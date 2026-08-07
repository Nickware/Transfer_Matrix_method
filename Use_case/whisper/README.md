# Modelo conceptual de propagación de chisme por capas (análoga al TMM) (en desarrollo)

Este script de Octave implementa un **modelo conceptual** de propagación de un chisme, injuria o calumnia a través de capas sociales, inspirado en la lógica del **método de matriz de transferencia (TMM)** usado en acústica y física.

## Idea general

En lugar de ondas sonoras, el modelo trabaja con **intensidad de chisme** que se propaga de una capa social a la siguiente:

- Emisor inicial → Amigos/cercanos → Redes sociales → Opinión pública → Consecuencias públicas

Cada capa puede:

- Transmitir el chisme (pasar a la siguiente capa),
- Absorber (filtrar, dudar, corregir, no repetir),
- Reflejar (generar contrarrelato, desmentido, defensa).

Esto es análogo a cómo una capa acústica transmite, absorbe y refleja una onda sonora.

## Parámetros principales

En el script puedes modificar:

- `T`: probabilidad de transmisión por capa (0..1). Valores altos = chisme se propaga fácilmente.
- `A`: probabilidad de absorción por capa (0..1). Valores altos = la capa filtra mejor el chisme.
- `R`: probabilidad de reflexión por capa (0..1). Valores altos = mayor chance de desmentido o contrarrelato.
- `intensity0`: intensidad inicial del chisme (0..1).

## Salidas

- Gráfico de intensidad del chisme por capa.
- Gráfico de transmisión, absorción y reflexión por capa.
- Esquema conceptual con flechas que muestran los flujos.
- Resultados numéricos en consola.
- Archivo CSV con tabla de resultados.

## Interpretacion

Este modelo es conceptual y didáctico, no una teoría sociológica completa. Sirve para:

- Pensar en cómo se propaga el chisme a través de capas sociales.
- Identificar dónde están las "barreras" más fuertes (capas con alta absorción o reflexión).
- Diseñar estrategias de intervención:
  - reducir transmisión (educación, normas, sanciones),
  - aumentar absorción (cultura de no chismear, pensamiento crítico),
  - aumentar la reflexión (desmentidos rápidos, contranarrativas).

## Aplicación a estudios sociales

Puedes usar este modelo para:

- Estudiar casos de difamación, cancelación, estigma social.
- Analizar cómo el ruido social (chismes) se relaciona con el ruido físico (ruido de aeropuerto, por ejemplo).
- Diseñar encuestas o entrevistas que muestren cómo las personas perciben la propagación de chismes en su comunidad.

## Limitaciones

- No captura motivaciones profundas, poder, desigualdad, género, etnia.
- No explica subjetividad ni experiencia vivida.
- Es una metáfora matemática simplificada, no una teoría completa.
