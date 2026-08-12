# ============================================================================
# Sesion 8: Intervalos de confianza
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 16 oct 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

ingles <- saber_pro$MOD_INGLES_PUNT[!is.na(saber_pro$MOD_INGLES_PUNT)]

# --- IC con z ----------------------------------------------------------------
set.seed(2026)
n <- 200
muestra <- sample(ingles, n)
xbar   <- mean(muestra)
sigma  <- sd(ingles)  # asumimos sigma poblacional conocido
z_95   <- qnorm(0.975)

ic_z <- c(xbar - z_95 * sigma / sqrt(n), xbar + z_95 * sigma / sqrt(n))
cat("IC 95% con z (sigma conocido):\n")
cat(sprintf("  [%.2f, %.2f]\n", ic_z[1], ic_z[2]))
cat("  Media muestral:", round(xbar, 2), "\n")
cat("  Margen de error:", round(z_95 * sigma / sqrt(n), 2), "\n")

# Simulacion: cobertura del IC
B <- 1000
cubre <- replicate(B, {
  m <- sample(ingles, n)
  ic <- mean(m) + c(-1, 1) * z_95 * sigma / sqrt(n)
  ic[1] <= mean(ingles) & mean(ingles) <= ic[2]
})
cat("  Cobertura empirica (1000 simulaciones):", mean(cubre), "\n")

# --- IC con t ----------------------------------------------------------------
t_test <- t.test(muestra, conf.level = 0.95)
cat("\nIC 95% con t (sigma desconocido):\n")
cat(sprintf("  [%.2f, %.2f]\n", t_test$conf.int[1], t_test$conf.int[2]))
cat("  df =", t_test$parameter, "\n")

# Comparacion z vs t
cat("\nAncho IC z:", round(diff(ic_z), 2), "\n")
cat("Ancho IC t:", round(diff(as.numeric(t_test$conf.int)), 2), "\n")
cat("El IC t es mas ancho porque usa s en vez de sigma\n")

# --- IC con chi2 -------------------------------------------------------------
s2   <- var(muestra)
df   <- n - 1
chi_l <- qchisq(0.025, df)
chi_u <- qchisq(0.975, df)

ic_var <- c(df * s2 / chi_u, df * s2 / chi_l)
ic_sd  <- sqrt(ic_var)

cat("\nIC 95% para la varianza (chi-cuadrado):\n")
cat(sprintf("  Var: [%.2f, %.2f]\n", ic_var[1], ic_var[2]))
cat(sprintf("  SD:  [%.2f, %.2f]\n", ic_sd[1], ic_sd[2]))
cat("  s^2 muestral:", round(s2, 2), "\n")

# --- IC para proporciones ----------------------------------------------------
b1_o_mas <- sum(saber_pro$MOD_INGLES_DESEM %in% c("B1", "B+", "B2"), na.rm = TRUE)
n_total  <- sum(!is.na(saber_pro$MOD_INGLES_DESEM))
p_hat    <- b1_o_mas / n_total

se_p <- sqrt(p_hat * (1 - p_hat) / n_total)
ic_p <- p_hat + c(-1, 1) * z_95 * se_p

cat("\nIC 95% para proporcion B1 o superior:\n")
cat("  p_hat =", round(p_hat, 4), "\n")
cat(sprintf("  IC: [%.4f, %.4f]\n", ic_p[1], ic_p[2]))

prop_test <- prop.test(b1_o_mas, n_total, conf.level = 0.95)
cat("  IC con correccion de continuidad:\n")
cat(sprintf("  [%.4f, %.4f]\n", prop_test$conf.int[1], prop_test$conf.int[2]))

# --- Forest plot departamental -----------------------------------------------
ic_deptos <- saber_pro %>%
  filter(!is.na(MOD_INGLES_PUNT), !is.na(ESTU_DEPTO_RESIDE)) %>%
  group_by(ESTU_DEPTO_RESIDE) %>%
  summarise(
    n     = n(),
    media = mean(MOD_INGLES_PUNT),
    sd    = sd(MOD_INGLES_PUNT),
    .groups = "drop"
  ) %>%
  filter(n >= 100) %>%
  mutate(
    se    = sd / sqrt(n),
    lower = media - qt(0.975, n - 1) * se,
    upper = media + qt(0.975, n - 1) * se
  ) %>%
  arrange(media)

media_nacional <- mean(saber_pro$MOD_INGLES_PUNT, na.rm = TRUE)

ggplot(ic_deptos, aes(x = media, y = reorder(ESTU_DEPTO_RESIDE, media))) +
  geom_point(color = "steelblue", size = 2) +
  geom_errorbarh(aes(xmin = lower, xmax = upper), height = 0.3,
                 color = "steelblue") +
  geom_vline(xintercept = media_nacional, linetype = "dashed", color = "red") +
  labs(title = "IC 95% del puntaje de ingles por departamento",
       subtitle = "Linea roja = media nacional",
       x = "Puntaje promedio ingles", y = NULL) +
  theme_minimal()
