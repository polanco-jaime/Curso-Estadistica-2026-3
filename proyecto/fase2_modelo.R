# ============================================================================
# Proyecto Estadistico - Fase 2: Intervalos de Confianza y Pruebas de Hipotesis
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Entrega: Oct 2 2026 | Presentacion oral: 3 min
# ============================================================================
#
# OBJETIVO: Aplicar inferencia estadistica a los datos ICFES
# - Intervalos de confianza al 95% para medias
# - Pruebas t (1 muestra y 2 muestras)
# - ANOVA por estrato socioeconomico
# - Tamano del efecto (d de Cohen)
# - Analisis de potencia estadistica
#
# ============================================================================

# --- Cargar paquetes ---------------------------------------------------------
library(tidyverse)  # Manipulacion de datos y visualizacion
library(car)        # ANOVA y diagnosticos
library(pwr)        # Analisis de potencia
library(effsize)    # Tamano del efecto (d de Cohen)

# --- Cargar datos ------------------------------------------------------------
# TODO: Cargar el dataset cruzado Saber11-SaberPro desde BigQuery o CSV
# datos <- read.csv("../../datos/cruce_saber11_saberpro.csv")

# TODO: Filtrar por programa Negocios Internacionales
# datos <- datos %>%
#   filter(PROGRAMA == "Negocios Internacionales")

# TODO: Verificar estructura de datos
# glimpse(datos)


# =============================================================================
# 1. INTERVALOS DE CONFIANZA AL 95% PARA LA MEDIA
# =============================================================================

# --- 1.1 IC global para MOD_INGLES_PUNT --------------------------------------
# TODO: Calcular media, desviacion estandar y tamano de muestra
# media_ingles <- mean(datos$MOD_INGLES_PUNT, na.rm = TRUE)
# sd_ingles <- sd(datos$MOD_INGLES_PUNT, na.rm = TRUE)
# n_ingles <- sum(!is.na(datos$MOD_INGLES_PUNT))

# TODO: Calcular error estandar
# se_ingles <- sd_ingles / sqrt(n_ingles)

# TODO: Calcular IC con t.test()
# ic_ingles <- t.test(datos$MOD_INGLES_PUNT, conf.level = 0.95)
# print(ic_ingles)

# INTERPRETACION:
# Con 95% de confianza, la media poblacional de MOD_INGLES_PUNT
# se encuentra entre [LIMITE_INFERIOR] y [LIMITE_SUPERIOR]


# --- 1.2 IC por departamento -------------------------------------------------
# TODO: Calcular IC por departamento (top 5 departamentos con mas estudiantes)
# ic_por_depto <- datos %>%
#   group_by(DEPARTAMENTO) %>%
#   summarise(
#     n = n(),
#     media = mean(MOD_INGLES_PUNT, na.rm = TRUE),
#     ic_inf = t.test(MOD_INGLES_PUNT, conf.level = 0.95)$conf.int[1],
#     ic_sup = t.test(MOD_INGLES_PUNT, conf.level = 0.95)$conf.int[2]
#   ) %>%
#   arrange(desc(n)) %>%
#   head(5)

# print(ic_por_depto)


# --- 1.3 IC por estrato socioeconomico ---------------------------------------
# TODO: Calcular IC por estrato (FAMI_ESTRATOVIVIENDA)
# ic_por_estrato <- datos %>%
#   group_by(FAMI_ESTRATOVIVIENDA) %>%
#   summarise(
#     n = n(),
#     media = mean(MOD_INGLES_PUNT, na.rm = TRUE),
#     ic_inf = t.test(MOD_INGLES_PUNT, conf.level = 0.95)$conf.int[1],
#     ic_sup = t.test(MOD_INGLES_PUNT, conf.level = 0.95)$conf.int[2]
#   ) %>%
#   filter(!is.na(FAMI_ESTRATOVIVIENDA))

# print(ic_por_estrato)


# =============================================================================
# 2. PRUEBA t DE 1 MUESTRA
# =============================================================================

# PREGUNTA: El puntaje promedio de ingles es significativamente diferente
# del valor de referencia (por ejemplo, 150)?

# H0: mu = 150
# H1: mu != 150
# Nivel de significancia: alpha = 0.05

