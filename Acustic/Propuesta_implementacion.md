# Propuesta concreta de implementación del proyecto

## Objetivo

Desarrollar un prototipo en Python para modelar la propagación de sonido en estructuras multicapa mediante el método de matriz de transferencia (TMM), con un caso de uso inicial para una fachada cercana a un aeropuerto.

## Alcance inicial

1. Resolver la transmisión y reflexión de una onda acústica a través de capas planas y homogéneas.
2. Calcular:
   - coeficientes de reflexión y transmisión,
   - pérdida por transmisión TL/STL en dB,
   - nivel interior estimado a partir de un espectro exterior.
3. Incluir un ejemplo realista de fachada multicapa.
4. Generar resultados exportables (CSV/PNG) y una interfaz simple para ejecutar casos.

## Estructura propuesta del proyecto

```text
Acustic/
  Readme.md
  Propuesta_implementacion.md
  acoustic_tmm/
    __init__.py
    core.py
    layers.py
    examples.py
    plotting.py
    io_utils.py
  data/
    airport_fachada_config.json
    example_layers.json
  scripts/
    run_airport_case.py
  tests/
    test_core.py
    test_airport_case.py
```

## Componentes principales

### 1. Modelo físico base

Implementar una clase central que reciba:
- un vector de frecuencias,
- una lista de capas,
- propiedades de cada capa: densidad, velocidad del sonido, espesor,
- opcionalmente: pérdidas de amortiguamiento o factor de pérdida.

Cada capa se representará con una estructura tipo dataclass:

```python
from dataclasses import dataclass

@dataclass
class Layer:
    name: str
    rho: float
    c: float
    thickness: float
    loss_factor: float = 0.0
```

### 2. Solver TMM

Crear una clase `AcousticTMM` con métodos para:
- calcular impedancia acústica `Z = rho * c`,
- calcular número de onda `k = 2*pi*f / c`,
- construir la matriz de transferencia de cada capa,
- multiplicar las matrices en cascada,
- obtener coeficientes de reflexión y transmisión,
- convertir el resultado a `TL` y `STL`.

### 3. Caso de uso: fachada de aeropuerto

Usar el esquema físico:

```text
aire exterior -> muro pesado -> cámara de aire -> lana mineral -> placa interior -> aire interior
```

Parámetros sugeridos para el prototipo:
- aire exterior/interior: `rho = 1.2`, `c = 343`, `thickness = 0.0` (medio semi-infinito)
- muro pesado: `rho = 2200`, `c = 3500`, `thickness = 0.12`
- cámara de aire: `rho = 1.2`, `c = 343`, `thickness = 0.05`
- lana mineral: `rho = 80`, `c = 250`, `thickness = 0.05`
- placa interior: `rho = 800`, `c = 2500`, `thickness = 0.012`

### 4. Entrada y salida

- Configuración en JSON o YAML para evitar hardcode.
- Salida en CSV con columnas:
  - frecuencia,
  - `R`, `T`,
  - `TL`,
  - `L_interior` estimado.
- Gráficos de `TL(f)` y comparación exterior/interior.

## Implementación paso a paso

### Fase 1: base matemática

- Refactorizar el archivo base [Base/multilayer_media.py](../Base/multilayer_media.py) para que sea reutilizable.
- Asegurar que el cálculo sea estable para un rango de frecuencias realista (100 Hz a 5000 Hz).
- Validar resultados con un caso simple de una sola interfaz aire-aire.

### Fase 2: estructura modular

- Separar en módulos claros:
  - `core.py`: lógica TMM,
  - `layers.py`: modelos de capas,
  - `examples.py`: casos de ejemplo,
  - `plotting.py`: visualización,
  - `io_utils.py`: lectura/escritura de datos.

### Fase 3: caso de fachada

- Adaptar el modelo de la fachada del caso de uso existente en la carpeta [Use_case/Airport/fachada](../Use_case/Airport/fachada).
- Usar un espectro exterior simplificado de ruido de aeronaves.
- Estimar el nivel interior como:

```python
L_interior = L_exterior - TL
```

### Fase 4: interfaz ejecutable

Agregar un script CLI sencillo:

```bash
python scripts/run_airport_case.py --config data/airport_fachada_config.json
```

### Fase 5: pruebas y validación

- Crear pruebas unitarias para:
  - una sola capa,
  - dos capas con cambio brusco de impedancia,
  - comparación de energía entre reflexión y transmisión.

## Ejemplo mínimo de código

```python
import numpy as np
from acoustic_tmm.core import AcousticTMM
from acoustic_tmm.layers import Layer

frequencies = np.linspace(100, 5000, 1000)

layers = [
    Layer(name="aire_ext", rho=1.2, c=343, thickness=0.0),
    Layer(name="muro", rho=2200, c=3500, thickness=0.12),
    Layer(name="aire_camara", rho=1.2, c=343, thickness=0.05),
    Layer(name="lana", rho=80, c=250, thickness=0.05),
    Layer(name="placa", rho=800, c=2500, thickness=0.012),
    Layer(name="aire_int", rho=1.2, c=343, thickness=0.0),
]

solver = AcousticTMM(frequencies=frequencies, layers=layers)
R, T = solver.solve()
TL = -10 * np.log10(np.maximum(np.abs(T), 1e-12))
```

## Resultado esperado del primer prototipo

Al finalizar la primera iteración, el proyecto debería permitir:
- ejecutar un caso simple desde la línea de comandos,
- generar una curva de `TL` por frecuencia,
- comparar ruido exterior e interior estimado,
- exportar resultados a CSV,
- servir como base para futuros estudios más realistas o para validación con datos medidos.

## Recomendación de prioridad

Empezar por:
1. reescribir el núcleo TMM en Python de forma modular,
2. añadir un caso de fachada de ejemplo,
3. dejar el resultado listo para ejecutar en una sola orden.