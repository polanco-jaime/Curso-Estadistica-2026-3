# Guia del Profesor -- Sesiones S03 a S08

> Documento interno. No publicar en GitHub.

## Filosofia: ejemplo cotidiano -> formalizacion -> R con datos reales

Cada concepto sigue esta secuencia:
1. **Ejemplo cotidiano Gen Z** (screen time, TikTok, Spotify, Netflix, apps, gaming) -> captura atencion, genera intuicion
2. **Formalizacion matematica** -> el slide ya tiene ambos lados
3. **Codigo en R con datos ICFES** -> solo cuando abrimos R, motivamos la herramienta con datos reales del programa

La transicion se hace explicita: *"Ya vieron como funciona con [ejemplo]. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

---

## S03 -- Probabilidad, Distribucion Normal y Muestreo (~1.5 h)

### Objetivo
El estudiante debe entender variables aleatorias como funciones formales, dominar la distribucion normal y sus calculos de probabilidad, conocer las distribuciones chi-cuadrado, t y F como herramientas derivadas, y comprender el muestreo, la distribucion muestral de X-barra y el Teorema Central del Limite como fundamento de toda la inferencia.

### Slide 1-2: Titulo y Agenda
- Presentarse si es necesario.
- *"Hoy empezamos con la columna vertebral de la estadistica: la distribucion normal y el muestreo. Todo lo que veamos de aqui en adelante se apoya en estos conceptos."*

---

### Seccion 1: Variables aleatorias

### Slide 3: Variable aleatoria (-> screen time, puntaje Saber Pro)
- **Abrir**: *"Piensen en cuantas horas de screen time tuvieron ayer. Cada uno tiene un numero diferente. Eso es exactamente una variable aleatoria: una funcion que le asigna un valor numerico a cada resultado."*
- **Conectar**: X = puntaje de ingles en Saber Pro (entre 0 y 200), Y = numero de aprobados, Z = horas de screen time. Todos son ejemplos de la misma idea.
- **Formalizar**: notacion mayusculas para la variable (X, Y, Z), minusculas para valores especificos (x, y, z). Tipos: discreta (contable) vs continua (cualquier valor en un intervalo).
- **Cerrar**: *"Ya vimos esto informalmente en S00 con likes y reels. Ahora lo formalizamos con la notacion que vamos a usar todo el semestre."*

### Slide 4: Funcion de probabilidad (variable discreta)
- **Abrir**: *"Si tiran un dado, cada cara tiene probabilidad 1/6. Esa tablita de valores y probabilidades es la funcion de probabilidad."*
- **Conectar**: pmf = P(X = x). Propiedades: todas entre 0 y 1, suman 1.
- **Formalizar**: enfatizar las dos propiedades formales.
- **Cerrar**: *"Esto funciona cuando podemos listar los valores. Pero para variables como el screen time, que puede ser 4.372 horas, necesitamos otra herramienta."*

### Slide 5: Funcion de densidad (variable continua)
- **Abrir**: *"Para continuas ya no preguntamos P(X = 4.372) porque eso siempre es cero. En cambio preguntamos P(4 <= X <= 5) -- el area bajo la curva."*
- **Conectar**: f(x) >= 0, integra a 1, probabilidades como areas.
- **Formalizar**: enfatizar que P(X = x) = 0 para continuas. Solo tiene sentido calcular P(a <= X <= b).
- **Cerrar**: *"Con esto tenemos el marco para las dos grandes familias. Ahora necesitamos resumir una distribucion con dos numeros: el centro y la dispersion."*

### Slide 6: Valor esperado y varianza
- **Abrir**: *"El valor esperado es el promedio a largo plazo. Si miden su screen time todos los dias del ano y promedian, eso es E(X)."*
- **Conectar**: E(X) = mu es el centro. Var(X) = sigma^2 mide la dispersion. sigma es la desviacion estandar.
- **Formalizar**: formulas para discreta (sumatoria) y continua (integral). Varianza como E[(X-mu)^2].
- **Cerrar**: *"Estos son parametros POBLACIONALES. Fijos pero desconocidos. Lo que calculamos con datos son ESTADISTICOS muestrales."*

### Slide 7: Parametros vs estadisticos (-> screen time como VA)
- **Abrir**: *"mu y sigma describen a TODA la poblacion. x-barra y s son lo que calculamos con nuestra muestra. Son diferentes cosas."*
- **Conectar**: puntaje de ingles Saber Pro como variable aleatoria continua. Screen time diario como otra VA continua.
- **Formalizar**: P(X <= 150) = proporcion con puntaje <= 150. P(160 <= X <= 180) = proporcion entre 160 y 180.
- **Cerrar**: *"La pregunta clave es: cual es la distribucion de X? Eso determina como calculamos probabilidades. Y la distribucion mas importante es..."*

### Slide 8: Parametros vs estadisticos (cont.)
- **Abrir**: *"Si tengo toda la poblacion, calculo mu y sigma directamente. Si solo tengo muestra, estimo con x-barra y s."*
- **Formalizar**: relacion con estadistica descriptiva. Pregunta clave: cual es la distribucion de X?
- **Cerrar**: *"Vamos a responder esa pregunta con la distribucion mas importante de toda la estadistica."*

---

### Seccion 2: Distribucion normal

### Slide 9: La distribucion normal (-> definicion formal)
- **Abrir**: *"La normal, la gaussiana, la campana de Gauss -- tiene muchos nombres porque aparece en TODAS partes."*
- **Conectar**: funcion de densidad con mu y sigma. Notacion X ~ N(mu, sigma^2).
- **Formalizar**: la formula de la densidad. Enfatizar que esta completamente determinada por dos parametros: mu (centro) y sigma (dispersion).
- **Cerrar**: *"La formula es intimidante, pero lo unico que necesitan saber es que con mu y sigma se calcula TODO."*

### Slide 10: La distribucion normal: ejemplo e intuicion (-> screen time)
- **Abrir**: *"El screen time diario de los estudiantes del salon sigue aproximadamente una campana: la mayoria usa el celular entre 4 y 6 horas, y muy pocos estan en los extremos -- menos de 1 hora o mas de 9 horas."*
- **Conectar**: la normal es simetrica, con la mayoria de los datos cerca del centro. Los extremos son raros.
- **Formalizar**: conociendo mu y sigma, podemos calcular cualquier probabilidad.
- **Cerrar**: *"Ahora veamos las propiedades que hacen tan util esta distribucion."*

### Slide 11: Propiedades de la distribucion normal (-> regla 68-95-99.7)
- **Abrir**: *"La regla mas util de la normal: 68% de los datos estan a 1 sigma del centro, 95% a 2 sigma, 99.7% a 3 sigma."*
- **Conectar**: si mu = 5h de screen time y sigma = 1h, el 95% de tus companeros tiene entre 3h y 7h.
- **Formalizar**: 7 propiedades. Enfatizar forma de campana, simetria, media = mediana = moda, asintotas, puntos de inflexion.
- **Cerrar**: *"Pero cada normal tiene sus propios mu y sigma. Para comparar necesitamos estandarizar."*

### Slide 12: Distribucion normal estandar (-> comparar puntaje Saber Pro vs seguidores Instagram)
- **Abrir**: *"La normal estandar es la normal con mu=0 y sigma=1. Es la 'regla universal' para comparar cualquier cosa con cualquier cosa."*
- **Conectar**: Z = (X - mu)/sigma. *"Tu puntaje Saber Pro vs tu numero de seguidores en Instagram estan en escalas diferentes. La estandarizacion los pone en la misma escala."*
- **Formalizar**: f(z), tabla Z, simplificacion de calculos.
- **Cerrar**: *"Con esto ya podemos calcular probabilidades."*

### Slide 13: Calculo de probabilidades con la normal
- **Abrir**: *"Tres tipos de preguntas: menor que, mayor que, y entre dos valores."*
- **Formalizar**: procedimiento general: identificar mu y sigma, estandarizar, buscar en tabla o software.
- **Cerrar**: *"Vamos a verlo con un ejemplo concreto."*

### Slide 14: Ejemplo probabilidades con puntaje de ingles
- **Abrir**: *"X = puntaje de ingles Saber Pro ~ N(155, 20^2). Que proporcion tiene puntaje <= 150?"*
- **Formalizar**: estandarizar, calcular P(Z <= -0.25) = 0.4013. Aproximadamente 40% obtiene <= 150.
- **Cerrar**: *"Hagamos el caso de 'que proporcion supera 170'."*

### Slide 15: Ejemplo probabilidad en un intervalo
- **Abrir**: *"Que proporcion obtiene entre 145 y 165?"*
- **Formalizar**: P(145 <= X <= 165) = P(X <= 165) - P(X <= 145) = 0.3830.
- **Cerrar**: *"Y si quiero el problema al reves -- dado un porcentaje, encontrar el puntaje?"*

### Slide 16: Encontrar cuantiles (-> percentil 75)
- **Abrir**: *"Spotify te dice 'estas en el top 25% de oyentes de Bad Bunny'. Eso es el percentil 75. Ahora hagamos lo mismo con puntajes."*
- **Formalizar**: problema inverso. Encontrar x tal que P(X <= x) = 0.75. Usar tabla Z inversa: z = 0.674, x = 155 + 0.674(20) = 168.48.
- **Cerrar**: *"En R esto se hace con una sola funcion."*

### Slide 17-18: Funciones de la normal en R
*[Frames de codigo R -- transicionar con la frase habitual]*

*"Ya vieron como funciona con probabilidades de puntajes. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

### Slide 19: rnorm() generar valores aleatorios normales
*[Frame de codigo R -- transicionar con la frase habitual]*

### Slide 20-21: Comparar datos reales con curva normal
*[Frames de codigo R -- transicionar con la frase habitual]*

*"Atencion al shapiro.test() -- les dice si sus datos se parecen a una normal. Eso lo van a usar mucho."*

---

### Seccion 3: Distribuciones chi-cuadrado, t y F

### Slide 22: Distribucion chi-cuadrado
- **Abrir**: *"La chi-cuadrado aparece cuando elevamos al cuadrado variables normales estandar. Suena raro, pero la necesitamos para inferencia sobre varianzas."*
- **Conectar**: definicion como suma de Z^2. Propiedades: solo positivos, sesgada, E = k, Var = 2k.
- **Formalizar**: usos principales: inferencia sobre varianzas, bondad de ajuste, tablas de contingencia.
- **Cerrar**: *"No necesitan memorizar la formula. Solo entender CUANDO aparece."*

### Slide 23-24: Distribucion chi-cuadrado en R
*[Frames de codigo R -- transicionar con la frase habitual]*

### Slide 25: Distribucion t de Student
- **Abrir**: *"Cuando no conocemos sigma (que es casi siempre), usamos s. Eso introduce incertidumbre extra, y la distribucion t la captura."*
- **Conectar**: colas mas pesadas que la normal. Para n >= 30, se parece mucho a la normal.
- **Formalizar**: estadistico t = (X-barra - mu)/(s/sqrt(n)) ~ t(n-1). IC y pruebas de hipotesis para medias.
- **Cerrar**: *"Vamos a ver de donde viene historicamente."*

### Slide 26: De donde viene la distribucion t
- **Abrir**: *"En 1908, un tipo llamado William Gosset trabajaba en la cerveceria Guinness. No podia publicar con su nombre real, asi que uso el seudonimo 'Student'. Descubrio que reemplazar sigma por s cambia la distribucion."*
- **Formalizar**: si conocemos sigma, usamos Z. Si estimamos sigma con s, usamos t. La t tiene colas mas pesadas para reflejar la incertidumbre adicional.
- **Cerrar**: *"Veamos la diferencia con un ejemplo concreto."*

