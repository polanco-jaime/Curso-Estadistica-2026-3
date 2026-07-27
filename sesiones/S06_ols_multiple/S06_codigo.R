# ============================================================================
# Sesion 6: Regresion lineal multiple
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 25 sep 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

# --- OLS multiple ------------------------------------------------------------


# --- Sesgo variable omitida OVB ----------------------------------------------


# --- VIF y multicolinealidad ------------------------------------------------


# --- AIC BIC -----------------------------------------------------------------


# --- Interaccion privada x estrato -------------------------------------------
