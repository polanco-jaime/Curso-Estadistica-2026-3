# ============================================================================
# Extraccion de datos ICFES desde BigQuery -> Parquet
# Ejecutar UNA VEZ para generar los archivos .parquet en datos/
# Requiere: bigrquery, arrow, dplyr
# ============================================================================

library(bigrquery)
library(arrow)
library(dplyr)

proyecto_bq <- "ph-jabri"

# --- Saber Pro ---------------------------------------------------------------
cat("Extrayendo Saber Pro...\n")
sql_saber_pro <- "SELECT * FROM `ph-jabri.SABER_PRO.SABER_PRO`"
saber_pro <- bq_project_query(proyecto_bq, sql_saber_pro) |>
  bq_table_download()
write_parquet(saber_pro, "saber_pro/saber_pro.parquet")
cat("  -> saber_pro/saber_pro.parquet guardado:", nrow(saber_pro), "filas\n")

# --- Saber 11 ----------------------------------------------------------------
cat("Extrayendo Saber 11...\n")
sql_saber11 <- "SELECT * FROM `ph-jabri.SABER11.SABER11`"
saber11 <- bq_project_query(proyecto_bq, sql_saber11) |>
  bq_table_download()
write_parquet(saber11, "saber11/saber11.parquet")
cat("  -> saber11/saber11.parquet guardado:", nrow(saber11), "filas\n")

# --- Cruce Saber11 - SaberPro ------------------------------------------------
cat("Extrayendo cruce Saber11-SaberPro...\n")
sql_cruce <- "SELECT * FROM `ph-jabri.ICFES.Saber11_SaberPro`"
cruce <- bq_project_query(proyecto_bq, sql_cruce) |>
  bq_table_download()
write_parquet(cruce, "cruce/cruce_saber11_saberpro.parquet")
cat("  -> cruce/cruce_saber11_saberpro.parquet guardado:", nrow(cruce), "filas\n")

cat("\nExtraccion completa. Archivos .parquet listos para subir al repositorio.\n")
