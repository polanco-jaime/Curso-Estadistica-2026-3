# Guia del Profesor -- Sesiones S09 a S13

> Documento interno. No publicar en GitHub.

## Filosofia: ejemplo cotidiano -> formalizacion -> R con datos reales

Cada concepto sigue esta secuencia:
1. **Ejemplo cotidiano Gen Z** (reel, TikTok, Spotify, matches, gaming) -> captura atencion, genera intuicion
2. **Formalizacion matematica** -> el slide ya tiene ambos lados
3. **Codigo en R con datos ICFES** -> solo cuando abrimos R, motivamos la herramienta con datos reales del programa

La transicion se hace explicita: *"Ya vieron como funciona con [ejemplo]. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

---

## S09 -- Regresion Lineal Simple / OLS (~1.5 h)

### Objetivo
El estudiante debe entender el modelo de regresion lineal simple como herramienta de prediccion, la logica de OLS como criterio de minimizacion, los supuestos de Gauss-Markov, el coeficiente de determinacion R-cuadrado, y las pruebas de significancia para los coeficientes. Al final, debe poder ajustar un modelo con `lm()`, interpretar el output de `summary()`, y entender la regresion con variable dummy como generalizacion del t-test.

### Slide 1-2: Titulo y Agenda
- Presentarse brevemente si hay caras nuevas.
- *"Hoy pasamos de describir relaciones a PREDECIR. Hasta ahora sabiamos que dos variables estan correlacionadas. Hoy vamos a construir una ecuacion que nos permita hacer predicciones concretas."*

### Slide 3: Motivacion: mas alla de la correlacion (-> predecir nota del parcial)
- **Abrir**: *"Hasta ahora calculamos correlaciones. Sabemos que r mide la fuerza de la relacion lineal. Pero r no nos deja PREDECIR. Si les digo que la correlacion entre horas de estudio y nota del parcial es 0.7, todavia no pueden decirme: 'si estudio 10 horas, cual va a ser mi nota.'"*
- **Conectar**: La regresion resuelve eso. Nos da una ecuacion, una recta, que permite predecir Y a partir de X. Ya no es solo "hay relacion", sino "cuanto cambia Y cuando X cambia en una unidad".
- **Formalizar**: Enfatizar las 3 limitaciones de la correlacion: no predice, es simetrica (cor(X,Y) = cor(Y,X)), no distingue dependiente de independiente.
- **Cerrar**: *"Pregunta de investigacion: podemos predecir el desempeno en ingles en Saber Pro a partir del puntaje de ingles en Saber 11? Para eso necesitamos un modelo de regresion."*

### Slide 4: El modelo de regresion lineal simple (-> formalizacion)
- **Abrir**: *"El modelo es una ecuacion sencilla: Y = beta_0 + beta_1 * X + error. Cada estudiante tiene un puntaje observado Y, un predictor X, y un error -- la parte que el modelo no captura."*
- **Conectar**: Recalcar que beta_0 y beta_1 son parametros poblacionales desconocidos. Los estimamos con los datos.
- **Formalizar**: Repasar cada componente: Y_i (respuesta), X_i (predictor), beta_0 (intercepto), beta_1 (pendiente), epsilon_i (error). *"El intercepto es el valor esperado de Y cuando X = 0. La pendiente es cuanto cambia Y por cada unidad que sube X."*
- **Cerrar**: *"Los betas con gorrito son las estimaciones que obtenemos de los datos. Eso es lo que R nos va a calcular."*

### Slide 5: Ecuacion estimada y valores ajustados (-> ejemplo numerico)
- **Abrir**: *"Supongamos que ya tenemos la ecuacion estimada: Y-hat = 45 + 1.8 * X. Si un estudiante saco 60 en Saber 11, predecimos que su puntaje en Saber Pro sera 45 + 1.8 * 60 = 153."*
- **Conectar**: Introducir el concepto de residuo: e = Y - Y-hat. *"Si su puntaje real fue 158, el residuo es 5. El modelo se equivoco por 5 puntos."*
- **Formalizar**: Y-hat es la prediccion, e es la distancia entre lo observado y lo predicho.
- **Cerrar**: *"El objetivo de OLS es encontrar la recta que haga esos residuos lo mas pequenos posible."*

### Slide 6: Visualizacion scatter plot + linea de regresion
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Ya vieron como funciona con el ejemplo de predecir notas a partir de horas de estudio. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

- Mostrar el scatter plot con `geom_smooth(method = "lm")`. Senalar la banda de confianza del 95%.
- *"Cada punto es un estudiante real. La linea roja es la recta OLS. La banda rosada es la incertidumbre."*

### Slide 7: Que linea elegir? (-> criterio de minimizacion)
- **Abrir**: *"Hay infinitas lineas que pasan por la nube de puntos. Cual es la mejor?"*
- **Conectar**: Presentar las 3 opciones: minimizar suma de errores absolutos, minimizar el error maximo, minimizar la suma de errores al cuadrado.
- **Formalizar**: OLS = Ordinary Least Squares. *"Al cuadrado porque los errores positivos y negativos no se cancelen, y porque penaliza mas los errores grandes."*
- **Cerrar**: *"OLS es el caballo de batalla de la estadistica. Vamos a ver por que funciona tan bien."*

### Slide 8: Metodo de Minimos Cuadrados Ordinarios (OLS)
- **Abrir**: *"OLS elige beta_0-hat y beta_1-hat que minimizan la suma de los residuos al cuadrado: SSE = suma de (Y_i - Y_hat_i)^2."*
- **Conectar**: *"En palabras simples: OLS busca la linea que mejor le pega a los datos."*
- **Formalizar**: Escribir la funcion objetivo en el tablero si es posible.
- **Cerrar**: *"Para encontrar el minimo, hacemos calculo: derivamos, igualamos a cero, y resolvemos."*

### Slide 9: Derivacion: ecuaciones normales (-> formalizacion pura)
- **Abrir**: *"Esto es calculo puro. Derivamos SSE respecto a beta_0 y beta_1, igualamos a cero."*
- **Conectar**: No hace falta ejemplo cotidiano aqui. Es formalizacion. Ir rapido pero claro.
- **Formalizar**: Las dos ecuaciones normales. Senalar que resolverlas nos da los estimadores OLS.
- **Cerrar**: *"De esas ecuaciones salen las formulas que vamos a usar."*

### Slide 10: Formulas de los estimadores OLS
- **Abrir**: *"Estas son las formulas estrella de la sesion."*
- **Conectar**: beta_1-hat = S_XY / S_XX. *"El numerador mide cuanto X e Y varian juntas. El denominador mide cuanto varia X sola."*
- **Formalizar**: Enfatizar que beta_0-hat = Y-barra - beta_1-hat * X-barra. *"La linea OLS SIEMPRE pasa por el punto (X-barra, Y-barra). Eso es una propiedad importante."*
- **Cerrar**: *"Ojo: no tienen que memorizar las formulas para el examen. Tienen la hoja de formulas. Lo que si tienen que saber es interpretarlas."*

### Slide 11: Relacion con la correlacion (-> horas de estudio)
- **Abrir**: *"beta_1-hat = r * (s_Y / s_X). La pendiente depende de la correlacion y de las desviaciones estandar."*
- **Conectar**: *"No solo sabemos que horas de estudio y nota estan correlacionadas, sino que cada hora adicional sube la nota en beta_1-hat puntos. Eso es el valor agregado de la regresion sobre la correlacion."*
- **Formalizar**: Si r = 0, beta_1 = 0. El signo de beta_1 es el de r.
- **Cerrar**: *"Correlacion nos dice SI hay relacion. Regresion nos dice CUANTO cambia Y por cada unidad de X."*

### Slide 12: Aplicacion en R: lm()
*[Frame de codigo R -- transicionar con la frase habitual]*

- Mostrar `lm(MOD_INGLES_PUNT ~ INGLES_SABER11_PUNT, data = icfes_ni)`.
- Interpretar los coeficientes: beta_0 = 45.23, beta_1 = 1.82.
- *"Por cada punto adicional en Saber 11, esperamos 1.82 puntos mas en Saber Pro."*
- **Cuidado con la extrapolacion**: *"beta_0 = 45.23 es el intercepto teorico, pero nadie saca 0 en Saber 11. No interpreten el intercepto fuera del rango de los datos."*

### Slide 13-14: Valores ajustados y residuos / Visualizacion de residuos
*[Frame de codigo R -- transicionar con la frase habitual]*

- `fitted()`, `residuals()`. Verificar que sum(residuos) ~ 0 y cor(X, residuos) ~ 0.
- Grafico de residuos vs valores ajustados: *"Idealmente, los residuos deben estar dispersos aleatoriamente alrededor de 0. Si ven un patron, algo anda mal."*
- Presentar los 3 patrones: embudo (heterocedasticidad), curva (no linealidad), aleatorio (ok).

---

**Transicion a supuestos**: *"Acabamos de ajustar un modelo y miramos los residuos. Pero para que nuestras estimaciones sean confiables, necesitamos que se cumplan ciertos supuestos."*

### Slide 15: Los supuestos clasicos de regresion lineal (-> Gauss-Markov)
- **Abrir**: *"Para que OLS sea el Mejor Estimador Lineal Insesgado -- BLUE por sus siglas en ingles -- necesitamos 5 supuestos."*
- **Conectar**: Enumerar los 5 uno por uno: linealidad, independencia, homocedasticidad, normalidad, exogeneidad.
- **Formalizar**: *"Si se cumplen los 4 primeros, OLS es BLUE. Si ademas se cumple normalidad, las pruebas t y F son validas."*
- **Cerrar**: *"En la Sesion 11 vamos a aprender a VERIFICAR estos supuestos con tests formales. Hoy solo los presentamos."*

### Slide 16: Consecuencias de violar los supuestos
- **Abrir**: *"Que pasa si se viola cada supuesto?"*
- **Conectar**: Repasar las 4 alertas del slide: linealidad violada -> sesgo, independencia violada -> errores estandar incorrectos, homocedasticidad violada -> ineficiencia, normalidad violada -> inferencia invalida en muestras pequenas.
- **Formalizar**: *"Cada violacion tiene solucion. No entren en panico si un supuesto no se cumple."*
- **Cerrar**: *"Soluciones tipicas: transformar variables, errores robustos, bootstrap, confiar en el TCL."*

### Slide 17: Verificacion de supuestos: graficos diagnosticos
*[Frame de codigo R -- transicionar con la frase habitual]*

- `par(mfrow = c(2,2)); plot(modelo1)`. Mostrar los 4 graficos diagnosticos.
- Explicar brevemente que buscar en cada uno.
- *"Estos 4 graficos son su primera linea de defensa. Siempre corranlos despues de ajustar cualquier modelo."*

---

**Transicion a R-cuadrado**: *"Ya tenemos el modelo, verificamos supuestos visualmente. Ahora necesitamos medir que tan bueno es el ajuste."*

### Slide 18: Descomposicion de la variabilidad: SST = SSR + SSE
- **Abrir**: *"La variabilidad total de Y se descompone en dos partes: lo que el modelo explica y lo que no."*
- **Conectar**: SST = variabilidad total, SSR = explicada por el modelo, SSE = no explicada.
- **Formalizar**: SST = SSR + SSE. Dividiendo por SST: 1 = SSR/SST + SSE/SST.
- **Cerrar**: *"R-cuadrado es exactamente SSR/SST: la proporcion de variabilidad explicada."*

