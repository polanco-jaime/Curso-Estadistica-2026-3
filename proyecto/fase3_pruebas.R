# ============================================================================
# Proyecto Estadistico - Fase 3: Regresion OLS e Informe Final
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Entrega: Nov 27 2026 | Presentacion oral: 10 min
# ============================================================================
#
# OBJETIVO: Modelar la relacion entre Saber 11 y Saber Pro usando regresion OLS
# - Regresion simple: 1 predictor Saber 11 -> 1 respuesta Saber Pro
# - Regresion multiple: 4+ predictores Saber 11 -> MOD_INGLES_PUNT
# - Diagnosticos completos: linealidad, normalidad, homocedasticidad,
#   multicolinealidad, observaciones influyentes
# - Errores robustos (HC1) con sandwich/lmtest
#
# ============================================================================

# --- Cargar paquetes ---------------------------------------------------------
library(tidyverse)  # Manipulacion de datos y visualizacion
library(car)        # VIF, Breusch-Pagan, diagnosticos avanzados
library(lmtest)     # Pruebas de diagnostico (bptest, coeftest)
library(sandwich)   # Errores estandar robustos (HC1)

# --- Cargar datos ------------------------------------------------------------
# TODO: Cargar el dataset cruzado Saber11-SaberPro desde BigQuery o CSV
# datos <- read.csv("../../datos/cruce_saber11_saberpro.csv")

# TODO: Filtrar por programa Negocios Internacionales
# datos <- datos %>%
#   filter(PROGRAMA == "Negocios Internacionales")

# TODO: Verificar estructura de datos
# glimpse(datos)

# TODO: Eliminar NA en variables clave (Saber 11 y Saber Pro)
# datos <- datos %>%
#   filter(
#     !is.na(PUNT_INGLES),
#     !is.na(PUNT_MATEMATICAS),
#     !is.na(PUNT_LECTURA_CRITICA),
#     !is.na(PUNT_SOCIALES_CIUDADANAS),
#     !is.na(PUNT_CIENCIAS_NATURALES),
#     !is.na(MOD_INGLES_PUNT),
#     !is.na(MOD_RAZONA_CUANTITAT_PUNT),
#     !is.na(MOD_LECTURA_CRITICA_PUNT)
#   )


# =============================================================================
# 1. REGRESION LINEAL SIMPLE (OLS)
# =============================================================================

# PREGUNTA: Como predice el puntaje de ingles en Saber 11 (PUNT_INGLES)
# el puntaje de ingles en Saber Pro (MOD_INGLES_PUNT)?

# Modelo: MOD_INGLES_PUNT = beta_0 + beta_1 * PUNT_INGLES + epsilon

# --- 1.1 Visualizacion inicial ----------------------------------------------
# TODO: Grafico de dispersion con linea de regresion
# ggplot(datos, aes(x = PUNT_INGLES, y = MOD_INGLES_PUNT)) +
#   geom_point(alpha = 0.3) +
#   geom_smooth(method = "lm", se = TRUE, color = "blue") +
#   labs(title = "Relacion entre Saber 11 Ingles y Saber Pro Ingles",
#        x = "Saber 11 Ingles (PUNT_INGLES)",
#        y = "Saber Pro Ingles (MOD_INGLES_PUNT)") +
#   theme_minimal()


# --- 1.2 Ajuste del modelo simple --------------------------------------------
# TODO: Estimar el modelo de regresion simple
# modelo_simple <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES, data = datos)
# summary(modelo_simple)

# INTERPRETACION:
# - Intercepto (beta_0): [VALOR] (puntaje esperado en Saber Pro cuando Saber 11 = 0)
# - Pendiente (beta_1): [VALOR] (cambio en Saber Pro por cada punto adicional en Saber 11)
# - R-cuadrado: [VALOR] (% de variabilidad en Saber Pro explicada por Saber 11)
# - p-valor: [VALOR] (significancia estadistica del predictor)


