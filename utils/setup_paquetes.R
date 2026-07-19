# ============================================================================
# Setup de paquetes - Estadistica 2026-II - Pontificia Universidad Javeriana
# ============================================================================

paquetes <- c(
  "tidyverse",
  "ggplot2",
  "car",
  "lmtest",
  "sandwich",
  "MASS",
  "boot",
  "pwr",
  "effsize",
  "strucchange",
  "moments",
  "corrplot"
)

nuevos <- paquetes[!(paquetes %in% installed.packages()[, "Package"])]

if (length(nuevos) > 0) {
  install.packages(nuevos, repos = "https://cloud.r-project.org")
  cat("Paquetes instalados:", paste(nuevos, collapse = ", "), "\n")
} else {
  cat("Todos los paquetes ya estan instalados.\n")
}

invisible(lapply(paquetes, library, character.only = TRUE))
cat("Todos los paquetes cargados correctamente.\n")
