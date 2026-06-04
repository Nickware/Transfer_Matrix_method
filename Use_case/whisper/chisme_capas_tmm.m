% Script de Octave: Modelo conceptual de propagacion de chisme por capas
% Analogia del TMM: cada capa social puede transmitir, reflejar (devolver/desmentir) o absorber (atenuar) el chisme.
% No es TMM fisico real, sino una extension conceptual con matrices de "transmision social".

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

% Numero de capas sociales (excluyendo origen y consecuencias finales)
N_capas = 3;

% Probabilidad de transmision de una capa a la siguiente (0..1)
% Valores altos = facilita el chisme, bajos = lo dificulta
T = [0.9, 0.7, 0.5];  % Ejemplo: amigos transmiten mucho, redes medianamente, comunidad menos

% Probabilidad de absorcion (filtro, duda, correccion) en cada capa (0..1)
% Valores altos = buena capacidad de filtrar/el chisme se atenua
A = [0.3, 0.5, 0.7];  % Ejemplo: comunidad tiene mayor capacidad de cuestionar

% Probabilidad de "reflexion" (contra-relato, desmentido, defensa)
% Esto devuelve parte del chisme al nivel anterior o al origen
R = [0.1, 0.2, 0.3];  % Ejemplo: a mayor capa, mayor chance de desmentido

% Intensidad inicial del chisme (0..1)
% 1 = calumnia muy fuerte, 0 = inexistente
intensity0 = 1.0;

% -------------------------------
% Simulacion paso a paso
% -------------------------------
% Intensity(i) = intensidad del chisme EN la capa i
% transmitted(i) = intensidad que logra pasar de capa i a i+1
% absorbed(i) = intensidad que se filtra en capa i
% reflected(i) = intensidad que se "devuelve" (desmentido, contra-relato)

Intensity = zeros(1, N_capas+2);
Intensity(1) = intensity0;  % capa 1 = emisor

transmitted = zeros(1, N_capas);
absorbed    = zeros(1, N_capas);
reflected   = zeros(1, N_capas);

for k = 1:N_capas
    I_in = Intensity(k);
    
    % Partes que salen de esta capa
    trans  = I_in * T(k);       % transmite a la siguiente
    abss   = I_in * A(k);       % absorbe (se filtra)
    refl   = I_in * R(k);       % refleja (desmentido, contra-relato)
    rest   = I_in - trans - abss - refl;  % lo que queda "estancado" (no se decide)
    
    transmitted(k) = trans;
    absorbed(k)    = abss;
    reflected(k)   = refl;
    
    % Intensity que llega a la siguiente capa
    Intensity(k+1) = trans;
endfor

% Intensity final en la capa de consecuencias (da publico)
I_final = Intensity(N_capas+2);

% -------------------------------
% Graficos
% -------------------------------
% 1) Intensity del chisme por capa
figure('Position',[100 100 900 500]);

subplot(1,2,1);
capas_names = {'Emisor','Amigos','Redes','Opinion publica','Consecuencias'};
capas_x = 1:length(capas_names);
bar(capas_x, Intensity, 'FaceColor',[0.2 0.6 0.8], 'EdgeColor','k');
set(gca,'XTick',capas_x,'XTickLabel',capas_names,'XTickLabelRotation',15);
ylim([0 max([Intensity, 1])]);
ylabel('Intensidad del chisme');
title('Intensidad del chisme por capas');
grid on;

% 2) Transmision, absorcion y reflexion por capa
subplot(1,2,2);
capas_marcas = {'Amigos','Redes','Opinion publica'};
capas_x2 = 1:N_capas;
width = 0.25;
bar(capas_x2-width, transmitted, width, 'FaceColor',[0.2 0.7 0.2], 'EdgeColor','k'); hold on;
bar(capas_x2, absorbed, width, 'FaceColor',[0.8 0.2 0.2], 'EdgeColor','k');
bar(capas_x2+width, reflected, width, 'FaceColor',[0.8 0.6 0.1], 'EdgeColor','k');
set(gca,'XTick',capas_x2,'XTickLabel',capas_marcas);
legend('Transmision','Absorcion','Reflexion','Location','best');
ylabel('Intensidad');
title('Transmision, absorcion y reflexion por capa');
grid on;

