% Fachada multicapa con TMM acústico a incidencia normal
% Modelo simplificado: aire exterior -> muro (masa superficial) -> camara de aire
% -> lana mineral (fluido equivalente simple) -> placa interior (masa superficial) -> aire interior
% Calcula STL y nivel interior estimado frente a un espectro simplificado de ruido de aeronaves

% Autor: [Tu Nombre]
% Ultima actualizacion: [Fecha]

% Nota: Este es un modelo simplificado para ilustrar el uso de TMM en una fachada de aeropuerto.
% Se pueden agregar mas capas, detalles de geometria, perdidas adicionales, etc. para mayor realismo.
% Requiere Octave o Matlab con funciones basicas de matriz y graficacion.
% Salida: Graficas de STL y niveles, tabla de resultados en CSV, imagen esquematica de capas.
% Para uso en el contexto de un caso de estudio de aeropuerto, se pueden ajustar los parametros y el espectro exterior segun datos reales o mediciones locales para obtener resultados mas precisos.
% Se pueden comparar diferentes configuraciones de fachada, materiales, espesores, etc. para optimizar el diseño frente al ruido de aeronaves.
% Este codigo es un punto de partida para explorar el impacto de diferentes capas y materiales en la reduccion del ruido en interiores frente a fuentes exteriores como las aeronaves.
% Se recomienda validar los resultados con mediciones reales o software especializado para casos mas complejos o criticos.
% Se pueden agregar efectos de difraccion, incidencia oblicua, acoplamiento estructural, etc. para mayor realismo si se desea.
% Este modelo asume incidencia normal y no considera efectos de borde, difraccion, ni acoplamiento estructural entre capas, lo cual puede ser una simplificacion importante dependiendo del caso de estudio.
% Se pueden agregar perdidas adicionales por friccion, absorcion en las capas, etc. para mayor realismo si se dispone de datos o modelos adecuados.
% Se pueden comparar los resultados con criterios de aceptabilidad de ruido en interiores segun normativas locales o internacionales para evaluar el desempeño de la fachada frente al ruido de aeronaves.
% Se pueden realizar analisis de sensibilidad variando los parametros de las capas, el espectro exterior, etc. para entender mejor el impacto de cada factor en la reduccion del ruido en interiores.
% Se recomienda documentar claramente los parametros utilizados, las suposiciones del modelo, y las limitaciones para interpretar correctamente los resultados obtenidos con este enfoque simplificado.

% Se pueden agregar comentarios adicionales en el codigo para explicar cada paso y facilitar su entendimiento y modificacion por parte de otros usuarios o para futuras referencias.
% Se pueden agregar funciones adicionales para calcular indices globales de ruido, como el nivel de ruido equivalente continuo (Leq), el nivel de ruido ponderado A (dBA), etc. si se dispone de datos adecuados para el espectro exterior y se desea obtener resultados mas representativos del impacto del ruido en interiores.
% Se pueden agregar efectos de acoplamiento entre capas, como la interaccion entre la masa superficial y la camara de aire, para obtener resultados mas realistas si se dispone de modelos adecuados para describir estos efectos.
% Se pueden agregar efectos de difraccion en los bordes de la fachada, especialmente a bajas frecuencias, para obtener resultados mas realistas si se dispone de modelos adecuados para describir estos efectos.  
% Se pueden agregar efectos de incidencia oblicua para obtener resultados mas realistas si se dispone de modelos adecuados para describir estos efectos, especialmente si la fuente de ruido no esta directamente frente a la fachada.  
% Se pueden agregar efectos de acoplamiento estructural entre las capas, como la interaccion entre la masa superficial y la camara de aire, para obtener resultados mas realistas si se dispone de modelos adecuados para describir estos efectos.
% Se pueden agregar efectos de absorcion en las capas, como la absorcion en la lana mineral, para obtener resultados mas realistas si se dispone de datos adecuados para describir estos efectos.
% Se pueden agregar efectos de friccion en las capas, como la friccion en la camara de aire, para obtener resultados mas realistas si se dispone de datos adecuados para describir estos efecto
% Se pueden agregar efectos de acoplamiento entre capas, como la interaccion entre la masa superficial y la camara de aire, para obtener resultados mas realistas si se dispone de modelos adecuados para describir estos efectos.

clear; close all; clc;

% -------------------------------
% Parametros del aire
% -------------------------------
rho0 = 1.21;            % kg/m^3
c0   = 343;             % m/s
Z0   = rho0 * c0;       % impedancia caracteristica del aire

% -------------------------------
% Frecuencias (1/3 de octava aprox.)
% -------------------------------
f = [50 63 80 100 125 160 200 250 315 400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000];
omega = 2*pi*f;
k0 = omega / c0;

% -------------------------------
% Espectro exterior simplificado de ruido de aeronave (dB)
% Caso ilustrativo, no medicion local
% -------------------------------
Lext = [72 74 76 78 80 82 84 86 88 89 90 91 92 93 92 90 88 86 84 82 80];

% -------------------------------
% Parametros de la fachada
% -------------------------------
% Muro rigido modelado como masa superficial (ladrillo/mamposteria pesada)
m1 = 220;               % kg/m^2
eta1 = 0.05;            % perdida estructural

% Camara de aire
d_air = 0.08;           % m

% Lana mineral como fluido equivalente simple con perdidas efectivas
d_p = 0.05;             % m
rho_eq = 25;            % kg/m^3 (valor efectivo simplificado)
c_eq = 120;             % m/s   (valor efectivo simplificado)
alpha_p = 0.12;         % perdida efectiva Np/m aprox creciente se puede refinar

