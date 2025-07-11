# Optics
## Repositorio Optics

Este repositorio **Nickware/Optics**, emplea librerias como `tmm` (Transfer Matrix Method). Incluye los siguientes elementos y funcionalidades:

### 1. Scripts de simulación óptica

- **Cálculo de reflexión y transmisión:** Scripts para calcular la fracción de luz reflejada y transmitida en sistemas multicapa usando el método de matrices de transferencia.
- **Modelado de películas delgadas:** Ejemplos que simulan la propagación de luz en películas delgadas y estructuras multicapa, considerando diferentes materiales y espesores.
- **Simulación de elipsometría:** Cálculo de ángulos elipsométricos (Psi y Delta) para analizar la respuesta óptica de capas delgadas.
- **Cálculo de absorción local:** Herramientas para determinar la absorción de luz en diferentes posiciones dentro de la estructura multicapa.
- **Visualización:** Gráficas de los resultados de simulaciones (por ejemplo, transmisión vs. longitud de onda, reflexión vs. ángulo de incidencia).


### 2. Ejemplos y documentación

- **Ejemplos prácticos:** Scripts inspirados en problemas clásicos de óptica, como los presentados en libros de referencia (por ejemplo, *Optical Waves in Layered Media* de Pochi Yeh).
- **Referencias a la librería original:** Notas que indiquen que los ejemplos están basados o adaptados de la librería `tmm` original y su documentación.
- **README detallado:** Explicación sobre el propósito del repositorio, instrucciones de uso y dependencias necesarias (como `numpy`, `matplotlib` y la propia `tmm`).


### 3. Estructura típica de archivos

- **Carpeta principal con scripts:** Archivos `.py` con simulaciones y ejemplos.
- **README.md:** Documento introductorio.
- **Requisitos:** Archivo `requirements.txt` o instrucciones para instalar las dependencias.
- **Posibles notebooks:** Archivos `.ipynb` para ejemplos interactivos.


### 4. Funcionalidades 

- **Cálculo de coeficientes ópticos:** Reflexión, transmisión, absorción en sistemas multicapa para diferentes ángulos y polarizaciones.
- **Soporte para materiales dispersivos y absorbentes:** Permitir el uso de índices de refracción complejos y dependientes de la longitud de onda.
- **Simulación de estructuras mixtas:** Capacidad de modelar tanto capas delgadas como gruesas en una misma estructura[^1][^2].
- **Cálculo de parámetros elipsométricos:** Simulación de mediciones ópticas avanzadas como la elipsometría.


### 5. Dependencias y entorno

- **Librerías requeridas:** `numpy`, `matplotlib`, y `tmm` como mínimo.
- **Compatibilidad:** Scripts preparados para ejecutarse en Python 3.

En resumen, este repositorio contiene scripts y ejemplos para simular, analizar y visualizar fenómenos ópticos en sistemas multicapa, aprovechando todas las capacidades de librerías como `tmm` para estudios de reflexión, transmisión, absorción y elipsometría en películas delgadas[^1][^2].

[^1]: https://pypi.org/project/tmm/

[^2]: https://github.com/sbyrnes321/tmm

[^3]: https://github.com/Nickware/Optics

[^4]: https://pypi.org/project/tmm-fast/

[^5]: https://github.com/t3n0/transfer-matrix-method

[^6]: https://pypi.org/project/tmtools/

[^7]: https://github.com/sbyrnes321/tmm/blob/master/examples.py

[^8]: https://aur.archlinux.org/packages/optix

[^9]: https://pythonhosted.org/tmm/_modules/tmm/examples.html

[^10]: https://anaconda.org/conda-forge/tmm

[^11]: https://github.com/networkoptix/nx_open

[^12]: https://pythonhosted.org/tmm/tmm.html

[^13]: https://sjbyrnes.com/fresnel_manual.pdf

[^14]: https://github.com/pylhc/omc3

[^15]: https://paperswithcode.com/paper/tmm-fast-a-transfer-matrix-computation

[^16]: https://openresearchsoftware.metajnl.com/articles/10.5334/jors.271

[^17]: https://en.wikibooks.org/wiki/Opticks_Developer_Guide/Concepts

[^18]: https://arxiv.org/abs/2111.13667

[^19]: https://github.com/AniruthAnanth/LightweightTransferMatrixMethod

[^20]: https://github.com/networkoptix/tools

[^21]: https://arxiv.org/pdf/2111.13667.pdf
