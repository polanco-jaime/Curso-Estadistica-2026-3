# ============================================================================
# Sesion 7: Diagnosticos y regresion logistica
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 2 oct 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

# --- Breusch-Pagan -----------------------------------------------------------


# --- Durbin-Watson ------------------------------------------------------------


# --- Cook D ------------------------------------------------------------------


# --- Errores estandar robustos -----------------------------------------------


# --- Regresion logistica -----------------------------------------------------


# --- Odds ratios y AUC-ROC --------------------------------------------------
