# ============================================================================
# Sesiones 8-9: Chi-Cuadrado y Regresion Lineal Simple (OLS)
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Prof. Jaime Polanco Jimenez
# ============================================================================

library(arrow)
library(dplyr)
library(ggplot2)

# --- Cargar datos ------------------------------------------------------------

gh <- paste0(
  "https://raw.githubusercontent.com/",
  "polanco-jaime/Curso-Estadistica-2026-3/",
  "main/datos"
)

saber_pro <- read_parquet(paste0(gh, "/saber_pro/saber_pro.parquet"))

saber_pro$TIPO_IES <- ifelse(
  grepl("NO OFICIAL", saber_pro$INST_ORIGEN),
  "Privada", "Publica"
)

cat("Observaciones Saber Pro:", nrow(saber_pro), "\n")
glimpse(saber_pro)


# ============================================================================
# PARTE 1: CHI-CUADRADO
# ============================================================================

# --- 1.1 Ejemplo a mano: estrato y aprobacion --------------------------------

tabla_mano <- matrix(
  c(3, 7, 6, 4, 9, 1),
  nrow = 3, byrow = TRUE,
  dimnames = list(
    Estrato = c("Bajo (1-2)", "Medio (3-4)", "Alto (5-6)"),
    Resultado = c("Aprobo", "Reprobo")
  )
)
tabla_mano

# Frecuencias esperadas bajo independencia
n <- sum(tabla_mano)
esperadas <- outer(rowSums(tabla_mano), colSums(tabla_mano)) / n
esperadas

# Estadistico chi-cuadrado a mano
chi2 <- sum((tabla_mano - esperadas)^2 / esperadas)
chi2  # 7.50

gl <- (nrow(tabla_mano) - 1) * (ncol(tabla_mano) - 1)
pchisq(chi2, df = gl, lower.tail = FALSE)  # 0.024

# Verificar con chisq.test()
chisq.test(tabla_mano)


# --- 1.2 Prueba de independencia con datos ICFES -----------------------------

tabla_obs <- table(saber_pro$MOD_INGLES_DESEM, saber_pro$TIPO_IES)
tabla_obs

resultado <- chisq.test(tabla_obs)
resultado

# Frecuencias esperadas
round(resultado$expected, 1)

# Residuos estandarizados
round(resultado$residuals, 2)

# Mosaico
mosaicplot(tabla_obs,
           color = c("steelblue", "coral"),
           main = "Nivel MCER vs Tipo de IES",
           xlab = "Nivel MCER",
           ylab = "Tipo de IES")


# --- 1.3 V de Cramer --------------------------------------------------------

chi2_val <- resultado$statistic
n_obs    <- sum(tabla_obs)
min_dim  <- min(nrow(tabla_obs), ncol(tabla_obs))

V <- sqrt(chi2_val / (n_obs * (min_dim - 1)))
V


# --- 1.4 Bondad de ajuste ---------------------------------------------------

niveles <- table(saber_pro$MOD_INGLES_DESEM)
niveles

chisq.test(niveles, p = rep(1/5, 5))

barplot(niveles,
        col = "steelblue",
        main = "Distribucion de niveles MCER",
        xlab = "Nivel", ylab = "Frecuencia")
abline(h = sum(niveles) / 5, col = "red", lty = 2, lwd = 2)
legend("topright", "Esperado (uniforme)", col = "red", lty = 2)


# ============================================================================
# PARTE 2: REGRESION LINEAL SIMPLE (OLS)
# ============================================================================

# --- 2.1 Cruzar Saber Pro con Saber 11 --------------------------------------

s11 <- read_parquet(paste0(gh, "/saber11/saber11.parquet"))
cr  <- read_parquet(paste0(gh, "/cruce/cruce_saber11_saberpro.parquet"))

