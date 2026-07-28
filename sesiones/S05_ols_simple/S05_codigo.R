# ============================================================================
# Sesion 5: Regresion lineal simple OLS
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 18 sep 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))
cruce     <- read_parquet(paste0(gh_raw, "/cruce/cruce_saber11_saberpro.parquet"))

# Cruzar Saber 11 con Saber Pro
datos <- cruce %>%
  inner_join(saber11, by = c("estu_consecutivo_sb11" = "ESTU_CONSECUTIVO")) %>%
  inner_join(saber_pro, by = c("estu_consecutivo_sbpro" = "ESTU_CONSECUTIVO"),
             suffix = c("_sb11", "_sbpro")) %>%
  filter(!is.na(PUNT_INGLES), !is.na(MOD_INGLES_PUNT))

muestra <- datos %>% slice_sample(n = 50000)

# --- Supuestos Gauss-Markov --------------------------------------------------
cat("Supuestos de Gauss-Markov para OLS:\n")
cat("1. Linealidad: Y = b0 + b1*X + e\n")
cat("2. Exogeneidad estricta: E[e|X] = 0\n")
cat("3. Rango completo (no multicolinealidad perfecta)\n")
cat("4. Homocedasticidad: Var(e|X) = sigma^2\n")
cat("5. No autocorrelacion: Cov(e_i, e_j) = 0\n\n")

ggplot(muestra, aes(x = PUNT_INGLES, y = MOD_INGLES_PUNT)) +
  geom_point(alpha = 0.1, color = "steelblue") +
  geom_smooth(method = "lm", color = "red", se = TRUE) +
  labs(title = "Ingles Saber 11 vs Ingles Saber Pro",
       x = "Puntaje Ingles Saber 11", y = "Puntaje Ingles Saber Pro") +
  theme_minimal()

# --- OLS simple --------------------------------------------------------------
modelo_simple <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES, data = muestra)
summary(modelo_simple)

cat("\nInterpretacion:\n")
cat("b0 =", round(coef(modelo_simple)[1], 3),
    "-> puntaje esperado en Saber Pro si Saber 11 = 0\n")
cat("b1 =", round(coef(modelo_simple)[2], 3),
    "-> por cada punto adicional en Saber 11,\n",
    "   el puntaje de Saber Pro aumenta en", round(coef(modelo_simple)[2], 3), "\n")

# --- R2 prueba t y F ---------------------------------------------------------
r2  <- summary(modelo_simple)$r.squared
r2a <- summary(modelo_simple)$adj.r.squared
cat("\nR2 =", round(r2, 4), "\n")
cat("R2 ajustado =", round(r2a, 4), "\n")

# Prueba t para b1
coefs <- summary(modelo_simple)$coefficients
cat("\nPrueba t para b1:\n")
cat("t =", round(coefs[2, "t value"], 2), "\n")
cat("p-valor =", format(coefs[2, "Pr(>|t|)"], digits = 4), "\n")

# Prueba F global
f_stat <- summary(modelo_simple)$fstatistic
p_f <- pf(f_stat[1], f_stat[2], f_stat[3], lower.tail = FALSE)
cat("\nPrueba F global:\n")
cat("F =", round(f_stat[1], 2), "  p-valor =", format(p_f, digits = 4), "\n")

# Graficos diagnosticos
par(mfrow = c(2, 2))
plot(modelo_simple)
par(mfrow = c(1, 1))

# --- Modelo con dummy PRIVADA ------------------------------------------------
saber_pro_d <- saber_pro %>%
  filter(!is.na(INST_ORIGEN), !is.na(MOD_INGLES_PUNT)) %>%
  mutate(privada = ifelse(INST_ORIGEN == "NO OFICIAL - PRIVADA", 1, 0))

modelo_dummy <- lm(MOD_INGLES_PUNT ~ privada, data = saber_pro_d)
summary(modelo_dummy)

cat("\nModelo con dummy:\n")
cat("b0 =", round(coef(modelo_dummy)[1], 2),
    "-> media puntaje IES publicas\n")
cat("b1 =", round(coef(modelo_dummy)[2], 2),
    "-> diferencia promedio privada - publica\n")

ggplot(saber_pro_d, aes(x = factor(privada, labels = c("Publica", "Privada")),
                        y = MOD_INGLES_PUNT)) +
  geom_boxplot(fill = c("steelblue", "coral")) +
  labs(title = "Puntaje de ingles: Publica vs Privada",
       x = "Tipo de IES", y = "Puntaje ingles Saber Pro") +
  theme_minimal()