# --- 1.3 IC para los coeficientes -------------------------------------------
# TODO: Calcular IC al 95% para beta_0 y beta_1
# confint(modelo_simple, level = 0.95)


# =============================================================================
# 2. REGRESION LINEAL MULTIPLE (OLS)
# =============================================================================

# PREGUNTA: Como predicen los 5 puntajes de Saber 11 el puntaje de ingles
# en Saber Pro (MOD_INGLES_PUNT)?

# Modelo: MOD_INGLES_PUNT = beta_0 + beta_1*PUNT_INGLES + beta_2*PUNT_MATEMATICAS +
#         beta_3*PUNT_LECTURA_CRITICA + beta_4*PUNT_SOCIALES_CIUDADANAS +
#         beta_5*PUNT_CIENCIAS_NATURALES + epsilon

# --- 2.1 Ajuste del modelo multiple -----------------------------------------
# TODO: Estimar el modelo de regresion multiple
# modelo_multiple <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES + PUNT_MATEMATICAS +
#                       PUNT_LECTURA_CRITICA + PUNT_SOCIALES_CIUDADANAS +
#                       PUNT_CIENCIAS_NATURALES,
#                       data = datos)
# summary(modelo_multiple)

# INTERPRETACION:
# - Identificar predictores significativos (p < 0.05)
# - Interpretar coeficientes: manteniendo las demas variables constantes,
#   un aumento de 1 punto en [VARIABLE] se asocia con un cambio de [beta] puntos
#   en MOD_INGLES_PUNT
# - R-cuadrado ajustado: [VALOR] (considera el numero de predictores)
# - F-estadistico: [VALOR] (significancia global del modelo)


# --- 2.2 IC para los coeficientes -------------------------------------------
# TODO: Calcular IC al 95% para todos los coeficientes
# confint(modelo_multiple, level = 0.95)


# =============================================================================
# 3. DIAGNOSTICOS DEL MODELO
# =============================================================================

# Verificar supuestos de regresion lineal:
# 1. Linealidad: relacion lineal entre X e Y
# 2. Normalidad: residuos siguen distribucion normal
# 3. Homocedasticidad: varianza constante de residuos
# 4. Independencia: residuos no correlacionados (asumido por diseno)
# 5. No multicolinealidad: predictores no altamente correlacionados

# --- 3.1 Graficos de diagnostico (base R) -----------------------------------
# TODO: Generar los 4 graficos de diagnostico clasicos
# par(mfrow = c(2, 2))
# plot(modelo_multiple)
# par(mfrow = c(1, 1))

# INTERPRETACION:
# - Residuals vs Fitted: verificar linealidad (patron aleatorio) y homocedasticidad
# - Normal Q-Q: verificar normalidad de residuos (puntos sobre la diagonal)
# - Scale-Location: verificar homocedasticidad (banda horizontal)
# - Residuals vs Leverage: identificar observaciones influyentes (fuera de Cook's distance)


# --- 3.2 Prueba de Breusch-Pagan (homocedasticidad) -------------------------
# H0: Varianza constante (homocedasticidad)
# H1: Heterocedasticidad
# Nivel de significancia: alpha = 0.05

# TODO: Realizar prueba de Breusch-Pagan
# bptest(modelo_multiple)

# INTERPRETACION:
# p-valor = [VALOR]
# Si p < 0.05, rechazamos H0 y concluimos que hay heterocedasticidad.
# Solucion: usar errores estandar robustos (HC1)


# --- 3.3 VIF (multicolinealidad) --------------------------------------------
# VIF (Variance Inflation Factor) mide la correlacion entre predictores
# Regla practica: VIF > 10 indica multicolinealidad problematica
#                 VIF > 5 requiere atencion

# TODO: Calcular VIF para cada predictor
# vif(modelo_multiple)

