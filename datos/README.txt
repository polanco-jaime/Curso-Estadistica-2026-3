================================================================================
  DATOS ICFES - Curso de Estadistica 2026-II
  Pontificia Universidad Javeriana
================================================================================

Este directorio contiene los microdatos del ICFES en formato Parquet.
Los archivos se cargan directamente desde GitHub en cada sesion de R.

FUENTES DE DATOS (BigQuery)
----------------------------
  - ph-jabri.SABER11        -> Saber 11 por semestre/ano
  - ph-jabri.SABER_PRO      -> Saber Pro por semestre/ano
  - ph-jabri.ICFES.Saber11_SaberPro -> Llaves para cruzar Saber 11 con Saber Pro

GENERACION DE LOS .parquet
---------------------------
  Ejecutar datos/00_extraer_bigquery.R (requiere bigrquery y arrow).
  El script extrae las tablas de BigQuery y las guarda como .parquet.

ESTRUCTURA DE CARPETAS
-----------------------
  datos/
  ├── 00_extraer_bigquery.R          <- Script de extraccion
  ├── saber11/saber11.parquet        <- Pruebas Saber 11
  ├── saber_pro/saber_pro.parquet    <- Pruebas Saber Pro
  └── cruce/cruce_saber11_saberpro.parquet <- Cruce Saber11-SaberPro

USO EN R
---------
  library(arrow)
  gh <- "https://raw.githubusercontent.com/polanco-jaime/
         Curso-Estadistica-2026-3/main/datos"
  saber_pro <- read_parquet(paste0(gh, "/saber_pro/saber_pro.parquet"))

VARIABLES PRINCIPALES
----------------------
  MOD_INGLES_PUNT            Puntaje ingles Saber Pro (variable central)
  PUNT_INGLES                Puntaje ingles Saber 11
  MOD_RAZONA_CUANTITAT_PUNT  Razonamiento cuantitativo Saber Pro
  ESTU_GENERO                Genero del estudiante
  ESTU_DEPTO_RESIDE          Departamento de residencia
  INST_ORIGEN                Tipo de IES (publica/privada)
  FAMI_ESTRATOVIVIENDA       Estrato socioeconomico

NOTAS
------
  - Formato Parquet: compresion columnar, mas liviano y rapido que CSV.
  - Requiere paquete arrow en R: install.packages("arrow")
  - Fuente oficial: https://icfes.gov.co/resultados-saber
  - Foco del curso: programa Negocios Internacionales (NI).
