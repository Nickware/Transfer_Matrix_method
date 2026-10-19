# Método de Matriz de Transferencia

Este repositorio reúne ejemplos educativos del **método de matriz de transferencia (TMM)** aplicados a sistemas estratificados. En términos generales, cada capa se representa mediante una matriz y la respuesta del conjunto se obtiene al multiplicarlas en orden. Los ejemplos calculan, según el dominio, reflexión, transmisión, propagación de ondas o bandas de energía.

El contenido está organizado por área y combina scripts en Python y MATLAB/Octave con documentación y propuestas. **No es una única biblioteca ni todos los documentos describen código ya implementado**; consulta cada README para conocer las hipótesis y requisitos de cada ejemplo.

## Mapa del repositorio

| Área | Contenido actual | Punto de entrada |
| --- | --- | --- |
| Base acústica | Ejemplo Python de TMM para medios acústicos multicapa. | [Documentación](Base/Readme.md) · [Código](Base/multilayer_media.py) |
| Óptica | Ejemplos de elipsometría, reflexión, transmisión y vector de Poynting; varios usan la biblioteca `tmm`. | [Documentación](Optics/Readme.md) · [Scripts](Optics/) |
| Geofísica | Simulación Python de propagación sísmica en capas terrestres. | [Documentación](Geophysics/Readme.md) · [Código](Geophysics/seismic_wave.py) |
| Mecánica cuántica | Ejemplos MATLAB/Octave para la ecuación de Schrödinger 1D y superredes. | [Documentación](Quantum_Mechanics/Readme.md) · [Barrera 1D](Quantum_Mechanics/Schrödinger_1D.m) · [Superred](Quantum_Mechanics/Superlattice.m) |
| Acústica aplicada | Documentación sobre propagación sonora y una propuesta para organizar una implementación reutilizable. | [Documentación](Acustic/Readme.md) · [Propuesta](Acustic/Propuesta_implementacion.md) |
| Caso: fachada aeroportuaria | Modelo Octave de una fachada multicapa; calcula pérdida por transmisión y estima niveles interiores con un espectro ilustrativo. Incluye resultados CSV. | [Descripción](Use_case/Airport/Readme.md) · [Guía y alcance](Use_case/Airport/fachada/README.md) · [Script](Use_case/Airport/fachada/fachada_tmm_aeropuerto.m) |
| Caso conceptual: propagación de un chisme | Analogía didáctica inspirada en el TMM; no es un modelo físico ni sociológico validado. | [Descripción](Use_case/whisper/README.md) · [Script](Use_case/whisper/chisme_capas_tmm.m) |

## Primeros pasos

No hay una instalación única para todo el repositorio. Los ejemplos Python requieren normalmente `numpy` y `matplotlib`; los scripts ópticos que importan `tmm` necesitan además esa biblioteca. Revisa el README del área antes de ejecutar un ejemplo.

Por ejemplo, desde la raíz del repositorio:

```bash
python Base/multilayer_media.py
python Geophysics/seismic_wave.py
```

Para el modelo de fachada, con Octave instalado, ejecútalo desde su carpeta para que las gráficas y el CSV se escriban en el directorio `output` previsto:

```bash
cd Use_case/Airport/fachada
octave fachada_tmm_aeropuerto.m
```

## Alcance

Los scripts son ejemplos y prototipos independientes, con supuestos propios de cada problema. En particular, el caso aeroportuario usa un espectro ilustrativo y simplificaciones como incidencia normal; no sustituye mediciones, una evaluación normativa ni un modelo acústico completo. Para interpretar resultados, consulta la documentación del proyecto correspondiente.