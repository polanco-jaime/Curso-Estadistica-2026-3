# ============================================================================
# Sesion 2: Descriptiva grafica
# Estadistica 2026-II - Pontificia Universidad Javeriana
# Fecha: Vie 14 ago 2026
# ============================================================================

# --- Cargar paquetes y datos -------------------------------------------------
library(tidyverse)
library(arrow)

gh_raw <- "https://raw.githubusercontent.com/polanco-jaime/Curso-Estadistica-2026-3/main/datos"
saber_pro <- read_parquet(paste0(gh_raw, "/saber_pro/saber_pro.parquet"))
saber11   <- read_parquet(paste0(gh_raw, "/saber11/saber11.parquet"))

# --- Histograma y KDE -------------------------------------------------------
ggplot(saber_pro, aes(x = MOD_INGLES_PUNT)) +
  geom_histogram(aes(y = after_stat(density)), bins = 40,
                 fill = "steelblue", color = "white", alpha = 0.7) +
  geom_density(color = "darkred", linewidth = 1) +
  geom_vline(aes(xintercept = mean(MOD_INGLES_PUNT, na.rm = TRUE)),
             linetype = "dashed", color = "black") +
  labs(title = "Distribucion del puntaje de ingles (Saber Pro)",
       x = "Puntaje", y = "Densidad") +
  theme_minimal()

ggplot(saber_pro %>% filter(!is.na(INST_ORIGEN)),
       aes(x = MOD_INGLES_PUNT, fill = INST_ORIGEN)) +
  geom_histogram(aes(y = after_stat(density)), bins = 40,
                 alpha = 0.5, position = "identity") +
  labs(title = "Puntaje de ingles por tipo de IES",
       x = "Puntaje", y = "Densidad", fill = "Tipo IES") +
  theme_minimal()

# --- Box plot ----------------------------------------------------------------
ggplot(saber_pro %>% filter(!is.na(FAMI_ESTRATOVIVIENDA)),
       aes(x = FAMI_ESTRATOVIVIENDA, y = MOD_INGLES_PUNT,
           fill = FAMI_ESTRATOVIVIENDA)) +
  geom_boxplot(outlier.alpha = 0.3) +
  labs(title = "Puntaje de ingles por estrato socioeconomico",
       x = "Estrato", y = "Puntaje") +
  theme_minimal() +
  theme(legend.position = "none")

ggplot(saber_pro %>% filter(!is.na(ESTU_GENERO)),
       aes(x = ESTU_GENERO, y = MOD_INGLES_PUNT, fill = ESTU_GENERO)) +
  geom_boxplot(outlier.alpha = 0.3) +
  labs(title = "Puntaje de ingles por genero",
       x = "Genero", y = "Puntaje") +
  theme_minimal() +
  theme(legend.position = "none")

# --- Scatter plot ------------------------------------------------------------
ggplot(saber_pro, aes(x = MOD_LECTURA_CRITICA_PUNT, y = MOD_INGLES_PUNT)) +
  geom_point(alpha = 0.05, color = "steelblue") +
  geom_smooth(method = "lm", color = "darkred", se = TRUE) +
  labs(title = "Ingles vs. Lectura critica (Saber Pro)",
       x = "Lectura critica", y = "Ingles") +
  theme_minimal()

# Bar plot de medias por departamento
medias_depto <- saber_pro %>%
  filter(!is.na(ESTU_DEPTO_RESIDE)) %>%
  group_by(ESTU_DEPTO_RESIDE) %>%
  summarise(media = mean(MOD_INGLES_PUNT, na.rm = TRUE), n = n(),
            .groups = "drop") %>%
  filter(n >= 50) %>%
  arrange(desc(media))

ggplot(medias_depto, aes(x = reorder(ESTU_DEPTO_RESIDE, media), y = media)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Puntaje promedio de ingles por departamento",
       x = NULL, y = "Media puntaje ingles") +
  theme_minimal()

# --- Heatmap departamental ---------------------------------------------------
heatmap_data <- saber_pro %>%
  filter(!is.na(ESTU_DEPTO_RESIDE), !is.na(MOD_INGLES_DESEM)) %>%
  count(ESTU_DEPTO_RESIDE, MOD_INGLES_DESEM) %>%
  group_by(ESTU_DEPTO_RESIDE) %>%
  mutate(prop = n / sum(n)) %>%
  ungroup()

ggplot(heatmap_data, aes(x = MOD_INGLES_DESEM, y = ESTU_DEPTO_RESIDE,
                         fill = prop)) +
  geom_tile() +
  scale_fill_viridis_c(labels = scales::percent) +
  labs(title = "Proporcion de nivel MCER por departamento",
       x = "Nivel MCER", y = NULL, fill = "Proporcion") +
  theme_minimal()

# --- Violin plot -------------------------------------------------------------
ggplot(saber_pro %>% filter(!is.na(INST_ORIGEN)),
       aes(x = INST_ORIGEN, y = MOD_INGLES_PUNT, fill = INST_ORIGEN)) +
  geom_violin(alpha = 0.5) +
  geom_boxplot(width = 0.15, fill = "white") +
  labs(title = "Distribucion de puntaje: publica vs privada",
       x = "Tipo de IES", y = "Puntaje") +
  theme_minimal() +
  theme(legend.position = "none")