# TODO: Realizar prueba t de 1 muestra
# t_test_1muestra <- t.test(datos$MOD_INGLES_PUNT, mu = 150, alternative = "two.sided")
# print(t_test_1muestra)

# INTERPRETACION:
# p-valor = [VALOR]
# Si p < 0.05, rechazamos H0 y concluimos que el puntaje promedio
# es significativamente diferente de 150.


# =============================================================================
# 3. PRUEBA t DE 2 MUESTRAS INDEPENDIENTES
# =============================================================================

# PREGUNTA: Hay diferencia significativa en MOD_INGLES_PUNT entre
# estudiantes de IES publicas vs privadas?

# H0: mu_publico = mu_privado
# H1: mu_publico != mu_privado
# Nivel de significancia: alpha = 0.05

# TODO: Separar datos por tipo de IES
# datos_publico <- datos %>% filter(IES_TIPO == "Publica")
# datos_privado <- datos %>% filter(IES_TIPO == "Privada")

# TODO: Verificar supuesto de igualdad de varianzas (Levene test)
# leveneTest(MOD_INGLES_PUNT ~ IES_TIPO, data = datos)

# TODO: Realizar prueba t de 2 muestras (asumiendo varianzas iguales o desiguales segun Levene)
# t_test_2muestras <- t.test(MOD_INGLES_PUNT ~ IES_TIPO,
#                            data = datos,
#                            var.equal = TRUE,  # Cambiar a FALSE si Levene rechaza H0
#                            alternative = "two.sided")
# print(t_test_2muestras)

# INTERPRETACION:
# p-valor = [VALOR]
# Si p < 0.05, rechazamos H0 y concluimos que hay diferencia significativa
# en el puntaje de ingles entre IES publicas y privadas.


# =============================================================================
# 4. ANOVA POR ESTRATO SOCIOECONOMICO
# =============================================================================

# PREGUNTA: Hay diferencias significativas en MOD_INGLES_PUNT
# entre los diferentes estratos socioeconomicos?

# H0: mu_1 = mu_2 = mu_3 = mu_4 = mu_5 = mu_6
# H1: Al menos una media es diferente
# Nivel de significancia: alpha = 0.05

# TODO: Preparar datos (eliminar NA y convertir estrato a factor)
# datos_anova <- datos %>%
#   filter(!is.na(FAMI_ESTRATOVIVIENDA), !is.na(MOD_INGLES_PUNT)) %>%
#   mutate(FAMI_ESTRATOVIVIENDA = as.factor(FAMI_ESTRATOVIVIENDA))

# TODO: Visualizar distribucion por estrato
# ggplot(datos_anova, aes(x = FAMI_ESTRATOVIVIENDA, y = MOD_INGLES_PUNT)) +
#   geom_boxplot() +
#   labs(title = "Distribucion de MOD_INGLES_PUNT por Estrato Socioeconomico",
#        x = "Estrato", y = "Puntaje Ingles") +
#   theme_minimal()

# TODO: Verificar supuestos de ANOVA
# (1) Normalidad de residuos (Shapiro-Wilk o Q-Q plot)
# (2) Homocedasticidad (Levene test)

# modelo_anova <- aov(MOD_INGLES_PUNT ~ FAMI_ESTRATOVIVIENDA, data = datos_anova)
# plot(modelo_anova, which = 2)  # Q-Q plot
# leveneTest(MOD_INGLES_PUNT ~ FAMI_ESTRATOVIVIENDA, data = datos_anova)

# TODO: Realizar ANOVA
# anova_resultado <- aov(MOD_INGLES_PUNT ~ FAMI_ESTRATOVIVIENDA, data = datos_anova)
# summary(anova_resultado)

# INTERPRETACION:
# p-valor = [VALOR]
# Si p < 0.05, rechazamos H0 y concluimos que hay diferencias significativas
# en el puntaje de ingles entre al menos dos estratos.


# --- 4.1 Pruebas post-hoc (Tukey HSD) ----------------------------------------
# Si ANOVA rechaza H0, realizar pruebas post-hoc para identificar
# que pares de estratos son significativamente diferentes.

# TODO: Realizar Tukey HSD
# tukey_resultado <- TukeyHSD(anova_resultado)
# print(tukey_resultado)

