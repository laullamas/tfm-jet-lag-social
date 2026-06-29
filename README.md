# Cuantificación, caracterización y modelado predictivo del jet lag social a partir de datos de monitorización circadiana ambulatoria

Trabajo de Fin de Máster (TFM) del Máster en Bioinformática de la Universidad de
Murcia (curso 2025/26). 

Este repositorio reúne el código del flujo de trabajo, desde la descarga de los datos
hasta los modelos de aprendizaje automático que predicen el SJL.

> **Nota sobre los datos.** Los datos de la cohorte contienen información personal y no se publican por motivos de confidencialidad. El repositorio
> incluye únicamente el código y los informes renderizados (HTML).

## Flujo de trabajo

| Orden | Archivo | Función |
|---|---|---|
| 0 | [`descarga_entidades.R`](descarga_entidades.R) | Descarga las entidades |
| 1 | [`preprocesamiento.ipynb`](preprocesamiento.ipynb) | Limpieza, cálculo del SJL y construcción de los conjuntos de datos |
| 2 | [`construccion_dataset.Rmd`](construccion_dataset.Rmd) | Ensamblado del conjunto de datos de modelado y diccionario de variables |
| 3 | [`analisis_estadistico.Rmd`](analisis_estadistico.Rmd) | Caracterización descriptiva e inferencial del SJL |
| 4 | [`machine_learning.Rmd`](machine_learning.Rmd) | Regresión y clasificación binaria del SJL |

## Informes renderizados

Cada `.Rmd` genera un informe HTML autocontenido (carpeta `html/`) con las figuras
y tablas embebidas. 

| Informe | Ver |
|---|---|
| Preprocesamiento | [Ver](https://raw.githack.com/laullamas/tfm-jet-lag-social/main/html/preprocesamiento.html) |
| Construcción del dataset | [Ver](https://raw.githack.com/laullamas/tfm-jet-lag-social/main/html/construccion_dataset.html) |
| Análisis estadístico | [Ver](https://raw.githack.com/laullamas/tfm-jet-lag-social/main/html/analisis_estadistico.html) |
| Machine learning | [Ver](https://raw.githack.com/laullamas/tfm-jet-lag-social/main/html/machine_learning.html) |

## Entorno y dependencias

Análisis desarrollado con **R 4.6.0** y **Python 3.13.9** sobre Windows 11. Además de
R base y de la biblioteca estándar de Python, se emplearon los siguientes paquetes, en
las versiones indicadas:

**R**

| Paquete | Versión | Uso |
|---|---|---|
| tidyverse | 2.0.0 | Manipulación de datos y gráficos (dplyr, tidyr, ggplot2, readr, purrr, stringr, tibble, forcats, lubridate) |
| patchwork | 1.3.2 | Composición de gráficos multipanel |
| scales | 1.4.0 | Formato de ejes y escalas |
| ggtext | 0.1.2 | Texto enriquecido en los gráficos |
| DT | 0.34.0 | Tablas interactivas en los informes |
| rstatix | 0.7.3 | Pruebas no paramétricas (Kruskal-Wallis, Dunn) |
| effectsize | 1.0.2 | Tamaños del efecto (Cliff δ, ε²) |
| ppcor | 1.1 | Correlación parcial de Spearman |
| psych | 2.6.5 | Idoneidad del PCA (KMO) |
| nFactors | 2.4.1.2 | Número de componentes (análisis paralelo de Horn) |
| inflection | 1.3.7 | Detección del codo en el scree plot |
| caret | 7.0-1 | Entrenamiento, validación cruzada y selección de variables |
| ranger | 0.18.0 | Random forest |
| randomForest | 4.7-1.2 | Evaluador del wrapper RFE |
| kernlab | 0.9-33 | Máquinas de vectores soporte (SVM) |
| glmnet | 5.0 | Elastic Net y regresión logística regularizada |
| xgboost | 1.7.8.1 | Gradient boosting (ver nota) |
| MLmetrics | 1.1.3 | Métricas de clasificación (Macro-F1, etc.) |
| pROC | 1.19.0.1 | Curvas ROC, AUC y test de DeLong |
| doParallel | 1.0.17 | Paralelización del entrenamiento |
| shapviz | 0.10.3 | Valores SHAP (TreeSHAP) y su visualización |
| rmarkdown | 2.31 | Motor que genera los informes HTML a partir de los `.Rmd` |
| knitr | 1.51 | Ejecución de los bloques de código de los informes |
| kableExtra | 1.4.0 | Formato de tablas |
| semanticCRFR | 0.3 | Descarga del CRD (paquete interno del IMIB, no está en CRAN) |

**Python**

| Paquete | Versión | Uso |
|---|---|---|
| pandas | 2.3.3 | Manipulación de datos |
| numpy | 2.3.5 | Cálculo numérico |
| scipy | 1.16.3 | Estadística (media circular) |
| matplotlib | 3.10.6 | Gráficos |
| holidays | 0.98 | Calendario de festivos |
| python-dateutil | 2.9.0.post0 | Festivos móviles (p. ej. Pascua) |
| joblib | 1.5.2 | Paralelización |
| requests | 2.32.5 | Llamadas al API |
| python-dotenv | 1.1.0 | Carga de credenciales desde `.env` |
| jinja2 | 3.1.6 | Plantillas |
| ipykernel | 6.31.0 | Kernel de Jupyter |
| imib-pyutils | 0.2.26 | Autenticación OAuth2 con el API del IMIB (paquete interno, no está en PyPI) |

> **Nota sobre xgboost.** Se fija en la versión 1.7.8.1 porque caret 7.0-1 es incompatible con xgboost 2.1 o superior (un cambio interno del *booster* rompe la integración con caret).

> **Paquetes internos del IMIB.** `semanticCRFR` (R) e `imib-pyutils` (Python) son paquetes internos para acceder al CRD y al API; no están en repositorios públicos.

