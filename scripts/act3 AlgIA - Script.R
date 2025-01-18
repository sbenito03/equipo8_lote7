
# Reseteo del entorno
rm(list = ls())

# Configurar directorio (cambiar a tu directorio personal)
#path <- "C:/Users/victo/OneDrive/Escritorio/UNIR/1er - Algoritmos e Inteligencia Artificial/Actividades IA/act3_algIA"
path <- 
setwd(path)


#### ---- CARGA DE LIBRERÍAS ----

# Librerias generales (dyplr, stats, ggplot...)

# Librerias especificas (caret, librerias de algoritmos)




#### ---- CARGA DE DATOS ----

# Cargar dataframes en 1 solo
columns <- read.table('column_names.txt', sep = "\f")   # Nombres de columnas de los datos (nombres de genes)
data <- read.csv('gene_expression.csv', header=FALSE, col.names=columns[[1]], sep=";")   # Datos; Columns se convierte en nombres de columnas
labels <- read.csv('classes.csv', header=FALSE, sep=";")   # Etiquetas para evaluar resultados
data$labels <- labels[[2]]   # Labels se convierte en la ultima columna del dataframe

# Depurar datos (imputacion de NAs)
sumaNA <- sum(is.na(data))
sumaCero <- sum(data == 0)
total_celdas <- nrow(data) * (ncol(data) -1)   # Sin la columna labels
print(paste0("El dataset contiene ", sumaNA, " valores NA y ", sumaCero, " valores 0, de un total de ", total_celdas, " valores."))
# "El dataset contiene 0 valores NA y 32503 valores 0, de un total de 400500 valores."

## Depurar los valores 0





#### ---- METODOS DE APRENDIZAJE NO SUPERVISADO ----

# 2 metodos de reduccion de dimensiones -- pca, isomap, umap...

# 2 metodos de clustering -- average, ward...




#### ---- METODOS DE APRENDIZAJE SUPERVISADO + METRICAS DE EVALUACION ----

# 3 metodos de aprendizaje supervisado -- lda, rda, kNN, SVM, SVM kernel radial, SVM kernel polinomial, arbol de decision...

# 1er metodo
# Matriz de confusion
# Precision, sensibilidad, especificidad, score-F1

# 2o metodo
# Matriz de confusion
# Precision, sensibilidad, especificidad, score-F1

# 3er metodo
# Matriz de confusion
# Precision, sensibilidad, especificidad, score-F1