### Slide 27: Distribucion t: muestra pequena vs grande (-> Netflix con amigos)
- **Abrir**: *"Si le preguntas a 5 amigos cuantas horas de Netflix ven, la variabilidad es alta y usas t. Si encuestas a 200 estudiantes, s se acerca a sigma y la t se parece a la normal."*
- **Conectar**: muestra pequena -> colas pesadas -> intervalos mas anchos. Muestra grande -> se parece a Z.
- **Formalizar**: por eso usamos t en lugar de Z cuando estimamos sigma con s.
- **Cerrar**: *"Veamos en R como se comparan."*

### Slide 28-29: Distribucion t en R
*[Frames de codigo R -- transicionar con la frase habitual]*

### Slide 30: Distribucion F de Fisher
- **Abrir**: *"La F aparece cuando comparamos dos varianzas. Piensen: la variabilidad del puntaje de ingles es diferente entre IES publicas y privadas?"*
- **Conectar**: razon de dos chi-cuadrado. Usos: comparar varianzas, ANOVA, significancia global en regresion.
- **Formalizar**: solo valores positivos, asimetrica, depende de dos parametros de gl.
- **Cerrar**: *"La F la van a ver mucho en las proximas sesiones con ANOVA y regresion."*

### Slide 31-32: Distribucion F en R
*[Frames de codigo R -- transicionar con la frase habitual]*

---

### Seccion 4: Muestreo y distribucion muestral de X-barra

### Slide 33: Poblacion vs muestra
- **Abrir**: *"Poblacion = TODOS los estudiantes de NI en Colombia. Muestra = los 500 que pudimos encuestar. El objetivo es usar la muestra para aprender sobre la poblacion."*
- **Conectar**: parametros (mu, sigma, p) son de la poblacion. Estadisticos (x-barra, s, p-hat) son de la muestra.
- **Formalizar**: N = tamano poblacional, n = tamano muestral. Objetivo de la inferencia: usar estadisticos para aprender sobre parametros.
- **Cerrar**: *"La pregunta es: que tan buena puede ser una muestra?"*

### Slide 34: Poblacion vs muestra: ejemplo (-> Netflix y la universidad)
- **Abrir**: *"Es como hacer una encuesta a 30 companeros del salon sobre cuantas horas de Netflix ven al mes, en lugar de preguntarle a toda la universidad."*
- **Conectar**: poblacion = todos los estudiantes de NI (~50,000). Muestra = 500 seleccionados aleatoriamente. Estimamos mu con x-barra.
- **Formalizar**: diagrama muestreo -> inferencia. Mostrar el flujo en la grafica TikZ.
- **Cerrar**: *"Para que funcione, el muestreo tiene que ser aleatorio."*

### Slide 35: Muestreo aleatorio simple (MAS)
- **Abrir**: *"Cada elemento de la poblacion tiene la misma probabilidad de ser seleccionado. Es como una rifa justa."*
- **Conectar**: supuestos clave: observaciones independientes, misma distribucion. Notacion: X_1, ..., X_n iid.
- **Formalizar**: evita sesgos, permite generalizar, fundamento de la inferencia.
- **Cerrar**: *"Pero que pasa si no hacemos MAS?"*

### Slide 36: Muestreo aleatorio simple: ejemplo (-> TikTok y sesgo de seleccion)
- **Abrir**: *"Quieres saber cuantas horas semanales dedican los javerianos a TikTok. Si solo encuestas a tus amigos cercanos, el resultado no representa a toda la universidad. Eso es sesgo de seleccion."*
- **Conectar**: el MAS evita ese problema. En la practica, MAS perfecto es dificil, pero es el punto de partida teorico.
- **Formalizar**: en la practica a veces se usan otros metodos (estratificado, conglomerados), pero MAS es la base.
- **Cerrar**: *"Ahora la pregunta central: si tomo muchas muestras diferentes, como se comporta x-barra?"*

### Slide 37: Distribucion muestral de X-barra
- **Abrir**: *"Esto es FUNDAMENTAL. Si pudieramos tomar mil muestras diferentes de 100 estudiantes, cada una daria un x-barra diferente. La distribucion de esos mil x-barra es la distribucion muestral."*
- **Conectar**: experimento mental: tomar muestra -> calcular x-barra -> devolver -> repetir infinitamente.
- **Formalizar**: E(X-barra) = mu (insesgado), Var(X-barra) = sigma^2/n, SE(X-barra) = sigma/sqrt(n).
- **Cerrar**: *"El error estandar es la clave de toda la inferencia."*

### Slide 38: Interpretacion del error estandar (-> screen time y precision)
- **Abrir**: *"Si sigma = 20 puntos y n = 100, SE = 20/10 = 2 puntos. La media muestral tipicamente difiere de mu en unos 2 puntos."*
- **Conectar**: *"Encuestar a 100 companeros sobre su screen time da una estimacion bastante precisa del promedio de toda la universidad."*
- **Formalizar**: tres mensajes clave: X-barra menos variable que X; SE disminuye con sqrt(n), no con n; para reducir SE a la mitad necesitas 4 veces mas observaciones.
- **Cerrar**: *"Ahora viene el teorema mas importante del curso."*

---

### Seccion 5: Teorema Central del Limite

### Slide 39: Teorema Central del Limite (TCL)
- **Abrir**: *"El TCL dice que NO IMPORTA como se vea la distribucion original -- sesgada, bimodal, rara -- si promedias suficientes observaciones, el resultado es normal."*
- **Conectar**: para n grande, X-barra ~ N(mu, sigma^2/n).
- **Formalizar**: Z = (X-barra - mu)/(sigma/sqrt(n)) ~ N(0,1) aprox. Dos mensajes clave: no importa la forma original, para n grande X-barra es aprox normal.
- **Cerrar**: *"Suena abstracto. Veamos un ejemplo."*

### Slide 40: TCL ejemplo con TikTok (-> sesiones de TikTok)
- **Abrir**: *"El tiempo por sesion de TikTok NO es normal: muchas sesiones cortas, pocas muy largas. Pero si promedias el tiempo de 30 sesiones y repites muchas veces, esos promedios si forman una campana. Eso es el TCL."*
- **Conectar**: no importa que la distribucion individual sea rara. Al promediar muchas observaciones, converge a campana.
- **Formalizar**: intuicion: los extremos se cancelan al promediar.
- **Cerrar**: *"La pregunta practica es: cuantas observaciones son 'suficientes'?"*

### Slide 41: TCL: cuando es n suficientemente grande?
- **Abrir**: *"Depende de que tan 'rara' sea la poblacion. Si ya es normal, cualquier n sirve. Si es muy sesgada, puedes necesitar n >= 50."*
- **Formalizar**: tabla con reglas practicas: normal -> cualquier n, simetrica -> ~15, moderadamente sesgada -> ~30, muy sesgada -> >= 50.
- **Cerrar**: *"La regla practica general: n >= 30."*

### Slide 42: Por que el TCL es tan importante?
- **Abrir**: *"Este es EL teorema mas importante de la estadistica. Punto. Sin el, nada de lo que viene despues funciona."*
- **Conectar**: fundamento de la inferencia (ICs, pruebas de hipotesis, tamano de muestra). Universalidad (aplica a cualquier poblacion). Justifica el uso de la normal.
- **Formalizar**: permite aproximaciones: Binomial -> Normal, Poisson -> Normal.
- **Cerrar**: *"Veamos como se usa en la vida real."*

### Slide 43: El TCL en la vida real (-> Spotify y YouTube)
- **Abrir**: *"Los algoritmos de recomendacion de Spotify y YouTube promedian miles de interacciones de usuarios. Gracias al TCL, esos promedios se comportan como normales, lo que les permite calcular intervalos de confianza y tomar decisiones."*
- **Conectar**: sin el TCL, la inferencia seria muchisimo mas complicada.
- **Formalizar**: recapitular: conociendo la distribucion de X-barra, podemos construir ICs, hacer pruebas de hipotesis, calcular tamanos de muestra.
- **Cerrar**: *"Ahora vamos a comprobar todo esto con simulaciones en R."*

### Slide 44-55: Simulacion del TCL en R (pasos 1 a 4, comparacion SE)
*[Frames de codigo R -- transicionar con la frase habitual]*

*"Ya vieron como funciona con sesiones de TikTok. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

**Puntos clave durante las demos:**
- Paso 1: *"Miren como la distribucion poblacional de Saber 11 Ingles NO es normal -- sesgada a la derecha."*
- Paso 2: *"Tomamos 2000 muestras de n=30. La media de las medias esta cerca de mu. El SE simulado esta cerca de sigma/sqrt(n). El TCL funciona."*
- Paso 3: *"El histograma de medias muestrales ES normal, aunque la poblacion no lo era. Esto es el TCL en accion."*
- Paso 4: *"A mayor n, la distribucion es mas concentrada y mas normal."*

---

### Seccion 6: Propiedades de estimadores

### Slide 56: Que es un estimador? (-> screen time y Duolingo)
- **Abrir**: *"Un estimador es una formula para adivinar un parametro desconocido. X-barra para estimar mu, s^2 para estimar sigma^2, p-hat para estimar p."*
- **Conectar**: promedio de screen time de 50 companeros, proporcion que usa Duolingo.
- **Formalizar**: notacion theta (parametro), theta-hat (estimador), theta-hat = valor numerico (estimacion).
- **Cerrar**: *"Pero no cualquier formula es buena. Como sabemos si un estimador es 'bueno'?"*

### Slide 57: Propiedad 1: Insesgamiento
- **Abrir**: *"Un estimador es insesgado si EN PROMEDIO acierta al valor verdadero. No en cada muestra, sino a largo plazo."*
- **Formalizar**: E(theta-hat) = theta. X-barra es insesgado para mu. s^2 con n-1 es insesgado para sigma^2. Con n en el denominador seria sesgado (por eso usamos n-1).
- **Cerrar**: *"Ser insesgado no garantiza precision individual, pero si 'en promedio'."*

### Slide 58: Propiedad 2: Eficiencia
- **Abrir**: *"Entre dos estimadores que aciertan en promedio, preferimos el que varia menos."*
- **Formalizar**: menor varianza = estimaciones mas consistentes entre muestras = ICs mas estrechos. X-barra es mas eficiente que la mediana para normales.
- **Cerrar**: *"Y la tercera propiedad es la mas intuitiva."*

### Slide 59: Propiedad 3: Consistencia
- **Abrir**: *"Con mas datos, el estimador se acerca al valor verdadero. Obvious, pero hay que demostrarlo formalmente."*
- **Formalizar**: theta-hat converge en probabilidad a theta cuando n -> infinito. Condicion suficiente: E -> theta y Var -> 0.
- **Cerrar**: *"Todos los estimadores comunes que usamos son consistentes."*

### Slide 60: Resumen propiedades de estimadores
- **Abrir**: *"Tres propiedades: insesgado (acierta en promedio), eficiente (varia poco), consistente (mejora con mas datos)."*
- **Formalizar**: tabla resumen con ejemplos. Mencionar trade-off sesgo-varianza: un estimador ligeramente sesgado puede tener menor varianza (ej: regresion ridge).
- **Cerrar**: *"En este curso usamos estimadores insesgados."*

---

### Seccion 7: Resumen y conexion

### Slide 61: Resumen de la sesion
- Recapitular los 6 temas. Enfatizar: *"El TCL + la normal = fundamento de la inferencia."*

