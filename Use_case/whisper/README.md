# Modelo conceptual de propagacion de chisme por capas (analoga al TMM) (en desarrollo)

Este script de Octave implementa un **modelo conceptual** de propagacion de un chisme, injuria o calumnia a traves de capas sociales, inspirado en la logica del **metodo de matriz de transferencia (TMM)** usado en acustica y fisica.

## Idea general

En lugar de ondas sonoras, el modelo trabaja con **intensidad de chisme** que se propaga de una capa social a la siguiente:

- **Emisor inicial** → **Amigos/cercanos** → **Redes sociales** → **Opinion publica** → **Consecuencias publicas**

Cada capa puede:

- **Transmitir** el chisme (pasar a la siguiente capa),
- **Absorber** (filtrar, dudar, corregir, no repetir),
- **Reflejar** (generar contra-relato, desmentido, defensa).

Esto es analogo a como una capa acustica transmite, absorbe y refleja una onda sonora.

## Parametros principales

En el script puedes modificar:

- `T`: probabilidad de transmision por capa (0..1). Valores altos = chisme se propaga facilmente.
- `A`: probabilidad de absorcion por capa (0..1). Valores altos = la capa filtra mejor el chisme.
- `R`: probabilidad de reflexion por capa (0..1). Valores altos = mayor chance de desmentido o contra-relato.
- `intensity0`: intensidad inicial del chisme (0..1).

## Salidas

- Grafico de intensidad del chisme por capa.
- Grafico de transmision, absorcion y reflexion por capa.
- Esquema conceptual con flechas que muestran los flujos.
- Resultados numericos en consola.
- Archivo CSV con tabla de resultados.

## Interpretacion

Este modelo es conceptual y didactico, no una teoria sociologica completa. Sirve para:

- Pensar en como se propaga el chisme a traves de capas sociales.
- Identificar donde estan las "barreras" mas fuertes (capas con alta absorcion o reflexion).
- DiseVAR estrategias de intervencion:
  - reducir transmision (educacion, normas, sanciones),
  - aumentar absorcion (cultura de no chismear, pensamiento critico),
  - aumentar reflexion (desmentidos rapidos, contra-narrativas).

## Aplicacion a estudios sociales

Puedes usar este modelo para:

- Estudiar casos de difamacion, cancelacion, estigma social.
- Analizar como el ruido social (chismes) se relaciona con el ruido fisico (ruido de aeropuerto, por ejemplo).
- DiseVAR encuestas o entrevistas que muestren como las personas perciben la propagacion de chismes en su comunidad.

## Limitaciones

- No captura motivaciones profundas, poder, desigualdad, genero, etnia.
- No explica subjetividad ni experiencia vivida.
- Es una metá··fora matematica simplificada, no una teoria completa.
