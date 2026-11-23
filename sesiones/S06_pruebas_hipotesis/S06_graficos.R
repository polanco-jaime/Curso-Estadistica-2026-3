library(ggplot2)

datos <- data.frame(
  puntaje = c(158, 172, 145, 163, 170, 155, 168, 149, 161, 175),
  estudiante = paste("E", 1:10, sep = "")
)

xbar <- mean(datos$puntaje)
mu_0 <- 155

# --- 1. Dotplot / strip chart (ya existente) ---
p1 <- ggplot(datos, aes(x = puntaje, y = 0)) +
  geom_point(size = 4, color = "#2166AC", alpha = 0.85) +
  geom_vline(xintercept = xbar, linewidth = 1, linetype = "dashed", color = "#D6604D") +
  geom_vline(xintercept = mu_0, linewidth = 1, linetype = "dotted", color = "#F4A582") +
  annotate("text", x = xbar + 1.2, y = 0.25, label = paste0("bar(x) == ", xbar),
           parse = TRUE, color = "#D6604D", size = 5, hjust = 0) +
  annotate("text", x = mu_0 - 1.2, y = 0.25, label = paste0("mu[0] == ", mu_0),
           parse = TRUE, color = "#F4A582", size = 5, hjust = 1) +
  annotate("segment", x = mu_0, xend = xbar, y = -0.15, yend = -0.15,
           arrow = arrow(ends = "both", length = unit(0.15, "cm")),
           color = "grey40", linewidth = 0.6) +
  annotate("text", x = (mu_0 + xbar) / 2, y = -0.22,
           label = paste0("Diferencia = ", round(xbar - mu_0, 1), " puntos"),
           color = "grey30", size = 3.8) +
  scale_x_continuous(breaks = seq(140, 180, 5), limits = c(140, 180)) +
  scale_y_continuous(limits = c(-0.35, 0.4)) +
  labs(x = "Puntaje de Inglés (Saber Pro)", y = NULL) +
  theme_minimal(base_size = 14) +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.minor.x = element_blank(),
    plot.margin = margin(10, 15, 10, 10)
  )

ggsave("S06_dotplot_repaso.pdf", p1, width = 8, height = 2.5)
cat("1/8 Guardado: S06_dotplot_repaso.pdf\n")


# --- 2. Distribución muestral (Paso 4) ---
se <- 3.15
x_vals <- seq(mu_0 - 4 * se, mu_0 + 4 * se, length.out = 300)
y_vals <- dt((x_vals - mu_0) / se, df = 9) / se

df_dist <- data.frame(x = x_vals, y = y_vals)

p2 <- ggplot(df_dist, aes(x, y)) +
  geom_line(linewidth = 1, color = "#2166AC") +
  geom_area(alpha = 0.15, fill = "#2166AC") +
  geom_vline(xintercept = mu_0, linetype = "solid", color = "grey50", linewidth = 0.5) +
  annotate("segment", x = mu_0, xend = mu_0 + se, y = max(y_vals) * 0.6, yend = max(y_vals) * 0.6,
           arrow = arrow(ends = "both", length = unit(0.12, "cm")),
           color = "#E67E22", linewidth = 0.8) +
  annotate("text", x = mu_0 + se / 2, y = max(y_vals) * 0.65, label = "SE",
           color = "#E67E22", size = 4.5, fontface = "bold") +
  annotate("segment", x = xbar, xend = xbar, y = 0, yend = max(y_vals) * 0.95,
           arrow = arrow(length = unit(0.2, "cm")), color = "#D6604D", linewidth = 1) +
  annotate("text", x = xbar + 0.5, y = max(y_vals) * 0.98,
           label = paste0("bar(x) == ", xbar), parse = TRUE,
           color = "#D6604D", size = 5, hjust = 0) +
  annotate("text", x = mu_0, y = max(y_vals) * 1.1,
           label = paste0("Distribucion~de~bar(x)~si~mu == ", mu_0),
           parse = TRUE, size = 4.5, color = "grey30") +
  scale_x_continuous(
    breaks = c(mu_0 - 2 * se, mu_0 - se, mu_0, mu_0 + se, mu_0 + 2 * se),
    labels = round(c(mu_0 - 2 * se, mu_0 - se, mu_0, mu_0 + se, mu_0 + 2 * se), 1)
  ) +
  labs(x = expression(bar(x)), y = NULL) +
  theme_minimal(base_size = 13) +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    plot.margin = margin(15, 15, 10, 10)
  )