### Slide 62: La distribucion normal + TCL = fundamento de la inferencia
- **Abrir**: *"Recapitulemos la logica completa: muchas variables son normales o aprox normales. Incluso cuando no lo son, X-barra si lo es (TCL). Conociendo la distribucion de X-barra, podemos construir ICs, hacer pruebas de hipotesis, calcular tamanos de muestra."*
- **Formalizar**: sin el TCL, necesitariamos conocer la distribucion poblacional exacta.
- **Cerrar**: *"En la proxima sesion usamos esto para construir intervalos de confianza."*

### Slide 63: Proxima sesion
- *"Repasen qnorm(), qt(), pnorm(), pt(). Asegurense de entender el error estandar y el TCL. La proxima sesion es la aplicacion directa de todo lo de hoy."*

---

## S04 -- Estimacion Puntual e Intervalos de Confianza (~1.5 h)

### Objetivo
El estudiante debe entender la diferencia entre estimacion puntual e intervalo de confianza, construir e interpretar ICs para la media (con sigma conocida y desconocida) y para la varianza, y visualizar comparaciones entre grupos usando forest plots.

### Slide 1-2: Titulo y Agenda
- *"Hoy damos el salto de 'tengo un numero' a 'tengo un rango que probablemente contiene la verdad'. Eso es pasar de estimacion puntual a intervalos de confianza."*

---

### Seccion 1: Estimacion Puntual

### Slide 3: Parametros vs Estadisticos: Repaso
- **Abrir**: *"Repaso rapido: parametro = poblacion (mu, sigma, p), desconocido. Estadistico = muestra (x-barra, s, p-hat), observable."*
- **Conectar**: cual es la media VERDADERA de ingles de TODOS los estudiantes de NI en Colombia? No la sabemos. Estimamos con nuestra muestra.
- **Formalizar**: problema central de la inferencia: usar estadisticos para aprender sobre parametros.
- **Cerrar**: *"Vamos a formalizar ese proceso."*

### Slide 4: Que es la Estimacion Puntual?
- **Abrir**: *"Un solo numero como mejor apuesta del parametro desconocido."*
- **Formalizar**: x-barra estima mu, s^2 estima sigma^2, p-hat estima p. Notacion theta-hat.
- **Cerrar**: *"El problema: un solo numero no captura la incertidumbre."*

### Slide 5: Estimacion puntual: ejemplo cotidiano (-> Spotify y la estimacion)
- **Abrir**: *"Spotify estima tu 'perfil musical' con un conjunto de parametros. Cada cancion que escuchas es un dato. Theta-hat es la mejor aproximacion de tus gustos basada en esos datos."*
- **Conectar**: un estimador puntual da un solo numero. Pero que tan cerca esta del valor real? Para responder, necesitamos intervalos de confianza.
- **Formalizar**: idea clave -- un solo numero no captura incertidumbre.
- **Cerrar**: *"Primero veamos que propiedades queremos de un buen estimador."*

### Slide 6: Propiedades Deseables de un Estimador (-> Spotify y consistencia)
- **Abrir**: *"Ya vimos esto en S03, pero ahora agregamos contexto: entre mas canciones le das 'like' en Spotify, mejor estima tus gustos musicales. Eso es consistencia."*
- **Conectar**: insesgamiento, eficiencia, consistencia -- repaso rapido con los mismos criterios.
- **Formalizar**: E(x-barra) = mu, x-barra -> mu cuando n -> infinito.
- **Cerrar**: *"Bien, pero un solo numero no basta. Necesitamos cuantificar incertidumbre."*

### Slide 7: Ejemplo: Estimacion Puntual con Datos ICFES
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Ya vieron como funciona con Spotify. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

### Slide 8: De Estimacion Puntual a Intervalos (-> screen time del salon)
- **Abrir**: *"mu-hat = 162.5 puntos. Es mu exactamente 162.5? No. Pero probablemente esta cerca. Mejor decir: esta entre 159.8 y 165.2."*
- **Conectar**: *"El screen time promedio del salon esta entre 4.2 y 5.8 horas. Eso es mucho mas informativo que decir '5 horas'."*
- **Formalizar**: estimacion puntual (un punto) vs intervalo de confianza (un rango que cuantifica incertidumbre).
- **Cerrar**: *"Vamos a construir esos intervalos formalmente."*

---

### Seccion 2: Logica de los Intervalos de Confianza

### Slide 9: Que es un Intervalo de Confianza?
- **Abrir**: *"Un IC al 95% es un rango que, si repitieramos el muestreo muchas veces, contendria el parametro verdadero en el 95% de los casos."*
- **Formalizar**: IC = estimacion puntual +/- margen de error. Nivel de confianza (1-alpha), tipicamente 0.90, 0.95, 0.99.
- **Cerrar**: *"La interpretacion correcta es sutil. Presten atencion."*

### Slide 10: Interpretacion Correcta del IC (-> screen time y encuestas)
- **Abrir**: *"Interpretacion CORRECTA: si tomaramos 100 muestras y construyeramos un IC con cada una, esperariamos que 95 contengan el parametro."*
- **Conectar**: *"Estamos 95% confiados de que el screen time promedio de los javerianos esta entre 4.2 y 5.8 horas."*
- **Formalizar**: interpretacion INCORRECTA: "hay 95% de probabilidad de que mu este en (a,b)". Esto es incorrecto porque mu es fijo, no aleatorio. Lo que varia es el intervalo.
- **Cerrar**: *"Este error de interpretacion es MUY comun. Si les pregunto en el parcial, la respuesta correcta es la que dice 'si repitieramos el muestreo'."*

### Slide 11: Visualizacion del Concepto de IC
- **Abrir**: *"Miren el grafico: 8 muestras, 8 intervalos. 7 de 8 contienen a mu. Uno no. Con mas muestras, converge a 95%."*
- **Formalizar**: los intervalos verdes contienen mu, el rojo no. El IC es lo que varia de muestra a muestra; mu esta fijo.
- **Cerrar**: *"Ahora veamos el margen de error."*

### Slide 12: Margen de Error
- **Abrir**: *"El margen de error es la mitad del ancho del IC. Depende de tres cosas: nivel de confianza, variabilidad, y tamano de muestra."*
- **Formalizar**: E = z_{alpha/2} * sigma/sqrt(n). Mayor confianza -> mayor margen. Mayor n -> menor margen.
- **Cerrar**: *"Hay un trade-off entre confianza y precision."*

### Slide 13: Trade-off: Confianza vs Precision (-> hora de llegada de un amigo)
- **Abrir**: *"Predecir la hora exacta a la que un amigo llega a clase es dificil. Pero decir 'llega entre 6:55 y 7:10' es mas seguro. Entre mas amplio el rango, mas confianza, pero menos precision."*
- **Conectar**: mas confianza (99%) -> intervalo mas ancho. Menos confianza (90%) -> intervalo mas estrecho.
- **Formalizar**: visualizar el trade-off. La solucion: aumentar n.
- **Cerrar**: *"Ahora construyamos ICs formalmente."*

---

### Seccion 3: IC para la Media: sigma Conocida

### Slide 14: IC para mu con sigma Conocida
- **Abrir**: *"Caso 1: sabemos sigma. Es raro en la practica, pero es el punto de partida teorico."*
- **Formalizar**: supuestos (MAS, normalidad o n >= 30, sigma conocida). Formula: x-barra +/- z_{alpha/2} * sigma/sqrt(n). Fundamento: TLC.
- **Cerrar**: *"Veamos los valores criticos."*

### Slide 15: Valores Criticos de z
- **Formalizar**: tabla de valores criticos: 90% -> 1.645, 95% -> 1.960, 99% -> 2.576. Grafico TikZ mostrando areas.
- **Cerrar**: *"Ahora en R."*

### Slide 16-17: Calculo de Valores Criticos en R / Ejemplo Numerico
*[Frames de codigo R -- transicionar con la frase habitual]*

### Slide 18: Ejemplo Numerico: IC con sigma Conocida (cont.)
*[Frame de codigo R -- transicionar con la frase habitual]*

### Slide 19: Interpretacion del Resultado
- **Abrir**: *"IC al 95%: (159.28, 165.72). Estamos 95% confiados de que la media poblacional esta entre esos dos valores."*
- **Formalizar**: margen de error E = 3.22 puntos. Si necesitamos mas precision, aumentar n.
- **Cerrar**: *"Reconocen este formato? Las encuestas electorales lo usan."*

### Slide 20: El IC en la vida real (-> encuestas electorales y apps de delivery)
- **Abrir**: *"Las encuestas electorales reportan 'el candidato A tiene 48% +/- 3%'. Ese +/- 3% es el margen de error de un IC."*
- **Conectar**: *"Apps de delivery: 'tiempo estimado: 25-35 minutos' -- eso es un intervalo de confianza implicito."*
- **Formalizar**: ejemplos cotidianos de IC: reportes de salud, tiempos estimados.
- **Cerrar**: *"Pero en la practica casi nunca conocemos sigma. Que hacemos?"*

---

### Seccion 4: IC para la Media: sigma Desconocida (Distribucion t)

### Slide 21: El Problema: sigma Desconocida
- **Abrir**: *"En la vida real, casi NUNCA conocemos sigma. Usamos s. Pero reemplazar sigma por s introduce incertidumbre adicional."*
- **Formalizar**: t = (x-barra - mu)/(s/sqrt(n)) sigue una t de Student con n-1 gl.
- **Cerrar**: *"Veamos la analogia."*

### Slide 22: sigma Desconocida: analogia (-> horas de sueno)
- **Abrir**: *"Imagina que quieres estimar el promedio de horas de sueno de tu salon, pero no conoces que tan dispersos son los datos. Solo tienes s de tu muestra. Esa incertidumbre extra es la que captura la distribucion t."*
- **Conectar**: cuando sigma es desconocida, usamos s y la distribucion t. Intervalos mas anchos, especialmente con muestras pequenas.
- **Cerrar**: *"Veamos como se comparan z y t."*

### Slide 23: Distribucion t de Student (comparacion visual)
- **Abrir**: *"La t se parece a la normal pero con colas mas pesadas. Con pocos gl, las colas son mucho mas anchas."*
- **Formalizar**: simetrica, centrada en 0, colas mas pesadas, depende de gl = n-1. Con n grande, t(n-1) ~ N(0,1).
- **Cerrar**: *"Consecuencia: los valores criticos de t son MAYORES que los de z."*

### Slide 24: IC para mu con sigma Desconocida
- **Formalizar**: formula x-barra +/- t_{alpha/2, n-1} * s/sqrt(n). Diferencia con sigma conocida: t en vez de z, s en vez de sigma.
- **Cerrar**: *"Veamos cuanto difieren z y t."*

### Slide 25: Comparacion de Valores Criticos: z vs t
- **Abrir**: *"Con 6 observaciones, t es 31% mas grande que z. Con 31, solo 4%. Con n grande, practicamente iguales."*
- **Formalizar**: tabla comparativa. Con n >= 30, la diferencia es pequena pero sigue siendo mejor usar t cuando sigma es desconocida.
- **Cerrar**: *"En la practica, SIEMPRE usen t. R lo hace automaticamente con t.test()."*

### Slide 26-29: Calculo de Valores Criticos t / Ejemplo IC para Media / t.test() / Output
*[Frames de codigo R -- transicionar con la frase habitual]*

*"Ya vieron como funciona la teoria. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

**Punto clave durante la demo de t.test():** *"t.test() les da TODO: el estadistico t, los gl, el p-valor y el IC. Es la navaja suiza de la inferencia para medias."*

---

### Seccion 5: IC para la Varianza (Distribucion chi-cuadrado)