### Slide 19: Coeficiente de determinacion R-cuadrado
- **Abrir**: *"R-cuadrado = SSR/SST = 1 - SSE/SST. Rango: de 0 a 1."*
- **Conectar**: *"Si R-cuadrado = 0.65, el 65% de la variabilidad del puntaje de ingles en Saber Pro se explica por el puntaje en Saber 11. El 35% restante se debe a otros factores."*
- **Formalizar**: R-cuadrado = 0 -> X no explica nada. R-cuadrado = 1 -> ajuste perfecto.
- **Cerrar**: Pasar al ejemplo de la vida cotidiana.

### Slide 20: Coeficiente de determinacion R-cuadrado (cont.) (-> notas vs horas de estudio)
- **Abrir**: *"Que porcentaje de la variacion en sus notas se explica por horas de estudio?"*
- **Conectar**: *"Si R-cuadrado = 0.6, el 60% de las diferencias en notas se explican por cuanto estudian. El 40% restante depende de otros factores: sueno, metodo de estudio, si almorzaron bien..."*
- **Formalizar**: R-cuadrado es siempre positivo (es un cuadrado), pero r puede ser negativo. El signo se ve en beta_1.
- **Cerrar**: *"En regresion simple, R-cuadrado = r-cuadrado. Eso es elegante: la correlacion al cuadrado es la proporcion de varianza explicada."*

### Slide 21: Relacion entre R-cuadrado y correlacion
- Repasar la formula R-cuadrado = r-cuadrado.
- Ejemplos numericos: r = 0.8 -> R-cuadrado = 0.64, r = -0.5 -> R-cuadrado = 0.25.

### Slide 22: Calculando R-cuadrado en R
*[Frame de codigo R -- transicionar con la frase habitual]*

- `summary(modelo1)$r.squared`. Verificar con `cor()^2` y con calculo manual de SST, SSR, SSE.

### Slide 23: Precauciones al interpretar R-cuadrado
- **Abrir**: *"R-cuadrado alto NO implica causalidad. R-cuadrado alto NO implica buen modelo de prediccion (puede haber overfitting). R-cuadrado bajo NO implica modelo inutil."*
- **Conectar**: *"En ciencias sociales, R-cuadrado = 0.20 puede ser razonable. No se obsesionen con que R-cuadrado sea alto."*
- **Formalizar**: Enfatizar las 3 alertas del slide.
- **Cerrar**: *"Ahora que medimos el ajuste, necesitamos saber si los coeficientes son estadisticamente significativos."*

---

**Transicion a significancia**: *"Tenemos betas estimados, tenemos R-cuadrado. Pero todo eso es muestral. Necesitamos saber si el efecto es real o solo ruido."*

### Slide 24: Varianza del error y MSE
- **Abrir**: *"Para hacer inferencia, necesitamos estimar sigma-cuadrado, la varianza del error."*
- **Conectar**: MSE = SSE / (n - 2). *"s = raiz de MSE es el error estandar de la regresion. Si s = 12, en promedio los valores observados se desvian +/- 12 puntos de la linea."*
- **Formalizar**: n - 2 grados de libertad porque estimamos 2 parametros.
- **Cerrar**: *"Con sigma estimada, podemos construir errores estandar para los betas."*

### Slide 25: Error estandar de beta_1-hat
- **Abrir**: *"beta_1-hat tiene su propia distribucion muestral, con su propio error estandar."*
- **Conectar**: SE(beta_1) = s / sqrt(S_XX). *"Mayor variabilidad en X -> menor error estandar. Mayor variabilidad residual -> mayor error estandar."*
- **Formalizar**: Bajo supuestos de normalidad: (beta_1-hat - beta_1) / SE(beta_1-hat) ~ t_{n-2}.
- **Cerrar**: *"Eso nos permite hacer pruebas t."*

### Slide 26: Prueba t para la pendiente
- **Abrir**: *"La hipotesis mas comun: H_0: beta_1 = 0 (no hay relacion lineal) vs H_1: beta_1 distinto de 0."*
- **Conectar**: t = beta_1-hat / SE(beta_1-hat). *"Si t es grande en valor absoluto, rechazamos H_0."*
- **Formalizar**: Regla de decision: rechazamos si |t| > t_{alpha/2, n-2} o si p-valor < alpha.
- **Cerrar**: *"Si rechazamos H_0, concluimos que la pendiente es estadisticamente diferente de cero: hay relacion lineal significativa."*

### Slide 27: Intervalo de confianza para beta_1 (-> IC con datos ICFES)
- **Abrir**: *"IC del 95% para beta_1: beta_1-hat +/- t * SE(beta_1-hat)."*
- **Conectar**: Ejemplo: IC = [1.65, 1.99]. *"Con 95% de confianza, por cada punto adicional en Saber 11, el puntaje en Saber Pro aumenta entre 1.65 y 1.99 puntos."*
- **Formalizar**: Si el IC no contiene 0, la pendiente es significativa.
- **Cerrar**: *"El IC es mas informativo que el p-valor porque nos da el rango de valores plausibles."*

### Slide 28: Aplicacion en R: summary(lm())
*[Frame de codigo R -- transicionar con la frase habitual]*

- Mostrar output completo de `summary(modelo1)`. Guiarlos linea por linea.

### Slide 29: Interpretando el output de summary()
- **Abrir**: *"Vamos a desmenuzar este output."*
- **Conectar**: Estimate, Std. Error, t value, Pr(>|t|). Las estrellitas. Residual standard error. Multiple R-squared. F-statistic.
- **Formalizar**: *"t = 92.09 para beta_1. p < 2e-16. Altamente significativo."*
- **Cerrar**: *"Existe una relacion lineal MUY significativa entre el ingles de Saber 11 y Saber Pro. Por cada punto adicional en Saber 11, esperamos 1.82 puntos mas en Saber Pro."*

### Slide 30: Intervalos de confianza para los coeficientes
*[Frame de codigo R -- transicionar con la frase habitual]*

- `confint(modelo1, level = 0.95)` y `confint(modelo1, level = 0.99)`.

### Slide 31: Prueba F global
- **Abrir**: *"En regresion simple, la prueba F global es equivalente a la prueba t para beta_1. F = t-cuadrado."*
- **Conectar**: H_0: beta_1 = 0 (modelo no util) vs H_1: beta_1 distinto de 0.
- **Formalizar**: F = MSR / MSE ~ F_{1, n-2}.
- **Cerrar**: *"En regresion multiple (S10), F prueba si TODOS los coeficientes son cero simultaneamente. Ahi F y t ya no son equivalentes."*

---

**Transicion a variable dummy**: *"Hasta ahora usamos un predictor numerico continuo. Pero que pasa si queremos comparar dos grupos?"*

### Slide 32: Variables dummy (indicadoras) (-> iPad en clase)
- **Abrir**: *"Una variable dummy es binaria: 0 o 1. Por ejemplo, 1 si la IES es privada, 0 si es publica."*
- **Conectar**: *"Otro ejemplo cercano: una variable que vale 1 si usan iPad en clase y 0 si no, o 1 si trabajan y 0 si no."*
- **Formalizar**: Definicion formal de la variable PRIVADA.
- **Cerrar**: *"Con una dummy, la regresion compara promedios entre dos grupos."*

### Slide 33: Variables dummy: modelo e interpretacion
- **Abrir**: *"MOD_INGLES = beta_0 + beta_1 * PRIVADA + error."*
- **Conectar**: beta_0 = promedio en publicas (PRIVADA = 0), beta_0 + beta_1 = promedio en privadas (PRIVADA = 1), beta_1 = diferencia entre los dos grupos.
- **Formalizar**: *"beta_1 es la diferencia promedio entre IES privadas y publicas."*
- **Cerrar**: *"Eso les suena familiar? Es exactamente lo que hace la prueba t de dos muestras."*

### Slide 34: Regresion con dummy en R
*[Frame de codigo R -- transicionar con la frase habitual]*

- Crear la variable dummy con `ifelse()`, ajustar modelo, interpretar.
- *"Puntaje promedio en publicas: 154.82. Privadas: 162.17. Diferencia: 7.35 puntos. Significativa."*

### Slide 35: Equivalencia con prueba t de dos muestras
*[Frame de codigo R -- transicionar con la frase habitual]*

- Mostrar `t.test(... var.equal = TRUE)`. *"El estadistico t de la regresion (12.67) es IDENTICO al de la prueba t de dos muestras. La regresion es una generalizacion poderosa."*
- **Punto clave**: *"Si entendieron regresion, ya entendieron el t-test como caso particular."*

### Slide 36: Visualizacion boxplot por grupo
*[Frame de codigo R -- transicionar con la frase habitual]*

### Slide 37-39: Ejemplo integrador (scatter, modelo, diagnostico)
*[Frames de codigo R -- transicionar con la frase habitual]*

- Ejemplo con razonamiento cuantitativo vs ingles Saber 11.
- Correlacion, modelo, diagnosticos, Breusch-Pagan.

### Slide 40-41: Ejemplo integrador: prediccion y visualizacion final
*[Frames de codigo R -- transicionar con la frase habitual]*

- `predict()` con IC y IP. *"El intervalo de prediccion es siempre mas amplio que el IC porque predecimos una observacion individual, no la media."*

### Slide 42: Resumen de la sesion
- Repasar los 5 conceptos clave y los 3 de inferencia.
- *"Modelo -> OLS -> Supuestos -> R-cuadrado -> Pruebas t y F -> Dummy = t-test."*

### Slide 43: Proxima sesion
- *"La proxima vez vamos a meter VARIOS predictores al mismo tiempo. Imaginen que quieren predecir su nota controlando por horas de estudio, screen time, y si trabajan. Eso es regresion multiple."*

---

## S10 -- Regresion Lineal Multiple (~1.5 h)

### Objetivo
El estudiante debe entender el modelo de regresion lineal multiple, interpretar coeficientes ceteris paribus, distinguir R-cuadrado de R-cuadrado ajustado, comprender el sesgo por variable omitida (OVB), diagnosticar multicolinealidad con VIF, y seleccionar modelos con AIC/BIC. Al final, debe saber que controlar por variables confusoras cambia los coeficientes, y por que eso importa.

### Slide 1-2: Titulo y Agenda
- *"Hoy damos el salto de un solo predictor a VARIOS. La regresion multiple es la herramienta mas usada en economia, ciencias sociales, y basicamente cualquier analisis serio con datos observacionales."*

### Slide 3: Mas alla de un solo predictor (-> predecir nota del parcial controlando por multiples factores)
- **Abrir**: *"En la sesion pasada usamos un solo predictor. Pero en la vida real, multiples factores influyen simultaneamente. El puntaje de ingles puede depender de Saber 11, estrato, tipo de IES, educacion de los padres, region..."*
- **Conectar**: *"Imaginen que quieren predecir su nota del parcial controlando por horas de estudio, screen time diario, y si trabajan. La regresion multiple permite aislar el efecto de cada factor."*
- **Formalizar**: Objetivo de regresion multiple: estimar el efecto de cada predictor CONTROLANDO POR los demas.
- **Cerrar**: *"La clave de la regresion multiple son esas 3 palabras: 'controlando por todo lo demas'. En latin: ceteris paribus."*

