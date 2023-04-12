--VAMOS A COMENZAR CON LA PRIMICIA QUE TENEMOS UNA EMPRESA DE BASE TECNOLIGICA, QUE VENDE PRODUCTOS O DISPOSITIVOS TECNOLOGICOS COMO"
--LAPTOPS, MOVILES, TABLETS, ETC. Y QUE LO HACE CON VARIOS VENDEDORES, Y EN VARIAS REGIONES DEL PAIS.

--CREAR UNA BASE DE DATOS:
create database EJEMPLO_DCD_1050_ENERO_ABRIL_2023_V1;
go

--USAMOS LA BASE DE DATOS DCD02:
use  EJEMPLO_DCD_1050_ENERO_ABRIL_2023_V1;
go

--VER IDIOMA DE MI SQL SERVER:
SELECT @@LANGUAGE AS IDIOMA
/*
La primera línea, "SELECT @@LANGUAGE AS IDIOMA", muestra el idioma actual configurado en el servidor de bases de datos.

*/

--CAMBIAMOS IDIOMA DEPENDIENDO:
SET LANGUAGE SPANISH
SET LANGUAGE ENGLISH

/*

01/01/2022
01-01-2022
2022-01-01
2022/01/01

Todos estos elementos representan la misma fecha, el 1 de enero de 2022, pero escritos en diferentes formatos.

01/01/2022: Este es un formato de fecha común en algunos países que utilizan el formato "dd/mm/yyyy", donde "dd" representa el día, "mm" el mes y "yyyy" el año. En este caso, el formato indica que es el 1 de enero de 2022.

01-01-2022: Este es otro formato común de fecha, especialmente en países que usan el formato "mm-dd-yyyy", donde "mm" representa el mes, "dd" el día y "yyyy" el año. En este caso, también representa el 1 de enero de 2022.

2022-01-01: Este es un formato ISO estándar de fecha, utilizado internacionalmente y que sigue el orden "yyyy-mm-dd", donde "yyyy" representa el año, "mm" el mes y "dd" el día. Este formato es muy utilizado en bases de datos y sistemas informáticos.

2022/01/01: Este es un formato de fecha menos común, pero todavía utilizado en algunos países. Este formato también sigue el orden "yyyy/mm/dd".


*/

select SYSDATETIME() as fecha, SYSUTCDATETIME() as fecha, CAST(getdate() as date) as Fecha_Normal

/*
Este es un código SQL que muestra tres diferentes funciones de fecha y hora:

SYSDATETIME(): es una función que devuelve la fecha y hora actual del sistema en formato de fecha y hora de SQL Server (por ejemplo: 2023-03-14 12:30:45.1234567).

SYSUTCDATETIME(): es una función que devuelve la fecha y hora actual del sistema en formato de fecha y hora de SQL Server en formato UTC (tiempo universal coordinado) (por ejemplo: 2023-03-14 18:30:45.1234567).

CAST(getdate() as date): es una función que convierte la fecha y hora actual del sistema en una fecha normal de SQL Server, eliminando la información de la hora (por ejemplo: 2023-03-14).

El código SQL utiliza "as fecha" para renombrar cada columna de la salida con el nombre "fecha" y facilitar la lectura del resultado.


*/

/*
Para diseñar esta base de datos, he considerado las siguientes entidades:

Departamento: información de los departamentos en los que trabajan los empleados.
Empleados: información de los empleados de la empresa.
Género: información de los géneros de las personas.
Cliente: información de los clientes de la empresa.
Vendedor: información de los vendedores de la empresa.
Supervisor: información de los supervisores de la empresa.
Ventas_Hechos: información de las ventas realizadas por los vendedores.
Productos: información de los productos vendidos por los vendedores.
Categoría_Producto: información de las categorías de productos.
Región: información de las regiones geográficas de la empresa.
Sucursal: información de las sucursales de la empresa.
Ciudad: información de las ciudades donde están ubicadas las sucursales.
Condición_Factura: información de las condiciones de pago de las facturas.
Días_Factura: información de los días de pago de las facturas.
Metas_Ventas_Anual: información de las metas de ventas anuales de los vendedores.
Estatus_Facturas: información del estatus de las facturas.


A continuación, presento el modelo de base de datos:


La tabla "Departamento" tiene una relación de uno a muchos con la tabla "Empleados", ya que un departamento puede tener varios empleados, pero un empleado solo puede pertenecer a un departamento.
La tabla "Empleado" tiene una relación de muchos a uno con la tabla "Departamento", ya que un empleado trabaja en un solo departamento, pero un departamento puede tener varios empleados.
La tabla "Género" tiene una relación de uno a muchos con la tabla "Cliente", ya que un género puede tener varios clientes, pero un cliente solo puede tener un género.
La tabla "Vendedor" tiene una relación de uno a muchos con la tabla "Supervisor", ya que un supervisor puede tener varios vendedores, pero un vendedor solo puede tener un supervisor.
La tabla "Supervisor" tiene una relación de muchos a uno con la tabla "Empleado", ya que un supervisor es un tipo de empleado, pero un empleado puede ser de varios tipos.
La tabla "Ventas_Hechos" tiene una relación de muchos a uno con la tabla "Productos", ya que una venta puede tener varios productos, pero un producto solo puede pertenecer a una venta.
La tabla "Productos" tiene una relación de uno a muchos con la tabla "Categoría_Producto", ya que una categoría puede tener varios productos, pero un producto solo puede pertenecer a una categoría.
La tabla "Region" tiene una relación de uno a muchos con la tabla "Ciudad", ya que una región puede tener varias ciudades, pero una ciudad pertenece a una sola región.
La tabla "Ciudad" tiene una relación de uno a muchos con la tabla "Sucursal", ya que una ciudad puede tener varias sucursales, pero una sucursal está ubicada en una sola ciudad.
La tabla "Sucursal" tiene una relación de uno a muchos con la tabla "Ciudad", ya que una ciudad puede tener varias sucursales, pero una sucursal solo puede estar en una ciudad.
La tabla "Ventas_Hechos" tiene una relación de muchos a uno con la tabla "Vendedor", ya que una venta puede ser realizada por un vendedor, pero un vendedor puede tener varias ventas.
La tabla "Ventas_Hechos" tiene una relación de muchos a uno con la tabla "Cliente", ya que una venta puede ser realizada a un cliente, pero un cliente puede tener varias ventas.
La tabla "Ventas_Hechos" tiene una relación de muchos a uno con la tabla "Condición_Factura", ya que una venta puede tener una condición de pago, pero una condición de pago puede estar en varias ventas.
La tabla "Ventas_Hechos" tiene una relación de muchos a uno con la tabla "Días_Factura", ya que una venta puede tener un día de pago, pero un día de pago puede estar en varias ventas.
La tabla "Ventas_Hechos" tiene una relación de muchos a uno con la tabla "Supervisor", ya que una venta puede ser supervisada por un solo supervisor, pero un supervisor puede supervisar varias ventas.
La tabla "Ventas_Hechos" tiene una relación de muchos a uno con la tabla "Metas_Ventas_Anual", ya que una venta contribuye a cumplir una meta de ventas anual, pero una meta de ventas anual puede ser alcanzada por varias ventas.
La tabla "Estatus_Facturas" tiene una relación de muchos a uno con la tabla "Condición_Factura", ya que un estado de factura puede corresponder a una sola condición de factura, pero una condición de factura puede tener varios estados de factura.

En cuanto a la implementación de estas relaciones en SQL Server, se podrían utilizar las claves foráneas para asegurar la integridad referencial 
entre las tablas. Por ejemplo, en la tabla "Ventas_Hechos", se podría agregar una columna "id_cliente" como clave foránea que haga referencia
a la columna "id" de la tabla "Cliente", para asegurarse de que cada venta esté asociada con un cliente existente en la tabla "Cliente". 
De esta forma, se garantiza que la base de datos no contenga registros huérfanos o referencias a entidades inexistentes.

A nivel de restricciones, se pueden definir las siguientes:

Clave primaria: cada tabla debe tener una clave primaria única para identificar de manera única cada registro. Por ejemplo, en la tabla "Empleados", la clave primaria podría ser el campo "ID_Empleado".
Clave foránea: se utilizan para establecer relaciones entre tablas. Por ejemplo, en la tabla "Ventas_Hechos", la clave foránea "ID_Producto" se relaciona con el campo "ID_Producto" de la tabla "Productos".
Restricciones de integridad referencial: se utilizan para garantizar que no se puedan agregar registros con valores que no existen en la tabla relacionada. Por ejemplo, en la tabla "Ventas_Hechos", la clave foránea "ID_Producto" debe hacer referencia a un registro existente en la tabla "Productos".
Restricciones de no nulos: se utilizan para garantizar que los campos requeridos no estén vacíos. Por ejemplo, en la tabla "Empleados", el campo "Nombre" no debe ser nulo.
Restricciones de valor único: se utilizan para garantizar que los valores en un campo sean únicos. Por ejemplo, en la tabla "Clientes", el campo "Correo_Electrónico" debe ser único para cada cliente.
Restricciones de valores predeterminados: se utilizan para establecer un valor predeterminado para un campo en caso de que no se proporcione un valor. Por ejemplo, en la tabla "Empleados", el campo "Fecha_Contratación" podría tener un valor predeterminado de la fecha actual si no se proporciona un valor explícito.
Restricciones de comprobación: se utilizan para garantizar que los valores en un campo cumplan ciertas condiciones. Por ejemplo, en la tabla "Ventas_Hechos", el campo "Cantidad_Vendida" no debe ser negativo.

Regla de Atomicidad:

Todas las tablas deben complir con la regla de atomicidad, ya que cada una de ellas tiene un único identificador de clave primaria, 
que garantiza que cada registro pueda ser identificado de manera única e indivisible. Además, las tablas no tienen registros que 
dependan de otros registros en otras tablas, lo que también garantiza que no habrá operaciones que afecten parcialmente a los datos.

La normalización:

La normalización de bases de datos es un proceso que se utiliza para estructurar las tablas de una base de datos de manera que se
reduzca la redundancia de los datos y se mejore su integridad. Las formas normales son reglas que establecen restricciones sobre la 
forma en que se estructuran las tablas.


*/


--Creamos la Tabla departamento, tambien podemos crearla manualmente sin comandos.
CREATE TABLE departamento(
 id_departamento int Primary key,
 nombre_departamento VARCHAR(40)
);
go
--seleccionamos la tabla para ver como ha quedado:

select * from departamento

--Creamos la Tabla Genero, tambien podemos crearla manualmente sin comandos.

CREATE TABLE genero(
	 id_genero int Primary key,
	 genero varchar(15)
	);
go

--seleccionamos la tabla para ver como ha quedado:

select * from genero

	
--Creamos la Tabla sucursal, tambien podemos crearla manualmente sin comandos.

create table sucursal(
	id_sucursal int primary key,
	surcusal varchar(50) not null,
	);
GO

--ver como ha quedado la tabla:

select * from sucursal

--Creamos la Tabla region, tambien podemos crearla manualmente sin comandos.
create table region(
	id_region int primary key not null,
	nombre varchar(50) not null,
	);
GO

--ver como ha quedado la tabla:

select * from region

	--Creamos la Tabla cuidades, tambien podemos crearla manualmente sin comandos.
create table ciudad(
	id_ciudad int primary key not null,
	nombre_ciudad varchar(50) not null,
	latitud float NULL,
	longitud float NULL,
	id_region int references region(id_region)
	);
go

--seleccionamos la tabla para ver como ha quedado:

select * from ciudad

--Creamos la Tabla region, tambien podemos crearla manualmente sin comandos.

create table status_empleado(
	id_status_empleado int primary key not null,
	tipo_contrato varchar(50) not null,
	Status_empleado varchar(30) not null,
	);
GO


--Creamos la Tabla empleados, tambien podemos crearla manualmente sin comandos.

CREATE TABLE empleados(
	 id_empleados int Primary key,
	 nombre varchar(30),
	 cedula varchar(15),
	 fecha_nacimiento date not null,
	 estado_civil varchar(10) not null,
	 nivel_academico varchar(20) not null,
	 sueldo int not null,
	 posicion varchar(50) not null,
	 fecha_entrada date not null,
	 id_genero int,
	 id_region int,
	 id_ciudad int,
	 id_sucursal int,
	 id_departamento int,
	 id_status_empleado int
	FOREIGN KEY (id_departamento) REFERENCES departamento (id_departamento),
	FOREIGN KEY (id_genero) REFERENCES genero (id_genero),
	FOREIGN KEY (id_region) REFERENCES region (id_region),
	FOREIGN KEY (id_ciudad) REFERENCES ciudad (id_ciudad),
	FOREIGN KEY (id_sucursal) REFERENCES sucursal (id_sucursal),
	FOREIGN KEY (id_status_empleado) REFERENCES status_empleado (id_status_empleado),

	  );
go

--NOTAS PARA CUANDO NECESITEMOS AGREGAR CAMPOS ADICIONALES UNA VEZ HAYAMO CREADO UNA TABLA Y NECESITAMOS
--MODIFICARLA. --AGREGAMOS UN NUEVO CAMPO LLAMADO ID_REGION PARA DETERMINAR QUE DE REGION ES EL EMPLEADO.
ALTER TABLE empleados
ADD FOREIGN KEY (id_region) REFERENCES region(id_region);
--AGREGAMOS UN NUEVO CAMPO LLAMADO ID_REGION PARA DETERMINAR QUE DE REGION ES EL EMPLEADO.


--Creamos la Tabla supervidores, tambien podemos crearla manualmente sin comandos.

create table supervisor(
	id_supervisor int primary key not null,
	supervisor varchar(50) not null,
	id_sucursal int not null,
	id_region int not null,
	id_genero int not null,
	FOREIGN KEY (id_sucursal) REFERENCES sucursal (id_sucursal),
	FOREIGN KEY (id_region) REFERENCES region (id_region),
	FOREIGN KEY (id_genero) REFERENCES genero (id_genero),
	);
GO

	select * from supervisor


 --CREAR TABLA FOTOS DE SUPERVISOR:

create table Fotos_supervisor (
	id_Foto_supervisor int primary key not null,
	foto_Supervisor_url varchar (255) not null,
	id_region int not null,
	id_genero int not null,
	id_supervisor int null,
	FOREIGN KEY (id_region) REFERENCES region (id_region),
	FOREIGN KEY (id_genero) REFERENCES genero (id_genero),
	FOREIGN KEY (id_supervisor) REFERENCES supervisor (id_supervisor),
	);
go

SELECT * FROM Fotos_supervisor
	select * from supervisor

--CREAREMOS UNA TABLA LLAMADA CONDICION DE FACTURA

create table condicion_factura (
	id_condicion int primary key not null,
	condicion varchar(25) not null,
	);
GO

--seleccionamos la tabla para ver como ha quedado:

select * from condicion_factura

--CREAREMOS UNA TABLA LLAMADA DIAS DE FActuracion

create table dias_factura (
	id_dias_factura int primary key not null,
	dias_creditos int not null,
	);
GO

--Creamos la Tabla Cliente, tambien podemos crearla manualmente sin comandos.

create table cliente(
	id_cliente int primary key not null,
	nombre_Cliente varchar(50) not null,
	apellido_Cliente varchar(50)not null,
	nombre_Negocio varchar (100) not null,
	direccion varchar(100) not null,
	telefono varchar(100) not null,
	RNC varchar (15) not null,
	id_region int not null,
	FOREIGN KEY (id_region) REFERENCES region (id_region),
	);
go

--seleccionamos la tabla para ver como ha quedado:

select * from cliente

--Creamos la Tabla categoria productos, tambien podemos crearla manualmente sin comandos.

create table categoria_producto(
	id_categoria int primary key not null,
	descripcion varchar(100) not null
	);
