# Aislamiento y control de ruido ambiental cerca de aeropuertos 

El aislamiento y control de ruido ambiental cerca de aeropuertos se basa en entender cómo el **sonido se propaga en el aire y atraviesa o se refleja en estructuras** (muros, ventanas, fachadas, barreras), y en diseñar sistemas multicapa que disipen parte de esa energía mediante fricción interna, materiales porosos y viscoelásticos.[archdaily+1](https://www.archdaily.com/1029098/environmental-noise-improving-urban-soundscapes-for-well-being)

## Qué se busca cerca de aeropuertos

En zonas residenciales cercanas a aeropuertos (como barrios alrededor de pistas), el objetivo típico es reducir el nivel de ruido interior en viviendas, colegios y hospitales mediante:[sciencedirect+2](https://www.sciencedirect.com/science/article/abs/pii/S1574954117302479)

- Mejora de la **fachada** (muros, ventanas, sellos, cubiertas) para aumentar el aislamiento sonoro.
- Uso de **programas de insonorización residencial**, que financian cambios constructivos (doble/triple ventana, vidrios laminados, muros multicapa, techos mejorados).[noisequest.psu+2](https://www.noisequest.psu.edu/noiseeffects-residentialsound.html)
- Diseño urbano y de edificios que **protejan fachadas sensibles** (dormitorios, aulas) del ruido directo de aeronaves.[aes-aes+2](https://www.aes-aes.com/consultancy-services/environmental-and-facade-noise-modelling/)

## Rol de los materiales porosos y viscoelásticos

En fachadas, techos y barreras se usan combinaciones de capas para aumentar la **pérdida por transmisión** (Sound Transmission Loss, STL):[ioa+3](https://acortar.link/1BhCtL) 

- **Materiales porosos** (lana mineral, espumas, fibras):
  - Dejan entrar el sonido en su estructura de poros.
  - La viscosidad del aire en los poros y las pérdidas térmicas convierten energía acústica en calor.
- **Capas viscoelásticas** (láminas amortiguantes, polímeros):
  - Se deforman con la vibración del panel y disipan energía por amortiguamiento interno.[jtam+1](http://jtam.pl/pdf-101763-33336?filename=Effects+of+viscoelastic.pdf)
- **Configuraciones multicapa** (placa rígida + cámara de aire + poroso + placa):
  - Generan desajustes de impedancia y múltiples reflexiones internas, aumentando la atenuación.[ioa+1](https://acortar.link/1BhCtL) 

Estudios muestran que paneles multicapa (poroso + viscoelástico + placas) pueden incrementar notablemente la pérdida por transmisión (decenas de dB extra en rangos de frecuencia relevantes para ruido de aeronaves).[fzt.haw-hamburg+1](https://www.fzt.haw-hamburg.de/pers/Scholz/ewade/2007/CEAS2007/papers2007/ceas-2007-469.pdf)

## Cómo se integra esto en el diseño alrededor de aeropuertos

En la práctica se combinan **modelo de propagación exterior** + **modelo de fachada**:[ams-institute+2](https://www.ams-institute.org/news/a-new-way-of-urban-design-reduces-aircraft-noise-around-buildings-and-in-outdoor-spaces/)

- Modelos ambientales calculan niveles de ruido que llegan a la fachada (contornos de 65 dB DNL, etc.).[noisequest.psu+1](https://www.noisequest.psu.edu/noiseeffects-residentialsound.html)
- Modelos de fachada (a menudo basados en estructuras multicapa y, numéricamente, en métodos tipo matriz de transferencia) evalúan cuánto se atenúa el ruido al pasar por muros, ventanas y techos, considerando capas de aire, vidrio, porosos y viscoelásticos.[aes-aes+2](https://www.aes-aes.com/consultancy-services/environmental-and-facade-noise-modelling/)
- Guías oficiales de insonorización alrededor de aeropuertos especifican **estándares de reducción de nivel**, métodos de ensayo y estrategias típicas (ventanas especiales, refuerzo de techos, ventilación mecánica para permitir mantener ventanas cerradas).[faa+3](https://www.faa.gov/documentLibrary/media/Advisory_Circular/150-5000-9B-Sound-Insulation-2022.pdf)

Investigaciones recientes en diseño urbano “sound-adaptive” muestran que la **geometría de los edificios y patios** puede reducir el ruido de aeronaves hasta del orden de 10–15 dB en fachadas protegidas, complementando el aislamiento material.[archdaily+1](https://www.archdaily.com/1029098/environmental-noise-improving-urban-soundscapes-for-well-being)

# Fachada multicapa sometida a ruido de aeronaves

Es posible armar un modelo conceptual bastante realista de **fachada multicapa** sometida a ruido de aeronaves y ver cómo entra el método de matriz de transferencia acústica para estimar la **transmisión en frecuencia** (STL o pérdida por transmisión). [publications.ibpsa](https://publications.ibpsa.org/proceedings/bs/2019/papers/BS2019_211184.pdf)

## 1. Esquema físico de la fachada

Se parte de una fachada típica mejorada cerca de un aeropuerto:

- Capa 1: **aire exterior** (medio incidente).  
- Capa 2: **muro estructural** (ladrillo u hormigón).  
- Capa 3: **cámara de aire**.  
- Capa 4: **lana mineral** (material poroso absorbente).  
- Capa 5: **placa interior** (yeso laminado / drywall).  
- Capa 6: **aire interior** (habitación receptora).  

En la práctica, estudios de transmisión a través de muros multicapa usan precisamente este tipo de esquema y lo modelan con TMM, tratando el poroso como fluido equivalente (modelo de Johnson–Allard) y las placas con modelos de placa delgada acoplados al TMM. [sciencedirect](https://www.sciencedirect.com/science/article/pii/S0360132321002146)

## 2. Idea del método de matriz de transferencia acústica

En una aproximación simplificada de **onda plana normal a la fachada**:

- Cada capa fluida (aire, poroso visto como fluido equivalente) se describe por su **impedancia acústica** $\(Z_i = \rho_i c_i\$) y número de onda $\(k_i(\omega)\)$, que puede ser complejo si hay pérdidas. [pmc.ncbi.nlm.nih](https://pmc.ncbi.nlm.nih.gov/articles/PMC6277340/)
- Cada capa sólida delgada (muro, placa) se puede incorporar bien como:
  - una **impedancia de superficie** (si no resolvemos su espesor), o  
  - como una capa con modelo de placa acoplado (más avanzado, pero también formulable en TMM). [publications.lib.chalmers](https://publications.lib.chalmers.se/records/fulltext/183451/183451.pdf)

Para una capa fluida de espesor $\(d\)$, la matriz de propagación es:

$\[P_i = \begin{pmatrix}
\cos(k_i d) & jZ_i \sin(k_i d$) 
\\j \frac{1}{Z_i} \sin(k_i d) & \cos(k_i d)
\end{pmatrix}\]$

Esta matriz relaciona $\((p, v)\)$ (presión y velocidad) en la cara de entrada y salida de la capa. [pmc.ncbi.nlm.nih](https://pmc.ncbi.nlm.nih.gov/articles/PMC6277340/)

La **matriz total** de la fachada es el producto ordenado de las matrices de todas las capas:

$\[M_{\text{tot}} = P_5 \cdot P_4 \cdot P_3 \cdot P_2\$]

(con el aire exterior e interior considerados en las condiciones de contorno). [publications.ibpsa](https://publications.ibpsa.org/proceedings/bs/2019/papers/BS2019_211184.pdf)

Con $\(M_{\text{tot}}\)$ se obtiene el **coeficiente de transmisión** $\(T(\omega)\)$ y de ahí la **pérdida por transmisión** $STL(\(\omega\))$:

$\[
\text{STL}(\omega) = -10 \log_{10} |T(\omega)|^2
\]$

Esta STL suele compararse con el espectro típico de ruido de aeronaves, que presenta componentes relevantes entre unos 100 Hz y varios kHz, con picos alrededor de 1–1.3 kHz asociados al ruido de los fans. [faa](https://www.faa.gov/sites/faa.gov/files/about/office_org/headquarters_offices/apl/pears_to43.pdf)

## 3. Cómo se aplicaría en la práctica

Conceptualmente, el procedimiento sería:

1. Elegir una **banda de frecuencias** representativa del ruido de aeronaves (por ejemplo 50–5000 Hz, o bandas de tercio de octava centradas en $63 Hz$, $125 Hz$, $250 Hz$, ..., $4 kHz$). [productspec.co](https://productspec.co.nz/media/21ybffly/acoustic-test-report-73-university-of-canterbury.pdf)
2. Para cada frecuencia:
   - Obtener $\(k_i(\omega)\)$ y $\(Z_i(\omega)\)$ de cada capa (aire, fluido equivalente poroso, etc.). [pmc.ncbi.nlm.nih](https://pmc.ncbi.nlm.nih.gov/articles/PMC6277340/)
   - Construir y multiplicar las matrices de transferencia $P_i$ para cada capa. [publications.ibpsa](https://publications.ibpsa.org/proceedings/bs/2019/papers/BS2019_211184.pdf)
   - Calcular el coeficiente de transmisión $\(T(\omega)\)$ y derivar la STL.  
3. Superponer esa STL con el espectro de ruido de avión (en dB por banda) para ver cuánto ruido entra al interior. [faa](https://www.faa.gov/sites/faa.gov/files/about/office_org/headquarters_offices/apl/pears_to43.pdf)

Estudios y tesis aplican justamente esta combinación de TMM + modelos de materiales porosos para optimizar configuraciones de muros multicapa y dobles fachadas en edificios expuestos a tráfico o aeronaves. [sciencedirect](https://www.sciencedirect.com/science/article/abs/pii/S0360132310001204)

## 4. Interpretación física

- El **muro pesado** aporta aislamiento por “ley de masas”, especialmente en frecuencias medias–altas. [pubs.aip](https://pubs.aip.org/asa/jasa/article-abstract/128/6/3513/904212/Sound-transmission-through-finite-lightweight?redirectedFrom=fulltext)
- La **cámara de aire + lana mineral** crea una cavidad con absorción interna que reduce la energía que acopla de la placa exterior a la interior (reduce resonancias masa–aire–masa). [file.sdiarticle3](http://file.sdiarticle3.com/wp-content/uploads/2019/06/Revised-ms_AJR2P_46351_v1.pdf)
- La **placa interior** añade masa y cambios de impedancia, mejorando el aislamiento en bandas donde la fachada sencilla sería deficiente. [publications.lib.chalmers](https://publications.lib.chalmers.se/records/fulltext/183451/183451.pdf)

Con esto ya tiene un esquema conceptual completo, siendo este la base de la implementación del modelo numérico en Octave, que calcula STL de una fachada específica frente a un espectro de ruido de aeronaves.