### Slide 30: IC para la Varianza sigma^2 (-> volatilidad de Rappi)
- **Abrir**: *"A veces no solo nos interesa el promedio, sino que tan VARIABLE es algo. Si la varianza del tiempo de entrega de Rappi es alta, no puedes confiar en la hora estimada."*
- **Conectar**: aplicaciones en educacion (heterogeneidad en rendimiento), comercio (volatilidad de la TRM), logistica.
- **Formalizar**: motivacion formal para IC de la varianza.
- **Cerrar**: *"Para esto necesitamos la distribucion muestral de s^2."*

### Slide 31: Distribucion muestral de s^2
- **Formalizar**: (n-1)s^2/sigma^2 ~ chi^2(n-1) si la poblacion es normal.
- **Cerrar**: *"Con esto podemos construir el IC."*

### Slide 32: Distribucion Chi-Cuadrado
- **Abrir**: *"A diferencia de z y t, la chi-cuadrado NO es simetrica. Eso hace que el IC para sigma^2 sea asimetrico."*
- **Formalizar**: asimetrica, solo positivos, depende de gl. Implicacion: IC asimetrico.
- **Cerrar**: *"La formula del IC refleja esa asimetria."*

### Slide 33: Formula del IC para sigma^2
- **Formalizar**: ((n-1)s^2/chi^2_{alpha/2}, (n-1)s^2/chi^2_{1-alpha/2}). Valores criticos: cola derecha e izquierda. IC para sigma: tomar raiz de los limites.
- **Cerrar**: *"Noten que los valores criticos de la chi-cuadrado NO son opuestos como en z o t."*

### Slide 34-35: Ejemplo IC para la Varianza en R
*[Frames de codigo R -- transicionar con la frase habitual]*

### Slide 36: Asimetria del IC para sigma^2
- **Abrir**: *"Miren: s = 18 pero el IC para sigma es (15.9, 20.8). El 18 NO esta en el centro del intervalo. Eso es por la asimetria de la chi-cuadrado."*
- **Formalizar**: ejemplo numerico completo mostrando la asimetria.
- **Cerrar**: *"Es contraintuitivo pero correcto."*

---

### Seccion 6: Forest Plot Departamental

### Slide 37: IC por Departamento: Motivacion
- **Abrir**: *"Hasta ahora hemos visto ICs para un solo grupo. Pero la pregunta interesante es: varia el rendimiento entre departamentos?"*
- **Formalizar**: estrategia: calcular IC por departamento, visualizar en forest plot, comparar solapamiento.
- **Cerrar**: *"Vamos a ver esto en R."*

### Slide 38-42: Calculo de IC por Departamento / Forest Plot / Interpretacion / Departamentos Atipicos / Ancho de IC
*[Frames de codigo R -- transicionar con la frase habitual]*

*"Ya vieron como funciona la teoria. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

**Puntos clave durante la demo:**
- *"El forest plot es HERMOSO para comunicar resultados. Cada punto es x-barra, cada barra es el IC."*
- *"Si dos IC NO se solapan, hay evidencia de diferencia."*
- *"ICs mas anchos = muestras mas pequenas o mayor variabilidad."*

---

### Seccion 7: Resumen

### Slide 43: Tabla Resumen de Intervalos de Confianza
- Recapitular: mu con sigma conocida (z), mu con sigma desconocida (t), sigma^2 (chi-cuadrado).
- *"En la practica, casi siempre usan la distribucion t para la media."*

### Slide 44: Diagrama de Flujo para Elegir el IC
- Recorrer el diagrama. *"Si estan estimando mu y no les dicen que sigma es conocida, usen t. Punto."*

### Slide 45: Supuestos y Robustez
- *"IC para mu: robusto con n grande. IC para sigma^2: NO robusto -- sensible a desviaciones de normalidad."*

### Slide 46: Resumen de la Sesion
- *"Proxima sesion: IC para proporciones, tamano de muestra, muestreo estratificado."*

### Slide 47-48: Ejercicios y Cierre
- Repasar ejercicios. *"El desafio de bootstrap es opcional pero vale la pena."*

---

## S05 -- IC para Proporciones y Tamano de Muestra (~1.5 h)

### Objetivo
El estudiante debe construir e interpretar ICs para proporciones, calcular tamanos de muestra para medias y proporciones, y entender los conceptos basicos de muestreo estratificado.

### Slide 1-2: Titulo y Agenda
- *"Hoy completamos la caja de herramientas de estimacion. Despues de hoy, van a poder responder: cuantos estudiantes necesito encuestar para estimar algo con la precision que quiero?"*

---

### Seccion 1: IC para Proporciones

### Slide 3: Motivacion: Estimar Proporciones (-> iPhone vs Android en el salon)
- **Abrir**: *"Que proporcion del salon usa iPhone vs Android? Si encuestas a 30 companeros y 18 dicen iPhone, p-hat = 18/30 = 0.60. Pero, que tan preciso es ese 60%? Para eso necesitamos un intervalo de confianza."*
- **Conectar**: en educacion: que proporcion alcanza B1 en ingles? Que porcentaje aprueba con mas de 300?
- **Formalizar**: diferencia con medias: variable binaria, codificacion 0/1.
- **Cerrar**: *"Empecemos por definir p-hat formalmente."*

### Slide 4: Motivacion (cont.)
- **Formalizar**: variable categorica binaria (exito/fracaso). p-hat = x/n.
- **Cerrar**: *"Ahora necesitamos la distribucion muestral de p-hat."*

### Slide 5: Proporcion Muestral p-hat
- **Abrir**: *"De 200 estudiantes de NI, 140 superan B1. p-hat = 140/200 = 0.70."*
- **Conectar**: conexion con Bernoulli: cada estudiante es un ensayo. x ~ Binomial(n, p).
- **Formalizar**: definicion formal.
- **Cerrar**: *"Cual es la distribucion de p-hat?"*

### Slide 6: Distribucion Muestral de p-hat
- **Abrir**: *"El TCL tambien aplica a proporciones. Para n grande, p-hat es aprox normal."*
- **Formalizar**: E(p-hat) = p (insesgado). Var(p-hat) = p(1-p)/n. Z = (p-hat - p)/sqrt(p(1-p)/n) ~ N(0,1).
- **Cerrar**: *"Pero hay una condicion de validez."*

### Slide 7: Condicion de Aplicabilidad
- **Abrir**: *"La aproximacion normal funciona si tenemos al menos 5 exitos y 5 fracasos."*
- **Formalizar**: n*p-hat >= 5 y n*(1-p-hat) >= 5. Ejemplo: n=200, p-hat=0.70 -> 140 y 60, ambos >= 5.
- **Cerrar**: *"Si se cumple, podemos construir el IC."*

### Slide 8: IC para una Proporcion
- **Abrir**: *"Problema: la formula necesita p, pero eso es lo que queremos estimar. Solucion: reemplazar p por p-hat."*
- **Formalizar**: p-hat +/- z_{alpha/2} * sqrt(p-hat(1-p-hat)/n). Usamos z (no t) porque el error estandar ya usa p-hat.
- **Cerrar**: *"Veamoslo en R."*

### Slide 9-12: Ejemplo proporcion B1 / IC manualmente / prop.test() / Interpretacion (-> iPhone en la uni)
*[Frames de codigo R -- transicionar con la frase habitual]*

*"Ya vieron como funciona con iPhone vs Android. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

**Punto clave en interpretacion:** *"Si 18 de 30 usan iPhone (p-hat = 0.60), el IC al 95% seria aprox (0.42, 0.78). Es decir, la verdadera proporcion podria estar entre 42% y 78%. Mucha incertidumbre con solo 30 personas."*

### Slide 13-14: IC por Departamento / Forest Plot de Proporciones
*[Frames de codigo R -- transicionar con la frase habitual]*

### Slide 15: Comparar Dos Proporciones
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Si los dos IC NO se solapan, hay evidencia de diferencia significativa."*

---

### Seccion 2: Tamano de Muestra para Medias

### Slide 16: Planificacion del Muestreo (-> Spotify vs Apple Music)
- **Abrir**: *"Cuantas personas necesitas encuestar para saber si mas del 50% de la uni prefiere Spotify a Apple Music, con un margen de error de +/- 5%?"*
- **Conectar**: pregunta inversa: en vez de calcular IC dado n, cual debe ser n para el margen de error que quiero?
- **Formalizar**: componentes del problema: E deseado, nivel de confianza, estimacion previa de sigma.
- **Cerrar**: *"Vamos a la formula."*

### Slide 17: Planificacion del Muestreo (cont.)
- **Formalizar**: tres componentes: margen de error deseado, nivel de confianza, variabilidad.
- **Cerrar**: *"Despejemos n de la formula del margen de error."*

### Slide 18: Formula de Tamano de Muestra para mu
- **Abrir**: *"n = (z * sigma / E)^2. Redondear siempre hacia arriba."*
- **Formalizar**: derivacion desde E = z_{alpha/2} * sigma/sqrt(n). Despejamos n.
- **Cerrar**: *"Veamoslo con un ejemplo."*

### Slide 19: Ejemplo: Tamano de Muestra para MOD_INGLES_PUNT
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Resultado: necesitamos 312 estudiantes para estimar la media con +/- 2 puntos al 95%."*

### Slide 20: Relacion entre n, E y Nivel de Confianza
- **Abrir**: *"Quieres mas precision (menor E)? Necesitas mas datos. Quieres mas confianza? Tambien mas datos. No hay almuerzo gratis."*
- **Formalizar**: n es proporcional a 1/E^2 (reducir E a la mitad = 4 veces mas datos) y a sigma^2.
- **Cerrar**: *"Veamos la sensibilidad."*

### Slide 21: Sensibilidad del Tamano de Muestra
*[Frame de codigo R -- transicionar con la frase habitual]*

### Slide 22: Que Hacer si No Conocemos sigma?
- **Abrir**: *"Tres opciones: estudio piloto, literatura, o regla del rango."*
- **Formalizar**: piloto (n=30-50, calcular s), literatura (buscar sigma reportada), rango (sigma ~ rango/4 o rango/6).
- **Cerrar**: *"Lo mismo aplica para proporciones."*

---

### Seccion 3: Tamano de Muestra para Proporciones

### Slide 23: Formula de Tamano de Muestra para p
- **Abrir**: *"Mismo concepto, formula diferente. Pero tiene un problema: necesita conocer p, que es justo lo que queremos estimar."*
- **Formalizar**: n = z^2 * p(1-p) / E^2. Soluciones: usar p* de estudios previos o p* = 0.5.
- **Cerrar**: *"El enfoque conservador resuelve el problema."*

### Slide 24: Enfoque Conservador: p* = 0.5
- **Abrir**: *"p(1-p) alcanza su maximo cuando p = 0.5. Entonces usar p* = 0.5 GARANTIZA que n sera suficiente sin importar cual sea el verdadero p."*
- **Formalizar**: formula conservadora: n = z^2 / (4E^2). Grafico de p(1-p) vs p mostrando el maximo.
- **Cerrar**: *"Es mas costoso pero mas seguro."*

### Slide 25: Ejemplo: Tamano de Muestra para Proporcion
*[Frame de codigo R -- transicionar con la frase habitual]*

### Slide 26: Comparacion de Metodos (-> Spotify vs Apple Music con estimacion previa)
- **Abrir**: *"Con p* = 0.5: necesitas 1068 encuestados. Con p* = 0.20: solo 683. Un ahorro de 385 personas (36% menos)."*
- **Conectar**: *"Si ya sabes que en tu facultad aprox 70% usa Spotify, usa p* = 0.70 y necesitaras menos encuestados."*
- **Formalizar**: trade-off: conservador (seguro pero costoso) vs estimado (eficiente pero riesgoso).
- **Cerrar**: *"Funcion en R para automatizarlo."*

