# ============================================================================
# Sesion 1: Descriptiva numerica
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 31 jul 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)
library(moments)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

ingles <- saber_pro$MOD_INGLES_PUNT

# --- Medidas de tendencia central --------------------------------------------
media   <- mean(ingles, na.rm = TRUE)
mediana <- median(ingles, na.rm = TRUE)

tabla_freq <- table(ingles)
moda <- as.numeric(names(tabla_freq)[which.max(tabla_freq)])

cat("Media:", round(media, 2), "\n")
cat("Mediana:", mediana, "\n")
cat("Moda:", moda, "\n")

# --- Medidas de dispersion ---------------------------------------------------
desv_est <- sd(ingles, na.rm = TRUE)
varianza <- var(ingles, na.rm = TRUE)
rango    <- range(ingles, na.rm = TRUE)
iqr_val  <- IQR(ingles, na.rm = TRUE)
cv       <- desv_est / media * 100

cat("\nDesviacion estandar:", round(desv_est, 2))
cat("\nVarianza:", round(varianza, 2))
cat("\nRango:", rango[1], "-", rango[2])
cat("\nIQR:", iqr_val)
cat("\nCoeficiente de variacion:", round(cv, 2), "%\n")

cuartiles <- quantile(ingles, probs = c(0.25, 0.50, 0.75), na.rm = TRUE)
percentiles <- quantile(ingles, probs = c(0.10, 0.90), na.rm = TRUE)
cat("\nCuartiles:\n"); print(cuartiles)
cat("P10 y P90:\n"); print(percentiles)

# --- Asimetria y curtosis ----------------------------------------------------
asimetria <- skewness(ingles, na.rm = TRUE)
curtosis  <- kurtosis(ingles, na.rm = TRUE)

cat("\nAsimetria:", round(asimetria, 3))
cat("\nCurtosis:", round(curtosis, 3), "\n")

if (asimetria > 0) cat("  -> Asimetria positiva (cola derecha)\n")
if (asimetria < 0) cat("  -> Asimetria negativa (cola izquierda)\n")
if (abs(asimetria) < 0.5) cat("  -> Aproximadamente simetrica\n")
if (curtosis > 3) cat("  -> Leptocurtica (colas pesadas)\n")
if (curtosis < 3) cat("  -> Platicurtica (colas livianas)\n")

# --- Resumen por estrato -----------------------------------------------------
saber_pro %>%
  filter(!is.na(FAMI_ESTRATOVIVIENDA), !is.na(MOD_INGLES_PUNT)) %>%
  group_by(FAMI_ESTRATOVIVIENDA) %>%
  summarise(
    n       = n(),
    media   = round(mean(MOD_INGLES_PUNT), 2),
    mediana = median(MOD_INGLES_PUNT),
    sd      = round(sd(MOD_INGLES_PUNT), 2),
    min     = min(MOD_INGLES_PUNT),
    max     = max(MOD_INGLES_PUNT),
    .groups = "drop"
  ) %>%
  print()

# --- Resumen rapido ----------------------------------------------------------
summary(ingles)