# INTERPRETACION:
# VIF < 5: No hay problema de multicolinealidad
# VIF > 10: Considerar eliminar variables altamente correlacionadas o usar PCA


# --- 3.4 Observaciones influyentes (Cook's distance) ------------------------
# Cook's distance mide la influencia de cada observacion en el modelo
# Regla practica: D > 4/n o D > 1 indica observacion influyente

# TODO: Calcular Cook's distance
# cooks_d <- cooks.distance(modelo_multiple)
# n <- nrow(datos)
# umbral <- 4 / n

# TODO: Identificar observaciones influyentes
# influyentes <- which(cooks_d > umbral)
# print(paste("Numero de observaciones influyentes:", length(influyentes)))

# TODO: Visualizar Cook's distance
# plot(cooks_d, type = "h", main = "Cook's Distance",
#      ylab = "Cook's Distance", xlab = "Observacion")
# abline(h = umbral, col = "red", lty = 2)

# TODO: Examinar observaciones influyentes
# datos[influyentes, ]

# DECISION:
# - Si las observaciones influyentes son errores de medicion o outliers extremos,
#   considerar eliminarlas y re-estimar el modelo
# - Si son observaciones validas, reportarlas y verificar robustez del modelo


# =============================================================================
# 4. ERRORES ESTANDAR ROBUSTOS (HC1)
# =============================================================================

# Si hay heterocedasticidad (Breusch-Pagan rechaza H0), usar errores
# estandar robustos para corregir la inferencia.

# TODO: Calcular coeficientes con errores estandar robustos HC1
# coeftest(modelo_multiple, vcov = vcovHC(modelo_multiple, type = "HC1"))

# INTERPRETACION:
# Comparar los errores estandar robustos con los OLS clasicos.
# Si hay heterocedasticidad, los errores OLS pueden estar sesgados,
# y los p-valores robustos son mas confiables.


# =============================================================================
# 5. COMPARACION DE MODELOS
# =============================================================================

# Comparar modelo simple vs multiple usando R-cuadrado ajustado y AIC/BIC

# TODO: Comparar R-cuadrado ajustado
# summary(modelo_simple)$adj.r.squared
# summary(modelo_multiple)$adj.r.squared

# TODO: Comparar AIC (Akaike Information Criterion)
# AIC(modelo_simple)
# AIC(modelo_multiple)

# TODO: Comparar BIC (Bayesian Information Criterion)
# BIC(modelo_simple)
# BIC(modelo_multiple)

# INTERPRETACION:
# - R-cuadrado ajustado mas alto -> mejor ajuste (penaliza complejidad)
# - AIC/BIC mas bajo -> mejor modelo (penaliza sobreajuste)
# - Si el modelo multiple no mejora significativamente el ajuste,
#   considerar el modelo simple por parsimonia


# =============================================================================
# 6. PREDICCIONES
# =============================================================================

# TODO: Generar predicciones para nuevos datos (ejemplo)
# nuevos_datos <- data.frame(
#   PUNT_INGLES = 70,
#   PUNT_MATEMATICAS = 65,
#   PUNT_LECTURA_CRITICA = 68,
#   PUNT_SOCIALES_CIUDADANAS = 62,
#   PUNT_CIENCIAS_NATURALES = 60
# )

# prediccion <- predict(modelo_multiple, newdata = nuevos_datos, interval = "prediction")
# print(prediccion)

# INTERPRETACION:
# Para un estudiante con estos puntajes en Saber 11, el modelo predice
# un puntaje de [fit] en MOD_INGLES_PUNT, con IC 95%: [lwr, upr]


# =============================================================================
# 7. VISUALIZACIONES COMPLEMENTARIAS
# =============================================================================

# --- 7.1 Grafico de coeficientes con IC --------------------------------------
# TODO: Visualizar coeficientes con IC 95%
# coef_df <- data.frame(
#   variable = names(coef(modelo_multiple))[-1],  # Excluir intercepto
#   beta = coef(modelo_multiple)[-1],
#   ic_inf = confint(modelo_multiple)[-1, 1],
#   ic_sup = confint(modelo_multiple)[-1, 2]
# )