ggsave("S06_dist_muestral.pdf", p2, width = 8, height = 3.5)
cat("2/8 Guardado: S06_dist_muestral.pdf\n")


# --- 3. IC visualization (Paso 5) ---
ic_lower <- 154.47
ic_upper <- 168.73

p3 <- ggplot() +
  annotate("segment", x = ic_lower, xend = ic_upper, y = 0.5, yend = 0.5,
           linewidth = 2, color = "#2166AC") +
  annotate("segment", x = ic_lower, xend = ic_lower, y = 0.35, yend = 0.65,
           linewidth = 1.2, color = "#2166AC") +
  annotate("segment", x = ic_upper, xend = ic_upper, y = 0.35, yend = 0.65,
           linewidth = 1.2, color = "#2166AC") +
  annotate("point", x = xbar, y = 0.5, size = 4, color = "#2166AC") +
  annotate("text", x = xbar, y = 0.72,
           label = paste0("bar(x) == ", xbar), parse = TRUE,
           color = "#2166AC", size = 5) +
  annotate("text", x = ic_lower, y = 0.22,
           label = "154.5", color = "#2166AC", size = 4) +
  annotate("text", x = ic_upper, y = 0.22,
           label = "168.7", color = "#2166AC", size = 4) +
  geom_vline(xintercept = mu_0, linetype = "dashed", linewidth = 1, color = "#D6604D") +
  annotate("text", x = mu_0, y = 0.95,
           label = paste0("mu[0] == ", mu_0), parse = TRUE,
           color = "#D6604D", size = 5) +
  scale_x_continuous(breaks = seq(150, 170, 5), limits = c(148, 175)) +
  scale_y_continuous(limits = c(0, 1.1)) +
  labs(x = "Puntaje", y = NULL) +
  theme_minimal(base_size = 13) +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    plot.margin = margin(10, 15, 10, 10)
  )

ggsave("S06_ic_repaso.pdf", p3, width = 8, height = 2.5)
cat("3/8 Guardado: S06_ic_repaso.pdf\n")


# --- 4. Flow diagram "Para qué sirven" ---
p4 <- ggplot() +
  annotate("rect", xmin = 0, xmax = 3, ymin = 0, ymax = 1.2,
           fill = "#D4E6F1", color = "#2166AC", linewidth = 0.8) +
  annotate("text", x = 1.5, y = 0.8, label = "Observamos",
           size = 5, fontface = "bold", color = "#2166AC") +
  annotate("text", x = 1.5, y = 0.4,
           label = paste0("bar(x) == ", xbar), parse = TRUE,
           size = 4.5, color = "#2166AC") +
  annotate("rect", xmin = 4.5, xmax = 7.5, ymin = 0, ymax = 1.2,
           fill = "#FDEBD0", color = "#E67E22", linewidth = 0.8) +
  annotate("text", x = 6, y = 0.8, label = "¿Es real o",
           size = 5, fontface = "bold", color = "#E67E22") +
  annotate("text", x = 6, y = 0.4, label = "es ruido?",
           size = 5, fontface = "bold", color = "#E67E22") +
  annotate("rect", xmin = 9, xmax = 12, ymin = 0, ymax = 1.2,
           fill = "#D5F5E3", color = "#27AE60", linewidth = 0.8) +
  annotate("text", x = 10.5, y = 0.8, label = "Decisión",
           size = 5, fontface = "bold", color = "#27AE60") +
  annotate("text", x = 10.5, y = 0.4, label = "formal",
           size = 5, fontface = "bold", color = "#27AE60") +
  annotate("segment", x = 3.1, xend = 4.4, y = 0.6, yend = 0.6,
           arrow = arrow(length = unit(0.25, "cm")),
           linewidth = 1.2, color = "grey40") +
  annotate("text", x = 3.75, y = 0.2, label = "Prueba de hip.",
           size = 3.8, color = "grey40") +
  annotate("segment", x = 7.6, xend = 8.9, y = 0.6, yend = 0.6,
           arrow = arrow(length = unit(0.25, "cm")),
           linewidth = 1.2, color = "grey40") +
  annotate("text", x = 8.25, y = 0.2,
           label = "list('p-valor', alpha)", parse = TRUE,
           size = 3.8, color = "grey40") +
  scale_x_continuous(limits = c(-0.5, 12.5)) +
  scale_y_continuous(limits = c(-0.3, 1.5)) +
  theme_void() +
  theme(plot.margin = margin(10, 10, 10, 10))

