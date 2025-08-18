% Barrera cuántica utilizando el método de matriz de transferencia implementado en Octave
% Script que resuelve la ecuación de Schrödinger independiente del tiempo para una barrera cuántica 1D 
% utilizando el método de matriz de transferencia y mostrar la función de onda y el potencial gráficamente.

clear; clf;

% --- constantes físicas(unidades atómicas: hbar = 1, m = 1/2) ---
hbar = 1;
m = 0.5;

% --- Parámetros del sistema ---
E = 1;           % Energía de partículas
V0 = 2;          % Altura de barrera
a = 1;           % Ancho de barrera

% --- Regiones ---
x1 = linspace(-2, 0, 200);           % Izquierda de la barrera
x2 = linspace(0, a, 200);            % Barrera interior
x3 = linspace(a, 4, 300);            % Derecho de barrera

% --- Números de onda ---
k1 = sqrt(2*m*(E-0))/hbar;           % Izquierda (V=0)
k2 = sqrt(2*m*(E-V0))/hbar;          % Barrera interior (puede ser imaginario)
k3 = sqrt(2*m*(E-0))/hbar;           % Bien (V=0)

% --- Matrices de transferencia ---
M12 = [0.5*(1+k2/k1), 0.5*(1-k2/k1); 0.5*(1-k2/k1), 0.5*(1+k2/k1)]; % Interfaz en x = 0
M23 = [0.5*(1+k3/k2), 0.5*(1-k3/k2); 0.5*(1-k3/k2), 0.5*(1+k3/k2)]; % Interfaz en x = a

P2 = [exp(1i*k2*a), 0; 0, exp(-1i*k2*a)];           % Propagación dentro de la Región 2

Mtot = M23 * P2 * M12;                             % Matriz de transferencia total

% --- Entrada: Incidente desde la izquierda, amplitud = 1 ---
A = [1; 0];         % Solo onda incidente de la izquierda
B = Mtot \ [1; 0];  % Resolver amplitudes salientes

% Reconstruir la función de onda en cada región
psi1 = exp(1i*k1*x1) + B(2)*exp(-1i*k1*x1);
psi2 = (M12(1,1)*A(1)+M12(1,2)*A(2))*exp(1i*k2*x2) + ...
       (M12(2,1)*A(1)+M12(2,2)*A(2))*exp(-1i*k2*x2);
psi3 = B(1)*exp(1i*k3*x3);

% --- Perfil potencial ---
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
title('Barrera cuántica: método de matriz de transferencia');
grid on;