go

select * from categoria_producto

--CREAMOS LA TABLA FOTO CATEGORIA:
create table Foto_categoria_producto(
	id_Foto_categoria int primary key not null,
	url_Foto varchar(200) not null,
	id_categoria int not null,
	FOREIGN KEY (id_categoria) REFERENCES categoria_producto (id_categoria),
);
go

select * from Foto_categoria_producto


--Creamos la Tabla Productos, tambien podemos crearla manualmente sin comandos.

create table Productos(
	id_producto int primary key not null,
	descripcion varchar(100) not null,
	existencia int not null,
	precio_compra int not null,
	precio_ventas int not null,
	fecha_entrada date not null,
	id_categoria int not null
	FOREIGN KEY (id_categoria) REFERENCES categoria_producto (id_categoria),
	);
go

--seleccionamos la tabla para ver como ha quedado:

select * from Productos
	   	 
--CREAR TABLA FOTOS DE VENDEDOR:

create table Fotos_productos (
	id_producto int primary key not null,
	foto_Productos_url varchar (255) not null,
	id_categoria int not null,
	FOREIGN KEY (id_categoria) REFERENCES categoria_producto (id_categoria),
	FOREIGN KEY (id_producto) REFERENCES Productos (id_producto),
	);
go

select * from empleados
select * from Fotos_productos

--Creamos la Tabla vendedor, tambien podemos crearla manualmente sin comandos.

create table vendedor(
	id_vendedor int primary key not null,
	nombre_vendedor varchar(50) not null,
	id_ciudad int not null,
	id_region int not null,
	id_empleados int not null,
	id_cliente int not null,
	id_supervisor int not null,
	id_genero int not null,
	FOREIGN KEY (id_empleados) REFERENCES empleados (id_empleados),
	FOREIGN KEY (id_region) REFERENCES region (id_region),
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
	FOREIGN KEY (id_supervisor) REFERENCES supervisor (id_supervisor),
	FOREIGN KEY (id_ciudad) REFERENCES ciudad (id_ciudad),
	FOREIGN KEY (id_genero) REFERENCES genero (id_genero),
	);
go

--seleccionamos la tabla para ver como ha quedado:

select * from vendedor


--CREAR TABLA FOTOS DE VENDEDOR:

create table Fotos_vendedor (
	id_vendedor int primary key not null,
	foto_Vendedor_url varchar (255) not null,
	id_genero int not null,
	id_region int not null,
	id_supervisor INT NOT NULL,
	FOREIGN KEY (id_region) REFERENCES region (id_region),
	FOREIGN KEY (id_supervisor) REFERENCES supervisor (id_supervisor),
	FOREIGN KEY (id_vendedor) REFERENCES vendedor (id_vendedor),
);
go

--seleccionamos la tabla para ver como ha quedado:

select * from Fotos_vendedor



--CREAMOS LA TABLA LLAMADA VENTAS NORMALIZADA PARA LA TABLA DE HECHOS:
--ESTA TABLA SI SERIA LA CORRECTA, YA QUE ESTA NORMALIZADA: 

--ESTA EN LA FORMA MAS BASICA DE UNA TABLA DE VENTAS, EXISTE LO QUE SE LLAMA
-- TABLA DE HECHOS Y TABLAS DE DIMENSIONES, EN ELLAS PODEMOS ENCONTRAR
-- MODELO ESTRELLA O MODELO COPO NIEVE, QUE HACEN REFERENCIA A MODELOS PARA USO DE
-- DATA WAREHOUSE, O DATA MARTS.

-- GENERAMENTE LAS FACTURAS SE DIVIDEN EN ORDEN ESPECIFICO, ESTE ES:
--UNA TABLA LLAMADA ENCABEZADO DE FACTURA.
--OTRA TABLA LLAMADA DETALLE DE FACTURA.
-- EN AMBOS CASOS LA IDEA ES QUE SOLO SE REPITA EN EL ENCABEZADO EL NOMBRE DEL CLIENTE. NO DE FACTURA, FECHA, DIRECCION
--TELEFONO, NUMERO DE COMPROBANTE, ETC. 
-- EN EL DETALLE DE LA FACTURA ENTONCES MOSTRAR PRODUCTO, CANTIDAD, DESCUENTOS, ITBIS, MONTO, ETC. POR CADA ITEM O 
--PRODUCTO AGREGADO, PERO EN ESTE EJEMPLO SOLO TENDREMOS UNA FACTURA BASICA DE UN PRODUCTO POR COMPRA Y CLIENTE.

	
--NOTAS SOBRE CALCULOS DE PRECIOS

/*
En la contabilidad de costo se utiliza una formula para calcular a como se debe vender un producto
en nuestro caso es un modelo ficticio, el cual el precio esta dado directamente en la tabla

Pero si quisieramos hacerlo para fines de analis de utilidad y rentabilidad entonces deberiamos utilizar un tabla
nueva con la siguiente formula:

Precio de ventas que en este caso lo abreviamos como (PV) PRECIO DE VENTAS,  
sera igual al costo de ventas que abreviamos asi (CV) COSTO DE VENTAS
PV = CV/1-%
donde 1 es una contante y % es el marge que se estable de la ganancia que se espera optener del producto.
 % es el margen de utilidad deseado.


*/


--EN NUESTRA TABLA TENDREMOS UN CAMPO CALCULADO, QUE SERIA LA CANTIDAD COMPRADA POR EL PRECIO, ESTO ME DARIA EL MONTO.

--PROCEDEREMOS A CREAR LA TABLA BASICA VENTAS HECHOS:

create table Ventas_Hechos(
	id_ventas int primary key not null,
	No_facturas int not null,
	fecha_venta date,
	id_condicion int not null,
	id_dias_factura int not null,
	id_vendedor int not null,
	id_cliente int not null,
	id_producto int not null,
	cantidad int not null,
	precio_ventas int not null,
	monto as (cantidad * precio_ventas) PERSISTED,--Campo Calculado, Multiplica Datos.
	id_region  int not null,
	id_ciudad  int not null,
	FOREIGN KEY (id_condicion) REFERENCES condicion_factura (id_condicion),
	FOREIGN KEY (id_dias_factura) REFERENCES dias_factura (id_dias_factura),
	FOREIGN KEY (id_vendedor) REFERENCES vendedor (id_vendedor),
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
	FOREIGN KEY (id_producto) REFERENCES Productos (id_producto),
	FOREIGN KEY (id_region) REFERENCES region (id_region),
	FOREIGN KEY (id_ciudad) REFERENCES ciudad (id_ciudad),
	);
go

--seleccionamos la tabla para ver como ha quedado:

select * from Ventas_Hechos


--CREAR TABLA ESTATUS DE FACTURACION:

create table Estatus_Facturas(
	id_status int primary key not null,
	fecha_pago date,
	id_ventas int not null,
	No_facturas int not null,
	id_cliente int not null,
	monto_pagado int not null,
	Dias_credito int not null,
	estatus_Cobrado varchar(20) not null,
	FOREIGN KEY (id_ventas) REFERENCES ventas_hechos (id_ventas),
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
	);
go

--SELECCIONAMOS LA TABLA PARA LA ESTRUCTURA

select * from Estatus_Facturas

--crearemos la tabla Metas
create table Metas_Ventas_Anual(
	id_meta int primary key not null,
	id_sucursal int not null,
	id_region int null,
	fecha_inicio date,
	fecha_corte date,
	monto int not null,
	FOREIGN KEY (id_sucursal) REFERENCES sucursal (id_sucursal),
	FOREIGN KEY (id_region) REFERENCES region (id_region),
	);
go

select * from region

--SELECCIONAMOS LA TABLA PARA LA ESTRUCTURA

select * from Metas_Ventas_Anual

--Realizaremos un Select para ver todas las tablas: 

select * from departamento
select * from empleados
select * from genero
select * from Cliente
select * from vendedor
select * from supervisor
select * from Ventas_Hechos
select * from Productos
select * from categoria_producto
select * from region
select * from sucursal
select * from ciudad
select * from condicion_factura
select * from dias_factura
select * from Metas_Ventas_Anual
select * from Estatus_Facturas

--UNA VEZ TENEMOS TODAS NUESTRAS O ENTIDADES YA CREADAS, VAMOS A INSERTAR LOS DATOS A CADA UNA.:

--Insertamos algunos registros a la departamento:
select * from departamento

INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1001, 'administracion');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1002, 'contabilidad');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1003, 'ventas');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1004, 'tecnologia');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1005, 'Produccion');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1006, 'almacen');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1007, 'despacho');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1008, 'marketing');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1009, 'seguridad');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1010, 'finanzas');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1011, 'auditoria');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1012, 'compras');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1013, 'transportacion');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1014, 'Promosion');

SELECT * FROM departamento
--Insertamos algunos registros a la departamento DIRECTIVOS:

INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1015, 'CTO (Chief Technology Officer)');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1016, 'CEO (Chief Marketing Officer)');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1017, 'COO (Chief Operating Officer)');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1018, 'CMO (Chief Marketing Officer)');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1019, 'CFO (Chief Financial Officer)');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1020, 'CCO (Chief Communications Officer)');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1021, 'CIO (Chief Information Officer)');
INSERT INTO departamento (id_departamento, nombre_departamento) VALUES(1022, 'CEO (Chief Executive Officer)');


--HACEMOS UN SELECT PARA LOS DEPARTAMENTOS:

SELECT * FROM departamento

--insertateremos datos en la tabla genero

insert into genero (id_genero, genero) values (1,'Femenino');
insert into genero (id_genero, genero) values (2,'Masculino');
insert into genero (id_genero, genero) values (3,'Otros');

--HACEMOS UN SELECT PARA LOS GENEROS:

SELECT * FROM GENERO


--Insertamos algunos registros a la tabla sucursal:

INSERT INTO sucursal(id_sucursal, surcusal)VALUES(1,'Santiago');--Todo el Cibao y el Norte del Pais
INSERT INTO sucursal(id_sucursal, surcusal)VALUES(2,'Azua');--Toda Zona Sur del Pais
INSERT INTO sucursal(id_sucursal, surcusal)VALUES(3,'Santo Domingo');--Toda la Parte Sureste del Pais Incluyendo y Santo Domingo

--HACEMOS UN SELECT PARA LOS sucursal:

select * from sucursal

--Insertamos algunos registros a la tabla region:

INSERT INTO region(id_region, nombre)VALUES(1,'Region Cibao');--Todo el Cibao y el Norte del Pais
INSERT INTO region(id_region, nombre)VALUES(2,'Region Sur');--Toda Zona Sur del Pais
INSERT INTO region(id_region, nombre)VALUES(3,'Region Este');--Toda la Parte Sureste del Pais Incluyendo y Santo Domingo

--seleccionamos la tabla para ver como ha quedado:

select * from region
select * from genero
select * from sucursal
select * from supervisor

--Insertamos algunos registros a la tabla supervisor:

INSERT INTO supervisor(id_supervisor, supervisor, id_sucursal,id_region, id_genero)VALUES(1,'FRANCISCO JAVIER PEÑA',1,1,2);--Todo el Ciebao y el Norte del Pais
INSERT INTO supervisor(id_supervisor, supervisor, id_sucursal,id_region, id_genero)VALUES(2,'LAURA DE LA ROSA MENDEZ',2,2,1);--Toda Zona Sur del Pais
INSERT INTO supervisor(id_supervisor, supervisor, id_sucursal,id_region, id_genero)VALUES(3,'JOSEP HERNADEZ',3,3,2);--Toda la Parte Sureste del Pais Incluyendo y Santo Domingo


--seleccionamos la tabla para ver como ha quedado:

select * from supervisor


--Insertamos algunos registros a la tabla CUIDAD:

--REGION DEL CIBAO:

INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(1,'Concepción de La Vega',19.2220707,-70.5295563,1);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(2,'Moca',19.3935204,-70.5259781, 1);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(3,'San Felipe de Puerto Plata',19.7934399,-70.6884003,1);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(4,'San Francisco de Macorós',19.3009892,-70.2525864,1);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(5,'Santiago de los Caballeros', 19.4517002,-70.6970291,1);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(6,'Bonao',18.9368706,-70.4092331,1);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(7,'Valverde',19.566667,-71.083333,1);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(8,'Monte Cristi',19.85,-71.65,1);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(9,'Samaná',19.205278, -69.336389,1);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(10,'Puerto Plata',19.795833, -70.694444,1);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(11,'Dajabón',19.54878, -71.70829,1);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(12,'Salcedo',19.37762,-70.41762,1);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(13,'Nagua',19.3832,-69.8474,1);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(14,'Cotuí',19.55186,-71.07813,1);

--REGION DEL SUR:

INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(15,'Villa Altagracia',18.67, -70.17,2);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(16,'San Cristóbal',18.4166698,-70.133333,2);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(17,'Indepencia',18.49,  -71.85,2);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(18,'Pedernales ',18.033333, -71.75,2);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(19,'San Jose de ocoa',18.5466099,-70.5063095,2);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(20,'Baní',18.2796402,-70.3318481,2);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(21,'Azua',18.4531898,-70.7349014,2);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(22,'Bajos de Haina',18.4153805,-70.0331726,2);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(23,'Santa Cruz de Barahona',18.2085400,-71.1007690,2);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(24,'Loma de Cabrera',19.422, -71.615,2);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(25,'San Juan de la Maguana',18.8058796,-71.2299118,2);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(26,'Bahoruco-Neiba',18.48137,-71.41965,2);

--REGION DEL ESTE:
   	
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(27,'Santo Domingo DN',18.502007355386127, -69.9379561871873,3);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(28,'Santo Domingo Oeste',18.5104964364861,-69.8572232487354,3);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(29,'Santo Domingo Este',18.4884701,-69.8570709,3);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(30,'Santo Domingo Norte',18.55,-69.9,3);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(31,'San Pedro de Macorós',18.4538994,-69.3086395,3);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(32,'La Romana',18.4273300,-68.9728470,3);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(33,'Salvaleón de Higuey',18.6150093,-68.7079773,3);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(34,'Punta Cana',18.5818195,-68.4043121,3);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(35,'El Seibo',18.76559,-69.03886,3);
INSERT INTO ciudad (id_ciudad, nombre_ciudad, latitud, longitud,id_region)VALUES(36,'Hato Mayor',18.76278,-69.25681,3);

--seleccionamos la tabla para ver como ha quedado:

select * from region
select * from ciudad



select * from empleados
select * from departamento


--Insertamos algunos registros a la empleados, en este casos todos de ventas.

SELECT * FROM status_empleado

--insertar status_empleado

insert into status_empleado (id_status_empleado, tipo_contrato,Status_empleado) values(1,'Tiempo Completo', 'Activo')
insert into status_empleado (id_status_empleado, tipo_contrato,Status_empleado) values(2,'Tiempo Completo', 'Renuncia')
insert into status_empleado (id_status_empleado, tipo_contrato,Status_empleado) values(3,'Tiempo Completo', 'Cancelado')
insert into status_empleado (id_status_empleado, tipo_contrato,Status_empleado) values(4,'Tiempo Completo', 'Suspendido')

insert into status_empleado (id_status_empleado, tipo_contrato,Status_empleado) values(5,'Tiempo Parcial', 'Activo')
insert into status_empleado (id_status_empleado, tipo_contrato,Status_empleado) values(6,'Tiempo Parcial', 'Renuncia')
insert into status_empleado (id_status_empleado, tipo_contrato,Status_empleado) values(7,'Tiempo Parcial', 'Cancelado')
insert into status_empleado (id_status_empleado, tipo_contrato,Status_empleado) values(8,'Tiempo Parcial', 'Suspendido')

