# ============================================================================
# Sesion 7: Diagnosticos y regresion logistica
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 2 oct 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)
library(lmtest)
library(sandwich)
library(pROC)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))
cruce     <- read_parquet(paste0(gh_raw, "/cruce/cruce_saber11_saberpro.parquet"))

datos <- cruce %>%
  inner_join(saber11, by = c("estu_consecutivo_sb11" = "ESTU_CONSECUTIVO")) %>%
  inner_join(saber_pro, by = c("estu_consecutivo_sbpro" = "ESTU_CONSECUTIVO"),
             suffix = c("_sb11", "_sbpro")) %>%
  filter(!is.na(PUNT_INGLES), !is.na(PUNT_MATEMATICAS),
         !is.na(PUNT_LECTURA_CRITICA), !is.na(MOD_INGLES_PUNT))

muestra <- datos %>% slice_sample(n = 30000)

modelo <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES + PUNT_MATEMATICAS +
               PUNT_LECTURA_CRITICA, data = muestra)

# --- Breusch-Pagan -----------------------------------------------------------
bp_test <- bptest(modelo)
cat("Prueba de Breusch-Pagan (homocedasticidad):\n")
print(bp_test)
cat("\nH0: varianza constante (homocedasticidad)\n")
cat("H1: varianza no constante (heterocedasticidad)\n")
if (bp_test$p.value < 0.05) {
  cat("-> Rechazamos H0: hay evidencia de heterocedasticidad\n")
} else {
  cat("-> No se rechaza H0: no hay evidencia de heterocedasticidad\n")
}

# --- Durbin-Watson ------------------------------------------------------------
dw_test <- dwtest(modelo)
cat("\nPrueba de Durbin-Watson (autocorrelacion):\n")
print(dw_test)
cat("DW ~2: no autocorrelacion, <2: positiva, >2: negativa\n")

# --- Cook D ------------------------------------------------------------------
cook_d <- cooks.distance(modelo)
umbral <- 4 / nrow(muestra)
influyentes <- which(cook_d > umbral)

cat("\nDistancia de Cook:\n")
cat("Umbral 4/n =", round(umbral, 6), "\n")
cat("Observaciones influyentes (D > 4/n):", length(influyentes), "\n")

plot(cook_d, type = "h", main = "Distancia de Cook", ylab = "D_i")
abline(h = umbral, col = "red", lty = 2)

top5 <- head(sort(cook_d, decreasing = TRUE), 5)
cat("\nTop 5 observaciones mas influyentes:\n")
print(round(top5, 5))

# --- Errores estandar robustos -----------------------------------------------
cat("\nComparacion errores estandar OLS vs robustos HC1:\n")
ols_se <- coeftest(modelo)
rob_se <- coeftest(modelo, vcov = vcovHC(modelo, type = "HC1"))

comparacion_se <- tibble(
  variable = rownames(ols_se),
  SE_OLS    = ols_se[, "Std. Error"],
  SE_HC1    = rob_se[, "Std. Error"],
  ratio     = rob_se[, "Std. Error"] / ols_se[, "Std. Error"]
)
print(comparacion_se)

cat("\nCoeficientes con errores robustos HC1:\n")
print(rob_se)

# --- Regresion logistica -----------------------------------------------------
saber_pro_logit <- saber_pro %>%
  filter(!is.na(MOD_INGLES_DESEM), !is.na(MOD_RAZONA_CUANTITAT_PUNT),
         !is.na(MOD_LECTURA_CRITICA_PUNT), !is.na(INST_ORIGEN)) %>%
  mutate(b1_o_mas = ifelse(MOD_INGLES_DESEM %in% c("B1", "B+", "B2"), 1, 0),
         privada  = ifelse(INST_ORIGEN == "NO OFICIAL - PRIVADA", 1, 0))

logit_model <- glm(b1_o_mas ~ MOD_RAZONA_CUANTITAT_PUNT +
                      MOD_LECTURA_CRITICA_PUNT + privada,
                    data = saber_pro_logit, family = binomial)
summary(logit_model)

# --- Odds ratios y AUC-ROC --------------------------------------------------
or <- exp(coef(logit_model))
or_ci <- exp(confint(logit_model))
cat("\nOdds Ratios:\n")
print(round(or, 4))
cat("\nIC 95% para Odds Ratios:\n")
print(round(or_ci, 4))

# AUC-ROC
prob_pred <- predict(logit_model, type = "response")
roc_obj <- roc(saber_pro_logit$b1_o_mas, prob_pred)
cat("\nAUC:", round(auc(roc_obj), 4), "\n")

plot(roc_obj, main = "Curva ROC: Probabilidad de alcanzar B1 o mas",
     col = "steelblue", lwd = 2)
abline(a = 0, b = 1, lty = 2, col = "gray50")
