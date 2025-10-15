# Barrera Cuántica 1D con Método de Matriz de Transferencia

## Descripción

Este script resuelve la ecuación de Schrödinger independiente del tiempo para una **barrera cuántica unidimensional (1D)** utilizando el **método de matriz de transferencia**. El objetivo es calcular y visualizar la función de onda asociada a una partícula de energía $$E$$ al incidir sobre una barrera rectangular de altura $$V_0$$ y ancho $$a$$. El resultado es una representación gráfica de la función de onda y el perfil del potencial, lo que permite analizar fenómenos como la reflexion y el tunelamiento cuántico.

## Características

- **Implementa el método de matriz de transferencia:** permite acoplar soluciones en regiones con diferentes potenciales de forma eficiente.
- **Perfil configurable:** puedes modificar la energía, la altura y el ancho de la barrera fácilmente en los parámetros del script.
- **Visualización clara:** gráfica en la misma figura la parte real de la función de onda y el perfil del potencial.

## Uso

1. **Abre Octave** y copia el código en un archivo, por ejemplo `barrera_transferencia.m`.
2. **Ejecuta el script** en Octave:
   ```
   barrera_transferencia
   ```
3. **Visualiza la gráfica** generada, donde:
    - La línea azul muestra la parte real de la función de onda $$\psi(x)$$ en las tres regiones.
    - La línea negra discontinua representa el perfil del potencial $$V(x)$$.

## Parámetros Modificables

- `E`  = Energía de la partícula.
- `V0` = Altura de la barrera.
- `a`  = Ancho de la barrera.

Puedes experimentar con estos valores para observar cómo cambian la transmisión, la reflexión y el comportamiento de tunelamiento a través de la barrera.

## Conceptos importantes

- **Unidad natural:** el script utiliza unidades atómicas ($$\hbar=1$$, $$m=1/2$$) para simplificar la notación.
- **Coeficientes:** puedes agregar cálculos de coeficientes de transmisión y reflexión expandiendo el script a partir de las amplitudes calculadas.
- **Generalización:** para múltiples barreras o potenciales arbitrarios, podrías adaptar la construcción de matrices de transferencia.

## Dependencias

- Octave GNU (recomendado: versión 6 o superior).

## Créditos

Elaborado con fines formativos para cursos de mecánica cuántica, física moderna y simulaciones de transporte cuántico.
