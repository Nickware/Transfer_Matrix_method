# Método de Matriz de Transferencia (TMM) para Medios Multicapa

## Introducción

El **Método de Matriz de Transferencia (TMM)** es una técnica poderosa y eficiente para calcular los coeficientes de transmisión y reflexión de ondas que se propagan a través de medios con múltiples capas. Este método es ampliamente utilizado en diversas áreas como acústica, óptica, electromagnetismo y sismología.

## Fundamentos Teóricos

### Impedancia Característica

Para cada medio, la impedancia característica se define como:

$\[
Z_i = \rho_i \cdot c_i
\]$

donde:
- $\(\rho_i\)$ = densidad del medio $\(i\)$
- $\(c_i\)$ = velocidad de propagación en el medio $\(i\)$

### Número de Onda

El número de onda en cada medio está dado por:

$\[
k_i = \frac{\omega}{c_i} = \frac{2\pi f}{c_i}
\]$

donde:
- $\(\omega\)$ = frecuencia angular
- $\(f\)$ = frecuencia lineal

### Matriz de Transferencia para una Capa

Para una capa de espesor $\(d\)$, la matriz de transferencia es:

![](/home/jntorresr/Pictures/Screenshots/Screenshot from 2025-11-03 21-33-32.png)

### Sistema Multicapa

Para un sistema de $\(N\)$ capas, la matriz total es el producto de las matrices individuales:

$\[
M_{\text{total}} = M_1 \cdot M_2 \cdot \ldots \cdot M_N
\]$

### Coeficientes de Reflexión y Transmisión

Los coeficientes se calculan como:

$\[
R = \frac{A\cdot Z_{\text{derecha}} + B - C\cdot Z_{\text{izquierda}}\cdot Z_{\text{derecha}} - D\cdot Z_{\text{izquierda}}}{A\cdot Z_{\text{derecha}} + B + C\cdot Z_{\text{izquierda}}\cdot Z_{\text{derecha}} + D\cdot Z_{\text{izquierda}}}
\]$

$\[
T = \frac{2\cdot Z_{\text{derecha}}}{A\cdot Z_{\text{derecha}} + B + C\cdot Z_{\text{izquierda}}\cdot Z_{\text{derecha}} + D\cdot Z_{\text{izquierda}}}
\]$

donde $\(A, B, C, D\) son los elementos de \(M_{\text{total}}\).$

## Implementación

### Estructura de Datos

Cada capa se define mediante:
- Densidad $(\(\rho\))$
- Velocidad de propagación $(\(c\))$
- Espesor $(\(d\))$
- Nombre (opcional)

### Algoritmo Principal

1. **Inicialización**: Definir frecuencias de interés y propiedades de las capas
2. **Cálculo de impedancias**: $\(Z_i = \rho_i \cdot c_i\)$
3. **Cálculo de números de onda**: $\(k_i = \frac{2\pi f}{c_i}\)$
4. **Construcción de matrices**: Para cada capa a cada frecuencia
5. **Multiplicación de matrices**: Obtener la matriz total del sistema
6. **Cálculo de coeficientes**: Obtener $\(R\)$ y $\(T\)$ para cada frecuencia

## Código Ejemplo

```python
import numpy as np

class TMM:
    def __init__(self, frequencies, layers):
        self.frequencies = frequencies
        self.layers = layers
        
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
    
    def solve(self):
        n_freq = len(self.frequencies)
        R = np.zeros(n_freq, dtype=complex)
        T = np.zeros(n_freq, dtype=complex)
        
        for i, freq in enumerate(self.frequencies):
            M_total = np.eye(2, dtype=complex)
            
            for layer in self.layers:
                rho, c, d, _ = layer
                M_layer = self.layer_matrix(freq, rho, c, d)
                M_total = np.dot(M_total, M_layer)
            
            Z_left = self.calculate_impedance(self.layers[0][0], self.layers[0][1])
            Z_right = self.calculate_impedance(self.layers[-1][0], self.layers[-1][1])
            
            A, B, C, D = M_total[0,0], M_total[0,1], M_total[1,0], M_total[1,1]
            
            denominator = A*Z_right + B + C*Z_left*Z_right + D*Z_left
            R[i] = (A*Z_right + B - C*Z_left*Z_right - D*Z_left) / denominator
            T[i] = (2*Z_right) / denominator
        
        return R, T
```

## Aplicaciones

### 1. Acústica
- Diseño de materiales absorbentes
- Aislamiento acústico
- Transductores y altavoces

### 2. Óptica
- Recubrimientos antirreflejos
- Espejos dieléctricos
- Filtros ópticos

### 3. Electromagnetismo
- Absorbentes de radar (RAM)
- Antenas de microstrip
- Dispositivos de invisibilidad

### 4. Sismología
- Análisis de propagación de ondas sísmicas
- Caracterización de suelos
- Estudios de microzonificación

## Ventajas del TMM

1. **Precisión**: Solución exacta de la ecuación de onda
2. **Eficiencia**: Cálculo rápido para múltiples frecuencias
3. **Flexibilidad**: Maneja cualquier número de capas
4. **Estabilidad**: Numéricamente robusto
5. **Versatilidad**: Aplicable a múltiples fenómenos ondulatorios

## Visualización

El método permite visualizar:
- Coeficientes de transmisión y reflexión vs. frecuencia
- Pérdida de transmisión
- Impedancia de cada capa
- Respuesta en fase y amplitud
- Efectos de resonancia

## Extensiones Avanzadas

### Medios con Pérdidas
Incorporar atenuación mediante un número de onda complejo:

$\[
k = \frac{\omega}{c} + j\alpha
\]$

donde $\(\alpha\)$ es el coeficiente de atenuación.

### Incidencia Oblícua
Modificar las matrices para ángulos de incidencia no normales.

### Anisotropía
Extender el método para medios anisotrópicos.

## Referencias

1. Chew, W. C. (1995). Waves and fields in inhomogeneous media.
2. Born, M., & Wolf, E. (1999). Principles of optics.
3. Brekhovskikh, L. M. (1960). Waves in layered media.
4. Yeh, P. (1988). Optical waves in layered media.

## Cómo Usar

1. Definir las propiedades de las capas (densidad, velocidad, espesor)
2. Especificar el rango de frecuencias de interés
3. Ejecutar el código para calcular R y T
4. Visualizar los resultados con las herramientas proporcionadas

## Ejemplo de Configuración

```python
# Definir capas: [densidad, velocidad, espesor, nombre]
layers = [
    [1.2, 343, np.inf, "Aire"],
    [1000, 1500, 0.1, "Agua"],
    [2000, 3000, 0.2, "Vidrio"],
    [1.2, 343, np.inf, "Aire"]
]

frequencies = np.linspace(100, 10000, 1000)  # 100 Hz a 10 kHz

tmm = TMM(frequencies, layers)
R, T = tmm.solve()
```

## Interpretación de Resultados

- $\(|R|^2 + |T|^2 = 1\)$ (conservación de energía)
- Picos en la transmisión indican resonancias
- Valles en la transmisión indican interferencia destructiva
- La fase proporciona información sobre retardos temporales

## Contribuciones

Las contribuciones son bienvenidas. Por favor:
1. Revise los issues existentes
2. Haga fork del proyecto
3. Cree una rama para su característica
4. Commit sus cambios
5. Push a la rama
6. Abra un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT. Vea el archivo `LICENSE` para más detalles.
