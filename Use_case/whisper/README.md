# Modelo conceptual de propagación de chisme por capas

Este ejemplo de Octave compara dos cascadas hipotéticas de propagación: un escenario base y otro con moderación. Usa la idea de capas del **método de matriz de transferencia (TMM)** como analogía; no aplica matrices físicas ni es un modelo social validado.

## Idea general

El modelo trabaja con una intensidad normalizada entre 0 y 1 que avanza por estas transiciones:

- Emisor → Amigos → Redes → Opinión pública → Consecuencias

En cada transición, la intensidad entrante se reparte entre:

- **Transmisión (`T`)**: pasa al siguiente nodo.
- **Filtrado (`A`)**: se detiene por duda, verificación o decisión de no compartir.
- **Contra-relato (`R`)**: parte asociada a una respuesta o desmentido.
- **Sin propagación**: intensidad restante que tampoco avanza.

Para cada etapa se exige `T + A + R <= 1`; el script comprueba los coeficientes antes de simular.

## Escenarios y parámetros

El script compara dos conjuntos de coeficientes, definidos en `T_case`, `A_case` y `R_case`:

- `Base`: cascada de referencia.
- `Moderacion`: cascada hipotética con menor transmisión y mayor filtrado/contra-relato en algunas etapas.
- `intensity0`: intensidad inicial normalizada; por defecto es `1.0`.

Los valores son supuestos ilustrativos, no probabilidades medidas. `R` se contabiliza como contra-relato, pero el script no modela cómo se difunde ni si logra corregir a quienes recibieron el mensaje.

## Salidas

- Gráfico que compara la intensidad que alcanza cada nodo en ambos escenarios.
- Barras apiladas con el balance de flujos por etapa para el escenario base.
- Resumen numérico en consola, incluida la intensidad en consecuencias.
- `output/chisme_capas_resultados.csv`, con una fila por escenario y transición.

## Ejecución

Con Octave instalado, desde la raíz del repositorio:

```bash
cd Use_case/whisper
octave chisme_capas_tmm.m
```

El script crea `output` si no existe y escribe allí el CSV. También abre las gráficas.

## Interpretación y límites

El resultado permite comparar cómo cambian las intensidades al modificar los coeficientes supuestos. No predice la difusión real de rumores ni representa personas, redes, tiempos, repetición, credibilidad, diferencias de audiencia o la influencia efectiva de una corrección.

Úsalo como ejercicio de balance de flujos y análisis de escenarios, no para evaluar personas, comunidades o estrategias reales sin datos y un modelo validado.
