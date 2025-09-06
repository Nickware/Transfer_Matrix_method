import numpy as np
import matplotlib.pyplot as plt

class AcousticTMM:
    def __init__(self, frequencies, layers):
        self.frequencies = frequencies
        self.layers = layers  # Lista de [densidad, velocidad, espesor]
        
    def calculate_impedance(self, rho, c):
        return rho * c
    
    def calculate_k(self, frequency, c):
        return 2 * np.pi * frequency / c
    
    def layer_matrix(self, frequency, rho, c, d):
        Z = self.calculate_impedance(rho, c)
        k = self.calculate_k(frequency, c)
        
        M = np.array([
            [np.cos(k*d), 1j*Z*np.sin(k*d)],
            [1j*np.sin(k*d)/Z, np.cos(k*d)]
        ], dtype=complex)
        
        return M
    
    def calculate_coefficients(self, Z_left, Z_right, M_total):
        # Matriz total relaciona medios izquierdo y derecho
        A, B, C, D = M_total[0,0], M_total[0,1], M_total[1,0], M_total[1,1]
        
        # Coeficientes de reflexión y transmisión
        R = (A*Z_right + B - C*Z_left*Z_right - D*Z_left) / \
            (A*Z_right + B + C*Z_left*Z_right + D*Z_left)
        
        T = (2*Z_right) / (A*Z_right + B + C*Z_left*Z_right + D*Z_left)
        
        return R, T
    
    def solve(self):
        n_freq = len(self.frequencies)
        R = np.zeros(n_freq, dtype=complex)
        T = np.zeros(n_freq, dtype=complex)
        
        for i, freq in enumerate(self.frequencies):
            # Matriz total inicializada como identidad
            M_total = np.eye(2, dtype=complex)
            
            # Multiplicar matrices de todas las capas
            for layer in self.layers:
                rho, c, d = layer
                M_layer = self.layer_matrix(freq, rho, c, d)
                M_total = np.dot(M_total, M_layer)
            
            # Impedancias de los medios extremos
            Z_left = self.calculate_impedance(self.layers[0][0], self.layers[0][1])
            Z_right = self.calculate_impedance(self.layers[-1][0], self.layers[-1][1])
            
            R[i], T[i] = self.calculate_coefficients(Z_left, Z_right, M_total)
        
        return R, T

# Ejemplo de uso
if __name__ == "__main__":
    # Definir parámetros
    frequencies = np.linspace(100, 5000, 500)  # 100 Hz a 5 kHz
    
    # Definir capas: [densidad (kg/m³), velocidad (m/s), espesor (m)]
    layers = [
        [1.2, 343, 0.1],    # Aire - medio de entrada
        [1000, 1500, 0.02], # Agua - capa intermedia
        [1.2, 343, 0.1]     # Aire - medio de salida
    ]
    
    # Calcular
    tmm = AcousticTMM(frequencies, layers)
    R, T = tmm.solve()
    
    # Graficar resultados
    plt.figure(figsize=(12, 8))
    
    plt.subplot(2, 2, 1)
    plt.plot(frequencies, 20*np.log10(np.abs(R)))
    plt.title('Coeficiente de Reflexión (dB)')
    plt.xlabel('Frecuencia (Hz)')
    plt.ylabel('|R| (dB)')
    plt.grid(True)
    
    plt.subplot(2, 2, 2)
    plt.plot(frequencies, 20*np.log10(np.abs(T)))
    plt.title('Coeficiente de Transmisión (dB)')
    plt.xlabel('Frecuencia (Hz)')
    plt.ylabel('|T| (dB)')
    plt.grid(True)
    
    plt.subplot(2, 2, 3)
    plt.plot(frequencies, np.angle(R))
    plt.title('Fase del Coeficiente de Reflexión')
    plt.xlabel('Frecuencia (Hz)')
    plt.ylabel('Fase (rad)')
    plt.grid(True)
    
    plt.subplot(2, 2, 4)
    plt.plot(frequencies, np.abs(R)**2 + np.abs(T)**2)
    plt.title('Conservación de Energía')
    plt.xlabel('Frecuencia (Hz)')
    plt.ylabel('|R|² + |T|²')
    plt.grid(True)
    plt.ylim([0.9, 1.1])
    
    plt.tight_layout()
    plt.show()
