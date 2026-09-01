# Seismic wave propagation through layered Earth model using Transfer Matrix Method (TMM)
# Este código simula la propagación de ondas sísmicas a través de un modelo de capas terrestres
# utilizando el método de matriz de transferencia (TMM), en la representación presión/velocidad
# (análoga a un circuito ABCD de línea de transmisión).
#
# Versión ajustada respecto al original:
#   1. La capa "Aire" ahora tiene densidad y velocidad realistas (antes tenía valores propios
#      de un sedimento liviano, no de aire real), lo que cambia drásticamente el contraste de
#      impedancia en la interfaz suelo-aire (de ~36:1 a ~39,000:1 — reflexión casi total).
#   2. Se añade la pérdida de transmisión en POTENCIA (además de la de amplitud de presión que
#      ya existía), que incluye la corrección por la razón de impedancias Z_izq/Z_der.
#   3. Se aumentó la resolución en frecuencia (NE) para resolver mejor las franjas de
#      interferencia de las capas más gruesas/rápidas.
#   4. El panel de transmisión ahora usa escala logarítmica en Y: con el contraste de
#      impedancia realista, |T| es del orden de 1e-4 a 1e-5, invisible en escala lineal.
#
# Verificación incluida: se imprime en consola el chequeo de conservación de energía
# |R|^2 + (Z_izq/Z_der)|T|^2 = 1, que debe dar 1.0 en todas las frecuencias si el modelo
# está bien planteado (análogo a la unitaridad en mecánica cuántica).
#
# Autor: [Tu Nombre]
# Fecha: [Fecha de creación]
# Requisitos: Python 3.x, NumPy, Matplotlib
# Nota: Modelo simplificado, sin atenuación, anisotropía ni acoplamiento P-S. Para aplicaciones
# avanzadas, usar software especializado en sismología.

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle

class SeismicTMM:
    def __init__(self, frequencies, layers):
        self.frequencies = frequencies
        self.layers = layers  # Lista de [densidad, velocidad, espesor, nombre]

    def calculate_impedance(self, rho, vp):
        return rho * vp

    def calculate_k(self, frequency, vp):
        return 2 * np.pi * frequency / vp

    def layer_matrix(self, frequency, rho, vp, d):
        Z = self.calculate_impedance(rho, vp)
        k = self.calculate_k(frequency, vp)
        M = np.array([
            [np.cos(k*d), 1j*Z*np.sin(k*d)],
            [1j*np.sin(k*d)/Z, np.cos(k*d)]
        ], dtype=complex)
        return M

    def calculate_coefficients(self, Z_left, Z_right, M_total):
        A, B, C, D = M_total[0,0], M_total[0,1], M_total[1,0], M_total[1,1]

        R = (A*Z_right + B - C*Z_left*Z_right - D*Z_left) / \
            (A*Z_right + B + C*Z_left*Z_right + D*Z_left)

        T = (2*Z_right) / (A*Z_right + B + C*Z_left*Z_right + D*Z_left)

        return R, T

    def solve(self):
        n_freq = len(self.frequencies)
        R = np.zeros(n_freq, dtype=complex)
        T = np.zeros(n_freq, dtype=complex)

        Z_left = self.calculate_impedance(self.layers[0][0], self.layers[0][1])
        Z_right = self.calculate_impedance(self.layers[-1][0], self.layers[-1][1])

        for i, freq in enumerate(self.frequencies):
            M_total = np.eye(2, dtype=complex)

            for j, layer in enumerate(self.layers):
                rho, vp, d, _ = layer
                if j == 0 or j == len(self.layers)-1:  # Medios semi-infinitos
                    continue
                M_layer = self.layer_matrix(freq, rho, vp, d)
                M_total = np.dot(M_total, M_layer)

            R[i], T[i] = self.calculate_coefficients(Z_left, Z_right, M_total)

        # Pérdida de transmisión en AMPLITUD de presión (definición original)
        transmission_loss_amplitude = -20 * np.log10(np.abs(T))

        # Pérdida de transmisión en POTENCIA: incluye la corrección por el
        # contraste de impedancias. Potencia_transmitida/Potencia_incidente =
        # (Z_izq/Z_der)*|T|^2 — sin esta corrección, la pérdida en dB queda
        # desplazada por -10*log10(Z_izq/Z_der) respecto al valor físico real.
        transmission_loss_power = -10 * np.log10((Z_left/Z_right) * np.abs(T)**2)

        # Chequeo de conservación de energía (sanity check, análogo a la
        # unitaridad cuántica): debe dar 1.0 en todas las frecuencias.
        power_conservation = np.abs(R)**2 + (Z_left/Z_right)*np.abs(T)**2
        print(f"Chequeo de conservación de energía |R|^2+(Zizq/Zder)|T|^2: "
              f"min={power_conservation.min():.8f}, max={power_conservation.max():.8f}")

        return R, T, transmission_loss_amplitude, transmission_loss_power, Z_left, Z_right

# Configuración del modelo sísmico
frequencies = np.linspace(0.1, 20, 3000)  # más puntos para resolver bien la interferencia