### Slide 27: Funcion en R para Tamano de Muestra
*[Frame de codigo R -- transicionar con la frase habitual]*

---

### Seccion 4: Muestreo Estratificado

### Slide 28: Muestreo Aleatorio Simple vs Estratificado
- **Abrir**: *"MAS: cada persona tiene igual probabilidad. Simple pero puede no representar subgrupos. Estratificado: divido la poblacion en estratos homogeneos y muestreo dentro de cada uno."*
- **Conectar**: estratos comunes en educacion: departamento, tipo IES (publica/privada), nivel socioeconomico, genero.
- **Formalizar**: ventajas de estratificado: mayor precision, representatividad garantizada, estimaciones por subgrupo, eficiencia administrativa.
- **Cerrar**: *"La clave es como asignar la muestra a cada estrato."*

### Slide 29: Ventajas del Muestreo Estratificado
- **Formalizar**: cuatro ventajas detalladas.
- **Cerrar**: *"Hay dos formas de asignar: proporcional y optima."*

### Slide 30: Asignacion Proporcional vs Optima
- **Abrir**: *"Proporcional: si el 15% de NI esta en Antioquia, asignas 15% de tu muestra a Antioquia. Simple y justo."*
- **Formalizar**: proporcional: n_i = n * N_i/N. Optima (Neyman): n_i proporcional a N_i * sigma_i. La optima requiere conocer sigma_i (limitacion).
- **Cerrar**: *"Veamoslo en R."*

### Slide 31: Ejemplo: Asignacion Proporcional por Departamento
*[Frame de codigo R -- transicionar con la frase habitual]*

### Slide 32: Consideraciones Practicas
- **Abrir**: *"En la vida real hay factores que no estan en las formulas."*
- **Formalizar**: costo vs precision, tasa de respuesta (ajustar: si esperas 70% respuesta y quieres n=500, seleccionar 715), datos faltantes, poder estadistico.
- **Cerrar**: *"Estas son las cosas que distinguen un buen diseno muestral de uno malo."*

---

### Seccion 5: Resumen de toda la Unidad 2

### Slide 33: Tabla Maestra de Intervalos de Confianza
- Recapitular las 4 formulas: mu con sigma conocida (z), mu con sigma desconocida (t), sigma^2 (chi^2), p (z con p-hat).
- *"Si les preguntan que formula usar, pregunten: que parametro estoy estimando? Conozco sigma?"*

### Slide 34: Tabla de Tamano de Muestra
- Dos formulas: para mu y para p.
- *"SIEMPRE redondear hacia arriba."*

### Slide 35: Conexion con Pruebas de Hipotesis
- **Abrir**: *"Adelanto de la proxima unidad: si un IC al 95% NO contiene un valor theta_0, entonces rechazamos H_0: theta = theta_0 al 5%. Los ICs y las pruebas de hipotesis son dos caras de la misma moneda."*
- **Formalizar**: ejemplo: IC (162, 168). H_0: mu = 160. Como 160 NO esta en el IC, rechazamos H_0.
- **Cerrar**: *"La proxima sesion formalizamos esto."*

### Slide 36-39: Resumen / Ejercicios / Cierre
- *"Proxima sesion: fundamentos de pruebas de hipotesis. H_0, H_1, p-valor, errores tipo I y II."*

---

## S06 -- Fundamentos de Pruebas de Hipotesis (~1.5 h)

### Objetivo
El estudiante debe formular hipotesis estadisticas, entender errores tipo I y II, interpretar correctamente el p-valor, ejecutar pruebas z y t (una y dos muestras) en R, calcular e interpretar la d de Cohen y la potencia estadistica.

### Slide 1-2: Titulo y Agenda
- *"Hoy pasamos de 'estimar' a 'decidir'. Hasta ahora: cuanto vale mu? Hoy: hay evidencia suficiente para afirmar que mu es diferente de 160?"*

---

### Seccion 1: Introduccion a las Pruebas de Hipotesis

### Slide 3: Que es una Hipotesis Estadistica? (-> lofi y estudio)
- **Abrir**: *"Los que escuchan lofi realmente estudian mas horas? H_0: no hay diferencia. H_1: si hay diferencia. Eso es una prueba de hipotesis."*
- **Conectar**: la media de ingles en NI es 160? La proporcion que supera B1 es mayor al 70%? IES publicas y privadas tienen el mismo rendimiento?
- **Formalizar**: diferencia con IC: el IC estima un rango plausible; la prueba pregunta si hay evidencia suficiente contra un valor especifico.
- **Cerrar**: *"Empecemos por la estructura formal."*

### Slide 4: Hipotesis Nula vs Hipotesis Alternativa (-> analogia juridica)
- **Abrir**: *"H_0 es como la presuncion de inocencia. La asumimos verdadera hasta que la evidencia demuestre lo contrario."*
- **Conectar**: H_0 (no diferencia, igualdad) vs H_1 (lo que queremos probar). H_0 contiene =, H_1 contiene distinto, < o >.
- **Formalizar**: solo rechazamos H_0 con evidencia fuerte. No rechazar H_0 NO es lo mismo que aceptarla.
- **Cerrar**: *"H_1 puede tener tres formas."*

### Slide 5: Tres Formas de la Hipotesis Alternativa
- **Abrir**: *"Dos colas: es diferente? Cola derecha: es mayor? Cola izquierda: es menor?"*
- **Formalizar**: bilateral (distinto), unilateral derecha (mayor), unilateral izquierda (menor).
- **Cerrar**: *"La forma depende de la pregunta de investigacion."*

### Slide 6: Ejemplos con Datos ICFES
- **Formalizar**: tres ejemplos concretos con puntajes ICFES: dos colas, cola derecha, cola izquierda.
- **Cerrar**: *"Si no hay razon para esperar una direccion, usen dos colas."*

### Slide 7: La Hipotesis Nula como Statu Quo
- **Abrir**: *"H_0 representa el estado actual del conocimiento. Solo la rechazamos si los datos gritan en contra."*
- **Formalizar**: 'no rechazar H_0' no es 'aceptar H_0'. Puede ser que H_0 sea verdadera O que la muestra sea muy pequena.
- **Cerrar**: *"Pensemos la analogia completa."*

### Slide 8: Analogia con un Juicio
- **Abrir**: *"Acusado = H_0. Inocente = H_0 verdadera. Evidencia = datos. Veredicto culpable = rechazar H_0. Veredicto no culpable = no rechazar H_0."*
- **Conectar**: 'no culpable' no es lo mismo que 'inocente'. Solo significa que no hay evidencia suficiente.
- **Formalizar**: solo declaramos 'culpable' si la evidencia es mas alla de una duda razonable.
- **Cerrar**: *"Pero a veces nos equivocamos. Hay dos tipos de errores."*

---

### Seccion 2: Error Tipo I, Tipo II y Nivel de Significancia

### Slide 9: Dos Tipos de Errores
- **Abrir**: *"Podemos tomar dos decisiones (rechazar o no), y hay dos realidades (H_0 verdadera o falsa). Eso da 4 combinaciones."*
- **Formalizar**: tabla 2x2. Error tipo I (alpha): rechazar H_0 verdadera. Error tipo II (beta): no rechazar H_0 falsa.
- **Cerrar**: *"Veamos cada uno con detalle."*

### Slide 10: Error Tipo I (-> TikTok viral falso positivo)
- **Abrir**: *"Declarar que un producto es viral en TikTok cuando no lo es. Una marca invierte millones en algo que 'todos quieren' pero nadie compra. Eso es un falso positivo."*
- **Conectar**: en educacion: concluir que un programa funciona cuando no tiene efecto -> invertir recursos en algo inefectivo.
- **Formalizar**: P(rechazar H_0 | H_0 verdadera) = alpha. En la analogia juridica: condenar a un inocente.
- **Cerrar**: *"Y el error opuesto..."*

### Slide 11: Error Tipo II (-> emprendimiento Instagram falso negativo)
- **Abrir**: *"Tu emprendimiento lanza un anuncio en Instagram que realmente atrae clientes, pero con solo 15 respuestas concluyes que 'no sirve' y lo cancelas. Eso es un falso negativo."*
- **Conectar**: en educacion: descartar un programa efectivo porque la muestra era muy pequena.
- **Formalizar**: P(no rechazar H_0 | H_0 falsa) = beta. En la analogia juridica: absolver a un culpable.
- **Cerrar**: *"Resumen visual."*

### Slide 12: Tabla Resumen de Errores
- **Formalizar**: tabla con definicion, nombre alternativo, analogia juridica, analogia medica, y como se controlan.
- **Cerrar**: *"Alpha lo controlamos nosotros. Veamos."*

### Slide 13: Nivel de Significancia alpha
- **Abrir**: *"Alpha es la probabilidad maxima de error tipo I que toleramos. Nosotros lo fijamos ANTES de ver los datos."*
- **Formalizar**: valores comunes: 0.05 (estandar), 0.01 (conservador), 0.10 (si el error tipo II es mas costoso).
- **Cerrar**: *"Pero hay un trade-off entre alpha y beta."*

### Slide 14: Trade-off entre alpha y beta
- **Abrir**: *"Si somos muy estrictos para rechazar (alpha bajo), aumenta la probabilidad de no detectar un efecto real (beta alto). Solucion: aumentar n."*
- **Formalizar**: relacion inversa con grafico. Aumentar n reduce AMBOS.
- **Cerrar**: *"Ahora la herramienta que conecta todo: el p-valor."*

---

### Seccion 3: El p-valor

### Slide 15: Que es el p-valor?
- **Abrir**: *"El p-valor responde: que tan incompatibles son mis datos con H_0? Si es muy pequeno, H_0 es dificil de defender."*
- **Formalizar**: p-valor = P(estadistico tan extremo o mas | H_0 verdadera). Regla: p < alpha -> rechazar; p >= alpha -> no rechazar.
- **Cerrar**: *"Veamos con un ejemplo concreto."*

### Slide 16: El p-valor: ejemplo concreto (-> lofi y estudio)
- **Abrir**: *"Si comparas horas de estudio entre quienes escuchan lofi y quienes no, y el p-valor es 0.03, hay solo un 3% de probabilidad de ver una diferencia tan grande si realmente no hubiera diferencia. Como 0.03 < 0.05, rechazamos H_0."*
- **Formalizar**: el p-valor solo mide evidencia contra H_0, no prueba que H_1 sea verdadera.
- **Cerrar**: *"Cuidado con las interpretaciones incorrectas."*

### Slide 17: Errores Comunes de Interpretacion del p-valor
- **Abrir**: *"Cuatro cosas que el p-valor NO es."*
- **Formalizar**: (1) NO es P(H_0 verdadera | datos) -- es al reves. (2) NO es 'probabilidad de que sea por azar'. (3) NO mide la magnitud del efecto. (4) NO es probabilidad de replicar.
- **Cerrar**: *"Si les preguntan en el parcial, recuerden: el p-valor NO es la probabilidad de que H_0 sea verdadera."*

### Slide 18: Escala Cualitativa del p-valor
- **Formalizar**: tabla: p < 0.01 (evidencia muy fuerte), 0.01-0.05 (moderada), 0.05-0.10 (debil), p >= 0.10 (ninguna).
- **Cerrar**: *"El umbral de 0.05 es convencional, no magico."*

### Slide 19: Visualizacion del p-valor (dos colas)
- **Formalizar**: grafico TikZ mostrando la distribucion, regiones de rechazo, estadistico observado, y el area del p-valor.
- **Cerrar**: *"Ahora apliquemos todo esto."*

