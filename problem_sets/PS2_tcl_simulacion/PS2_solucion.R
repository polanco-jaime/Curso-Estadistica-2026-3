# ============================================================================
# Problem Set 2: Correlacion y Paradoja de Simpson
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Asignado: Ago 14 | Entrega: Ago 21
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(corrplot)

# datos <- read.csv("../../datos/saber_pro/ARCHIVO.csv")
# ni <- datos %>% filter(PROGRAMA == "NEGOCIOS INTERNACIONALES")

# --- a) Matriz de correlaciones Pearson y Spearman ---------------------------
# Variables: MOD_INGLES_PUNT, MOD_RAZONA_CUANTITAT_PUNT,
#            MOD_LECTURA_CRITICA_PUNT, MOD_COMPETEN_CIUDADA_PUNT,
#            MOD_COMUNI_ESCRITA_PUNT
# TODO: Seleccionar las 5 variables
# TODO: cor(..., method = "pearson")
# TODO: cor(..., method = "spearman")
# TODO: corrplot() o heatmap para visualizar
# TODO: Identificar pares con mayor y menor correlacion
# TODO: Comparar diferencias entre Pearson y Spearman


# --- b) Tabla de contingencia genero x nivel ingles MCER ---------------------
# TODO: Crear variable nivel_mcer a partir de MOD_INGLES_DESEM (A-, A1, A2, B1, B+)
# TODO: table(ESTU_GENERO, nivel_mcer)
# TODO: Calcular frecuencias absolutas y relativas
# TODO: prop.table()
# TODO: Identificar patrones


# --- c) Paradoja de Simpson --------------------------------------------------
# TODO: Calcular correlacion agregada entre dos variables
# TODO: Calcular correlacion desagregada por tipo IES o estrato
# TODO: Crear graficos que muestren la inversion o cambio de relacion
# TODO: Explicar el fenomeno observado


# --- d) Conclusiones ---------------------------------------------------------
# TODO: Explicar relevancia para politica educativa
# TODO: Discutir riesgos de no controlar variables confusoras
