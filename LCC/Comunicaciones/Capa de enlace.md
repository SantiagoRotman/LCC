
Controla la comunicación por el medio físico entre dos maquinas, se encarga de:
- Asegurar el orden de la información
- Evitar errores
- Elegir una velocidad compatible con ambas maquinas
- Controlar como se accede al medio físico
- Define el formato de la trama
- Direccionamiento de hardware

[[Trama]]: Unidad de información transmitida, orientada al bit
[[Paquete]]: Unidad de información transmitida, orientada a un conjunto de bits

La capa de enlace toma paquetes de la capa de red y los convierte en tramas. Luego la maquina destino hace el proceso inverso. Hay tres formas en las que ofrece este servicio a la capa de red

* Servicio sin acuse ni conexión: Se envían tramas independientes sin pedir que acuse su recibo, no se establece conexión. Se usa cuando la tasa de errores del canal es baja o para trafico en tiempo real. Los pocos errores en general se manejan en las capas superiores.

* Servicio con acuse sin conexión: Se usa con medios inestables, cada trama se reconoce individualmente. Usando ancho de banda pero es mas eficiente si hay bastantes errores.

* Servicio con acuse y orientado a la conexión: Se establece una conexión previa a la transferencia de datos, cada trama se numera y se garantiza el orden y la falta de errores. Se usa en líneas p2p, inalámbricas o telefónicas. 

## Subcapa de control de enlace (LLC)

Controla el reordenamiento de las tramas, control de flujo y control de errores.

### Enmarcado de la trama
Es la delimitación de la trama sin el uso del tiempo, para que el receptor conozca donde empieza y donde termina con precisión. Se usan varios métodos:

* **Cuenta de caracteres:** Utiliza un campo en la trama que tiene la longitud en caracteres de la misma. El problema es si hay un error en este campo se pierde la sincronización entre las maquinas, puede ser difícil, costoso e incluso no recuperable este tipo de error.
* **Bytes bandera con relleno de bytes:** Cada trama comienza y termina con una secuencia de caracteres de enmarque. El problema es que esta secuencia se puede confundir con los datos, en especial con datos binarios. Para solucionar se agrega un carácter de escape antes de los de enmarcado en los datos, o del mismo carácter de escape. La desventaja es que depende del conjunto de caracteres usados en cada maquina.
* **Bits bandera con relleno de bits:** Similar al anterior pero a nivel de bits, por ejemplo si se usa la secuencia 01111110 como delimitador. Si se quiere mandar esta secuencia como dato se le agrega un 0 después del quinto 1, el receptor sabe que tiene que sacarlo.
* **Violaciones de codificación de la capa física:** A nivel de la capa física se transmite una señal distinta que la del 0 o el 1.

### Control de errores
