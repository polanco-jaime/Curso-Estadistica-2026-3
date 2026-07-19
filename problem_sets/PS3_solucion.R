# ============================================================================
# Problem Set 3: Distribucion Normal y Teorema Central del Limite
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Asignado: Ago 21 | Entrega: Sep 11
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)

# datos_pro <- read.csv("../../datos/saber_pro/ARCHIVO.csv")
# ni <- datos_pro %>% filter(PROGRAMA == "NEGOCIOS INTERNACIONALES")

# saber11 <- read.csv("../../datos/saber11/ARCHIVO.csv")

# ============================================================================
# PARTE 1: Ejercicios con la Distribucion Normal
# ============================================================================

# --- a) Parametros de MOD_INGLES_PUNT ----------------------------------------
# TODO: Calcular media mu y desviacion estandar sigma


# --- b) Calculo de probabilidades con pnorm() -------------------------------
# TODO: P(X > 150)
# TODO: P(120 < X < 160)
# TODO: P(X < 100)


# --- c) Calculo de cuantiles con qnorm() -------------------------------------
# TODO: Cuantil 0.25 (Q1)
# TODO: Cuantil 0.90 (P90)
# TODO: IQR = Q3 - Q1


# --- d) Visualizacion: histograma + curva normal teorica ---------------------
# TODO: Histograma de MOD_INGLES_PUNT
# TODO: Superponer curva dnorm(x, mean = mu, sd = sigma)
# TODO: Comentar sobre el ajuste


# ============================================================================
# PARTE 2: Simulacion del Teorema Central del Limite
# ============================================================================

# --- e) Distribucion poblacional de PUNT_INGLES (Saber 11) ------------------
# TODO: Calcular mu y sigma poblacionales
# TODO: Histograma de la distribucion poblacional


# --- f) Simulacion del TCL ---------------------------------------------------
# set.seed(2026)
# TODO: Para n = 30, 100, 500:
#   - Extraer 2000 muestras aleatorias de tamano n
#   - Calcular la media de cada muestra
#   - Graficar distribucion de medias muestrales


# --- g) Convergencia: superponer curva N(mu, sigma^2/n) ---------------------
# TODO: Para cada n, graficar histograma + curva teorica
# TODO: Comentar sobre convergencia


# --- h) Error estandar teorico vs simulado -----------------------------------
# TODO: SE_teorico = sigma / sqrt(n)
# TODO: SE_simulado = sd(medias_muestrales)
# TODO: Tabla comparativa para n = 30, 100, 500


# --- i) Conclusiones ---------------------------------------------------------
# TODO: Explicar que demuestra la simulacion sobre el TCL
# TODO: Relevancia para inferencia estadistica
