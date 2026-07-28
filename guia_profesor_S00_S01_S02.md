# Guía del Profesor — Sesiones S00, S01 y S02

> Documento interno. No publicar en GitHub.

## Filosofía: ejemplo cotidiano → formalización → R con datos reales

Cada concepto sigue esta secuencia:
1. **Ejemplo cotidiano Gen Z** (reel, TikTok, Spotify, matches, gaming) → captura atención, genera intuición
2. **Formalización matemática** → el slide ya tiene ambos lados
3. **Código en R con datos ICFES** → solo cuando abrimos R, motivamos la herramienta con datos reales del programa

La transición se hace explícita: *"Ya vieron cómo funciona con reels y likes. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

---

## S00 — Conceptos Fundamentales (~15 min)

### Objetivo
Establecer el lenguaje matemático del semestre. El estudiante debe salir sabiendo qué es una variable aleatoria y por qué necesitamos formalizarla.

### Slide 1-2: Título y Agenda
- Presentarse brevemente si es la primera clase.
- *"Antes de meternos con datos reales, necesitamos un vocabulario común. Esta mini-sesión les da las herramientas conceptuales que vamos a usar el resto del semestre."*

### Slide 3: Experimento aleatorio (→ reel de Instagram)
- **Abrir**: *"¿Cuántos de ustedes han subido un reel o un TikTok? Cuando le dieron 'compartir', ¿sabían cuántas views iba a tener?"*
- **Conectar**: eso es un experimento aleatorio — sabes los resultados posibles (muchas views, pocas, ninguna), pero no cuál va a ocurrir.
- **Formalizar**: leer las 3 propiedades. Preguntar: *"¿Se les ocurre otro ejemplo?"* (pedir un Rappi, entrar a una ranked de Valorant).
- **Enfatizar**: la clave es la **incertidumbre antes** de que ocurra.

### Slide 4: Espacio muestral Ω (→ views del reel)
- *"Ya sabemos que hay incertidumbre. Ahora necesitamos catalogar TODO lo que puede pasar."*
- **Dos versiones del mismo experimento**: Ω = {0, 1, 2, ...} si contamos views. Ω = {viral, no viral} si solo nos interesa eso.
- **Punto clave**: *"La definición de Ω depende de la pregunta que hacemos. Misma situación, diferentes Ω."*

### Slide 5: Evento (→ "que supere 10,000 views")
- *"Un evento es una pregunta concreta de sí/no sobre el resultado."*
- **Ejemplo**: *"¿Mi reel superó 10,000 views? Eso es el evento A. ¿Se quedó en 10K o menos? Eso es A complemento."*
- **σ-álgebra**: mencionarla como *"la colección de todas las preguntas válidas que podemos hacer"*. No detenerse mucho.

### Slide 6: Probabilidad P (→ historial de reels)
- *"Ahora queremos ponerle un número a cada evento: ¿qué tan probable es que se vuelva viral?"*
- **Axiomas como sentido común**:
  1. *"Nada tiene probabilidad negativa."*
  2. *"Algo tiene que pasar: la probabilidad total es 1."*
  3. *"Si dos cosas no pueden pasar al mismo tiempo, la probabilidad de que pase alguna es la suma."*
- **Ejemplo**: P(viral) = 0.05, P(no viral) = 0.95. *"Suman 1. Solo el 5% de tus reels se vuelven virales — suena realista, ¿no?"*
- **Cerrar**: *"Con (Ω, A, P) ya tenemos un espacio de probabilidad completo."*

### Slide 7: Variable aleatoria (→ likes en Instagram)
- **Este es el slide más importante de S00.** Tomarse el tiempo.
- *"El resultado del experimento puede ser cualquier cosa — 'la gente reaccionó', 'se hizo viral'. Pero para hacer estadística necesitamos NÚMEROS."*
- **Definición**: *"X es una función que toma un resultado del experimento y le asigna un número real. Es el puente entre el fenómeno y las matemáticas."*
- **Ejemplo**: X = número de likes. *"Antes teníamos una sensación ('fue bien', 'fue mal'). Ahora tenemos 47, 230, 1500. Y con números podemos calcular promedios, varianzas, hacer predicciones..."*
- **Medibilidad**: mencionarla brevemente — *"Esta condición técnica garantiza que podemos calcular probabilidades. No la vamos a demostrar, pero sepan que existe."*

### Slide 8: Tipos de VA (→ matches, TikTok, Rappi)
- **Regla rápida**: *"¿Se puede contar? → discreta. ¿Se mide? → continua."*
- **Discretas**: *"Número de matches en Bumble esta semana — 0, 1, 2, 3. Kills en una partida de Valorant."*
- **Continuas**: *"Horas que pasas hoy en TikTok — 0.5, 1.3, 2.7... Tiempo que tarda el Rappi."*
- **Consecuencia**: *"Con discretas sumamos, con continuas integramos."*