% Placa interior (yeso)
m2 = 12;                % kg/m^2
eta2 = 0.08;            % perdida estructural

% -------------------------------
% Funciones auxiliares locales
% -------------------------------
function M = fluid_layer(k, Z, d)
  M = [cos(k*d), 1i*Z*sin(k*d); 1i*(1/Z)*sin(k*d), cos(k*d)];
endfunction

function M = mass_layer(omega, m, eta)
  Zs = 1i*omega*m*(1 - 1i*eta);
  M = [1, Zs; 0, 1];
endfunction

function tau = transmission_from_M(M, ZL, ZR)
  den = M(1,1) + M(1,2)/ZR + ZL*M(2,1) + (ZL/ZR)*M(2,2);
  tau = abs(2/den)^2 * real(ZL/ZR);
endfunction

% -------------------------------
% Calculo TMM
% -------------------------------
TL = zeros(size(f));
Lin = zeros(size(f));
tau = zeros(size(f));

for n = 1:length(f)
  w = omega(n);

  % Camara de aire
  M_airgap = fluid_layer(k0(n), Z0, d_air);

  % Poroso como fluido equivalente con numero de onda complejo
  k_p = w/c_eq - 1i*alpha_p;
  Z_p = rho_eq * c_eq * (1 + 0.15i);
  M_porous = fluid_layer(k_p, Z_p, d_p);

  % Hojas / paneles como masas superficiales
  M_wall  = mass_layer(w, m1, eta1);
  M_board = mass_layer(w, m2, eta2);

  % Matriz total de izquierda a derecha
  Mtot = M_wall * M_airgap * M_porous * M_board;

  tau(n) = transmission_from_M(Mtot, Z0, Z0);
  TL(n) = -10*log10(max(tau(n), 1e-12));
  Lin(n) = Lext(n) - TL(n);
endfor

% -------------------------------
% Indices globales simples en dB(A)-like ilustrativos
% -------------------------------
Lext_lin = sum(10.^(Lext/10));
Lin_lin  = sum(10.^(Lin/10));
Lext_tot = 10*log10(Lext_lin);
Lin_tot  = 10*log10(Lin_lin);
Red_global = Lext_tot - Lin_tot;

% -------------------------------
% Graficas
% -------------------------------
figure('Position',[80 80 1000 700]);
subplot(2,1,1)
semilogx(f, TL, 'b-o', 'LineWidth', 1.8, 'MarkerSize', 5); grid on;
xlabel('Frecuencia (Hz)'); ylabel('STL / TL (dB)');
title('Perdida por transmision de la fachada multicapa (TMM)');
xticks_plot = [50 100 200 500 1000 2000 5000];
set(gca,'XTick',xticks_plot);
set(gca,'XTickLabel',{'50','100','200','500','1000','2000','5000'});
xlim([min(f) max(f)]);

subplot(2,1,2)
semilogx(f, Lext, 'k-s', 'LineWidth', 1.5, 'MarkerSize', 4); hold on;
semilogx(f, Lin, 'r-o', 'LineWidth', 1.8, 'MarkerSize', 5); grid on;
xlabel('Frecuencia (Hz)'); ylabel('Nivel por banda (dB)');
legend('Espectro exterior aeronave','Nivel interior estimado','Location','southwest');
title(sprintf('Exterior vs interior estimado | Reduccion global = %.1f dB', Red_global));
xticks_plot = [50 100 200 500 1000 2000 5000];
set(gca,'XTick',xticks_plot);
set(gca,'XTickLabel',{'50','100','200','500','1000','2000','5000'});
xlim([min(f) max(f)]);

print('output/fachada_tmm_resultado.png','-dpng','-r180');

% -------------------------------
% Perfil esquematico de capas
% -------------------------------
figure('Position',[120 120 1000 280]);
layer_names = {'Muro pesado','Camara aire','Lana mineral','Placa interior'};
layer_thick = [0.12 d_air d_p 0.013];
layer_x = [0 cumsum(layer_thick)];
colors = [0.55 0.45 0.35; 0.80 0.90 1.00; 0.95 0.85 0.35; 0.82 0.82 0.85];
for i=1:length(layer_thick)
  patch([layer_x(i) layer_x(i+1) layer_x(i+1) layer_x(i)], [0 0 1 1], colors(i,:), 'EdgeColor','k');
  text((layer_x(i)+layer_x(i+1))/2, 0.5, layer_names{i}, 'HorizontalAlignment','center');
  hold on;
endfor
xlim([0 layer_x(end)]); ylim([0 1]);
set(gca,'YTick',[]);
xlabel('Espesor acumulado (m)');
title('Esquema simplificado de la fachada multicapa');
grid on;
print('output/fachada_tmm_capas.png','-dpng','-r180');

% -------------------------------
% Tabla de resultados
% -------------------------------
T = [f(:), Lext(:), TL(:), Lin(:), tau(:)];
header = 'Frecuencia_Hz,Lext_dB,TL_dB,NivelInterior_dB,tau';
fid = fopen('output/fachada_tmm_resultados.csv','w');
fprintf(fid, '%s\n', header);
fclose(fid);
dlmwrite('output/fachada_tmm_resultados.csv', T, '-append');

fprintf('Nivel exterior total aprox: %.2f dB\n', Lext_tot);
fprintf('Nivel interior total aprox: %.2f dB\n', Lin_tot);
fprintf('Reduccion global aprox: %.2f dB\n', Red_global);