### Slide 4: El modelo de regresion lineal multiple
- **Abrir**: *"Y = beta_0 + beta_1 * X_1 + beta_2 * X_2 + ... + beta_p * X_p + error."*
- **Conectar**: beta_j = cambio esperado en Y cuando X_j aumenta en una unidad, manteniendo constantes todas las demas variables.
- **Formalizar**: Repasar cada componente.
- **Cerrar**: *"Esa interpretacion 'manteniendo constantes las demas' es FUNDAMENTAL. Si la olvidan, van a interpretar mal todo."*

### Slide 5: Ecuacion estimada
- **Abrir**: *"Estimamos con OLS, igual que antes: minimizar la suma de residuos al cuadrado."*
- **Conectar**: Mencionar brevemente la formula matricial (X'X)^{-1}X'Y. *"No entramos en detalle, pero R usa esta formula internamente."*
- **Formalizar**: Y-hat, residuos, SSE.
- **Cerrar**: *"La mecanica es la misma. Lo que cambia es la interpretacion."*

### Slide 6: Sintaxis en R: lm(Y ~ X1 + X2 + ...)
*[Frame de codigo R -- transicionar con la frase habitual]*

*"Ya vieron como funciona con el ejemplo de predecir la nota controlando por horas, screen time y trabajo. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

### Slide 7: Interpretacion de los coeficientes (-> ceteris paribus con datos ICFES)
- **Abrir**: *"Vamos a interpretar cada coeficiente."*
- **Conectar**: beta_1 = 1.67: por cada punto adicional en Saber 11, +1.67 en Saber Pro, manteniendo constantes estrato, tipo de IES y educacion del padre. beta_3 = 3.82: IES privadas obtienen 3.82 puntos mas que publicas, controlando por todo lo demas.
- **Formalizar**: Enfatizar "en promedio" y "controlando por".
- **Cerrar**: *"Noten que el efecto de Saber 11 bajo de 1.82 (modelo simple) a 1.67 (modelo multiple). Por que? Porque ahora controlamos por otros factores."*

---

**Transicion al modelo completo**: *"Vamos a agregar mas variables al modelo para ver como cambian los coeficientes."*

### Slide 8-9: Modelo extendido con transformaciones / Resultados del modelo completo
*[Frames de codigo R -- transicionar con la frase habitual]*

- Crear dummies regionales, log de ingresos, modelo completo.

### Slide 10: Interpretacion del modelo completo
- Repasar variables continuas y dummy. Enfatizar semi-elasticidad de log(ingresos).

### Slide 11: Interpretacion de dummies regionales (-> trap de la categoria de referencia)
- **Abrir**: *"Cuando tienen una variable categorica con k categorias, incluyen k-1 dummies. La que se omite es la categoria de referencia."*
- **Conectar**: Region Andina es la referencia. *"Caribe obtiene 2.54 puntos MENOS que Andina. Bogota obtiene 5.23 puntos MAS que Andina. Todo controlando por estrato, Saber 11, tipo IES, etc."*
- **Formalizar**: Alerta sobre la dummy variable trap: si incluyen todas las categorias, hay colinealidad perfecta.
- **Cerrar**: *"Siempre piensen: los coeficientes de las dummies son RELATIVOS a la categoria omitida."*

---

**Transicion a R-cuadrado ajustado**: *"En regresion simple, R-cuadrado era suficiente. En regresion multiple, necesitamos algo mas."*

### Slide 12: R-cuadrado en regresion multiple
- **Abrir**: *"R-cuadrado se define igual que antes. Pero tiene un problema: SIEMPRE aumenta o se mantiene al agregar variables, incluso si son irrelevantes."*
- **Conectar**: Ejemplo con 3 modelos: R-cuadrado sube de 0.65 a 0.66 a 0.662 al agregar variables, incluso si X_3 es ruido puro.
- **Formalizar**: R-cuadrado nunca decrece al agregar variables.
- **Cerrar**: *"Necesitamos una medida que penalice la complejidad."*

### Slide 13: R-cuadrado en regresion multiple (cont.) (-> filtros de una foto)
- **Abrir**: *"Agregar variables es como agregar filtros a una foto: siempre se ve 'mejor', pero no necesariamente mas real."*
- **Conectar**: La analogia esta en el slide. Usarla tal cual.
- **Formalizar**: Solucion: R-cuadrado ajustado.
- **Cerrar**: *"R-cuadrado ajustado SI puede bajar si agregamos variables inutiles."*

### Slide 14: R-cuadrado ajustado
- **Abrir**: *"R-cuadrado ajustado = 1 - (MSE / MST). Penaliza por el numero de predictores."*
- **Conectar**: R_adj <= R. R_adj puede disminuir si agregamos una variable irrelevante.
- **Formalizar**: Formula, propiedades.
- **Cerrar**: *"Para comparar modelos con diferente numero de variables, SIEMPRE usar R-cuadrado ajustado."*

### Slide 15-16: Comparacion R-cuadrado vs R-cuadrado ajustado / Cuando usar
*[Frame de codigo R -- transicionar con la frase habitual]*

---

**Transicion a significancia**: *"Ahora que tenemos R-cuadrado ajustado, vamos a las pruebas de significancia."*

### Slide 17: Prueba F global
- **Abrir**: *"La prueba F global prueba si ALGUN predictor es util. H_0: todos los betas son cero."*
- **Conectar**: Si rechazamos H_0, al menos una variable es significativa. El modelo en conjunto es util.
- **Formalizar**: F = MSR / MSE ~ F_{p, n-p-1}. F = R^2/p / ((1-R^2)/(n-p-1)).
- **Cerrar**: *"Un F grande significa que el modelo explica mucho mas de lo que esperariamos por azar."*

### Slide 18: Relacion entre F y R-cuadrado
- Ejemplo numerico con R-cuadrado = 0.714, p = 8, n = 5085.

### Slide 19: Prueba t individual
- **Abrir**: *"La prueba t individual prueba si UN coeficiente especifico es significativo, controlando por los demas."*
- **Conectar**: H_0: beta_j = 0 vs H_1: beta_j distinto de 0. *"El resultado puede cambiar drasticamente si agregamos o quitamos predictores."*
- **Formalizar**: t_j = beta_j-hat / SE(beta_j-hat) ~ t_{n-p-1}.
- **Cerrar**: *"No confundir la prueba t individual con la F global. F prueba TODOS juntos. t prueba UNO a la vez."*

### Slide 20: Interpretando el output de summary()
*[Frame de codigo R -- transicionar con la frase habitual]*

- *"Todas las variables son significativas EXCEPTO Region Pacifica (p = 0.092). No difiere significativamente de la Andina al 5%."*

### Slide 21: Significancia conjunta vs individual
- **Abrir**: *"Puede pasar que F global sea significativa pero ningun coeficiente individual lo sea. Eso se llama multicolinealidad."*
- **Conectar**: *"Es como un equipo de futbol: juntos ganan partidos, pero no puedes decir cual jugador es el mas importante porque todos dependen de los demas."*
- **Formalizar**: Causas: multicolinealidad, tamano muestral pequeno, efectos debiles pero multiples.
- **Cerrar**: *"Siempre reportar ambas pruebas. Si hay discrepancia, investigar VIF."*

---

**Transicion a OVB**: *"Ahora viene uno de los conceptos mas importantes del curso: el sesgo por variable omitida."*

### Slide 22: Que es el sesgo por variable omitida? (-> iPad vs ingresos)
- **Abrir**: *"El OVB ocurre cuando omitimos una variable relevante que esta correlacionada con un predictor incluido. En ese caso, los coeficientes estimados estan sesgados."*
- **Conectar**: *"Si no controlan por nivel socioeconomico, podrian pensar que tener iPad mejora las notas, cuando en realidad es que familias de mayores ingresos compran iPads Y ADEMAS invierten mas en educacion."*
- **Formalizar**: Dos condiciones: (1) la variable omitida afecta a Y, (2) esta correlacionada con X.
- **Cerrar**: *"Cada vez que ven una correlacion 'interesante' en Twitter, preguntense: que variable omitida podria explicar ambas cosas?"*

### Slide 23: Formula del sesgo
- **Abrir**: *"Podemos cuantificar la direccion del sesgo."*
- **Conectar**: E(gamma_1) = beta_1 + beta_2 * Cov(X_1, X_2) / Var(X_1). *"El sesgo depende de dos cosas: el efecto de la variable omitida y su correlacion con el predictor incluido."*
- **Formalizar**: Si ambos son positivos, sesgo positivo (sobreestimacion). Si tienen signos opuestos, sesgo negativo.
- **Cerrar**: *"Veamoslo con datos."*

### Slide 24-25: Ejemplo empirico: efecto de IES privada (sin y con estrato)
*[Frame de codigo R -- transicionar con la frase habitual]*

- Modelo omitido: PRIVADA = 7.35. Modelo con estrato: PRIVADA = 4.12. *"El efecto de IES privada estaba INFLADO por el OVB. Al controlar por estrato, el efecto baja de 7.35 a 4.12."*

### Slide 26: Ejemplo empirico: explicacion del cambio
- **Abrir**: *"ESTRATO correlacionado positivamente con PRIVADA. ESTRATO tiene efecto positivo en ingles. Sesgo positivo: gamma_1 > beta_1."*
- **Conectar**: *"Los estudiantes de IES privadas tienen estrato mas alto en promedio (3.21 vs 2.43). Sin controlar, PRIVADA cargaba con el efecto del estrato."*
- **Formalizar**: Direccion del sesgo.
- **Cerrar**: *"Por eso es TAN importante controlar por confundidores."*

### Slide 27: Verificar la correlacion entre PRIVADA y ESTRATO
*[Frame de codigo R -- transicionar con la frase habitual]*

### Slide 28: Implicaciones del OVB (-> regla de oro)
- **Abrir**: *"Nunca concluir causalidad solo con regresion observacional."*
- **Conectar**: *"Si ven que 'usar iPad' se asocia con mejores notas, preguntense: que variable omitida podria explicar ambas cosas?"*
- **Formalizar**: Estrategias: incluir todas las variables relevantes, variables instrumentales, disenos experimentales.
- **Cerrar**: *"Ahora veamos otro problema clasico: cuando los predictores estan demasiado correlacionados entre si."*

---

**Transicion a VIF**: *"OVB es un problema de variables faltantes. Multicolinealidad es un problema de variables redundantes."*

### Slide 29: Que es la multicolinealidad? (-> TikTok e Instagram)
- **Abrir**: *"La multicolinealidad ocurre cuando dos o mas predictores estan altamente correlacionados entre si."*
- **Conectar**: *"Horas en TikTok y horas en Instagram miden casi lo mismo: screen time en redes. Si meten ambas en el modelo, hay multicolinealidad. El modelo no puede separar el efecto de cada una."*
- **Formalizar**: Tipos: perfecta (rara) y alta (comun). Consecuencias: errores estandar inflados, coeficientes inestables.
- **Cerrar**: *"Importante: la multicolinealidad NO afecta R-cuadrado ni la capacidad de prediccion. Solo afecta la interpretacion de los coeficientes individuales."*

### Slide 30: Factor de Inflacion de la Varianza (VIF)
- **Abrir**: *"El VIF mide cuanto se infla la varianza de beta_j-hat debido a la correlacion con otros predictores."*
- **Conectar**: VIF_j = 1 / (1 - R_j^2), donde R_j^2 es el R-cuadrado de regresionar X_j contra las demas X.
- **Formalizar**: VIF = 1 -> no correlacion. VIF = 5 -> la varianza es 5 veces mayor.
- **Cerrar**: *"Reglas de pulgar: VIF < 5 ok, 5-10 preocupante, >= 10 severo."*

### Slide 31: Reglas de pulgar para VIF
- Soluciones: eliminar variable, combinar (indice/promedio), PCA, regularizacion, aumentar n.

### Slide 32-33: Calcular VIF en R / Ejemplo con multicolinealidad severa
*[Frames de codigo R -- transicionar con la frase habitual]*

- Mostrar VIF normales (todos < 5), luego crear ESTRATO_x2 y mostrar VIF = 5432.

---

**Transicion a seleccion de modelos**: *"Ya sabemos diagnosticar multicolinealidad. Ahora: como elegimos el mejor modelo entre varios candidatos?"*

### Slide 34: Criterios de informacion: AIC y BIC
- **Abrir**: *"Queremos el modelo que mejor balance ajuste y complejidad. AIC y BIC nos ayudan."*
- **Conectar**: Menor AIC/BIC -> mejor modelo. BIC penaliza mas la complejidad que AIC.
- **Formalizar**: Formulas de AIC y BIC.
- **Cerrar**: *"AIC para prediccion, BIC para inferencia."*

### Slide 35: AIC vs BIC
- Comparar filosofias: teoria de informacion vs teoria bayesiana.

### Slide 36-37: Calcular AIC y BIC en R / Comparar con BIC
*[Frames de codigo R -- transicionar con la frase habitual]*

### Slide 38-39: Seleccion automatica con step() / Precaucion
*[Frame de codigo R -- transicionar con la frase habitual]*

- **Alerta**: *"La seleccion automatica puede llevar a overfitting. Usenla como exploracion, pero siempre validen con teoria."*

---

**Transicion a interacciones**: *"Hasta ahora asumimos que el efecto de cada variable es constante. Pero que pasa si el efecto de X_1 DEPENDE del nivel de X_2?"*

### Slide 40: Que es una interaccion? (-> iPad y acceso a internet)
- **Abrir**: *"Una interaccion ocurre cuando el efecto de X_1 sobre Y depende del nivel de X_2."*
- **Conectar**: *"El efecto de IES privada sobre ingles es el mismo para todos los estratos, o es mayor en estratos altos? Similar a preguntarse: el efecto de usar iPad en las notas es igual para todos, o depende de si ademas tienen acceso a internet en casa?"*
- **Formalizar**: Modelo con interaccion: Y = beta_0 + beta_1*X_1 + beta_2*X_2 + beta_3*(X_1 * X_2) + error.
- **Cerrar**: *"beta_3 mide como cambia el efecto de X_1 cuando X_2 sube en una unidad."*

### Slide 41: Interpretacion matematica de la interaccion
- Efecto marginal de X_1 = beta_1 + beta_3 * X_2. Si beta_3 = 0, no hay interaccion.

### Slide 42: Ejemplo: interaccion PRIVADA x ESTRATO
*[Frame de codigo R -- transicionar con la frase habitual]*

### Slide 43: Interpretacion del modelo con interaccion
- **Abrir**: *"El efecto de PRIVADA segun ESTRATO: estrato 1 -> +3.23 puntos, estrato 3 -> +5.01, estrato 5 -> +6.79."*
- **Conectar**: *"El efecto de IES privada AUMENTA con el estrato: 0.89 puntos adicionales por cada nivel de estrato."*
- **Formalizar**: Interaccion marginalmente significativa (p = 0.087).
- **Cerrar**: *"En la practica, si la interaccion no es significativa, a menudo se mantiene el modelo sin interaccion. Pero siempre vale la pena explorar."*

### Slide 44-46: Visualizacion de la interaccion / Interaccion continua x continua
*[Frames de codigo R -- transicionar con la frase habitual]*

### Slide 47: Resumen de regresion multiple
- Modelo, interpretacion ceteris paribus, OLS, R-cuadrado ajustado, AIC/BIC.
- Prueba F global, prueba t individual, reportar ambas + IC.

### Slide 48: Problemas comunes y soluciones
- OVB, multicolinealidad, interacciones.

### Slide 49: Checklist para analisis de regresion multiple
- 8 pasos: exploracion -> ajuste -> ajuste global -> significancia individual -> diagnosticos -> seleccion -> interacciones -> reporte.

### Slide 50-51: Ejemplo final reporte profesional / Proximos pasos
- *"La proxima sesion vamos a aprender a VERIFICAR los supuestos del modelo con tests formales y graficos diagnosticos."*

---

## S11 -- Diagnosticos de Regresion (~1.5 h)

### Objetivo
El estudiante debe saber verificar los supuestos de OLS con graficos diagnosticos y tests formales (Breusch-Pagan, Durbin-Watson), identificar observaciones influyentes con la distancia de Cook, y corregir heterocedasticidad con errores estandar robustos (Huber-White). Al final, debe poder ejecutar el protocolo completo de diagnosticos despues de cualquier modelo OLS.

### Slide 1-2: Titulo y Agenda
- *"Hoy vamos a aprender a verificar si el modelo que ajustaron realmente se comporta bien. Los diagnosticos son como el control de calidad: no los pueden saltar."*

### Slide 3: Los supuestos del modelo OLS (-> recapitulacion Gauss-Markov)
- **Abrir**: *"Recuerden los 5 supuestos de Gauss-Markov de la Sesion 9: linealidad, exogeneidad, homocedasticidad, no autocorrelacion, normalidad."*
- **Conectar**: Si se cumplen 1-4, OLS es BLUE. Si se cumple 5, las pruebas t y F son validas.
- **Formalizar**: Repasar brevemente cada supuesto con la tabla del slide.
- **Cerrar**: *"Hoy aprendemos a VERIFICAR cada uno."*

### Slide 4: Que pasa si se violan los supuestos? (-> notas de ingles y trabajo medio tiempo)
- **Abrir**: *"Cada violacion tiene consecuencias diferentes."*
- **Conectar**: Tabla: supuesto violado -> consecuencia -> sintoma. *"Piensen en las notas de ingles: la variabilidad es mayor entre estudiantes que trabajan medio tiempo -- sus resultados son mas impredecibles que los de quienes se dedican solo a estudiar. Eso es heterocedasticidad."*
- **Formalizar**: Repasar la tabla.
- **Cerrar**: *"Fijense que en heterocedasticidad, los betas siguen insesgados pero los errores estandar son INCORRECTOS. Eso invalida toda la inferencia."*

### Slide 5: El papel de los diagnosticos (-> ciclo estimar-diagnosticar-corregir)
- **Abrir**: *"Diagnosticos = verificar supuestos DESPUES de estimar."*
- **Conectar**: Mostrar el ciclo TikZ: Estimar -> Diagnosticar -> Corregir -> Re-estimar (loop).
- **Formalizar**: Los diagnosticos nos dicen si necesitamos transformar variables, agregar/eliminar variables, usar errores robustos, o cambiar de modelo.
- **Cerrar**: *"Es un proceso iterativo. Rara vez un modelo sale perfecto a la primera."*

### Slide 6: Herramientas diagnosticas en R
- **Abrir**: *"R tiene todo lo que necesitamos."*
- **Conectar**: `plot(modelo)`, `residuals()`, `fitted()`, `rstandard()`, `cooks.distance()`, `bptest()`, `dwtest()`, `vif()`.
- **Formalizar**: *"Estrategia: empezar con plot(modelo) y luego profundizar con tests formales."*
- **Cerrar**: *"Vamos a ver los 4 graficos diagnosticos uno por uno."*

---

**Transicion a los 4 graficos**: *"La funcion plot(modelo) genera 4 graficos automaticamente. Son su primera linea de defensa."*

### Slide 7: Los 4 graficos de plot(modelo)
*[Frame de codigo R -- transicionar con la frase habitual]*

- `par(mfrow = c(2,2)); plot(modelo)`. Enumerar los 4: Residuals vs Fitted, Normal Q-Q, Scale-Location, Residuals vs Leverage.

### Slide 8: Grafico 1: Residuals vs Fitted (-> patron ideal vs problematico)
- **Abrir**: *"Eje X: valores ajustados. Eje Y: residuos. Linea roja: tendencia suavizada (loess)."*
- **Conectar**: Ideal: puntos dispersos aleatoriamente, linea roja horizontal. Problema 1: curvatura -> no linealidad. Problema 2: embudo -> heterocedasticidad.
- **Formalizar**: Mostrar los dos diagramas TikZ (patron ideal vs problematico).
- **Cerrar**: *"Si ven curvatura, hay que transformar variables. Si ven embudo, necesitan errores robustos."*

### Slide 9: Grafico 1: Patrones visuales
- Columna izquierda: patron ideal. Columna derecha: patron problematico. Usar los diagramas TikZ del slide.

### Slide 10: Grafico 2: Normal Q-Q (-> normalidad de residuos)
- **Abrir**: *"Eje X: cuantiles teoricos de N(0,1). Eje Y: residuos estandarizados. Si los puntos siguen la diagonal, los residuos son normales."*
- **Conectar**: Desviaciones leves son normales. Preocuparse solo si la desviacion es marcada y afecta muchos puntos.
- **Formalizar**: Colas pesadas: puntos se alejan en los extremos. Asimetria: curvatura en S.
- **Cerrar**: *"Con n grande, el TCL nos salva. Pero con n pequeno, la normalidad importa mucho."*

### Slide 11: Grafico 2: Patrones Q-Q
- Columna izquierda: normalidad (bueno). Columna derecha: colas pesadas (malo).

### Slide 12: Grafico 3: Scale-Location (-> heterocedasticidad)
- **Abrir**: *"Eje X: valores ajustados. Eje Y: raiz de |residuos estandarizados|. Detecta heterocedasticidad de manera mas clara."*
- **Conectar**: Ideal: linea roja horizontal. Problema: linea roja con pendiente.
- **Formalizar**: Al elevar al cuadrado (raiz cuadrada), se enfatiza la dispersion.
- **Cerrar**: *"Este grafico complementa el Residuals vs Fitted."*

### Slide 13: Grafico 3: Patrones Scale-Location
- Columna izquierda: homocedasticidad. Columna derecha: heterocedasticidad.

### Slide 14: Grafico 4: Residuals vs Leverage (-> observaciones influyentes)
- **Abrir**: *"Eje X: leverage (apalancamiento). Eje Y: residuos estandarizados. Lineas punteadas: isolineas de distancia de Cook."*
- **Conectar**: Leverage: que tan extremo es X_i respecto al centro. Residuo: que tan lejos esta Y_i de Y-hat_i. Observacion influyente: alto leverage + alto residuo.
- **Formalizar**: Puntos fuera de Cook D > 0.5 o D > 1 merecen investigacion.
- **Cerrar**: *"Estas observaciones cambian mucho los coeficientes si las quitamos."*

### Slide 15: Grafico 4: Interpretacion
- Diagrama TikZ con punto influyente en rojo.

### Slide 16-17: Ejemplo en R: generando los 4 graficos / graficos individuales
*[Frames de codigo R -- transicionar con la frase habitual]*

- `plot(modelo, which = 1)`, etc. Nota: el grafico 5 (Residuals vs Leverage) es mas util que el 4 (Cook's distance barplot).

### Slide 18: Interpretacion conjunta de los graficos
- Tabla resumen: grafico -> detecta -> solucion.

### Slide 19: Estrategia practica de diagnostico (-> subir foto a Instagram)
- **Abrir**: *"El proceso de diagnostico es como subir una foto a Instagram."*
- **Conectar**: *"Primero la toman, luego revisan si salio bien (diagnosticos), aplican filtros si es necesario (correcciones) y vuelven a revisar antes de publicar."*
- **Formalizar**: 5 pasos: ajustar modelo -> generar graficos -> tests formales si hay problemas -> corregir -> re-estimar.
- **Cerrar**: *"Ahora vamos a formalizar la deteccion de heterocedasticidad con un test estadistico."*

---

**Transicion a Breusch-Pagan**: *"Miramos los graficos. Ahora necesitamos un test formal para decir si hay heterocedasticidad o no."*

### Slide 20: El supuesto de homocedasticidad
- **Abrir**: *"Homocedasticidad: la varianza del error es constante para todas las observaciones. Heterocedasticidad: no es constante."*
- **Conectar**: Definicion formal.
- **Formalizar**: Var(epsilon_i | X) = sigma^2 (constante) vs sigma_i^2 (variable).
- **Cerrar**: Pasar a los ejemplos.

### Slide 21: El supuesto de homocedasticidad (cont.) (-> screen time y variabilidad de notas)
- **Abrir**: *"Homocedasticidad: estudiantes de todos los estratos tienen la misma dispersion en ingles despues de controlar por las X."*
- **Conectar**: *"Heterocedasticidad: es como el screen time. Entre quienes pasan mas de 6 horas en redes, la variabilidad de notas es enorme -- algunos rinden bien y otros no. Para quienes pasan menos de 2 horas, la variabilidad es menor."*
- **Formalizar**: Los dos ejemplos del slide: homocedasticidad (misma incertidumbre para todos) vs heterocedasticidad (mas incertidumbre para algunos grupos).
- **Cerrar**: *"Veamos las consecuencias."*

### Slide 22: Consecuencias de la heterocedasticidad
- **Abrir**: *"Los coeficientes beta-hat siguen insesgados. PERO ya no son eficientes (BLUE se pierde), los errores estandar son incorrectos, y los IC y pruebas t/F son invalidas."*
- **Conectar**: La formula verdadera de la varianza con Omega = diag(sigma_1^2, ..., sigma_n^2).
- **Formalizar**: El problema no es sesgo, es PRECISION. Los errores estandar OLS subestiman o sobreestiman la incertidumbre real.
- **Cerrar**: *"Necesitamos un test para detectar esto."*

### Slide 23: Test de Breusch-Pagan
- **Abrir**: *"H_0: homocedasticidad (varianza constante). H_1: heterocedasticidad."*
- **Conectar**: Procedimiento en 4 pasos: estimar modelo -> calcular e_i^2 -> regresar e_i^2 contra las X -> extraer R^2 de esa regresion auxiliar.
- **Formalizar**: BP = n * R^2 ~ chi^2_k.
- **Cerrar**: *"Si BP es grande, rechazamos H_0."*

### Slide 24: Test de Breusch-Pagan: estadistico y decision
- Continuacion del procedimiento. Si BP > chi^2_{k, alpha} o p < alpha, hay heterocedasticidad.

### Slide 25-26: Breusch-Pagan en R / Interpretacion
*[Frames de codigo R -- transicionar con la frase habitual]*

- `library(lmtest); bptest(modelo)`. BP = 38.472, df = 4, p < 0.001. *"Rechazamos H_0: hay heterocedasticidad."*

### Slide 27: Variantes del test de Breusch-Pagan
- BP estandar, BP estudentizado (default en R), test de White (mas general).
- *"Regla practica: empezar con Breusch-Pagan. Si hay muchas variables, usar White."*

### Slide 28: Visualizacion de heterocedasticidad
- Columna izquierda: homocedasticidad (dispersion constante). Columna derecha: heterocedasticidad (embudo).

---

**Transicion a autocorrelacion**: *"Heterocedasticidad resuelta. Ahora veamos otro supuesto: no autocorrelacion."*

### Slide 29: El supuesto de no autocorrelacion (-> series de tiempo)
- **Abrir**: *"No autocorrelacion: los errores de diferentes observaciones no estan correlacionados."*
- **Conectar**: Comun en series de tiempo. Menos comun en corte transversal (como ICFES). Consecuencias similares a heterocedasticidad.
- **Formalizar**: Cor(epsilon_i, epsilon_j) = 0 para todo i distinto de j.
- **Cerrar**: *"Para datos de corte transversal como ICFES, la autocorrelacion es rara. Pero tenemos que verificar."*

### Slide 30: Test de Durbin-Watson
- **Abrir**: *"DW = suma de (e_i - e_{i-1})^2 / suma de e_i^2."*
- **Conectar**: DW ~ 2: ok. DW < 2: autocorrelacion positiva. DW > 2: autocorrelacion negativa.
- **Formalizar**: Regla practica: si 1.5 < DW < 2.5, no hay problema.
- **Cerrar**: *"Veamoslo en R."*

### Slide 31-32: Durbin-Watson en R / Interpretacion
*[Frames de codigo R -- transicionar con la frase habitual]*

- `dwtest(modelo)`. DW = 1.98, p = 0.45. *"No rechazamos H_0. No hay autocorrelacion."*

### Slide 33: Visualizacion de autocorrelacion
- Columna izquierda: sin autocorrelacion (patron aleatorio). Columna derecha: autocorrelacion positiva (rachas).

---

**Transicion a Cook's D**: *"Supuestos de varianza cubiertos. Ahora: observaciones influyentes."*

### Slide 34: Conceptos: leverage y residuos
- **Abrir**: *"Leverage mide que tan extremo es X_i. Residuo mide que tan lejos esta Y_i de la prediccion."*
- **Conectar**: Alto leverage: $h_{ii}$ alto. Alto residuo: e_i grande. Influyente: ambos altos.
- **Formalizar**: h_{ii} = diagonal de la hat matrix. Promedio: (k+1)/n. Alto si > 2 * promedio.
- **Cerrar**: *"Una observacion influyente es la que tiene AMBOS: alto leverage Y alto residuo."*

### Slide 35: Distancia de Cook (-> estudiante que falto a todo pero saco 5.0)
- **Abrir**: *"La distancia de Cook mide cuanto cambiarian TODOS los coeficientes si eliminaramos la observacion i."*
- **Conectar**: *"Imaginen un estudiante que falto a todos los parciales pero saco 5.0 en el final -- ese caso distorsiona el modelo de prediccion de notas. Eso es una observacion influyente."*
- **Formalizar**: D_i = (e_i^2 / (p * MSE)) * h_{ii} / (1 - h_{ii})^2. Regla: D_i > 4/n merece investigacion. D_i > 1 es muy influyente.
- **Cerrar**: *"Ojo: NO eliminar automaticamente. Primero investigar."*

### Slide 36: Tipos de observaciones (-> diagrama TikZ)
- 4 tipos: normales (bajo leverage, bajo residuo), outlier (bajo leverage, alto residuo), alto leverage (alto leverage, bajo residuo), influyente (alto leverage Y alto residuo).
- Usar el diagrama TikZ del slide con puntos de colores.

### Slide 37-38: Calculando Cook's D en R / Graficando
*[Frames de codigo R -- transicionar con la frase habitual]*

- `cooks.distance(modelo)`, umbral = 4/n, `plot()` con linea roja.

### Slide 39: Que hacer con observaciones influyentes?
- **Abrir**: *"NO eliminar automaticamente. Eliminar observaciones sin justificacion es manipular los datos."*
- **Conectar**: 4 pasos: verificar datos (error de entrada?), contextualizar (caso especial?), re-estimar sin la observacion, reportar sensibilidad.
- **Formalizar**: *"Reportar: 'Resultados robustos a exclusion de observaciones influyentes' o 'Las conclusiones cambian al excluir...'"*
- **Cerrar**: *"Siempre investigar antes de eliminar."*

### Slide 40: Observaciones influyentes: ejemplo (-> Netflix autodidacta)
- **Abrir**: *"Dos ejemplos contrastantes."*
- **Conectar**: Error de datos: MOD_INGLES_PUNT = 300 (maximo es 100 en la escala relevante) -> eliminar. *"Es como cuando alguien tiene 200 anos en una base de datos -- obviamente algo salio mal."* Caso legitimo: estudiante de estrato 1 que saco 95 en ingles -> NO eliminar. *"Es atipico pero real, como alguien que aprendio ingles viendo series en Netflix sin subtitulos."*
- **Formalizar**: Distinguir error de datos de outlier legitimo.
- **Cerrar**: *"El outlier legitimo se reporta como analisis de sensibilidad."*

### Slide 41: Analisis de sensibilidad
*[Frame de codigo R -- transicionar con la frase habitual]*

- Modelo completo vs modelo sin influyentes. Comparar con `texreg::screenreg()`.

---

**Transicion a errores robustos**: *"Ya detectamos heterocedasticidad. Ahora la solucion: errores estandar robustos."*

### Slide 42: La solucion a la heterocedasticidad (-> errores robustos Huber-White)
- **Abrir**: *"Ante heterocedasticidad, podemos: transformar variables, usar WLS, o simplemente usar errores estandar robustos."*
- **Conectar**: Ventajas: los coeficientes NO cambian, solo cambian los errores estandar (se corrigen), no requiere especificar la forma de heterocedasticidad.
- **Formalizar**: Los IC y pruebas t se vuelven validos.
- **Cerrar**: *"Los errores robustos son la solucion mas practica."*

### Slide 43: La solucion a la heterocedasticidad (cont.) (-> filtro de correccion)
- **Abrir**: *"Si hay heterocedasticidad, SIEMPRE reportar errores robustos."*
- **Conectar**: *"Los errores robustos corrigen las estimaciones cuando la varianza no es constante -- como ponerle un filtro de correccion a una foto que salio sobreexpuesta."*
- **Formalizar**: Regla practica.
- **Cerrar**: *"Veamos los tipos."*

### Slide 44: Tipos de errores robustos
- HC0 (White original), HC1 (mas comun en econometria), HC2 (usa leverage), HC3 (conservadora).
- *"Cual usar? HC1 por defecto. HC3 si n < 250 o hay alto leverage."*

### Slide 45: Errores robustos en R
*[Frame de codigo R -- transicionar con la frase habitual]*

- `library(sandwich); library(lmtest); coeftest(modelo, vcov = vcovHC(modelo, type = "HC1"))`.

### Slide 46-47: Comparacion: errores clasicos vs robustos
- **Abrir**: *"Miren: los coeficientes son IDENTICOS. Solo cambian los errores estandar."*
- **Conectar**: Los SE aumentaron (especialmente para PRIVADA). Algunas variables pueden perder significancia.
- **Formalizar**: Comparar columna por columna.
- **Cerrar**: *"El mensaje es claro: los errores clasicos eran demasiado optimistas."*

### Slide 48: Intervalos de confianza robustos
*[Frame de codigo R -- transicionar con la frase habitual]*

- IC clasicos vs robustos. *"Los IC robustos son mas amplios. Reflejan la mayor incertidumbre real."*

### Slide 49: Cuando usar errores robustos?
- Tabla: BP rechaza H_0 -> usar robustos. n > 1000 -> usar robustos. Publicacion academica -> usar robustos.
- *"En econometria moderna, es estandar reportar SIEMPRE errores robustos."*

### Slide 50: Limitaciones de los errores robustos
- *"Los errores robustos NO corrigen sesgos. Si el modelo esta mal especificado (variable omitida, no linealidad), los errores robustos no ayudan."*

---

**Transicion al ejemplo integrado**: *"Ahora vamos a poner todo junto con un ejemplo completo paso a paso."*

### Slide 51-54: Ejemplo completo: diagnosticos paso a paso
*[Frames de codigo R -- transicionar con la frase habitual]*

- Cargar datos, estimar modelo, graficos diagnosticos, BP test, DW test, VIF, Cook's D, errores robustos, analisis de sensibilidad.

### Slide 55: Interpretacion del ejemplo
- 5 hallazgos esperados: heterocedasticidad (BP rechaza), normalidad (Q-Q leve desviacion pero n grande), influyentes (5-10), autocorrelacion (DW ~ 2 ok), multicolinealidad (VIF bajo).

### Slide 56: Checklist de diagnosticos
- 7 pasos del protocolo estandar. *"Nunca reportar resultados OLS sin verificar supuestos."*

### Slide 57: Tabla resumen: problemas y soluciones
- Tabla completa: problema -> test -> deteccion -> solucion.

### Slide 58: Proxima sesion
- *"La proxima sesion vamos a aplicar TODO lo aprendido en el curso a un analisis completo con datos ICFES: el pipeline estadistico de principio a fin."*

---

## S12 -- Integracion y Analisis Aplicado (~1.5 h)

### Objetivo
El estudiante debe integrar TODAS las herramientas del curso (descriptiva, IC, pruebas de hipotesis, regresion, diagnosticos) en un analisis completo con datos ICFES. Esta sesion es esencialmente un ejemplo aplicado de principio a fin, mas retroalimentacion del PS8.

### Slide 1-2: Titulo y Agenda
- *"Hoy es la sesion de integracion. Vamos a hacer un analisis estadistico COMPLETO: desde la pregunta de investigacion hasta las conclusiones, pasando por EDA, IC, pruebas, regresion y diagnosticos. Todo con datos ICFES de Negocios Internacionales."*

### Slide 3: El pipeline estadistico completo (-> diagrama TikZ)
- **Abrir**: *"Este es el flujo completo: Pregunta -> Datos -> EDA -> IC -> Pruebas -> Modelo -> Diagnosticos -> Conclusiones."*
- **Conectar**: Mostrar el diagrama TikZ con las flechas de retroalimentacion. *"Los diagnosticos pueden llevarnos a re-especificar el modelo. Las conclusiones pueden generar nuevas preguntas."*
- **Formalizar**: Proceso iterativo, no lineal.
- **Cerrar**: *"Hoy recorremos todo el pipeline con un caso real."*

### Slide 4: El pipeline estadistico: proceso iterativo (-> cocinar)
- **Abrir**: *"Cada paso informa el siguiente."*
- **Conectar**: *"Es como cocinar: primero los ingredientes (datos), luego la preparacion (limpieza), la coccion (modelo), y la presentacion del plato (conclusiones). Si queman algo en la coccion (diagnosticos fallan), toca volver atras y ajustar."*
- **Formalizar**: Los datos cuentan una historia -- nuestro trabajo es descubrirla con rigor.
- **Cerrar**: *"Veamos por que importa hacer el pipeline completo."*

### Slide 5: Por que importa el pipeline completo? (-> TikTok sin editar)
- **Abrir**: *"Mal analisis vs buen analisis."*
- **Conectar**: Mal analisis: *"Saltar directamente a regresion, no explorar los datos, ignorar supuestos. Es como publicar un TikTok sin editar: sale cualquier cosa."* Buen analisis: *"Guion, grabacion, edicion, revision y publicacion."*
- **Formalizar**: Los 5 puntos de cada columna.
- **Cerrar**: *"Objetivo de hoy: aplicar el pipeline completo a datos ICFES de NI."*

### Slide 6: Caso de estudio: competencia en ingles en NI
- **Abrir**: *"Pregunta de investigacion: Que factores socioeconomicos y academicos determinan el desempeno en ingles de estudiantes de Negocios Internacionales en Colombia?"*
- **Conectar**: Relevancia: informar politicas de admision y nivelacion, identificar grupos vulnerables, evaluar equidad.
- **Formalizar**: Variable dependiente: MOD_INGLES_PUNT.
- **Cerrar**: *"Empecemos con formular bien la pregunta."*

---

**Transicion a Paso 1**: *"Antes de tocar los datos, necesitamos una pregunta clara."*

### Slide 7: Formulando una buena pregunta de investigacion
- **Abrir**: *"Clara, medible, relevante, acotada."*
- **Conectar**: *"Recuerden la sesion de descriptiva (S01): primero hay que saber QUE queremos medir antes de calcular medias y desviaciones. La pregunta es el GPS de todo el analisis."*
- **Formalizar**: 4 caracteristicas.
- **Cerrar**: *"Veamos la diferencia entre una pregunta vaga y una especifica."*

### Slide 8: Formulando una buena pregunta: ejemplo
- Izquierda: pregunta vaga. Derecha: pregunta especifica con variable dependiente, independientes, y poblacion bien definidas.

### Slide 9: Operacionalizacion de variables
- Tabla: concepto -> variable -> medicion. MOD_INGLES_PUNT, ESTU_ESTRATO, PRIVADA, PUNT_INGLES_S11, ESTU_GENERO, REGION.

---

**Transicion a Paso 2**: *"Pregunta formulada. Ahora a cargar y limpiar los datos."*

### Slide 10-15: Cargar datos, filtrar, crear variables, tratar NAs, verificar
*[Frames de codigo R -- transicionar con la frase habitual]*

*"Ya vieron como funciona con el ejemplo de la receta de cocina. Ahora vamos a hacer lo mismo pero con datos reales de estudiantes como ustedes, en R."*

### Slide 16: Valores faltantes: consideraciones (-> limpiar playlist de Spotify)
- **Abrir**: *"na.omit() elimina TODAS las filas con algun NA. Puede ser demasiado drastico."*
- **Conectar**: *"Es como limpiar su playlist de Spotify: no borren todo, solo las canciones que realmente no sirven. Cada dato que eliminan es informacion que pierden."*
- **Formalizar**: Mejor: eliminar NA solo en variables clave. Reportar cuantas observaciones se perdieron.
- **Cerrar**: *"Siempre reportar la limpieza."*

---

**Transicion a Paso 3**: *"Datos limpios. Ahora a explorar."*

### Slide 17-22: EDA: descriptivos, desagregacion por estrato/IES/region, visualizaciones
*[Frames de codigo R -- transicionar con la frase habitual]*

### Slide 23: EDA: hallazgos preliminares (-> tabla por estrato)
- **Abrir**: *"Miren la tabla: relacion positiva clara entre estrato y puntaje."*
- **Conectar**: Gradiente: estrato 1 = 138.5, estrato 6 = 178.3. Diferencia de 40 puntos. La variabilidad disminuye con el estrato.
- **Formalizar**: Estos son estadisticos muestrales. Necesitamos IC y pruebas para saber si reflejan la poblacion.
- **Cerrar**: *"Estas diferencias son estadisticamente significativas? Necesitamos pruebas formales."*

### Slide 24: EDA: hallazgos preliminares (cont.)
- *"Recuerden S03 (muestreo): necesitamos IC y pruebas para saber si reflejan la poblacion."*

### Slide 25-26: EDA: scatterplot Saber 11 vs Saber Pro / Proporcion B1
*[Frames de codigo R -- transicionar con la frase habitual]*

---

**Transicion a Paso 4**: *"EDA nos dio pistas. Ahora cuantifiquemos la incertidumbre con IC."*

### Slide 27-28: IC para la media por region / Resultados
*[Frames de codigo R -- transicionar con la frase habitual]*

### Slide 29: Forest plot de IC por region
*[Frame de codigo R -- transicionar con la frase habitual]*

- *"Si dos IC NO se superponen, hay diferencia significativa. Orinoquia tiene mayor incertidumbre por menor n."*

### Slide 30-31: IC para proporciones / Resultados
*[Frames de codigo R -- transicionar con la frase habitual]*

- *"IES privadas: 35.6% alcanza B1. Publicas: 23.7%. Los IC no se superponen: diferencia significativa."*

---

**Transicion a Paso 5**: *"IC nos dieron el rango. Ahora las pruebas formales para decidir."*

### Slide 32-33: Prueba t: publica vs privada / Conclusion
*[Frame de codigo R -- transicionar con la frase habitual]*

- t = -11.23, p < 0.001. *"IES privadas puntuan 11.5 puntos mas en promedio."*

### Slide 34: ANOVA: diferencias entre regiones
*[Frame de codigo R -- transicionar con la frase habitual]*

- F(3, 2830) = 52.34, p < 0.001. *"Hay diferencias significativas entre regiones. Tukey identifica cuales pares."*

### Slide 35-36: Chi-cuadrado: nivel MCER x tipo IES / Resultados
*[Frames de codigo R -- transicionar con la frase habitual]*

- Chi-cuadrado = 87.345, df = 2, p < 0.001. *"Hay asociacion significativa."*

### Slide 37-38: Tamano del efecto: d de Cohen / Interpretacion
*[Frame de codigo R -- transicionar con la frase habitual]*

- d = 0.62 (efecto mediano). *"La diferencia publica-privada es significativa Y sustantiva."*

---

**Transicion a Paso 6**: *"Descriptiva, IC, pruebas. Ahora el modelo de regresion para cuantificar relaciones controlando por multiples factores."*

### Slide 39: Modelo simple: solo estrato
*[Frame de codigo R -- transicionar con la frase habitual]*

- beta_ESTRATO = 7.234. R-cuadrado = 0.134. *"El estrato explica solo 13.4%. Queda mucho sin explicar."*

### Slide 40-41: Modelo multiple / Conclusiones
*[Frame de codigo R -- transicionar con la frase habitual]*

- *"Controlando por otras variables, el efecto del estrato se reduce de 7.2 a 2.1. El puntaje en Saber 11 es el predictor mas fuerte (t = 25.76). R-cuadrado sube a 0.428."*

### Slide 42: Sesgo de variable omitida (OVB) (-> comparacion modelo1 vs modelo2)
- **Abrir**: *"Miren la tabla comparativa: el coeficiente de estrato bajo de 7.234 a 2.134."*
- **Conectar**: En modelo1, ESTRATO captura su efecto directo MAS el efecto indirecto de variables omitidas. Al incluir PRIVADA y PUNT_S11, el efecto se purifica.
- **Formalizar**: Tabla comparativa: Modelo 1 vs Modelo 2.
- **Cerrar**: *"El efecto causal 'verdadero' del estrato es ~2.1 puntos, no 7.2."*

### Slide 43: OVB: explicacion del cambio (-> aislar ingredientes en receta)
- **Abrir**: *"Por que cambio el coeficiente?"*
- **Conectar**: *"Recuerden S10 (OLS multiple): controlar variables es como aislar el efecto de un solo ingrediente en una receta -- hay que mantener todo lo demas constante para saber que aporta cada uno."*
- **Formalizar**: Estudiantes de estrato alto tienden a ir a IES privadas y tener mejor Saber 11.
- **Cerrar**: *"Por eso siempre controlamos por confundidores."*

### Slide 44: Interpretacion de coeficientes
*[Frame de codigo R -- transicionar con la frase habitual]*

- Interpretar cada coeficiente ceteris paribus. Enfatizar que ESTU_GENERO no es significativo (p = 0.118).
- *"Recordar: estos son efectos parciales, no causales. Datos observacionales."*

---

**Transicion a Paso 7**: *"Modelo ajustado. Ahora diagnosticos."*

### Slide 45: Diagnosticos graficos
*[Frame de codigo R -- transicionar con la frase habitual]*

- `par(mfrow = c(2,2)); plot(modelo2)`. Checklist de que buscar en cada grafico.

### Slide 46: Test de Breusch-Pagan
*[Frame de codigo R -- transicionar con la frase habitual]*

- BP = 38.472, p < 0.001. *"Hay heterocedasticidad. Usar errores robustos."*

### Slide 47: Observaciones influyentes
*[Frame de codigo R -- transicionar con la frase habitual]*

- Cook's D, umbral 4/n, investigar influyentes.

---

**Transicion a Paso 8**: *"Pipeline completo. Ahora las conclusiones."*

### Slide 48: Sintesis de hallazgos
- **Abrir**: *"5 resultados principales."*
- **Conectar**: 1) Desempeno general: promedio 154.3, nivel A2/B1. 2) Gradiente socioeconomico: +2.1 puntos por estrato. 3) Brecha publico-privada: +5.4 puntos. 4) Persistencia: Saber 11 es el predictor mas fuerte. *"Las brechas vienen desde el colegio -- como cuando el algoritmo de una red social te encasilla desde el principio."* 5) No hay diferencias por genero.
- **Formalizar**: Cada resultado con IC.
- **Cerrar**: *"Ahora las implicaciones."*

