# ============================================================================
# Sesion 6: Regresion lineal multiple
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 25 sep 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)
library(car)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))
cruce     <- read_parquet(paste0(gh_raw, "/cruce/cruce_saber11_saberpro.parquet"))

datos <- cruce %>%
  inner_join(saber11, by = c("estu_consecutivo_sb11" = "ESTU_CONSECUTIVO")) %>%
  inner_join(saber_pro, by = c("estu_consecutivo_sbpro" = "ESTU_CONSECUTIVO"),
             suffix = c("_sb11", "_sbpro")) %>%
  filter(!is.na(PUNT_INGLES), !is.na(PUNT_MATEMATICAS),
         !is.na(PUNT_LECTURA_CRITICA), !is.na(MOD_INGLES_PUNT))

muestra <- datos %>% slice_sample(n = 50000)

# --- OLS multiple ------------------------------------------------------------
modelo_mult <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES + PUNT_MATEMATICAS +
                    PUNT_LECTURA_CRITICA + PUNT_C_NATURALES +
                    PUNT_SOCIALES_CIUDADANAS,
                  data = muestra)
summary(modelo_mult)

cat("Interpretacion de coeficientes:\n")
for (v in names(coef(modelo_mult))[-1]) {
  cat(sprintf("  %s: b = %.4f\n", v, coef(modelo_mult)[v]))
}

# --- Sesgo variable omitida OVB ----------------------------------------------
modelo_simple <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES, data = muestra)

cat("\nSesgo por variable omitida (OVB):\n")
cat("Coef PUNT_INGLES (simple):", round(coef(modelo_simple)[2], 4), "\n")
cat("Coef PUNT_INGLES (multiple):", round(coef(modelo_mult)["PUNT_INGLES"], 4), "\n")
cat("Diferencia (OVB):",
    round(coef(modelo_simple)[2] - coef(modelo_mult)["PUNT_INGLES"], 4), "\n")

# --- VIF y multicolinealidad ------------------------------------------------
vif_vals <- vif(modelo_mult)
cat("\nFactor de Inflacion de la Varianza (VIF):\n")
print(round(vif_vals, 2))
cat("\nRegla: VIF > 5 indica multicolinealidad moderada, VIF > 10 severa\n")

# --- AIC BIC -----------------------------------------------------------------
m1 <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES, data = muestra)
m2 <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES + PUNT_MATEMATICAS, data = muestra)
m3 <- lm(MOD_INGLES_PUNT ~ PUNT_INGLES + PUNT_MATEMATICAS +
           PUNT_LECTURA_CRITICA, data = muestra)
m4 <- modelo_mult

comparacion <- tibble(
  modelo  = c("m1 (1 var)", "m2 (2 vars)", "m3 (3 vars)", "m4 (5 vars)"),
  R2      = c(summary(m1)$r.squared, summary(m2)$r.squared,
              summary(m3)$r.squared, summary(m4)$r.squared),
  R2_adj  = c(summary(m1)$adj.r.squared, summary(m2)$adj.r.squared,
              summary(m3)$adj.r.squared, summary(m4)$adj.r.squared),
  AIC_val = c(AIC(m1), AIC(m2), AIC(m3), AIC(m4)),
  BIC_val = c(BIC(m1), BIC(m2), BIC(m3), BIC(m4))
)
print(comparacion)

# --- Interaccion privada x estrato -------------------------------------------
saber_pro_int <- saber_pro %>%
  filter(!is.na(INST_ORIGEN), !is.na(FAMI_ESTRATOVIVIENDA),
         !is.na(MOD_INGLES_PUNT)) %>%
  mutate(privada = ifelse(INST_ORIGEN == "NO OFICIAL - PRIVADA", 1, 0),
         estrato_num = as.numeric(gsub("Estrato ", "", FAMI_ESTRATOVIVIENDA)))

modelo_int <- lm(MOD_INGLES_PUNT ~ privada * estrato_num, data = saber_pro_int)
summary(modelo_int)

cat("\nInteraccion privada x estrato:\n")
cat("El efecto de ser IES privada varia segun el estrato del estudiante\n")
cat("Coef interaccion:", round(coef(modelo_int)["privada:estrato_num"], 3), "\n")

ggplot(saber_pro_int,
       aes(x = estrato_num, y = MOD_INGLES_PUNT,
           color = factor(privada, labels = c("Publica", "Privada")))) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(title = "Interaccion: efecto de IES privada por estrato",
       x = "Estrato", y = "Puntaje ingles", color = "Tipo IES") +
  theme_minimal()
