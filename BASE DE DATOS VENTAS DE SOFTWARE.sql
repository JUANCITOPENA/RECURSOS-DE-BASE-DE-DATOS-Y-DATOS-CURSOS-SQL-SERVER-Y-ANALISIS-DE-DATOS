/*
El proceso de diseño y modelamiento de una base de datos comienza por identificar los requisitos de negocio
y definir los objetivos de la base de datos. Estos requisitos se pueden obtener mediante entrevistas con los
usuarios, el análisis de documentos y la comprensión del funcionamiento del negocio.

Una vez que se han identificado los requisitos, se pueden comenzar a definir los modelos de datos. El primer 
modelo de datos es el Modelo Entidad-Relación (ER), el cual se utiliza para representar los objetos y las
relaciones que existen entre ellos. En este modelo se definen las entidades y sus atributos, así como las 
relaciones entre ellas.

Después de definir el modelo ER, se procede a la creación del modelo relacional, el cual representa las entidades
y las relaciones en tablas y establece las restricciones necesarias para garantizar la integridad de los datos. 
En este modelo se definen las claves primarias y foráneas, las restricciones de integridad referencial, las 
restricciones de dominio y otras restricciones necesarias.

También es importante definir la atomicidad, consistencia, aislamiento y durabilidad (ACID) de la base de datos, 
lo cual se logra mediante la definición de transacciones y la implementación de mecanismos de control de concurrencia.

Una vez que se ha definido el modelo relacional y se han establecido las restricciones necesarias, se procede a la
implementación del modelo mediante la creación de las tablas, la definición de las claves primarias y foráneas, y 
la inserción de los datos iniciales.

Finalmente, se realizan pruebas para asegurarse de que la base de datos cumple con los requisitos de negocio y de 
que los datos están correctamente estructurados y almacenados. También es importante llevar a cabo pruebas de rendimiento
y optimización para asegurarse de que la base de datos pueda manejar grandes volúmenes de datos y ofrecer un alto rendimiento.


*/


/*


El proceso de diseño y modelamiento involucra la creación de una base de datos llamada "SOFTWARE_JPV" y la creación
de varias tablas con campos y relaciones entre ellas.

Primero se crea la tabla "cliente" con campos como "id_cliente", "nombre", "apellidos", "cedula_RNC", "direccion",
"telefono", "correo", e "id_region".

Luego se crea la tabla "vendedor" con campos como "id_vendedor", "nombre", "apellidos", "cedula", "direccion",
"telefono", "sueldo", "correo", e "id_region".

Después se crea la tabla "categoria_productos" con campos como "id_categoria" y "nombre_categoria".

Luego se crea la tabla "Productos" con campos como "id_producto", "descripcion", "existencia", "precio_compra",
"precio_ventas", "fecha_entrada", e "id_categoria", y se establece una relación con la tabla "categoria_productos".

Se crea la tabla "region" con campos como "id_region" y "nombre".

Se crea la tabla "ciudad" con campos como "id_ciudad", "nombre_ciudad", "latitud", "longitud", y "id_region", y 
se establece una relación con la tabla "region".

Se crea la tabla "condicion_factura" con campos como "id_condicion" y "condicion".

Se crea la tabla "tipo_ventas" con campos como "id_tipo_ventas" y "descripcion".

Finalmente se crea la tabla "factura" con campos como "id_factura", "No_factura", "fecha_venta", "id_condicion",
"id_vendedor", "id_cliente", e "id_tipo_ventas", y se establecen relaciones con las tablas "vendedor", "cliente",
"condicion_factura", y "tipo_ventas".

Además, se crea la tabla "detalle_factura" con campos como "item_detalle_factura", "id_factura", "id_producto", 
"cantidad_vendida", "precio_ventas", y "monto" (un campo calculado que multiplica la cantidad vendida por el precio de venta),
y se establecen relaciones con las tablas "Productos" y "factura".

*/

--CREAMOS UNA BASE DE DATOS LLAMADA SOFTWARE_JPV:
create database SOFTWARE_JPV;
go

--usamos esa base de datos ventasdm:

use SOFTWARE_JPV;
go

--VAMOS A CREAR LAS TABLAS Y LAS RELACIONES DEL MODELO:

--CREAMOS LA TABLA CLIENTES:

create table cliente(
id_cliente int IDENTITY(1,1) primary key not null,
nombre varchar(50) not null,
apellidos varchar(60) not null,
cedula_RNC varchar(13)not null,
direccion varchar(60) not null,
telefono varchar(12) not null,
correo varchar(30) not null,
id_region int not null
);
go

--CREAMOS LA TABLA VENDEDOR:

create table vendedor(
id_vendedor int IDENTITY(1,1) primary key not null,
nombre varchar(50) not null,
apellidos varchar(60) not null,
cedula varchar(13)not null,
direccion varchar(60) not null,
telefono varchar(12) not null,
sueldo int not null,
correo varchar(30) not null,
id_region int not null
);
go

--CREAMOS LA TABLA CATEGORIA:

create table categoria_productos(
id_categoria int IDENTITY(1,1) primary key not null,
nombre_categoria varchar(100) not null
);
go

--CREAMOS LA TABLA PRODUCTOS:

create table Productos(
	id_producto int primary key not null,
	descripcion varchar(100) not null,
	existencia int not null,
	precio_compra int not null,
	precio_ventas int not null,
	fecha_entrada date not null,
	id_categoria int not null
	FOREIGN KEY (id_categoria) REFERENCES categoria_productos (id_categoria),
	);
go


--Creamos la Tabla region, tambien podemos crearla manualmente sin comandos.
create table region(
	id_region int primary key not null,
	nombre varchar(50) not null,
	);
GO

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


--CREAMOS LA TABLA CONDICIONES DE FACTURAS (CREDITO O CONTADO)
create table condicion_factura (
	id_condicion int primary key not null,
	condicion varchar(25) not null,
	);
GO

--SELECCIONAMOS LA TABLA PARA LA ESTRUCTURA:

select * from condicion_factura;


--CREAMOS LA TABLA TIPO DE VENTAS

create table tipo_ventas (
	id_tipo_ventas int primary key not null,
	descripcion varchar(25) not null,
	);
GO

--CREAMOS LA TABLA FACTURA:

create table factura(
id_factura int primary key not null,
No_factura int not null,
fecha_venta date,
id_condicion int not null,
id_vendedor int not null,
id_cliente int not null,
id_tipo_ventas int not null,
FOREIGN KEY (id_vendedor) REFERENCES vendedor (id_vendedor),
FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
FOREIGN KEY (id_condicion) REFERENCES condicion_factura (id_condicion),
FOREIGN KEY (id_tipo_ventas) REFERENCES tipo_ventas (id_tipo_ventas),
);
go

-- seleccionamos la tabla para la estructura:

select * from factura

--CREAMOS LA TABLA DETALLE FACTURAS:

create table detalle_factura(
item_detalle_factura int primary key identity (1,1)not null,
id_factura int not null,
id_producto int not null,
cantidad_vendida int not null,
precio_ventas int not null,
monto as (cantidad_vendida * precio_ventas) PERSISTED,--campo calculado, multiplica datos.
FOREIGN KEY (id_producto) REFERENCES Productos (id_producto),
FOREIGN KEY (id_factura) REFERENCES factura (id_factura),
);

-- seleccionamos la tabla para la estructura:

select * from detalle_factura



--Insertamos algunos registros a la tabla tipo_clientes:

INSERT INTO tipo_ventas(id_tipo_ventas, descripcion)VALUES(1,'Online');--Todo el Cibao y el Norte del Pais
INSERT INTO tipo_ventas(id_tipo_ventas, descripcion)VALUES(2,'Fisica');--Toda Zona Sur del Pais

select * from tipo_ventas

--Insertamos algunos registros a la tabla region:

INSERT INTO region(id_region, nombre)VALUES(1,'Region Cibao');--Todo el Cibao y el Norte del Pais
INSERT INTO region(id_region, nombre)VALUES(2,'Region Sur');--Toda Zona Sur del Pais
INSERT INTO region(id_region, nombre)VALUES(3,'Region Este');--Toda la Parte Sureste del Pais Incluyendo y Santo Domingo

--seleccionamos la tabla para ver como ha quedado:

select * from region

--Insertamos algunos registros a la tabla CUIDAD:

--REGION DEL CIBAO-SUR-NORDESTE-NORTE:

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

select * from ciudad


