# ============================================================================
# Sesion 3: Muestreo distribuciones y correlacion
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 21 ago 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

# --- Simulacion TCL ---------------------------------------------------------


# --- Distribuciones chi2 t F ------------------------------------------------


# --- Correlacion Pearson y Spearman ------------------------------------------


# --- Paradoja de Simpson -----------------------------------------------------


# --- Pipeline EDA ------------------------------------------------------------