# Definir las capas terrestres: [densidad (kg/m³), velocidad onda P (m/s), espesor (m), nombre]
layers = [
    [2700, 6000, np.inf, "Manto Superior"],   # Medio semi-infinito de entrada
    [2600, 4000, 5000, "Corteza Inferior"],
    [2500, 3500, 3000, "Corteza Media"],
    [2200, 2000, 1000, "Capa Sedimentaria"],
    [1800, 1500, 500, "Suelo Superior"],
    [1.225, 340, np.inf, "Aire"]              # Medio semi-infinito de salida (aire real)
]

# Crear y resolver el modelo
seismic_model = SeismicTMM(frequencies, layers)
R, T, transmission_loss_amplitude, transmission_loss_power, Z_left, Z_right = seismic_model.solve()

# Crear visualización
fig = plt.figure(figsize=(16, 12))
plt.rcParams['font.size'] = 12

# 1. Visualización de las capas terrestres
ax1 = plt.subplot2grid((3, 2), (0, 0), rowspan=2)
depth = 0
max_depth = sum(layer[2] for layer in layers[1:-1] if np.isfinite(layer[2]))

for i, layer in enumerate(layers):
    if i == 0 or i == len(layers)-1:
        continue
    density, vp, thickness, name = layer
    color = plt.cm.plasma(i/len(layers))
    ax1.add_patch(Rectangle((0, depth), 1, thickness,
                           facecolor=color, edgecolor='black', alpha=0.7))
    ax1.text(1.05, depth + thickness/2, f"{name}\nρ={density} kg/m³, Vp={vp} m/s",
             va='center', ha='left')
    depth += thickness

ax1.set_xlim(0, 2)
ax1.set_ylim(max_depth, 0)
ax1.set_title('Modelo de Capas Terrestres')
ax1.set_ylabel('Profundidad (m)')
ax1.set_xticks([])

# 2. Coeficiente de transmisión (escala log: con aire realista |T| es muy pequeño)
ax2 = plt.subplot2grid((3, 2), (0, 1))
ax2.semilogy(frequencies, np.abs(T), 'b-', linewidth=2)
ax2.set_xlabel('Frecuencia (Hz)')
ax2.set_ylabel('Coeficiente de Transmisión |T| (log)')
ax2.set_title('Transmisión de Ondas Sísmicas')
ax2.grid(True, which='both', alpha=0.3)

# 3. Pérdida por transmisión: amplitud vs. potencia
ax3 = plt.subplot2grid((3, 2), (1, 1))
ax3.plot(frequencies, transmission_loss_amplitude, 'r-', linewidth=2, label='Amplitud (presión)')
ax3.plot(frequencies, transmission_loss_power, 'g--', linewidth=2, label='Potencia')
ax3.set_xlabel('Frecuencia (Hz)')
ax3.set_ylabel('Pérdida de Transmisión (dB)')
ax3.set_title('Pérdida de Transmisión vs. Frecuencia')
ax3.legend()
ax3.grid(True, alpha=0.3)

# 4. Impedancia de las capas
ax4 = plt.subplot2grid((3, 2), (2, 0), colspan=2)
impedances = [seismic_model.calculate_impedance(layer[0], layer[1]) for layer in layers]
layer_names = [layer[3] for layer in layers]
x_pos = np.arange(len(impedances))

bars = ax4.bar(x_pos, impedances, color=plt.cm.plasma(np.linspace(0, 1, len(impedances))))
ax4.set_yscale('log')  # el rango ahora abarca ~5 órdenes de magnitud (roca vs. aire)
ax4.set_xlabel('Capas')
ax4.set_ylabel('Impedancia Acústica (kg/m²s, log)')
ax4.set_title('Impedancia de las Capas Terrestres')
ax4.set_xticks(x_pos)
ax4.set_xticklabels(layer_names, rotation=45, ha='right')

for i, v in enumerate(impedances):
    ax4.text(i, v*1.15, f'{v:.2e}', ha='center', va='bottom', rotation=90)

plt.tight_layout()
plt.show()

# 5. Visualización adicional: Respuesta en frecuencia detallada
plt.figure(figsize=(12, 8))

plt.subplot(2, 1, 1)
plt.semilogx(frequencies, 20*np.log10(np.abs(T)), 'b-', linewidth=2, label='Transmisión')
plt.semilogx(frequencies, 20*np.log10(np.abs(R)), 'r-', linewidth=2, label='Reflexión')
plt.xlabel('Frecuencia (Hz)')
plt.ylabel('Amplitud (dB)')
plt.title('Respuesta en Frecuencia del Modelo Sísmico')
plt.legend()
plt.grid(True, which="both", alpha=0.3)

plt.subplot(2, 1, 2)
plt.semilogx(frequencies, np.angle(T, deg=True), 'b--', linewidth=2, label='Fase Transmisión')
plt.semilogx(frequencies, np.angle(R, deg=True), 'r--', linewidth=2, label='Fase Reflexión')
plt.xlabel('Frecuencia (Hz)')
plt.ylabel('Fase (grados)')
plt.legend()
plt.grid(True, which="both", alpha=0.3)

plt.tight_layout()
plt.show()
