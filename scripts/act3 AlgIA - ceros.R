
### DEPURACION DE CEROS

# Reseteo del entorno
rm(list = ls())

# Directorio con los datos
path <- "C:/Users/victo/OneDrive/Escritorio/UNIR/1er - Algoritmos e Inteligencia Artificial/Actividades IA/act3_algIA"
setwd(path)


#### ---- LIBRERIAS ----

library(ggplot2)
library(gridExtra)


#### ---- CARGA DE DATOS ----

# Cargar dataframes en 1 solo
columns <- read.table('column_names.txt', sep = "\f")   # Nombres de columnas de los datos (nombres de genes)
data <- read.csv('gene_expression.csv', header=FALSE, col.names=columns[[1]], sep=";")   # Datos; Columns se convierte en nombres de columnas
labels <- read.csv('classes.csv', header=FALSE, sep=";")   # Etiquetas para evaluar resultados
data$labels <- labels[[2]]   # Labels se convierte en la ultima columna del dataframe




#### ---- DEPURACION DE DATOS ----

# Observamos el dataset en busca de valores NA y valores 0
sumaNA <- sum(is.na(data))
sumaCero <- sum(data == 0)
total_celdas <- nrow(data) * (ncol(data) -1)   # Sin la columna labels
print(paste0("El dataset contiene ", sumaNA, " valores NA y ", sumaCero, " valores 0, de un total de ", total_celdas, " valores."))


## Depurar los valores 0
data_zeros <- data == 0   # Convertimos valores 0 a TRUE, resto a FALSE
# Primero, obtenemos la cantidad de 0 de cada columna
colszero <- colSums(data_zeros)   # Sumamos los valores TRUE de cada columna (los valores 0)
colszero_ordenado <- sort(colszero, decreasing = TRUE)   # Ordenamos de mayor a menor para evaluar mejor
colszero_ordenado   # Mostramos el resultado
# Lo mismo para las filas
rowszero <- rowSums(data_zeros)   # Sumamos los valores TRUE de cada columna (los valores 0)
rowszero_ordenado <- sort(rowszero, decreasing = TRUE)   # Ordenamos de mayor a menor para evaluar mejor
rowszero_ordenado   # Mostramos el resultado




# HISTOGRAMAS: Visualizacion de los datos de cada gen
# En bloques de 20 genes; histogramas en grid de 4 filas x 5 columnas
# Siendo 500 genes, son 25 grupos (i) de 20 genes
# IMPORTANTE: los genes quedan ordenados de mayor a menor valores cero

for (i in 0:24) {   
  # Cada valor de i es un grupo de 20 genes
  
  # 1. Lista para almacenar los histogramas
  plots <- list()
  
  # 2. Generar un histograma para cada gen dentro del grupo
  for (gen in names(colszero_ordenado)[(20*i+1):(20*i+20)]) {
    p <- ggplot(data, aes_string(x = gen)) +
      geom_histogram(binwidth = 1, fill = "steelblue", color = "black", alpha = 0.7) +
      labs(title = gen, x = "Expresión", y = "Observaciones") +
      theme_minimal()
    
    # Almacenar el histograma en la lista
    plots[[gen]] <- p
  }
  
  # 3. Almacenar los histogramas en una cuadrícula de 5 cols con gridExtra y guardar como archivo
  grid_plot <- do.call(grid.arrange, c(plots, ncol = 5))  # 5 columnas en la cuadrícula
  file_name <- paste0("histogramas_genes_porordenceros_", (20*i+1), "-", (20*i+20),".png")
  ggsave(file_name, plot = grid_plot, width = 12, height = 8, dpi = 300)
}



# DISCUSION SOBRE LOS CEROS:

# CEROS A LO LARGO DE LAS COLUMNAS
# 3 columnas contienen todo valores 0 -> no aportan ninguna informacion, eliminar
# 34 columnas contienen entre 400 y 800 valores 0 (hasta histograma 37) -> eliminar?
# 34 columnas contienen entre 100 y 399 valores 0 (hasta histograma 71) -> imputar valor minimo
# 25 columnas contienen entre 15 y 99 valores 0 (hasta histograma 96) -> imputar valor minimo
# 56 columnas contienen entre 1 y 14 valores 0 (hasta histograma 152) -> imputar valor minimo
# 349 columnas contienen 0 valores 0 -> perfecto, estas columnas no necesitan tratamiento

# QUE HACER CON LOS CEROS:
# Los ceros pueden ser debidos a ausencia de expresion de un gen en una condicion (relevante), limitaciones tecnicas (errores, o valores por debajo del minimo de deteccion)...
# Es importante mantener aquellos ceros que son relevantes, pero se les pueden imputar valores no-cero.
#
# 1. Eliminar genes con demasiados ceros: genes con ~800 ceros contienen poca informacion, candidatos a ser eliminados
# 2. Imputacion de ceros: imputar el valor no-cero mas bajo, si se sospecha limite de deteccion
# 3. Análisis por grupos: estan los ceros asociados a subgrupos, o los genes con ceros tienen un contexto biologico? Como afectan los ceros a la varianza de los datos?
# 4. Normalizacion por metodos que manejan ceros (e.g. DESeq2)



