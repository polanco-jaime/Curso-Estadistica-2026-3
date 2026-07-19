# ============================================================================
# Problem Set 8: Regresion Lineal Multiple y Diagnosticos Avanzados
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Asignado: Oct 30 | Entrega: Nov 13
# ============================================================================

# --- Cargar paquetes ---------------------------------------------------------
library(tidyverse)
library(car)       # para vif()
library(lmtest)    # para bptest(), coeftest()
library(sandwich)  # para vcovHC()

# --- Cargar datos ------------------------------------------------------------
# Opcion 1: Leer desde CSV local
# datos <- read.csv("../../datos/saber11_saberpro_ni.csv")

# Opcion 2: Conectar a BigQuery (proyecto ph-jabri)
# library(bigrquery)
# bq_auth()
# sql <- "SELECT MOD_INGLES_PUNT,
#                PUNT_INGLES, PUNT_MATEMATICAS, PUNT_LECTURA_CRITICA,
#                PUNT_SOCIALES_CIUDADANAS, PUNT_CIENCIAS_NATURALES
#         FROM `ph-jabri.ICFES.Saber11_SaberPro`
#         WHERE ESTU_PRGM_ACADEMICO LIKE '%NEGOCIOS INTERNACIONALES%'
#         AND MOD_INGLES_PUNT IS NOT NULL
#         AND PUNT_INGLES IS NOT NULL"
# datos <- bq_project_query("ph-jabri", sql) %>% bq_table_download()

# Filtrar datos completos
# ni <- datos %>%
#   filter(!is.na(MOD_INGLES_PUNT),
#          !is.na(PUNT_INGLES),
#          !is.na(PUNT_MATEMATICAS),
#          !is.na(PUNT_LECTURA_CRITICA),
#          !is.na(PUNT_SOCIALES_CIUDADANAS))


# --- 1) Modelo OLS multiple con 4+ regresores de Saber 11 -------------------

# TODO: Seleccionar 4 o mas regresores de Saber 11
# Sugerencias: PUNT_INGLES, PUNT_MATEMATICAS, PUNT_LECTURA_CRITICA,
#              PUNT_SOCIALES_CIUDADANAS, PUNT_CIENCIAS_NATURALES


# TODO: Estimar modelo OLS multiple
# modelo_multiple <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES + PUNT_MATEMATICAS +
#                       PUNT_LECTURA_CRITICA + PUNT_SOCIALES_CIUDADANAS,
#                       data = ni)
# summary(modelo_multiple)


# TODO: Interpretar cada coeficiente beta_j
# ¿Cual regresor tiene mayor efecto sobre MOD_INGLES_PUNT?



# --- 2) Multicolinealidad: VIF -----------------------------------------------

# TODO: Calcular VIF para cada regresor
# vif_values <- vif(modelo_multiple)
# print(vif_values)


# TODO: Identificar regresores con VIF > 5 o VIF > 10


# TODO: ¿Que implica multicolinealidad alta para precision de estimaciones?


# TODO: ¿Es necesario eliminar algun regresor? Justificar



# --- 3) Sesgo por variable omitida (OVB) -------------------------------------

# TODO: Estimar modelo simple
# modelo_simple <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES, data = ni)
# summary(modelo_simple)


# TODO: Comparar coeficiente de PUNT_INGLES en modelo simple vs. multiple
# gamma_1 (simple) vs. beta_1 (multiple)


# TODO: ¿Cambio el coeficiente? ¿En que direccion?


# TODO: Explicar sesgo por variable omitida: ¿por que el modelo simple
# sobrestima o subestima el efecto de PUNT_INGLES?



# --- 4) Diagnosticos graficos: 4 graficos base -------------------------------

# TODO: Producir los 4 graficos diagnosticos estandar
# par(mfrow = c(2, 2))
# plot(modelo_multiple)


# TODO: Interpretar cada grafico:
# 1. Residuos vs. valores ajustados (linealidad, homocedasticidad)
# 2. Q-Q plot (normalidad)
# 3. Scale-Location (homocedasticidad)
# 4. Residuos vs. leverage (observaciones influyentes, distancia de Cook)



# --- 5) Prueba de heterocedasticidad (Breusch-Pagan) -------------------------

# TODO: Plantear hipotesis:
# H0: homocedasticidad
# H1: heterocedasticidad


# TODO: Aplicar prueba de Breusch-Pagan
# bp_test <- bptest(modelo_multiple)
# print(bp_test)


# TODO: Reportar estadistico de prueba y p-valor


# TODO: ¿Rechaza H0 al 5%? ¿Que implica para errores estandar OLS?



# --- 6) Observaciones influyentes: distancia de Cook -------------------------

# TODO: Calcular distancia de Cook para cada observacion
# cooks_d <- cooks.distance(modelo_multiple)


# TODO: Identificar las 5 observaciones mas influyentes
# top_influential <- ni %>%
#   mutate(cooks_d = cooks_d) %>%
#   arrange(desc(cooks_d)) %>%
#   slice_head(n = 5)
# print(top_influential)


# TODO: ¿Alguna observacion supera umbral D_i > 4/n?
# n <- nrow(ni)
# umbral <- 4 / n


# TODO: Examinar observaciones influyentes: ¿que caracteristicas tienen?
# ¿Son outliers genuinos o datos atipicos validos?



# --- 7) Errores estandar robustos (HC1) --------------------------------------

# TODO: Calcular matriz de varianza-covarianza robusta
# vcov_robust <- vcovHC(modelo_multiple, type = "HC1")


# TODO: Reportar coeficientes con errores estandar robustos
# coeftest(modelo_multiple, vcov = vcov_robust)


# TODO: Comparar errores estandar OLS vs. robustos
# ¿Cuales son mas grandes?


# TODO: ¿Cambian conclusiones de significancia estadistica para algun regresor?



# --- 8) Bondad de ajuste y comparacion de modelos ----------------------------

# TODO: Reportar R^2 y R^2 ajustado del modelo multiple
# summary(modelo_multiple)$r.squared
# summary(modelo_multiple)$adj.r.squared


# TODO: Comparar R^2 del modelo multiple con R^2 del modelo simple
# summary(modelo_simple)$r.squared


# TODO: ¿Cuanto aumenta el poder explicativo al incluir mas regresores?


# TODO: ¿El aumento en R^2 justifica la complejidad adicional?
# (Usar criterio del R^2 ajustado)



# --- 9) Conclusiones y recomendaciones finales -------------------------------

# TODO: Sintetizar el analisis completo:

# a) ¿Cuales son los principales determinantes del puntaje de ingles en
#    Saber Pro para estudiantes de NI?


# b) ¿El modelo cumple razonablemente los supuestos de Gauss-Markov?
#    ¿Que violaciones identifico?


# c) Si tuviera que recomendar UN ajuste al modelo para mejorar su validez,
#    ¿cual seria? (Ejemplos: eliminar regresor por VIF alto, usar errores
#    robustos, excluir outliers, transformar variables)


# d) ¿El modelo tiene utilidad practica para predecir el rendimiento en
#    Saber Pro de futuros estudiantes de NI?


# ============================================================================
# Fin del Problem Set 8
# ============================================================================