select * from ciudad WHERE id_region='1'
select * from ciudad WHERE id_region='2'
select * from ciudad WHERE id_region='3'


--INSERTAMOS DATOS EN LA TABLA CLIENTE:

insert into cliente (nombre, apellidos, cedula_rnc, direccion, telefono , correo, id_region)
values ('JUANCITO','PEÑA','001-0000211-4','C/SAN JOSE #39, STO.DGO.OESTE','809-111-2222','JUANCITO.P@HOTMAIL.COM', 1);
insert into cliente (nombre, apellidos, cedula_rnc, direccion, telefono , correo, id_region)
values ('JAVIER','GOMEZ','501-0550030-5','C/JUAN MIGUEL #99, STO.DGO.ESTE','809-222-1111','JAVIER.G@HOTMAIL.COM', 1);
insert into cliente (nombre, apellidos, cedula_rnc, direccion, telefono , correo, id_region)
values ('DANILO','FAÑA','111-1111000-0','C/PEDRO JULIO #11, STO.DGO.OESTE','809-333-4444','DANIELO.F@HOTMAIL.COM', 2);
insert into cliente (nombre, apellidos, cedula_rnc, direccion, telefono , correo, id_region)
values ('DARIEL','VASQUEZ','158-512-991','C/JUEGANDO SIEMPRE','809-664-0043','DARIE@GMAIL.COM', 2);
insert into cliente (nombre, apellidos, cedula_rnc, direccion, telefono , correo, id_region)
values ('LEONEL','GUZMAN', '211-151-001','C/NO SE DONDE ES','809-988-8888','PEDRO@GMAIL.COM', 3);
insert into cliente (nombre, apellidos, cedula_rnc, direccion, telefono , correo, id_region)
values ('RAMON','MARQUEZ', '159-821-521','SAN JUAN # 52','809-988-8888','PEDRO@GMAIL.COM', 3);

--SELECCIONAMOS ESA TABLA PARA LOS DATOS INSERTADOS:

select * from cliente;


--INSERTAMOS DATOS EN LA TABLA VENDEDOR:

insert into vendedor (nombre, apellidos, cedula, direccion, telefono , sueldo, correo, id_region)
values ('ANDRES','PATIÑO','010-2110251-0','C/DUARTE, STO.DGO.OESTE','809-999-9999',25000,'ANDRES@HOTMAIL.COM', 1);
insert into vendedor (nombre, apellidos, cedula, direccion, telefono , sueldo, correo, id_region)
values ('PAOLO','LUEGANO','200-2000000-5','C/CIELO LINDO # 39, STO.DGO.ESTE','809-333-3333',25000,'PAOLO.G@HOTMAIL.COM', 1);
insert into vendedor (nombre, apellidos, cedula, direccion, telefono , sueldo, correo, id_region)
values ('LEONEL','GUERRA','300-0000000-0','C/CERO CERO, STO.DGO.OESTE','809-555-4444',25000,'LEONEL.F@HOTMAIL.COM', 2);
insert into vendedor (nombre, apellidos, cedula, direccion, telefono , sueldo, correo, id_region)
VALUES('CESAR', 'MELENDEZ','300-0000000-0','C/CERO CERO, STO.DGO.OESTE','809-222-1111',25000,'LEONEL.F@HOTMAIL.COM', 2);
insert into vendedor (nombre, apellidos, cedula, direccion, telefono , sueldo, correo, id_region)
VALUES('ANTONIO','PEREZ','300-0000000-0','C/CERO CERO, STO.DGO.OESTE','809-101-5551',25000,'LEONEL.F@HOTMAIL.COM', 3);
insert into vendedor (nombre, apellidos, cedula, direccion, telefono , sueldo, correo, id_region)
VALUES('CRISTOPHER','MENDEZ','300-0000000-0','C/CERO CERO, STO.DGO.OESTE','809-988-3330',25000,'LEONEL.F@HOTMAIL.COM', 3);
insert into vendedor (nombre, apellidos, cedula, direccion, telefono , sueldo, correo, id_region)
VALUES('ULTIMO','FERNADEZ','300-0000000-0','C/CERO CERO, STO.DGO.OESTE','809-798-7989',25000,'LEONEL.F@HOTMAIL.COM', 3);


