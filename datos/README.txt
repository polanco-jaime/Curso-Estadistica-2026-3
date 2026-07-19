================================================================================
  DATOS ICFES - Curso de Estadistica 2026-II
  Pontificia Universidad Javeriana
================================================================================

Este directorio contiene los microdatos del ICFES usados durante el curso.
Los archivos CSV deben descargarse y colocarse en las subcarpetas correspondientes.

FUENTES DE DATOS (BigQuery)
----------------------------
  - ph-jabri.SABER11        -> Saber 11 por semestre/ano
  - ph-jabri.SABER_PRO      -> Saber Pro por semestre/ano
  - ph-jabri.ICFES.Saber11_SaberPro -> Llaves para cruzar Saber 11 con Saber Pro

ESTRUCTURA DE CARPETAS
-----------------------
  datos/
  ├── saber11/      <- CSVs de pruebas Saber 11 (por periodo)
  ├── saber_pro/    <- CSVs de pruebas Saber Pro (por periodo)
  └── cruce/        <- CSV con llaves de cruce Saber11-SaberPro

VARIABLES PRINCIPALES
----------------------
  MOD_INGLES_PUNT          Puntaje de ingles Saber Pro (variable central del curso)
  PUNT_INGLES              Puntaje de ingles Saber 11
  MOD_RAZONA_CUANTITAT_PUNT  Puntaje razonamiento cuantitativo Saber Pro
  ESTU_GENERO              Genero del estudiante
  ESTU_DEPTO_RESIDE        Departamento de residencia
  INST_ORIGEN              Tipo de IES (publica/privada)
  FAMI_ESTRATOVIVIENDA     Estrato socioeconomico

NOTAS
------
  - Los archivos CSV no se incluyen en el repositorio por su tamano.
  - Fuente oficial: https://icfes.gov.co/resultados-saber
  - Los datos del programa Negocios Internacionales (NI) son el foco del curso.
