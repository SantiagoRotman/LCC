

# Testing Estructural

En el testing estructural, los conjuntos de prueba deben cumplir con lo que se denomina **criterio de selección de casos de prueba**, un subconjunto del dominio de entrada del programa. Si C es un criterio de selección y T es un conjunto de prueba que pertenece a C, se dice que T satisface C. 

Un criterio de selección C es **consistente** sí y solo sí para cualesquiera conjuntos de prueba T1 y T2 que satisfacen C, T1 no encuentra un error sí y solo sí T2 tampoco lo hace.

- **Criterio de cubrimiento de sentencias**
	Seleccionar un conjunto de prueba T tal que, al ejecutar P para cada d en T, cada sentencia básica de P es ejecutada al menos una vez.
- **Criterio de cubrimiento de flechas**
	Seleccionar un conjunto de prueba T tal que, al ejecutar P para cada d en T, cada flecha del CFG de P es atravesada al menos una vez.
- **Criterio de cubrimiento de condiciones**
	Seleccionar un conjunto de prueba T tal que, al ejecutar P para cada d en T, cada flecha del CFG de P es atravesada al menos una vez y las proposiciones simples que forman condiciones (P1 and P2 or P3) toman los dos valores de verdad.
- **Criterio de cubrimiento de caminos**
	Seleccionar un conjunto de prueba T tal que, al ejecutar P para cada d en T, se recorren todos los caminos completos posibles del CFG P.

# Testing Basado en Especificaciones Z

Un programa es correcto si verifica su especificación, entonces necesitamos saber cómo expresar los casos de prueba y los resultados del programa en términos de la especificación.