ggsave("S06_flujo_hipotesis.pdf", p4, width = 9, height = 2.2)
cat("4/8 Guardado: S06_flujo_hipotesis.pdf\n")


# --- 5. Trade-off alpha vs beta ---
alpha_vals <- seq(0.001, 0.20, length.out = 200)
beta_vals <- 0.5 * exp(-8 * alpha_vals) + 0.05

df_tradeoff <- data.frame(alpha = alpha_vals, beta = beta_vals)

p5 <- ggplot(df_tradeoff, aes(alpha, beta)) +
  geom_line(linewidth = 1.2, color = "#2166AC") +
  geom_vline(xintercept = 0.05, linetype = "dashed", color = "#D6604D", linewidth = 0.8) +
  annotate("text", x = 0.055, y = max(beta_vals) * 0.95,
           label = paste0("alpha == 0.05"), parse = TRUE,
           color = "#D6604D", size = 4.5, hjust = 0) +
  annotate("segment", x = 0.05, xend = 0.05, y = 0, yend = df_tradeoff$beta[which.min(abs(alpha_vals - 0.05))],
           linetype = "dashed", color = "#D6604D", linewidth = 0.5) +
  annotate("segment", x = 0, xend = 0.05, y = df_tradeoff$beta[which.min(abs(alpha_vals - 0.05))],
           yend = df_tradeoff$beta[which.min(abs(alpha_vals - 0.05))],
           linetype = "dashed", color = "#D6604D", linewidth = 0.5) +
  annotate("text", x = 0.12, y = 0.3,
           label = "alpha~baja %=>% beta~sube",
           parse = TRUE, size = 4.5, color = "grey30") +
  scale_x_continuous(breaks = seq(0, 0.20, 0.05),
                     labels = c("0", "0.05", "0.10", "0.15", "0.20")) +
  labs(x = expression(alpha), y = expression(beta)) +
  theme_minimal(base_size = 13) +
  theme(
    panel.grid.minor = element_blank(),
    plot.margin = margin(10, 15, 10, 10)
  )

ggsave("S06_tradeoff_alpha_beta.pdf", p5, width = 7, height = 4)
cat("5/8 Guardado: S06_tradeoff_alpha_beta.pdf\n")


# --- 6. p-valor visualización (dos colas) ---
x_t <- seq(-4, 4, length.out = 400)
y_t <- dt(x_t, df = 9)
df_t <- data.frame(x = x_t, y = y_t)

t_crit <- qt(0.975, df = 9)
t_obs <- 2.5