### Slide 9: Distribución (→ likes por foto, screen time)
- *"La distribución describe el patrón — con qué frecuencia toma cada valor."*
- **pmf (discreta)**: mostrar la tabla de likes. *"El 40% de tus fotos recibe ~150 likes, el 30% recibe ~200. Eso es toda la distribución."*
- **pdf (continua)**: *"Para el screen time no podemos hacer tabla porque hay infinitos valores. En vez de eso, tenemos una curva. El área bajo la curva entre dos puntos da la probabilidad."*

### Slide 10: Valor esperado E[X] (→ Spotify Wrapped)
- *"Si repitieras el experimento todos los días del año, ¿cuál sería el promedio?"*
- **Spotify Wrapped**: *"Tu Wrapped dice que escuchas en promedio 85 minutos de música al día. Eso es E[X]. Sumas los 365 días, divides entre 365, y te da ~85."*
- **Metáfora**: *"E[X] es el centro de gravedad de la distribución."*

### Slide 11: Varianza Var(X) (→ Spotify estable vs binge)
- *"El valor esperado te dice el centro, pero no qué tan dispersos están los resultados."*
- **Contraste**: *"Días estables: escuchas ~60 min. Varianza baja. Días de binge listening: 20 min un día, 200 otro. Varianza alta. Los dos pueden promediar 85, pero la experiencia es MUY diferente."*
- *"La varianza mide qué tan impredecible es el resultado."*

### Slide 12: Resumen (diagrama de flujo)
- Recorrer el diagrama TikZ. *"Este es el mapa del territorio. Todo lo que veremos este semestre se construye sobre estos 8 conceptos."*

### Slide 13: Cierre
- *"¿Preguntas? ... Ahora que tenemos el lenguaje, vamos a usarlo con datos reales en la Sesión 1."*

---

## S01 — Estadística Descriptiva Numérica (~1.5 h)

### Objetivo
Calcular e interpretar medidas numéricas (centro, dispersión, forma, posición). Los conceptos se ilustran con ejemplos Gen Z; R se aplica a datos ICFES reales.

### Bloque 1: Introducción al curso (slides 3-10, ~20 min)

**Estos slides ya usan contexto ICFES — mantenerlos como están.**

- **Slide 3 (¿Qué es la estadística?)**: *"Descriptiva = lo que ya tenemos. Inferencial = lo que no observamos."*
- **Slide 4-5 (ICFES)**: explicar Saber 11 y Saber Pro. *"Datos reales de estudiantes de NI."*
- **Slide 6 (MOD_INGLES_PUNT)**: *"Para NI, el inglés es competitividad internacional. Esta variable será nuestro hilo conductor."*
- **Slide 7 (Preguntas)**: *"Hoy respondemos las preguntas 1 a 3."*
- **Slides 8-10 (R/RStudio)**: demo en vivo si es primera vez con R.
- **Slides 11-13 (Tipos de datos)**: *"¿MOD_INGLES_PUNT es categórica o cuantitativa?"*

### Bloque 2: Medidas de tendencia central (slides 14-23, ~25 min)

#### Media aritmética
- **Concepto** (→ screen time): *"El promedio de screen time de 5 amigos: 5h, 7h, 4h, 8h, 6h → x̄ = 6h."*
- **Ejemplo** (→ Spotify): minutos de música en 5 días: 45, 60, 55, 70, 50 → x̄ = 56 min.
- **R** (→ ICFES): `mean(icfes$MOD_INGLES_PUNT)`. *"Ahora calculamos lo mismo pero con miles de estudiantes reales."*
- **Propiedad clave**: sensible a outliers. *"Un solo millonario cambia el ingreso promedio del salón."*

#### Media ponderada
- **Ejemplo** (→ Spotify Wrapped): top 3 artistas con diferente % de escucha. El rating ponderado refleja tus hábitos reales.

#### Mediana
- **Concepto** (→ seguidores en Instagram): ordenar amigos por seguidores, el del medio es la mediana.
- **Outlier** (→ amigo viral): *"Tus amigos tienen 280, 310, 350, 400 seguidores... pero uno tiene 50,000 porque se hizo viral. La media sube a locura, pero la mediana ni se entera."*
- **R** (→ ICFES): `median()`. Comparar con mean.

#### Moda
- *"La canción más escuchada de tu playlist este mes = la moda."*
- *"Es la única medida que funciona para categorías."*

#### ¿Cuándo usar cada medida?
- *"Distribución de likes en TikTok: muchos posts con pocos likes, pocos virales → sesgada a la derecha → moda < mediana < media."*