---

### Seccion 4: Prueba z para una Muestra (sigma Conocida)

### Slide 20: Estadistico de Prueba z
- **Abrir**: *"Cuando sigma es conocida: z = (x-barra - mu_0) / (sigma/sqrt(n)). Mide cuantas desviaciones estandar esta x-barra del valor hipotetico."*
- **Formalizar**: supuestos: MAS, normalidad o n >= 30, sigma conocida. Si H_0 es verdadera, z ~ N(0,1).
- **Cerrar**: *"Veamos las regiones de rechazo."*

### Slide 21: Region de Rechazo y Valor Critico
- **Formalizar**: dos colas: rechazar si |z| > z_{alpha/2}. Cola derecha: rechazar si z > z_alpha. Cola izquierda: rechazar si z < -z_alpha.
- **Cerrar**: *"Ejemplo con datos ICFES."*

### Slide 22-23: Ejemplo: La Media de Ingles es Mayor que 155?
*[Frames de codigo R -- transicionar con la frase habitual]*

*"Ya vieron como funciona la logica. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

---

### Seccion 5: Prueba t para una Muestra (sigma Desconocida)

### Slide 24: Estadistico de Prueba t
- **Abrir**: *"Caso real: no conocemos sigma, usamos s. Estadistico t con n-1 gl."*
- **Formalizar**: t = (x-barra - mu_0) / (s/sqrt(n)). Si H_0 es verdadera, t ~ t(n-1). Regiones de rechazo identicas a las de z pero con valores criticos de t.
- **Cerrar**: *"Ejemplo con datos reales."*

### Slide 25-28: Ejemplo La Media Supera B1? / t.test() / Interpretacion Output
*[Frames de codigo R -- transicionar con la frase habitual]*

**Punto clave:** *"t.test() con alternative = 'greater' hace todo: calcula el estadistico, el p-valor, y el IC de una cola."*

---

### Seccion 6: Prueba t para Dos Muestras Independientes

### Slide 29: Comparar Dos Medias Poblacionales
- **Abrir**: *"Difiere el puntaje de ingles entre IES publicas y privadas? H_0: mu_publica = mu_privada."*
- **Formalizar**: hipotesis, equivalente como diferencia de medias = 0.
- **Cerrar**: *"Necesitamos un estadistico para dos muestras."*

### Slide 30: Estadistico de Prueba para Dos Muestras (Welch)
- **Abrir**: *"El estadistico de Welch NO asume varianzas iguales. Es la version robusta y la que R usa por defecto."*
- **Formalizar**: formula de t de Welch. GL de Welch (no memorizar, R lo calcula).
- **Cerrar**: *"Veamoslo en R."*

### Slide 31-32: Ejemplo Ingles Publicas vs Privadas / Formula con ~
*[Frames de codigo R -- transicionar con la frase habitual]*

*"La formula y ~ grupo es estandar en R para modelos. Acostumbrense a usarla."*

---

### Seccion 7: d de Cohen y Tamano del Efecto

### Slide 33: Significancia Estadistica vs Significancia Practica
- **Abrir**: *"Con muestras grandes, diferencias MINUSCULAS pueden ser estadisticamente significativas. Que n_1 = n_2 = 10,000 y la diferencia sea 0.7 puntos con p < 0.001. Es relevante una diferencia de 0.7 puntos?"*
- **Formalizar**: significancia estadistica (p-valor pequeno) no es lo mismo que significancia practica (efecto relevante). Necesitamos medir el tamano del efecto.
- **Cerrar**: *"Para eso existe la d de Cohen."*

### Slide 34: d de Cohen
- **Abrir**: *"|d| ~ 0.2: efecto pequeno. |d| ~ 0.5: mediano. |d| ~ 0.8: grande."*
- **Formalizar**: d = (x-barra_1 - x-barra_2) / s_pooled. Ventaja: independiente del tamano de muestra y de las unidades.
- **Cerrar**: *"Calculemoslo en R."*

### Slide 35-36: Calcular d de Cohen en R / Ejemplo con Interpretacion
*[Frames de codigo R -- transicionar con la frase habitual]*

### Slide 37: Reporte Completo: Estadistica + Efecto
- **Abrir**: *"SIEMPRE reporten AMBOS: p-valor Y tamano del efecto. Nunca un p-valor solo."*
- **Formalizar**: ejemplo de reporte completo con M, DE, t, gl, p-valor, d, e interpretacion contextual.
- **Cerrar**: *"Si en el problem set solo ponen el p-valor sin d de Cohen, lo voy a notar."*

---

### Seccion 8: Potencia Estadistica

### Slide 38: Que es la Potencia Estadistica? (-> encuesta sobre lofi con 10 personas)
- **Abrir**: *"La potencia es la capacidad de tu encuesta para detectar una diferencia real. Si encuestas a solo 10 personas sobre lofi y estudio, probablemente no detectaras nada aunque la diferencia exista."*
- **Formalizar**: Potencia = 1 - beta = P(rechazar H_0 | H_0 falsa). Convencion: minimo 0.80 (80%), ideal 0.90.
- **Cerrar**: *"Que factores afectan la potencia?"*

### Slide 39: Factores que Afectan la Potencia
- **Formalizar**: 4 factores: n (mayor -> mayor potencia), alpha (mayor -> mayor potencia pero mas error tipo I), tamano del efecto (grande -> mas facil detectar), variabilidad (menor -> mayor potencia). El unico que controlamos facilmente es n.
- **Cerrar**: *"La curva de potencia lo visualiza."*

### Slide 40: Curva de Potencia
- **Formalizar**: grafico TikZ. La potencia aumenta cuando el verdadero mu se aleja de mu_0.
- **Cerrar**: *"Calculemoslo en R con el paquete pwr."*

### Slide 41-42: Calcular Potencia en R / Tamano de Muestra Requerido
*[Frames de codigo R -- transicionar con la frase habitual]*

*"Para detectar un efecto de d = 0.3 con potencia 0.80 necesitas ~175 personas por grupo. Para d = 0.2 necesitas ~394. Efectos pequenos son CAROS de detectar."*

---

### Seccion 9: Relacion entre IC y Pruebas de Hipotesis

### Slide 43: Dos Caras de la Misma Moneda
- **Abrir**: *"Si un IC al 95% para mu NO contiene 160, entonces rechazamos H_0: mu = 160 al 5%. Siempre coinciden."*
- **Formalizar**: teorema de equivalencia. IC mas informativo: da rango de valores plausibles.
- **Cerrar**: *"Verifiquemoslo en R."*

### Slide 44-45: Verificar Equivalencia en R
*[Frames de codigo R -- transicionar con la frase habitual]*

### Slide 46: Cuando Usar IC vs Prueba de Hipotesis?
- **Abrir**: *"IC: enfoque en estimacion. Prueba: enfoque en decision. Recomendacion: reportar AMBOS."*
- **Formalizar**: comparacion en dos columnas.
- **Cerrar**: *"En la practica, reportar ambos da una vision completa."*

---

### Seccion 10: Conclusiones

### Slide 47: Resumen de la Sesion
- Recapitular 8 conceptos: hipotesis, errores, p-valor, prueba z, prueba t (1 y 2 muestras), d de Cohen, potencia, IC vs prueba.
- *"Proxima sesion: prueba t pareada, ANOVA, y pruebas no parametricas."*

### Slide 48: Tabla Resumen: Que Prueba Usar?
- Recorrer la tabla. *"Hoy vimos las primeras tres filas. La proxima sesion completamos la tabla."*

### Slide 49-50: Ejercicios y Cierre
- Enfatizar el ejercicio del desafio (comparar ingles entre genero con IC y prueba, verificar equivalencia).

---

## S07 -- Pruebas para Dos Poblaciones, ANOVA y No Parametricas (~1.5 h)

### Objetivo
El estudiante debe ejecutar pruebas t pareadas, entender la logica de ANOVA y sus supuestos, aplicar comparaciones multiples con Tukey HSD, y saber cuando usar pruebas no parametricas (Mann-Whitney, Kruskal-Wallis).

### Slide 1-2: Titulo y Agenda
- *"Hoy completamos la caja de herramientas de comparacion de grupos. Despues de hoy, van a poder comparar dos grupos (pareados o no) y tres o mas grupos, con y sin supuestos de normalidad."*

---

### Seccion 1: Prueba t Pareada (Muestras Dependientes)

### Slide 3: Muestras Independientes vs Dependientes
- **Abrir**: *"Hasta ahora comparamos grupos DISTINTOS: publicas vs privadas. Ahora vamos a comparar la MISMA persona en dos momentos."*
- **Conectar**: Saber 11 vs Saber Pro del mismo estudiante. Antes vs despues de una intervencion.
- **Formalizar**: muestras dependientes (pareadas): mismos sujetos medidos dos veces, o pares emparejados.
- **Cerrar**: *"Veamos un ejemplo cotidiano."*

### Slide 4: Muestras Dependientes: ejemplo cotidiano (-> screen time antes y despues de app bienestar digital)
- **Abrir**: *"Medir tu screen time ANTES y DESPUES de instalar una app de bienestar digital como Forest o One Sec. Cada persona es su propio control."*
- **Conectar**: la misma persona se mide dos veces -> datos pareados. Se analizan las DIFERENCIAS d_i = x_despues - x_antes.
- **Formalizar**: cada par esta vinculado. La unidad de analisis es la diferencia, no los valores individuales.
- **Cerrar**: *"Cuando usamos esta prueba?"*

### Slide 5: Cuando Usar Prueba t Pareada?
- **Abrir**: *"Dos mediciones del MISMO sujeto. O pares naturales."*
- **Conectar**: ventaja: controla variabilidad entre sujetos -> mayor potencia. En ICFES: comparar Saber 11 vs Saber Pro del mismo estudiante (problema: necesitamos tabla de cruce).
- **Formalizar**: criterios de uso.
- **Cerrar**: *"La idea clave: trabajar con las diferencias."*

### Slide 6: Hipotesis y Estadistico de Prueba
- **Abrir**: *"Nos olvidamos de los valores individuales y trabajamos solo con las diferencias d_i = x_1i - x_2i."*
- **Formalizar**: H_0: mu_d = 0 vs H_1: mu_d != 0. Estadistico t = d-barra / (s_d / sqrt(n)). t ~ t(n-1).
- **Cerrar**: *"Veamoslo con datos simulados."*

### Slide 7-10: Ejemplo Saber 11 vs Saber Pro (simulado) / Prueba t pareada / Visualizacion
*[Frames de codigo R -- transicionar con la frase habitual]*

*"Ya vieron como funciona con screen time antes y despues. Ahora vamos a hacer lo mismo pero con datos de puntajes de estudiantes, en R."*

**Punto clave:** *"t.test() con paired = TRUE hace todo. Es equivalente a hacer t.test() sobre las diferencias directamente."*

---

### Seccion 2: ANOVA de Una Via

### Slide 11: Motivacion: Comparar Mas de Dos Grupos (-> inflacion del error tipo I)
- **Abrir**: *"Queremos comparar ingles entre 5 regiones. Podemos hacer 10 pruebas t por pares? Si, pero el error tipo I se INFLA: con 10 pruebas al 5%, la probabilidad de al menos un falso positivo es 40%!"*
- **Formalizar**: P(al menos un error tipo I) = 1 - (1-alpha)^m. Con m=10, alpha=0.05: 0.40.
- **Cerrar**: *"Necesitamos una prueba que compare TODOS los grupos a la vez."*