p6 <- ggplot(df_t, aes(x, y)) +
  geom_line(linewidth = 0.8, color = "grey30") +
  geom_area(data = df_t[df_t$x <= -t_crit, ], fill = "#E74C3C", alpha = 0.5) +
  geom_area(data = df_t[df_t$x >= t_crit, ], fill = "#E74C3C", alpha = 0.5) +
  geom_vline(xintercept = c(-t_crit, t_crit), linetype = "dashed", color = "grey50") +
  annotate("segment", x = t_obs, xend = t_obs, y = 0, yend = dt(t_obs, 9) + 0.06,
           arrow = arrow(length = unit(0.2, "cm")), color = "#2166AC", linewidth = 1.2) +
  annotate("text", x = t_obs + 0.15, y = dt(t_obs, 9) + 0.08,
           label = expression(t[obs]), color = "#2166AC", size = 5, hjust = 0) +
  annotate("text", x = -t_crit, y = -0.02,
           label = expression(-t[alpha / 2]), color = "grey40", size = 4, vjust = 1) +
  annotate("text", x = t_crit, y = -0.02,
           label = expression(t[alpha / 2]), color = "grey40", size = 4, vjust = 1) +
  annotate("text", x = -3.2, y = 0.06,
           label = expression(alpha / 2), color = "#E74C3C", size = 4.5) +
  annotate("text", x = 3.2, y = 0.06,
           label = expression(alpha / 2), color = "#E74C3C", size = 4.5) +
  annotate("text", x = 0, y = max(y_t) * 0.6,
           label = "No rechazar", color = "grey40", size = 4.5) +
  scale_x_continuous(breaks = -4:4) +
  labs(x = "t", y = NULL) +
  theme_minimal(base_size = 13) +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    plot.margin = margin(10, 15, 10, 10)
  )

ggsave("S06_pvalor_dos_colas.pdf", p6, width = 8, height = 3.5)
cat("6/8 Guardado: S06_pvalor_dos_colas.pdf\n")


# --- 7. IC-test conexión (IC con mu_0 dentro) ---
p7 <- ggplot() +
  annotate("segment", x = ic_lower, xend = ic_upper, y = 0.5, yend = 0.5,
           linewidth = 2, color = "#2166AC") +
  annotate("segment", x = ic_lower, xend = ic_lower, y = 0.35, yend = 0.65,
           linewidth = 1.2, color = "#2166AC") +
  annotate("segment", x = ic_upper, xend = ic_upper, y = 0.35, yend = 0.65,
           linewidth = 1.2, color = "#2166AC") +
  annotate("point", x = xbar, y = 0.5, size = 4, color = "#2166AC") +
  annotate("text", x = xbar, y = 0.72,
           label = paste0("bar(x) == ", xbar), parse = TRUE,
           color = "#2166AC", size = 5) +
  annotate("text", x = ic_lower, y = 0.22, label = "154.5", color = "#2166AC", size = 4) +
  annotate("text", x = ic_upper, y = 0.22, label = "168.7", color = "#2166AC", size = 4) +
  geom_vline(xintercept = mu_0, linetype = "dashed", linewidth = 1, color = "#D6604D") +
  annotate("text", x = mu_0, y = 0.95,
           label = paste0("mu[0] == ", mu_0), parse = TRUE,
           color = "#D6604D", size = 5) +
  annotate("label", x = (ic_lower + ic_upper) / 2, y = 1.15,
           label = "✓ 155 está DENTRO del IC",
           color = "#27AE60", size = 4.5, fill = "#EAFAF1",
           label.size = 0, fontface = "bold") +
  scale_x_continuous(breaks = seq(150, 170, 5), limits = c(148, 175)) +
  scale_y_continuous(limits = c(0, 1.3)) +
  labs(x = "Puntaje", y = NULL) +
  theme_minimal(base_size = 13) +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    plot.margin = margin(10, 15, 10, 10)
  )

ggsave("S06_ic_conexion.pdf", p7, width = 8, height = 2.5)
cat("7/8 Guardado: S06_ic_conexion.pdf\n")


# --- 8. Curva de potencia ---
mu_true <- seq(145, 175, length.out = 300)
n_test <- 10
se_test <- 9.96 / sqrt(n_test)
t_crit_pot <- qt(0.975, df = n_test - 1)

potencia <- sapply(mu_true, function(mu_alt) {
  ncp <- (mu_alt - mu_0) / se_test
  1 - pt(t_crit_pot, df = n_test - 1, ncp = ncp) +
    pt(-t_crit_pot, df = n_test - 1, ncp = ncp)
})

df_pot <- data.frame(mu = mu_true, power = potencia)