% 3) Esquema de capas con flechas
figure('Position',[120 120 1100 400]);
hold on; xlim([0 10]); ylim([0 1]);
y_center = 0.5;
dy = 0.12;

% Posiciones de las capas
x_pos = linspace(0.5, 9.5, N_capas+2);
for i=1:length(x_pos)
    y = y_center;
    rect_w = 1.2;
    % caja
    patch([x_pos(i)-rect_w/2 x_pos(i)+rect_w/2 x_pos(i)+rect_w/2 x_pos(i)-rect_w/2,...
           y-dy y-dy y+dy y+dy], [0.9 0.9 0.9], 'EdgeColor','k');
    text(x_pos(i), y, capas_names{i}, 'HorizontalAlignment','center','FontWeight','bold');
endfor

% flechas de transmision
for i=1:N_capas+1
    x1 = x_pos(i)+0.6;
    x2 = x_pos(i+1)-0.6;
    y = y_center;
    if x2 > x1
        % flecha
        quiver(x1, y, x2-x1, 0, 0, 0, 'MaxHeadSize',0.5, 'Color','b','LineWidth',2);
        % etiqueta con valor de transmision
        if i <= N_capas
            txt = sprintf('%.2f', transmitted(i));
        else
            txt = sprintf('%.2f', Intensity(N_capas+2));
        end
        text((x1+x2)/2, y+0.05, txt, 'HorizontalAlignment','center','FontSize',8);
    end
endfor

% flechas de absorcion (hacia abajo)
for i=1:N_capas
    x = x_pos(i+1);
    y1 = y_center+dy;
    y2 = y_center-0.15;
    quiver(x, y1, 0, y2-y1, 0, 0, 'MaxHeadSize',0.5, 'Color','r','LineWidth',1.5);
    txt = sprintf('%.2f', absorbed(i));
    text(x, y2-0.02, txt, 'HorizontalAlignment','center','FontSize',8,'Color','r');
endfor

% flechas de reflexion (hacia arriba y hacia atras)
for i=1:N_capas
    x = x_pos(i+1);
    y1 = y_center+dy;
    y2 = y_center+0.25;
    quiver(x, y1, 0, y2-y1, 0, 0, 'MaxHeadSize',0.5, 'Color','g','LineWidth',1.5);
    txt = sprintf('%.2f', reflected(i));
    text(x, y2+0.02, txt, 'HorizontalAlignment','center','FontSize',8,'Color','g');
endfor

xlim([0 10]); ylim([-0.3 0.8]);
set(gca,'Visible','off');
title('Esquema conceptual de propagacion de chisme por capas (analoga al TMM)');

% -------------------------------
% Resultados numericos
% -------------------------------
fprintf('Intensidad inicial del chisme: %.3f\n', intensity0);
fprintf('\n');
for k=1:N_capas
    fprintf('Capa %d (%s):\n', k, capas_marcas{k});
    fprintf('  Transmision a siguiente: %.3f\n', transmitted(k));
    fprintf('  Absorcion (filtrado):    %.3f\n', absorbed(k));
    fprintf('  Reflexion (desmentido):  %.3f\n', reflected(k));
    fprintf('  Intensity en siguiente:  %.3f\n', Intensity(k+1));
    fprintf('\n');
endfor
fprintf('Intensidad final (consecuencias publicas): %.3f\n', I_final);
fprintf('\n');

% -------------------------------
% Guardado de resultados
% -------------------------------
% Guardar tabla CSV
fid = fopen('output/chisme_capas_resultados.csv','w');
fprintf(fid,'Capa,Intensidad,Transmision,Absorcion,Reflexion\n');
for i=1:N_capas
    fprintf(fid,'%d,%.4f,%.4f,%.4f,%.4f\n', i, Intensity(i), transmitted(i), absorbed(i), reflected(i));
endfor
% ultima capa (consecuencias)
fprintf(fid,'%d,%.4f,0,0,0\n', N_capas+2, Intensity(N_capas+2));
fclose(fid);

fprintf('Resultados guardados en output/chisme_capas_resultados.csv\n');
