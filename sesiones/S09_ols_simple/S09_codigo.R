# ============================================================================
# Session 9: R-squared, Significance, Dummies, and RCT Workshop
# Statistics 2026-II - Pontificia Universidad Javeriana
# Prof. Jaime Polanco Jimenez
#
# Data:
#   - Saber Pro / ICFES (from course GitHub repo)
#   - LaLonde (1986) NSW job training experiment (Matching package)
# ============================================================================

library(arrow)
library(dplyr)
library(ggplot2)

# --- 0. Load ICFES data -----------------------------------------------------

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
saber_pro$PRIVADA <- ifelse(saber_pro$TIPO_IES == "Privada", 1, 0)

cat("Observations:", nrow(saber_pro), "\n")


# ============================================================================
# PART 1: R-SQUARED
# ============================================================================

# --- 1.1 Mini exercise: 5 data points (pencil-and-paper verification) -------

horas <- c(2, 4, 6, 8, 10)
nota  <- c(55, 65, 70, 80, 85)

modelo_mini <- lm(nota ~ horas)
summary(modelo_mini)
coef(modelo_mini)

SST_mini <- sum((nota - mean(nota))^2)
SSE_mini <- sum(residuals(modelo_mini)^2)
SSR_mini <- SST_mini - SSE_mini

cat("Mini exercise:\n")
cat("  SST:", SST_mini, "\n")
cat("  SSE:", SSE_mini, "\n")
cat("  SSR:", SSR_mini, "\n")
cat("  R2: ", round(1 - SSE_mini / SST_mini, 4), "\n")
cat("  R2 (summary):", round(summary(modelo_mini)$r.squared, 4), "\n\n")


# --- 1.2 R-squared with ICFES data -----------------------------------------

modelo1 <- lm(MOD_INGLES_PUNT ~ PUNT_MATEMATICAS, data = saber_pro)

SST <- sum((saber_pro$MOD_INGLES_PUNT -
              mean(saber_pro$MOD_INGLES_PUNT))^2)
SSE <- sum(residuals(modelo1)^2)
SSR <- SST - SSE
R2  <- SSR / SST

cat("ICFES model:\n")
cat("  SST:", round(SST, 0), "\n")
cat("  SSE:", round(SSE, 0), "\n")
cat("  SSR:", round(SSR, 0), "\n")
cat("  R2 (manual):", round(R2, 4), "\n")
cat("  R2 (summary):", round(summary(modelo1)$r.squared, 4), "\n\n")

# R2 = r2 in simple regression
r <- cor(saber_pro$PUNT_MATEMATICAS, saber_pro$MOD_INGLES_PUNT)
cat("  cor:", round(r, 4), "\n")
cat("  cor^2:", round(r^2, 4), "\n\n")


# ============================================================================
# PART 2: SIGNIFICANCE
# ============================================================================

# --- 2.1 Full summary of the ICFES model ------------------------------------

summary(modelo1)

# --- 2.2 Confidence intervals -----------------------------------------------

confint(modelo1, level = 0.95)


# ============================================================================
# PART 3: DUMMIES
# ============================================================================

# --- 3.1 OLS with dummy: private vs public ----------------------------------

modelo_dummy <- lm(MOD_INGLES_PUNT ~ PRIVADA, data = saber_pro)
summary(modelo_dummy)

# Same result as a two-sample t-test
t.test(MOD_INGLES_PUNT ~ TIPO_IES, data = saber_pro, var.equal = TRUE)

# --- 3.2 Perfect multicollinearity trap -------------------------------------

saber_pro$PUBLICA <- 1 - saber_pro$PRIVADA

modelo_trap <- lm(MOD_INGLES_PUNT ~ PRIVADA + PUBLICA, data = saber_pro)
summary(modelo_trap)


# ============================================================================
# PART 4: REGRESSION TABLES (3 ICFES models)
# ============================================================================

m1_icfes <- lm(MOD_INGLES_PUNT ~ PUNT_MATEMATICAS, data = saber_pro)

m2_icfes <- lm(MOD_INGLES_PUNT ~ PUNT_MATEMATICAS + PRIVADA,
               data = saber_pro)

m3_icfes <- lm(MOD_INGLES_PUNT ~ PUNT_MATEMATICAS + PRIVADA + PUNT_INGLES,
               data = saber_pro)

cat("=== PUNT_MATEMATICAS coefficient across models ===\n")
cat("M1:", round(coef(m1_icfes)["PUNT_MATEMATICAS"], 3), "\n")
cat("M2:", round(coef(m2_icfes)["PUNT_MATEMATICAS"], 3), "\n")
cat("M3:", round(coef(m3_icfes)["PUNT_MATEMATICAS"], 3), "\n\n")

cat("=== R-squared ===\n")
cat("M1:", round(summary(m1_icfes)$r.squared, 3), "\n")
cat("M2:", round(summary(m2_icfes)$r.squared, 3), "\n")
cat("M3:", round(summary(m3_icfes)$r.squared, 3), "\n\n")


# ============================================================================
# PART 5: RCT WORKSHOP - LaLonde (1986)
# ============================================================================

