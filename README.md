# Estadística — Ciencias Económicas y Administrativas — 2026-II

**Pontificia Universidad Javeriana**  
Facultad de Ciencias Económicas y Administrativas  
Profesor: Jaime Polanco Jiménez — `jaime.polanco@javeriana.edu.co`

---

## Contenido del curso

Curso de estadística aplicada para economía y administración con datos reales del ICFES (**Saber 11** y **Saber Pro**) y experimentos controlados aleatorizados (RCT) en **R**.

### Sesiones del semestre

| Sesión | Tema | Carpeta |
|--------|------|---------|
| **S00** | Conceptos fundamentales de probabilidad | `sesiones/S00_conceptos_fundamentales/` |
| **S01** | Estadística descriptiva numérica | `sesiones/S01_descriptiva_numerica/` |
| **S02** | Estadística descriptiva gráfica, correlación y paradoja de Simpson | `sesiones/S02_descriptiva_grafica/` |
| **S03** | Probabilidad, distribución normal, muestreo y TCL | `sesiones/S03_probabilidad_normal_muestreo/` |
| **S04** | Estimación puntual e intervalos de confianza | `sesiones/S04_estimacion_ic/` |
| **S06** | Pruebas de hipótesis, $p$-valor, $d$ de Cohen y potencia | `sesiones/S06_pruebas_hipotesis/` |
| **S08** | Chi-cuadrado ($\chi^2$), independencia e introducción a OLS | `sesiones/S08_chi2_independencia_bondad/` |
| **S09** | Regresión lineal simple (OLS), $R^2$, dummies y LPM | `sesiones/S09_ols_simple/` |
| **S10** | Regresión lineal múltiple, OVB, VIF, interacciones y atrición (RCT) | `sesiones/S10_ols_multiple/` |
| **S11** | Diagnósticos de regresión, heterocedasticidad y errores robustos | `sesiones/S11_diagnosticos_regresion/` |
| **S12** | Integración aplicada: pipeline completo de investigación | `sesiones/S12_integracion_aplicada/` |
| **S13** | Repaso final e integración del curso | `sesiones/S13_repaso_final/` |

---

## Estructura del repositorio

```text
Syllabus.pdf       Programa oficial del curso
sesiones/          Slides (.tex/.pdf), código R y notebooks de cada sesión (S00–S13)
problem_sets/      Enunciados de los talleres (PS1–PS8)
proyecto/          Asignación de grupos, guías de Fase 1–2 y slides de Fase 3 (Video-Podcast)
examenes/          Guías de repaso e instrucciones públicas del examen final (RCT)
datos/             Datos ICFES en formato Parquet + script de extracción
utils/             Scripts auxiliares (paquetes R)
```

---

## Proyecto Integrador (Saber 11 $\rightarrow$ Saber Pro)

- **Fase 1 (20%):** Análisis exploratorio de datos (EDA) — `proyecto/fase1_eda/`
- **Fase 2 (35%):** Intervalos de confianza y pruebas de hipótesis — `proyecto/fase2_ic_pruebas/`
- **Fase 3 (45%):** Entrega final en formato **Video-Podcast** (YouTube + script reproducible en Campus Virtual) — `proyecto/fase3_modelo_informe/slides_fase3_podcast.pdf`

---

## Datos

Los datos del curso provienen de las pruebas ICFES y están incluidos en formato [Apache Parquet](https://parquet.apache.org/):

| Archivo | Descripción | Periodos | Filas aprox. |
|---------|-------------|----------|--------------|
| `datos/saber11/saber11.parquet` | Saber 11 — puntajes y variables sociodemográficas | 2015-1, 2015-2 | ~550K |
| `datos/saber_pro/saber_pro.parquet` | Saber Pro — módulos genéricos e información institucional | 2018–2022 | ~1.5M |
| `datos/cruce/cruce_saber11_saberpro.parquet` | Cruce ICFES: llaves para vincular estudiantes entre Saber 11 y Saber Pro | 2012–2022 | ~2.8M |

Para leer los datos en R:

```r
library(arrow)
saber11   <- read_parquet("datos/saber11/saber11.parquet")
saber_pro <- read_parquet("datos/saber_pro/saber_pro.parquet")
cruce     <- read_parquet("datos/cruce/cruce_saber11_saberpro.parquet")
```

El script `datos/00_extraer_bigquery.R` documenta las consultas SQL originales usadas para extraer los datos desde BigQuery.

---

## Software requerido

- [R](https://cran.r-project.org/) (>= 4.3)
- [RStudio](https://posit.co/download/rstudio-desktop/)
- Paquetes R: ejecutar `source("utils/setup_paquetes.R")`
