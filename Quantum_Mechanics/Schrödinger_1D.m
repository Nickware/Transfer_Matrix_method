% Barrera cuántica utilizando el método de matriz de transferencia (Octave)
% Versión corregida: construcción correcta de la matriz de transferencia total
% y despeje algebraico apropiado de las condiciones de frontera mixtas
% (incidencia conocida por la izquierda, ausencia de onda entrante por la derecha).
%
% Resuelve la ecuación de Schrödinger independiente del tiempo para una barrera
% cuántica 1D y grafica la función de onda junto con el perfil de potencial.
%
% Parámetros:
% E:  Energía de la partícula
% V0: Altura de la barrera
% a:  Ancho de la barrera
%
% El script calcula la función de onda en las tres regiones (izquierda, dentro
% de la barrera y derecha), verifica la conservación de probabilidad
% (|R|^2 + (k3/k1)|T|^2 = 1) como chequeo de sanidad, y grafica el resultado.
%
% Autor: [Tu Nombre]
% Referencias:
% - Griffiths, D. J. (2018). Introduction to Quantum Mechanics (3rd ed.).
% - Shankar, R. (2011). Principles of Quantum Mechanics (2nd ed.).
% --- Fin de comentarios ---
clear; clf;

% --- Constantes físicas (unidades atómicas: hbar = 1, m = 1/2) ---
hbar = 1;
m = 0.5;

% --- Parámetros del sistema ---
E = 1;           % Energía de la partícula
V0 = 2;          % Altura de la barrera
a = 1;           % Ancho de la barrera

% --- Regiones ---
x1 = linspace(-2, 0, 200);           % Izquierda de la barrera
x2 = linspace(0, a, 200);            % Interior de la barrera
x3 = linspace(a, 4, 300);            % Derecha de la barrera

% --- Números de onda ---
k1 = sqrt(2*m*(E-0)+0i)/hbar;        % Izquierda (V=0)
k2 = sqrt(2*m*(E-V0)+0i)/hbar;       % Interior de la barrera (imaginario si E<V0)
k3 = sqrt(2*m*(E-0)+0i)/hbar;        % Derecha (V=0)

% --- Matrices de "matching" en cada interfaz ---
% Se obtienen imponiendo continuidad de psi y psi' en cada frontera.
% Relacionan las amplitudes (onda hacia adelante; onda hacia atrás) de un
% lado con las del otro, ambas referidas al MISMO punto de la interfaz.
M12 = [0.5*(1+k2/k1), 0.5*(1-k2/k1); 0.5*(1-k2/k1), 0.5*(1+k2/k1)]; % en x = 0
M23 = [0.5*(1+k3/k2), 0.5*(1-k3/k2); 0.5*(1-k3/k2), 0.5*(1+k3/k2)]; % en x = a

% --- Matrices de propagación (fase acumulada dentro de cada región) ---
% P2 traslada las amplitudes de la región 2 desde x=0 hasta x=a.
% P3 hace lo mismo para la región 3 (necesaria porque psi3 se escribe en
% coordenadas globales, no locales a partir de x=a).
P2 = [exp(1i*k2*a), 0; 0, exp(-1i*k2*a)];
P3 = [exp(1i*k3*a), 0; 0, exp(-1i*k3*a)];

% --- Matriz de transferencia TOTAL: [A1;B1] = Mtot * [A3;B3] ---
% Orden correcto: se recorre la cadena de matching/propagación desde la
% región 1 hacia la región 3, invirtiendo P2 (no aplicándola directo) y
% añadiendo P3, que el planteamiento ingenuo M23*P2*M12 pasa por alto.
Mtot = M12 * inv(P2) * M23 * P3;

% --- Condiciones de frontera físicas ---
% Conocido: A1 = 1 (incidencia unitaria desde la izquierda)
%           B3 = 0 (no hay onda entrante desde +infinito)
% Incógnitas: B1 (reflexión), A3 (transmisión)
%
% OJO: A1 y B3 son conocidos pero viven en lados OPUESTOS de Mtot, así que
% no se puede resolver como un sistema Mtot\[1;0] (eso asumiría B1=0, que
% es física y numéricamente incorrecto). Se despeja algebraicamente:
%   A1 = Mtot(1,1)*A3 + Mtot(1,2)*B3  ->  A3 = (A1 - Mtot(1,2)*B3) / Mtot(1,1)
%   B1 = Mtot(2,1)*A3 + Mtot(2,2)*B3
A1 = 1;
B3 = 0;
A3 = (A1 - Mtot(1,2)*B3) / Mtot(1,1);
B1 = Mtot(2,1)*A3 + Mtot(2,2)*B3;

% --- Amplitudes dentro de la barrera (región 2) ---
% Se obtienen invirtiendo el matching de la primera interfaz:
% [A2;B2] = M12^{-1} * [A1;B1]
coef2 = M12 \ [A1; B1];
A2 = coef2(1);
B2 = coef2(2);

% --- Chequeo de sanidad: conservación de probabilidad ---
% Con k1 y k3 reales (regiones clásicamente permitidas, V=0), debe cumplirse
% |R|^2 + (k3/k1)|T|^2 = 1. Cualquier desviación indica un error algebraico.
R = B1 / A1;
T = A3 / A1;
unitariedad = abs(R)^2 + (real(k3)/real(k1)) * abs(T)^2;
printf('Coeficiente de reflexión |R|^2 = %.6f\n', abs(R)^2);
printf('Coeficiente de transmisión |T|^2 = %.6f\n', (real(k3)/real(k1))*abs(T)^2);
printf('Chequeo de unitaridad |R|^2 + |T|^2 = %.6f (debe ser 1.000000)\n', unitariedad);
if abs(unitariedad - 1) > 1e-8
    warning('¡La unitaridad no se cumple! Revisa la construcción de Mtot.');
end

% --- Reconstruir la función de onda en cada región ---
psi1 = A1*exp(1i*k1*x1) + B1*exp(-1i*k1*x1);
psi2 = A2*exp(1i*k2*x2) + B2*exp(-1i*k2*x2);
psi3 = A3*exp(1i*k3*x3) + B3*exp(-1i*k3*x3);

% --- Perfil de potencial ---
V1 = zeros(size(x1));
V2 = V0*ones(size(x2));
V3 = zeros(size(x3));
xx = [x1 x2 x3];
VV = [V1 V2 V3];

% --- Gráfica ---
plot(xx, real([psi1 psi2 psi3]), 'b-', 'LineWidth', 1.2); hold on;
plot(xx, VV, 'k--', 'LineWidth', 2);
xlabel('x'); ylabel('\psi(x) and V(x)');
legend('Re[\psi(x)]','V(x)');
title(sprintf('Barrera cuántica (E=%.2f, V0=%.2f, a=%.2f) — |T|^2=%.4f', E, V0, a, (real(k3)/real(k1))*abs(T)^2));
grid on;
