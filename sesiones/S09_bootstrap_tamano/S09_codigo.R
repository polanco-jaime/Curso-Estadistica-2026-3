# ============================================================================
# Sesion 9: Bootstrap y tamano de muestra
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 23 oct 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

# --- Bootstrap percentil ----------------------------------------------------


# --- Bootstrap BCa -----------------------------------------------------------


# --- Tamano de muestra optimo ------------------------------------------------


# --- Muestreo estratificado --------------------------------------------------
