## Simulaciones con la libreria tmm

### Enfoque principal

Este repositorio está orientado al estudio y simulación de fenómenos ópticos en sistemas multicapa utilizando el **Método de Matrices de Transferencia (TMM)**. Los scripts incluidos abordan diferentes aspectos de la óptica de películas delgadas y multicapa, con énfasis en cálculos y visualización de resultados.

#### Temáticas y ejemplos de scripts

- **Cálculo de ángulos elipsométricos (Psi y Delta):**
    - Se simulan sistemas compuestos por aire, SiO₂ y Si, variando el grosor de la capa de SiO₂.
    - Se emplea el TMM para calcular cómo los ángulos Psi y Delta dependen del espesor de la capa.
    - Los resultados se visualizan gráficamente para mostrar la influencia del grosor en las mediciones elipsométricas.
- **Cálculo de coeficientes de reflexión:**
    - Se determina la fracción de luz reflejada en sistemas multicapa para luz no polarizada, tanto a incidencia normal como a 45°.
    - Se analiza la dependencia del coeficiente de reflexión respecto al número de onda y el ángulo de incidencia.
    - Se destaca la diferencia esperada entre incidencia normal y oblicua según las ecuaciones de Fresnel.
- **Cálculo del vector de Poynting y absorción local:**
    - Se calcula el vector de Poynting y la absorción local a diferentes profundidades en estructuras multicapa.
    - Permite visualizar cómo la energía y la absorción varían dentro de la estructura.
- **Simulación de la transmisión en películas delgadas:**
    - Se simula la transmisión de luz a través de una película delgada usando el TMM.
    - Se calcula la intensidad transmitida para distintas longitudes de onda y se grafica la fracción de potencia transmitida.


#### Características comunes

- **Uso del TMM:** Todos los scripts emplean el Método de Matrices de Transferencia para resolver problemas ópticos en estructuras multicapa.
- **Visualización:** Los resultados de los cálculos se presentan mediante gráficos generados con `matplotlib`.
- **Inspiración y referencias:** Los ejemplos están basados en el libro *"Optical Waves in Layered Media"* de Pochi Yeh y reproducen ejemplos del repositorio [sbyrnes321/tmm].
- **Dependencias:** Utilizan principalmente las bibliotecas `numpy` y `matplotlib` para cálculos numéricos y visualización.
- **Aplicaciones:** Los scripts son útiles para entender fenómenos como elipsometría, reflexión, transmisión y absorción en sistemas ópticos multicapa.


#### Observaciones

- Los scripts están diseñados tanto para ilustrar conceptos teóricos como para servir de base para simulaciones ópticas en investigación o docencia.
- Se recomienda tener correctamente instalado el módulo `tmm` para ejecutar los ejemplos.

El repositorio ofrece ejemplos prácticos y didácticos para simular y analizar fenómenos ópticos en sistemas multicapa, con un enfoque fuerte en la aplicación del método de matrices de transferencia y la visualización de resultados.
