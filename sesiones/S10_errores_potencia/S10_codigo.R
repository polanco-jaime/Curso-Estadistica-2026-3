# ============================================================================
# Sesion 10: Errores y potencia estadistica
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 30 oct 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)
library(effsize)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

# --- H0 y H1 p-valor --------------------------------------------------------
set.seed(2026)
muestra <- sample(saber_pro$MOD_INGLES_PUNT[!is.na(saber_pro$MOD_INGLES_PUNT)], 200)

# H0: mu = 160 vs H1: mu != 160
test_mu <- t.test(muestra, mu = 160)
cat("Prueba t de una muestra:\n")
cat("H0: mu = 160 vs H1: mu != 160\n")
cat("t =", round(test_mu$statistic, 3), "\n")
cat("p-valor =", format(test_mu$p.value, digits = 4), "\n")
cat("IC 95%: [", round(test_mu$conf.int[1], 2), ",",
    round(test_mu$conf.int[2], 2), "]\n")
if (test_mu$p.value < 0.05) {
  cat("-> Rechazamos H0 al 5%\n")
} else {
  cat("-> No se rechaza H0 al 5%\n")
}

# --- Error tipo I y II -------------------------------------------------------
# Simulacion error tipo I: H0 es verdadera
mu0 <- mean(saber_pro$MOD_INGLES_PUNT, na.rm = TRUE)
sigma <- sd(saber_pro$MOD_INGLES_PUNT, na.rm = TRUE)
n <- 100
alpha <- 0.05
B <- 5000

rechazos_tipo1 <- replicate(B, {
  x <- rnorm(n, mean = mu0, sd = sigma)
  t.test(x, mu = mu0)$p.value < alpha
})
cat("\nSimulacion Error Tipo I (H0 verdadera):\n")
cat("Tasa de rechazo (deberia ser ~", alpha, "):", mean(rechazos_tipo1), "\n")

# Simulacion error tipo II: H1 es verdadera (mu = mu0 + 5)
delta <- 5
rechazos_potencia <- replicate(B, {
  x <- rnorm(n, mean = mu0 + delta, sd = sigma)
  t.test(x, mu = mu0)$p.value < alpha
})
cat("\nSimulacion Error Tipo II (H1 verdadera, delta =", delta, "):\n")
cat("Potencia (1 - beta):", mean(rechazos_potencia), "\n")
cat("Error tipo II (beta):", 1 - mean(rechazos_potencia), "\n")

# --- Potencia estadistica ----------------------------------------------------
# Potencia vs tamano de muestra para delta = 5
tamanos <- seq(10, 500, by = 10)
potencias <- sapply(tamanos, function(nn) {
  pt <- power.t.test(n = nn, delta = delta, sd = sigma,
                     sig.level = 0.05, type = "one.sample")
  pt$power
})

potencia_df <- tibble(n = tamanos, potencia = potencias)

ggplot(potencia_df, aes(x = n, y = potencia)) +
  geom_line(color = "steelblue", linewidth = 1) +
  geom_hline(yintercept = 0.80, linetype = "dashed", color = "red") +
  labs(title = "Potencia vs tamano de muestra",
       subtitle = paste("delta =", delta, ", sigma =", round(sigma, 1)),
       x = "Tamano de muestra (n)", y = "Potencia (1 - beta)") +
  theme_minimal()

n_80 <- power.t.test(delta = delta, sd = sigma, power = 0.80,
                     sig.level = 0.05, type = "one.sample")
cat("\nn minimo para potencia 0.80:", ceiling(n_80$n), "\n")

# --- d de Cohen --------------------------------------------------------------
publica <- saber_pro %>%
  filter(INST_ORIGEN == "OFICIAL", !is.na(MOD_INGLES_PUNT)) %>%
  pull(MOD_INGLES_PUNT)
privada <- saber_pro %>%
  filter(INST_ORIGEN == "NO OFICIAL - PRIVADA", !is.na(MOD_INGLES_PUNT)) %>%
  pull(MOD_INGLES_PUNT)

d_cohen <- cohen.d(privada, publica)
cat("\nd de Cohen (privada vs publica):\n")
print(d_cohen)

cat("\nInterpretacion:\n")
cat("|d| < 0.2: efecto trivial\n")
cat("|d| ~ 0.2: efecto pequeno\n")
cat("|d| ~ 0.5: efecto mediano\n")
cat("|d| ~ 0.8: efecto grande\n")

# --- Curva de potencia -------------------------------------------------------
d_values <- c(0.1, 0.2, 0.3, 0.5, 0.8)
curvas <- map_dfr(d_values, function(d) {
  tibble(
    d_cohen = d,
    n = tamanos,
    potencia = sapply(tamanos, function(nn) {
      power.t.test(n = nn, delta = d * sigma, sd = sigma,
                   sig.level = 0.05, type = "two.sample")$power
    })
  )
})

ggplot(curvas, aes(x = n, y = potencia, color = factor(d_cohen))) +
  geom_line(linewidth = 1) +
  geom_hline(yintercept = 0.80, linetype = "dashed") +
  scale_color_viridis_d() +
  labs(title = "Curvas de potencia para diferentes tamanos de efecto",
       x = "n por grupo", y = "Potencia", color = "d de Cohen") +
  theme_minimal()
