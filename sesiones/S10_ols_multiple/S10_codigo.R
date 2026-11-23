# ============================================================================
# S10_codigo.R
# Sesión 10: Regresión Lineal Múltiple — OLS
# Datos: Experimento AI-Driven Mentorship (KU Leuven, 2024)
# Curso de Estadística — Pontificia Universidad Javeriana
# ============================================================================

# ── 0. Paquetes ─────────────────────────────────────────────────────────────
library(car)  # VIF

# ── 1. Cargar y explorar los datos ──────────────────────────────────────────
datos <- read.csv("datos/rct_student_sample.csv")

dim(datos)   # 148 estudiantes, 22 variables
str(datos)
head(datos)

# Variables clave del experimento:
#   Y (post)     : pt_enrollment_likelihood  (0-100)
#   Y (baseline) : enrollment_likelihood     (0-100)
#   Tratamiento  : T1 (Friendly), T2 (Mentor), T3 (Narrative)
#                  Categoría omitida: T0 = Control
#   Controles    : se_pre (autoeficacia), migrant, age

# Resumen descriptivo
summary(datos[, c("pt_enrollment_likelihood", "enrollment_likelihood",
                   "T1", "T2", "T3", "se_pre", "migrant")])

# Distribución de tratamiento
table(datos$treatment)

# Media de Y por grupo de tratamiento
tapply(datos$pt_enrollment_likelihood, datos$treatment, mean, na.rm = TRUE)

# Media de Y baseline por grupo
tapply(datos$enrollment_likelihood, datos$treatment, mean, na.rm = TRUE)


# ============================================================================
# BLOQUE 1: Regresión Múltiple — El Modelo
# ============================================================================

# ── 2. Regresión simple: un solo tratamiento ───────────────────────────────
modelo_simple <- lm(pt_enrollment_likelihood ~ T1, data = datos)
summary(modelo_simple)
# Solo estamos mirando T1 vs T0. Ignoramos T2 y T3.

# ── 3. Regresión múltiple: tres tratamientos ───────────────────────────────
modelo_trat <- lm(pt_enrollment_likelihood ~ T1 + T2 + T3, data = datos)
summary(modelo_trat)
# Nota: R² = 0.010, F no significativo (p = 0.71)
# Ningún tratamiento es significativo individualmente.

# Coeficientes e intervalos de confianza
coef(modelo_trat)
confint(modelo_trat)

# ── 4. OLS con controles baseline (McKenzie, 2012) ─────────────────────────
# Agregar la intención de inscripción PRE-tratamiento como control
modelo_ols <- lm(pt_enrollment_likelihood ~ T1 + T2 + T3 +
                   enrollment_likelihood,
                 data = datos)
summary(modelo_ols)
# ¡R² salta de 0.01 a 0.83!
# El baseline explica la mayor parte de la variación.

# Agregar autoeficacia pre-tratamiento
modelo_completo <- lm(pt_enrollment_likelihood ~ T1 + T2 + T3 +
                        enrollment_likelihood + se_pre,
                      data = datos)
summary(modelo_completo)
# se_pre no es significativa (p = 0.34). R² apenas cambia.

# Interpretación ceteris paribus:
# β_T2 = -0.14: los estudiantes del grupo Mentor reportan 0.14 puntos
#                MENOS de intención que el control, CONTROLANDO POR
#                la intención baseline y autoeficacia. No significativo.


# ============================================================================
# BLOQUE 2: R² y R² ajustado
# ============================================================================

# ── 5. Comparación progresiva de R² ────────────────────────────────────────
cat("=== Modelo 1: solo tratamientos ===\n")
cat("R²    =", summary(modelo_trat)$r.squared, "\n")
cat("R²adj =", summary(modelo_trat)$adj.r.squared, "\n\n")

cat("=== Modelo 2: + baseline ===\n")
cat("R²    =", summary(modelo_ols)$r.squared, "\n")
cat("R²adj =", summary(modelo_ols)$adj.r.squared, "\n\n")

cat("=== Modelo 3: + se_pre ===\n")
cat("R²    =", summary(modelo_completo)$r.squared, "\n")
cat("R²adj =", summary(modelo_completo)$adj.r.squared, "\n")

# Agregar el baseline es clave. Agregar se_pre no aporta.


# ============================================================================
# BLOQUE 3: Pruebas de significancia
# ============================================================================

# ── 6. Prueba F global ──────────────────────────────────────────────────────
# ¿El modelo en conjunto es útil?
# H₀: β₁ = β₂ = β₃ = β₄ = 0
# Ver la última línea de summary()

summary(modelo_ols)
# F-statistic: 179.5 on 4 and 143 DF, p-value: < 2.2e-16
# Rechazamos H₀: el modelo es altamente significativo.

