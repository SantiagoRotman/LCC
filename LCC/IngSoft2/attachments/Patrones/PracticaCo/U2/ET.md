## Ejercicio I

Explique en pocas líneas la razón por la cual el patrón de diseño Visitor utiliza el mecanismo de doble despacho.

Permite agregar operaciones a módulos sin la necesidad de cambiarlos.

## Ejercicio II

Describa las características fundamentales del patrón de diseño Visitor.

## Ejercicio III

Describa las características fundamentales del patrón de diseño Strategy.

## Ejercicio IV

Explique como se logra evitar la explosión de clases al utilizar el patrón de diseño Decorator.

Sea A una implementación base y sean B y C dos implementaciones adicionales que pueden llegar a ser utilizadas o no
dependiendo de los requerimientos del sistema. Para implementar cada implementación posible se necesitan cuatro 
módulos, A, A+B, A+C, A+B+C. Incluso con herencia la cantidad se mantiene. Pero si utilizamos el patrón Decorator
solo necesitamos tres, A, Bdeco, Cdeco.