--SELECCIONAMOS ESA TABLA PARA LOS DATOS INSERTADOS:

select * from vendedor;

--Insertamos algunos registros a la tabla Categoria Producto:

insert into categoria_productos values ('SOFTWARE DE VENTAS');
insert into categoria_productos values ('VIDEOS JUEGOS');
insert into categoria_productos values ('SOFTWARE DESKTOP Y APLICACION');
insert into categoria_productos values ('SOFTWARE BUSSINESS INTELLIGENCES');
insert into categoria_productos values ('SISTEMAS OPERATIVOS');



--SELECCIONAMOS ESA TABLA PARA LOS DATOS INSERTADOS:

select * from categoria_productos;


--INSERTAMOS ALGUNOS PRODUCTOS 1- CELULARES:

insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (100,'MSELLER','10','800000','969000','01-01-2021','1');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (101,'EASY-SALES','10','750000','850000','01-01-2021','1');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (102,'MACOLA-ES','10','1000000','1350000','01-01-2021','1');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (103,'SAP','10','2250000','2850000','01-01-2021','1');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (104,'SALESFORCE X MODULOS','10','205200','295000','01-11-2021','1');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (105,'ODOO','10','2000000','2650000','01-01-2021','1');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (106,'Dynamics 365 Sales x Users','10','60000','77830','01-01-2021','1');

--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='1'