saber_pro <- saber_pro |>
  inner_join(cr, by = c("ESTU_CONSECUTIVO" = "estu_consecutivo_sbpro")) |>
  inner_join(
    s11 |> select(ESTU_CONSECUTIVO, PUNT_INGLES, PUNT_MATEMATICAS),
    by = c("estu_consecutivo_sb11" = "ESTU_CONSECUTIVO")
  )

cat("Observaciones despues del cruce:", nrow(saber_pro), "\n")


# --- 2.2 Derivacion OLS: escalar, matricial y R -----------------------------

# Ejemplo con 5 datos ficticios
X_val <- c(40, 50, 60, 70, 80)
Y_val <- c(130, 145, 160, 175, 200)

# Medias
Xbar <- mean(X_val)  # 60
Ybar <- mean(Y_val)  # 162

# Formula escalar
S_XY <- sum((X_val - Xbar) * (Y_val - Ybar))  # 1700
S_XX <- sum((X_val - Xbar)^2)                  # 1000

beta1_hat <- S_XY / S_XX   # 1.70
beta0_hat <- Ybar - beta1_hat * Xbar  # 60

cat("Formula escalar: b0 =", beta0_hat, ", b1 =", beta1_hat, "\n")

# Formula matricial: beta = (X'X)^{-1} X'Y
X <- cbind(1, X_val)
Y <- matrix(Y_val, ncol = 1)

XtX     <- t(X) %*% X
XtX_inv <- solve(XtX)
XtY     <- t(X) %*% Y
beta_hat <- XtX_inv %*% XtY

cat("Formula matricial:\n")
print(beta_hat)

# Verificar con lm()
modelo_ejemplo <- lm(Y_val ~ X_val)
cat("lm():\n")
print(coef(modelo_ejemplo))

# Varianza de beta: sigma^2 (X'X)^{-1}
resid_ej  <- Y_val - X %*% beta_hat
sigma2_hat <- sum(resid_ej^2) / (length(Y_val) - 2)
var_beta   <- sigma2_hat * XtX_inv
cat("Var(beta_hat):\n")
print(var_beta)
cat("SE(b0) =", sqrt(var_beta[1,1]), ", SE(b1) =", sqrt(var_beta[2,2]), "\n")


# --- 2.3 Modelo 1: Matematicas (Saber 11) -> Ingles (Saber Pro) -------------

# Scatter plot
ggplot(saber_pro, aes(x = PUNT_MATEMATICAS, y = MOD_INGLES_PUNT)) +
  geom_point(alpha = 0.1, color = "steelblue", size = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "red",
              fill = "pink", alpha = 0.3) +
  labs(
    title = "Matematicas Saber 11 vs Ingles Saber Pro",
    x = "Puntaje Matematicas Saber 11",
    y = "Puntaje Ingles Saber Pro"
  ) +
  theme_minimal()

# Ajustar OLS
modelo1 <- lm(MOD_INGLES_PUNT ~ PUNT_MATEMATICAS, data = saber_pro)
coef(modelo1)

# Resumen completo
summary(modelo1)

# Valores ajustados y residuos
y_hat    <- fitted(modelo1)
residuos <- residuals(modelo1)

cat("Suma de residuos (debe ser ~0):", sum(residuos), "\n")

datos_modelo <- modelo1$model
cat("Cor(X, residuos) (debe ser ~0):",
    cor(datos_modelo$PUNT_MATEMATICAS, residuos), "\n")

# R^2
cat("R2:", summary(modelo1)$r.squared, "\n")

r <- cor(saber_pro$MOD_INGLES_PUNT, saber_pro$PUNT_MATEMATICAS, use = "complete.obs")
cat("r =", round(r, 4), ", r^2 =", round(r^2, 4), "\n")

# Intervalos de confianza
confint(modelo1, level = 0.95)
confint(modelo1, level = 0.99)