# ── 7. Pruebas t individuales ───────────────────────────────────────────────
# ¿Cada coeficiente aporta?
# Ver la columna Pr(>|t|)
coef(summary(modelo_ols))

# Solo enrollment_likelihood es significativo (p < 2e-16).
# Los tratamientos no son significativos individualmente.


# ============================================================================
# BLOQUE 4: Sesgo por Variable Omitida (OVB)
# ============================================================================

# ── 8. Comparar modelos con y sin baseline ──────────────────────────────────
cat("Coeficientes SIN control baseline:\n")
round(coef(modelo_trat), 2)

cat("\nCoeficientes CON control baseline:\n")
round(coef(modelo_ols), 2)

# T3 pasa de +5.50 a -1.31. ¿Por qué?
# El grupo T3 tenía baseline más alto por azar (84.7 vs 76.6).
# Sin controlar, T3 parece mejor, pero era ventaja previa.

# Verificar la correlación tratamiento-baseline
cor(datos[, c("T1", "T2", "T3", "enrollment_likelihood")],
    use = "complete.obs")
# Baja correlación (esperada en un RCT), pero no perfectamente cero
# con solo 148 observaciones.

# ── 9. Medias baseline por grupo ────────────────────────────────────────────
tapply(datos$enrollment_likelihood, datos$treatment, mean, na.rm = TRUE)
# T0: 76.6, T1: 78.2, T2: 80.0, T3: 84.7
# T3 tiene ventaja previa. Sin controlar, le atribuimos un efecto falso.


# ============================================================================
# BLOQUE 5: VIF y Multicolinealidad
# ============================================================================

# ── 10. Calcular VIF ───────────────────────────────────────────────────────
vif(modelo_completo)
# T1: 1.51, T2: 1.53, T3: 1.50, enrollment: 1.05, se_pre: 1.05
# Todos < 5 → NO hay problema de multicolinealidad.

# ── 11. Ejemplo artificial de multicolinealidad severa ──────────────────────
datos$enrollment_x2 <- datos$enrollment_likelihood * 2 +
                         rnorm(nrow(datos), 0, 0.5)

cor(datos$enrollment_likelihood, datos$enrollment_x2)

modelo_colin <- lm(pt_enrollment_likelihood ~
                     enrollment_likelihood + enrollment_x2,
                   data = datos)
vif(modelo_colin)
# VIF muy alto → eliminar una de las dos variables.


# ============================================================================
# BLOQUE 6: Interacciones y Selección de Modelos
# ============================================================================

# ── 12. Efectos heterogéneos: migrant × tratamiento ────────────────────────
modelo_interaccion <- lm(
  pt_enrollment_likelihood ~ T1 + T2 + T3 +
    enrollment_likelihood +
    T1:migrant + T2:migrant + T3:migrant,
  data = datos
)
summary(modelo_interaccion)
# T2:migrant = -5.37 (p = 0.077): el efecto del Mentor es diferente
# para estudiantes migrantes vs no migrantes (marginalmente significativo).

# Efecto de T2 para NO migrantes: β_T2 = 1.37
# Efecto de T2 para migrantes:     β_T2 + β_T2:migrant = 1.37 - 5.37 = -4.00

# ── 13. AIC y BIC ──────────────────────────────────────────────────────────
AIC(modelo_trat, modelo_ols, modelo_completo, modelo_interaccion)
BIC(modelo_trat, modelo_ols, modelo_completo, modelo_interaccion)

# Modelo OLS + baseline tiene el menor AIC (1070.5) y BIC (1088.5).
# Es el modelo más parsimonioso y mejor ajustado.

# ── 14. Selección automática (backward) ────────────────────────────────────
modelo_full <- lm(
  pt_enrollment_likelihood ~ T1 + T2 + T3 +
    enrollment_likelihood + se_pre + migrant +
    T1:migrant + T2:migrant + T3:migrant,
  data = datos
)

modelo_step <- step(modelo_full, direction = "backward", trace = 1)
summary(modelo_step)
# step() elimina variables que no mejoran el AIC.

# ── 15. Tabla comparativa final ─────────────────────────────────────────────
# Comparar R²_adj de todos los modelos
cat("\n=== Comparación de modelos ===\n")
modelos <- list(
  "Solo tratamiento"   = modelo_trat,
  "OLS + baseline"     = modelo_ols,
  "OLS + baseline + X" = modelo_completo,
  "Con interacciones"  = modelo_interaccion
)
for (nombre in names(modelos)) {
  s <- summary(modelos[[nombre]])
  cat(sprintf("%-22s  R²=%.3f  R²adj=%.3f  AIC=%.1f\n",
              nombre, s$r.squared, s$adj.r.squared, AIC(modelos[[nombre]])))
}

# Limpiar variable artificial
datos$enrollment_x2 <- NULL
