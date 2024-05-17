# VendorVision

## Introduccion

### Antecedentes del problema

La tienda de abarrotes de Martínez García Oscar Daniel y Ugalde Rezendíz Vannesa, inició en el año 1992. Da servicios de atención a personas que necesitan comprar ciertos productos como canasta básica, alcohol, snacks, artículos de limpieza, etc. Los productos que actualmente están vendiendo son para un público en general.

Normalmente los dueños de esta tienda de abarrotes registran el conteo de productos, inversiones y ganancias en una libreta pequeña, por lo tanto, no se sabe la cantidad de producto que se tiene, y esto genera que no sean consumidos por los clientes y eventualmente no sirvan. Gracias a estas confusiones, se compra mucho o muy poco de lo que se debería, también no se conoce con exactitud la ganancia por día, y esto genera un descontrol total de las ganancias e inversiones. Por tales motivos en primera instancia se requiere de una aplicación local que realice la gestión de los productos, su inversión y ganancia (registrar, borrar y consultar), se realizarán estadísticas graficas con base a las ventas diarias para ver cuáles son las ganancias y cuanto producto se vendió, y así poder tener un control exacto de la tienda de abarrotes.

## Glosario de terminos

1. **Productos** Elementos que se le ofrecerán al cliente con el fin de que el los compre.

2. **Ganancias totales** Dinero total obtenido de los productos que fueron vendidos.

3. **Ganancias finales** Ganancias totales menos el dinero invertido.

4. **Dinero Invertido** Dinero que se ocupa para la compra de producto

5. **Estadística** Estudio que reúne y clasifica un conjunto de datos numéricos con el fin de llegar a conclusiones exactas.

6. **Gráfica** Ilustración que representa información de forma que sea más fácil de comprender.

7. **Inventario** Conjunto de productos que tiene una empresa para comercial con el cliente

8. **Comercio** Es la compra, venta o intercambio de bienes y/o servicios.

9. **Economía** Ciencia que estudia la producción, distribución, comercialización y consumo de bienes y servicios dados por los integrantes que participan en un sistema económico.

10. **Distribuidor** Persona, empresa u organización que se encarga de transportar un producto o servicio hasta el lugar donde será vendido.

11. **Tienda de abarrotes** En un establecimiento que ofrece diversos productos, en especial alimenticios.

## Modelo del sistema

### Modelo de cascada

El modelo de cascada es una metodología para la gestión de proyectos en el que el proyecto se divide en distintas fases secuenciales y donde el equipo puede pasar a la siguiente fase solo cuando se haya completado la anterior.

![](img/Modelo de cascada.png)

## Definición del problema, objetivo del proyecto usuarios

### Definición del Problema

Los dueños de la tienda Martínez García Oscar Daniel y Ugalde Rezdíz Vannesa no cuentan con un software local que les permita organizar y gestionar sus productos, inversiones y ganancias de su tienda de abarrotes.

### Objetivo del proyecto

Crear un software que permita organizar y gestionar la inversión, ganancia e información general de los productos, como la fecha de caducidad y cantidad, de la tienda de abarrotes.

Los Usuarios que podrán utilizar el proyecto son

- Administradores de la tienda

- Repartidor

## Requerimientos funcionales

### Módulo de gestión de productos

En esta sección se podrán administrar todos los productos registrar, consultar y borrar su información.

#### Submódulo de registro de productos

1. Nombre del producto

2. Clave a elegir

3. Inversión

4. Ganancia

5. Descripción

6. Cantidad en granel o por pieza en stock

7. Caducidad

#### Submódulo de consulta de producto

Se podrá consultar todos los productos y sus datos guardados como el nombre, inversión, ganancia, descripción y cantidad en stock.

Se podrá consultar los datos de un producto en específico solicitando al usuario su nombre o clave. Después se mostrará toda la información correspondiente al mismo como el nombre, inversión, ganancia, descripción y cantidad en stock.

Se dará la opción de modificar los datos de un producto, solicitando el nombre o clave del producto y el dato que se desea cambiar.

#### Submódulo de estadísticas

Se mostrarán los productos vendidos, su cantidad y los que hay en stock.

#### Submódulo de borrar productos

Se mostrará una lista de los productos registrados, y se solicitará el nombre o código del producto que se desea borrar.

### Módulo de ventas

En este módulo se registrarán los productos que sean comprados por el cliente en una sesión, que muestre los productos vendidos y el total a pagar por ellos

#### Submódulo de inversión

Se almacenarán los datos de la inversión de cada producto solicitando la clave o nombre del producto.

#### Submódulo de ganancias

Se almacenarán las ganancias de cada producto vendido solicitando la clave o nombre del producto.

#### Submódulo de estadística de inversión y ganancias

Se mostrarán las inversiones y ganancias de los productos por día.

### Definición de Requerimientos No-Funcionales o de desempeño del sistema

- **Rendimiento** establece las expectativas de velocidad y capacidad del sistema. Puede incluir aspectos como tiempos de respuesta, tiempos de carga, rendimiento bajo diferentes cargas de trabajo y escalabilidad.

- **Disponibilidad** establece cuánto tiempo el sistema debe estar disponible para los usuarios. Puede incluir objetivos de tiempo de actividad, tiempo de inactividad planificado y recuperación ante fallas.

- **Fiabilidad** describe la confiabilidad del sistema y su capacidad para funcionar correctamente durante un período de tiempo determinado. Puede incluir aspectos como la tolerancia a fallos y la recuperación ante errores.

- **Portabilidad** define la capacidad del sistema para ser trasladado o adaptado a diferentes entornos y plataformas. Puede incluir la compatibilidad con diferentes sistemas operativos, navegadores o dispositivos.

- **Escalabilidad** describe cómo el sistema puede manejar un aumento en la carga de trabajo sin degradar su rendimiento. Puede incluir la escalabilidad vertical (mejorar los recursos de un solo equipo) o la escalabilidad horizontal (añadir más recursos o equipos para mantener el rendimiento).

## Requerimientos del Sistema

### Requerimientos de Hardware

1. Computadora
2. Espacio en disco duro 1GB
3. Memoria RAM 2 GB
4. Procesador 2GHz
5. Ratón
6. Teclado
7. Pantalla

### Requerimientos de Software

1. Java
2. Netbeans 8.1, 8.2
3. Cualquier sistema operativo compatible con Java
