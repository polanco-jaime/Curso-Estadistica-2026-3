# ============================================================================
# Sesion 4: Propiedades de estimadores y MLE
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 11 sep 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)
library(MASS)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

poblacion <- saber_pro$MOD_INGLES_PUNT[!is.na(saber_pro$MOD_INGLES_PUNT)]
mu_real   <- mean(poblacion)

# --- Insesgamiento consistencia eficiencia -----------------------------------
set.seed(2026)
B <- 2000
tamanos <- c(10, 30, 100, 500, 2000)

resultados <- map_dfr(tamanos, function(n) {
  medias <- replicate(B, mean(sample(poblacion, n, replace = TRUE)))
  tibble(n = n, media_muestral = medias)
})

resultados %>%
  group_by(n) %>%
  summarise(
    E_Xbar   = mean(media_muestral),
    sesgo    = mean(media_muestral) - mu_real,
    var_Xbar = var(media_muestral),
    .groups  = "drop"
  ) %>%
  print()

ggplot(resultados, aes(x = factor(n), y = media_muestral)) +
  geom_boxplot(fill = "steelblue", alpha = 0.6) +
  geom_hline(yintercept = mu_real, linetype = "dashed", color = "red") +
  labs(title = "Consistencia: la media muestral converge a mu",
       x = "Tamano de muestra (n)", y = expression(bar(X))) +
  theme_minimal()

# Eficiencia: media vs mediana
comparacion <- map_dfr(tamanos, function(n) {
  medias   <- replicate(B, mean(sample(poblacion, n)))
  medianas <- replicate(B, median(sample(poblacion, n)))
  tibble(n = n,
         estimador = rep(c("Media", "Mediana"), each = B),
         valor = c(medias, medianas))
})

comparacion %>%
  group_by(n, estimador) %>%
  summarise(varianza = var(valor), .groups = "drop") %>%
  pivot_wider(names_from = estimador, values_from = varianza) %>%
  mutate(eficiencia_relativa = Mediana / Media) %>%
  print()

# --- Bias-variance tradeoff --------------------------------------------------
trim_levels <- c(0, 0.05, 0.10, 0.20, 0.30)
n <- 100

bias_var <- map_dfr(trim_levels, function(tr) {
  estimaciones <- replicate(B, mean(sample(poblacion, n), trim = tr))
  tibble(trim = tr,
         sesgo = mean(estimaciones) - mu_real,
         var   = var(estimaciones),
         ecm   = mean((estimaciones - mu_real)^2))
})
print(bias_var)

ggplot(bias_var, aes(x = var, y = sesgo^2)) +
  geom_point(size = 3, color = "steelblue") +
  geom_text(aes(label = paste0("trim=", trim)), vjust = -1) +
  labs(title = "Tradeoff Sesgo-Varianza", x = "Varianza", y = "Sesgo^2") +
  theme_minimal()

# --- MLE con fitdistr --------------------------------------------------------
fit_normal <- fitdistr(poblacion, "normal")
cat("\nMLE Normal:\n")
print(fit_normal)
cat("mu_MLE =", fit_normal$estimate["mean"], "\n")
cat("sigma_MLE =", fit_normal$estimate["sd"], "\n")
cat("Log-verosimilitud:", fit_normal$loglik, "\n")

ggplot(data.frame(x = poblacion), aes(x)) +
  geom_histogram(aes(y = after_stat(density)), bins = 50,
                 fill = "steelblue", alpha = 0.6) +
  stat_function(fun = dnorm,
                args = list(mean = fit_normal$estimate["mean"],
                            sd   = fit_normal$estimate["sd"]),
                color = "red", linewidth = 1.2) +
  labs(title = "Ajuste MLE Normal a puntaje de ingles",
       x = "Puntaje", y = "Densidad") +
  theme_minimal()
