# ============================================================================
# Sesion 3: Muestreo distribuciones y correlacion
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 21 ago 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)
library(corrplot)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

# --- Simulacion TCL ---------------------------------------------------------
set.seed(2026)
poblacion <- saber11$PUNT_INGLES[!is.na(saber11$PUNT_INGLES)]
mu_pob    <- mean(poblacion)
sigma_pob <- sd(poblacion)

cat("Poblacion Saber 11 - PUNT_INGLES\n")
cat("mu =", round(mu_pob, 2), " sigma =", round(sigma_pob, 2), "\n\n")

B <- 2000
tamanos <- c(30, 100, 500)

par(mfrow = c(1, 3))
for (n in tamanos) {
  medias <- replicate(B, mean(sample(poblacion, n, replace = TRUE)))
  hist(medias, breaks = 40, probability = TRUE, col = "steelblue",
       main = paste("n =", n), xlab = expression(bar(X)))
  curve(dnorm(x, mu_pob, sigma_pob / sqrt(n)), add = TRUE, col = "red", lwd = 2)
  cat(sprintf("n=%d: SE teorico=%.3f, SE simulado=%.3f\n",
              n, sigma_pob / sqrt(n), sd(medias)))
}
par(mfrow = c(1, 1))

# --- Distribuciones chi2 t F ------------------------------------------------
par(mfrow = c(1, 3))

x <- seq(0, 30, length = 300)
plot(x, dchisq(x, df = 5), type = "l", lwd = 2, col = "steelblue",
     main = "Chi-cuadrado", ylab = "Densidad")
lines(x, dchisq(x, df = 10), col = "darkred", lwd = 2)
legend("topright", c("df=5", "df=10"), col = c("steelblue", "darkred"), lwd = 2)

x <- seq(-4, 4, length = 300)
plot(x, dt(x, df = 3), type = "l", lwd = 2, col = "steelblue",
     main = "t de Student", ylab = "Densidad")
lines(x, dt(x, df = 30), col = "darkred", lwd = 2)
lines(x, dnorm(x), col = "gray50", lwd = 2, lty = 2)
legend("topright", c("df=3", "df=30", "Normal"),
       col = c("steelblue", "darkred", "gray50"), lwd = 2, lty = c(1, 1, 2))

x <- seq(0, 5, length = 300)
plot(x, df(x, df1 = 5, df2 = 20), type = "l", lwd = 2, col = "steelblue",
     main = "F de Fisher", ylab = "Densidad")
lines(x, df(x, df1 = 10, df2 = 50), col = "darkred", lwd = 2)
legend("topright", c("F(5,20)", "F(10,50)"), col = c("steelblue", "darkred"), lwd = 2)

par(mfrow = c(1, 1))

# --- Correlacion Pearson y Spearman ------------------------------------------
modulos <- saber_pro %>%
  select(MOD_INGLES_PUNT, MOD_RAZONA_CUANTITAT_PUNT,
         MOD_LECTURA_CRITICA_PUNT, MOD_COMPETEN_CIUDADA_PUNT) %>%
  drop_na()

cor_pearson  <- cor(modulos, method = "pearson")
cor_spearman <- cor(modulos, method = "spearman")

corrplot(cor_pearson, method = "color", type = "upper",
         addCoef.col = "black", tl.cex = 0.7,
         title = "Correlacion Pearson", mar = c(0, 0, 1, 0))

corrplot(cor_spearman, method = "color", type = "upper",
         addCoef.col = "black", tl.cex = 0.7,
         title = "Correlacion Spearman", mar = c(0, 0, 1, 0))

# --- Paradoja de Simpson -----------------------------------------------------
cor_global <- cor(saber_pro$MOD_INGLES_PUNT,
                  saber_pro$MOD_RAZONA_CUANTITAT_PUNT, use = "complete.obs")
cat("\nCorrelacion global ingles ~ razonamiento:", round(cor_global, 3), "\n")

cor_por_ies <- saber_pro %>%
  filter(!is.na(INST_ORIGEN)) %>%
  group_by(INST_ORIGEN) %>%
  summarise(
    r = cor(MOD_INGLES_PUNT, MOD_RAZONA_CUANTITAT_PUNT, use = "complete.obs"),
    n = n(), .groups = "drop"
  )
print(cor_por_ies)

ggplot(saber_pro %>% filter(!is.na(INST_ORIGEN)),
       aes(x = MOD_RAZONA_CUANTITAT_PUNT, y = MOD_INGLES_PUNT,
           color = INST_ORIGEN)) +
  geom_point(alpha = 0.03) +
  geom_smooth(method = "lm", se = FALSE, linewidth = 1.2) +
  geom_smooth(aes(color = NULL), method = "lm", color = "black",
              linetype = "dashed", se = FALSE) +
  labs(title = "Paradoja de Simpson: ingles vs razonamiento",
       subtitle = "Negra = global; color = por tipo de IES",
       x = "Razonamiento cuantitativo", y = "Ingles", color = "IES") +
  theme_minimal()

# --- Pipeline EDA ------------------------------------------------------------
saber_pro %>%
  select(starts_with("MOD_"), PUNT_GLOBAL) %>%
  pivot_longer(everything(), names_to = "modulo", values_to = "puntaje") %>%
  filter(!is.na(puntaje)) %>%
  group_by(modulo) %>%
  summarise(
    n     = n(),
    media = round(mean(puntaje), 1),
    sd    = round(sd(puntaje), 1),
    min   = min(puntaje),
    q1    = quantile(puntaje, 0.25),
    med   = median(puntaje),
    q3    = quantile(puntaje, 0.75),
    max   = max(puntaje),
    .groups = "drop"
  ) %>%
  print()
