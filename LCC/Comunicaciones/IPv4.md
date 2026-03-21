**Protocolo IP:** Conectar muchas redes fisicas en una virtual grande y ofrecer un servicio, sin conexión, de entrega de paquetes.

**Datagrama IP (paquete):**
![[Pasted image 20260314164204.png]]
**Version:** La version del protocolo usado
**LON:** La longitud de la cabecera en palabras de 32 bits, de 20 a 60 bytes
**Tipo de servicio:** Una indication para la red de como tratar el paquete, no garantiza el servicio.
![[Pasted image 20260314164540.png]]
* PRIO: Se utiliza en casos de congestión, va de 0 (normal) a 7 (control de red), en general se ignora.
* D (Delay): Dar prioridad al retardo.
* T : Dar prioridad al throughput.
* R (Reliability): Dar prioridad a la fiabilidad .
* C (Cost): Dar prioridad al coste.

**Longitud total:** Tamaño total del datagrama medido en octetos
**Identificación:**  Entero que identifica a un datagrama, si es fragmentado todos los fragmentos tienen el mismo numero

**Flags:**

| Reserved (1 bit) | Don’t Fragment (DF) (1 bit)<br>Cuando es 1 indica que el datagrama no se debe fragmentar | More Fragments (MF) (1 bit)<br>Cuando es 1 indica que no es el final y quedan mas fragmentos |
| ---------------- | ---------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
**Fragment offset:** Indica el desplazamiento de los datos del fragmento en el datagrama completo, se mide en unidades de 8 bytes

**Time To Live (TTL):** La duración, en segundos, que el datagrama puede permanecer en la red. Los routers y anfitriones que procesan los datagramas deben decrementar el campo en 1 y eliminarlo si llega a 0.

**Protocolo:** El protocolo de alto nivel usado para crear el datagrama, Ej: IP (4), TCP(6), UDP(18)

**Header Checksum:** Suma en bloques de 16 bits de la cabecera y se transmite el complemento a uno como checksum, de manera de tener en el receptor la suma mas el checksum igual a 0.

**Source Address:** IP el emisor
**Destination Address:** IP el receptor

**Opciones:** Debe ser implementado por todos los dispositivos IP, se usa para pruebas o depuración
Para mas info leer hoja 34

**Relleno:** Relleno para que el tamaño del encabezado sea múltiplo de 32 bits