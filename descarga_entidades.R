# Paquetes necesarios
# remotes::install_git("https://devops.imib.es/AISBIB/semanticCRFR.git")
library(tidyverse)
library(semanticCRFR)

# Cargar credenciales desde el .env en la raíz del proyecto.
dot_env <- file.path(getwd(), ".env")
if (!file.exists(dot_env)) stop("No se encontró el fichero .env en: ", dot_env)
readRenviron(dot_env)

USERNAME <- Sys.getenv("IMIB_USERNAME")
PASSWORD <- Sys.getenv("IMIB_PASSWORD")

# Validar que las credenciales se han cargado correctamente.
if (nchar(USERNAME) == 0 || nchar(PASSWORD) == 0) {
  stop("IMIB_USERNAME o IMIB_PASSWORD no están definidos en el .env")
}

# Manera de evitar que httr2 abra un diálogo interactivo para pedir la contraseña.
# httr2 llama a askpass::askpass() cuando la contraseña es NULL.
# Sobreescribiendo la opción "askpass" le indicamos que use nuestra función,
# que devuelve el valor del .env sin abrir ningún diálogo interactivo.
options(askpass = function(prompt) PASSWORD)

PROYECTO <- 11847

SALIDAS_CIRCADIANAS <- 522   # Una fila por visita de MCA: fechas, sensor, tipo sueño…
NO_PARAMETRICOS     <- 523   # No paramétricos por visita: IS, IV, RA, L5, M10…
DESCRIPTIVOS        <- 329   # Datos sociodemográficos y clínicos del sujeto

# Ruta de salida (relativa a la raíz del proyecto TFM)
OUT_DIR <- "./data/raw/crd"
dir.create(OUT_DIR, showWarnings = FALSE, recursive = TRUE)

# DESCARGA

guardar_csv <- function(df, nombre) {
  ruta <- file.path(OUT_DIR, paste0(nombre, ".csv")) # para que las llamadas posteriores sean más limpias
  # write_excel_csv (del paquete readr, ya cargado con tidyverse) guarda el
  # CSV en UTF-8 con una marca (BOM) al inicio, para que Excel reconozca la
  # codificación y represente correctamente los caracteres (tildes, ñ).
  readr::write_excel_csv(df, ruta)
  cat(sprintf("%-30s  %5d filas  |  %3d columnas  →  %s\n",
              nombre, nrow(df), ncol(df), ruta))
}

# --- patients: tabla maestra de sujetos del proyecto ---
patients <- get_patients(username = USERNAME, project = PROYECTO)
guardar_csv(patients, "patients")

# --- Entidad 522: salidas circadianas (una fila por visita de actigrafía) ---
salidas_circadianas <- get_entity(username = USERNAME, project = PROYECTO, entity = SALIDAS_CIRCADIANAS)
guardar_csv(salidas_circadianas, "salidas_circadianas_522")

# --- Entidad 523: parámetros no paramétricos (una fila por visita) ---
no_parametricos <- get_entity(username = USERNAME, project = PROYECTO, entity = NO_PARAMETRICOS)
guardar_csv(no_parametricos, "no_parametricos_523")

# --- Entidad 329: descriptivos del sujeto (una fila por visita; demográficos estables) ---
descriptivos_sujeto <- get_entity(username = USERNAME, project = PROYECTO, entity = DESCRIPTIVOS)
guardar_csv(descriptivos_sujeto, "descriptivos_329")
