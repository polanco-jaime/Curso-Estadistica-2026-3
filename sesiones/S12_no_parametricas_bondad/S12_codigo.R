# ============================================================================
# Sesion 12: Pruebas no parametricas y bondad de ajuste
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 13 nov 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

# --- Chi2 independencia ------------------------------------------------------


# --- Chi2 bondad de ajuste ---------------------------------------------------


# --- Mann-Whitney ------------------------------------------------------------


# --- Kruskal-Wallis ----------------------------------------------------------


# --- Tablas de contingencia --------------------------------------------------
