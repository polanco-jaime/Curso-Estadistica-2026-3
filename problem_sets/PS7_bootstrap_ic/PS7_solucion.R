# ============================================================================
# Problem Set 7: Bondad de Ajuste y Regresion Lineal Simple
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Asignado: Oct 16 | Entrega: Oct 30
# ============================================================================

# --- Cargar paquetes ---------------------------------------------------------
library(tidyverse)

# --- Cargar datos ------------------------------------------------------------
# Opcion 1: Leer desde CSV local
# datos <- read.csv("../../datos/saber11_saberpro_ni.csv")

# Opcion 2: Conectar a BigQuery (proyecto ph-jabri)
# library(bigrquery)
# bq_auth()
# sql <- "SELECT MOD_INGLES_PUNT, MOD_INGLES_DESEM_MCER,
#                PUNT_INGLES
#         FROM `ph-jabri.ICFES.Saber11_SaberPro`
#         WHERE ESTU_PRGM_ACADEMICO LIKE '%NEGOCIOS INTERNACIONALES%'
#         AND MOD_INGLES_PUNT IS NOT NULL
#         AND PUNT_INGLES IS NOT NULL"
# datos <- bq_project_query("ph-jabri", sql) %>% bq_table_download()

# Filtrar datos completos
# ni <- datos %>%
#   filter(!is.na(MOD_INGLES_PUNT), !is.na(PUNT_INGLES), !is.na(MOD_INGLES_DESEM_MCER))


# --- 1) Prueba chi-cuadrado de bondad de ajuste -----------------------------

# TODO: Construir tabla de frecuencias observadas para niveles MCER
# tabla_mcer <- table(ni$MOD_INGLES_DESEM_MCER)
# print(tabla_mcer)


# TODO: Plantear hipotesis:
# H0: p_1 = p_2 = ... = p_5 = 1/5 (distribucion uniforme)
# H1: al menos una p_i difiere de 1/5


# TODO: Calcular frecuencias esperadas bajo H0
# n_total <- sum(tabla_mcer)
# n_niveles <- length(tabla_mcer)
# frec_esperadas <- rep(n_total / n_niveles, n_niveles)


# TODO: Aplicar prueba chi-cuadrado de bondad de ajuste
# chi2_gof <- chisq.test(tabla_mcer, p = rep(1/n_niveles, n_niveles))
# print(chi2_gof)


# TODO: Interpretar: ¿Rechaza H0? ¿Que niveles estan sobre/subrepresentados?



# --- 2) Regresion lineal simple (OLS) ----------------------------------------

# TODO: Preparar datos: cruzar Saber 11 y Saber Pro
# Filtrar estudiantes de NI con datos completos en ambas pruebas


# TODO: Graficar scatterplot de PUNT_INGLES (x) vs. MOD_INGLES_PUNT (y)
# ggplot(ni, aes(x = PUNT_INGLES, y = MOD_INGLES_PUNT)) +
#   geom_point(alpha = 0.3) +
#   labs(title = "Relacion entre Saber 11 y Saber Pro en Ingles (NI)",
#        x = "Puntaje Ingles Saber 11",
#        y = "Puntaje Ingles Saber Pro") +
#   theme_minimal()


# TODO: Estimar modelo OLS
# modelo_ols <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES, data = ni)
# summary(modelo_ols)


# TODO: Interpretar coeficientes beta_0 (intercepto) y beta_1 (pendiente)
# Si PUNT_INGLES aumenta en 10 puntos, ¿cuanto aumenta MOD_INGLES_PUNT?



# --- 3) Diagnostico de residuos ----------------------------------------------

# TODO: Calcular residuos
# residuos <- residuals(modelo_ols)
# valores_ajustados <- fitted(modelo_ols)


# TODO: Graficar residuos vs. valores ajustados
# plot(valores_ajustados, residuos,
#      xlab = "Valores ajustados", ylab = "Residuos",
#      main = "Residuos vs. Valores Ajustados")
# abline(h = 0, col = "red", lty = 2)


# TODO: Graficar Q-Q plot de residuos
# qqnorm(residuos)
# qqline(residuos, col = "red")


# TODO: Interpretar graficos: ¿Se cumplen supuestos de linealidad,
# homocedasticidad y normalidad?


# TODO: Identificar las 3 observaciones con mayor residuo absoluto (outliers)
# outliers <- ni %>%
#   mutate(residuo_abs = abs(residuos)) %>%
#   arrange(desc(residuo_abs)) %>%
#   slice_head(n = 3)
# print(outliers)



# --- 4) Bondad de ajuste (R cuadrado) ----------------------------------------

# TODO: Reportar R^2 y R^2 ajustado
# summary(modelo_ols)$r.squared
# summary(modelo_ols)$adj.r.squared


# TODO: Interpretar R^2: ¿Que porcentaje de variabilidad en Saber Pro
# es explicado por Saber 11?


# TODO: ¿El modelo tiene buen ajuste? Justificar



# --- 5) Prediccion -----------------------------------------------------------

# TODO: Predecir puntaje de Saber Pro para un estudiante con 75 puntos
# en Saber 11
# nuevo_dato <- data.frame(PUNT_INGLES = 75)
# prediccion <- predict(modelo_ols, newdata = nuevo_dato,
#                       interval = "prediction", level = 0.95)
# print(prediccion)


# TODO: Interpretar intervalo de prediccion al 95%



# --- 6) Conclusiones ---------------------------------------------------------

# TODO: Sintetizar hallazgos:
# - ¿La distribucion de niveles MCER es uniforme en NI?
# - ¿El puntaje de Saber 11 es buen predictor de Saber Pro en ingles?
# - ¿Que limitaciones tiene el modelo OLS simple?


# ============================================================================
# Fin del Problem Set 7
# ============================================================================
