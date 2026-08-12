# ============================================================================
# Sesion 11: Pruebas parametricas
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 6 nov 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))
cruce     <- read_parquet(paste0(gh_raw, "/cruce/cruce_saber11_saberpro.parquet"))

# --- Prueba t 1 muestra -----------------------------------------------------
ingles <- saber_pro$MOD_INGLES_PUNT[!is.na(saber_pro$MOD_INGLES_PUNT)]
set.seed(2026)
muestra <- sample(ingles, 300)

test_1m <- t.test(muestra, mu = 160, alternative = "two.sided")
cat("Prueba t una muestra: H0: mu = 160\n")
print(test_1m)

# --- Prueba t 2 muestras ----------------------------------------------------
publica <- saber_pro %>%
  filter(INST_ORIGEN == "OFICIAL", !is.na(MOD_INGLES_PUNT)) %>%
  pull(MOD_INGLES_PUNT)
privada <- saber_pro %>%
  filter(INST_ORIGEN == "NO OFICIAL - PRIVADA", !is.na(MOD_INGLES_PUNT)) %>%
  pull(MOD_INGLES_PUNT)

test_2m <- t.test(privada, publica, alternative = "two.sided", var.equal = FALSE)
cat("\nPrueba t dos muestras (Welch): privada vs publica\n")
print(test_2m)

cat("Media privada:", round(mean(privada), 2), "\n")
cat("Media publica:", round(mean(publica), 2), "\n")
cat("Diferencia:", round(mean(privada) - mean(publica), 2), "\n")

# --- Prueba t pareada --------------------------------------------------------
datos_pareados <- cruce %>%
  inner_join(saber11, by = c("estu_consecutivo_sb11" = "ESTU_CONSECUTIVO")) %>%
  inner_join(saber_pro, by = c("estu_consecutivo_sbpro" = "ESTU_CONSECUTIVO"),
             suffix = c("_sb11", "_sbpro")) %>%
  filter(!is.na(PUNT_INGLES), !is.na(MOD_INGLES_PUNT)) %>%
  slice_sample(n = 500)

# Estandarizar ambos puntajes a z-scores para comparar
datos_pareados <- datos_pareados %>%
  mutate(z_sb11  = scale(PUNT_INGLES)[, 1],
         z_sbpro = scale(MOD_INGLES_PUNT)[, 1],
         diff_z  = z_sbpro - z_sb11)

test_pareada <- t.test(datos_pareados$z_sbpro, datos_pareados$z_sb11,
                       paired = TRUE)
cat("\nPrueba t pareada (z-scores: Saber Pro - Saber 11):\n")
print(test_pareada)

ggplot(datos_pareados, aes(x = diff_z)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Diferencia de z-scores (Saber Pro - Saber 11)",
       x = "Diferencia z", y = "Frecuencia") +
  theme_minimal()

# --- ANOVA y Tukey -----------------------------------------------------------
anova_data <- saber_pro %>%
  filter(!is.na(FAMI_ESTRATOVIVIENDA), !is.na(MOD_INGLES_PUNT))

modelo_aov <- aov(MOD_INGLES_PUNT ~ FAMI_ESTRATOVIVIENDA, data = anova_data)
cat("\nANOVA: puntaje ingles por estrato\n")
summary(modelo_aov)

# Eta-cuadrado
ss <- summary(modelo_aov)[[1]]
eta2 <- ss["Sum Sq"][1, 1] / sum(ss["Sum Sq"])
cat("Eta-cuadrado:", round(eta2, 4), "\n")

# Tukey HSD
tukey <- TukeyHSD(modelo_aov)
cat("\nComparaciones Tukey HSD:\n")
print(tukey)

plot(tukey, las = 1, cex.axis = 0.6)

# Medias por estrato
anova_data %>%
  group_by(FAMI_ESTRATOVIVIENDA) %>%
  summarise(n = n(), media = round(mean(MOD_INGLES_PUNT), 2),
            sd = round(sd(MOD_INGLES_PUNT), 2), .groups = "drop") %>%
  arrange(FAMI_ESTRATOVIVIENDA) %>%
  print()

# --- Prueba de Chow ----------------------------------------------------------
datos_chow <- cruce %>%
  inner_join(saber11, by = c("estu_consecutivo_sb11" = "ESTU_CONSECUTIVO")) %>%
  inner_join(saber_pro, by = c("estu_consecutivo_sbpro" = "ESTU_CONSECUTIVO"),
             suffix = c("_sb11", "_sbpro")) %>%
  filter(!is.na(PUNT_INGLES), !is.na(MOD_INGLES_PUNT), !is.na(INST_ORIGEN)) %>%
  slice_sample(n = 20000)

# Modelo conjunto
m_conjunto <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES, data = datos_chow)
rss_c <- sum(resid(m_conjunto)^2)

# Modelos separados
m_pub <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES,
            data = filter(datos_chow, INST_ORIGEN == "OFICIAL"))
m_priv <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES,
             data = filter(datos_chow, INST_ORIGEN == "NO OFICIAL - PRIVADA"))
rss_s <- sum(resid(m_pub)^2) + sum(resid(m_priv)^2)

k <- length(coef(m_conjunto))
n_total <- nrow(datos_chow)
F_chow <- ((rss_c - rss_s) / k) / (rss_s / (n_total - 2 * k))
p_chow <- pf(F_chow, k, n_total - 2 * k, lower.tail = FALSE)

cat("\nPrueba de Chow (estabilidad por tipo IES):\n")
cat("F =", round(F_chow, 3), "\n")
cat("p-valor =", format(p_chow, digits = 4), "\n")
if (p_chow < 0.05) {
  cat("-> Los coeficientes difieren entre IES publicas y privadas\n")
}
