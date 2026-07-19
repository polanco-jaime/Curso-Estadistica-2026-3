# ============================================================================
# Problem Set 5: Pruebas t de Student y Tamano del Efecto
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Asignado: Sep 18 | Entrega: Sep 25
# ============================================================================

# --- Cargar paquetes ---------------------------------------------------------
library(tidyverse)
library(effsize)

# --- Cargar datos ------------------------------------------------------------
# Opcion 1: Leer desde CSV local
# datos <- read.csv("../../datos/saber_pro_ni.csv")

# Opcion 2: Conectar a BigQuery (proyecto ph-jabri)
# library(bigrquery)
# bq_auth()
# sql <- "SELECT MOD_INGLES_PUNT, ESTU_INST_NATURALEZA
#         FROM `ph-jabri.ICFES.Saber11_SaberPro`
#         WHERE ESTU_PRGM_ACADEMICO LIKE '%NEGOCIOS INTERNACIONALES%'"
# datos <- bq_project_query("ph-jabri", sql) %>% bq_table_download()

# Filtrar estudiantes de Negocios Internacionales (NI)
# ni <- datos %>% filter(!is.na(MOD_INGLES_PUNT))


# --- 1) Prueba t de una muestra ----------------------------------------------
# H0: mu = 160 vs. H1: mu != 160

# TODO: Aplicar t.test() para probar si la media de MOD_INGLES_PUNT difiere de 160


# TODO: Reportar estadistico t, grados de libertad, p-valor e IC al 95%


# TODO: Interpretar: ¿Rechaza H0 al 5%? ¿Que implica?



# --- 2) Prueba t de dos muestras independientes ------------------------------
# H0: mu_publica = mu_privada vs. H1: mu_publica != mu_privada

# TODO: Separar datos por tipo de institucion (publica vs. privada)
# Sugerencia: usar la variable ESTU_INST_NATURALEZA


# TODO: Aplicar t.test() de dos muestras (Welch, varianzas desiguales)


# TODO: Reportar estadistico t, grados de libertad, p-valor, diferencia de medias


# TODO: Interpretar: ¿Rechaza H0? ¿Cual grupo tiene mayor puntaje promedio?



# --- 3) Tamano del efecto: d de Cohen ----------------------------------------

# TODO: Calcular d de Cohen usando effsize::cohen.d()
# Alternativamente, calcular manualmente:
# d = (mean_privada - mean_publica) / s_pooled


# TODO: Interpretar d segun convencion de Cohen:
# Pequeno: |d| ~ 0.2, Mediano: |d| ~ 0.5, Grande: |d| ~ 0.8


# TODO: ¿El efecto tiene relevancia practica ademas de significancia estadistica?



# --- 4) Curva de potencia ----------------------------------------------------

# TODO: Usar power.t.test() para calcular potencia con distintos n
# Usar d de Cohen del punto anterior como efecto esperado
# Probar n = 30, 50, 100, 200, 500 por grupo


# TODO: Crear data frame con resultados (n, potencia)


# TODO: Graficar curva de potencia (n vs. potencia)
# Agregar linea horizontal en potencia = 0.80


# TODO: ¿Cual es el n minimo por grupo para potencia >= 0.80?



# --- 5) Conclusiones ---------------------------------------------------------

# TODO: Sintetizar hallazgos:
# - ¿El puntaje promedio de NI difiere de 160 puntos?
# - ¿Existe brecha publico-privado en ingles? ¿Es grande?
# - ¿El tamano de muestra actual es adecuado?


# ============================================================================
# Fin del Problem Set 5
# ============================================================================
