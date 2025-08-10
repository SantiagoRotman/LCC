
Para comparar diseños, usamos de [[Criterio]] el
### [[Principio]] de Diseño para el Cambio: 
El mejor diseño es aquel que permite la implementación de cambios de manera tal que
* Cada cambio se efectué al menor costo posible
* La introducción de cada cambio no degrade la integridad conceptual del sistema

**La metodología de [[Parnas]] para descomponer un sistema en módulos**
1. Se identifican los ítem con probabilidad de cambio presentes en los requerimientos.
2. Se analizan la diversas formas en que cada ítem puede cambiar.
3. Se asigna una probabilidad de cambio a cada variación analizada.
4. Se aíslan en módulos separados los ítem cuya probabilidad de cambio sea alta.
5. Se diseñan las interfaces de los módulos de manera que resulten insensibles a los cambios
anticipados.
### [[Principio]] de Ocultación de Información
Los ítem con alta probabilidad de cambio son el fundamento para descomponer un sistema en
módulos. Cada módulo de la descomposición debe ocultar un único ítem con alta probabilidad de
cambio, y debe ofrecer a los demás módulos una interfaz insensible a los cambios anticipados.

**Diseño basado en ocultación de la información (DBOI):**
Cada uno de los módulos del sistema fue diseñado aplicando el POI y se siguieron adecuadamente cada uno de los pasos anteriores.

Cuando un módulo presenta una interfaz tal que los otros módulos no pueden suponer razonablemente nada sobre la implementación del módulo, se dice que la implementación está **encapsulada**. La **abstracción** consiste en lograr que la interfaz provea la menor cantidad de servicios posible y de la manera más abstracta posible.
### [[Principio]] de Diseño: Diseños Abiertos y Cerrados
El diseño debe ser tal que nuevas funcionalidades se puedan incorporar en nuevos módulos sin tener que modificar los módulos existentes. Los módulos de un diseño deben estar abiertos a extensiones, pero cerrados a modificaciones.

**Limitaciones de DBOI**: No hay, como esta planteado hasta ahora, una forma simple de generar instancias de módulos, seria conveniente poder tratar a cada módulo como un tipo en si.

**Diseño basado en tipos abstractos de datos (DTAD):** La única diferencia entre el DBOI y DTAD es que en este último se asume que cada módulo del diseño es, genera o define un tipo.

**Diseño orientado a objetos (DOO):**

**Herencia (de interfaces):** Sean A y B dos tipos de un DTAD. Decimos que B es un heredero de A si toda subrutina de la interfaz de A es una subrutina de la interfaz de B
* Los herederos pueden cambiar la definición (implementación) de las subrutinas de su interfaz.
* Si B es un heredero de A y g es una subrutina cualquiera tal que uno de sus parámetros formales es de tipo A, entonces también aceptará un parámetro real de tipo B.

**Diseño Orientado a Objetos (DOO):** Un DTAD en el cual se utiliza el concepto de herencia definido en la Definición 6, pasa a ser un Diseño Orientado a Objetos (DOO).

**Objeto:** En el contexto del DOO, un objeto es una instancia de un tipo (módulo).

**[[Principio]] de Diseño: Principio de sustitución de Liskov:** Si S es un subtipo de T, entonces los objetos de tipo T pueden ser sustituidos por objetos de tipo S sin alterar ninguna de las propiedades importantes del programa

Por lo general la mejor forma de aplicar la herencia es la siguiente:
1. Se considera un cierto ítem con alta probabilidad de cambio. 
2. Se define un tipo que lo oculta, pero que en general no será implementado; sólo provee una interfaz. Este tipo se implementa si no tiene herederos; ver el paso siguiente. 
3. Para las variantes del ítem de cambio se definen herederos del tipo que por lo general tienen la misma interfaz, es decir ni si quiera agregan subrutinas. 
4. Se implementan los herederos. 
5. Los clientes de todos estos tipos se definen únicamente en términos del supertipo; es decir esperan parámetros o definen variables cuyo tipo es el del supertipo

### [[Principio]] de Diseño: Programación Orientada a Objetos (POO)
Programe para una interfaz, no para una implementación. Es decir, no se deben declarar las variables con el tipo de los herederos sino con el tipo de los supertipos.

La herencia por sí sola, cualquiera sea su definición, no es el núcleo de un buen diseño. Aplicar la herencia como mecanismo primordial para obtener un diseño suele dar como resultado un diseño estático, difícil de comprender, mantener y modificar. El criterio central para descomponer un sistema en partes (diseñar) es el propuesto por Parnas.

**Herencia de Clases vs de Interfaces:** La herencia de clases define la implementación de un objeto en términos de la implementación de otro objeto . Esencialmente, es un mecanismo para compartir código y representación interna. Por otro lado, la herencia de interfaces (o subtipado) describe cuándo un objeto puede ser usado en lugar de otro. En el contexto del diseño, esta noción de herencia de interfaces está mucho más relacionada con la visión externa de un componente, que es parte del diseño, a diferencia de la implementación, que no lo es.

[[Principio]] de Diseño: Composición de objetos, Favorecer la composición de objetos frente a la herencia (de clases)

[[Principio]] de Diseño: Diseñar es documentar, Un diseño sin documentación carece de utilidad práctica.

# Documentos

## Documentos de módulos:
Los elementos de estos documentos son módulos o unidades de implementación. Los módulos representan una forma basada en el código de considerar al sistema. Cada módulo tiene asignada y es responsable de llevar adelante una función
* ### Especificación de Interfaces
 ![[Pasted image 20250511185654.png]]

* ### Estructura de Módulos
Los módulos que no son hojas de la estructura se llaman módulos impropios o lógicos, y las hojas se llaman módulos propios o físicos. Sólo los módulos físicos se implementan. Los módulos lógicos son un medio que permite organizar jerárquicamente el sistema. Los módulos lógicos no pueden participar en la herencia ni pueden instanciarse ni ser módulos genéricos. Ningún módulo puede ser submódulo de dos módulos diferentes.

![[Pasted image 20250511185802.png]]
![[Pasted image 20250511185827.png]]

* ### Guía de Módulos
La Guía de Módulos es un documento escrito en lenguaje natural que complementa la Especificación de Interfaces y la Estructura de Módulos. La guía se divide en capítulos, secciones, subsecciones, etc. donde cada una de estas divisiones corresponde a un nivel de la Estructura de Módulos

Módulos lógicos. Descripción del criterio por el cual el módulo contiene a sus “hĳos”. Muy breve descripción de los módulos existentes y de su función (uno o dos renglones por hĳo).

Módulos físicos. El texto se divide en dos secciones: Función y Secreto. 

Función. Se da una especificación funcional del módulo lo más detallada posible. En principio se debe dar una especificación funcional de cada una de las subrutinas en la interfaz del módulo. Esta especificación funcional debe incluir, como mínimo, el significado de cada parámetro y una explicación de cada una de las salidas; en particular deben explicarse cada uno de los mensajes de error producidos (un mensaje de error no es únicamente algo que se imprime en la pantalla, sino los errores en general que emite la subrutina incluyendo valores de retorno, excepciones, etc.). En caso de que exista una especificación formal se debe incluir una referencia a aquella. 

Secreto. En la segunda se explica la decisión de diseño que se decidió ocultar y la razón que llevó a ello; debe haber una referencia al documento Análisis de Cambio