insert into status_empleado (id_status_empleado, tipo_contrato,Status_empleado) values(9,'Remoto al 100%', 'Activo')
insert into status_empleado (id_status_empleado, tipo_contrato,Status_empleado) values(10,'Remoto al 100%', 'Cancelado')
insert into status_empleado (id_status_empleado, tipo_contrato,Status_empleado) values(11,'Mixto', 'Activo')
insert into status_empleado (id_status_empleado, tipo_contrato,Status_empleado) values(12,'Mixto', 'Cancelado')



--INSERTAMOS DATOS EN LA TABLA - ORDEN TODOS LOS DE LA REGION 1 DESDE EL ID EMPLEADO 1 AL 7:

INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(1,'CESAR MELENDEZ','244-0000256-1','1973-03-20', 'Soltero','Bachillerato',18600,'vendedor','2014-01-01',2,1,1,1,1003,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(2,'ANTONIO PEREZ','142-2568921-1','1971-12-13', 'Soltero','Diplomado/a',18600,'vendedor','2014-01-01',2,1,2,1,1003,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(3,'CRISTOPHER MENDEZ','201-7800123-0','1969-07-20','Soltero/a','Diplomado/a',18600,'vendedor','2014-01-01',	2,1,3,1,1003, '1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(4,'ULTIMO FERNADEZ','007-0072310-3','1973-07-23','Separado/a','Bachillerato',18600,'vendedor','2014-01-01',2,1,4,1,1003,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(5,'MARTES JIMENEZ','142-7654321-1','1969-10-16','Soltero/a','Bachillerato',18600,'vendedor','2014-01-01',2,1,5,1,1003, '1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(6,'ENMUEL JIMENEZ','123-4567891-0','1978-11-05','Casado/a','Diplomado/a',18600,'vendedor','2014-01-01',2,1,6,1,1003,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(7,'TINA GUTIERREZ','325-1234567-1','1966-06-10','Casado/a','Bachillerato',	18600,	'vendedor',	'2014-01-01',2,1,7,1,1003, '1');

--INSERTAMOS DATOS EN LA TABLA - ORDEN TODOS LOS DE LA REGION 2 DESDE EL ID EMPLEADO 8,9,10,11,12,13,32,33,36,38 :

INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(8,'SATURNINO BRAVO','220-0088004-1','1966-06-10','Casado/a','Bachillerato',	55200,	'vendedor',	'2014-01-01',1,2,15,2,1003, '1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(9,'ALONZO DE LOS SANTOS','007-0072310-4','1964-03-11','Casado/a','Bachillerato',35600,'vendedor','2014-01-01',1,2,16,2,1003, '1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(10,'MARITIN MARTINEZ','142-7654321-2','1969-12-13','Soltero/a','Diplomado/a',25000,'vendedor','2014-01-01',2,2,17,2,1003,  '1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(11,'FRANCELIS NUÑEZ VIDAL','123-4567891-1','1979-12-13','Soltero/a','Diplomado/a',25000,'vendedor','2014-01-01',2,2,18,2,1003,  '1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(12,'JESUS DE DIOS DE LOS SANTOS','325-1234567-2','1970-11-13','Soltero/a','Bachillerato',30000,'vendedor','2014-01-01',1,2,19,2,1003,  '1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(13,'JOSE ANTONIO MENDEZ','220-0088004-2','1970-10-13','Soltero/a','Bachillerato',25000,'vendedor','2014-01-01',2,2,26,2,1003 ,'1');

--INSERTAMOS DATOS EN LA TABLA - ORDEN TODOS LOS DE LA REGION 3

INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(14,'NICOLAS PAULINO','007-0072310-5','1989-10-05','Soltero/a','Diplomado/a',45000,'vendedor','2014-01-01',1,3,27,3,1003, '1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(15,'LUZ ANTONIA PRIETO','142-7654321-3','1995-11-05','Casado/a','Diplomado/a',45000,'vendedor','2014-01-01',1,3,28,3,1003,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(16,'MIGUEL HERRERA','123-4567891-2','1966-06-17','Soltero/a','Bachillerato',18600,'vendedor','2018-01-01',2,3,29,3,1003,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(17,'NACHALINE PEÑA','325-1234567-3','1984-09-10','Casado/a','Bachillerato',25000,'vendedor','2014-05-01',2,3,30,3,1003,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(18,'JUANCITO PEÑA V','224-0000000-1','1985-06-10','Casado/a','Maestria Sistemas',75000,'CTO (Chief Technology Officer)','2014-03-01',2,3,27,3,1001, '1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(19,'JUAN GUTIERREZ','007-0072310-6','1980-07-20', 'Separado/a','LIC. ADMINISTRACION',120000,'CEO (Chief Marketing Officer)','2014-06-04',2,3,27,3,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(20,'MILAGROS BONETTI','142-7654321-4','1977-03-28', 'Soltero','LIC. ADMINISTRACION',130000,'COO (Chief Operating Officer)','2017-08-11',1,3,27,3,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(21,'MARLON BORLAN','123-4567891-3','1990-10-16', 'Separado/a','LIC. ADMINISTRACION',150000,'CMO (Chief Marketing Officer)','2014-10-01',1,3,27,3,1001, '1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(22,'YENNIFER LOMBAR','325-1234567-4','1986-11-16', 'Soltero','LIC. ADMINISTRACION',145000,'CFO (Chief Financial Officer)','2016-03-30',1,3,27, 3,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(23,'MONICA CARRILLO','225-5555444-5','1989-03-20','Casado/a','INGENIERO INDUSTRIAL',145000,'CCO (Chief Communications Officer)','2021-11-25',1,3,27,3,1001, '1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(24,'ARLEN GOLSWORTHY','325-1234567-5','1995-04-20','Casado/a','ING. SISTEMAS',75000,'CIO (Chief Information Officer)','2014-01-01',1,3,27,3,1001, '1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(25,'HUBE SALLIER','225-5555444-6','1980-03-20','Casado/a','LIC. ADMINISTRACION',75000,'CEO (Chief Executive Officer)','2015-01-01',2,3,27,3,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(26,'JUAN CARLOS VILLA','445-5824890-1','1983-09-17','Soltero/a','LIC.CONTABILIDAD',65000,'Enc. Almacen','2014-01-01',2,3,27,3,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(27,'JUAN MELCIADEZ','225-5555444-6','1989-03-06','Soltero/a','LIC. ADMINISTRACION',50000,'Enc. Despacho','2014-03-03',2,3,27,3,1001,'5');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(28,'YAMILCA HERRY','445-5824890-2','1989-03-06','Soltero/a','LIC. Marketing',35000,'Enc. Marketing','2016-05-30',2,3,27,3,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(29,'MARCOS LANTIGUA','225-5555444-7','1984-07-23','Separado/a','Bachillerato',22000,'Enc. Seguridad','2015-02-09',2,3,27,3,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(30,'HERRY LAUREANO','445-5824890-3','1984-07-23','Separado/a','ADMINISTRACION',38000,'Enc. Seguridad','2014-01-01',2,3,27,3,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(31,'TEOFILO MONTILLA','225-5555444-8','1989-10-16','Separado/a','ADMINISTRACION',36000,'Enc. Auditoria','2016-12-22',2,3,27,3,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(32,'LUSANTI SOTO','123-9874563-0','1998-01-10','Separado/a','Bachillerato',30000,'Chofer','2015-01-01',2,2,21,2,1008,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(33,'MANUEL TEJEDA LEBRON','404-9855490-4','1984-07-23','Separado/a','Bachillerato',22000,'Chofer','2015-11-20',2,2,23,2,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(34,'SANTO MANUEL PEREZ','100-1000000-2','1990-10-16','Casado/a','Bachillerato Tecnico',22000,'Chofer','2015-07-20',	1,3,27,3,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(35,'CARLOS PEREZ PEÑA','100-1000000-2','1990-10-16','Casado/a','Bachillerato Tecnico',18000,'Ayudante Camion','2015-07-20',1,3,27,3,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(36,'JOAN ANTONIO MENDEZ','404-9855490-5','1985-07-23','Separado/a','Bachillerato',18600,'Ayudante Camion','2015-07-20',2,2,25,2,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(37,'JOAQUIN JIMENEZ','100-1000000-3','1991-10-16','Casado/a','Bachillerato Tecnico',18600,'Ayudante Camion','2016-07-07',1,3,27,3,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(38,'JACQUELYNN HUMBLE','404-9855490-5','1985-07-23','Separado/a','LIC. ADMINISTRACION',28000,'Aux. Admin','2017-05-21',1,2,26,2,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(39,'ISABEL VASQUEZ','100-1000000-3','1991-10-16','Casado/a','LIC. ADMINISTRACION',36000,'Compras','2019-02-08',1,3,27,3,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(40,'NOBY NEHLS','125-9855490-5','1973-03-20', 'Soltero','LIC. ADMINISTRACION',38000,'Contabilidad','2020-11-05',1,3,27,3,1001,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(41,'ARLEN GONZALEZ','404-9855490-6','1993-10-05', 'Soltero','LIC. ADMINISTRACION',38000,'Creditos y Cobros','2021-10-10',1,3,27,3,1002,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(42,'BENANCIO ORTEGA','404-9855490-7','1996-03-20', 'Soltero','LIC. ADMINISTRACION',56000,'Produccion','2021-09-26',1,3,27,3,1006,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(43,'OTIS FERGUSSON','404-9855490-8','1990-10-16', 'Soltero','MERDOLOCO',38000,'Promosion','2020-06-23',1,3,27,3,1014,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(44,'GAREK BOTTRELL','404-9855490-9','1996-10-16', 'Casado/a','LIC. ADMINISTRACION',42300,'Enc. Tansportacion','2014-01-01',1,3,27,3,1013,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(45,'EDWARD DE LEON','201-1234567-8','1992-08-16', 'Soltero','Bachillerato',18600,'vendedor','2019-03-28',2,3,31,3,1003,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(46,'TONY GONZALEZ','098-7654321-0','1996-01-16', 'Casado/a','Bachillerato',18600,'vendedor','2018-02-28',2,3,32,3,1003,'1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(47,'ALVARO GONZALEZ','154-7896541-2','1995-01-25', 'Casado/a','Universitario',18600,'vendedor','2021-02-25',2,3,33,3,1003, '1');
INSERT INTO empleados (id_empleados, nombre, cedula, fecha_nacimiento, estado_civil, nivel_academico, sueldo, posicion, fecha_entrada, id_genero,id_region, id_ciudad, id_sucursal, id_departamento,id_status_empleado)
VALUES(48,'LUISA MEDINA','145-7896541-0','2000-01-25', 'Soltero/a','Universitario',18600,'vendedor','2019-02-25',1,3,34,3,1003,'1');

--Seleccionamos la Tabla empleados para ver sus registros.

SELECT * FROM empleados
SELECT * FROM departamento
select * from cliente
select * from genero
select * from region

--Insertamos algunos registros a la tabla clientes:

--CLIENTES REGION ESTE
insert into cliente values (100001,'JUANCITO','PEÑA','SOLUCONESJPV','C/SAN JUAN # 777','809-767-9290','101-1001-001',3);--ESTE
insert into cliente values (100002,'DARIEL','VASQUEZ','JUEGOS_RD','C/JUEGANDO SIEMPRE','809-664-0043','158-512-991',3); --ESTE
insert into cliente values (100003,'LEONEL','GUZMAN','TECNOLO-GUIA','C/NO SE DONDE ES','809-988-8888','211-151-001',3);--ESTE
insert into cliente values (100004,'DANILO','MENTIRA','NOTICIAS-DANILO','C/JUAN Y QUE','809-789-4300','088-852-111',3);--ESTE
insert into cliente values (100005,'ALEXANDER','ARIAS','MOVILES-AA-','C/JOSE AGUSTIN','849-507-1010','101-1001-001',3);--ESTE
insert into cliente values (100006,'ALVARO','ABAD','CVC-TEC','AV.IZABEL AGUIAR','829-444-3494','208-121-191',3);--ESTE
insert into cliente values (100007,'HECTOR','LIRIANO','EMPANADA-BUENAS','C/44 # 56S','809-888-8777','001-001-009',3);--ESTE

--CLIENTES REGION SUR
insert into cliente values (100008,'MILDRED','FEBLES GONZALEZ','RRHH-SOLUCTION','C/ABANICO SUR #44','809-977-3300','222-552-555',2);--SUR
insert into cliente values (100009,'JUAN','MEREJILDO','GABINETES PARA TI-','C/CENTRAL # 25','809-707-2020','202-2002-009',2);--SUR
insert into cliente values (100010,'DULCE','VICTORIANO','TELAS PARA TI','AV.IZABEL AGUIAR','829-444-3494','208-121-191',2);--SUR
insert into cliente values (100011,'QUERALT','VISO GILABERT','CASA CORDELLAS.','AV. SANTIAGO #5','809-977-3301','202-2002-010',2);--SUR
insert into cliente values (100012,'JOAN','AYALA FERRERAS','RK Y M LTDA Y CIA S.EN C.','DOCTOR ESTRELLA #1','809-707-2021','208-121-192',2);--SUR
insert into cliente values (100013,'JHOANA','BAEZ TEJADO','SUMAZARI S.A','C/PRINCIPAL #5','829-444-3495','222-552-557',	2);--SUR

--CLIENTES REGION CIBAO
insert into cliente values (100014,'MARCOS','SOTO JIMENEZ','DISTRIBUIDORA CALYPSO', 'AV. MONUMENTAL # 52','809-888-8779','202-2002-011',1);--CIBAO
insert into cliente values (100015,'JOSEP','AGUILERA VILLA','INVERSIONES Y NEGOCIOS S.A.','CARRETRA PRINCIPAL CIBAO','809-977-3302','208-121-193',1);--CIBAO
insert into cliente values (100016,'ESTHER','PASCUAL ALOY','LINHAMDAN ARBOLEDA & COMPANIA S.A','AV. JUAN PABLO DUARTE','809-707-2022','222-552-558',1);--CIBAO
insert into cliente values (100017,'LAURA','VALLEJO GUTIERRES','INVERSIONES VIENA S.A.','AV. JOSE MARTI','829-444-3496','202-2002-012',1);--CIBAO
insert into cliente values (100018,'RAQUEL','RAMIREZ GARCIA','PAPELRIA CORPOTIVA.S.A.','AV. FEDERICO BASILIS',	'809-888-8780','208-121-194',1);--CIBAO
insert into cliente values (100019,'LOURDES','MENDEZ','ZAPATOS Y MAS CALIDAD','AV. SIEMPRE VIDA','829-444-3497','202-2002-013',1);--CIBAO
insert into cliente values (100020,'SOFIA','GUARDIA BELEN','LENCERIA TODO SEXY','AV. SIEMPRE DE NOCHE','809-888-8781','208-121-195',1);--CIBAO

--CLIENTES REGION CIBAO
insert into cliente values (100021,'BAYDEN','AMILCAR GUERRA','SOLUCIONES WEB.','AV. FRANCISCO PEÑA','809-111-2565','108-444-222',1);--CIBAO
insert into cliente values (100022,'JUANITA','MARTINEZ','NOTICAS MUNDIALES','AV. NOTICIAS PARA TI # 52','809-444-4444','222-211-222',1);--CIBAO
insert into cliente values (100023,'YENNIFER','LOMBARDER','MODELOS MUNDIALES','AV. MEJOR BESTIDO','809-777-8988','002-333-2222',1);--CIBAO

--CLIENTES REGION ESTE
insert into cliente values (100024,'RAQUEL','GARCIA RAMIREZ','CONSTRUCCIONES RD.','AV. ESPAÑA # 55',	'809-888-8780','208-121-194',2);--CIBAO
insert into cliente values (100025,'GLORIA','BENEGAS','HELADOS SABROSOS RD','AV. SIEMPRE VIDA','829-444-3497','202-2002-013',2);--CIBAO
insert into cliente values (100026,'MILDRED','BATISTA GUERRA','COMEDOR BUEN PROVECHO','AV. SIEMPRE DE NOCHE','809-888-8781','208-121-195',2);--CIBAO
insert into cliente values (100027,'FRANCIA','ITALIA BENECIA','PAPELRIA CORPOTIVA.S.A.','AV. FEDERICO BASILIS',	'809-888-8780','208-121-194',2);--CIBAO

--CLIENTES REGION SUR
insert into cliente values (100028,'JESUS','MARTE GUTIERRES','RESTAURANTE JESUS','AV. SIEMPRE VIDA','829-444-3497','202-2002-013',3);--CIBAO
insert into cliente values (100029,'VLADIMIR','UCRANIA KIEV','AGUA PURA RD','AV. SIEMPRE DE NOCHE','809-888-8781','208-121-195',3);--CIBAO
insert into cliente values (100030,'SALVADOR','SALCEDO SALVA','SUPERMERCADO SALVADOR','AV. SIEMPRE DE NOCHE','809-888-8781','208-121-195',3);--CIBAO

--seleccionamos la tabla para ver como ha quedado:
select * from cliente

select * from cliente where id_region='3'
select * from cliente where id_region='2'
select * from cliente where id_region='1'

select * from region

--Insertamos algunos registros a la tabla Categoria Producto:

insert into categoria_producto values (1101,'TELEFONOS');
insert into categoria_producto values (1102,'LAPTOPS');
insert into categoria_producto values (1103,'TABLETS');
insert into categoria_producto values (1104,'ACCESORIOS');
insert into categoria_producto values (1105,'CONSOLAS');
insert into categoria_producto values (1106,'SMART TV');
insert into categoria_producto values (1107,'PC DESKTOP');

--seleccionamos la tabla para ver como ha quedado:

select * from categoria_producto

--AQUI ME HE EQUIVOCADO, Y HE PUESTO TELEFONO EN VEZ DE CELULARES O MOVILES

UPDATE categoria_producto SET descripcion='SMARTPHONE' WHERE id_categoria='1101';

--seleccionamos la tabla para ver como ha quedado:

select * from categoria_producto
select * from productos

--INSERTAMOS ALGUNOS PRODUCTOS 1- SMART PHONE:

insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (100,'IPHONE X','20','36000','45000','01-11-2020','1101');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (101,'Samsung Galaxy S9+','15','33600','42000','11-05-2020','1101');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (102,'OnePlus 8 Pro','10','24000','30000','11-06-2020','1101');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (103,'Galaxy Note 10 Plus','10','28000','35000','11-01-2020','1101');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (104,'Huawei P20 Pro','10','32000','40000','11-03-2020','1101');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (105,'Xperia X Performance','10','20000','25000','11-01-2020','1101');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (106,'ZTE Blade V8','10','20000','25000','11-02-2020','1101');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (107,'Pixel 4 XL ','10','17600','22000','11-04-2020','1101');

--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='1101'

--INSERTAMOS ALGUNOS PRODUCTOS 2-LAPTOPS
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (108,'ASUS K52JT','10','20000','25000','11-01-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (109,'HP Envy 13','10','30320','37901','03-06-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (110,'Huawei MateBook X Pro','30','88720','110901','10-04-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (112,'Honor MagicBook 14','10','25648','32061','19-05-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (113,'Acer Swift 5 (SF514-54T)','10','29648','37061','19-05-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (114,'Asus ZenBook S13','10','65407','81759','05-05-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (115,'Lenovo Yoga C740','10','42000','52501','19-10-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (116,'Microsoft Surface Laptop 3','25','40178','50223','10-05-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (117,'MacBook Air','10','42000','52501','29-05-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (118,'Lenovo YOGA 920','10','51344','64181','17-05-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (119,'Lenovo IdeaPAD','10','55970','69963','10-04-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (120,'Dell XPS','10','22424','28031','29-05-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (121,'HP Pavilion 360','10','61343','76679','10-03-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (122,'Acer Chromebook','10','23359','29199','10-03-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (123,'MSI GF63 THIN','25','18688','23360','10-02-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (124,'Surface Book 2','10','51391','64239','17-02-2020','1102');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (125,'Toshiba Portege','10','62090','77613','10-01-2020','1102');


--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='1102'
 
--INSERTAMOS ALGUNOS PRODUCTOS 3-TABLETS
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (126,'iPad de 10,2','10','15370','19213','10-05-2020','1103');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (127,'Samsung Galaxy Tab S5e','10','18640','23301','19-01-2020','1103');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (128,'Microsoft Surface Pro 6','10','32656','40821','22-02-2020','1103');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (129,'Huawei MatePad Pro','10','25648','32061','10-01-2020','1103');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (130,'iPad mini (2019)','10','24714','30893','10-01-2020','1103');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (131,'Amazon Fire HD 8','10','3736','4671','10-01-2020','1103');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (132,'Huawei MediaPad M5 de 8.4','10','18688','23360','20-03-2020','1103');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (133,'Onyx Boox Note2','10','25695','32119','23-04-2020','1103');


--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='1103'

--INSERTAMOS ALGUNOS PRODUCTOS 4-ACCESORIOS

insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (134,'Teclado Mars Gaming MKXTKL','50','1498','1873','24-06-2020','1104');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (135,'Teclado Gaming, WisFox ','50','1760','2200','21-06-2020','1104');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (136,'OHQ Ratón ZERODATE X300GY','50','680','850','2-06-2020','1104');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (137,'Cheekbonny Auriculares Gaming ','50','1560','1950','28-06-2020','1104');

--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='1104'


--INSERTAMOS ALGUNOS PRODUCTOS 5-CONSOLAS
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (138,'Nintendo GameCube','10','3135','3919','15-11-2017','1105');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (139,'Nintendo 64','10','13440','16800','25-06-2017','1105');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (140,'Nintendo Switch','10','17382','21728','08-01-2018','1105');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (141,'PSP','10','5376','6720','25-01-2016','1105');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (142,'Xbox 360','10','6496','8120','16-08-2019','1105');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (143,'PlayStation 3','10','90004','101256','23-03-2016','1105');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (144,'Wii','10','8736','10920','19-09-2019','1105');


select * from Productos 
select * from Productos where id_categoria ='1105'

--INSERTAMOS ALGUNOS PRODUCTOS 6-SMART-TV
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (145,'Samsung Smart Tv Full Hd 32 Pulgadas','10','11192','13990','17-10-2020','1106');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (146,'Televisores Smar Tv TCL 40 Pulgadas','10','10800','13500','18-10-2020','1106');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (147,'TV 50" LED SMART FULL HD 3D LT50DA950 JVC','10','15600','18990','17-10-2017','1106');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (148,'LG Smart TV  50 PULGADAS','10','15600','19500','18-10-2016','1106');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (149,'Hisense 43" Class 4K UHD LED Roku Smart TV HDR 43R6E1','10','13592','16990','17-10-2016','1106');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (150,'Sony Televisión LED 40″ Smart TV W40A16T-SM','10','14000','17500','15-10-2019','1106');


select * from Productos 
select * from Productos where id_categoria ='1106'



--INSERTAMOS ALGUNOS PRODUCTOS PC DESKTOP:
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (151,'HP Omen Obelisk','20','48650','50400','21/02/2016','1107');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (152,'Apple iMac 5K (2019)','20','90200','100800','21/02/2019','1107');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (153,'Adamant Ryzen Threadripper','20','350000','370680','21/02/2020','1107');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (154,'Dell G5 Gaming','20','49200','52080','21/02/2019','1107');


insert into Productos (id_producto, descripcion, existencia, precio_compra,precio_ventas,fecha_entrada, id_categoria)values (157,'Samsung Smart Tv Full Hd 32 Pulgadas','10','11192','13990','2020-11-01','1106');
insert into Productos (id_producto, descripcion, existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (158,'Televisores Smar Tv Tcl 40 Pulgadas','10','10800','13500','2020-11-01','1106');


select * from Productos
select * from Productos where id_categoria ='1106'
select * from categoria_producto


--Para borrar la tabla producto o vaciarla.	
--truncate table vendedor
--drop table vendedor

select * from empleados

select * from ciudad
select * from supervisor
select * from genero
select * from vendedor
select * from cliente where id_region ='3'
select * from region

select * from empleados
--Insertamos algunos registros a la tabla vendedor:

--VENDEDORES DEL CIBAO:
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados, id_cliente, id_supervisor, id_genero)
VALUES(1,'CESAR MELENDEZ',1,1,1,100014,1,2);--Región Norte o Cibao
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(2,'ANTONIO PEREZ',2,1,2,100015,1,2);--Región Norte o Cibao
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados, id_cliente,id_supervisor, id_genero)
VALUES(3,'CRISTOPHER MENDEZ',3,1,3,100016,1,2);--Región Norte o Cibao
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(4,'ULTIMO FERNADEZ',4,1,4,100017,1,2);--Región Norte o Cibao
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados, id_cliente,id_supervisor, id_genero)
VALUES(5,'MARTES JIMENEZ',5,1,5,100018,1,2);--Región Norte o Cibao
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(6,'ENAMUEL JIMENEZ',6,1,6,100019,1,2);--Región Norte o Cibao
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados, id_cliente,id_supervisor, id_genero)
VALUES(7,'TINA GUTIERREZ',7,1,7,100020,1,2);--Región Norte o Cibao	
	
--VENDEDORES DEL SUROESTE:
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(8,'SATURNINO BRAVO',15,2,6,100008,2,2);--Región Suroeste
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(9,'ALONZO DE LOS SANTOS',16,2,9,100009,2,2);--Región Suroeste
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(10,'MARITIN MARTINEZ',17,2,10,100010,2,2);--Región Suroeste
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(11,'FRANCELIS NUÑEZ VIDAL',18,2,11,100011,2,1);--Región Suroeste
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(12,'JESUS DE DIOS DE LOS SANTOS',19,2,12,100012,2,2);--Región Suroeste
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(13,'JOSE ANTONIO MENDEZ',26,2,13,100013,2,2);--Región Suroeste


--VENDEDORES DEL SURESTE:
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(14,'NICOLAS PAULINO',27,3,14,100001,3,2);--Región Sureste
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente,id_supervisor, id_genero)
VALUES(15,'LUZ ANTONIA PRIETO',28,3,15,100002,3,1);--Región Sureste
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente,id_supervisor, id_genero)
VALUES(16,'MIGUEL HERRERA',29,3,16,100003,3,2);--Región Sureste
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(17,'NACHALINE  PEÑA',30,3,17,100004,3,1);--Región Sureste
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(18,'LUISA MEDINA',31,3,18,100005,3,1);--Región Sureste
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(19,'EDWARD DE LEON',32,3,19,100006,3,2);--Región Sureste
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(20,'ALVARO GONZALEZ',33,3,20,100007,3,2);--Región Sureste
INSERT INTO vendedor (id_vendedor, nombre_vendedor, id_ciudad,id_region,id_empleados,id_cliente, id_supervisor, id_genero)
VALUES(21,'TONY GONZALEZ',3,3,46,100020,3,1);--Región Sureste



select * from cliente

--INSERTAMOS LOS DATOS EN LA TABLA:

 insert into Fotos_supervisor values ('1','https://dl.dropbox.com/s/smhzpzub1wzw6ae/A5.png','1','2','1');
 insert into Fotos_supervisor values ('2','https://dl.dropbox.com/s/ov3t5g3xt8wm8zg/A29.png','2','1','2');
 insert into Fotos_supervisor values ('3','https://dl.dropbox.com/s/qzrph6s50mlqdju/A7.png','3','2','3');

 select * from supervisor

 --SELECCIONAR LA TABLA FOTOS DE Fotos_supervisor:

SELECT * FROM Fotos_supervisor


--INSERTAMOS LOS DATOS EN LA TABLA:

select * from Fotos_vendedor

--VENDEDORES DE LA REGION 1 Y VENDEDOR 1:

insert into Fotos_vendedor values ('1','https://dl.dropbox.com/s/4bz1xriny7ro04g/A40.png','2','1','1');
insert into Fotos_vendedor values ('2','https://dl.dropbox.com/s/d9iqy5tjormmhrk/A36.png','2','1','1');
insert into Fotos_vendedor values ('3','https://dl.dropbox.com/s/0jkab8w6ie0h91z/A42.png','2','1','1');
insert into Fotos_vendedor values ('4','https://dl.dropbox.com/s/o6rn2hd5t9878fy/A6.png','2','1','1');
insert into Fotos_vendedor values ('5','https://dl.dropbox.com/s/zgx7g0h0mxubhao/A21.png','2','1','1');
insert into Fotos_vendedor values ('6','https://dl.dropbox.com/s/em8slkr3sf6nu9e/A9.png','2','1','1');
insert into Fotos_vendedor values ('7','https://dl.dropbox.com/s/1f9hzgblcmuen4a/A10.png','2','1','1');

--VENDEDORES DE LA REGION 2 Y VENDEDOR 2:

insert into Fotos_vendedor values ('8','https://dl.dropbox.com/s/jveyj0btov87izo/A38.png','1','2','2');
insert into Fotos_vendedor values ('9','https://dl.dropbox.com/s/27oq7ocj4q8a0z8/A46.png','1','2','2');
insert into Fotos_vendedor values ('10','https://dl.dropbox.com/s/z4geyw1u2psmm47/A16.png','2','2','2');
insert into Fotos_vendedor values ('11','https://dl.dropbox.com/s/t9ghnd2zm5a3ecw/A18.png','2','2','2');
insert into Fotos_vendedor values ('12','https://dl.dropbox.com/s/yxe96df3xrzoc4y/A44.png','1','2','2');
insert into Fotos_vendedor values ('13','https://dl.dropbox.com/s/aufyj7zngfnd2yo/A20.png','2','2','2');

--VENDEDORES DE LA REGION 3 Y VENDEDOR 3:

insert into Fotos_vendedor values ('14','https://dl.dropbox.com/s/2lks10yyiurw2b0/A33.png','1','3','3');
insert into Fotos_vendedor values ('15','https://dl.dropbox.com/s/id0gj57k6z3m73q/A34.png','1','3','3');
insert into Fotos_vendedor values ('16','https://dl.dropbox.com/s/6llc8tyg69dkwk2/A28.png','2','3','3');
insert into Fotos_vendedor values ('17','https://dl.dropbox.com/s/p71u7ozjv6b5xxk/A17.png','2','3','3');
insert into Fotos_vendedor values ('18','https://dl.dropbox.com/s/1kpn9jrkaoo7fkq/A47.png','2','3','3');
insert into Fotos_vendedor values ('19','https://dl.dropbox.com/s/3x1q6p167szkg19/A49.png','2','3','3');
insert into Fotos_vendedor values ('20','https://dl.dropbox.com/s/xnimxsc4d2ie02f/A50.png','2','3','3');


--SELECCIONAR LA TABLA FOTOS DE VENDEDOR:

SELECT * FROM Fotos_vendedor



--INSERTAMOS LOS DATOS EN LA TABLA, INSERTAMOS 7 DE EJEMPLOS LOS DEMAS LO IMPORTAMOS POR EXCEL:

--INSERTAMOS FOTOS DE ALGUNOS PRODUCTOS 1-SMARTPHONE

insert into Fotos_productos values ('100','https://www.noticias3d.com/imagenes/noticias/201801/apple-iphone-x-new-1.jpg','1101')
insert into Fotos_productos values ('101','https://m.media-amazon.com/images/I/61UDrA6RtTL._AC_SL1500_.jpg','1101')
insert into Fotos_productos values ('102','https://ss7.vzw.com/is/image/VerizonWireless/pdp-samsung-star2-feature1-d-0218?$pngalpha$&scl=2','1101')
insert into Fotos_productos values ('103','https://m.media-amazon.com/images/I/61+8N2S1iYL._AC_SL1500_.jpg','1101')
insert into Fotos_productos values ('104','https://m.media-amazon.com/images/I/61z8ytoOVoL._AC_SL1000_.jpg','1101')
insert into Fotos_productos values ('105','https://m.media-amazon.com/images/I/71RJCEvmkTL._AC_SL1500_.jpg','1101')
insert into Fotos_productos values ('106','https://m.media-amazon.com/images/I/61qEv-Kn-HL._AC_SX679_.jpg','1101')
insert into Fotos_productos values ('107','https://m.media-amazon.com/images/I/91sCsb5CtlL._AC_SL1500_.jpg','1101')

--INSERTAMOS FOTOS DE ALGUNOS PRODUCTOS 2-LAPTOPS
insert into Fotos_productos values ('108','https://images-na.ssl-images-amazon.com/images/I/81q31rMsvxL._AC_SL1500_.jpg	','1102')
insert into Fotos_productos values ('109','https://cdn.shopify.com/s/files/1/1700/9937/products/i_01_hero_slide_1_tcm195_2610847_tcm195_2610945_tcm195-2610847_93517eea-314d-434d-9454-cb232ff0bd03.png?v=1549804116','1102')
insert into Fotos_productos values ('110','https://img01.huaweifile.com/sg/ms/co/pms/product/6972453162595/428_428_47A779F71741A81F49628CFE9BD848B5C9A019E895F75E73mp.png','1102')
insert into Fotos_productos values ('111','https://www.laptop6.com//products/Dell_5.png','1102')
insert into Fotos_productos values ('112','https://img01.honorfile.com/eu/uk/honor/pms/product/6901443375097/group/428_428_4AE2096582F9DB01D1683BF9380535D8B91D1BCDD0EE356A.png	','1102')
insert into Fotos_productos values ('113','https://i0.wp.com/laptopmedia.com/wp-content/uploads/2019/10/3-15-e1575304158983.png?fit=1500%2C922&ssl=1','1102')
insert into Fotos_productos values ('114','https://i0.wp.com/laptopmedia.com/wp-content/uploads/2019/08/3-6-e1565952368118.png?fit=1455%2C907&ssl=1','1102')
insert into Fotos_productos values ('115','https://home.ripley.com.pe/Attachment/WOP_5/2004227989276/2004227989276_2.jpg','1102')
insert into Fotos_productos values ('116','https://http2.mlstatic.com/D_NQ_NP_719584-MLA41976150702_052020-O.jpg','1102')
insert into Fotos_productos values ('117','https://thegoodguys.sirv.com/products/50070551/50070551_692922.PNG?scale.height=505&scale.width=773&canvas.height=505&canvas.width=773&canvas.opacity=0&q=90','1102')
insert into Fotos_productos values ('118','https://static.turbosquid.com/Preview/001233/361/UV/lenovo-yoga-920-3D-model_D.jpg','1102')
insert into Fotos_productos values ('119','https://static.lenovo.com/na/subseries/hero/lenovo-ideapad-s340-14-intel-blacklit-noglass-hero.png','1102')
insert into Fotos_productos values ('120','https://static.wixstatic.com/media/7e78cb_1788138a64a14aeb80f5eca0229dafd5~mv2.png/v1/fill/w_480,h_320,al_c,q_90,usm_0.66_1.00_0.01/7e78cb_1788138a64a14aeb80f5eca0229dafd5~mv2.webp','1102')
insert into Fotos_productos values ('121','https://images-na.ssl-images-amazon.com/images/I/81Bu7RhFsiL._AC_SX466_.jpg','1102')
insert into Fotos_productos values ('122','https://www.notebookcheck.org/uploads/tx_nbc2/acerC720_01.png','1102')
insert into Fotos_productos values ('123','https://www.notebookcheck.net/uploads/tx_nbc2/2001688273_04.png','1102')
insert into Fotos_productos values ('124','https://static.turbosquid.com/Preview/001220/545/Q6/realistic-microsoft-surface-book-3D-model_600.jpg','1102')
insert into Fotos_productos values ('125','https://es.dynabook.com/contents/es_ES/SERIES_GROUP_DESCRIPTION/images/img_portege-z30.png','1102')

select * from Productos where id_producto='126'

--INSERTAMOS FOTOS DE ALGUNOS PRODUCTOS 3-TABLETS

select * from Fotos_productos

insert into Fotos_productos values ('126','https://m.media-amazon.com/images/I/91RicPoj7vL._AC_SY679_.jpg','1103')
insert into Fotos_productos values ('127','https://ghost-armor.com/media/catalog/product/cache/f9b262cccfc4db316b94156ff62f9953/g/a/galaxy_tab_s5e.png','1103')
insert into Fotos_productos values ('128','https://www.windowscentral.com/sites/wpcentral.com/files/field/image/2018/10/hp-spectre-x2-png-01.png?itok=W-_A5PBm','1103')
insert into Fotos_productos values ('129','https://shop.intertecqatar.com/wp-content/uploads/2020/07/Huawei-MatePad-Pro-4G-8GB-256GB.png','1103')
insert into Fotos_productos values ('130','https://i.pinimg.com/originals/92/89/21/928921eaffd204e48d1d6a97b9601534.png	','1103')
insert into Fotos_productos values ('131','https://d2b8wt72ktn9a2.cloudfront.net/mediocre/image/upload/c_pad,f_auto,dpr_2.0,h_368,q_auto,w_368/ngzbnakllepwmeygito7.png	','1103')
insert into Fotos_productos values ('132','https://i.blogs.es/6b64d1/huawei/450_1000.png','1103')
insert into Fotos_productos values ('133','https://goodereader.com/blog/uploads/images/Note2-5.png','1103')

--INSERTAMOS FOTOS DE ALGUNOS PRODUCTOS 4-ACCESORIOS
insert into Fotos_productos values ('134','https://es.marsgaming.eu/uploads/_thumnails/mk215_640x400.png','1104')
insert into Fotos_productos values ('135','https://deyoutubers.org/wp-content/uploads/2019/08/deyoutubers_0004_Capa-16-390x200.png	','1104')
insert into Fotos_productos values ('136','https://images-na.ssl-images-amazon.com/images/I/61Ut6vEquYL._AC_SX522_.jpg','1104')
insert into Fotos_productos values ('137','https://m.media-amazon.com/images/I/71ykajUoClL._AC_UL320_.jpg','1104')

--INSERTAMOS FOTOS DE ALGUNOS PRODUCTOS 5-CONSOLAS

insert into Fotos_productos values ('138','https://mediamaster.vandal.net/i/620x347/8-2018/201883013462_2.jpg','1105')
insert into Fotos_productos values ('139','https://mediamaster.vandal.net/i/620x333/3-2020/20203516234973_4.jpg	','1105')
insert into Fotos_productos values ('140','https://mediamaster.vandal.net/i/620x351/3-2020/20203616987_1.jpg','1105')
insert into Fotos_productos values ('141','https://mediamaster.vandal.net/i/620x349/3-2020/20203516234973_11.jpg','1105')
insert into Fotos_productos values ('142','https://mediamaster.vandal.net/i/620x521/3-2020/20203516234973_13.jpg','1105')
insert into Fotos_productos values ('143','https://mediamaster.vandal.net/i/620x565/3-2020/20203516234973_14.jpg','1105')
insert into Fotos_productos values ('144','https://mediamaster.vandal.net/i/620x366/3-2020/20203616125028_1.jpg	','1105')

--INSERTAMOS FOTOS DE ALGUNOS PRODUCTOS 6-SMART-TV

insert into Fotos_productos values ('145','https://www.grupomastertech.pe/wp-content/uploads/2019/08/TV.png	','1106')
insert into Fotos_productos values ('146','https://images.samsung.com/is/image/samsung/mx_UN32J4300AFXZX_001_Front_indigo-blue?$L1-Thumbnail$','1106')
insert into Fotos_productos values ('147','https://www.tcl.com/content/dam/tcl-dam/product/tv-product/a-series/a323-mx/site/pc/product-image/TCL-32A323-01.png','1106')
insert into Fotos_productos values ('148','https://http2.mlstatic.com/televisor-aiwa-55-pulgadas-aw55b4k-smart-4k-uhd-led-D_NQ_NP_979374-MLV41093876595_032020-F.jpg','1106')
insert into Fotos_productos values ('149','https://www.giztele.com/wp-content/uploads/2017/05/Sony-KDL32RE400BAEP-portada.png','1106')
insert into Fotos_productos values ('150','https://i.pinimg.com/originals/2e/da/c9/2edac90e17153cf0ec0de31d344ba87e.png','1106')

--INSERTAMOS FOTOS DE ALGUNOS PRODUCTOS PC DESKTOP:

insert into Fotos_productos values ('151','https://www.hp.com/nz/en/images/Group_106_tcm194_2670529_tcm194_2670617_tcm194-2670529.png','1107')
insert into Fotos_productos values ('152','https://res-5.cloudinary.com/grover/image/upload/e_trim/c_limit,f_auto,fl_png8.lossy,h_1280,q_auto,w_1280/v1554375584/m3b3ercywosecypibvzx.png','1107')
insert into Fotos_productos values ('153','https://m.media-amazon.com/images/I/71aJhPg7cKL._AC_SS450_.jpg','1107')
insert into Fotos_productos values ('154','https://subrayado.com.mx/wp-content/uploads/2020/11/PC-Buen-Fin-2020.jpg','1107')

insert into Fotos_productos values ('157','https://m.media-amazon.com/images/I/91UsHjAPTlL._AC_SL1500_.jpg','1106')
insert into Fotos_productos values ('158','https://m.media-amazon.com/images/I/71mTUwgs9hL._AC_SL1500_.jpg','1106')


--IMAGENES DE FOTO CATEGORIA:

insert into Foto_categoria_producto values ('1','https://cdn.icon-icons.com/icons2/1498/PNG/512/smarphone_103433.png','1101')
insert into Foto_categoria_producto values ('2','https://cdn.icon-icons.com/icons2/1852/PNG/512/iconfinder-rootaccess-4417096_116625.png','1102')
insert into Foto_categoria_producto values ('3','https://cdn.icon-icons.com/icons2/1520/PNG/512/tabletipadflat_105992.png','1103')
insert into Foto_categoria_producto values ('4','https://st.depositphotos.com/2656329/3911/v/950/depositphotos_39113981-stock-illustration-mobile-phone-accessories-icon-set.jpg','1104')
insert into Foto_categoria_producto values ('5','https://cdn.icon-icons.com/icons2/1633/PNG/512/52761videogame_109402.png','1105')
insert into Foto_categoria_producto values ('6','https://cdn.icon-icons.com/icons2/1875/PNG/512/smarttv_119955.png','1106')
insert into Foto_categoria_producto values ('7','https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Desktop-PC.svg/1024px-Desktop-PC.svg.png','1107')

--seleccionamos la tabla para ver como ha quedado:

select * from Foto_categoria_producto

 select * from  Fotos_productos

 select * from  productos
 
--INSERTAMOS ALGUNAS condiecion_factura 
insert into condicion_factura values (1,'Efectivo');
insert into condicion_factura values (2,'Cheque');
insert into condicion_factura values (3,'Transferencia');
insert into condicion_factura values (4,'Deposito');
insert into condicion_factura values (5,'Credito');

--truncate table condiecion_factura
	
--INSERTAMOS ALGUNAS dias_factura 

insert into dias_factura values (1,1);
insert into dias_factura values (2,15);
insert into dias_factura values (3,30);
insert into dias_factura values (4,60);
insert into dias_factura values (5,90);
insert into dias_factura values (6,120);

select * from condicion_factura
select * from dias_factura
select * from Ventas_Hechos
select * from vendedor


--INSERTAMOS DATOS DENTRO DE LA TABLA VENTAS_HECHOS CON LOS REGISTROS SIGUIENTES:
	
--VENTAS 2016
SELECT * FROM Ventas_Hechos
insert into Ventas_Hechos values (1,25001,'01-01-2016',1,1,3,100016,'100',1,'45000',1,3);
insert into Ventas_Hechos values (2,25002,'04-01-2016',5,2,8,100008,'101',3,'42000',2,15);
insert into Ventas_Hechos values (3,25003,'05-01-2016',1,1,8,100008,'102',1,'30000',2,15);
insert into Ventas_Hechos values (4,25004,'06-01-2016',1,1,3,100016,'100',1,'45000',1,3);
insert into Ventas_Hechos values (5,25005,'05-02-2016',1,1,3,100016,'100',1,'45000',1,3);

insert into Ventas_Hechos values (6,25006,'17-02-2016',5,2,8,100008,'105',1,'25000',2,15);
insert into Ventas_Hechos values (7,25007,'08-03-2016',1,1,19,100006,'106',2,'25000',3,32);
insert into Ventas_Hechos values (8,25008,'29-03-2016',2,3,10,100010,'107',1,'22000',2,17);
insert into Ventas_Hechos values (9,25009,'11-04-2016',2,2,5,100018,'108',1,'25000',1,5);
insert into Ventas_Hechos values (10,25010,'28-04-2016',3,1,2,100015,'109',1,'37901',1,2);
insert into Ventas_Hechos values (11,25011,'03-05-2016',3,1,5,100018,'110',1,'110901',1,5);
insert into Ventas_Hechos values (12,25012,'1-05-2016',4,1,6,100019,'111',5,'61261',1,6);

insert into Ventas_Hechos values (13,25013,'25-05-2016',3,1,18,100005,'112',1,'32061',3,31);
insert into Ventas_Hechos values (14,25014,'30-05-2016',1,1,14,100001,'113',2,'37061',3,27);
insert into Ventas_Hechos values (15,25015,'15-06-2016',4,1,14,100001,'114',2,'81759',3,27);
insert into Ventas_Hechos values (16,25016,'27-06-2016',5,3,15,100004,'115',4,'52501',3,29);
insert into Ventas_Hechos values (17,25017,'13-07-2016',4,1,8,100008,'116',1,'50223',2,15);
insert into Ventas_Hechos values (18,25018,'29-07-2016',4,1,1,100014,'117',1,'52501',1,1);
insert into Ventas_Hechos values (19,25019,'08-08-2016',1,1,15,100004,'118',5,'64181',3,28);
insert into Ventas_Hechos values (20,25020,'29-08-2016',3,1,9,100009,'119',1,'69963',2,16);
insert into Ventas_Hechos values (21,25021,'05-09-2016',3,1,10,100010,'120',1,'28031',2,17);
insert into Ventas_Hechos values (22,25022,'30-09-2016',2,2,4,100017,'121',1,'76679',1,4);
insert into Ventas_Hechos values (23,25023,'05-10-2016',1,1,15,100002,'122',5,'29199',3,28);
insert into Ventas_Hechos values (24,25024,'10-10-2016',1,1,14,100001,'123',1,'23360',3,27);
insert into Ventas_Hechos values (25,25025,'18-10-2016',2,2,14,100001,'124',2,'64239',3,32);
insert into Ventas_Hechos values (26,25026,'28-11-2016',5,3,20,100007,'125',2,'77613',3,33);
insert into Ventas_Hechos values (27,25027,'30-11-2016',4,1,3,100016,'126',1,'19213',1,3);
insert into Ventas_Hechos values (28,25028,'30-11-2016',1,1,13,100013,'127',1,'23301',2,26);
insert into Ventas_Hechos values (29,25029,'01-12-2016',4,1,3,100016,'128',1,'40821',1,3);
insert into Ventas_Hechos values (30,25030,'15-12-2016',3,1,6,100019,'129',1,'32061',1,6);
insert into Ventas_Hechos values (31,25031,'20-12-2016',5,2,14,100001,'130',2,'30893',3,27);
insert into Ventas_Hechos values (32,25032,'24-12-2016',3,1,14,100001,'131',2,'4671',3,27);
insert into Ventas_Hechos values (33,25033,'25-12-2016',5,4,19,100006,'132',1,'23360',3,32);
insert into Ventas_Hechos values (34,25034,'30-12-2016',4,1,15,100004,'133',5,'32119',3,28);

select * from Ventas_Hechos where fecha_venta >= '2016-01-01' and fecha_venta <= '2016-12-31' --and id_region='3'
order by id_ventas asc

select * from Productos
--VENTAS 2017

insert into Ventas_Hechos values (35,25035,'08-01-2017',4,1,18,100005,'134',1,'1873',3,31);
insert into Ventas_Hechos values (36,25036,'28-01-2017',3,1,8,100008,'135',1,'2200',2,15);
insert into Ventas_Hechos values (37,25037,'18-02-2017',2,2,15,100004,'136',5,'850',3,28);
insert into Ventas_Hechos values (38,25038,'28-02-2017',3,1,15,100004,'137',4,'1950',3,28);
insert into Ventas_Hechos values (39,25039,'13-03-2017',4,1,18,100005,'138',1,'3919',3,31);
insert into Ventas_Hechos values (40,25040,'14-03-2017',3,1,8,100008,'139',1,'16800',2,15);
insert into Ventas_Hechos values (41,25041,'19-04-2017',3,1,8,100008,'140',3,'21728',2,15);
insert into Ventas_Hechos values (42,25042,'29-04-2017',2,2,1,100014,'141',1,'6720',1,1);
insert into Ventas_Hechos values (43,25043,'05-05-2017',4,1,15,100002,'142',5,'8120',3,28);
insert into Ventas_Hechos values (44,25044,'28-05-2017',3,1,2,100015,'143',1,'112512',1,2);--
insert into Ventas_Hechos values (45,25045,'06-06-2017',5,3,14,100001,'100',2,'45000',3,27);
insert into Ventas_Hechos values (46,25046,'28-06-2017',1,1,2,100015,'101',1,'25000',1,2);--
insert into Ventas_Hechos values (47,25047,'17-07-2017',5,2,14,100001,'102',2,'30000',3,27);
insert into Ventas_Hechos values (48,25048,'28-07-2017',4,1,14,100001,'103',2,'35000',3,27);
insert into Ventas_Hechos values (49,25049,'17-08-2017',4,1,14,100001,'104',1,'40000',3,27);
insert into Ventas_Hechos values (50,25050,'28-08-2017',5,2,20,100007,'105',2,'25000',3,33);
insert into Ventas_Hechos values (51,25051,'30-08-2017',5,3,17,100004,'105',2,'25000',3,30);
insert into Ventas_Hechos values (52,25052,'01-09-2017',4,1,15,100002,'106',5,'25000',3,28);
insert into Ventas_Hechos values (53,25053,'29-09-2017',5,2,14,100001,'107',2,'22000',3,27);
insert into Ventas_Hechos values (54,25054,'05-10-2017',1,1,14,100001,'108',2,'25000',3,27);
insert into Ventas_Hechos values (55,25055,'15-10-2017',5,3,14,100001,'109',2,'37901',3,27);
insert into Ventas_Hechos values (56,25056,'29-10-2017',1,1,14,100001,'110',2,'110901',3,27);
insert into Ventas_Hechos values (57,25057,'06-11-2017',5,3,4,100017,'111',1,'61261',1,4);
insert into Ventas_Hechos values (58,25058,'19-11-2017',2,3,1,100014,'133',1,'32119',1,1);
insert into Ventas_Hechos values (59,25059,'25-11-2017',5,2,4,100017,'134',1,'1873',1,4);
insert into Ventas_Hechos values (60,25060,'30-11-2017',3,1,15,100004,'135',4,'2200',3,28);
insert into Ventas_Hechos values (61,25061,'05-12-2017',4,1,14,100001,'136',2,'850',3,27);
insert into Ventas_Hechos values (62,25062,'10-12-2017',4,1,15,100004,'137',4,'1950',3,27);
insert into Ventas_Hechos values (63,25063,'12-12-2017',4,1,14,100001,'138',2,'3919',3,27);
insert into Ventas_Hechos values (64,25064,'15-12-2017',1,1,17,100004,'139',5,'16800',3,30);
insert into Ventas_Hechos values (65,25065,'17-12-2017',2,2,19,100006,'140',1,'21728',3,32);
insert into Ventas_Hechos values (66,25066,'18-12-2017',3,1,19,100006,'141',1,'6720',3,32);
insert into Ventas_Hechos values (67,25067,'22-12-2017',4,1,19,100006,'142',1,'8120',3,32);
insert into Ventas_Hechos values (68,25068,'24-12-2017',1,1,19,100006,'143',1,'112512',3,32);
insert into Ventas_Hechos values (69,25069,'30-12-2017',1,1,15,100004,'144',1,'10920',3,28);
insert into Ventas_Hechos values (70,25070,'30-12-2017',1,1,19,100006,'145',2,'13990',3,32);

select * from Ventas_Hechos where fecha_venta >= '2017-01-08' and fecha_venta <= '2017-12-31'  --and id_region='3'
order by fecha_venta asc


--VENTAS 2018

insert into Ventas_Hechos values (71,25071,'01-01-2018',1,1,7,'100020','150',1,'17500',1,7);
insert into Ventas_Hechos values (72,25072,'01-02-2018',1,1,6,'100019','150',1,'17500',1,6);
insert into Ventas_Hechos values (73,25073,'02-03-2018',2,2,7,'100020','150',1,'17500',1,7);
insert into Ventas_Hechos values (74,25074,'02-04-2018',2,2,7,'100020','150',1,'17500',1,7);
insert into Ventas_Hechos values (75,25075,'03-05-2018',1,1,5,'100018','149',1,'16990',1,5);
insert into Ventas_Hechos values (76,25076,'04-06-2018',1,1,4,'100017','149',1,'16990',1,4);
insert into Ventas_Hechos values (77,25077,'05-07-2018',3,1,1,'100014','149',1,'16990',1,1);
insert into Ventas_Hechos values (78,25078,'06-08-2018',3,1,2,'100015','148',1,'13500',1,2);
insert into Ventas_Hechos values (79,25079,'07-09-2018',4,1,1,'100014','148',1,'13500',1,1);
insert into Ventas_Hechos values (80,25080,'08-10-2018',1,1,6,'100019','147',1,'18990',1,6);
insert into Ventas_Hechos values (81,25081,'09-11-2018',1,1,7,'100020','144',1,'10920',1,7);
insert into Ventas_Hechos values (82,25082,'10-12-2018',5,2,6,'100019','144',1,'10920',1,6);
insert into Ventas_Hechos values (83,25083,'24-12-2018',1,1,6,'100019','144',1,'10920',1,6);
insert into Ventas_Hechos values (84,25084,'30-12-2018',1,1,5,'100018','144',1,'10920',1,5);


select * from Ventas_Hechos where fecha_venta >= '2018-01-01' and fecha_venta <= '2018-12-31' --and id_region='3'
order by fecha_venta asc



--VENTAS 2019

insert into Ventas_Hechos values (85,25085,'05-01-2019',3,1,8,'100008','111',1,'61261',2,15);
insert into Ventas_Hechos values (86,25086,'28-02-2019',1,1,8,'100008','111',1,'61261',2,15);
insert into Ventas_Hechos values (87,25087,'03-03-2019',1,1,9,'100009','116',1,'50223',2,16);
insert into Ventas_Hechos values (88,25088,'04-03-2019',3,1,9,'100009','116',1,'50223',2,16);
insert into Ventas_Hechos values (89,25089,'05-04-2019',1,1,10,'100010','123',1,'23360',2,17);
insert into Ventas_Hechos values (90,25090,'06-05-2019',2,2,20,'100007','123',1,'23360',3,33);
insert into Ventas_Hechos values (91,25091,'06-06-2019',1,1,20,'100007','123',1,'23360',3,33);
insert into Ventas_Hechos values (92,25092,'07-07-2019',1,1,8,'100008','110',1,'110901',2,15);
insert into Ventas_Hechos values (93,25093,'08-08-2019',1,1,8,'100008','110',1,'110901',2,15);
insert into Ventas_Hechos values (94,25094,'09-09-2019',2,3,9,'100009','110',1,'110901',2,16);
insert into Ventas_Hechos values (95,25095,'10-10-2019',1,1,10,'100010','110',1,'110901',2,17);
insert into Ventas_Hechos values (96,25096,'11-11-2019',1,1,13,'100013','100',1,'45000',2,26);
insert into Ventas_Hechos values (97,25097,'12-12-2019',3,1,12,'100012','100',1,'45000',2,19);
insert into Ventas_Hechos values (98,25098,'30-12-2019',1,1,11,'100011','100',1,'45000',2,18);

select * from Ventas_Hechos where fecha_venta >= '2019-01-01' and fecha_venta <= '2019-12-31' order by fecha_venta asc


--VENTAS 2020 

insert into Ventas_Hechos values (99,25099,'01-01-2020',1,1,14,'100001','111',1,'61261',3,27);
insert into Ventas_Hechos values (100,25100,'04-01-2020',1,1,15,'100002','111',1,'61261',3,28);
insert into Ventas_Hechos values (101,25101,'05-01-2020',1,1,16,'100003','116',1,'50223',3,29);
insert into Ventas_Hechos values (102,25102,'30-01-2020',1,1,17,'100004','116',1,'50223',3,30);
insert into Ventas_Hechos values (103,25103,'03-02-2020',1,1,18,'100005','123',1,'23360',3,31);
insert into Ventas_Hechos values (104,25104,'28-02-2020',1,1,14,'100001','111',1,'61261',3,27);
insert into Ventas_Hechos values (105,25105,'04-03-2020',1,1,15,'100002','111',1,'61261',3,28);
insert into Ventas_Hechos values (106,25106,'05-04-2020',1,1,10,'100010','116',1,'50223',2,17);
insert into Ventas_Hechos values (107,25107,'28-04-2020',1,1,11,'100011','116',1,'50223',2,18);
insert into Ventas_Hechos values (108,25108,'01-05-2020',1,1,12,'100012','123',1,'23360',2,19);
insert into Ventas_Hechos values (109,25109,'30-05-2020',1,1,14,'100001','111',1,'61261',3,27);
insert into Ventas_Hechos values (110,25110,'01-06-2020',1,1,15,'100002','111',1,'61261',3,28);
insert into Ventas_Hechos values (111,25111,'30-06-2020',1,1,16,'100003','116',1,'50223',3,29);
insert into Ventas_Hechos values (112,25112,'08-07-2020',1,1,14,'100001','111',1,'61261',3,27);
insert into Ventas_Hechos values (113,25113,'30-07-2020',1,1,15,'100002','111',1,'61261',3,28);
insert into Ventas_Hechos values (114,25114,'09-08-2020',1,1,16,'100003','116',1,'50223',3,29);
insert into Ventas_Hechos values (115,25115,'28-08-2020',1,1,17,'100004','116',1,'50223',3,30);
insert into Ventas_Hechos values (116,25116,'10-09-2020',1,1,18,'100005','123',1,'23360',3,31);
insert into Ventas_Hechos values (117,25117,'29-09-2020',1,1,8,'100008','123',2,'23360',2,15);
insert into Ventas_Hechos values (118,25118,'01-10-2020',1,1,7,'100020','150',1,'17500',1,7);
insert into Ventas_Hechos values (119,25119,'28-10-2020',1,1,9,'100009','123',3,'23360',2,16);
insert into Ventas_Hechos values (120,25120,'11-11-2020',1,1,10,'100010','110',2,'110901',2,17);
insert into Ventas_Hechos values (121,25121,'30-11-2020',1,1,11,'100011','110',4,'110901',2,18);
insert into Ventas_Hechos values (122,25122,'05-12-2020',5,3,12,'100012','110',2,'110901',2,19);
insert into Ventas_Hechos values (123,25123,'10-12-2020',1,1,1,'100014','110',1,'110901',1,1);
insert into Ventas_Hechos values (124,25124,'15-12-2020',1,1,2,'100015','100',1,'45000',1,2);
insert into Ventas_Hechos values (125,25125,'24-12-2020',3,1,5,'100018','100',1,'45000',1,5);
insert into Ventas_Hechos values (126,25126,'30-12-2020',1,1,7,'100020','100',1,'45000',1,7);

select * from Ventas_Hechos where fecha_venta >= '2020-01-01' and fecha_venta <= '2020-12-31' order by fecha_venta asc

--VENTAS 2021

insert into Ventas_Hechos values (127,25127,'02-01-2021',1,1,14,'100001','111',1,'61261',3,27);
insert into Ventas_Hechos values (128,25128,'05-01-2021',1,1,15,'100002','111',1,'61261',3,28);
insert into Ventas_Hechos values (129,25129,'15-01-2021',1,1,16,'100003','116',1,'50223',3,29);
insert into Ventas_Hechos values (130,25130,'20-01-2021',1,1,17,'100004','116',1,'50223',3,30);
insert into Ventas_Hechos values (131,25131,'31-01-2021',1,1,18,'100005','123',1,'23360',3,31);
insert into Ventas_Hechos values (132,25132,'01-02-2021',1,1,14,'100001','111',1,'61261',3,27);
insert into Ventas_Hechos values (133,25133,'28-02-2021',1,1,15,'100002','111',1,'61261',3,28);
insert into Ventas_Hechos values (134,25134,'05-03-2021',1,1,16,'100003','116',1,'50223',3,29);
insert into Ventas_Hechos values (135,25135,'28-03-2021',1,1,17,'100004','116',1,'50223',3,30);
insert into Ventas_Hechos values (136,25136,'06-04-2021',1,1,18,'100005','123',1,'23360',3,31);
insert into Ventas_Hechos values (137,25137,'28-04-2021',1,1,14,'100001','111',1,'61261',3,27);
insert into Ventas_Hechos values (138,25138,'03-04-2021',1,1,15,'100002','111',1,'61261',3,28);
insert into Ventas_Hechos values (139,25139,'30-05-2021',1,1,16,'100003','116',1,'50223',3,29);
insert into Ventas_Hechos values (140,25140,'03-05-2021',1,1,14,'100001','111',1,'61261',3,27);
insert into Ventas_Hechos values (141,25141,'29-05-2021',1,1,15,'100002','111',1,'61261',3,28);
insert into Ventas_Hechos values (142,25142,'03-05-2021',1,1,16,'100003','116',1,'50223',3,29);
insert into Ventas_Hechos values (143,25143,'27-06-2021',1,1,17,'100004','116',1,'50223',3,30);
insert into Ventas_Hechos values (144,25144,'03-06-2021',1,1,18,'100005','123',1,'23360',3,31);
insert into Ventas_Hechos values (145,25145,'22-06-2021',1,1,8,'100008','123',2,'23360',2,15);
insert into Ventas_Hechos values (146,25146,'04-06-2021',1,1,9,'100009','123',3,'23360',2,16);
insert into Ventas_Hechos values (147,25147,'26-06-2021',1,1,10,'100010','110',2,'110901',2,17);
insert into Ventas_Hechos values (148,25148,'27-06-2021',1,1,11,'100011','110',4,'110901',2,18);
insert into Ventas_Hechos values (149,25149,'28-06-2021',5,3,12,'100012','110',2,'110901',2,19);
insert into Ventas_Hechos values (150,25150,'04-07-2021',1,1,1,'100014','110',1,'110901',1,1);
insert into Ventas_Hechos values (151,25151,'01-07-2021',1,1,2,'100015','100',1,'45000',1,2);
insert into Ventas_Hechos values (152,25152,'02-07-2021',3,1,5,'100018','100',1,'45000',1,5);
insert into Ventas_Hechos values (153,25153,'02-07-2021',1,1,7,'100020','100',1,'45000',1,7);
insert into Ventas_Hechos values (154,25154,'2021-05-16',1,1,7,'100020','100',1,'45000',1,7);
insert into Ventas_Hechos values (155,25155,'2021-05-16',5,3,14,'100028','147',1,'15600',3,30);
insert into Ventas_Hechos values (156,25156,'2021-05-25',5,2,15,'100029','148',3,'15600',3,31);
insert into Ventas_Hechos values (157,25157,'2021-06-05',5,3,18,'100030','149',2,'13592',3,32);
insert into Ventas_Hechos values (158,25158,'2021-07-16',1,1,19,'100028','150',5,'14000',3,30);
insert into Ventas_Hechos values (159,25159,'2021-07-30',5,3,18,'100029','151',2,'48650',3,31);
insert into Ventas_Hechos values (160,25160,'2021-08-29',1,1,19,'100030','153',5,'350000',3,32);
insert into Ventas_Hechos values (159,25159,'2021-05-22',5,3,11,'100011','153',1,'370680',2,18);
insert into Ventas_Hechos values (160,25160,'2021-05-25',5,2,11,'100011','154',3,'52080',2,18);
insert into Ventas_Hechos values (161,25161,'2021-06-03',5,3,13,'100013','152',2,'100800',2,26);
insert into Ventas_Hechos values (162,25162,'2021-06-16',1,1,13,'100013','151',5,'50400',2,26);
insert into Ventas_Hechos values (163,25163,'2021-06-20',1,1,14,'100001','134',10,'61261',3,27);
insert into Ventas_Hechos values (164,25164,'2021-06-25',1,1,15,'100002','135',10,'61261',3,28);
insert into Ventas_Hechos values (165,25165,'2021-06-30',1,1,16,'100003','136',10,'50223',3,29);
insert into Ventas_Hechos values (166,25166,'2021-07-02',1,1,17,'100004','137',10,'50223',3,30);


select * from Ventas_Hechos where fecha_venta >= '2021-07-02' and fecha_venta <= '2021-07-02'
order by fecha_venta asc


--TAREA PARA ÚSTEDES (REGISTRAR O INSERTAR LAS VENTAS 2021--TAREA DE USTEDES, 
--HACER LAS VENTAS DE LO QUE QUEDA DE AÑO 2021 HASTA DICIMENRE:2021, RECORDAR RESPETAR REGION,
--CLIENTE, PROVINCIAS.










select * from Ventas_Hechos



--TAREA PARA ÚSTEDES (REGISTRAR O INSERTAR LAS VENTAS 2022--
--TAREA DE USTEDES, HACER LAS VENTAS DE LO QUE VA DE AÑO 2022: 
--:2021, RECORDAR RESPETAR REGION, CLIENTE, PROVINCIAS.











--INSERTAMOS LOS DATOS CON FECHA EN ESPAÑOL AÑO 2016:

insert into Estatus_Facturas values (1,'1/3/2016',1,25001,'100016','45000',1,'si');
insert into Estatus_Facturas values (2,'15/1/2016',2,25002,'100008','126000',15,'si');
insert into Estatus_Facturas values(3,'26/1/2016',3,25003,'100008','30000',1,'si');
insert into Estatus_Facturas values(4,'19/2/2016',4,25004,'100016','45000',1,'si');
insert into Estatus_Facturas values(5,'17/4/2016',6,25006,'100008','25000',15,'no');
insert into Estatus_Facturas values(6,'8/5/2016',7,25007,'100006','50000',1,'si');
insert into Estatus_Facturas values(7,'10/5/2016',8,25008,'100010','22000',30,'si');
insert into Estatus_Facturas values(8,'11/5/2016',9,25009,'100018','25000',15,'si');
insert into Estatus_Facturas values(9,'05/5/2016',5,25005,'100016','45000',1,'si');
insert into Estatus_Facturas values(10,'03/6/2016',11,25011,'100018','110901',1,'si');
insert into Estatus_Facturas values(11,'6/6/2016',12,25012,'100019','306305',1,'si');
insert into Estatus_Facturas values(12,'18/6/2016',10,25010,'100015','37901',1,'si');
insert into Estatus_Facturas values(13,'07/07/2016',13,25013,'100005','32061',1,'si');
insert into Estatus_Facturas values(14,'07/8/2016',14,25014,'100001','74122',1,'si');
insert into Estatus_Facturas values(15,'02/08/2016',15,25015,'100001','163518',1,'si');
insert into Estatus_Facturas values(16,'09/08/2016',19,25019,'100004','320905',1,'si');
insert into Estatus_Facturas values(17,'08/08/2016',17,25017,'100008','50223',1,'si');
insert into Estatus_Facturas values(18,'18/08/2016',18,25018,'100014','52501',1,'si');
insert into Estatus_Facturas values(19,'18/08/2016',16,25016,'100004','210004',30,'si');
insert into Estatus_Facturas values(20,'15/10/2016',22,25022,'100017','76679',15,'si');
insert into Estatus_Facturas values(21,'13/09/2016',21,25021,'100010','28031',1,'si');
insert into Estatus_Facturas values(22,'22/09/2016',20,25020,'100009','69963',1,'si');
insert into Estatus_Facturas values(23,'16/10/2016',24,25024,'100001','23360',1,'si');
insert into Estatus_Facturas values(24,'18/10/2016',23,25023,'100002','145995',1,'si');
insert into Estatus_Facturas values(25,'28/10/2016',25,25025,'100001','128478',15,'si');
insert into Estatus_Facturas values(26,'28/12/2016',26,25026,'100007','155226',30,'si');
insert into Estatus_Facturas values(27,'01/12/2016',27,25027,'100016','19213',1,'si');
insert into Estatus_Facturas values(28,'01/12/2016',28,25028,'100013','23301',1,'si');
insert into Estatus_Facturas values(29,'02/12/2016',29,25029,'100016','40821',1,'si');
insert into Estatus_Facturas values(30,'16/12/2016',30,25030,'100019','32061',1,'si');
insert into Estatus_Facturas values(31,'05/01/2017',31,25031,'100001','61786',15,'no');
insert into Estatus_Facturas values(32,'25/12/2016',32,25032,'100001','9342',1,'si');
insert into Estatus_Facturas values(33,'28/12/2016',33,25033,'100006','23360',60,'no');
insert into Estatus_Facturas values(34,'30/12/2016',34,25034,'100004','160595',1,'si');

--INSERTAMOS LOS DATOS CON FECHA EN ESPAÑOL AÑO 2017:.

insert into Estatus_Facturas values(35,'08/01/2017',35,25035,'100005','1873',1,'si');
insert into Estatus_Facturas values(36,'28/01/2017',36,25036,'100008','2200',1,'si');
insert into Estatus_Facturas values(37,'18/02/2017',37,25037,'100004','4250',15,'si');
insert into Estatus_Facturas values(38,'28/02/2017',38,25038,'100004','7800',1,'si');
insert into Estatus_Facturas values(39,'13/03/2017',39,25039,'100005','3919',1,'si');
insert into Estatus_Facturas values(40,'14/03/2017',40,25040,'100008','16800',1,'si');
insert into Estatus_Facturas values(41,'15/05/2017',42,25042,'100014','6720',15,'si');
insert into Estatus_Facturas values(42,'19/04/2017',41,25041,'100008','65184',1,'si');
insert into Estatus_Facturas values(43,'29/05/2017',44,25044,'100015','11256',1,'si');
insert into Estatus_Facturas values(44,'28/05/2017',43,25043,'100002','40600',1,'si');
insert into Estatus_Facturas values(45,'28/06/2017',45,25045,'100001','90000',30,'si');
insert into Estatus_Facturas values(46,'19/07/2017',46,25047,'100001','60000',15,'no');
insert into Estatus_Facturas values(47,'28/07/2017',47,25046,'100015','25000',1,'si');
insert into Estatus_Facturas values(48,'11/08/2017',48,25048,'100001','70000',1,'si');
insert into Estatus_Facturas values(49,'17/08/2017',49,25049,'100001','40000',1,'si');
insert into Estatus_Facturas values(50,'16/09/2017',50,25050,'100007','50000',15,'si');
insert into Estatus_Facturas values(51,'16/09/2017',51,25051,'100004','50000',30,'no');
insert into Estatus_Facturas values(52,'17/09/2017',52,25052,'100002','125000',1,'si');
insert into Estatus_Facturas values(53,'28/10/2017',53,25053,'100001','44000',15,'no');
insert into Estatus_Facturas values(54,'28/10/2017',54,25054,'100001','50000',1,'si');
insert into Estatus_Facturas values(55,'28/10/2017',55,25055,'100001','75802',30,'no');
insert into Estatus_Facturas values(56,'03/11/2017',56,25056,'100001','221802',1,'si');
insert into Estatus_Facturas values(57,'06/11/2017',57,25057,'100017','61261',30,'si');
insert into Estatus_Facturas values(58,'19/11/2017',58,25058,'100014','32119',30,'no');
insert into Estatus_Facturas values(59,'02/12/2017',59,25059,'100017','1873',15,'si');
insert into Estatus_Facturas values(60,'03/12/2017',60,25060,'100004','8800',1,'si');
insert into Estatus_Facturas values(61,'09/12/2017',61,25061,'100001','1700',1,'si');
insert into Estatus_Facturas values(62,'11/12/2017',62,25062,'100004','7800',1,'si');
insert into Estatus_Facturas values(63,'12/12/2017',63,25063,'100001','7838',1,'si');
insert into Estatus_Facturas values(64,'16/12/2017',64,25064,'100004','84000',1,'si');
insert into Estatus_Facturas values(65,'17/12/2017',65,25065,'100006','21728',15,'si');
insert into Estatus_Facturas values(66,'18/12/2017',66,25066,'100006','6720',1,'si');
insert into Estatus_Facturas values(67,'23/12/2017',67,25067,'100006','8120',1,'si');
insert into Estatus_Facturas values(68,'25/12/2017',68,25068,'100006','11256',1,'si');
insert into Estatus_Facturas values(69,'31/12/2017',69,25069,'100004','10920',1,'si');
insert into Estatus_Facturas values(70,'30/12/2017',70,25070,'100006','27980',1,'si');

--INSERTAMOS LOS DATOS CON FECHA EN ESPAÑOL AÑO 2018:

insert into Estatus_Facturas values(71,'02/01/2018',71,25071,'100020','17500',1,'si');
insert into Estatus_Facturas values(72,'14/02/2018',72,25072,'100019','17500',1,'si');
insert into Estatus_Facturas values(73,'17/03/2018',73,25073,'100020','17500',15,'si');
insert into Estatus_Facturas values(74,'17/04/2018',74,25074,'100020','17500',15,'no');
insert into Estatus_Facturas values(75,'04/05/2018',75,25075,'100018','16990',1,'si');
insert into Estatus_Facturas values(76,'05/06/2018',76,25076,'100017','16990',1,'si');
insert into Estatus_Facturas values(77,'06/07/2018',77,25077,'100014','16990',1,'si');
insert into Estatus_Facturas values(78,'09/08/2018',78,25078,'100015','13500',1,'si');
insert into Estatus_Facturas values(79,'08/09/2018',79,25079,'100014','13500',1,'si');
insert into Estatus_Facturas values(80,'09/10/2018',80,25080,'100019','18990',1,'si');
insert into Estatus_Facturas values(81,'10/11/2018',81,25081,'100020','10920',1,'si');
insert into Estatus_Facturas values(82,'25/12/2018',82,25082,'100019','10920',15,'si');
insert into Estatus_Facturas values(83,'25/12/2018',83,25083,'100019','10920',1,'si');
insert into Estatus_Facturas values(84,'31/12/2018',84,25084,'100018','10920',1,'si');

--INSERTAMOS LOS DATOS CON FECHA EN ESPAÑOL AÑO 2019:

insert into Estatus_Facturas values(85,'16/01/2019',85,25085,'100008','61261',1,'si');
insert into Estatus_Facturas values(86,'28/02/2019',86,25086,'100008','61261',1,'si');
insert into Estatus_Facturas values(87,'30/03/2019',87,25087,'100009','50223',1,'si');
insert into Estatus_Facturas values(88,'30/04/2019',88,25088,'100009','50223',1,'si');
insert into Estatus_Facturas values(89,'25/05/2019',89,25089,'100010','23360',1,'si');
insert into Estatus_Facturas values(90,'29/06/2019',90,25090,'100007','23360',15,'no');
insert into Estatus_Facturas values(91,'30/06/2019',91,25091,'100007','23360',1,'si');
insert into Estatus_Facturas values(92,'15/07/2019',92,25092,'100008','110901',1,'si');
insert into Estatus_Facturas values(93,'16/08/2019',93,25093,'100008','110901',1,'si');
insert into Estatus_Facturas values(94,'28/09/2019',94,25094,'100009','110901',30,'si');
insert into Estatus_Facturas values(95,'12/10/2019',95,25095,'100010','110901',1,'si');
insert into Estatus_Facturas values(96,'22/11/2019',96,25096,'100013','45000',1,'si');
insert into Estatus_Facturas values(97,'23/12/2019',97,25097,'100012','45000',1,'si');
insert into Estatus_Facturas values(98,'31/12/2019',98,25098,'100011','45000',1,'si');

--INSERTAMOS LOS DATOS CON FECHA EN ESPAÑOL AÑO 2020:

insert into Estatus_Facturas values(99,'16/01/2020',99,25099,'100001','61261',1,'si');
insert into Estatus_Facturas values(100,'29/01/2020',100,25100,'100002','61261',1,'si');
insert into Estatus_Facturas values(101,'27/02/2020',101,25101,'100003','50223',1,'si');
insert into Estatus_Facturas values(102,'28/02/2020',102,25102,'100004','50223',1,'si');
insert into Estatus_Facturas values(103,'25/03/2020',103,25103,'100005','23360',1,'si');
insert into Estatus_Facturas values(104,'16/04/2020',104,25104,'100001','61261',1,'si');
insert into Estatus_Facturas values(105,'29/04/2020',105,25105,'100002','61261',1,'si');
insert into Estatus_Facturas values(106,'25/04/2020',106,25108,'100005','23360',1,'si');
insert into Estatus_Facturas values(107,'30/05/2020',107,25106,'100003','50223',1,'si');
insert into Estatus_Facturas values(108,'30/05/2020',108,25107,'100004','50223',1,'si');
insert into Estatus_Facturas values(109,'16/06/2020',109,25109,'100001','61261',1,'si');
insert into Estatus_Facturas values(110,'29/06/2020',110,25110,'100002','61261',1,'si');
insert into Estatus_Facturas values(111,'30/06/2020',111,25111,'100003','50223',1,'si');
insert into Estatus_Facturas values(112,'16/08/2020',112,25112,'100001','61261',1,'si');
insert into Estatus_Facturas values(113,'29/09/2020',113,25113,'100002','61261',1,'si');
insert into Estatus_Facturas values(114,'30/09/2020',114,25114,'100003','50223',1,'si');
insert into Estatus_Facturas values(115,'30/09/2020',115,25115,'100004','50223',1,'si');
insert into Estatus_Facturas values(116,'25/10/2020',116,25116,'100005','23360',1,'si');
insert into Estatus_Facturas values(117,'29/10/2020',117,25117,'100008','46720',1,'si');
insert into Estatus_Facturas values(118,'30/10/2020',118,25118,'100020','17500',1,'si');
insert into Estatus_Facturas values(119,'30/10/2020',119,25119,'100009','70080',1,'si');
insert into Estatus_Facturas values(120,'15/11/2020',120,25120,'100010','221802',1,'si');
insert into Estatus_Facturas values(121,'02/12/2020',121,25121,'100011','443604',1,'si');
insert into Estatus_Facturas values(122,'30/01/2021',122,25122,'100012','221802',30,'si');
insert into Estatus_Facturas values(123,'11/12/2020',123,25123,'100014','110901',1,'si');
insert into Estatus_Facturas values(124,'16/12/2020',124,25124,'100015','45000',1,'si');
insert into Estatus_Facturas values(125,'25/12/2020',125,25125,'100018','45000',1,'si');
insert into Estatus_Facturas values(126,'31/12/2020',126,25126,'100020','45000',1,'si');

--INSERTAMOS LOS DATOS CON FECHA EN ESPAÑOL AÑO 2021:

insert into Estatus_Facturas values(127,'05/01/2021',127,25127,'100001','61261',1,'si');
insert into Estatus_Facturas values(128,'09/01/2021',128,25128,'100002','61261',1,'si');
insert into Estatus_Facturas values(129,'16/01/2021',129,25129,'100003','50223',1,'si');
insert into Estatus_Facturas values(130,'20/01/2021',130,25130,'100004','50223',1,'si');
insert into Estatus_Facturas values(131,'02/02/2021',131,25131,'100005','23360',1,'si');
insert into Estatus_Facturas values(132,'03/02/2021',132,25132,'100001','61261',1,'si');
insert into Estatus_Facturas values(133,'01/03/2021',133,25133,'100002','61261',1,'si');
insert into Estatus_Facturas values(134,'06/03/2021',134,25134,'100003','50223',1,'si');
insert into Estatus_Facturas values(135,'29/03/2021',135,25135,'100004','50223',1,'si');
insert into Estatus_Facturas values(136,'07/04/2021',136,25136,'100005','23360',1,'si');
insert into Estatus_Facturas values(137,'29/04/2021',137,25137,'100001','61261',1,'si');
insert into Estatus_Facturas values(138,'04/04/2021',138,25138,'100002','61261',1,'si');
insert into Estatus_Facturas values(139,'31/05/2021',139,25139,'100003','50223',1,'si');
insert into Estatus_Facturas values(140,'04/05/2021',140,25140,'100001','61261',1,'si');
insert into Estatus_Facturas values(141,'30/05/2021',141,25141,'100002','61261',1,'si');
insert into Estatus_Facturas values(142,'04/05/2021',142,25142,'100003','50223',1,'si');
insert into Estatus_Facturas values(143,'28/06/2021',143,25143,'100004','50223',1,'si');
insert into Estatus_Facturas values(144,'04/06/2021',144,25144,'100005','23360',1,'si');
insert into Estatus_Facturas values(145,'23/06/2021',145,25145,'100008','46720',1,'si');
insert into Estatus_Facturas values(146,'05/06/2021',146,25146,'100009','70080',1,'si');
insert into Estatus_Facturas values(147,'27/06/2021',147,25147,'100010','221802',1,'si');
insert into Estatus_Facturas values(148,'28/06/2021',148,25148,'100011','443604',1,'si');
insert into Estatus_Facturas values(149,'28/07/2021',149,25149,'100012','221802',30,'no');
insert into Estatus_Facturas values(150,'05/07/2021',150,25150,'100014','110901',1,'si');
insert into Estatus_Facturas values(151,'02/07/2021',151,25151,'100015','45000',1,'si');
insert into Estatus_Facturas values(152,'03/07/2021',152,25152,'100018','45000',1,'si');
insert into Estatus_Facturas values(153,'03/07/2021',153,25153,'100020','45000',1,'si');

--VENTAS NUEVAS 2021 MEDIADOS:
insert into Estatus_Facturas values(154,'16/05/2021',154,25154,'100020','45000',1,'si');
insert into Estatus_Facturas values(155,'16/05/2021',155,25155,'100028','15600',3,'no');
insert into Estatus_Facturas values(156,'25/05/2021',156,25156,'100029','46800',2,'si');
insert into Estatus_Facturas values(157,'05/06/2021',157,25157,'100030','27184',3,'no');
insert into Estatus_Facturas values(158,'16/07/2021',158,25158,'100028','70000',1,'si');


--VENTAS NUEVAS 2021 MEDIADOS:

insert into Estatus_Facturas values(159,'22/05/2021',159,25159,'100011','97300',3,'si');
insert into Estatus_Facturas values(160,'25/05/2021',160,25160,'100011','1000000',1,'no');
insert into Estatus_Facturas values(161,'03/06/2021',161,25161,'100013','201600',3,'si');
insert into Estatus_Facturas values(162,'16/06/2021',162,25162,'100013','152000',1,'no');
insert into Estatus_Facturas values(163,'20/06/2021',163,25163,'100001','612610',1,'si');
insert into Estatus_Facturas values(164,'25/06/2021',164,25164,'100002','500000',1,'no');
insert into Estatus_Facturas values(165,'30/06/2021',165,25165,'100003','502230',1,'si');
insert into Estatus_Facturas values(166,'02/07/2021',166,25166,'100004','300000',1,'no');


--SELECCIONAMOS LA TABLA PARA VER LOS DATOS:

select * from Estatus_Facturas 


SELECT * FROM VENTAS_HECHOS

--ESTATUS DE COBROS--
--TAREA DE USTEDES, HACER LOS COBROS DEL LAS VENTAS QUE AGREGUEN
--EN EL 2021 HASTA DICIMBRE Y DE LO QUE VA DE AÑO 2022: 








--INSERTAMOS DATOS EN LA TABLA Metas_Ventas_Anual


insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (1,1,1,'2016-01-01','2016-12-31',800000); 
insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (2,2,2,'2016-01-01','2016-12-31',350000); 
insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (3,3,3,'2016-01-01','2016-12-31',165000); 

insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (4,1,1,'2017-01-01','2017-12-31',256485); 
insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (5,2,2,'2017-01-01','2017-12-31',350000); 
insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (6,3,3,'2017-01-01','2017-12-31',165000); 

insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (7,1,1,'2018-01-01','2018-12-31',210640); 
insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (8,2,2,'2018-01-01','2018-12-31',350000); 
insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (9,3,3,'2018-01-01','2018-12-31',165000); 

insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (10,1,1,'2019-01-01','2019-12-31',0); 
insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (11,2,2,'2019-01-01','2019-12-31',350000); 
insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (12,3,3,'2019-01-01','2019-12-31',165000); 

insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (13,1,1,'2020-01-01','2020-12-31',263401); 
insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (14,2,2,'2020-01-01','2020-12-31',350000); 
insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (15,3,3,'2020-01-01','2020-12-31',165000); 

insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (16,1,1,'2021-01-01','2021-12-31',290901); 
insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (17,2,2,'2021-01-01','2021-12-31',350000); 
insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (18,3,3,'2021-01-01','2021-12-31',165000); 

insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (19,1,1,'2022-01-01','2022-12-31',800000); 
insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (20,2,2,'2022-01-01','2022-12-31',350000); 
insert into Metas_Ventas_Anual (id_meta, id_sucursal,id_region,fecha_inicio,fecha_corte, monto) values (21,3,3,'2022-01-01','2022-12-31',165000); 
  

SELECT * FROM Metas_Ventas_Anual



--CREAR UN PROCEDIMIENTOS ALMACENADO PARA INSERTAR PRODUCTOS SIN QUE ESTEN REPETIDOS COMO CODIGO O DESCRIPCION.

SELECT * FROM Productos
CREATE OR ALTER PROCEDURE SP_INSERTAR_PRODCTOS
@id_producto int,
@descripcion varchar(100),
@existencia int,
@precio_compra int,
@precio_venta int,
@fecha_entrada date,
@id_categoria int
as 
declare @total int --contar las cantidades en el resultado.
select @total = count(id_producto) from Productos where id_producto= @id_producto or descripcion = @descripcion
if(@total <1) --Si no se encuentran resultados es decir 0 valor.
	begin 
		insert into Productos values (@id_producto,@descripcion,@existencia,@precio_compra,@precio_venta,@fecha_entrada,@id_categoria)
	end
else 
	begin
		--print('El Articulo Ya se encuentra en la Tabla Productos')
		print('El Producto con el Codigo' + ' ' + CAST(@id_producto AS VARCHAR) +  + ' y con el Nombre: ' + @descripcion +  + ' '  +'Ya se encuentra en la Tabla de Productos')

	end


	
	
--finalizado

--PROBAMOS AHORA VIENDO NUESTRA TABLA DE PRODUCTOS.

SELECT * FROM Productos

--INSERTAMOS UN PRODUCTO Y LO VALIDAMOS:
exec SP_INSERTAR_PRODCTOS 158,'PRUEBA REPETIDA ','10','14451','16451','03-09-2022','1104';
exec SP_INSERTAR_PRODCTOS 160,'PRUEBA insercion','10','8736','10920','19-09-2019','1105';


--CREAR UN PROCEDIMIENTOS ALMACENADO PARA ELIMINAR PRODUCTOS QUE YA SE ENCUENTREN BORRRADOS CON VALIDACION DEL CODIGO 

CREATE OR ALTER PROCEDURE SP_ELIMINAR_PRODUCTO
@id_producto int
AS
BEGIN
    IF EXISTS (SELECT * FROM Productos WHERE id_producto = @id_producto)
    BEGIN
        DELETE FROM Productos WHERE id_producto = @id_producto
        PRINT 'Producto eliminado correctamente.'
    END
    ELSE
    BEGIN
        PRINT 'No se encontró el producto con el ID especificado.'
    END
END


--ELIMINAMOS UN PRODUCTO Y LO VALIDAMOS CON EL CODIGO:

exec SP_ELIMINAR_PRODUCTO 160
exec SP_ELIMINAR_PRODUCTO 170

select * from productos


--CREAR UN PROCEDIMIENTOS ALMACENADO PARA ELIMINAR PRODUCTOS QUE YA SE ENCUENTREN BORRRADOS CON VALIDACION DEL CODIGO O DESCRIPCION.

CREATE OR ALTER PROCEDURE SP_ELIMINAR_PRODUCTOS
@id_producto int,
@descripcion varchar(100)
as 
declare @total int --contar las cantidades en el resultado.
select @total = count(id_producto) from Productos where id_producto= @id_producto or descripcion = @descripcion
if(@total > 0) --Si se encuentran resultados es decir, hay al menos 1 valor.
	begin 
		delete from Productos where id_producto = @id_producto or descripcion = @descripcion
        print('El Producto con el Codigo' + ' ' + CAST(@id_producto AS VARCHAR) +  + ' y con el Nombre: ' + @descripcion +  + ' '  +'Ha sido eliminado correctamente de la Tabla de Productos')
	end
else 
	begin
		print('El Producto con el Codigo' + ' ' + CAST(@id_producto AS VARCHAR) +  + ' y con el Nombre: ' + @descripcion +  + ' '  +'No se encuentra en la Tabla de Productos')
	end

--ELIMINAMOS UN PRODUCTO Y LO VALIDAMOS CON EL CODIGO Y DESCRIPCION:

exec SP_ELIMINAR_PRODUCTOS 160,'PRUEBA REPETIDA';
exec SP_ELIMINAR_PRODUCTOS 168,'PRUEBA VALIDA';

select * from productos

/*
--CREAR UN PROCEDIMIENTOS ALMACENADO PARA ACTUALIZAR EL PRODUCTOS QUE YA 
SE ENCUENTREN BORRRADOS CON VALIDACION DEL CODIGO O DESCRIPCION.

*/

CREATE OR ALTER PROCEDURE SP_ACTUALIZAR_PRODUCTO
@id_producto int,
@descripcion varchar(100),
@existencia int,
@precio_compra int,
@precio_ventas int,
@fecha_entrada date,
@id_categoria int
AS 
BEGIN
	IF EXISTS(SELECT 1 FROM Productos WHERE id_producto = @id_producto)
	BEGIN
		UPDATE Productos
		SET descripcion = @descripcion,
			existencia = @existencia,
			precio_compra = @precio_compra,
			precio_ventas = @precio_ventas,
			fecha_entrada = @fecha_entrada,
			id_categoria = @id_categoria
		WHERE id_producto = @id_producto;
	END
	ELSE
	BEGIN
		PRINT 'El producto con el código ' + CAST(@id_producto AS varchar) + ' no existe en la tabla Productos.';
	END
END

select * from Productos
/*
Puedes ejecutar este procedimiento almacenado con la siguiente sintaxis, reemplazando los valores de
los parámetros según los datos que quieras actualizar:

*/

EXEC SP_ACTUALIZAR_PRODUCTO 
	@id_producto = 166,
	@descripcion = 'PRUEBA ACTUALIZADA',
	@existencia = 20,
	@precio_compra = 100,
	@precio_ventas = 200,
	@fecha_entrada = '2022-03-15',
	@id_categoria = 1104;

--Para validar que no se actualice un producto con los mismos valores anteriores, se puede hacer lo siguiente 
--en el procedimiento almacenado de actualización:

	CREATE OR ALTER PROCEDURE SP_ACTUALIZAR_PRODUCTO
	@id_producto int,
	@descripcion varchar(100),
	@existencia int,
	@precio_compra int,
	@precio_venta int,
	@fecha_entrada date,
	@id_categoria int
	AS
	BEGIN
	-- Verificar si el producto existe
	IF EXISTS(SELECT 1 FROM Productos WHERE id_producto = @id_producto)
	BEGIN
	-- Verificar si se actualizan los mismos valores
	IF NOT EXISTS(SELECT 1 FROM Productos
	WHERE id_producto = @id_producto
	AND descripcion = @descripcion
	AND existencia = @existencia
	AND precio_compra = @precio_compra
	AND precio_ventas = @precio_venta
	AND fecha_entrada = @fecha_entrada
	AND id_categoria = @id_categoria)
	BEGIN
	-- Actualizar el producto
	UPDATE Productos SET
	descripcion = @descripcion,
	existencia = @existencia,
	precio_compra = @precio_compra,
	precio_ventas = @precio_venta,
	fecha_entrada = @fecha_entrada,
	id_categoria = @id_categoria
	WHERE id_producto = @id_producto;
	PRINT 'El producto ha sido actualizado exitosamente.'
	END
	ELSE
	BEGIN
	PRINT 'No se puede actualizar el producto con los mismos valores anteriores.'
	END
	END
	ELSE
	BEGIN
	PRINT 'El producto no existe en la base de datos.'
	END
	END
	GO

--Para ejecutarlo, puedes utilizar el siguiente código:
EXEC SP_ACTUALIZAR_PRODUCTO 166,'PRUEBA ACTUALIZADA', 15, 15000, 17000, '2022-09-03', 1104;

/*
 crear un trigger en SQL Server que evita la inserción de datos duplicados en la tabla "Productos":
*/

CREATE TRIGGER tr_no_duplicados
ON Productos
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (
        SELECT 1
        FROM Productos p
        INNER JOIN inserted i ON p.id_producto = i.id_producto
        WHERE p.descripcion = i.descripcion
        AND p.existencia = i.existencia
        AND p.precio_compra = i.precio_compra
        AND p.precio_ventas = i.precio_ventas
        AND p.fecha_entrada = i.fecha_entrada
        AND p.id_categoria = i.id_categoria
    )
    BEGIN
        RAISERROR ('No se permiten productos duplicados.', 16, 1)
        ROLLBACK TRANSACTION
    END
END


SELECT OBJECTPROPERTY(OBJECT_ID('tr_no_duplicados'), 'ExecIsTriggerDisabled');

ENABLE TRIGGER tr_no_duplicados ON Productos;

DROP TRIGGER tr_no_duplicados;

INSERT INTO Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas, fecha_entrada, id_categoria)
VALUES (1, 'Producto 1', 10, 100, 120, '2022-03-14', 1106);

select * from Productos