
## [[Preparacion de datos]]: Si entra basura sale basura

### Entendiendo los datos
* **Analizar su relevancia para el problema**: Hablar con el experto, ver si hay otros datos relevantes y si ver el periodo de tiempo que cubren los datos:
* **Analizar la calidad de los datos**: 
	* Si el numero de datos es suficiente para que sean confiables
	* Analizar la cantidad de variables:
		* A ojo: 10 o mas datos por cada variables
		* Analizar si usar selección o extracción de variables
	* Analizar el balance entre las clases

### Limpiando los datos

**Meta-datos:** Datos sobre los datos, brindan información como:
* Tipo de variable
* Uso de la variable: Input, output, weight (da peso estadístico), si se tiene que ignorar o no, etc.

**Formato de los datos:** En general conviene convertir los datos a un formato estándar numérico. Analizar:
* **Datos faltantes:** Si el modelo no se aguanta valores faltantes, podemos:
	* Si hay pocos registros con datos faltantes: **Ignorar los registros** 
	* Si las variables son poco útiles y tienen mucha proporción de faltantes: **Ignorar las variables** 
	* Tratar los NA como un **valor particular** (eg -1)
	* **Imputation:** Llenado con un valor no extremo, como la mediana o media, o también se puede tratar de predecir el valor particular adecuado con un método de ML.