--INSERTAMOS ALGUNOS PRODUCTOS 2-LAPTOPS
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (107,'PC ZONE','10','25000','3142','01-01-2021','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (108,'G-FORCE ','10','350','450','01-01-2021','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (109,'Paper Mario: The Origami King','10','3000','3595','01-01-2021','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (110,'HITMAN 3','10','3500','4139','01-01-2021','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (111,'The Medium','10','1850','2277','01-01-2021','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (112,'Little Nightmares 2','10','29648','37061','01-01-2021','2');


--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='2'
 
--INSERTAMOS ALGUNOS PRODUCTOS 3-TABLETS
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (113,'ANTIVIRUS NORTON','10','1750','2280','01-01-2021','3');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (114,'ANTIVIRUS PANDA','10','1550','1995','01-01-2021','3');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (115,'Office 365','10','6800','7938','01-01-2021','3');

--SELECCIONAMOS ESA TABLA PARA LOS DATOS INSERTADOS:

select * from categoria_productos;

--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='3'

--INSERTAMOS ALGUNOS PRODUCTOS 4-ACCESORIOS

insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (116,'POWER BI PRO','10','4800','6000','01-01-2021','4');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (117,'POWER BI PREMIUM','10','800','963','01-01-2021','4');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (118,'TABLEAU','10','1600','1995','01-01-2021','4');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (119,'QlikView','10','1450','1710','01-01-2021','4');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (120,'SQL Server BI CAL','10','9500','11913','01-01-2021','4');

--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='4'


--INSERTAMOS ALGUNOS PRODUCTOS 6-SMART-TV
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (121,'Windows 10 Home','10','2950','3334','01-01-2021','5');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (122,'Windows 10 Professional','10','5300','6281','01-01-2021','5');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (123,'Mac OS X Versión 10.2 "jaguar"','10','6000','7353','01-01-2021','5');


--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='5'


--INSERTAMOS ALGUNAS condiecion_factura:

insert into condicion_factura values (1,'Efectivo');
insert into condicion_factura values (2,'Cheque');
insert into condicion_factura values (3,'Transferencia');
insert into condicion_factura values (4,'Deposito');
insert into condicion_factura values (5,'Credito');


--SELECCIONAMOS LA TABLA PARA LA ESTRUCTURA:

select * from condicion_factura;


--INSERTAMOS LOS DATOS EN TABLA FACTURA:

insert into factura values (1,25001,'01-01-2021',1,1,1,1);
insert into factura values (2,25002,'01-02-2021',2,2,2,2);
insert into factura values (3,25003,'05-02-2021',3,3,4,1);
insert into factura values (4,25004,'06-03-2021',1,4,5,1);
insert into factura values (5,25005,'05-04-2021',1,5,5,2);
insert into factura values (6,25006,'05-05-2021',5,1,3,1);
insert into factura values (7,25007,'08-06-2021',1,2,5,2);
insert into factura values (8,25008,'09-06-2021',2,3,2,2);
insert into factura values (9,25009,'11-07-2021',1,5,5,2);
insert into factura values (10,25010,'01-07-2021',3,7,4,2);

--SELECCIONAMOS LA TABLA PARA LOS DATOS:

select * from factura 
order by id_factura asc;

select * from detalle_factura 


--INSERTAMOS LOS DATOS EN TABLA FACTURA:

insert into detalle_factura values (1,100,1,969000);
insert into detalle_factura values (1,101,2,850000);
insert into detalle_factura values (2,103,3,2850000);
insert into detalle_factura values (2,105,2,2650000);
insert into detalle_factura values (3,105,2,2650000);
insert into detalle_factura values (3,106,2,77830);
insert into detalle_factura values (4,107,2,3142);
insert into detalle_factura values (4,100,2,969000);
insert into detalle_factura values (5,108,2,450);
insert into detalle_factura values (6,100,2,969000);

insert into detalle_factura values (7,107,2,3142);
insert into detalle_factura values (7,108,2,450);
insert into detalle_factura values (7,112,2,37061);
insert into detalle_factura values (8,110,2,4139);
insert into detalle_factura values (8,111,2,2277);

insert into detalle_factura values (9,106,2,77830);
insert into detalle_factura values (9,107,2,3142);
insert into detalle_factura values (10,115,2,7938);
insert into detalle_factura values (10,116,2,6000);
insert into detalle_factura values (10,122,2,6281);

--SELECCIONAMOS LA TABLA PARA LOS DATOS:

select * from detalle_factura 


select * from detalle_factura
order by id_factura asc;


--LISTAQMOS TODAS LAS TABLAS PARA SU CONTENIDO:

select * from cliente; 
select * from vendedor;
select * from Productos; 
select * from categoria_productos; 
select * from condicion_factura; 
select * from factura; 
select * from detalle_factura;
select * from tipo_ventas
select * from region

-- HACEMOS VARIOS SELECT PARA VER LOS DATOS DE VENTAS, TRANSACCIONES, ETC.

select sum(monto) as 'Total Monto de Ventas', count(*) as 'Total de Transacciones'  from detalle_factura
select sum(precio_ventas) as 'Total Precio Ventas', count(*) as 'Total de Transacciones'  from detalle_factura
select sum(precio_compra) as 'Total Precio Compra' , count(*) as 'Total de Productos' from Productos

SELECT SUM(df.precio_ventas - p.precio_compra) AS 'Utilidad Total',
       COUNT(DISTINCT df.id_factura) AS 'Total de Transacciones'
FROM detalle_factura df
JOIN Productos p ON df.id_producto = p.id_producto


--VER CLIENTES POR REGION:

select * from cliente where id_region='1'
select * from cliente where id_region='2'
select * from cliente where id_region='3'

--VER VENDEDORES POR REGION:

select * from vendedor where id_region='1'
select * from vendedor where id_region='2'
select * from vendedor where id_region='3'


--REALIZAMOS ALGUNAS CONSULTAS TOP  VENDEDORES:

select distinct TOP 7  c.nombre as Cliente
  ,SUM(monto) AS 'Total Ventas'
from cliente c join factura f
on c.id_cliente = f.id_cliente
join detalle_factura df
on df.id_factura = f.id_factura
GROUP BY c.nombre
Order by SUM(monto) desc


--REALIZAMOS ALGUNAS CONSULTAS TOP  VENDEDORES:

select distinct TOP 6  v.nombre as 'Vendedor'
  ,SUM(monto) AS 'Total Ventas'
from vendedor v join factura f
on v.id_vendedor = f.id_vendedor
join detalle_factura df
on df.id_factura = f.id_factura
GROUP BY v.nombre
Order by SUM(monto) desc

--REALIZAMOS ALGUNAS CONSULTAS TOP  PRODUCTOS:

select distinct p.descripcion AS Productos,
   count(cantidad_vendida) as 'Cantidad'
  ,SUM(df.cantidad_vendida * df.precio_ventas) AS 'Venta Total'
from detalle_factura df
join  Productos P 
on P.id_producto = df.id_producto
GROUP BY P.descripcion, monto
Order by SUM(monto) desc

--REALIZAMOS ALGUNAS CONSULTAS TOP  PRODUCTOS VEMOS CUANTOS PRODUCTOS POR CATEGORIA EXISTEN:

select cp.nombre_categoria as Categoria,
   count(cantidad_vendida) as Cantidad
  ,sum(df.cantidad_vendida * df.precio_ventas) AS 'Total'
from categoria_productos cp 
join Productos p
on p.id_categoria = cp.id_categoria
join detalle_factura df
on df.id_producto = p.id_producto
GROUP BY cp.nombre_categoria
Order by sum(cantidad_vendida) desc


--REALIZAMOS ALGUNAS CONSULTAS TOP  PRODUCTOS CUANTO SE HAN VENDEDIDO:

select distinct cp.nombre_categoria as Categoria
  ,count(cantidad_vendida) AS 'Productos', df.monto as 'Monto RD$' 
from categoria_productos cp join Productos p
on p.id_categoria = cp.id_categoria
join detalle_factura df
on df.id_producto = p.id_producto
GROUP BY cp.nombre_categoria, df.monto
Order by count(cantidad_vendida) desc

--REALIZAREMOS UNA CONSULTA QUE NOS PERMITA VER POR CATEGORIA LA  CANTIDAD DE VENTAS Y SUS MONTOS :

SELECT cp.nombre_categoria AS Categoria,
       COUNT(DISTINCT p.id_producto) AS 'Productos',
       SUM(df.monto) AS 'Monto RD$'
FROM categoria_productos cp 
JOIN Productos p ON p.id_categoria = cp.id_categoria
JOIN detalle_factura df ON df.id_producto = p.id_producto
GROUP BY cp.nombre_categoria
ORDER BY COUNT(DISTINCT p.id_producto) DESC;


--AHORA VAMOS A HACER ALGUNAS CONSULTAS CON JOIN- PARA UNIR LAS TABLAS:

select distinct f.No_factura, f.fecha_venta, cf.condicion as 'Condicon de Pago',
tv.descripcion as 'Tipo de Venta', r.nombre as 'Region', c.nombre 'Cliente', 
v.nombre 'Vendedor', p.descripcion 'Productos',df.cantidad_vendida 'Cantidad', 
df.precio_ventas 'Precio RD$',
	   sum(df.monto) 'Total RD$'
from factura f join detalle_factura df
on f.id_factura = df.id_factura
join cliente c
on f.id_cliente = c.id_cliente
join vendedor v
on v.id_vendedor = f.id_vendedor
join Productos p
on p.id_producto = df.id_producto
join condicion_factura cf
on cf.id_condicion = f.id_condicion
join tipo_ventas tv
on tv.id_tipo_ventas = f.id_tipo_ventas
join region r
on r.id_region = c.id_region
GROUP BY f.No_factura, f.fecha_venta, cf.condicion, tv.descripcion, r.nombre, c.nombre,p.descripcion, v.nombre,df.cantidad_vendida, df.precio_ventas, df.monto
Order by SUM(monto) desc



--CLASIFICACION DE CLIENTES DE ACUERDO A, B, C, DONDE A >= 5000000, B >=5000000 Y <5000000, C ES < 2000000

SELECT distinct  c.nombre as 'Cliente'
	 ,SUM(monto) AS [Total RD$],
CASE
   WHEN (SUM(dtf.cantidad_vendida * dtf.precio_ventas) >=5000000) THEN 'A'
   WHEN (SUM(dtf.cantidad_vendida * dtf.precio_ventas) < 5000000  AND SUM(dtf.cantidad_vendida * dtf.precio_ventas) >= 2000000) THEN 'B'
   ELSE 'C'
   END AS 'CATEGORIA A-B-C'

FROM factura f join cliente c
on f.id_cliente=c.id_cliente
join detalle_factura dtf
on dtf.id_factura = f.id_factura
join Productos p
on p.id_producto = dtf.id_producto
GROUP BY c.nombre
Order by SUM(monto) desc

select * from factura
select * from detalle_factura



--VAMOS A CREAR UNA VISTA LA CUAL NOS VA HA SEVIR PARA LA CONSULTA QUE YA TENIAMOS

create OR ALTER view Maestro_Detalle
as 
select distinct f.No_factura, f.fecha_venta, cf.condicion, tv.descripcion as 'Tipo de Venta',  c.nombre as 'Cliente',
       v.nombre as 'Vendedor',  ct.nombre_categoria as 'Categoria', p.descripcion as  'Productos',
       dtf.cantidad_vendida 'Cantidad', df.precio_ventas 'Precio RD$', 
	   sum(df.monto) as 'Total RD$'
from factura f join detalle_factura df
on f.id_factura = df.id_factura
join detalle_factura dtf
on dtf.id_factura = f.id_factura
join cliente c
on f.id_cliente = c.id_cliente
join vendedor v
on v.id_vendedor = f.id_vendedor
join Productos p
on p.id_producto = df.id_producto
join categoria_productos ct
on ct.id_categoria = p.id_categoria
join tipo_ventas tv
on tv.id_tipo_ventas = f.id_tipo_ventas
join condicion_factura cf
on cf.id_condicion = f.id_condicion
join region r
on r.id_region = c.id_region
GROUP BY f.No_factura, f.fecha_venta, cf.condicion, tv.descripcion, r.nombre, c.nombre,p.descripcion, v.nombre,dtf.cantidad_vendida, df.precio_ventas,ct.nombre_categoria, df.monto



--EJECUTAMOS LA VISTA QUE HEMOS CREADO:

select * from Maestro_Detalle;


CREATE OR ALTER VIEW Maestro_Detalle_v2 AS
SELECT f.No_factura, 
       f.fecha_venta, 
       cf.condicion, 
       tv.descripcion AS 'Tipo de Venta', 
       c.nombre AS 'Cliente',
       v.nombre AS 'Vendedor',  
       ct.nombre_categoria AS 'Categoria', 
       p.descripcion AS 'Productos',
       SUM(dtf.cantidad_vendida) AS 'Cantidad', 
       df.precio_ventas AS 'Precio RD$', 
       SUM(df.monto) AS 'Total RD$'
FROM factura f 
JOIN detalle_factura df ON f.id_factura = df.id_factura
JOIN detalle_factura dtf ON dtf.id_factura = f.id_factura
JOIN cliente c ON f.id_cliente = c.id_cliente
JOIN vendedor v ON v.id_vendedor = f.id_vendedor
JOIN Productos p ON p.id_producto = df.id_producto
JOIN categoria_productos ct ON ct.id_categoria = p.id_categoria
JOIN tipo_ventas tv ON tv.id_tipo_ventas = f.id_tipo_ventas
JOIN condicion_factura cf ON cf.id_condicion = f.id_condicion
JOIN region r ON r.id_region = c.id_region
GROUP BY f.No_factura, 
         f.fecha_venta, 
         cf.condicion, 
         tv.descripcion, 
         c.nombre, 
         v.nombre, 
         ct.nombre_categoria, 
         p.descripcion, 
         df.precio_ventas



--EJECUTAMOS LA VISTA QUE HEMOS CREADO:

select * from Maestro_Detalle_v2;

--Aqui vamos a crear un Procedimiento Almacenado para Parámetros de un Reporte:

create OR ALTER procedure PA_ReporteCrystal
@fecha_Inicio  date,
@fecha_Final  date
as
select f.No_factura, f.fecha_venta, cf.condicion 'Condicion de Pago', c.nombre 'Cliente', v.nombre 'Vendedor', p.descripcion 'Productos', 
       cp.nombre_categoria 'Categoria', df.cantidad_vendida 'Cantidad', df.precio_ventas 'Precio RD$', df.monto 'Total RD$'
from factura f join detalle_factura df
on f.id_factura = df.id_factura
join cliente c
on f.id_cliente = c.id_cliente
join vendedor v
on v.id_vendedor = f.id_vendedor
join Productos p
on p.id_producto = df.id_producto
join condicion_factura cf
on cf.id_condicion = f.id_condicion
join categoria_productos cp
on cp.id_categoria = p.id_categoria
where  fecha_venta >= @fecha_Inicio and fecha_venta <= @fecha_Final 
go

--Este procedimiento es el que tinees que utilizar en tu proyecto de Reporte con Crystal Report.

--Ejecutamos el store:
DECLARE	@return_value int
EXEC	@return_value = [dbo].PA_ReporteCrystal
		@fecha_Inicio = '2021-02-01',
		@fecha_Final = '2021-07-17'