### Slide 12: Motivacion (cont.) (-> TikTok y notas)
- **Abrir**: *"Hay diferencia en el promedio de notas entre estudiantes que usan TikTok menos de 1 hora, entre 1 y 3 horas, y mas de 3 horas al dia? Tres grupos, una variable numerica: ANOVA."*
- **Conectar**: ANOVA compara tres o mas grupos simultaneamente, controlando el error tipo I global.
- **Cerrar**: *"Veamos como funciona."*

### Slide 13: Que es ANOVA?
- **Abrir**: *"Analysis of Variance. Nombre confuso porque comparamos MEDIAS usando VARIANZAS."*
- **Formalizar**: H_0: mu_1 = mu_2 = ... = mu_k vs H_1: al menos un par difiere. H_1 dice que HAY diferencia, pero no DONDE.
- **Cerrar**: *"La logica es elegante."*

### Slide 14: Logica de ANOVA
- **Abrir**: *"Si todas las medias son iguales, la variabilidad ENTRE grupos deberia ser similar a la variabilidad DENTRO de grupos. Si son diferentes, la variabilidad entre grupos sera MAYOR."*
- **Formalizar**: F = MSB/MSW. F grande -> evidencia contra H_0. Bajo H_0, F ~ F(k-1, N-k).
- **Cerrar**: *"Necesitamos descomponer la variabilidad total."*

### Slide 15: Particion de la Variabilidad Total
- **Formalizar**: SST = SSB + SSW. SSB (variabilidad entre grupos), SSW (variabilidad dentro de grupos). MSB = SSB/(k-1), MSW = SSW/(N-k).
- **Cerrar**: *"Esto se resume en la tabla ANOVA."*

### Slide 16: Tabla ANOVA
- **Formalizar**: tabla completa con fuente, SS, df, MS, F. Notacion: k = numero de grupos, N = total, n_i = tamano grupo i.
- **Cerrar**: *"Veamoslo con datos reales."*

### Slide 17-18: Ejemplo Ingles por Macro-Region (creacion de variable)
*[Frames de codigo R -- transicionar con la frase habitual]*

### Slide 19: Realizar ANOVA en R
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Ya vieron como funciona con TikTok y notas. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

### Slide 20: Interpretar Output de ANOVA
- **Abrir**: *"F = 9.876, p-valor < 0.001. Rechazamos H_0: hay evidencia de que al menos una macro-region tiene media diferente."*
- **Conectar**: pero CUALES regiones difieren? ANOVA no dice. Necesitamos Tukey.
- **Formalizar**: leer el output completo: Df, Sum Sq, Mean Sq, F value, Pr(>F).
- **Cerrar**: *"Primero verifiquemos los supuestos."*

### Slide 21: Supuestos de ANOVA
- **Abrir**: *"ANOVA requiere tres cosas: normalidad de residuos, homocedasticidad (varianzas iguales), e independencia."*
- **Formalizar**: como verificar cada uno. Si no se cumplen: transformacion o prueba no parametrica.
- **Cerrar**: *"Verifiquemos con R."*

### Slide 22-23: Verificar Supuestos en R
*[Frames de codigo R -- transicionar con la frase habitual]*

---

### Seccion 3: Comparaciones Multiples: Tukey HSD

### Slide 24: El Problema de las Comparaciones Multiples
- **Abrir**: *"ANOVA dice HAY diferencia. Tukey dice DONDE esta."*
- **Formalizar**: con k=5 grupos, 10 comparaciones. Tukey controla la tasa de error familiar (FWER).
- **Cerrar**: *"Tukey es el metodo mas usado para comparaciones post-hoc."*

### Slide 25: Tukey HSD: Honestly Significant Difference
- **Formalizar**: IC simultaneo para cada par. Si el IC NO incluye 0, los grupos difieren significativamente.
- **Cerrar**: *"En R es una linea."*

### Slide 26: Realizar Tukey HSD en R
*[Frame de codigo R -- transicionar con la frase habitual]*

### Slide 27: Interpretar Resultados de Tukey
- **Abrir**: *"Miren: Caribe vs Andina: p-adj = 0.0018, diferencia significativa. Caribe 8.4 puntos por debajo. Pacifica vs Andina: p-adj = 0.049, justo significativa."*
- **Formalizar**: leer la tabla: diff, lwr, upr, p adj. Las demas comparaciones no son significativas.
- **Cerrar**: *"Visualicemoslo."*

### Slide 28: Visualizacion de Resultados Tukey
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Este forest plot de Tukey es PERFECTO para reportar resultados. Si el IC cruza 0, no hay diferencia."*

---

### Seccion 4: Curva de Potencia para ANOVA

### Slide 29: Tamano del Efecto en ANOVA: f de Cohen
- **Abrir**: *"Asi como d de Cohen es para dos grupos, f de Cohen es para ANOVA."*
- **Formalizar**: f ~ 0.10 (pequeno), f ~ 0.25 (mediano), f ~ 0.40 (grande).
- **Cerrar**: *"Cuantos necesitamos por grupo?"*

### Slide 30-31: Calcular Potencia para ANOVA / Explorar Escenarios
*[Frames de codigo R -- transicionar con la frase habitual]*

*"Efectos pequenos requieren muestras MUCHO mas grandes. Con f = 0.10 y 5 grupos, necesitas ~305 por grupo."*

---

### Seccion 5: Pruebas No Parametricas

### Slide 32: Cuando Usar Pruebas No Parametricas?
- **Abrir**: *"Si los datos no cumplen normalidad, son ordinales, o tienen outliers extremos."*
- **Formalizar**: 4 situaciones: datos ordinales, distribuciones muy sesgadas, muestras pequenas, violacion de supuestos. Ventajas: menos supuestos, robustas. Desventaja: menos potentes si los supuestos se cumplen.
- **Cerrar**: *"Veamos un ejemplo cotidiano."*

### Slide 33: Pruebas No Parametricas: ejemplo cotidiano (-> ratings de apps)
- **Abrir**: *"Datos de rating en apps (1-5 estrellas) no siguen una distribucion normal: son ordinales y discretos. Aqui conviene usar Mann-Whitney o Kruskal-Wallis."*
- **Conectar**: regla practica: ordinal -> no parametrica. Outliers fuertes -> considerar no parametrica. n grande y distribucion razonable -> parametrica.
- **Cerrar**: *"Veamos la correspondencia."*

### Slide 34: Pruebas No Parametricas Comunes
- **Formalizar**: tabla de equivalencias: t (1 muestra) <-> Wilcoxon signed-rank. t (2 indep) <-> Mann-Whitney. t pareada <-> Wilcoxon signed-rank. ANOVA <-> Kruskal-Wallis.
- **Cerrar**: *"Principio: trabajan con RANGOS en vez de valores originales."*

### Slide 35: Mann-Whitney-Wilcoxon
- **Abrir**: *"Alternativa a la t de dos muestras. En vez de comparar medias, compara si un grupo tiende a tener valores mas grandes."*
- **Formalizar**: H_0: las dos distribuciones son identicas. Metodo: combinar, asignar rangos, comparar sumas.
- **Cerrar**: *"Veamoslo en R."*

### Slide 36-38: Ejemplo Mann-Whitney en R / Comparar Parametrica vs No Parametrica
*[Frames de codigo R -- transicionar con la frase habitual]*

*"Si los datos son aprox normales, ambas pruebas dan resultados similares. Si difieren mucho, investigar outliers o asimetria."*

### Slide 39: Kruskal-Wallis: Alternativa a ANOVA
- **Abrir**: *"Kruskal-Wallis es para 3 o mas grupos lo que Mann-Whitney es para 2."*
- **Formalizar**: H_0: las k distribuciones son identicas. Estadistico H ~ chi^2(k-1).
- **Cerrar**: *"En R."*

### Slide 40: Ejemplo Kruskal-Wallis en R
*[Frame de codigo R -- transicionar con la frase habitual]*

### Slide 41: Comparaciones Post-hoc para Kruskal-Wallis
*[Frame de codigo R -- transicionar con la frase habitual]*

*"El ajuste de Bonferroni es conservador pero simple. Para el problem set, pueden usar Bonferroni o Holm."*

### Slide 42: Cuando Usar Parametrica vs No Parametrica?
- **Abrir**: *"Guia de decision: primero verificar supuestos. Si se cumplen, parametrica (mas potente). Si no, intentar transformacion. Si persiste, no parametrica. Si los datos son ordinales, siempre no parametrica."*
- **Formalizar**: con muestras grandes (n >= 30 por grupo), t y ANOVA son robustas a desviaciones moderadas de normalidad.
- **Cerrar**: *"Con n grande, el TLC les salva la vida."*

---

### Seccion 6: Resumen

### Slide 43: Tabla Resumen: Que Prueba Usar?
- Recorrer la tabla completa: 1 muestra, 2 independientes, 2 pareadas, k independientes, proporciones.
- *"Proxima sesion: chi-cuadrado para categoricas."*

### Slide 44: Flujo de Decision
- Recorrer el diagrama TikZ. *"Si los supuestos no se cumplen, cambiar a la prueba no parametrica correspondiente."*

### Slide 45: Resumen de la Sesion
- *"Proxima sesion: PARCIAL. Cubre sesiones 1-7."*

### Slide 46: Preparacion para el Parcial
- **Abrir**: *"Cuatro grandes bloques: descriptiva y visualizacion (S01-S03), estimacion e ICs (S04-S05), pruebas de hipotesis (S06), comparacion de grupos (S07)."*
- **Formalizar**: habilidades clave: interpretar output de R (t.test, aov, summary), verificar supuestos, elegir la prueba adecuada, reportar resultados completos.
- **Cerrar**: *"Repasen los ejercicios de las sesiones anteriores con datos ICFES."*

### Slide 47-48: Ejercicios / Cierre
- *"Mucho exito en el parcial!"*

---

## S08 -- Chi-Cuadrado: Independencia y Bondad de Ajuste (~1.5 h)

### Objetivo
El estudiante debe construir e interpretar tablas de contingencia, ejecutar la prueba chi-cuadrado de independencia y de bondad de ajuste, calcular e interpretar la V de Cramer, y comparar multiples proporciones.

### Slide 1-2: Titulo y Agenda
- *"Hoy entramos al mundo de las variables categoricas. Hasta ahora comparamos medias de variables numericas. Ahora la pregunta es: estan asociadas dos variables categoricas?"*

---

### Seccion 1: Tablas de contingencia

### Slide 3: Que es una tabla de contingencia? (-> nivel MCER x tipo IES)
- **Abrir**: *"Una tabla de contingencia cruza dos variables categoricas. Filas = categorias de una, columnas = categorias de la otra, celdas = frecuencias."*
- **Conectar**: como se relaciona el nivel MCER (A-, A1, A2, B1, B+) con el tipo de IES (publica/privada) para estudiantes de NI?
- **Formalizar**: estructura basica: filas, columnas, celdas, margenes.
- **Cerrar**: *"Construyamosla en R."*

### Slide 4: Construyendo una tabla de contingencia en R
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Hay 892 estudiantes de IES privadas con nivel A2. Ese es un dato, pero queremos saber si hay un PATRON."*

### Slide 5: Frecuencias marginales
*[Frame de codigo R -- transicionar con la frase habitual]*

### Slide 6: Frecuencias relativas
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Cada tipo de proporcion responde una pregunta diferente: del total, por fila, o por columna."*

### Slide 7: Visualizacion: mosaico
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Parece haber una diferencia: las IES privadas tienen mayor proporcion en B1 y B+. Pero es estadisticamente significativa?"*

---

### Seccion 2: Prueba chi-cuadrado de independencia

