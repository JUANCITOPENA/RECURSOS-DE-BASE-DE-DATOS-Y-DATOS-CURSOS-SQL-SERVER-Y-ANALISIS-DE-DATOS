--CREAMOS UNA BASE DE DATOS LLAMADA VENTASDM:
create database ventasdm;
go

--usamos esa base de datos ventasdm:

use ventasdm;
go

--CAMBIAR A ESPANIS EL LENGUAJE:

SET LANGUAGE Spanish;

--VAMOS A CREAR LAS TABLAS Y LAS RELACIONES DEL MODELO:

--CREAMOS LA TABLA CLIENTES:

create table cliente(
id_cliente int IDENTITY(1,1) primary key not null,
nombre varchar(50) not null,
apellidos varchar(60) not null,
cedula_RNC varchar(13)not null,
direccion varchar(60) not null,
telefono varchar(12) not null,
correo varchar(30) not null
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
correo varchar(30) not null
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

--CREAMOS LA TABLA CONDICIONES DE FACTURAS (CREDITO O CONTADO)
create table condicion_factura (
	id_condicion int primary key not null,
	condicion varchar(25) not null,
	);
GO

--SELECCIONAMOS LA TABLA PARA LA ESTRUCTURA:

select * from condicion_factura;

--CREAMOS LA TABLA FACTURA:

create table factura(
id_factura int primary key not null,
No_factura int not null,
fecha_venta date,
id_condicion int not null,
id_vendedor int not null,
id_cliente int not null,
FOREIGN KEY (id_vendedor) REFERENCES vendedor (id_vendedor),
FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
FOREIGN KEY (id_condicion) REFERENCES condicion_factura (id_condicion),
);
go

--CREAMOS LA TABLA DETALLE FACTURAS:

create table detalle_factura(
id_detalle_factura int primary key not null,
id_factura int not null,
id_producto int not null,
cantidad_vendida int not null,
precio_ventas int not null,
monto as (cantidad_vendida * precio_ventas) PERSISTED,--campo calculado, multiplica datos.
FOREIGN KEY (id_producto) REFERENCES Productos (id_producto),
FOREIGN KEY (id_factura) REFERENCES factura (id_factura),
);
go


--INSERTAMOS DATOS EN LA TABLA CLIENTE:

insert into cliente (nombre, apellidos, cedula_rnc, direccion, telefono , correo)
values ('JUANCITO','PEÑA','001-0000211-4','C/SAN JOSE #39, STO.DGO.OESTE','809-111-2222','JUANCITO.P@HOTMAIL.COM');
insert into cliente (nombre, apellidos, cedula_rnc, direccion, telefono , correo)
values ('JAVIER','GOMEZ','501-0550030-5','C/JUAN MIGUEL #99, STO.DGO.ESTE','809-222-1111','JAVIER.G@HOTMAIL.COM');
insert into cliente (nombre, apellidos, cedula_rnc, direccion, telefono , correo)
values ('DANILO','FAÑA','111-1111000-0','C/PEDRO JULIO #11, STO.DGO.OESTE','809-333-4444','DANIELO.F@HOTMAIL.COM');
insert into cliente (nombre, apellidos, cedula_rnc, direccion, telefono , correo)
values ('DARIEL','VASQUEZ','158-512-991','C/JUEGANDO SIEMPRE','809-664-0043','DARIE@GMAIL.COM');
insert into cliente (nombre, apellidos, cedula_rnc, direccion, telefono , correo)
values ('LEONEL','GUZMAN', '211-151-001','C/NO SE DONDE ES','809-988-8888','PEDRO@GMAIL.COM');

--SELECCIONAMOS ESA TABLA PARA LOS DATOS INSERTADOS:

select * from cliente;


--INSERTAMOS DATOS EN LA TABLA VENDEDOR:

insert into vendedor (nombre, apellidos, cedula, direccion, telefono , sueldo, correo)
values ('ANDRES','PATIÑO','010-2110251-0','C/DUARTE, STO.DGO.OESTE','809-999-9999',25000,'ANDRES@HOTMAIL.COM');
insert into vendedor (nombre, apellidos, cedula, direccion, telefono , sueldo, correo)
values ('PAOLO','LUEGANO','200-2000000-5','C/CIELO LINDO # 39, STO.DGO.ESTE','809-333-3333',25000,'PAOLO.G@HOTMAIL.COM');
insert into vendedor (nombre, apellidos, cedula, direccion, telefono , sueldo, correo)
values ('LEONEL','GUERRA','300-0000000-0','C/CERO CERO, STO.DGO.OESTE','809-555-4444',25000,'LEONEL.F@HOTMAIL.COM');
insert into vendedor (nombre, apellidos, cedula, direccion, telefono , sueldo, correo)
VALUES('CESAR', 'MELENDEZ','300-0000000-0','C/CERO CERO, STO.DGO.OESTE','809-222-1111',25000,'LEONEL.F@HOTMAIL.COM');
insert into vendedor (nombre, apellidos, cedula, direccion, telefono , sueldo, correo)
VALUES('ANTONIO','PEREZ','300-0000000-0','C/CERO CERO, STO.DGO.OESTE','809-101-5551',25000,'LEONEL.F@HOTMAIL.COM');
insert into vendedor (nombre, apellidos, cedula, direccion, telefono , sueldo, correo)
VALUES('CRISTOPHER','MENDEZ','300-0000000-0','C/CERO CERO, STO.DGO.OESTE','809-988-3330',25000,'LEONEL.F@HOTMAIL.COM');
insert into vendedor (nombre, apellidos, cedula, direccion, telefono , sueldo, correo)
VALUES('ULTIMO','FERNADEZ','300-0000000-0','C/CERO CERO, STO.DGO.OESTE','809-798-7989',25000,'LEONEL.F@HOTMAIL.COM');


--SELECCIONAMOS ESA TABLA PARA LOS DATOS INSERTADOS:

select * from vendedor;

--Insertamos algunos registros a la tabla Categoria Producto:

insert into categoria_productos values ('SMARPHONE');
insert into categoria_productos values ('LAPTOPS');
insert into categoria_productos values ('TABLETS');
insert into categoria_productos values ('ACCESORIOS');
insert into categoria_productos values ('CONSOLAS');
insert into categoria_productos values ('SMART TV');
insert into categoria_productos values ('PC DESKTOP');

--SELECCIONAMOS ESA TABLA PARA LOS DATOS INSERTADOS:

select * from categoria_productos;


--INSERTAMOS ALGUNOS PRODUCTOS 1- CELULARES:

insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (100,'IPHONE X','10','36000','45000','01-11-2020','1');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (101,'Samsung Galaxy S9+','10','33600','42000','11-05-2020','1');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (102,'OnePlus 8 Pro','10','24000','30000','11-06-2020','1');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (103,'Galaxy Note 10 Plus','10','28000','35000','11-01-2020','1');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (104,'Huawei P20 Pro','10','32000','40000','11-03-2020','1');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (105,'Xperia X Performance','10','20000','25000','11-01-2020','1');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (106,'ZTE Blade V8','10','20000','25000','11-02-2020','1');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (107,'Pixel 4 XL ','10','17600','22000','11-04-2020','1');


--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='1'

--INSERTAMOS ALGUNOS PRODUCTOS 2-LAPTOPS
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (108,'ASUS K52JT','10','20000','25000','11-01-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (109,'HP Envy 13','10','30320','37901','03-06-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (110,'Huawei MateBook X Pro','10','88720','110901','10-04-2020','2');

insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (111,'Dell XPS 13 9380','10','49008','61261','24-05-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (112,'Honor MagicBook 14','10','25648','32061','19-05-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (113,'Acer Swift 5 (SF514-54T)','10','29648','37061','19-05-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (114,'Asus ZenBook S13','10','65407','81759','05-05-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (115,'Lenovo Yoga C740','10','42000','52501','19-10-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (116,'Microsoft Surface Laptop 3','10','40178','50223','10-05-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (117,'MacBook Air','10','42000','52501','29-05-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (118,'Lenovo YOGA 920','10','51344','64181','17-05-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (119,'Lenovo IdeaPAD','10','55970','69963','10-04-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (120,'Dell XPS','10','22424','28031','29-05-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (121,'HP Pavilion 360','10','61343','76679','10-03-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (122,'Acer Chromebook','10','23359','29199','10-03-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (123,'MSI GF63 THIN','10','18688','23360','10-02-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (124,'Surface Book 2','10','51391','64239','17-02-2020','2');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (125,'Toshiba Portege','10','62090','77613','10-01-2020','2');


--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='2'
 
--INSERTAMOS ALGUNOS PRODUCTOS 3-TABLETS
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (126,'iPad de 10,2','10','15370','19213','10-05-2020','3');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (127,'Samsung Galaxy Tab S5e','10','18640','23301','19-01-2020','3');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (128,'Microsoft Surface Pro 6','10','32656','40821','22-02-2020','3');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (129,'Huawei MatePad Pro','10','25648','32061','10-01-2020','3');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (130,'iPad mini (2019)','10','24714','30893','10-01-2020','3');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (131,'Amazon Fire HD 8','10','3736','4671','10-01-2020','3');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (132,'Huawei MediaPad M5 de 8.4','10','18688','23360','20-03-2020','3');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (133,'Onyx Boox Note2','10','25695','32119','23-04-2020','3');


--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='3'

--INSERTAMOS ALGUNOS PRODUCTOS 4-ACCESORIOS

insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (134,'Teclado Mars Gaming MKXTKL','10','1498','1873','24-06-2020','4');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (135,'Teclado Gaming, WisFox ','10','1760','2200','21-06-2020','4');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (136,'OHQ Ratón ZERODATE X300GY','10','680','850','2-06-2020','4');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria) values (137,'Cheekbonny Auriculares Gaming ','10','1560','1950','28-06-2020','4');

--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='4'


--INSERTAMOS ALGUNOS PRODUCTOS 5-CONSOLAS
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (138,'Nintendo GameCube','10','3135','3919','15-11-2017','5');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (139,'Nintendo 64','10','13440','16800','25-06-2017','5');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (140,'Nintendo Switch','10','17382','21728','08-01-2018','5');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (141,'PSP','10','5376','6720','25-01-2016','5');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (142,'Xbox 360','10','6496','8120','16-08-2019','5');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (143,'PlayStation 3','10','90004','101256','23-03-2016','5');
insert into Productos (id_producto, descripcion, existencia, precio_compra, precio_ventas,fecha_entrada, id_categoria)values (144,'Wii','10','8736','10920','19-09-2019','5');

--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='5'

--INSERTAMOS ALGUNOS PRODUCTOS 6-SMART-TV
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (145,'Samsung Smart Tv Full Hd 32 Pulgadas','10','11192','13990','17-10-2020','6');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (146,'Televisores Smar Tv TCL 40 Pulgadas','10','10800','13500','18-10-2020','6');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (147,'TV 50" LED SMART FULL HD 3D LT50DA950 JVC','10','15600','18990','17-10-2017','6');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (148,'LG Smart TV  50 PULGADAS','10','15600','19500','18-10-2016','6');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (149,'Hisense 43" Class 4K UHD LED Roku Smart TV HDR 43R6E1','10','13592','16990','17-10-2016','6');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (150,'Sony Televisión LED 40″ Smart TV W40A16T-SM','10','14000','17500','15-10-2019','6');

--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='6'



--INSERTAMOS ALGUNOS PRODUCTOS PC DESKTOP:

insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (151,'HP Omen Obelisk','20','48650','50400','21/02/2016','7');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (152,'Apple iMac 5K (2019)','20','90200','100800','21/02/2019','7');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (153,'Adamant Ryzen Threadripper','20','350000','370680','21/02/2020','7');
insert into Productos (id_producto, descripcion,existencia,precio_compra, precio_ventas,fecha_entrada, id_categoria)values (154,'Dell G5 Gaming','20','49200','52080','21/02/2019','7');


--seleccionamos la tabla para ver como ha quedado:

select * from Productos 
select * from Productos where id_categoria ='7'

--INSERTAMOS ALGUNAS condiecion_factura:

insert into condicion_factura values (1,'Efectivo');
insert into condicion_factura values (2,'Cheque');
insert into condicion_factura values (3,'Transferencia');
insert into condicion_factura values (4,'Deposito');
insert into condicion_factura values (5,'Credito');


--SELECCIONAMOS LA TABLA PARA LA ESTRUCTURA:

select * from condicion_factura;


--INSERTAMOS LOS DATOS EN TABLA FACTURA:

insert into factura values (1,25001,'01-01-2021',1,1,1);
insert into factura values (2,25002,'01-02-2021',2,2,2);
insert into factura values (3,25003,'05-02-2021',3,3,4);
insert into factura values (4,25004,'06-03-2021',1,4,5);
insert into factura values (5,25005,'05-04-2021',1,5,5);
insert into factura values (6,25006,'17-05-2021',5,1,3);
insert into factura values (7,25007,'08-06-2021',1,2,5);
insert into factura values (8,25008,'09-06-2021',2,3,2);
insert into factura values (9,25009,'11-07-2021',1,5,5);
insert into factura values (10,25010,'17-07-2021',3,7,4);

insert into factura values (10,25010,'17-07-2021',3,7,4);

insert into factura values (11,25011,'02-07-2021',2,8,3);
insert into factura values (12,25012,'01-08-2021',5,6,5);
insert into factura values (13,25013,'03-08-2021',4,9,2);
insert into factura values (14,25014,'08-08-2021',3,5,5);
insert into factura values (15,25015,'11-08-2021',1,2,3);
insert into factura values (16,25016,'21-08-2021',5,7,4);
insert into factura values (17,25017,'02-09-2021',4,4,2);
insert into factura values (18,25018,'10-09-2021',2,9,1);
insert into factura values (19,25019,'15-09-2021',1,3,4);
insert into factura values (20,25020,'23-09-2021',3,8,3);
insert into factura values (21,25021,'03-10-2021',5,5,5);
insert into factura values (22,25022,'11-10-2021',1,9,2);
insert into factura values (23,25023,'15-10-2021',4,7,1);
insert into factura values (24,25024,'25-10-2021',2,3,4);


--SELECCIONAMOS LA TABLA PARA LOS DATOS:

select * from factura where fecha_venta >= '2021-01-01' and fecha_venta <= '2021-07-17'
order by id_factura asc;



--INSERTAMOS LOS DATOS EN TABLA FACTURA:

insert into detalle_factura values (1000001,1,100,1,45000);
insert into detalle_factura values (1000002,1,101,2,42000);
insert into detalle_factura values (1000003,2,103,3,30000);
insert into detalle_factura values (1000004,2,105,2,35000);
insert into detalle_factura values (1000005,3,105,2,35000);
insert into detalle_factura values (1000006,3,106,2,25000);
insert into detalle_factura values (1000007,4,107,2,25000);
insert into detalle_factura values (1000008,4,100,2,45000);
insert into detalle_factura values (1000009,5,108,2,22000);
insert into detalle_factura values (1000010,6,100,2,45000);

insert into detalle_factura values (1000011,5,109,3,18000);
insert into detalle_factura values (1000012,6,110,1,50000);
insert into detalle_factura values (1000013,6,109,2,30000);
insert into detalle_factura values (1000014,7,112,2,28000);
insert into detalle_factura values (1000015,7,113,2,32000);
insert into detalle_factura values (1000016,8,114,1,45000);
insert into detalle_factura values (1000017,8,112,2,28000);
insert into detalle_factura values (1000018,9,116,2,32000);
insert into detalle_factura values (1000019,9,117,3,48000);
insert into detalle_factura values (1000020,10,118,2,40000);
insert into detalle_factura values (1000021,10,119,2,45000);
insert into detalle_factura values (1000022,11,120,3,54000);
insert into detalle_factura values (1000023,11,117,1,16000);
insert into detalle_factura values (1000024,12,121,2,36000);
insert into detalle_factura values (1000025,12,118,1,20000);
insert into detalle_factura values (1000026,13,123,2,32000);
insert into detalle_factura values (1000027,13,124,3,51000);
insert into detalle_factura values (1000028,14,125,2,42000);
insert into detalle_factura values (1000029,14,120,1,27000);
insert into detalle_factura values (1000030,15,126,2,40000);


--SELECCIONAMOS LA TABLA PARA LOS DATOS:

select * from detalle_factura 


select * from detalle_factura where id_detalle_factura >= '1000001' and id_detalle_factura <= '10000011'
order by id_factura asc;


--LISTAQMOS TODAS LAS TABLAS PARA SU CONTENIDO:

select * from cliente; 
select * from vendedor;
select * from Productos; 
select * from categoria_productos; 
select * from condicion_factura; 
select * from factura; 
select * from detalle_factura;



--REALIZAMOS ALGUNAS CONSULTAS TOP  VENDEDORES:

select distinct TOP 5  c.nombre as Cliente
  ,SUM(monto) AS Ingresos
from cliente c join factura f
on c.id_cliente = f.id_cliente
join detalle_factura df
on df.id_factura = f.id_factura
GROUP BY c.nombre
Order by SUM(monto) desc


--REALIZAMOS ALGUNAS CONSULTAS TOP  VENDEDORES:

select distinct TOP 5  v.nombre
  ,SUM(monto) AS Ingresos
from vendedor v join factura f
on v.id_vendedor = f.id_vendedor
join detalle_factura df
on df.id_factura = f.id_factura
GROUP BY v.nombre
Order by SUM(monto) desc

--REALIZAMOS ALGUNAS CONSULTAS TOP  PRODUCTOS:

select distinct TOP 10   p.descripcion AS Productos
  ,SUM(monto) AS Ingresos
from Productos P join detalle_factura df
on P.id_producto = df.id_producto
join factura f
on df.id_factura = f.id_factura
GROUP BY P.descripcion
Order by SUM(monto) desc

--REALIZAMOS ALGUNAS CONSULTAS TOP  PRODUCTOS VEMOS CUANTOS PRODUCTOS POR CATEGORIA EXISTEN:

select cp.nombre_categoria as Categoria
  ,sum(cantidad_vendida) AS 'Total'
from categoria_productos cp join Productos p
on p.id_categoria = cp.id_categoria
join detalle_factura df
on df.id_producto = p.id_producto
GROUP BY cp.nombre_categoria
Order by sum(cantidad_vendida) desc


--REALIZAMOS ALGUNAS CONSULTAS TOP  PRODUCTOS CUANTO SE HAN VENDEDIDO:

select distinct cp.nombre_categoria as Categoria
  ,count(cantidad_vendida) AS 'Productos'
from categoria_productos cp join Productos p
on p.id_categoria = cp.id_categoria
join detalle_factura df
on df.id_producto = p.id_producto
GROUP BY cp.nombre_categoria
Order by count(cantidad_vendida) desc

--AHORA VAMOS A HACER ALGUNAS CONSULTAS CON JOIN- PARA UNIR LAS TABLAS:

select f.No_factura, f.fecha_venta, cf.condicion, c.nombre 'Cliente', v.nombre 'Vendedor', p.descripcion 'Productos',
       df.cantidad_vendida 'Cantidad', df.precio_ventas 'Precio RD$', df.monto 'Total RD$'
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





--MODIFICAMOS LA CONSULTA Y LE PONEMOS ALGO DE SEGURIDAD:

CREATE OR alter view Maestro_Detalle  with encryption
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


--EJECUTAMOS LA VISTA QUE HEMOS CREADO:

select * from Maestro_Detalle 



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


--EJECUTAMOS LA VISTA QUE HEMOS CREADO CON  WHERE:

select * from Maestro_Detalle 
WHERE [Condicion de Pago] ='Efectivo'

select * from Maestro_Detalle 
WHERE [Condicion de Pago] ='Cheque'

select * from Maestro_Detalle 
WHERE [Condicion de Pago] ='Transferencia'

select * from Maestro_Detalle 
WHERE [Condicion de Pago] ='Credito'


--# VENTAS TOTAL Y TRANSACCIONES:


select sum(monto) as 'Total Monto de Ventas', count(*) as 'Total de Transacciones'  from detalle_factura

select sum(precio_ventas) as 'Total Precio Ventas', count(*) as 'Total de Transacciones'  from detalle_factura

select sum(precio_compra) as 'Total Precio Compra' , count(*) as 'Total de Productos' from Productos