### Bloque 3: Medidas de dispersión (slides 24-33, ~20 min)

#### Rango e IQR
- **Rango** (→ screen time): *"El de menos screen time: 2h, el de más: 9h → rango = 7h. Pero si un amigo dejó el cel en casa (0h), el rango salta a 9h."*
- **IQR** (→ screen time): *"Q1 = 3h, Q3 = 7h, IQR = 4h. Outlier si > 13h — ¿quién se clava 13 horas?"*

#### Varianza y desviación estándar
- **Concepto** (→ Spotify streams): *"Un artista con streams diarios estables → poca varianza. Un artista que tuvo un hit viral un día y nada al siguiente → mucha varianza."*
- **Desviación estándar** (→ screen time): *"Si s = 1.5h, tus amigos se desvían en promedio 1.5h del screen time medio."*
- **R** (→ ICFES): `var()`, `sd()`. *"Ahora con datos reales."*

#### Coeficiente de variación
- Mantener como está — la comparación entre escalas es universal.

### Bloque 4: Forma de la distribución (slides 34-43, ~15 min)

#### Z-scores
- **Concepto** (→ screen time): *"Tu screen time es 8h, tus amigos promedian 5h con s = 1.2h. z = (8-5)/1.2 = 2.5. Estás 2.5 desviaciones por encima. Eres un outlier de celular."*
- **R**: mantener con ICFES.

#### Chebyshev y regla empírica
- Mantener formal. Estos son teoremas universales.

#### Asimetría
- *"Distribución de likes: la mayoría recibe pocos, unos pocos se hacen virales → cola a la derecha → asimetría positiva."*

#### Outliers
- *"Ese post que se hizo viral con 50K likes cuando normalmente recibes 200. ¿Es un error? No, es un fenómeno real. Pero HAY que investigarlo."*

### Bloque 5: Percentiles y cuartiles (slides 44-49, ~10 min)

- **Percentil** (→ Spotify Wrapped): *"Spotify te dice 'estás en el top 1% de oyentes de Bad Bunny'. Eso es el percentil 99."*
- **Five-number summary**: mantener formal.
- **R** (→ ICFES): `quantile()`, `summary()`.

### Bloque 6: Aplicación ICFES (slides 50-58, ~15 min)

**Todo este bloque es R con datos reales. No cambiar nada.**

- Demo en vivo si hay tiempo.
- *"Miren los números. ¿La media es mayor que la mediana? ¿Qué nos dice?"*

### Slides 57-58: Resumen y próxima sesión
- Recapitular. *"Instalen ggplot2, dplyr, corrplot, GGally."*

---

## S02 — Estadística Descriptiva Gráfica, Correlación y EDA (~1.5 h)

### Objetivo
Visualizar datos, calcular correlaciones, entender la Paradoja de Simpson, ejecutar un pipeline EDA. Conceptos con ejemplos Gen Z, R con ICFES.

### Bloque 1: Distribuciones de frecuencia (slides 3-8, ~10 min)

- **Definición** (→ TikTok): *"Si encuestan a 30 compañeros sobre cuántas horas de TikTok ven al día, la tabla de frecuencias organiza esas respuestas."*
- **Tabla ejemplo**: la misma lógica aplicada al screen time del salón.
- **R** (→ ICFES): `table()`, `cut()`. No cambiar código.

### Bloque 2: Visualización de una variable (slides 9-19, ~20 min)

#### Histograma
- *"Imaginen un histograma del screen time diario de todos en el salón. ¿Dónde está el pico? ¿Hay alguien con 12 horas?"*
- **R**: `geom_histogram()` con datos ICFES.
- *"¿Qué forma tiene? ¿Simétrica? ¿Sesgada?"*

#### Box plot
- **Concepto** (→ TikTok y sueño): *"Comparen horas de sueño entre quienes usan TikTok antes de dormir vs los que no. El box plot lo muestra de un vistazo."*
- **R**: box plot comparativo por tipo de IES, por estrato.
- *"¿Las cajas se superponen? ¿Los puntajes aumentan con el estrato?"*

#### Buenas prácticas
- *"Nada de gráficos 3D. Nada de gráficos de pastel con 15 categorías. Esos gráficos engañosos que ven en Twitter/X con ejes manipulados — eso es deshonestidad visual."*
- *"Si yo les veo un gráfico sin título ni ejes en un problem set, les reboto."*

### Bloque 3: Visualización de dos variables (slides 21-29, ~15 min)

#### Scatter plot
- **Concepto** (→ estudio vs nota): *"Horas de estudio vs nota del parcial. Cada punto es un compañero del salón."*
- **R**: scatter plot Saber 11 vs Saber Pro. *"¿Ven una tendencia?"*
- **Colorear por grupo**: *"¿La relación cambia según el tipo de IES?"* (anticipo de Simpson).

