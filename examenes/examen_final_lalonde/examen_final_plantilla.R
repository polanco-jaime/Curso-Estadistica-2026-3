# ============================================================================
# Examen Final: LaLonde (1986) - Analisis de un RCT
# Estadistica 2026-II - Pontificia Universidad Javeriana
#
# Grupo: ___
# Integrantes: ___
# ============================================================================

library(ggplot2)

# === SECCION 1: CARGAR Y EXPLORAR ==========================================

install.packages("Matching", repos = "https://cloud.r-project.org")
library(Matching)
data(lalonde)

# 1.1 Dimensiones y grupos
nrow(lalonde)
ncol(lalonde)
table(lalonde$treat)

# 1.2 Descriptivos por grupo
# COMPLETAR: media, mediana, sd de re78 por grupo
aggregate(re78 ~ treat, data = lalonde, FUN = mean)
# Agregar mediana y sd...


# 1.3 Diferencia bruta
# COMPLETAR: calcular la diferencia de medias
# INTERPRETAR: ...


# 1.4 Boxplot
# COMPLETAR: boxplot de re78 por treat
# INTERPRETAR: ...


# === SECCION 2: BALANCE ====================================================

# 2.1 Tabla de balance
balance_vars <- c("age", "educ", "black", "hisp",
                  "married", "nodegr", "re74", "re75")

cat("=== Tabla de Balance ===\n\n")
for (v in balance_vars) {
  m_treat <- mean(lalonde[[v]][lalonde$treat == 1])
  m_ctrl  <- mean(lalonde[[v]][lalonde$treat == 0])
  tt      <- t.test(lalonde[[v]] ~ lalonde$treat)
  cat(sprintf("%-10s  Treat: %7.2f  Control: %7.2f  p = %.3f\n",
              v, m_treat, m_ctrl, tt$p.value))
}

# 2.2 RESPONDER: Alguna variable con p < 0.05? Discutir...
# RESPUESTA:


# 2.3 RESPONDER: Por que importa el balance pre-tratamiento?
# RESPUESTA:


# === SECCION 3: OLS CON DUMMY ==============================================

# 3.1 Modelo simple
m1 <- lm(re78 ~ treat, data = lalonde)
summary(m1)

# 3.2 ESCRIBIR la ecuacion estimada:
# re78_hat = ___ + ___ * treat

# 3.3 INTERPRETAR beta_0:
# RESPUESTA:

# 3.4 INTERPRETAR beta_1 (efecto causal):
# RESPUESTA:

# 3.5 Intervalo de confianza
confint(m1)
# INTERPRETAR: contiene al 0? que implica?
# RESPUESTA:

# 3.6 Comparar con t-test
t.test(re78 ~ treat, data = lalonde, var.equal = TRUE)
# COMPARAR t-estadistico y p-valor con los del lm()
# RESPUESTA:


# === SECCION 4: R-SQUARED ==================================================

# 4.1 R2 del modelo
summary(m1)$r.squared

# 4.2 R2 a mano
SST <- sum((lalonde$re78 - mean(lalonde$re78))^2)
SSE <- sum(residuals(m1)^2)
SSR <- SST - SSE
R2  <- 1 - SSE / SST

cat("SST:", round(SST, 0), "\n")
cat("SSE:", round(SSE, 0), "\n")
cat("SSR:", round(SSR, 0), "\n")
cat("R2: ", round(R2, 4), "\n")

# 4.3 RESPONDER: R2 bajo = programa no funciona?
# RESPUESTA:

# 4.4 RESPONDER: Diferencia entre R2 y significancia
# RESPUESTA:

# 4.5 RESPONDER: Por que R2 bajo es esperado en un RCT?
# RESPUESTA:


# === SECCION 5: REGRESION MULTIPLE =========================================

# 5.1 Cuatro modelos
m1 <- lm(re78 ~ treat, data = lalonde)
m2 <- lm(re78 ~ treat + re75, data = lalonde)
m3 <- lm(re78 ~ treat + re75 + age + educ + black + married,
         data = lalonde)
m4 <- lm(re78 ~ treat + re74 + re75 + age + educ +
           black + hisp + married + nodegr,
         data = lalonde)

# 5.2 COMPLETAR la tabla de resultados
cat("=== Coeficiente de treat ===\n")
cat("M1:", round(coef(m1)["treat"], 0),
    " SE:", round(coef(summary(m1))["treat", "Std. Error"], 0),
    " R2:", round(summary(m1)$r.squared, 4), "\n")
# COMPLETAR para M2, M3, M4...


# 5.3 RESPONDER: Cambia mucho beta_treat de M1 a M4? Por que?
# RESPUESTA:

# 5.4 RESPONDER: Que pasa con el SE de treat?
# RESPUESTA:

