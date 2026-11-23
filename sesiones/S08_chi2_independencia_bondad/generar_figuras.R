# ============================================================================
# Genera las figuras PDF para los slides de S08-S09
# Ejecutar desde el directorio de la sesion:
#   Rscript generar_figuras.R
# ============================================================================

library(arrow)
library(dplyr)
library(ggplot2)
library(lmtest)

out <- "figuras"
dir.create(out, showWarnings = FALSE)

gh <- paste0(
  "https://raw.githubusercontent.com/",
  "polanco-jaime/Curso-Estadistica-2026-3/",
  "main/datos"
)

saber_pro <- read_parquet(paste0(gh, "/saber_pro/saber_pro.parquet"))
saber_pro$TIPO_IES <- ifelse(
  grepl("NO OFICIAL", saber_pro$INST_ORIGEN),
  "Privada", "Publica"
)

# --- Chi-cuadrado -----------------------------------------------------------

tabla_obs <- table(saber_pro$MOD_INGLES_DESEM, saber_pro$TIPO_IES)

pdf(file.path(out, "mosaico.pdf"), width = 7, height = 4.5)
mosaicplot(tabla_obs,
           color = c("steelblue", "coral"),
           main = "Nivel MCER vs Tipo de IES",
           xlab = "Nivel MCER", ylab = "Tipo de IES")
dev.off()

niveles <- table(saber_pro$MOD_INGLES_DESEM)
pdf(file.path(out, "barplot_mcer.pdf"), width = 7, height = 4)
barplot(niveles, col = "steelblue",
        main = "Distribucion de niveles MCER",
        xlab = "Nivel", ylab = "Frecuencia")
abline(h = sum(niveles) / 5, col = "red", lty = 2, lwd = 2)
legend("topright", "Esperado (uniforme)", col = "red", lty = 2)
dev.off()

# --- Cruzar datos -----------------------------------------------------------

s11 <- read_parquet(paste0(gh, "/saber11/saber11.parquet"))
cr  <- read_parquet(paste0(gh, "/cruce/cruce_saber11_saberpro.parquet"))

saber_pro <- saber_pro |>
  inner_join(cr, by = c("ESTU_CONSECUTIVO" = "estu_consecutivo_sbpro")) |>
  inner_join(
    s11 |> select(ESTU_CONSECUTIVO, PUNT_INGLES, PUNT_MATEMATICAS),
    by = c("estu_consecutivo_sb11" = "ESTU_CONSECUTIVO")
  )

set.seed(42)
idx <- sample(nrow(saber_pro), 10000)
sp_muestra <- saber_pro[idx, ]

# --- Modelo 1: scatter ------------------------------------------------------

p1 <- ggplot(sp_muestra, aes(x = PUNT_MATEMATICAS, y = MOD_INGLES_PUNT)) +
  geom_point(alpha = 0.15, color = "steelblue", size = 0.8) +
  geom_smooth(method = "lm", se = TRUE, color = "red",
              fill = "pink", alpha = 0.3) +
  labs(title = "Matematicas Saber 11 vs Ingles Saber Pro",
       x = "Puntaje Matematicas Saber 11",
       y = "Puntaje Ingles Saber Pro") +
  theme_minimal(base_size = 14)
ggsave(file.path(out, "scatter_modelo1.pdf"), p1, width = 7, height = 4.5)

# --- Modelo 1: residuos -----------------------------------------------------

m1s <- lm(MOD_INGLES_PUNT ~ PUNT_MATEMATICAS, data = sp_muestra)

pdf(file.path(out, "residuos_modelo1.pdf"), width = 7, height = 4.5)
plot(fitted(m1s), residuals(m1s),
     xlab = "Valores ajustados", ylab = "Residuos",
     main = "Residuos vs Valores Ajustados (modelo1)",
     pch = 20, col = rgb(0.26, 0.43, 0.71, 0.3))
abline(h = 0, col = "red", lwd = 2, lty = 2)
dev.off()

# --- Modelo 1: diagnostico 4 paneles ----------------------------------------

idx_diag <- sample(nrow(saber_pro), 5000)
m1d <- lm(MOD_INGLES_PUNT ~ PUNT_MATEMATICAS, data = saber_pro[idx_diag, ])

pdf(file.path(out, "diagnostico_modelo1.pdf"), width = 8, height = 7)
par(mfrow = c(2, 2))
plot(m1d)
par(mfrow = c(1, 1))
dev.off()

# --- Dummy: boxplot ----------------------------------------------------------

saber_pro$PRIVADA <- ifelse(saber_pro$TIPO_IES == "Privada", 1, 0)
md <- lm(MOD_INGLES_PUNT ~ PRIVADA, data = saber_pro)

p_box <- ggplot(saber_pro, aes(x = TIPO_IES, y = MOD_INGLES_PUNT, fill = TIPO_IES)) +
  geom_boxplot(alpha = 0.7) +
  geom_hline(yintercept = coef(md)[1],
             linetype = "dashed", color = "blue", linewidth = 1) +
  geom_hline(yintercept = coef(md)[1] + coef(md)[2],
             linetype = "dashed", color = "red", linewidth = 1) +
  labs(title = "Puntaje de ingles por tipo de IES",
       subtitle = paste0("b0 = ", round(coef(md)[1], 1),
                         " (publica), b1 = ", round(coef(md)[2], 1),
                         " (diferencia privada)"),
       x = "Tipo de IES", y = "Puntaje Ingles Saber Pro") +
  scale_fill_manual(values = c("steelblue", "coral")) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "none")
ggsave(file.path(out, "boxplot_dummy.pdf"), p_box, width = 7, height = 4.5)

# --- Modelo 2: scatter ------------------------------------------------------

m2 <- lm(MOD_RAZONA_CUANTITAT_PUNT ~ PUNT_INGLES, data = saber_pro)

p2 <- ggplot(sp_muestra, aes(x = PUNT_INGLES, y = MOD_RAZONA_CUANTITAT_PUNT)) +
  geom_point(alpha = 0.15, color = "steelblue", size = 0.8) +
  geom_smooth(method = "lm", se = TRUE, color = "red",
              fill = "pink", alpha = 0.3) +
  labs(title = "Ingles (Saber 11) vs Razonamiento Cuantitativo (Saber Pro)",
       subtitle = paste("R2 =", round(summary(m2)$r.squared, 3), ", p < 0.001"),
       x = "Puntaje Ingles Saber 11",
       y = "Puntaje Razonamiento Cuantitativo Saber Pro") +
  theme_minimal(base_size = 14) +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5))
ggsave(file.path(out, "scatter_modelo2.pdf"), p2, width = 7, height = 4.5)

# --- Modelo 2: diagnostico 4 paneles ----------------------------------------

m2d <- lm(MOD_RAZONA_CUANTITAT_PUNT ~ PUNT_INGLES, data = saber_pro[idx_diag, ])

pdf(file.path(out, "diagnostico_modelo2.pdf"), width = 8, height = 7)
par(mfrow = c(2, 2))
plot(m2d)
par(mfrow = c(1, 1))
dev.off()

cat("Figuras generadas en:", normalizePath(out), "\n")
