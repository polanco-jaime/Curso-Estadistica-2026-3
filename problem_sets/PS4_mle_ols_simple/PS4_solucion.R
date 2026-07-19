# ============================================================================
# Problem Set 4: Intervalos de Confianza
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Asignado: Sep 11 | Entrega: Sep 18
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)

# datos <- read.csv("../../datos/saber_pro/ARCHIVO.csv")
# ni <- datos %>% filter(PROGRAMA == "NEGOCIOS INTERNACIONALES")

# --- a) IC para la media global (95%, distribucion t) -----------------------
# TODO: t.test(ni$MOD_INGLES_PUNT, conf.level = 0.95)
# TODO: Reportar intervalo [x_bajo, x_alto]
# TODO: Interpretar en contexto
# TODO: Calcular margen de error


# --- b) IC por departamento --------------------------------------------------
# TODO: Agrupar por ESTU_DEPTO_RESIDE
# TODO: Calcular IC al 95% para cada departamento
# TODO: Crear tabla con: depto, media, lim_inf, lim_sup, n
# TODO: Identificar IC mas amplio y mas estrecho
# TODO: Explicar por que varian los anchos


# --- c) Forest plot de ICs departamentales -----------------------------------
# TODO: Graficar medias con barras de error (IC)
# TODO: Linea vertical en la media nacional
# TODO: Etiquetas de departamento en eje y
# TODO: Identificar departamentos significativamente diferentes


# --- d) IC para una proporcion (B1 o superior) -------------------------------
# TODO: Crear variable binaria: nivel_B1_o_mas
# TODO: prop.test() para calcular IC al 95%
# TODO: Reportar intervalo [p_bajo, p_alto]
# TODO: Interpretar porcentaje de estudiantes con B1+


# --- e) Tamano de muestra optimo (E = +/- 2 puntos) -------------------------
# TODO: Calcular sigma (DE de MOD_INGLES_PUNT)
# TODO: n = (z * sigma / E)^2, con z = 1.96 y E = 2
# TODO: Reportar n necesario


# --- f) Conclusiones ---------------------------------------------------------
# TODO: Resumir hallazgos sobre precision de estimaciones
# TODO: Comentar diferencias departamentales