### Slide 49: Implicaciones para politica educativa
- 5 recomendaciones: nivelacion al ingreso, intervencion temprana en secundaria, equidad en recursos para IES publicas, becas para inmersion, monitoreo continuo.
- *"Estas recomendaciones se basan en la evidencia estadistica que acabamos de producir."*

### Slide 50: Limitaciones del analisis
- Causalidad vs correlacion, variables omitidas, heterocedasticidad, generalizacion.
- *"Un buen analisis admite lo que NO puede concluir."*

### Slide 51: Futuras investigaciones
- Estudios experimentales, analisis longitudinales, variables de proceso.

---

**Transicion a retroalimentacion PS8**: *"Ahora vamos a la retroalimentacion del Problem Set 8."*

### Slide 52: Retroalimentacion PS8: errores comunes
- **Abrir**: *"5 errores comunes que observe."*
- **Conectar**: 1) No reportar diagnosticos. 2) Interpretar coeficientes sin controles (decir "el estrato causa X"). 3) Ignorar errores robustos. 4) No reportar tamano del efecto. 5) Graficos sin etiquetas.
- **Formalizar**: Solucion para cada error.
- **Cerrar**: *"Estos errores les costaran puntos en el proyecto final. Evitarlos."*

### Slide 53: Buenas practicas observadas
- Analisis exploratorio robusto, comparacion de modelos, analisis de sensibilidad, visualizaciones efectivas, interpretacion contextualizada, codigo reproducible.
- *"El codigo es parte del informe. Debe ser legible y reproducible."*