* **Formato uniforme y coherente para las fechas:** 
	* KSP (Mejor): YYYY + (#days_starting_Jan_1 - 0.5) / 365 + 1_if_leap_year
	* Unix: Numero de segundos hasta la fecha, es poco entendible
	* YYYYMMDD (Malo): No conserva distancias, eg  20240201 - 20240131 != 20240131 – 20240130
* **Variables categóricas:** 
	* **Binarias**: Pasar a -1, 1
	* **Ordinales** (Tienen orden): Convertir a números que preserven el orden natural y la escala 
	* **Nominales**: 
		* Pocos valores (<20): Convertir cada valor a una variable binaria
		* Muchos valores: Ignorar valores únicos, agrupar si tiene sentido o dejar las mas frecuentes y agrupar el resto en "otros". Luego crear variables binarias para las seleccionadas
* **Variables cíclicas:** Variables codificadas como un número pero que son circulares, como las horas del día o un ángulo. Se pueden convertir en dos variables tipo coordenadas (x,y) en un círculo. (hora_x<-cos(2*PI*hora/12))
* **Discretizar variables continuas (binning):** Algunos algoritmos usan valores discretos. Pueden usarse bins del mismo ancho. El problema es que esto puede generar aglutinamiento si los datos están agrupados o tienen una escala dispersa. Otra opción es usar bins de igual altura, con lo cual los bins tendrán anchos distintos. Por lo general, es preferible usar bins de igual altura porque evita los grupos y es uniforme. También puede usarse eso como una primera distribución y después se ajustan los bins a valores informativos o más claros.
* **Normalizacion:** Si los datos tienen escalas distintas suele convenir transformarlos a escalas similares. 
	* Min-Max: Transformar al intervalo \[0,1],  susceptible a outliers
	* Z-Score: Mas usado, se resta la media y divide por el desvío estándar.

**Outliers y errores:** Normalmente un valor que esté fuera de 2 veces la distancia intercuartil desde los cuartiles 1 y 3 se lo considera un outlier. Opciones para lidiar con outliers son: 
* No hacer nada (si los valores extremos son importantes para el análisis de datos)
* Forzar límites y acotar outliers a esos valores extremos
* Hacer binning (no de igual ancho)

**Preselección de variables útiles - falsos predictores:** 
* Eliminar variables con muy poca variación (algunas veces). Rule of thumb: sacar las variables que toman 'casi siempre' el mismo valor. 
* Eliminar falsos predictores: Un falso predictor es un campo correlacionado con el target de mi modelado pero que no sirve para predecir. Un ejemplo típico: la nota final de un alumno predice perfectamente el estado de aprobación del curso.  Se puede hacer un árbol de desición y considerar como sospechosa a cualquier variable que identifique casi completamente a una clase al tope del árbol.

**Clases desbalanceadas:** En diagnostico medico clasificar a todos como sanos da poco error pero no sirve, se puede
* Sobre-samplear la clase minoritaria
* Sub-samplear la clase mayoritaria
* Sub-samplear inteligentemente: Descartar registros obvios o pocos informativos 

### [[Visualización de datos]]
La visualización proporciona soporte de la exploración interactiva, dada la capacidad humana de reconocimiento de patrones y de análisis visual. También ayuda a la presentación de resultados. Como desventaja, pueden llevar a confusiones o presentar datos de manera engañosa.

**Lie factor:** Resultado de dividir el tamaño del efecto que se ve en el gráfico por el
tamaño del efecto real en los datos.

**Principios de buenas visualizaciones:** darle al observador el mayor número de ideas en el menor tiempo con la menor cantidad de tinta y espacio.

#### Visualización en 1D
* Dot plot, puntos en un eje
* Histograma
* Box plot
#### Visualización en 2D
* Scatter plot
* Gráficos de contornos, zonas divididas por densidad. Util cuando hay muchos datos
#### Visualización en 3D
* Heat maps
* Scatter plots en 3D

#### Visualización en mas dimensiones
* **Vistas múltiples**: Se muestran cada variable por separado, como un histograma de cada una, no muestra correlaciones. 
* **Scatter-plots**: Muestra los gráficos para todos los pares de variables. Muy útil para ver correlaciones
* **Parallel Coordinates:** pone cada variable en un valor distinto (fijo) del eje horizontal. Los valores se ponen en la vertical de la variable correspondiente, y se unen con líneas los valores que corresponden a la misma entrada. No es tan fácil seguir patrones, pero se pueden visualizar y encontrar algunos detalles. En resumen: cada punto es una línea, si hay puntos similares tendremos líneas similares; las líneas que se cruzan muestran atributos negativamente correlacionados. 
* **Chernoff Faces:** Codifica las diferentes variables en características de la cara humana. Aprovecha la capacidad humana de encontrar fácilmente pequeñas diferencias entre caras. 
* **Star Plot:** Cada variable va en una dirección angular diferente. Cada punto forma una "constelación" usando trazos en la dirección correspondiente y con largo proporcional a su valor

#### Análisis de Componentes Principales (PCA)
Si tenemos un dataset centrado (medias 0) y queremos representar esos datos en un espacio de menor dimension, no solo sirve para visualizarlos hay modelos funcionan mejor con menos dimensiones. Intenta conservar la estructura de los datos, o la similitud entre las entradas.

**Definición:** La primer componente principal es la dirección en la cual los datos tienen máxima varianza. La segunda componente principal es la dirección en la cual los datos tienen máxima varianza, pero que es ortogonal a la primera. Y así sucesivamente. Las direcciones principales son los autovectores de la matriz de covarianza.

Una buena proyección es aquella que minimiza la diferencia entre los valores originales y sus proyecciones. PCA es muy útil en la detección de outliers.

Interpretación:
* PCA hace una proyección lineal, un giro de los ejes. 
* Cada eje principal es una combinación lineal de las variables originales. 
* Se puede buscar evidencia sobre la importancia de las variables originales evaluando su aporte a las PC. Se suele hacer gráficamente.

### [[Selección de variables]]
Hay casos que la extracción de variables (PCA, Tsne, KPCA, etc) no sirve o no conviene, por ejemplo cuando quiero reducir la cantidad de medidas a tomar para reducir costos, cuando se quiere mantener la interpretabilidad de los datos o cuando ya se sabe con certeza que hay variables inutiles. 
Estos métodos también para descubrir información sobre las variables como importancia, correlación o independencia.

#### Métodos de selección de variables
* **Univariados**: Consideran de a una variable para determinar su utilidad 
* **Multivariados:** Consideran subconjuntos de variables al mismo tiempo. 
* **Filtros:** Ordenan las variables de acuerdo a un criterio de importancia independientemente de la predicción 
* **Wrappers**: Usan el predictor final para evaluar la utilidad de las variables
Los filtros suelen ser univariados mientras que los wrappers suelen ser multivariados.

Realizar una búsqueda exhaustiva en las posibles combinaciones de variables tiene dos problemas. El primero es la explosión combinatoria de los casos, lo que usualmente lo vuelve computacionalmente inviable. Aún así, un segundo inconveniente es que hacer pruebas exhaustivas puede llevar a falsos predictores en casos en las que una combinación tiene valores óptimos por sobreajuste.

### Probabilistic and Generative Classification Models

Hay tres soluciones comunes al problema de clasificación 
* **Aprender una regla de clasificación directamente sobre los datos:** Arboles, redes neuronales, etc.
* **Aprender la probabilidad de cada clase dado el input P(y/X):** regresión lógica, redes neuronales probabilísticas (softmax), etc.
* **Crear un modelo probabilístico para cada clase P(y,X):** La idea es usar estos modelos para estimar con cual de las dos clases es mas probable generar el punto de input. Ejemplos Naive Bayes

Mas concretamente los modelos probabilísticos generativos generan las probabilidades de conjuntas para cada clase y la entrada X=(x1,x2,...xn). Pero estimar la probabilidad conjunta para todas las variables es en general imposible ya que los espacios se vacían en altas dimensiones

#### Naïve Bayes 
Asume que todas las variables son independientes entre si, entonces aplicando la regla de la cadena. P(y,x1,x2,...,xn) se puede transformar en P(x1|y)P(x2|y)…P(xn|y) P(y). Para evitar la perdida de precisión por la multiplicación de muchos valores de diferentes escalas en punto flotante se usan logaritmos para convertilo en una suma.

Un problema es cuando alguna probabilidad da 0 te anula la cuenta aunque en realidad casi nunca es 0 sino muy chico. Para remediar esto se pueden añadir registros virtuales.

Tambien se puede adaptar el algoritmo para variables continuas, usando la distribución normal para modelar la probabilidad condicional. Usando funciones para cada variable y clase construidas estimando la media y la varianza de las variables para cada clase. Otra manera es usar histogramas para discretizar las variables

### [[Aprendizaje por instancias]] o lazy 

No aprende una función explicita de los datos, si no que crea una función implícita local. Esta función se calcula al momento de evaluar un dato, por eso lazy.
* El costo de clasificar es mayor, pero no tiene consto de entrenar.

**KNN:** Dado un x nuevo busca los k puntos mas cercanos y si el problema es de:
* Clasificación: Le asigna a x la clase mayoritaria de sus vecinos.
* Regresión: Usa una función simple sobre los valores de los vecinos, como el promedio.

Sesgo o bias inductivo: Asume que el espacio de las features es continuo localmente para las clases

Una mejora simple es pesar a los vecinos por la distancia a x.

**Locally Weighted Regression:** Construye funciones simples locales *explicitas* 
* Regresión lineal: Se crea una función $f_L(x) = w_0 + w_1 x_1 + ...+ w_n x_n$ y se usa una función de error para minimizarla y encontrar las w
* RBF: Se usa una función radial como kernel y luego se hace una regresión lineal sobre los puntos dados por estas funciones de kernel

### [[Transformers]]

