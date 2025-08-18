% Superlattice miniband structure using transfer matrix method
% This script calculates and visualizes the miniband structure of a 1D
% superlattice using the transfer matrix method. It computes the allowed
% minibands based on the periodic potential of a superlattice consisting of
% alternating quantum wells and barriers.
% The transfer matrix is computed for each period, and the allowed energy
% regions are determined by checking the trace condition for Bloch states.  
% The results are visualized as a color map of allowed miniband regions.
% The x-axis represents energy, and the y-axis represents the Bloch vector q.
% The color indicates whether the energy is allowed (blue) or forbidden (white).
% This script is designed to run in GNU Octave or MATLAB.

% Parameters
clear; clf;
hbar = 1; m = 0.5; % Atomic units
a = 2;     % Well width
b = 1;     % Barrier width
V0 = 5;    % Barrier height
N = 8;     % Number of periods for visualization
Emin = 0.01; Emax = 5; NE = 500; % Energy search range

% Energy grid for miniband structure
E = linspace(Emin, Emax, NE);
K = a + b;

% Bloch vector grid for Brillouin zone
q = linspace(-pi/K, pi/K, 200); 

% Preallocate miniband matrix
bands = zeros(length(q), NE);

% Transfer matrix function for one period (well+barrier)
function M = period_matrix(E, a, b, V0, m, hbar)
    k1 = sqrt(2*m*E)/hbar;
    k2 = sqrt(2*m*max(E-V0,0))/hbar;
    if(E<V0) k2 = 1i*sqrt(2*m*(V0-E))/hbar; end
    % Well (width a)
    Mw = [cos(k1*a), (1/k1)*sin(k1*a); -k1*sin(k1*a), cos(k1*a)];
    % Barrier (width b)
    Mb = [cos(k2*b), (1/k2)*sin(k2*b); -k2*sin(k2*b), cos(k2*b)];
    M = Mw*Mb;
endfunction

% Calculate minibands: For each q, find E where Tr[M(E)] = 2cos(qK)
for iq = 1:length(q)
    for iE = 1:NE
        EE = E(iE);
        M = period_matrix(EE, a, b, V0, m, hbar);
        bands(iq,iE) = real(trace(M)) - 2*cos(q(iq)*K); % Bloch condition
    end
end

% Plot allowed miniband regions (where |Tr[M]|<2)
imagesc(E, q, abs(bands)<1e-2);
set(gca, "YDir", "normal");
xlabel('Energy'); ylabel('Bloch vector q');
title('Minibands of 1D Superlattice (Transfer Matrix)');
colorbar; colormap([1 1 1; 0 0 1]); % white: forbidden, blue: allowed