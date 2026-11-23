# ============================================================================
# Sesion 12: Pruebas no parametricas y bondad de ajuste
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 13 nov 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

# --- Chi2 independencia ------------------------------------------------------
tabla_genero_mcer <- table(saber_pro$ESTU_GENERO, saber_pro$MOD_INGLES_DESEM)
cat("Tabla de contingencia: Genero x Nivel MCER\n")
print(tabla_genero_mcer)

chi2_indep <- chisq.test(tabla_genero_mcer)
cat("\nPrueba chi-cuadrado de independencia:\n")
print(chi2_indep)

# V de Cramer
k <- min(nrow(tabla_genero_mcer), ncol(tabla_genero_mcer))
v_cramer <- sqrt(chi2_indep$statistic / (sum(tabla_genero_mcer) * (k - 1)))
cat("V de Cramer:", round(v_cramer, 4), "\n")
cat("Interpretacion: < 0.1 debil, 0.1-0.3 moderada, > 0.3 fuerte\n")

# Proporciones por genero
prop.table(tabla_genero_mcer, margin = 1) %>%
  round(3) %>%
  print()

# --- Chi2 bondad de ajuste ---------------------------------------------------
freq_mcer <- table(saber_pro$MOD_INGLES_DESEM)
cat("\nFrecuencias observadas por nivel MCER:\n")
print(freq_mcer)

chi2_gof <- chisq.test(freq_mcer)
cat("\nPrueba chi-cuadrado de bondad de ajuste (H0: uniforme):\n")
print(chi2_gof)

cat("Frecuencias esperadas (uniforme):\n")
print(chi2_gof$expected)
cat("Residuos estandarizados:\n")
print(round(chi2_gof$residuals, 2))

barplot(rbind(chi2_gof$observed, chi2_gof$expected),
        beside = TRUE, col = c("steelblue", "coral"),
        legend = c("Observado", "Esperado"),
        main = "Bondad de ajuste: distribucion uniforme MCER")

# --- Mann-Whitney ------------------------------------------------------------
set.seed(2026)
pub_sample  <- saber_pro %>%
  filter(INST_ORIGEN == "OFICIAL", !is.na(MOD_INGLES_PUNT)) %>%
  slice_sample(n = 5000) %>%
  pull(MOD_INGLES_PUNT)

priv_sample <- saber_pro %>%
  filter(INST_ORIGEN == "NO OFICIAL - PRIVADA", !is.na(MOD_INGLES_PUNT)) %>%
  slice_sample(n = 5000) %>%
  pull(MOD_INGLES_PUNT)

mw_test <- wilcox.test(priv_sample, pub_sample, alternative = "two.sided")
cat("\nPrueba de Mann-Whitney (Wilcoxon rank-sum):\n")
cat("H0: las distribuciones son iguales\n")
print(mw_test)

cat("Mediana privada:", median(priv_sample), "\n")
cat("Mediana publica:", median(pub_sample), "\n")

# --- Kruskal-Wallis ----------------------------------------------------------
kw_data <- saber_pro %>%
  filter(!is.na(FAMI_ESTRATOVIVIENDA), !is.na(MOD_INGLES_PUNT)) %>%
  slice_sample(n = 30000)

kw_test <- kruskal.test(MOD_INGLES_PUNT ~ FAMI_ESTRATOVIVIENDA, data = kw_data)
cat("\nPrueba de Kruskal-Wallis (alternativa no parametrica a ANOVA):\n")
print(kw_test)

# Comparaciones post-hoc por pares
pairwise_test <- pairwise.wilcox.test(kw_data$MOD_INGLES_PUNT,
                                       kw_data$FAMI_ESTRATOVIVIENDA,
                                       p.adjust.method = "bonferroni")
cat("\nComparaciones post-hoc (Bonferroni):\n")
print(pairwise_test)

ggplot(kw_data, aes(x = FAMI_ESTRATOVIVIENDA, y = MOD_INGLES_PUNT,
                    fill = FAMI_ESTRATOVIVIENDA)) +
  geom_boxplot() +
  labs(title = "Kruskal-Wallis: puntaje ingles por estrato",
       x = "Estrato", y = "Puntaje ingles") +
  theme_minimal() +
  theme(legend.position = "none")

# --- Tablas de contingencia --------------------------------------------------
# Estrato x nivel MCER
tabla_est_mcer <- saber_pro %>%
  filter(!is.na(FAMI_ESTRATOVIVIENDA), !is.na(MOD_INGLES_DESEM)) %>%
  with(table(FAMI_ESTRATOVIVIENDA, MOD_INGLES_DESEM))

cat("\nTabla de contingencia: Estrato x MCER\n")
print(tabla_est_mcer)

cat("\nProporciones por fila (estrato):\n")
print(round(prop.table(tabla_est_mcer, margin = 1), 3))

chi2_est <- chisq.test(tabla_est_mcer)
cat("\nChi-cuadrado de independencia (Estrato x MCER):\n")
print(chi2_est)

v_est <- sqrt(chi2_est$statistic /
                (sum(tabla_est_mcer) *
                   (min(nrow(tabla_est_mcer), ncol(tabla_est_mcer)) - 1)))
cat("V de Cramer:", round(v_est, 4), "\n")

# Mosaicplot
mosaicplot(tabla_est_mcer, shade = TRUE,
           main = "Estrato x Nivel MCER", las = 2)