### Slide 54: Rubrica para el proyecto final
- Tabla con criterios y puntos. *"Lean la rubrica ANTES de empezar el proyecto. No despues."*

---

### Slide 55: El pipeline estadistico: repaso (-> diagrama TikZ de 8 pasos)
- Recorrer el diagrama vertical. *"Este es el mapa que deben seguir en el proyecto final."*

### Slide 56: Lecciones clave (-> OLS sin diagnosticos = postear sin revisar)
- **Abrir**: *"7 principios del analisis estadistico riguroso."*
- **Conectar**: 1) Explorar antes de modelar. 2) Controlar confundidores. 3) Verificar supuestos: *"OLS sin diagnosticos es como postear sin revisar -- puede salir muy mal."* 4) Reportar incertidumbre. 5) Interpretar en contexto. 6) Reconocer limitaciones. 7) Ser reproducible.
- **Formalizar**: Cada principio en una bala.
- **Cerrar**: *"Estos principios aplican a cualquier analisis que hagan en su carrera."*

### Slide 57: Proxima sesion
- *"La proxima sesion es el repaso final. Traigan todas sus dudas, su borrador de hoja de formulas, y calculadora."*

---

## S13 -- Repaso Final y Preparacion para el Examen (~1.5 h)

### Objetivo
El estudiante debe consolidar los conceptos de las 4 unidades del curso, practicar problemas tipo examen, y salir con un mapa mental claro de como se conectan descriptiva, IC, pruebas y regresion.

