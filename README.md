# Estad\'istica — Ciencias Econ\'omicas y Administrativas — 2026-III

**Pontificia Universidad Javeriana**
Facultad de Ciencias Economicas y Administrativas
Profesor: Jaime Polanco Jimenez — jaime.polanco@javeriana.edu.co

## Contenido del curso

El curso cubre estadistica aplicada usando datos reales del ICFES (Saber 11 y Saber Pro).

### Unidades

| Unidad | Tema | Sesiones |
|--------|------|----------|
| U1 | Estadistica descriptiva y probabilidad | S01–S03 |
| U2 | Estimacion e intervalos de confianza | S04–S05 |
| U3 | Pruebas de hipotesis | S06–S10 |
| U4 | Regresion lineal | S11–S13 |

## Estructura del repositorio

```
sesiones/          Slides (.tex/.pdf) y codigo R para cada sesion
problem_sets/      Enunciados (.tex/.pdf) y soluciones (.R)
proyecto/          Plantillas para las 3 fases del proyecto semestral
datos/             Datos ICFES en formato Parquet + script de extraccion
utils/             Scripts auxiliares (paquetes R, sync GitHub)
```

## Datos

Los datos del curso provienen de las pruebas ICFES y estan incluidos en formato [Apache Parquet](https://parquet.apache.org/):

| Archivo | Descripcion | Periodos | Filas aprox. |
|---------|-------------|----------|-------------|
| `datos/saber11/saber11.parquet` | Saber 11 — puntajes y variables sociodemograficas | 2015-1, 2015-2 | ~550K |
| `datos/saber_pro/saber_pro.parquet` | Saber Pro — modulos genericos e informacion institucional | 2018–2022 | ~1.5M |
| `datos/cruce/cruce_saber11_saberpro.parquet` | Cruce ICFES: llaves para vincular estudiantes entre Saber 11 y Saber Pro | 2012–2022 | ~2.8M |

Para leer los datos en R:

```r
library(arrow)
saber11   <- read_parquet("datos/saber11/saber11.parquet")
saber_pro <- read_parquet("datos/saber_pro/saber_pro.parquet")
cruce     <- read_parquet("datos/cruce/cruce_saber11_saberpro.parquet")
```

El script `datos/00_extraer_bigquery.R` documenta las consultas SQL originales usadas para extraer los datos desde BigQuery (`ph-jabri`).

## Software requerido

- [R](https://cran.r-project.org/) (>= 4.3)
- [RStudio](https://posit.co/download/rstudio-desktop/)
- Paquetes R: ejecutar `source("utils/setup_paquetes.R")`
