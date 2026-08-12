# ============================================================================
# Sesion 9: Bootstrap y tamano de muestra
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 23 oct 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)
library(boot)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

set.seed(2026)
ingles <- saber_pro$MOD_INGLES_PUNT[!is.na(saber_pro$MOD_INGLES_PUNT)]
muestra <- sample(ingles, 500)

# --- Bootstrap percentil ----------------------------------------------------
B <- 5000
boot_medias <- replicate(B, mean(sample(muestra, replace = TRUE)))

ic_percentil <- quantile(boot_medias, c(0.025, 0.975))
cat("Bootstrap percentil (B =", B, "):\n")
cat("  Media estimada:", round(mean(boot_medias), 2), "\n")
cat(sprintf("  IC 95%%: [%.2f, %.2f]\n", ic_percentil[1], ic_percentil[2]))
cat("  SE bootstrap:", round(sd(boot_medias), 2), "\n")

hist(boot_medias, breaks = 50, col = "steelblue",
     main = "Distribucion bootstrap de la media", xlab = expression(bar(X)))
abline(v = ic_percentil, col = "red", lwd = 2, lty = 2)
abline(v = mean(muestra), col = "black", lwd = 2)

# --- Bootstrap BCa -----------------------------------------------------------
stat_fn <- function(data, indices) mean(data[indices])

boot_obj <- boot(muestra, statistic = stat_fn, R = B)
print(boot_obj)

ic_bca <- boot.ci(boot_obj, type = c("perc", "bca", "norm"))
cat("\nComparacion de metodos bootstrap:\n")
print(ic_bca)

# --- Tamano de muestra optimo ------------------------------------------------
sigma_est <- sd(muestra)
margen_deseado <- c(5, 3, 2, 1, 0.5)
z_95 <- qnorm(0.975)

tamano_requerido <- tibble(
  margen = margen_deseado,
  n_necesario = ceiling((z_95 * sigma_est / margen_deseado)^2)
)
cat("\nTamano de muestra necesario para IC 95%:\n")
print(tamano_requerido)

ggplot(tamano_requerido, aes(x = margen, y = n_necesario)) +
  geom_line(color = "steelblue", linewidth = 1) +
  geom_point(color = "steelblue", size = 3) +
  scale_y_log10() +
  labs(title = "Tamano de muestra vs margen de error",
       x = "Margen de error deseado", y = "n necesario (escala log)") +
  theme_minimal()

# Para detectar diferencia con prueba t
tamanos_t <- map_dfr(c(0.2, 0.5, 0.8), function(d) {
  pt <- power.t.test(delta = d * sigma_est, sd = sigma_est,
                     power = 0.80, sig.level = 0.05)
  tibble(d_cohen = d, n_por_grupo = ceiling(pt$n))
})
cat("\nTamano de muestra para potencia 0.80:\n")
print(tamanos_t)

# --- Muestreo estratificado --------------------------------------------------
# Comparar precision: aleatorio simple vs estratificado por estrato
saber_strat <- saber_pro %>%
  filter(!is.na(FAMI_ESTRATOVIVIENDA), !is.na(MOD_INGLES_PUNT))

n_total <- 600
props_estrato <- saber_strat %>%
  count(FAMI_ESTRATOVIVIENDA) %>%
  mutate(prop = n / sum(n), n_asignado = round(prop * n_total))

cat("\nAsignacion proporcional por estrato (n =", n_total, "):\n")
print(props_estrato)

B_sim <- 1000

# Aleatorio simple
se_simple <- replicate(B_sim, {
  s <- slice_sample(saber_strat, n = n_total)
  mean(s$MOD_INGLES_PUNT)
}) %>% sd()

# Estratificado proporcional
se_estratificado <- replicate(B_sim, {
  s <- saber_strat %>%
    group_by(FAMI_ESTRATOVIVIENDA) %>%
    slice_sample(n = min(100, n())) %>%
    ungroup()
  mean(s$MOD_INGLES_PUNT)
}) %>% sd()

cat("\nComparacion de precision:\n")
cat("  SE aleatorio simple:", round(se_simple, 3), "\n")
cat("  SE estratificado:", round(se_estratificado, 3), "\n")
cat("  Ganancia en eficiencia:", round((1 - se_estratificado / se_simple) * 100, 1), "%\n")