### Slide 1-2: Titulo y Agenda
- *"Hoy repasamos todo el semestre. El objetivo es que salgan de aqui con las ideas claras y un plan de estudio para el examen."*

### Slide 3: Las 4 unidades del curso (-> diagrama TikZ)
- **Abrir**: *"El curso tiene 4 unidades que se construyen una sobre otra."*
- **Conectar**: Mostrar el diagrama TikZ 2x2 con las flechas: U1 -> U2 (Cuantificar), U1 -> U3 (Decidir), U2 -> U4 (Modelar), U3 -> U4 (Explicar).
- **Formalizar**: Cada flecha tiene un verbo. Recorrer las 4 unidades.
- **Cerrar**: *"Todo se integra en un analisis completo, como lo hicimos en S12."*

### Slide 4: Las 4 unidades del curso: conexiones (-> screen time, encuestas, ruido, receta)
- **Abrir**: *"Como se conectan las unidades?"*
- **Conectar**: U1: fundamento -- *"recuerden el screen time para la media y la desviacion estandar."* U2: incertidumbre -- *"el margen de error de las encuestas electorales."* U3: decisiones -- *"hay diferencia real o es solo ruido?"* U4: modelar relaciones -- *"cuanto pesa cada factor en el puntaje de ingles?"*
- **Formalizar**: Todo se integra en un analisis completo (como la receta de S12).
- **Cerrar**: *"Veamos el diagrama de conexiones conceptuales."*