### Slide 8: Hipotesis de independencia (-> genero y red social)
- **Abrir**: *"Hay asociacion entre genero y preferencia de red social (TikTok vs Instagram vs YouTube)? Si las variables fueran independientes, hombres y mujeres elegirian las redes en la misma proporcion."*
- **Conectar**: H_0: nivel MCER y tipo IES son independientes (no hay asociacion). H_1: existe asociacion.
- **Formalizar**: diferencia con pruebas anteriores: ahora ambas variables son categoricas.
- **Cerrar**: *"Para probar independencia, calculamos lo que ESPERARIAMOS ver si fueran independientes."*

### Slide 9: Frecuencias esperadas bajo independencia
- **Abrir**: *"Si las variables fueran independientes, cuantas observaciones esperariamos en cada celda?"*
- **Formalizar**: E_ij = (R_i * C_j) / n. Logica: bajo independencia, la proporcion de cada nivel MCER seria la misma en ambos tipos de IES.
- **Cerrar**: *"Veamos con un ejemplo."*

### Slide 10: Frecuencias esperadas: ejemplo
- **Abrir**: *"Celda (A2, privada): observamos 892, esperamos 891.24. Muy cercano en esta celda."*
- **Formalizar**: calculo paso a paso: E = 1648 * 2750 / 5085 = 891.24.
- **Cerrar**: *"Pero necesitamos mirar TODAS las celdas a la vez."*

### Slide 11: El estadistico chi-cuadrado
- **Abrir**: *"El estadistico chi-cuadrado mide la discrepancia TOTAL entre observado y esperado."*
- **Formalizar**: chi^2 = suma de (O_ij - E_ij)^2 / E_ij. Cercano a 0 = independencia plausible. Grande = evidencia contra independencia.
- **Cerrar**: *"Cuanto es 'grande'?"*

### Slide 12: Distribucion chi-cuadrado y grados de libertad
- **Abrir**: *"Bajo H_0, el estadistico sigue una chi-cuadrado con (r-1)(c-1) grados de libertad."*
- **Formalizar**: en el ejemplo: gl = (5-1)(2-1) = 4. Regla de decision: rechazar si chi^2 > chi^2_{alpha, gl} o p-valor < alpha.
- **Cerrar**: *"Hay una condicion de validez."*

### Slide 13: Condicion de validez
- **Abrir**: *"La aproximacion chi-cuadrado necesita que las frecuencias esperadas no sean muy pequenas."*
- **Formalizar**: E_ij >= 5 en al menos 80% de las celdas. Si no se cumple: combinar categorias, Fisher exacta (solo 2x2), o aumentar n.
- **Cerrar**: *"En nuestro ejemplo todas las celdas tienen E > 100. Estamos bien."*

### Slide 14: Aplicacion en R: chisq.test()
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Ya vieron como funciona con genero y redes sociales. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

### Slide 15: Interpretacion del resultado
- **Abrir**: *"chi^2 = 186.42, gl = 4, p-valor practicamente 0. Rechazamos H_0: hay asociacion entre nivel MCER y tipo de IES."*
- **Conectar**: rechazar H_0 indica asociacion, pero NO implica causalidad. Y la prueba NO nos dice que tan fuerte es la asociacion.
- **Formalizar**: conclusion completa.
- **Cerrar**: *"Pero DONDE estan las diferencias? Miremos los residuos."*

### Slide 16: Visualizando las diferencias (residuos estandarizados)
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Residuos > |2| indican celdas con diferencias importantes. IES privadas tienen MAS B1 y B+ de lo esperado, y MENOS A- y A1."*

### Slide 17: Visualizacion grafica de residuos (heatmap)
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Azul = menos de lo esperado, Rojo = mas de lo esperado. El patron es claro."*

---

### Seccion 3: V de Cramer

### Slide 18: Midiendo la fuerza de la asociacion
- **Abrir**: *"Chi-cuadrado dice SI hay asociacion. Pero QUE TAN FUERTE? Para eso existe la V de Cramer."*
- **Formalizar**: V = sqrt(chi^2 / (n * (min(r,c) - 1))). Rango: 0 (independencia) a 1 (asociacion perfecta).
- **Cerrar**: *"Calculemosla."*

### Slide 19: Calculo de V de Cramer en R
*[Frame de codigo R -- transicionar con la frase habitual]*

### Slide 20: V de Cramer: calculo manual
- **Formalizar**: V = sqrt(186.42 / (5085 * 1)) = sqrt(0.0367) = 0.1915.
- **Cerrar**: *"Como interpretamos ese 0.19?"*

### Slide 21: Interpretacion de V de Cramer
- **Abrir**: *"V < 0.1: asociacion muy debil. 0.1 a 0.3: moderada. >= 0.3: fuerte."*
- **Conectar**: V = 0.1915: asociacion moderada. Estadisticamente significativa (p < 0.001) pero la magnitud es moderada.
- **Formalizar**: como con d de Cohen: significancia estadistica no es lo mismo que significancia practica. Siempre reportar AMBOS.
- **Cerrar**: *"La misma leccion de siempre: p-valor Y tamano del efecto."*

### Slide 22: Ejemplo adicional: Estrato x Region
*[Frame de codigo R -- transicionar con la frase habitual]*

---

### Seccion 4: Prueba chi-cuadrado de bondad de ajuste

### Slide 23: Que es bondad de ajuste? (-> helados y distribucion uniforme)
- **Abrir**: *"Pregunta diferente: en la prueba de independencia comparamos dos variables observadas. En bondad de ajuste comparamos una variable observada con una distribucion TEORICA."*
- **Conectar**: los sabores de helado se venden igual o hay preferencias? Si H_0 es distribucion uniforme, cada sabor deberia venderse en igual proporcion.
- **Formalizar**: H_0: los datos provienen de la distribucion especificada. H_1: no.
- **Cerrar**: *"Veamos ejemplos."*

### Slide 24: Bondad de ajuste: ejemplos
- **Formalizar**: los niveles MCER se distribuyen uniformemente? El puntaje de ingles sigue una normal? La proporcion por region coincide con la distribucion poblacional?
- **Cerrar**: *"El estadistico es el mismo."*

### Slide 25: Estadistico de bondad de ajuste
- **Formalizar**: misma formula: chi^2 = suma (O_i - E_i)^2 / E_i. Grados de libertad: gl = k - p - 1 (p = parametros estimados de los datos).
- **Cerrar**: *"Ejemplo 1: distribucion uniforme."*

### Slide 26: Ejemplo 1: Distribucion uniforme de niveles MCER
*[Frame de codigo R -- transicionar con la frase habitual]*

*"chi^2 = 574.23, p < 0.001. Rechazamos: la distribucion NO es uniforme. Hay un pico en A2."*

### Slide 27: Visualizacion: observado vs esperado
*[Frame de codigo R -- transicionar con la frase habitual]*

### Slide 28-29: Ejemplo 2: Puntaje de ingles sigue normal?
*[Frames de codigo R -- transicionar con la frase habitual]*

**Punto clave sobre gl:** *"gl = k - p - 1 = 10 - 2 - 1 = 7 porque estimamos mu y sigma de los datos (p = 2)."*

### Slide 30: Alternativa: Test de Shapiro-Wilk
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Para probar normalidad, Shapiro-Wilk es mas potente que chi-cuadrado de bondad de ajuste."*

### Slide 31: Visualizacion: Q-Q plot
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Si los puntos siguen la linea roja, los datos son normales. En nuestro caso las colas se desvian."*

### Slide 32: Ejemplo 3: Distribucion regional esperada
*[Frame de codigo R -- transicionar con la frase habitual]*

*"La distribucion regional de NI NO refleja la distribucion poblacional de Colombia. Tiene sentido: los programas de NI se concentran en ciertas ciudades."*

---

### Seccion 5: Comparacion de multiples proporciones

### Slide 33: Extension: k proporciones
- **Abrir**: *"La proporcion de estudiantes que supera B1 es igual en las 5 regiones principales? Es una tabla 2 x k."*
- **Formalizar**: H_0: p_1 = p_2 = ... = p_k. H_1: al menos una es diferente. Equivalente a chi-cuadrado de independencia.
- **Cerrar**: *"En R."*

### Slide 34: Aplicacion: prop.test() para k proporciones
*[Frame de codigo R -- transicionar con la frase habitual]*

### Slide 35: Visualizacion de proporciones por region
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Bogota y la region Andina muestran las proporciones mas altas. Tiene sentido con lo que sabemos del contexto educativo colombiano."*

---

### Seccion 6: Resumen U3 completa

### Slide 36: Diagrama de flujo: Que prueba usar?
- Recorrer el diagrama TikZ completo: numerica -> cuantos grupos -> t o ANOVA. Categorica -> que pregunta -> independencia o bondad de ajuste.
- *"Este diagrama es la hoja de ruta para el resto del curso y para su vida profesional."*

### Slide 37: Resumen: Pruebas para variables numericas
- Recapitular: 1 media (t), 2 medias independientes (t 2 muestras), 2 medias pareadas (t pareada), 3+ medias (ANOVA). Alternativas no parametricas.

### Slide 38: Resumen: Pruebas para variables categoricas
- Recapitular: chi^2 de independencia (asociacion entre dos categoricas) y chi^2 de bondad de ajuste (comparar con distribucion teorica). V de Cramer para tamano del efecto.

### Slide 39: Recomendaciones finales
- **Abrir**: *"Tres reglas de oro para el resto del semestre."*
- **Formalizar**: (1) Siempre verificar supuestos: chi^2 necesita E >= 5, t necesita normalidad o n grande, ANOVA necesita normalidad y homocedasticidad. (2) Reportar resultados completos: estadistico, gl, p-valor, tamano del efecto, IC. (3) Interpretar en contexto.
- **Cerrar**: *"La proxima sesion entramos en regresion lineal simple. Modelamos la relacion entre dos variables numericas."*

### Slide 40: Proxima sesion
- *"Regresion lineal simple (OLS). Prepare sus datos -- vamos a modelar la relacion entre Saber 11 ingles y Saber Pro ingles."*

---

## Notas generales de presentacion (S03-S08)

- **Ritmo**: S03 es la mas densa (muchos conceptos nuevos). S04-S05 son mas procedimentales. S06 es conceptualmente pesada (p-valor, errores). S07 es amplia (muchas pruebas). S08 es un tema nuevo (categoricas). Ajustar segun preguntas del grupo.
- **Regla dual**: ejemplo cotidiano para el concepto -> datos ICFES solo cuando abrimos R. Hacer la transicion explicita cada vez.
- **Variedad de ejemplos**: S03 usa screen time, TikTok, Netflix, Spotify, Instagram. S04 usa Spotify, screen time, Rappi, delivery, encuestas. S05 usa iPhone/Android, Spotify/Apple Music. S06 usa lofi, TikTok viral, Instagram, emprendimiento. S07 usa apps de bienestar digital, TikTok y notas, ratings de apps. S08 usa genero y redes sociales, helados. No repetir el mismo ejemplo en slides consecutivos.
- **Demos en R**: al menos una demo en vivo por sesion. Los datos son ICFES, no los ejemplos cotidianos.
- **Participacion**: hacer preguntas directas al grupo cada ~10 min.
- **Tono**: natural, no forzado. Si un ejemplo no conecta, improvisar.
- **No condescender**: el ejemplo cotidiano es un ANCLA para la intuicion, no un sustituto de la matematica.
- **Preparacion para el parcial (S07)**: dedicar los ultimos 10-15 min a repasar temas clave y habilidades evaluables.
- **Despues del parcial (S08)**: retomar con energia. Los estudiantes vienen del parcial; empezar con algo visual (tabla de contingencia, mosaico) antes de la formalizacion.
