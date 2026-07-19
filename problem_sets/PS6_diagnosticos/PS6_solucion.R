# ============================================================================
# Problem Set 6: ANOVA, Pruebas No Parametricas y Asociacion Categorica
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Asignado: Sep 25 | Entrega: Oct 2
# ============================================================================

# --- Cargar paquetes ---------------------------------------------------------
library(tidyverse)
library(car)       # para leveneTest()

# --- Cargar datos ------------------------------------------------------------
# Opcion 1: Leer desde CSV local
# datos <- read.csv("../../datos/saber_pro_ni.csv")

# Opcion 2: Conectar a BigQuery (proyecto ph-jabri)
# library(bigrquery)
# bq_auth()
# sql <- "SELECT MOD_INGLES_PUNT, ESTU_NSE_ESTRATO, ESTU_GENERO,
#                MOD_INGLES_DESEM_MCER
#         FROM `ph-jabri.ICFES.Saber11_SaberPro`
#         WHERE ESTU_PRGM_ACADEMICO LIKE '%NEGOCIOS INTERNACIONALES%'"
# datos <- bq_project_query("ph-jabri", sql) %>% bq_table_download()

# Filtrar y preparar datos
# ni <- datos %>%
#   filter(!is.na(MOD_INGLES_PUNT), !is.na(ESTU_NSE_ESTRATO))


# --- 1) ANOVA de una via por estrato socioeconomico -------------------------

# TODO: Plantear hipotesis:
# H0: mu_1 = mu_2 = ... = mu_k
# H1: al menos una media difiere


# TODO: Verificar supuestos del ANOVA
# a) Normalidad por grupo (Shapiro-Wilk o Q-Q plots)


# b) Homocedasticidad (prueba de Levene)
# leveneTest(MOD_INGLES_PUNT ~ factor(ESTRATO), data = ni)


# TODO: Aplicar ANOVA
# modelo_anova <- aov(MOD_INGLES_PUNT ~ factor(ESTRATO), data = ni)
# summary(modelo_anova)


# TODO: Calcular eta cuadrado (proporcion de variabilidad explicada)
# eta2 = SS_entre / SS_total



# --- 2) Comparaciones multiples con Tukey HSD -------------------------------

# TODO: Aplicar Tukey HSD
# tukey_result <- TukeyHSD(modelo_anova)
# print(tukey_result)


# TODO: Reportar IC ajustados al 95% para todas las comparaciones


# TODO: Identificar pares de estratos con diferencias significativas


# TODO: Graficar intervalos de confianza de Tukey
# plot(tukey_result)



# --- 3) Prueba de Mann-Whitney por genero ------------------------------------

# TODO: Justificar uso de prueba no parametrica vs. prueba t


# TODO: Plantear H0 y H1 en terminos de medianas o rangos


# TODO: Aplicar wilcox.test()
# wilcox.test(MOD_INGLES_PUNT ~ GENERO, data = ni)


# TODO: Interpretar: ¿Rechaza H0? ¿Que grupo tiene mayor puntaje mediano?



# --- 4) Prueba chi-cuadrado de independencia: genero x nivel MCER -----------

# TODO: Construir tabla de contingencia
# tabla_contingencia <- table(ni$GENERO, ni$MOD_INGLES_DESEM_MCER)
# print(tabla_contingencia)


# TODO: Plantear H0 (independencia) y H1 (asociacion)


# TODO: Aplicar prueba chi-cuadrado
# chi2_test <- chisq.test(tabla_contingencia)
# print(chi2_test)


# TODO: Verificar supuesto: frecuencias esperadas >= 5
# print(chi2_test$expected)



# --- 5) Tamano del efecto: V de Cramer --------------------------------------

# TODO: Calcular V de Cramer
# V = sqrt(chi2 / (n * (k - 1)))
# donde k = min(filas, columnas)


# TODO: Interpretar V segun convencion:
# Debil: V < 0.1, Moderada: 0.1 <= V < 0.3, Fuerte: V >= 0.3


# TODO: ¿La asociacion tiene relevancia practica?



# --- 6) Conclusiones ---------------------------------------------------------

# TODO: Sintetizar hallazgos:
# - ¿El estrato socioeconomico explica diferencias en ingles?
# - ¿Cuales estratos difieren?
# - ¿Existe brecha de genero en ingles?
# - ¿El nivel MCER esta asociado con el genero?


# ============================================================================
# Fin del Problem Set 6
# ============================================================================