#### Heatmap y barras
- **R** con datos ICFES. *"¿Cuáles departamentos tienen mejores puntajes?"*
- *"`dodge` compara magnitudes, `fill` compara composición."*

### Bloque 4: Covarianza y correlación (slides 31-41, ~20 min)

#### Covarianza
- **Concepto** (→ Instagram): *"Los likes y comentarios en un post de Instagram tienden a subir juntos. Cuando x sube, y también sube → covarianza positiva."*
- **Limitación**: la magnitud depende de las unidades. *"Necesitamos estandarizar → correlación."*

#### Correlación de Pearson
- **Interpretación** (→ estudio vs nota): *"r = 0.8 entre horas de estudio y nota del parcial: relación fuerte positiva."*
- **R**: `cor()` con datos ICFES.

#### Advertencias
- Tres advertencias con énfasis:
  1. *"Solo mide relaciones LINEALES."*
  2. *"CORRELACIÓN NO ES CAUSALIDAD. La correlación entre consumo de café y buenas notas es alta, pero la variable confusora es que los que toman más café también estudian más horas."*
  3. *"Un solo outlier puede alterar r completamente."*

#### Correlación de Spearman
- **Concepto** (→ Rappi): *"Rating de un restaurante en Rappi (1-5 estrellas, ordinal) vs precio del plato. Spearman es más apropiado porque el rating es ordinal."*
- **R**: comparar Pearson vs Spearman con datos ICFES.

### Bloque 5: Paradoja de Simpson (slides 42-47, ~15 min)

**Bloque más importante de S02. Tomarse el tiempo.**

#### Definición
- *"La Paradoja de Simpson es una de las trampas más peligrosas. Una tendencia que ves en datos agregados puede INVERTIRSE en los subgrupos."*
- **Ejemplo delivery** (→ apps): *"Una app de delivery puede tener mejor rating agregado que otra, pero peor rating en CADA categoría individual (comida, rapidez, empaque). ¿Cómo? Porque la primera tiene más pedidos en la categoría que naturalmente puntúa más alto."*

#### Berkeley 1973
- Contar la historia completa. Es poderosa — no necesita actualización Gen Z.
- *"Parece discriminación de género. Pero al desagregar por departamento, la tendencia se invierte."*
- **Variable confusora**: competitividad del departamento.

#### ICFES
- Correlación agregada vs desagregada por tipo de IES.
- *"Las líneas de grupo pueden ir en otra dirección que la línea agregada."*

#### Por qué regresión múltiple
- *"La Paradoja de Simpson es la razón más poderosa por la que necesitamos regresión múltiple."*

### Bloque 6: Pipeline EDA (slides 47-55, ~10 min)

#### Flujo de trabajo
- *"El EDA es como cuando stalkean un perfil de Instagram: primero ven el feed general, luego las fotos, luego los comments, luego los tagged... Van profundizando."*
- Recorrer los 8 pasos.

#### Demo en vivo
- R con datos ICFES. Cargar → resumir → graficar → segmentar.

#### Checklist
- *"Antes de entregar un problem set, pasen por esta lista."*

### Slides 56-57: Resumen
- 4 mensajes clave:
  1. Visualizar siempre antes de resumir numéricamente.
  2. Correlación ≠ causalidad.
  3. Explorar subgrupos antes de agregar.
  4. El EDA es iterativo, no lineal.

---

## Notas generales de presentación

- **Ritmo**: S00 es rápida (~15 min). S01 y S02 son densas (~1.5 h). Ajustar según preguntas.
- **Regla dual**: ejemplo cotidiano para el concepto → datos ICFES solo cuando abrimos R. Hacer la transición explícita cada vez: *"Ya vieron cómo funciona con [reels/likes/Spotify]. Ahora con datos reales en R."*
- **Variedad de ejemplos**: cada concepto usa un ejemplo diferente de su vida (Instagram, TikTok, Spotify, Rappi, gaming, apps de citas). Evitar repetir el mismo ejemplo en slides consecutivos.
- **Demos en R**: al menos una demo en vivo por sesión. Los datos son ICFES, no los ejemplos cotidianos.
- **Participación**: hacer preguntas directas al grupo cada ~10 min. Las preguntas están entre comillas arriba.
- **Tono**: estos ejemplos deben sentirse naturales, no forzados. Si un ejemplo no conecta con el grupo, improvisar con algo que sí les resuene.
- **No condescender**: el ejemplo cotidiano es un ANCLA para la intuición, no un sustituto de la matemática. La formalización se mantiene intacta — el ejemplo ayuda a entenderla, no a evitarla.
