# ============================================================================
# Sesion 5: Regresion lineal simple OLS
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 18 sep 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

# --- Supuestos Gauss-Markov --------------------------------------------------


# --- OLS simple --------------------------------------------------------------


# --- R2 prueba t y F ---------------------------------------------------------


# --- Modelo con dummy PRIVADA ------------------------------------------------
