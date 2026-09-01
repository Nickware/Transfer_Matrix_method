% Superlattice miniband structure using transfer matrix method (Octave/MATLAB)
% Versión corregida: evita la coincidencia Emax=V0 (que producía NaN), elimina
% el doble bucle innecesario sobre (q,E), y calcula la frontera de las bandas
% de forma exacta mediante la relación q(E) = acos(Tr[M(E)]/2)/K, en vez de
% barrer un umbral de tolerancia fijo sobre una malla 2D.
%
% Calcula y visualiza la estructura de minibandas de una superred 1D con el
% método de matriz de transferencia. La matriz de transferencia se construye
% por periodo (pozo + barrera) en la representación [psi; psi'], y las
% energías permitidas son aquellas donde |Tr[M(E)]| <= 2 (condición de Bloch).
%
% Autor: [Tu Nombre]
% Referencias:
% - Griffiths, D. J. (2018). Introduction to Quantum Mechanics (3rd ed.).
% - Kronig, R. de L. & Penney, W. G. (1931). Proc. R. Soc. Lond. A.
clear; clf;

% --- Parámetros físicos (unidades atómicas) ---
hbar = 1; m = 0.5;
a = 2;     % Ancho del pozo
b = 1;     % Ancho de la barrera
V0 = 5;    % Altura de la barrera
K = a + b; % Periodo de la superred

% --- Malla de energía ---
% Se evita a propósito Emax = V0: si coinciden exactamente, k2=0 en la
% barrera y el término (1/k2)*sin(k2*b) de Mb se vuelve 0/0 (NaN en Octave).
Emin = 0.01;
Emax = 4.99;   % antes era 5, igual a V0 -> producía una columna de NaN
NE = 2000;     % más puntos: ahora es barato, solo se recorre una vez
E = linspace(Emin, Emax, NE);

% --- Matriz de transferencia de un periodo (pozo + barrera) ---
% Nota: el orden Mw*Mb vs Mb*Mw no afecta la traza (Tr[AB]=Tr[BA] siempre),
% así que para la condición de Bloch es indistinto; solo importaría si más
% adelante se quisieran extraer las funciones de Bloch (autovectores) reales.
function M = period_matrix(E, a, b, V0, m, hbar)
    k1 = sqrt(2*m*E)/hbar;
    if E < V0
        k2 = 1i*sqrt(2*m*(V0-E))/hbar;
    else
        k2 = sqrt(2*m*(E-V0))/hbar;
    end
    Mw = [cos(k1*a), (1/k1)*sin(k1*a); -k1*sin(k1*a), cos(k1*a)];
    Mb = [cos(k2*b), (1/k2)*sin(k2*b); -k2*sin(k2*b), cos(k2*b)];
    M = Mw*Mb;
endfunction

% --- Traza de M(E), calculada UNA sola vez por energía (no por cada q) ---
% La traza no depende de q en absoluto, así que el barrido 2D original
% (NE*Nq evaluaciones) era 200x más trabajo del necesario.
trM = zeros(size(E));
for iE = 1:NE
    M = period_matrix(E(iE), a, b, V0, m, hbar);
    trM(iE) = real(trace(M));
endfor

% --- Condición de Bloch: bandas permitidas donde |Tr[M(E)]| <= 2 ---
permitido = abs(trM) <= 2;

% --- Relación de dispersión exacta: q(E) = acos(Tr[M(E)]/2) / K ---
% acos devuelve la rama principal en [0,pi], así que q queda en [0, pi/K].
% Por simetría del potencial, E(q) = E(-q), así que se grafica también
% la rama reflejada -q para cubrir toda la primera zona de Brillouin.
q_pos = NaN(size(E));
q_pos(permitido) = acos(trM(permitido)/2) / K;
q_neg = -q_pos;

% --- Gráfica: estructura de minibandas E(q) ---
% Se reemplaza el mapa de color por umbral con la curva exacta E(q); donde
% no hay solución real (bandas prohibidas), q_pos/q_neg quedan en NaN y
% Octave simplemente deja el hueco, sin necesidad de tolerancia alguna.
plot(q_pos, E, 'b.', 'MarkerSize', 4); hold on;
plot(q_neg, E, 'b.', 'MarkerSize', 4);
xlabel('Vector de Bloch q'); ylabel('Energía');
title('Minibandas de una superred 1D (método de matriz de transferencia)');
xlim([-pi/K, pi/K]);
ylim([Emin, Emax]);
grid on;

% --- Resumen en consola de los rangos de energía permitidos (minibandas) ---
printf('Minibandas encontradas (E permitido donde |Tr[M(E)]| <= 2):\n');
en_banda = false;
for iE = 1:NE
    if permitido(iE) && ~en_banda
        inicio = E(iE); en_banda = true;
    end
    if ~permitido(iE) && en_banda
        printf('  [%.4f, %.4f]  ancho = %.4f\n', inicio, E(iE-1), E(iE-1)-inicio);
        en_banda = false;
    end
endfor
if en_banda
    printf('  [%.4f, %.4f]  ancho = %.4f\n', inicio, E(NE), E(NE)-inicio);
end