p8 <- ggplot(df_pot, aes(mu, power)) +
  geom_line(linewidth = 1.2, color = "#2166AC") +
  geom_hline(yintercept = 0.80, linetype = "dashed", color = "#E67E22", linewidth = 0.7) +
  geom_vline(xintercept = mu_0, linetype = "dashed", color = "#D6604D", linewidth = 0.7) +
  annotate("text", x = mu_0 - 0.5, y = 0.95,
           label = paste0("mu[0] == ", mu_0), parse = TRUE,
           color = "#D6604D", size = 4, hjust = 1) +
  annotate("text", x = 173, y = 0.83, label = "Potencia = 0.80",
           color = "#E67E22", size = 4) +
  annotate("text", x = 170, y = 0.55, label = "Mayor efecto\n→ más potencia",
           color = "grey40", size = 4) +
  annotate("text", x = 147, y = 0.3, label = "Menor efecto\n→ menos potencia",
           color = "grey40", size = 4) +
  scale_x_continuous(breaks = seq(145, 175, 5)) +
  scale_y_continuous(breaks = seq(0, 1, 0.2), labels = scales::percent_format(1)) +
  labs(x = expression(mu ~ "verdadero"), y = "Potencia") +
  theme_minimal(base_size = 13) +
  theme(
    panel.grid.minor = element_blank(),
    plot.margin = margin(10, 15, 10, 10)
  )

ggsave("S06_curva_potencia.pdf", p8, width = 8, height = 4)
cat("8/8 Guardado: S06_curva_potencia.pdf\n")


# --- 9. Equivalencia IC-test: dos ICs comparison ---
p9 <- ggplot() +
  annotate("segment", x = 152, xend = 168, y = 2, yend = 2,
           linewidth = 2, color = "#2166AC") +
  annotate("segment", x = 152, xend = 152, y = 1.8, yend = 2.2,
           linewidth = 1.2, color = "#2166AC") +
  annotate("segment", x = 168, xend = 168, y = 1.8, yend = 2.2,
           linewidth = 1.2, color = "#2166AC") +
  annotate("point", x = 160, y = 2, size = 4, color = "#2166AC") +
  annotate("text", x = 145, y = 2, label = expression(IC[1]),
           color = "#2166AC", size = 5) +
  annotate("text", x = 172, y = 2,
           label = expression(mu[0] ~ "dentro → No rechaza"),
           color = "#27AE60", size = 4, hjust = 0) +
  annotate("segment", x = 158, xend = 170, y = 0.8, yend = 0.8,
           linewidth = 2, color = "#2166AC") +
  annotate("segment", x = 158, xend = 158, y = 0.6, yend = 1.0,
           linewidth = 1.2, color = "#2166AC") +
  annotate("segment", x = 170, xend = 170, y = 0.6, yend = 1.0,
           linewidth = 1.2, color = "#2166AC") +
  annotate("point", x = 164, y = 0.8, size = 4, color = "#2166AC") +
  annotate("text", x = 145, y = 0.8, label = expression(IC[2]),
           color = "#2166AC", size = 5) +
  annotate("text", x = 172, y = 0.8,
           label = expression(mu[0] ~ "fuera → Rechaza"),
           color = "#E74C3C", size = 4, hjust = 0) +
  geom_vline(xintercept = mu_0, linetype = "dashed", linewidth = 1, color = "#D6604D") +
  annotate("text", x = mu_0, y = 2.8,
           label = paste0("mu[0] == ", mu_0), parse = TRUE,
           color = "#D6604D", size = 5) +
  scale_x_continuous(limits = c(143, 190), breaks = seq(145, 175, 5)) +
  scale_y_continuous(limits = c(0, 3)) +
  labs(x = "Puntaje", y = NULL) +
  theme_minimal(base_size = 13) +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    plot.margin = margin(10, 15, 10, 10)
  )

ggsave("S06_ic_equivalencia.pdf", p9, width = 9, height = 3)
cat("9/9 Guardado: S06_ic_equivalencia.pdf\n")

cat("\n=== Todos los gráficos generados ===\n")