# --- 5.0 Context -------------------------------------------------------------
#
# National Supported Work (NSW) Demonstration, 1970s, United States.
# A job training program for disadvantaged workers: ex-convicts,
# former drug addicts, high school dropouts, and young mothers.
# The program provided 12-18 months of subsidized employment
# and job training.
#
# Design: Randomized Controlled Trial (RCT).
#   - Treatment: accepted into NSW (job training)
#   - Control: randomly denied entry (no training)
#   - Outcome: real earnings in 1978 (re78), measured in USD
#
# Robert LaLonde (1986, American Economic Review) showed that
# non-experimental methods produced very different estimates from
# the RCT, launching the "credibility revolution" in economics.
# --------------------------------------------------------------------------

# --- 5.1 Load the data ------------------------------------------------------

install.packages("Matching", repos = "https://cloud.r-project.org")
library(Matching)
data(lalonde)

cat("=== LaLonde (1986) NSW Dataset ===\n")
cat("Observations:", nrow(lalonde), "\n")
str(lalonde)
names(lalonde)

table(lalonde$treat)
cat("Treated:", sum(lalonde$treat == 1), "\n")
cat("Control:", sum(lalonde$treat == 0), "\n\n")


# --- 5.2 Explore key variables ----------------------------------------------

summary(lalonde[, c("age", "educ", "re74", "re75", "re78")])

# Outcome by group
aggregate(re78 ~ treat, data = lalonde, FUN = mean)

cat("\nRaw difference in earnings:\n")
diff_raw <- mean(lalonde$re78[lalonde$treat == 1]) -
  mean(lalonde$re78[lalonde$treat == 0])
cat("  Treatment - Control = $", round(diff_raw, 0), "\n\n")


# --- 5.3 Balance check (verify randomization) -------------------------------

cat("=== Balance Table ===\n\n")

balance_vars <- c("age", "educ", "black", "hisp",
                  "married", "nodegr", "re74", "re75")

for (v in balance_vars) {
  m_treat  <- mean(lalonde[[v]][lalonde$treat == 1])
  m_ctrl   <- mean(lalonde[[v]][lalonde$treat == 0])
  tt       <- t.test(lalonde[[v]] ~ lalonde$treat)
  cat(sprintf("%-10s  Treat: %7.2f  Control: %7.2f  p = %.3f\n",
              v, m_treat, m_ctrl, tt$p.value))
}
cat("\n")

# If p > 0.05 for all: groups are balanced (randomization worked)


# --- 5.4 Visualize -----------------------------------------------------------

# Boxplot: earnings by treatment group
p1 <- ggplot(lalonde, aes(
  x = factor(treat, labels = c("Control", "Job Training")),
  y = re78,
  fill = factor(treat)
)) +
  geom_boxplot(alpha = 0.7, show.legend = FALSE) +
  labs(x = "Group", y = "Real Earnings 1978 (USD)",
       title = "LaLonde (1986): Earnings by Treatment Group") +
  theme_minimal()
print(p1)

# Distribution of earnings
p2 <- ggplot(lalonde, aes(
  x = re78,
  fill = factor(treat, labels = c("Control", "Job Training"))
)) +
  geom_histogram(bins = 30, alpha = 0.6, position = "identity") +
  labs(x = "Real Earnings 1978 (USD)", y = "Count",
       fill = "Group",
       title = "Distribution of Earnings by Group") +
  theme_minimal()
print(p2)

# Scatter: pre-treatment earnings vs post-treatment
p3 <- ggplot(lalonde, aes(
  x = re75, y = re78,
  color = factor(treat, labels = c("Control", "Job Training"))
)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Earnings 1975 (pre-treatment)",
       y = "Earnings 1978 (post-treatment)",
       color = "Group") +
  theme_minimal()
print(p3)


# --- 5.5 OLS with treatment dummy -------------------------------------------

m1_rct <- lm(re78 ~ treat, data = lalonde)
summary(m1_rct)

# Interpretation:
# beta_0 = mean earnings of control group
# beta_1 = causal effect of job training on earnings

# Confidence interval
confint(m1_rct)

# Verify: identical to a two-sample t-test
t.test(re78 ~ treat, data = lalonde, var.equal = TRUE)


# --- 5.6 Calculate R-squared by hand ----------------------------------------

SST_rct <- sum((lalonde$re78 - mean(lalonde$re78))^2)
SSE_rct <- sum(residuals(m1_rct)^2)
SSR_rct <- SST_rct - SSE_rct

cat("\n=== R-squared by hand ===\n")
cat("SST:", round(SST_rct, 0), "\n")
cat("SSE:", round(SSE_rct, 0), "\n")
cat("SSR:", round(SSR_rct, 0), "\n")
cat("R2:", round(1 - SSE_rct / SST_rct, 4), "\n")
cat("R2 (summary):", round(summary(m1_rct)$r.squared, 4), "\n\n")

# Low R2 but the effect is CAUSAL -- R2 measures prediction, not causation


# --- 5.7 Adding covariates --------------------------------------------------