# ggplot(coef_df, aes(x = variable, y = beta)) +
#   geom_point(size = 3) +
#   geom_errorbar(aes(ymin = ic_inf, ymax = ic_sup), width = 0.2) +
#   geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
#   coord_flip() +
#   labs(title = "Coeficientes del Modelo Multiple (IC 95%)",
#        x = "Predictor", y = "Coeficiente") +
#   theme_minimal()


# --- 7.2 Grafico de valores observados vs predichos -------------------------
# TODO: Visualizar bondad de ajuste
# datos$predichos <- predict(modelo_multiple)

# ggplot(datos, aes(x = predichos, y = MOD_INGLES_PUNT)) +
#   geom_point(alpha = 0.3) +
#   geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
#   labs(title = "Valores Observados vs Predichos",
#        x = "Valores Predichos", y = "Valores Observados") +
#   theme_minimal()


# --- 7.3 Grafico de residuos vs predictores ---------------------------------
# TODO: Verificar linealidad para cada predictor
# datos$residuos <- residuals(modelo_multiple)

# ggplot(datos, aes(x = PUNT_INGLES, y = residuos)) +
#   geom_point(alpha = 0.3) +
#   geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
#   geom_smooth(se = FALSE, color = "blue") +
#   labs(title = "Residuos vs PUNT_INGLES",
#        x = "PUNT_INGLES", y = "Residuos") +
#   theme_minimal()


# =============================================================================
# 8. TABLA RESUMEN PARA EL INFORME
# =============================================================================

# TODO: Crear tabla resumen con estadisticos clave del modelo multiple
# tabla_resumen <- data.frame(
#   Metrica = c("R-cuadrado", "R-cuadrado ajustado", "F-estadistico", "p-valor (F)",
#               "AIC", "BIC", "n observaciones"),
#   Valor = c(
#     round(summary(modelo_multiple)$r.squared, 3),
#     round(summary(modelo_multiple)$adj.r.squared, 3),
#     round(summary(modelo_multiple)$fstatistic[1], 2),
#     format.pval(pf(summary(modelo_multiple)$fstatistic[1],
#                    summary(modelo_multiple)$fstatistic[2],
#                    summary(modelo_multiple)$fstatistic[3],
#                    lower.tail = FALSE), digits = 3),
#     round(AIC(modelo_multiple), 1),
#     round(BIC(modelo_multiple), 1),
#     nrow(datos)
#   )
# )
# print(tabla_resumen)


# =============================================================================
# RESUMEN DE HALLAZGOS
# =============================================================================
#
# 1. Modelo simple (PUNT_INGLES -> MOD_INGLES_PUNT):
#    - R-cuadrado: [VALOR]
#    - Pendiente: [VALOR] (p = [VALOR])
#
# 2. Modelo multiple (5 predictores Saber 11 -> MOD_INGLES_PUNT):
#    - R-cuadrado ajustado: [VALOR]
#    - Predictores significativos: [LISTA]
#    - F-estadistico: [VALOR] (p < 0.001)
#
# 3. Diagnosticos:
#    - Linealidad: [CUMPLE / NO CUMPLE]
#    - Normalidad: [CUMPLE / NO CUMPLE]
#    - Homocedasticidad: [CUMPLE / NO CUMPLE] (Breusch-Pagan p = [VALOR])
#    - Multicolinealidad: [VIF maximo = VALOR]
#    - Observaciones influyentes: [n] (Cook's D > 4/n)
#
# 4. Errores robustos:
#    - [RESULTADO CON ERRORES HC1]
#
# 5. Implicaciones para Negocios Internacionales:
#    - [DISCUSION]
#
# =============================================================================