### Slide 5: Diagrama de conexiones conceptuales (-> diagrama TikZ)
- Recorrer el diagrama: Datos -> Descriptiva + Probabilidad -> Muestreo -> IC + Pruebas -> Regresion -> Diagnosticos -> Conclusiones (con loop de retroalimentacion).

### Slide 6: Cronologia de sesiones
- Tabla de sesiones S01-S13 con tema, unidad y peso en el examen.
- *"El examen es ACUMULATIVO, con mayor peso en U2-U4."*

---

**Transicion a repaso U1**: *"Vamos a repasar unidad por unidad. Empezamos con U1."*

### Slide 7: U1: Medidas de tendencia central y dispersion (-> millonario en el salon)
- **Abrir**: *"Media, mediana, moda. Varianza, desviacion estandar, IQR, CV."*
- **Conectar**: *"Recuerden: un millonario en el salon sube el promedio de ingresos de todos. La mediana ni se entera."*
- **Formalizar**: Formulas de media, varianza, DE.
- **Cerrar**: *"Estas formulas deben ir en su hoja de formulas."*

### Slide 8: U1: Medidas de forma
- Asimetria y curtosis. Formulas.

### Slide 9: U1: Correlacion de Pearson
- Formula, rango [-1, 1], limitacion: solo lineal.

### Slide 10: U1: Correlacion de Spearman
- Formula con rangos, robusta a outliers.

### Slide 11: U1: Paradoja de Simpson
- Ejemplo clasico. *"Siempre desagregar por variables confundidoras."*

### Slide 12: U1: Distribucion normal
- Formula, funciones en R, regla 68-95-99.7.

### Slide 13: U1: Teorema Central del Limite (-> screen time)
- **Abrir**: *"El TCL es el teorema mas importante del curso."*
- **Conectar**: *"Aunque el screen time individual de cada uno sea bien raro, el promedio de 100 estudiantes se comporta normal."*
- **Formalizar**: X-barra ~ N(mu, sigma^2/n) cuando n -> infinito.
- **Cerrar**: *"El TCL justifica todos los IC y pruebas que hacemos."*

### Slide 14: U1: Distribucion t de Student
- Cuando sigma es desconocida. df = n - 1. Converge a N(0,1).

### Slide 15: U1: Distribucion chi-cuadrado
- Para varianzas y pruebas de independencia/bondad de ajuste.

---

**Transicion a repaso U2**: *"U1 cubierta. Ahora U2: intervalos de confianza."*

### Slide 16: U2: IC para la media (sigma conocida)
- Formula: x-barra +/- z * sigma/sqrt(n).

### Slide 17: U2: IC para la media (sigma desconocida)
- Formula: x-barra +/- t * s/sqrt(n). Ejemplo numerico.

### Slide 18: U2: IC para la varianza
- Formula con chi-cuadrado. Asimetrico. Requiere normalidad.

### Slide 19: U2: IC para proporciones
- Formula de Wald. Condiciones: np >= 10, n(1-p) >= 10.

### Slide 20: U2: Tamano de muestra para mu
- n = (z * sigma / E)^2. Ejemplo.

### Slide 21: U2: Tamano de muestra para p
- n = (z / E)^2 * p(1-p). Si p desconocida, usar 0.5.

### Slide 22: U2: Tabla resumen de formulas de IC
- Tabla completa: parametro -> formula -> condiciones. *"Esta tabla DEBE ir en su hoja de formulas."*

### Slide 23: U2: Valores criticos comunes
- 90%: z = 1.645. 95%: z = 1.96. 99%: z = 2.576. *"Memoricen estos tres."*

---

**Transicion a repaso U3**: *"U2 cubierta. Ahora U3: pruebas de hipotesis."*

### Slide 24: U3: Pasos de una prueba de hipotesis
- 6 pasos: plantear hipotesis, elegir alpha, calcular estadistico, calcular p-valor, decision, conclusion.
- *"Siempre los mismos 6 pasos, sin importar el tipo de prueba."*

### Slide 25: U3: Errores tipo I y II (-> filtro de spam)
- **Abrir**: *"Error tipo I: rechazar H_0 cuando es verdadera. Error tipo II: no rechazar cuando es falsa."*
- **Conectar**: *"Tipo I: como cuando el filtro de spam bloquea un email importante. Tipo II: como cuando el filtro deja pasar spam."*
- **Formalizar**: alpha = P(Tipo I), beta = P(Tipo II), Potencia = 1 - beta.
- **Cerrar**: *"El alpha lo controlamos nosotros (generalmente 0.05). El beta depende del tamano del efecto, n, y alpha."*

