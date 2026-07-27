# ============================================================================
# Sesion 1: Descriptiva numerica
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 31 jul 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

# --- Medidas de tendencia central --------------------------------------------


# --- Medidas de dispersion ---------------------------------------------------


# --- Asimetria y curtosis ----------------------------------------------------
