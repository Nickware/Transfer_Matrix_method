% Script de Octave: Modelo conceptual de propagacion de chisme por capas
% Analogia conceptual: cada transicion divide intensidad en transmision, filtrado,
% generacion de contra-relato o intensidad que no se propaga.
% No usa matrices fisicas ni datos sociologicos observados.

clear; clf; clc;

% -------------------------------
% Parametros del sistema social
% -------------------------------
% Niveles:
%   - 0: Emisor inicial (origen del chisme)
%   - 1: Primer circulo (amigos, familiares, compañeros cercanos)
%   - 2: Redes sociales / medio ambiente cercano
%   - 3: Opinion publica / comunidad amplia
%   - 4: Consecuencias (da publico, reputacion, afetacion)

% Cada etapa transforma parte de la intensidad entrante en transmision,
% filtrado, contra-relato o intensidad que permanece sin propagarse.
capas_names = {'Emisor','Amigos','Redes','Opinion publica','Consecuencias'};
etapas = {'Emisor a amigos','Amigos a redes','Redes a opinion publica', ...
          'Opinion publica a consecuencias'};
n_etapas = numel(etapas);

% Comparar una cascada de referencia con una intervencion hipotetica.
scenario_names = {'Base','Moderacion'};
T_case = [0.90 0.70 0.50 0.40; ...
          0.85 0.50 0.30 0.25];
A_case = [0.05 0.10 0.15 0.20; ...
          0.10 0.20 0.30 0.35];
R_case = [0.05 0.10 0.15 0.20; ...
          0.05 0.20 0.20 0.20];

% Intensidad inicial normalizada (0..1), no calibrada con datos reales.
intensity0 = 1.0;

if any(T_case(:) < 0) || any(A_case(:) < 0) || any(R_case(:) < 0) || ...
   any(T_case(:) > 1) || any(A_case(:) > 1) || any(R_case(:) > 1)
    error('Los coeficientes de cada flujo deben estar entre 0 y 1.');
endif
if any(sum(T_case + A_case + R_case, 2) > 1 + 1e-12)
    error('En cada etapa, transmision + filtrado + contra-relato no puede superar 1.');
endif

% -------------------------------
% Simulacion paso a paso
% -------------------------------
% La intensidad que llega a cada nodo es la transmision de la etapa anterior.
% El contra-relato se contabiliza como resultado, pero no se propaga como una
% segunda señal ni vuelve a entrar en etapas anteriores.
n_scenarios = numel(scenario_names);
Intensity = zeros(n_scenarios, n_etapas + 1);
Intensity(:,1) = intensity0;
transmitted = zeros(n_scenarios, n_etapas);
absorbed = zeros(n_scenarios, n_etapas);
counter_narrative = zeros(n_scenarios, n_etapas);
stalled = zeros(n_scenarios, n_etapas);

for s = 1:n_scenarios
    for k = 1:n_etapas
        I_in = Intensity(s,k);
        transmitted(s,k) = I_in * T_case(s,k);
        absorbed(s,k) = I_in * A_case(s,k);
        counter_narrative(s,k) = I_in * R_case(s,k);
        stalled(s,k) = I_in - transmitted(s,k) - absorbed(s,k) - counter_narrative(s,k);
        Intensity(s,k+1) = transmitted(s,k);
    endfor
endfor

% -------------------------------
% Graficos
% -------------------------------
node_x = 0:n_etapas;
figure('Position',[100 100 1000 650]);
subplot(2,1,1);
hold on;
for s = 1:n_scenarios
    plot(node_x, Intensity(s,:), '-o', 'LineWidth', 1.8, 'MarkerSize', 6);
endfor
set(gca,'XTick',node_x,'XTickLabel',capas_names);
xlim([0 n_etapas]);
ylim([0 max([Intensity(:); 1])]);
ylabel('Intensidad normalizada');
title('Intensidad que alcanza cada nodo');
legend(scenario_names,'Location','northeast');
grid on;

subplot(2,1,2);
outcomes = [transmitted(1,:)' absorbed(1,:)' counter_narrative(1,:)' stalled(1,:)'];
bar(1:n_etapas, outcomes, 'stacked');
set(gca,'XTick',1:n_etapas,'XTickLabel',etapas);
ylabel('Intensidad por flujo');
title('Balance de intensidad por etapa (escenario base)');
legend('Transmitida','Filtrada','Contra-relato','Sin propagacion', ...
       'Location','northeastoutside');
grid on;

% -------------------------------
% Resultados numericos
% -------------------------------
fprintf('Intensidad inicial normalizada: %.3f\n\n', intensity0);
for s = 1:n_scenarios
    fprintf('%s - intensidad en consecuencias: %.4f\n', ...
            scenario_names{s}, Intensity(s,end));
endfor
fprintf('\n');
for k = 1:n_etapas
    fprintf('%s: base=%.4f, moderacion=%.4f\n', etapas{k}, ...
            transmitted(1,k), transmitted(2,k));
endfor

% -------------------------------
% Guardado de resultados
% -------------------------------
if exist('output','dir') ~= 7
    mkdir('output');
endif
fid = fopen('output/chisme_capas_resultados.csv','w');
if fid < 0
    error('No se pudo crear output/chisme_capas_resultados.csv.');
endif
fprintf(fid,'Escenario,Etapa,Intensidad_entrada,Transmitida,Filtrada,Contra_relato,Sin_propagacion\n');
for s = 1:n_scenarios
    for k = 1:n_etapas
        fprintf(fid,'%s,%s,%.6f,%.6f,%.6f,%.6f,%.6f\n', ...
                scenario_names{s}, etapas{k}, Intensity(s,k), ...
                transmitted(s,k), absorbed(s,k), counter_narrative(s,k), stalled(s,k));
    endfor
endfor
fclose(fid);
fprintf('Resultados guardados en output/chisme_capas_resultados.csv\n');