### Slide 26: U3: Tabla de pruebas parametricas
- Tabla: situacion -> prueba -> estadistico -> gl. 1 muestra, 2 muestras, pareada, ANOVA, chi-cuadrado, correlacion.
- *"Esta tabla es CLAVE para el examen. Saber cual prueba usar en cada situacion."*

### Slide 27-28: U3: Prueba t de una muestra / Ejemplo
- Formula, ejemplo numerico completo.

### Slide 29-30: U3: Prueba t de Welch / Ejemplo en R
*[Frame de codigo R]*

### Slide 31-32: U3: ANOVA / Post-hoc Tukey
- Formula F = MS_entre / MS_dentro. Si F rechaza, usar Tukey para pares.

### Slide 33-34: U3: Chi-cuadrado de independencia / Ejemplo
- Formula chi^2 = sum (O-E)^2/E. gl = (r-1)(c-1).

### Slide 35: U3: Pruebas no parametricas
- Tabla: parametrica -> no parametrica. Wilcoxon, Mann-Whitney, Kruskal-Wallis.
- *"Usar cuando los datos no son normales y n es pequeno."*

### Slide 36: U3: No parametricas - ejemplo
*[Frame de codigo R]*

### Slide 37: U3: d de Cohen
- Formula, interpretacion: < 0.2 trivial, 0.2-0.5 pequeno, 0.5-0.8 mediano, >= 0.8 grande.

### Slide 38: U3: Potencia
- Depende de tamano del efecto, n, alpha. Objetivo: >= 0.80.

---

**Transicion a repaso U4**: *"U3 cubierta. Ahora U4: regresion."*

### Slide 39: U4: Modelo de regresion lineal simple
- Modelo, estimadores OLS.

### Slide 40-41: U4: Modelo de regresion multiple / Ejemplo
- Modelo, interpretacion ceteris paribus. Ejemplo con datos ICFES.

### Slide 42: U4: R-cuadrado
- SST, SSR, SSE. Interpretacion.

### Slide 43: U4: R-cuadrado ajustado
- Penaliza por numero de variables.

### Slide 44: U4: Prueba t para beta_j
- H_0: beta_j = 0. Estadistico t.

### Slide 45: U4: Prueba F global
- H_0: todos los betas son 0. F = (R^2/k) / ((1-R^2)/(n-k-1)).

### Slide 46: U4: Sesgo de variable omitida (-> Wi-Fi vs 20 pestanas)
- **Abrir**: *"OVB: omitir una variable relevante correlacionada con un predictor sesga los coeficientes."*
- **Conectar**: *"El efecto del estrato baja de 7.2 a 2.1 al controlar por otras variables -- como culpar solo al Wi-Fi cuando el problema real es que tenian 20 pestanas abiertas."*
- **Formalizar**: Ejemplo numerico.
- **Cerrar**: *"Controlar por confundidores es fundamental."*

### Slide 47: U4: Multicolinealidad
- Consecuencias: SE inflados, coeficientes inestables.

### Slide 48: U4: VIF
- Formula, reglas de pulgar.

### Slide 49: U4: Diagnosticos de regresion (-> estudiante que falto pero saco 5.0)
- Checklist: plot(modelo), Breusch-Pagan, Cook's D, VIF.
- *"Recuerden el ejemplo del estudiante que falto a todo pero saco 5.0 en el final -- eso es una observacion influyente."*

### Slide 50: U4: Errores robustos
*[Frame de codigo R]*

- `coeftest(modelo, vcov = vcovHC(modelo, type = "HC1"))`.

### Slide 51: U4: Errores robustos -- recordar
- Coeficientes NO cambian. Solo cambian SE, p-valores, IC.

---

**Transicion a problemas tipo examen**: *"Ahora practiquemos con problemas tipo examen."*

### Slide 52: Problema 1: Interpretar output de regresion
- Output de summary(lm()). 4 preguntas: interpretar PRIVADA, significancia de ESTRATO, varianza explicada, modelo util.
- **Dar 5 minutos para que trabajen solos. Luego resolver juntos.**

### Slide 53-54: Problema 1: Soluciones (partes 1 y 2)
- Resolver paso a paso. Enfatizar lenguaje de asociacion, no causal.

### Slide 55: Problema 2: IC y prueba de hipotesis
- n = 100, x-barra = 158.5, s = 20.3. IC 95%, probar mu = 155.
- **Dar 5 minutos. Resolver juntos.**

### Slide 56: Problema 2: Soluciones
- IC: [154.5, 162.5]. t = 1.72, p = 0.088. No rechazamos. Consistente: 155 esta dentro del IC.

### Slide 57: Problema 3: Chi-cuadrado de independencia
- Tabla de contingencia. Hipotesis, frecuencia esperada, conclusion.
- **Dar 3 minutos. Resolver juntos.**

### Slide 58: Problema 3: Soluciones
- E = 126.9. chi^2 = 45.6 > 5.99. Rechazamos. Hay asociacion.

### Slide 59: Problema 4: OVB y multicolinealidad
- Dos modelos. Preguntas sobre OVB, modelo mejor, VIF.
- **Dar 3 minutos. Resolver juntos.**

### Slide 60: Problema 4: Soluciones
- OVB: estrato captura efecto de variables omitidas. Modelo B mejor. VIF = 12.5 indica multicolinealidad severa.

### Slide 61: Problema 5: Ensayo corto
- Asesor del Ministerio de Educacion. 2 politicas basadas en evidencia.
- *"Este tipo de pregunta mide su capacidad de conectar estadistica con decisiones. No es solo numeros -- es pensar con los numeros."*

---

**Transicion a estructura del examen**: *"Ahora la logistica."*

### Slide 62: Estructura del examen final
- Fecha, horario, formato, materiales permitidos (calculadora + hoja A4 de formulas).

### Slide 63: Partes del examen
- Conceptual (30 pts), calculo (30 pts), interpretacion (20 pts), ensayo (20 pts).

### Slide 64: Contenidos del examen (por unidad)
- U1: 15%, U2: 25%, U3: 30%, U4: 30%. *"Enfasis en U2-U4."*

### Slide 65: Estrategias de estudio (-> explicar por WhatsApp)
- **Abrir**: *"6 estrategias para prepararse."*
- **Conectar**: Repasar slides y PS, practicar calculos a mano, crear hoja de formulas, repasar interpretaciones de output, estudiar en grupo. *"Si pueden explicarselo a alguien por WhatsApp, lo entendieron."* Hacer simulacros.
- **Formalizar**: Las 6 estrategias.
- **Cerrar**: *"La hoja de formulas es una forma de estudio en si misma."*

### Slide 66: Recursos de estudio
- Slides, PS 1-8 con soluciones, grabaciones.

### Slide 67: Hoja de formulas: que incluir?
- Lista de 17 formulas sugeridas. *"La hoja NO sustituye el entendimiento. Usenla como apoyo, no como muleta."*

---

**Transicion a instrucciones del proyecto**: *"Antes de cerrar, las instrucciones del proyecto final."*

### Slide 68: Proyecto final: presentacion oral
- Fecha, duracion (10 min + 3 de preguntas), contenido (pregunta, datos, resultados, conclusiones).

### Slide 69: Proyecto final: informe escrito
- Formato (PDF, max 15 paginas), estructura, entrega.

### Slide 70: Rubrica del proyecto (recordatorio)
- Tabla con criterios. 60% informe + 40% presentacion.

### Slide 71: Consejos para el proyecto: errores comunes
- No reportar diagnosticos, graficos sin etiquetas, interpretar sin controlar, solo p-valores, codigo no reproducible.

### Slide 72: Consejos para el proyecto: buenas practicas
- Comenzar temprano, dividir tareas, iterar, visualizar bien, contextualizar.

---

**Transicion al cierre**: *"Cerremos el curso."*

### Slide 73: Recapitulacion: habilidades tecnicas
- Describir, visualizar, IC, pruebas, regresion, diagnosticos, R.

### Slide 74: Recapitulacion: habilidades conceptuales (-> helado y ahogamientos)
- **Abrir**: *"Mas alla de las formulas, lo mas importante es el pensamiento critico."*
- **Conectar**: *"Distinguir correlacion de causalidad -- recuerden: que el helado y los ahogamientos suban juntos no significa que uno cause el otro."*
- **Formalizar**: Pensar criticamente, reconocer limitaciones, comunicar resultados, integrar tecnicas.
- **Cerrar**: *"Estas habilidades les van a servir en cualquier carrera."*

### Slide 75: Mas alla del curso
- Aplicaciones en NI: analisis de mercados, evaluacion de politicas comerciales, consultoria, investigacion.

### Slide 76: Recursos para seguir aprendiendo
- Libros: "The Effect", "Causal Inference: The Mixtape". Cursos: Coursera, edX. Comunidades: R-Ladies, Stack Overflow. Practica: Kaggle, datos abiertos DANE.

### Slide 77: Reflexion final
- *"La estadistica no es solo matematicas. Es una forma de pensar sobre el mundo con rigor, humildad y curiosidad."*
- *"Gracias por su esfuerzo, participacion y compromiso a lo largo del semestre. Ha sido un placer acompanarlos."*

### Slide 78: Horarios de consulta antes del examen
- Lunes 24 (oficina 305, U2-U3), miercoles 26 (oficina 305, U4 + problemas), jueves 26 (Zoom, preguntas abiertas).
- *"Respondere emails hasta el jueves 26 a las 18:00. No envien preguntas el viernes."*

### Slide 79: Cierre
- *"Nos vemos el viernes 27 a las 7:00 para las presentaciones del proyecto. Exito en el examen y en el proyecto!"*

---

## Notas generales de presentacion

- **Ritmo**: S09 y S10 son densas (mucho contenido nuevo). S11 es mas practica (enfasis en R y diagnosticos). S12 es de integracion (ritmo mas pausado, dar espacio para discusion). S13 es de repaso (ir rapido en la teoria, dedicar tiempo a los problemas tipo examen).
- **Regla dual**: ejemplo cotidiano para el concepto -> datos ICFES solo cuando abrimos R. Hacer la transicion explicita cada vez: *"Ya vieron como funciona con [iPad/TikTok/Instagram/Netflix]. Ahora con datos reales en R."*
- **Demos en R**: S09-S11 tienen bastante codigo. Hacer demo en vivo si hay tiempo. S12 puede funcionar como taller guiado si el grupo esta receptivo.
- **Participacion**: En S09-S11, hacer preguntas sobre interpretacion: *"Que significa este coeficiente? Es significativo? Como lo saben?"* En S12, preguntar sobre el pipeline: *"Que paso viene despues? Por que?"* En S13, dejar que resuelvan los problemas solos antes de resolverlos juntos.
- **Tono**: Los ejemplos Gen Z (iPad, TikTok, Instagram, Netflix, Spotify, receta, foto sobreexpuesta, filtro de spam) deben sentirse naturales. Si un ejemplo no conecta, improvisar.
- **No condescender**: Los ejemplos cotidianos son ANCLAS para la intuicion, no sustitutos de la matematica. La formalizacion se mantiene intacta.
- **S13 especial**: Dedicar al menos 25 minutos a los problemas tipo examen. Idealmente, que los estudiantes trabajen en parejas o individualmente antes de socializar las respuestas.