# Residuos vs ajustados
plot(fitted(modelo1), residuals(modelo1),
     xlab = "Valores ajustados",
     ylab = "Residuos",
     main = "Residuos vs Valores Ajustados",
     pch = 20, col = rgb(0.26, 0.43, 0.71, 0.1))
abline(h = 0, col = "red", lwd = 2, lty = 2)

# Diagnostico 4 paneles
par(mfrow = c(2, 2))
plot(modelo1)
par(mfrow = c(1, 1))

# Verificacion formal de supuestos
shapiro.test(sample(residuos, 5000))

library(lmtest)
bptest(modelo1)


# --- 2.3 OLS con dummy: IES privada vs publica ------------------------------

saber_pro$PRIVADA <- ifelse(saber_pro$TIPO_IES == "Privada", 1, 0)
table(saber_pro$PRIVADA)

modelo_dummy <- lm(MOD_INGLES_PUNT ~ PRIVADA, data = saber_pro)
summary(modelo_dummy)

# Verificar: OLS con dummy = "t-test"
t.test(MOD_INGLES_PUNT ~ TIPO_IES, data = saber_pro, var.equal = TRUE)

# Boxplot
ggplot(saber_pro, aes(x = TIPO_IES, y = MOD_INGLES_PUNT, fill = TIPO_IES)) +
  geom_boxplot(alpha = 0.7) +
  geom_hline(yintercept = coef(modelo_dummy)[1],
             linetype = "dashed", color = "blue", linewidth = 1) +
  geom_hline(yintercept = coef(modelo_dummy)[1] + coef(modelo_dummy)[2],
             linetype = "dashed", color = "red", linewidth = 1) +
  labs(
    title = "Puntaje de ingles por tipo de IES",
    x = "Tipo de IES",
    y = "Puntaje Ingles Saber Pro"
  ) +
  scale_fill_manual(values = c("steelblue", "coral")) +
  theme_minimal()


# --- 2.4 Modelo 2 (integrador): Ingles (Saber 11) -> Razon. Cuantitativo ----

# Scatter plot
plot(saber_pro$PUNT_INGLES,
     saber_pro$MOD_RAZONA_CUANTITAT_PUNT,
     xlab = "Ingles Saber 11",
     ylab = "Razonamiento Cuantitativo Saber Pro",
     main = "Relacion entre ingles y razonamiento cuantitativo",
     pch = 20, col = rgb(0, 0, 1, 0.3))

# Correlacion
cor(saber_pro$PUNT_INGLES,
    saber_pro$MOD_RAZONA_CUANTITAT_PUNT,
    use = "complete.obs")

# Ajustar modelo
modelo2 <- lm(MOD_RAZONA_CUANTITAT_PUNT ~ PUNT_INGLES, data = saber_pro)
summary(modelo2)

# Intervalos de confianza
confint(modelo2)

# Diagnostico
par(mfrow = c(2, 2))
plot(modelo2)
par(mfrow = c(1, 1))

# Supuestos
shapiro.test(sample(residuals(modelo2), 5000))
bptest(modelo2)

# Prediccion
nuevo_dato <- data.frame(PUNT_INGLES = 60)

predict(modelo2, newdata = nuevo_dato)
predict(modelo2, newdata = nuevo_dato, interval = "confidence")
predict(modelo2, newdata = nuevo_dato, interval = "prediction")

# Visualizacion final
ggplot(saber_pro, aes(x = PUNT_INGLES, y = MOD_RAZONA_CUANTITAT_PUNT)) +
  geom_point(alpha = 0.1, color = "steelblue", size = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "red",
              fill = "pink", alpha = 0.3) +
  labs(
    title = "Ingles (Saber 11) vs Razonamiento Cuantitativo (Saber Pro)",
    subtitle = paste("R2 =", round(summary(modelo2)$r.squared, 3), ", p < 0.001"),
    x = "Puntaje Ingles Saber 11",
    y = "Puntaje Razonamiento Cuantitativo Saber Pro"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5)
  )
