# ============================================================================
# Sesion 13: Repaso final
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 20 nov 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)
library(boot)
library(car)
library(lmtest)
library(sandwich)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))
cruce     <- read_parquet(paste0(gh_raw, "/cruce/cruce_saber11_saberpro.parquet"))

# --- Problemas integradores -------------------------------------------------

# === Problema 1: EDA completo ===============================================
cat("=== Problema 1: EDA Saber 11 ===\n")

# Descriptiva numerica
saber11 %>%
  select(PUNT_GLOBAL, PUNT_MATEMATICAS, PUNT_INGLES, PUNT_LECTURA_CRITICA) %>%
  pivot_longer(everything(), names_to = "modulo", values_to = "puntaje") %>%
  filter(!is.na(puntaje)) %>%
  group_by(modulo) %>%
  summarise(
    n     = n(),
    media = round(mean(puntaje), 1),
    sd    = round(sd(puntaje), 1),
    med   = median(puntaje),
    q1    = quantile(puntaje, 0.25),
    q3    = quantile(puntaje, 0.75),
    .groups = "drop"
  ) %>%
  print()

# Boxplot por area del colegio
ggplot(saber11 %>% filter(!is.na(COLE_AREA_UBICACION)),
       aes(x = COLE_AREA_UBICACION, y = PUNT_GLOBAL,
           fill = COLE_AREA_UBICACION)) +
  geom_boxplot() +
  labs(title = "Puntaje global Saber 11 por area del colegio",
       x = "Area", y = "Puntaje global") +
  theme_minimal() + theme(legend.position = "none")

# === Problema 2: Intervalos de confianza =====================================
cat("\n=== Problema 2: Intervalos de confianza ===\n")

set.seed(2026)
muestra_sb11 <- sample(saber11$PUNT_MATEMATICAS[!is.na(saber11$PUNT_MATEMATICAS)], 250)

# IC con t
ic_t <- t.test(muestra_sb11, conf.level = 0.95)
cat("IC 95% para media de matematicas (Saber 11):\n")
cat(sprintf("  [%.2f, %.2f]\n", ic_t$conf.int[1], ic_t$conf.int[2]))

# Bootstrap
boot_fn <- function(x, i) mean(x[i])
boot_mat <- boot(muestra_sb11, boot_fn, R = 3000)
ic_boot <- boot.ci(boot_mat, type = "bca")
cat("IC 95% bootstrap BCa:\n")
print(ic_boot)

# === Problema 3: Pruebas de hipotesis ========================================
cat("\n=== Problema 3: Pruebas de hipotesis ===\n")

# t de 2 muestras: urbano vs rural
urbano <- saber11 %>%
  filter(COLE_AREA_UBICACION == "URBANO", !is.na(PUNT_GLOBAL)) %>%
  pull(PUNT_GLOBAL)
rural <- saber11 %>%
  filter(COLE_AREA_UBICACION == "RURAL", !is.na(PUNT_GLOBAL)) %>%
  pull(PUNT_GLOBAL)

test_area <- t.test(urbano, rural)
cat("Prueba t: urbano vs rural (puntaje global Saber 11)\n")
print(test_area)

# Mann-Whitney
mw_area <- wilcox.test(urbano, rural)
cat("\nMann-Whitney:\n")
print(mw_area)

# ANOVA por calendario
anova_cal <- aov(PUNT_GLOBAL ~ COLE_CALENDARIO, data = saber11 %>%
                   filter(!is.na(COLE_CALENDARIO)))
cat("\nANOVA: puntaje por calendario escolar\n")
summary(anova_cal)
TukeyHSD(anova_cal)

# === Problema 4: Regresion ===================================================
cat("\n=== Problema 4: Regresion ===\n")

datos_reg <- cruce %>%
  inner_join(saber11, by = c("estu_consecutivo_sb11" = "ESTU_CONSECUTIVO")) %>%
  inner_join(saber_pro, by = c("estu_consecutivo_sbpro" = "ESTU_CONSECUTIVO"),
             suffix = c("_sb11", "_sbpro")) %>%
  filter(!is.na(PUNT_INGLES), !is.na(PUNT_MATEMATICAS),
         !is.na(MOD_INGLES_PUNT)) %>%
  slice_sample(n = 20000)

# OLS multiple
modelo <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES + PUNT_MATEMATICAS +
               PUNT_LECTURA_CRITICA, data = datos_reg)
summary(modelo)

# Diagnosticos
par(mfrow = c(2, 2))
plot(modelo)
par(mfrow = c(1, 1))

# VIF
cat("VIF:\n")
print(vif(modelo))

# Breusch-Pagan
cat("\nBreusch-Pagan:\n")
print(bptest(modelo))

# Errores robustos
cat("\nCoeficientes con errores robustos HC1:\n")
print(coeftest(modelo, vcov = vcovHC(modelo, type = "HC1")))

# === Problema 5: Tabla resumen del curso =====================================
cat("\n=== Resumen de metodos del curso ===\n")
metodos <- tibble(
  sesion = 1:12,
  tema = c("Descriptiva numerica", "Descriptiva grafica",
           "Muestreo y correlacion", "Estimadores y MLE",
           "OLS simple", "OLS multiple",
           "Diagnosticos y logit", "Intervalos de confianza",
           "Bootstrap", "Errores y potencia",
           "Pruebas parametricas", "No parametricas"),
  funciones_R = c("mean, sd, quantile", "ggplot, geom_histogram, geom_boxplot",
                  "cor, corrplot, sample", "fitdistr, replicate",
                  "lm, summary, plot", "lm, vif, AIC, BIC",
                  "bptest, dwtest, glm, roc", "t.test, prop.test, qnorm",
                  "boot, boot.ci", "power.t.test, cohen.d",
                  "t.test, aov, TukeyHSD", "chisq.test, wilcox.test, kruskal.test")
)
print(metodos, n = 12)