# Model 2: add pre-treatment earnings
m2_rct <- lm(re78 ~ treat + re75, data = lalonde)

# Model 3: add demographics
m3_rct <- lm(re78 ~ treat + re75 + age + educ + black + married,
             data = lalonde)

# Model 4: add all pre-treatment variables
m4_rct <- lm(re78 ~ treat + re74 + re75 + age + educ +
               black + hisp + married + nodegr,
             data = lalonde)

cat("=== Treatment coefficient across models ===\n")
cat("M1 (treat only):  $", round(coef(m1_rct)["treat"], 0),
    "  R2:", round(summary(m1_rct)$r.squared, 4), "\n")
cat("M2 (+ re75):       $", round(coef(m2_rct)["treat"], 0),
    "  R2:", round(summary(m2_rct)$r.squared, 4), "\n")
cat("M3 (+ demog):      $", round(coef(m3_rct)["treat"], 0),
    "  R2:", round(summary(m3_rct)$r.squared, 4), "\n")
cat("M4 (all controls): $", round(coef(m4_rct)["treat"], 0),
    "  R2:", round(summary(m4_rct)$r.squared, 4), "\n\n")

# Key insight: in an RCT, the treatment coefficient barely changes
# when adding controls (exogeneity holds by design).
# But the SE shrinks and R2 increases.

# Compare confidence intervals
cat("=== Confidence Intervals for Treatment Effect ===\n")
ic1 <- confint(m1_rct)["treat", ]
ic2 <- confint(m2_rct)["treat", ]
ic3 <- confint(m3_rct)["treat", ]
ic4 <- confint(m4_rct)["treat", ]
cat("M1:", round(ic1, 0), " width:", round(diff(ic1), 0), "\n")
cat("M2:", round(ic2, 0), " width:", round(diff(ic2), 0), "\n")
cat("M3:", round(ic3, 0), " width:", round(diff(ic3), 0), "\n")
cat("M4:", round(ic4, 0), " width:", round(diff(ic4), 0), "\n\n")


# --- 5.8 Build a regression table -------------------------------------------

cat("=== REGRESSION TABLE (fill in during class) ===\n\n")
cat("                    (1)         (2)         (3)         (4)\n")
cat("                  re78        re78        re78        re78\n")
cat("---------------------------------------------------------------\n")

models <- list(m1_rct, m2_rct, m3_rct, m4_rct)
vars_show <- c("treat", "re75", "age", "educ", "black", "married")

for (v in vars_show) {
  coefs <- sapply(models, function(m) {
    s <- coef(summary(m))
    if (v %in% rownames(s)) {
      est <- round(s[v, "Estimate"], 0)
      se  <- round(s[v, "Std. Error"], 0)
      p   <- s[v, "Pr(>|t|)"]
      stars <- ifelse(p < 0.001, "***",
                      ifelse(p < 0.01, "**",
                             ifelse(p < 0.05, "*", "")))
      paste0(est, stars, " (", se, ")")
    } else {
      ""
    }
  })
  cat(sprintf("%-12s %12s %12s %12s %12s\n", v,
              coefs[1], coefs[2], coefs[3], coefs[4]))
}
cat("---------------------------------------------------------------\n")
cat(sprintf("%-12s %12s %12s %12s %12s\n", "R2",
            round(summary(m1_rct)$r.squared, 3),
            round(summary(m2_rct)$r.squared, 3),
            round(summary(m3_rct)$r.squared, 3),
            round(summary(m4_rct)$r.squared, 3)))
cat(sprintf("%-12s %12d %12d %12d %12d\n", "N",
            nrow(lalonde), nrow(lalonde), nrow(lalonde), nrow(lalonde)))
cat("\n")


# --- 5.9 What if it were NOT an RCT? (selection bias simulation) ------------

set.seed(2026)

# Create biased treatment: people with higher pre-earnings "choose" training
lalonde$prob_treat <- pnorm(lalonde$re75, mean = 3000, sd = 5000)
lalonde$treat_biased <- rbinom(nrow(lalonde), 1, lalonde$prob_treat)

# OLS without controls (biased)
m_biased1 <- lm(re78 ~ treat_biased, data = lalonde)

# OLS with controls
m_biased2 <- lm(re78 ~ treat_biased + re75 + age + educ + black,
                data = lalonde)

cat("=== RCT vs Observational Comparison ===\n\n")
cat("True experimental effect (M1): $",
    round(coef(m1_rct)["treat"], 0), "\n\n")
cat("Biased (no controls): $",
    round(coef(m_biased1)["treat_biased"], 0), "\n")
cat("Biased (with controls): $",
    round(coef(m_biased2)["treat_biased"], 0), "\n\n")

cat("Notice: without randomization, the estimate is biased.\n")
cat("Controls help, but cannot fully fix selection bias.\n")
cat("This is WHY economists care so much about identification.\n\n")

# Clean up the simulation column
lalonde$prob_treat   <- NULL
lalonde$treat_biased <- NULL


# ============================================================================
# END OF SESSION 9
# ============================================================================
