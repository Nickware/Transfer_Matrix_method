# Modelo acústico TMM para fachada cercana a aeropuerto

Esté script de **Octave** esta pensado para modelar la fachada multicapa usando **TMM acústico** con el esquema aire exterior → muro pesado → cámara de aire → lana mineral → placa interior → aire interior. marshallday+2

El modelo calcula la **pérdida por transmisión** \(TL\) o \(STL\) por frecuencia, estima un nivel interior a partir de un espectro exterior simplificado de ruido de aeronave y sigue la idea estándar de TMM: cada capa se representa por una matriz de transferencia y la matriz total se obtiene multiplicándolas en cascada.scribd+2

## Qué incluye

- Script `fachada_tmm_aeropuerto.m` con:
  - barrido en frecuencia,
  - cálculo de coeficiente de transmisión $\tau$,
  - cálculo de $TL = -10\log_{10}(\tau)$,
  - estimación de nivel interior por banda.dael.euracoustics+1

## Alcance del modelo

Este es un modelo **didáctico y simplificado**, útil para prototipos y comparación entre configuraciones de fachada, pero no reemplaza una evaluación normativa ni una caracterización de laboratorio o campo.pubs.aip+1
En particular, usa incidencia normal, masas superficiales para muro/placa y un poroso equivalente simple; para un estudio real haría falta incorporar incidencia difusa, ventanas, puentes estructurales, espectros medidos localmente y modelos más detallados del material poroso.publications.ibpsa+2

## Cómo usarlo

Ejecuta el script en Octave y luego ajusta parámetros como:

- `m1` para el muro exterior,
- `d_air` para la cámara de aire,
- `d_p` y parámetros del poroso,
- `m2` para la placa interior,
- `Lext` para cambiar el espectro exterior.faa+1

Una **versión mejorada** podría incluir:

- usar **bandas de tercio de octava normalizadas**,

- comparar **dos o tres fachadas** en la misma gráfica,

- o incorporar una **ventana doble** como segundo camino de transmisión, algo relevante cerca de aeropuertos.nrc-publications.canada+1

# Modelo numérico simplificado para estimar la pérdida por transmisión sonora (STL o TL)

Este script de Octave implementa un **modelo numérico simplificado** basado en el **método de matriz de transferencia (TMM)** para estimar la **pérdida por transmisión sonora (STL o TL)** de una fachada multicapa sometida a un espectro típico de ruido de aeronaves. El esquema físico usado es:

**aire exterior -> muro pesado -> cámara de aire -> lana mineral -> placa interior -> aire interior**

El objetivo es estimar, por banda de frecuencia, cuánto del ruido exterior logra transmitirse al interior de una vivienda o recinto.

## Qué calcula

El script calcula para cada frecuencia:

- El coeficiente de transmisión acústica `tau`.
- La pérdida por transmisión `TL` en dB.
- El nivel interior estimado `Lin = Lext - TL`.
- Una reducción global aproximada entre el espectro exterior e interior.

También genera:

- Una gráfica de `TL(f)`.
- Una gráfica comparando espectro exterior e interior estimado.
- Un esquema de las capas de la fachada.
- Un archivo CSV con resultados numéricos.

## Hipótesis del modelo

Este es un modelo **didáctico y de primer orden**, no un modelo normativo ni un cálculo certificado. Usa las siguientes simplificaciones:

- **Incidencia normal** de la onda sonora sobre la fachada.
- **Aire exterior e interior** modelados como fluidos homogéneos.
- **Muro y placa interior** modelados como masas superficiales con amortiguamiento estructural.
- **Lana mineral** modelada como un fluido equivalente simple con pérdidas efectivas.
- Espectro exterior de aeronave **ilustrativo**, no medido localmente.

Para estudios reales se requeriría incorporar:

- Incidencia difusa.
- Modelos más detallados del poroso (Delany-Bazley, Miki, Johnson-Champoux-Allard).
- Resonancias estructurales, coincidencia y puentes rígidos.
- Ventanas, infiltraciones y uniones constructivas.
- Espectros medidos en sitio o basados en operaciones reales del aeropuerto.

## Parámetros principales

Es posible modificar fácilmente:

- `m1`: masa superficial del muro exterior.
- `d_air`: espesor de la cámara de aire.
- `d_p`: espesor de la lana mineral.
- `rho_eq`, `c_eq`, `alpha_p`: parámetros efectivos del poroso.
- `m2`: masa superficial de la placa interior.
- `Lext`: espectro exterior de ruido de aeronave.

## Cómo ejecutar

Guarda el script como:

```octave
fachada_tmm_aeropuerto.m
```

Luego ejecútalo en Octave:

```octave
fachada_tmm_aeropuerto
```

## Archivos generados

- `fachada_tmm_resultado.png`: curva de TL y comparación exterior/interior.
- `fachada_tmm_capas.png`: esquema de la fachada multicapa.
- `fachada_tmm_resultados.csv`: tabla con frecuencias, niveles y transmisión.

## Interpretación física rápida

- Si `TL` aumenta, la fachada aísla mejor en esa frecuencia.
- Si `Lin` baja mucho respecto a `Lext`, el sistema reduce bien el ruido incidente.
- Las caídas locales en `TL` pueden indicar resonancias o bandas donde el sistema funciona peor.

## Aplicación al caso aeroportuario

Este tipo de modelo puede servir como **prototipo** para estudiar viviendas cercanas a corredores de ruido aeroportuario, por ejemplo en entornos urbanos expuestos a despegues y aterrizajes. Sirve para comparar configuraciones de fachada y evaluar qué combinación de masa, cámara y absorbente puede reducir mejor el ruido en bandas relevantes para aeronaves.

## Siguiente mejora recomendada

Una extensión natural del script es incorporar:

1. Bandas de tercio de octava normalizadas.
2. Espectros reales de ruido exterior medidos en campo.
3. Ventanas dobles o triples como segunda ruta de transmisión.
4. Comparación entre varias fachadas en la misma corrida.