# 5.5 Intervalos de confianza
cat("\n=== IC 95% para treat ===\n")
cat("M1:", round(confint(m1)["treat", ], 0), "\n")
# COMPLETAR para M2, M3, M4...

# 5.6 INTERPRETAR coeficiente de black en M4:
# RESPUESTA:


# === SECCION 6: TABLA DE REGRESION =========================================

# 6.1 Construir tabla estilo paper
# COMPLETAR: usar los resultados de la seccion 5
# Formato: coeficiente con asteriscos, SE entre parentesis

cat("\n=== TABLA DE REGRESION ===\n\n")
cat("                (1)         (2)         (3)         (4)\n")
cat("              re78        re78        re78        re78\n")
cat("-----------------------------------------------------------\n")

models <- list(m1, m2, m3, m4)
vars_show <- c("treat", "re75", "age", "educ", "black", "married")

for (v in vars_show) {
  coefs <- sapply(models, function(m) {
    s <- coef(summary(m))
    if (v %in% rownames(s)) {
      est <- round(s[v, "Estimate"], 0)
      se  <- round(s[v, "Std. Error"], 0)
      p   <- s[v, "Pr(>|t|)"]
      stars <- ifelse(p < 0.01, "***",
                      ifelse(p < 0.05, "**",
                             ifelse(p < 0.10, "*", "")))
      paste0(est, stars, " (", se, ")")
    } else {
      ""
    }
  })
  cat(sprintf("%-12s %12s %12s %12s %12s\n", v,
              coefs[1], coefs[2], coefs[3], coefs[4]))
}
cat("-----------------------------------------------------------\n")
cat(sprintf("%-12s %12s %12s %12s %12s\n", "R2",
            round(summary(m1)$r.squared, 3),
            round(summary(m2)$r.squared, 3),
            round(summary(m3)$r.squared, 3),
            round(summary(m4)$r.squared, 3)))
cat(sprintf("%-12s %12d %12d %12d %12d\n", "N",
            nrow(lalonde), nrow(lalonde), nrow(lalonde), nrow(lalonde)))

# 6.2 ESCRIBIR una oracion de resultados:
# RESPUESTA:


# === SECCION 7: SESGO DE SELECCION =========================================

# 7.1 Simular tratamiento observacional (NO aleatorio)
set.seed(2026)
lalonde$prob <- pnorm(lalonde$re75, mean = 3000, sd = 5000)
lalonde$treat_obs <- rbinom(nrow(lalonde), 1, lalonde$prob)

m_obs1 <- lm(re78 ~ treat_obs, data = lalonde)
m_obs2 <- lm(re78 ~ treat_obs + re75 + age + educ + black,
             data = lalonde)

# 7.2 COMPLETAR la tabla comparativa
cat("\n=== RCT vs Observacional ===\n")
cat("RCT (M1):            ", round(coef(m1)["treat"], 0), "\n")
cat("Obs. sin controles:  ", round(coef(m_obs1)["treat_obs"], 0), "\n")
cat("Obs. con controles:  ", round(coef(m_obs2)["treat_obs"], 0), "\n")

# 7.3 RESPONDER: Direccion del sesgo usando OVB
# RESPUESTA:

# 7.4 RESPONDER: Controles arreglan el sesgo completamente?
# RESPUESTA:

# 7.5 REFLEXION FINAL (maximo 5 oraciones):
# RESPUESTA:

# Limpiar
lalonde$prob      <- NULL
lalonde$treat_obs <- NULL


# === SECCION 8: DIAGNOSTICOS ===============================================

library(lmtest)
library(sandwich)

# 8.1 Breusch-Pagan
bptest(m3)
# INTERPRETAR:

# 8.2 Residuos vs ajustados
plot(fitted(m3), residuals(m3),
     xlab = "Valores ajustados", ylab = "Residuos",
     main = "Residuos vs Ajustados (M3)",
     pch = 20, col = rgb(0, 0.4, 0.7, 0.3))
abline(h = 0, col = "red", lwd = 2)
# INTERPRETAR:

# 8.3 Errores robustos
coeftest(m3, vcov = vcovHC(m3, type = "HC1"))
# COMPARAR con summary(m3): cambia la significancia de treat?
# RESPUESTA:

# 8.4 Cook's distance
cook <- cooks.distance(m3)
cat("\nObs. con Cook's D > 4/n:", sum(cook > 4/nrow(lalonde)), "\n")
cat("Max Cook's D:", round(max(cook), 4), "\n")
# RESPONDER: Deberia eliminar observaciones automaticamente?
# RESPUESTA:


# === SECCION 9: CONEXION CON COLOMBIA ======================================

# 9.1 RESPONDER:
# a) Como evaluarian Jovenes en Accion?
# b) Cual es el tratamiento y cual el resultado?
# c) Por que no basta comparar sin aleatorizacion?
# RESPUESTAS:


# ============================================================================
# FIN DEL EXAMEN FINAL
# ============================================================================