# TODO: Visualizar diferencias entre estratos
# plot(tukey_resultado)

# INTERPRETACION:
# Identificar pares de estratos con p-valor < 0.05 (diferencias significativas)


# =============================================================================
# 5. TAMANO DEL EFECTO (d de Cohen)
# =============================================================================

# El tamano del efecto cuantifica la magnitud de la diferencia entre grupos,
# independientemente del tamano de muestra.
# Interpretacion: |d| < 0.2 (pequeno), 0.2-0.8 (mediano), > 0.8 (grande)

# TODO: Calcular d de Cohen para la comparacion IES publicas vs privadas
# cohen_d <- cohen.d(MOD_INGLES_PUNT ~ IES_TIPO, data = datos)
# print(cohen_d)

# INTERPRETACION:
# d = [VALOR]
# El tamano del efecto es [pequeno/mediano/grande], lo que indica una diferencia
# [practicamente insignificante / moderada / sustancial] entre IES publicas y privadas.


# =============================================================================
# 6. ANALISIS DE POTENCIA ESTADISTICA
# =============================================================================

# La potencia estadistica es la probabilidad de detectar un efecto cuando
# realmente existe (1 - beta). Convencionalmente, se busca potencia >= 0.80.

# TODO: Calcular potencia post-hoc para la prueba t de 2 muestras
# Necesitamos: tamano del efecto (d), tamano de muestra, alpha

# n1 <- nrow(datos_publico)
# n2 <- nrow(datos_privado)
# d_observado <- cohen_d$estimate

# potencia_posthoc <- pwr.t2n.test(n1 = n1,
#                                   n2 = n2,
#                                   d = d_observado,
#                                   sig.level = 0.05,
#                                   alternative = "two.sided")
# print(potencia_posthoc)

# INTERPRETACION:
# Potencia = [VALOR]
# Con nuestro tamano de muestra, la probabilidad de detectar el efecto observado es [VALOR].
# [Si potencia < 0.80, el estudio puede estar sub-potenciado]


# TODO: Calcular tamano de muestra necesario para detectar un efecto mediano (d = 0.5)
# con potencia 0.80
# tamano_muestra <- pwr.t.test(d = 0.5,
#                              sig.level = 0.05,
#                              power = 0.80,
#                              type = "two.sample",
#                              alternative = "two.sided")
# print(tamano_muestra)

# INTERPRETACION:
# Para detectar un efecto mediano (d = 0.5) con potencia 0.80, se necesitan
# aproximadamente [n] estudiantes por grupo.


# =============================================================================
# 7. VISUALIZACIONES COMPLEMENTARIAS
# =============================================================================

# TODO: Grafico de medias con IC por estrato
# ggplot(ic_por_estrato, aes(x = as.factor(FAMI_ESTRATOVIVIENDA), y = media)) +
#   geom_point(size = 3) +
#   geom_errorbar(aes(ymin = ic_inf, ymax = ic_sup), width = 0.2) +
#   labs(title = "Media de MOD_INGLES_PUNT por Estrato (IC 95%)",
#        x = "Estrato Socioeconomico", y = "Puntaje Ingles") +
#   theme_minimal()

# TODO: Grafico de densidad por tipo de IES
# ggplot(datos, aes(x = MOD_INGLES_PUNT, fill = IES_TIPO)) +
#   geom_density(alpha = 0.5) +
#   labs(title = "Distribucion de MOD_INGLES_PUNT por Tipo de IES",
#        x = "Puntaje Ingles", y = "Densidad") +
#   theme_minimal()


# =============================================================================
# RESUMEN DE HALLAZGOS
# =============================================================================
#
# 1. IC global MOD_INGLES_PUNT: [LIMITE_INF, LIMITE_SUP]
# 2. Prueba t 1 muestra: [RESULTADO]
# 3. Prueba t 2 muestras (publico vs privado): [RESULTADO]
# 4. ANOVA por estrato: [RESULTADO]
# 5. Tukey HSD: [PARES SIGNIFICATIVOS]
# 6. d de Cohen: [VALOR] ([pequeno/mediano/grande])
# 7. Potencia estadistica: [VALOR]
# 8. Implicaciones para Negocios Internacionales: [DISCUSION]
#
# =============================================================================
