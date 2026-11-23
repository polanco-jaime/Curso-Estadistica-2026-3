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

# --- Visualizacion del concepto de IC con datos reales ----------------------
set.seed(1)
n_muestra <- 30
n_muestras <- 20
alpha <- 0.05

mu_real <- mean(poblacion)

sim_ic <- map_dfr(1:n_muestras, function(i) {
  muestra <- sample(poblacion, n_muestra)
  xbar <- mean(muestra)
  s    <- sd(muestra)
  ee   <- s / sqrt(n_muestra)
  t_c  <- qt(1 - alpha / 2, df = n_muestra - 1)
  tibble(
    muestra  = i,
    media    = xbar,
    ic_inf   = xbar - t_c * ee,
    ic_sup   = xbar + t_c * ee,
    contiene = ic_inf <= mu_real & mu_real <= ic_sup
  )
})

n_contiene <- sum(sim_ic$contiene)

p_ic <- ggplot(sim_ic, aes(x = media, y = factor(muestra),
                            color = contiene)) +
  geom_point(size = 2.5) +
  geom_errorbarh(aes(xmin = ic_inf, xmax = ic_sup),
                 height = 0.3, linewidth = 0.8) +
  geom_vline(xintercept = mu_real, linetype = "dashed",
             color = "blue", linewidth = 0.7) +
  scale_color_manual(
    values = c("TRUE" = "forestgreen", "FALSE" = "red"),
    labels = c("TRUE" = "Contiene mu", "FALSE" = "No contiene mu")
  ) +
  annotate("text", x = mu_real, y = n_muestras + 1.2,
           label = paste0("mu real = ", round(mu_real, 1)),
           color = "blue", hjust = 0.5, size = 3.5) +
  labs(
    title = paste0("20 muestras de n=30 de MOD_INGLES_PUNT: ",
                   n_contiene, " de 20 IC contienen mu"),
    x = "Puntaje de ingles (IC 95%)",
    y = "Muestra",
    color = NULL
  ) +
  theme_minimal(base_size = 12) +
  theme(legend.position = "bottom")

print(p_ic)

ggsave("sesiones/S04_estimadores_mle/S04_visualizacion_ic.pdf",
       p_ic, width = 10, height = 6)

# --- Forest plot: IC de ingles por departamento (datos reales) --------------
ic_deptos <- saber_pro %>%
  filter(!is.na(MOD_INGLES_PUNT), !is.na(ESTU_DEPTO_RESIDE)) %>%
  group_by(ESTU_DEPTO_RESIDE) %>%
  summarise(
    n      = n(),
    media  = mean(MOD_INGLES_PUNT),
    sd     = sd(MOD_INGLES_PUNT),
    ee     = sd / sqrt(n),
    t_c    = qt(0.975, df = n - 1),
    ic_inf = media - t_c * ee,
    ic_sup = media + t_c * ee,
    .groups = "drop"
  ) %>%
  filter(n >= 100) %>%
  arrange(media)

media_nacional <- weighted.mean(ic_deptos$media, ic_deptos$n)

p_forest <- ggplot(ic_deptos,
       aes(x = media,
           y = reorder(ESTU_DEPTO_RESIDE, media))) +
  geom_point(size = 2, color = "steelblue") +
  geom_errorbarh(aes(xmin = ic_inf, xmax = ic_sup),
                 height = 0.3, color = "steelblue", linewidth = 0.5) +
  geom_vline(xintercept = media_nacional, linetype = "dashed",
             color = "red", linewidth = 0.6) +
  annotate("text", x = media_nacional, y = 1,
           label = paste0("Media nacional = ", round(media_nacional, 1)),
           color = "red", hjust = -0.05, vjust = -0.5, size = 3) +
  labs(
    title = "IC al 95% para la media de MOD_INGLES_PUNT por departamento",
    subtitle = "Saber Pro - Departamentos con n >= 100",
    x = "Puntaje promedio de ingles (IC 95%)",
    y = NULL
  ) +
  theme_minimal(base_size = 10) +
  theme(axis.text.y = element_text(size = 7))

print(p_forest)

ggsave("sesiones/S04_estimadores_mle/S04_forest_deptos.pdf",
       p_forest, width = 10, height = 8)
