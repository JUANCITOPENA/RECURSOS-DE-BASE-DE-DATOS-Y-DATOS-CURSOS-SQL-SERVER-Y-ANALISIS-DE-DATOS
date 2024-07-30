/*
Propuesta de modelo de base de datos para un sistema de ventas de vehículos de la marca Toyota utilizando un modelo relacional en SQL Server:

Tablas:

Vehículos: almacena información básica sobre los vehículos, como el modelo, año, precio, etc.
Clientes: almacena información sobre los clientes, como nombre, dirección, teléfono, etc.
Ventas: almacena información sobre las ventas realizadas, como el cliente, el vehículo, la fecha de venta y el precio de venta.
Empleados: almacena información sobre los empleados de la empresa, como nombre, dirección, teléfono, etc.
Asignaciones: almacena información sobre la asignación de empleados a las ventas.
Inventario: almacena información sobre el inventario de vehículos disponibles en el lote.

Relaciones:

Cada vehículo puede tener varias ventas.
Cada venta está asociada a un solo vehículo.
Cada venta está asociada a un solo cliente.
Cada venta está asociada a uno o varios empleados.
Cada empleado puede tener varias ventas asignadas.
Cada vehículo está asociado a un solo inventario.

Indices:

Se crearán índices en las columnas de las tablas para mejorar el rendimiento en las consultas.
Nota: El modelo propuesto es un ejemplo básico y puede ser mejorado o modificado según las necesidades específicas del sistema.

*/

/*
Aquí te presento el código SQL para crear las tablas y las relaciones en una 
base de datos de SQL Server, de acuerdo a la propuesta anterior y agregando 
la nueva tabla "Modelos_URL" para almacenar las URLs de los modelos de vehículos
según la marca:
*/

--CREAR LA BASE DE DATOS VENTAS_VEHICULOS_TOYOTA
CREATE DATABASE VENTAS_VEHICULOS_TOYOTA_2023_V2;
GO

--USAR LA BASE DE DATOS:
USE VENTAS_VEHICULOS_TOYOTA_2023_JPV_2
GO

 --CREAR TABLA Vehiculos

CREATE TABLE Vehiculos (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Modelo VARCHAR(255) NOT NULL,
    Anio INT NOT NULL,
    Precio_compra DECIMAL(18,2) NOT NULL,
	Precio_ventas DECIMAL(18,2) not null,
	Stock int not null
);

 --CREAR TABLA PAIS:

 CREATE TABLE PAIS(
 ID_PAIS INT PRIMARY KEY IDENTITY(1,1),
 NOMBRE_PAIS VARCHAR(50) NOT NULL
 )

 --CREAR TABLA Clientes

CREATE TABLE Clientes (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Telefono VARCHAR(255) NOT NULL,
	ID_pais INT FOREIGN KEY REFERENCES PAIS(ID_PAIS) ON UPDATE CASCADE ON DELETE CASCADE,
);

--CREAR TABLA Empleados:

CREATE TABLE vendedor (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Telefono VARCHAR(255) NOT NULL
);

 --CREAR TABLA Ventas

CREATE TABLE Ventas (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ID_Vehiculo INT FOREIGN KEY REFERENCES Vehiculos(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ID_Cliente INT FOREIGN KEY REFERENCES Clientes(ID) ON UPDATE CASCADE ON DELETE CASCADE,
	ID_Vendedor INT FOREIGN KEY REFERENCES vendedor(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    Fecha_Venta DATE NOT NULL,
	Cantidad int ,
    Precio_Venta DECIMAL(18,2) NOT NULL,
    Total AS Cantidad * Precio_Venta
);

--CREAR TABLA AGREGAR EL CAMPO TOTAL CALCULO:


--SELECCIONAR TABLA PARA VER ESTRUCTURA:

SELECT * FROM vendedor

--CREAR TABLA FOTOS DE VENDEDOR:

create table Fotos_vendedor (
	ID_Foto  int primary key not null,
	foto_Vendedor_url varchar (255) not null,
	ID_vendedor  int not null,
	FOREIGN KEY (ID_vendedor) REFERENCES vendedor (ID)
);
go

--CREAR TABLA signaciones:

CREATE TABLE Asignaciones (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ID_Venta INT FOREIGN KEY REFERENCES Ventas(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ID_Empleado INT FOREIGN KEY REFERENCES vendedor(ID) ON UPDATE CASCADE ON DELETE CASCADE
);

--CREAR TABLA Inventario:

CREATE TABLE Inventario (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ID_Vehiculo INT FOREIGN KEY REFERENCES Vehiculos(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    Cantidad INT NOT NULL
);

CREATE TABLE Modelos_URL (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ID_Vehiculo INT FOREIGN KEY REFERENCES Vehiculos(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    URL VARCHAR(255) NOT NULL
);

--SELECCIONAMOS TODAS LAS TABLAS PARA VER COMO HAN QUEDADO:

SELECT * FROM PAIS
SELECT * FROM Clientes
SELECT * FROM Vehiculos
SELECT * FROM Ventas
SELECT * FROM vendedor
SELECT * FROM Fotos_vendedor
SELECT * FROM Asignaciones
SELECT * FROM Inventario
SELECT * FROM Modelos_URL



/*
Nota: en esta propuesta se asume que el campo Marca en la tabla vehiculos 
se refiere a la marca del vehiculo, por lo tanto se establece una relación 
con la tabla modelos_url para poder tener acceso a la url de ese modelo 
segun la marca.
*/

--INSERTAR 11 REGISTROS EN LA TABLA PAIS:

INSERT INTO PAIS (NOMBRE_PAIS) VALUES
('Republica Dominicana'),
('Estados Unidos'),
('México'),
('Canadá'),
('Argentina'),
('Brasil'),
('España'),
('Francia'),
('Italia'),
('China'),
('Japón')

--ejemplo de cómo insertar 18 registros en cada tabla:

INSERT INTO Vehiculos (Modelo, Anio, Precio_compra, Precio_ventas)
VALUES
('Corolla', 2021, 20000.00, 28000.00),
('Camry', 2021, 25000.00, 35000.00),
('RAV4', 2021, 30000.00, 38000.00),
('Highlander', 2021, 35000.00, 43000.00),
('Tacoma', 2021, 27000.00, 33000.00),
('Tundra', 2021, 35000.00, 39000.00),
('Prius', 2021, 24000.00, 28000.00),
('Yaris', 2021, 18000.00, 21000.00),
('Sienna', 2021, 33000.00, 37000.00),
('4Runner', 2021, 37000.00, 43000.00),
('Supra', 2021, 51000.00, 66000.00),
('Avalon', 2021, 38000.00, 45000.00),
('C-HR', 2021, 22000.00, 28000.00),
('Venza', 2021, 32000.00, 38000.00),
('Mirai', 2021, 50000.00, 65000.00),
('GR Supra', 2021, 55000.00, 65000.00),
('GR 86', 2021, 28000.00, 34000.00),
('Prius Prime', 2021, 28000.00, 35000.00)

--seleccionamos para los registros:

SELECT * FROM Vehiculos

--INSERTAR 10 REGISTROS EN LA TABLA PAIS:

INSERT INTO Clientes (Nombre, Direccion, Telefono, ID_pais) VALUES
    ('María García', 'Calle 2', '809-555-5556',1),
    ('Pedro López', 'Calle 3', '809-555-5557',2),
    ('Ana Martínez', 'Calle 4', '809-555-5558',3),
    ('Luis Hernández', 'Calle 5', '809-555-5559',4),
    ('Marta Gómez', 'Calle 6', '809-555-5560',5),
    ('Jorge Ramírez', 'Calle 7', '809-555-5561',6),
    ('Carla Rodríguez', 'Calle 8', '809-555-5562',7),
    ('Alberto Díaz', 'Calle 9', '849-555-5563',8),
    ('Lucía Sánchez', 'Calle 10', '829-555-5564',9),
    ('David Flores', 'Calle 11', '809-555-5565',10),
    ('Sofía Torres', 'Calle 12', '555-555-5566',11),
    ('Héctor Núñez', 'Calle 13', '555-555-5567',1),
    ('Adriana Ortiz', 'Calle 14', '555-555-5568',1),
    ('Raúl Vargas', 'Calle 15', '555-555-5569',1),
    ('Julia Fernández', 'Calle 16', '555-555-5570',5),
    ('Gustavo Medina', 'Calle 17', '555-555-5571', 6),
    ('Silvia Jiménez', 'Calle 18', '555-555-5572',1),
    ('Mario Aguilar', 'Calle 19', '555-555-5573', 10),
    ('Natalia Ruiz', 'Calle 20', '555-555-5574', 11),
    ('Andrés Castro', 'Calle 21', '555-555-5575', 5),
	('Lidia Pineda', 'Calle 22', '555-555-5576', 1),
    ('Carlos Gutiérrez', 'Calle 23', '555-555-5577', 4),
    ('Marcela Miranda', 'Calle 24', '555-555-5578', 7),
    ('Federico Mendoza', 'Calle 25', '555-555-5579', 8),
    ('Gabriela Torres', 'Calle 26', '555-555-5580', 7),
    ('Diego Sánchez', 'Calle 27', '555-555-5581', 6),
    ('Valeria Gómez', 'Calle 28', '555-555-5582', 1),
    ('Ricardo Salas', 'Calle 29', '555-555-5583', 2),
    ('Isabel García', 'Calle 30', '555-555-5584', 2),
    ('Francisco Méndez', 'Calle 31', '555-555-5585', 4),
    ('Alejandra Vega', 'Calle 32', '555-555-5586', 2),
    ('Javier Ortega', 'Calle 33', '555-555-5587', 7),
    ('Paulina Ramírez', 'Calle 34', '555-555-5588', 1),
    ('Mario Hernández', 'Calle 35', '555-555-5589', 2),
    ('Carolina Torres', 'Calle 36', '555-555-5590', 5),
    ('Andrea Reyes', 'Calle 37', '555-555-5591', 10),
    ('Miguel Jiménez', 'Calle 38', '555-555-5592', 8),
    ('Sara González', 'Calle 39', '555-555-5593', 9),
    ('Eduardo Medina', 'Calle 40', '555-555-5594', 1),
    ('Renata Castellanos', 'Calle 41', '555-555-5595', 1);

--VAMOS HACER UNA CONSULTA PARA LOS REGISTROS:

SELECT * FROM Clientes

SELECT * FROM Ventas

--INSERTAR REGISTROS EN LA TABLA DE VENTAS: 2020

INSERT INTO Ventas (ID_Vehiculo, ID_Cliente, Fecha_Venta, Cantidad, Precio_Venta)
VALUES
(1, 1, '2020-01-01', 1, 20000.00),
(2, 2, '2020-01-02', 1, 25000.00),
(3, 3, '2020-01-03', 2, 30000.00),
(4, 4, '2020-01-04', 1, 35000.00),
(5, 5, '2020-02-05', 1, 27000.00),
(6, 6, '2020-02-06', 1, 35000.00),
(7, 7, '2020-02-07', 1, 24000.00),
(8, 8, '2020-02-08', 1, 18000.00),
(9, 9, '2020-03-09', 2, 33000.00),
(10, 10, '2020-03-10', 1, 37000.00),
(11, 11, '2020-03-11', 1, 51000.00),
(12, 12, '2020-03-12', 1, 38000.00),
(13, 13, '2020-03-13', 1, 22000.00),
(14, 14, '2020-04-14', 1, 32000.00),
(15, 15, '2020-04-15', 2, 50000.00),
(16, 16, '2020-04-16', 1, 55000.00),
(17, 17, '2020-04-17', 1, 28000.00),
(18, 18, '2020-04-18', 1, 28000.00),
(1, 19, '2020-04-01', 1, 20000.00),
(2, 20, '2020-05-02', 1, 25000.00),
(3, 21, '2020-05-03', 2, 30000.00),
(4, 22, '2020-05-04', 1, 35000.00),
(5, 23, '2020-05-05', 1, 27000.00),
(6, 24, '2020-06-06', 1, 35000.00),
(7, 25, '2020-06-07', 1, 24000.00),
(8, 26, '2020-06-08', 1, 18000.00),
(9, 27, '2020-07-09', 2, 33000.00),
(10, 28, '2020-07-10', 1, 37000.00),
(11, 29, '2020-07-11', 1, 51000.00),
(12, 30, '2020-07-12', 1, 38000.00),
(13, 31, '2020-08-13', 1, 22000.00),
(14, 32, '2020-08-14', 1, 32000.00),
(15, 33, '2020-08-15', 2, 50000.00),
(16, 34, '2020-09-16', 1, 55000.00),
(17, 35, '2020-09-17', 1, 28000.00),
(18, 36, '2020-10-18', 1, 28000.00),
(15, 37, '2020-10-15', 2, 50000.00),
(16, 38, '2020-11-16', 1, 55000.00),
(17, 39, '2020-11-17', 1, 28000.00),
(18, 40, '2020-12-18', 1, 28000.00);

--SELECCIONAR LA TABLA PARA VER LOS REGISTROS:

SELECT * FROM Ventas
 
--INSERTAR REGISTROS EN LA TABLA DE VENTAS: 2021

INSERT INTO Ventas (ID_Vehiculo, ID_Cliente, Fecha_Venta, Cantidad, Precio_Venta)
VALUES
(1, 1, '2021-01-01', 1, 20000.00),
(2, 2, '2021-01-02', 1, 25000.00),
(3, 3, '2021-01-03', 2, 30000.00),
(4, 4, '2021-01-04', 1, 35000.00),
(5, 5, '2021-02-05', 1, 27000.00),
(6, 6, '2021-02-06', 1, 35000.00),
(7, 7, '2021-02-07', 1, 24000.00),
(8, 8, '2021-02-08', 1, 18000.00),
(9, 9, '2021-03-09', 2, 33000.00),
(10, 10, '2021-03-10', 1, 37000.00),
(11, 11, '2021-03-11', 1, 51000.00),
(12, 12, '2021-03-12', 1, 38000.00),
(13, 13, '2021-03-13', 1, 22000.00),
(14, 14, '2021-04-14', 1, 32000.00),
(15, 15, '2021-04-15', 2, 50000.00),
(16, 16, '2021-04-16', 1, 55000.00),
(17, 17, '2021-04-17', 1, 28000.00),
(18, 18, '2021-04-18', 1, 28000.00),
(1, 19, '2021-04-01', 1, 20000.00),
(2, 20, '2021-05-02', 1, 25000.00),
(3, 21, '2021-05-03', 2, 30000.00),
(4, 22, '2021-05-04', 1, 35000.00),
(5, 23, '2021-05-05', 1, 27000.00),
(6, 24, '2021-06-06', 1, 35000.00),
(7, 25, '2021-06-07', 1, 24000.00),
(8, 26, '2021-06-08', 1, 18000.00),
(9, 27, '2021-07-09', 2, 33000.00),
(10, 28, '2021-07-10', 1, 37000.00),
(11, 29, '2021-07-11', 1, 51000.00),
(12, 30, '2021-07-12', 1, 38000.00),
(13, 31, '2021-08-13', 1, 22000.00),
(14, 32, '2021-08-14', 1, 32000.00),
(15, 33, '2021-08-15', 2, 50000.00),
(16, 34, '2021-09-16', 1, 55000.00),
(17, 35, '2021-09-17', 1, 28000.00),
(18, 36, '2021-10-18', 1, 28000.00),
(15, 37, '2021-10-15', 2, 50000.00),
(16, 38, '2021-11-16', 1, 55000.00),
(17, 39, '2021-11-17', 1, 28000.00),
(18, 40, '2021-12-18', 1, 28000.00);

--SELECCIONAR LA TABLA PARA VER LOS REGISTROS:

SELECT * FROM Ventas

--INSERTAR REGISTROS EN LA TABLA DE VENTAS: 2022

INSERT INTO Ventas (ID_Vehiculo, ID_Cliente, Fecha_Venta, Cantidad, Precio_Venta)
VALUES
(1, 1, '2022-01-01', 1, 20000.00),
(2, 2, '2022-01-02', 1, 25000.00),
(3, 3, '2022-01-03', 2, 30000.00),
(4, 4, '2022-01-04', 1, 35000.00),
(5, 5, '2022-02-05', 1, 27000.00),
(6, 6, '2022-02-06', 1, 35000.00),
(7, 7, '2022-02-07', 1, 24000.00),
(8, 8, '2022-02-08', 1, 18000.00),
(9, 9, '2022-03-22', 2, 33000.00),
(10, 10, '2022-03-10', 1, 37000.00),
(11, 11, '2022-03-11', 1, 51000.00),
(12, 12, '2022-03-12', 1, 38000.00),
(13, 13, '2022-03-29', 1, 22000.00),
(14, 14, '2022-04-14', 1, 32000.00),
(15, 15, '2022-04-15', 2, 50000.00),
(16, 16, '2022-04-16', 1, 55000.00),
(17, 17, '2022-04-17', 1, 28000.00),
(18, 18, '2022-04-28', 1, 28000.00),
(1, 19, '2022-04-01', 1, 20000.00),
(2, 20, '2022-05-02', 1, 25000.00),
(3, 21, '2022-05-03', 2, 30000.00),
(4, 22, '2022-05-04', 1, 35000.00),
(5, 23, '2022-05-05', 1, 27000.00),
(6, 24, '2022-06-06', 1, 35000.00),
(7, 25, '2022-06-07', 1, 24000.00),
(8, 26, '2022-06-08', 1, 18000.00),
(9, 27, '2022-07-28', 2, 33000.00),
(10, 28, '2022-07-10', 1, 37000.00),
(11, 29, '2022-07-11', 1, 51000.00),
(12, 30, '2022-07-12', 1, 38000.00),
(13, 31, '2022-08-13', 1, 22000.00),
(14, 32, '2022-08-14', 1, 32000.00),
(15, 33, '2022-08-15', 2, 50000.00),
(16, 34, '2022-09-16', 1, 55000.00),
(17, 35, '2022-09-28', 1, 28000.00),
(18, 36, '2022-10-18', 1, 28000.00),
(15, 37, '2022-10-10', 2, 50000.00),
(16, 38, '2022-11-16', 1, 55000.00),
(17, 39, '2022-11-24', 1, 28000.00),
(18, 40, '2022-12-25', 1, 28000.00);

--SELECCIONAR LA TABLA PARA VER LOS REGISTROS:

SELECT * FROM Ventas

--INSERTAR REGISTROS EN LA TABLA DE VENTAS: 2023

INSERT INTO Ventas (ID_Vehiculo, ID_Cliente, Fecha_Venta, Cantidad, Precio_Venta)
VALUES
(1, 1, '2023-01-01', 1, 20000.00),
(2, 2, '2023-01-02', 1, 25000.00),
(3, 3, '2023-01-03', 2, 30000.00),
(4, 4, '2023-01-04', 1, 35000.00),
(5, 5, '2023-01-05', 1, 27000.00),
(6, 6, '2023-01-06', 1, 35000.00),
(7, 7, '2023-01-07', 1, 24000.00),
(8, 8, '2023-01-08', 1, 18000.00),
(9, 9, '2023-02-09', 2, 33000.00),
(10, 10, '2023-02-10', 1, 37000.00),
(11, 11, '2023-02-11', 1, 51000.00),
(12, 12, '2023-02-12', 1, 38000.00),
(13, 13, '2023-02-13', 1, 22000.00),
(14, 14, '2023-02-14', 1, 32000.00),
(15, 15, '2023-02-15', 2, 50000.00),
(16, 16, '2023-02-16', 1, 55000.00),
(17, 17, '2023-02-17', 1, 28000.00),
(18, 18, '2023-02-18', 1, 28000.00),
(1, 19, '2023-03-05', 1, 35000.00),
(5, 23, '2023-03-05', 1, 27000.00),
(6, 24, '2023-03-06', 1, 35000.00),
(7, 25, '2023-03-07', 1, 24000.00),
(8, 26, '2023-03-08', 1, 18000.00),
(9, 27, '2023-03-09', 2, 33000.00),
(10, 28, '2023-03-10', 1, 37000.00),
(11, 29, '2023-03-11', 1, 51000.00),
(12, 30, '2023-03-12', 1, 38000.00),
(13, 31, '2023-04-01', 1, 22000.00),
(14, 32, '2023-04-08', 1, 32000.00),
(15, 33, '2023-04-10', 2, 50000.00),
(16, 34, '2023-04-15', 1, 55000.00),
(17, 35, '2023-04-17', 1, 28000.00),
(18, 36, '2023-04-18', 1, 28000.00),
(15, 37, '2023-04-15', 2, 50000.00),
(16, 38, '2023-04-17', 1, 55000.00),
(17, 39, '2023-04-20', 1, 28000.00),
(18, 40, '2023-04-29', 1, 28000.00);

--SELECCIONAR LA TABLA PARA VER LOS REGISTROS:

SELECT * FROM Ventas

 SELECT * FROM Clientes
 SELECT * FROM Vehiculos
 SELECT * FROM Ventas

 --INSERTAMOS REGISTROS EN LA TABLA Empleados:

INSERT INTO vendedor (Nombre, Direccion, Telefono) VALUES
    ('Juan', 'Calle A', '809-555-5501'),
    ('Maria', 'Calle B', '809-555-5502'),
    ('Carlos', 'Calle C', '809-555-5503'),
    ('Ana', 'Calle D', '809-555-5504'),
    ('Luis', 'Calle E', '809-555-5505'),
    ('Sofia', 'Calle F', '809-555-5506'),
    ('Jorge', 'Calle G', '809-555-5507'),
    ('Juan', 'Calle H', '809-555-5508'),
    ('Gabriela', 'Calle I', '809-555-5509'),
    ('Juan', 'Calle J', '809-555-5510');

	SELECT * FROM vendedor



--INSERTAMOS REGISTROS EN LA TABLA Fotos_vendedor:

insert into Fotos_vendedor values ('1','https://dl.dropbox.com/s/4bz1xriny7ro04g/A40.png','1');
insert into Fotos_vendedor values ('2','https://dl.dropbox.com/s/yxe96df3xrzoc4y/A44.png','2');
insert into Fotos_vendedor values ('3','https://dl.dropbox.com/s/0jkab8w6ie0h91z/A42.png','3');
insert into Fotos_vendedor values ('4','https://dl.dropboxusercontent.com/s/2lks10yyiurw2b0/A33.png','4');
insert into Fotos_vendedor values ('5','https://dl.dropbox.com/s/zgx7g0h0mxubhao/A21.png','5');
insert into Fotos_vendedor values ('6','https://dl.dropboxusercontent.com/s/id0gj57k6z3m73q/A34.png','6');
insert into Fotos_vendedor values ('7','https://dl.dropbox.com/s/1f9hzgblcmuen4a/A10.png','7');
insert into Fotos_vendedor values ('8','https://dl.dropbox.com/s/jveyj0btov87izo/A38.png','8');
insert into Fotos_vendedor values ('9','https://dl.dropbox.com/s/27oq7ocj4q8a0z8/A46.png','9');
insert into Fotos_vendedor values ('10','https://dl.dropbox.com/s/z4geyw1u2psmm47/A16.png','10');

--INSERTAMOS REGISTROS EN LA TABLA Asignaciones:

INSERT INTO Asignaciones (ID_Venta, ID_Empleado) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10);

--SELECIONAR LA TABLA DE VEHICULOS:

SELECT * FROM Vehiculos

--INSERTAMOS REGISTROS EN LA TABLA Inventario:

INSERT INTO Inventario (ID_Vehiculo, Cantidad) VALUES
(1, 20),
(2, 20),
(3, 20),
(4, 20),
(5, 20),
(6, 20),
(7, 20),
(8, 20),
(9, 20),
(10, 20),
(11, 20),
(12, 20),
(13, 20),
(14, 20),
(15, 20),
(16, 20),
(17, 20),
(18, 20);

 --SELECIONAR LA TABLA DE VEHICULOS:

SELECT * FROM Inventario

--INSERTAMOS REGISTROS EN LA TABLA Modelos_URL:

INSERT INTO Modelos_URL (ID_Vehiculo, URL) VALUES
(1, 'https://di-uploads-pod20.dealerinspire.com/rickhendricktoyotaofsandysprings/uploads/2020/03/mlp-img-top-2020-camry.png'),
(2, 'https://deltacomercial.com.do/cdn/modelos/corolla/4b4118996e92823d7e2b472247359fa4.png'),
(3, 'https://www.autolist.com/izmo-photos/2018/18toyota/18toyotarav4leod4ra/toyota_18rav4leod4ra_angularfront.png'),
(4, 'https://platform.cstatic-images.com/xlarge/in/v2/stock_photos/4512b630-7c12-44da-b3c0-70c4950b3a00/dcfa07cf-533b-4f9f-88c8-020603c44d4d.png'),
(5, 'https://www.cars.com/i/large/in/v2/stock_photos/eb246eb0-bb21-4a02-983d-e6021d78c036/40ec83c6-1524-430d-8734-b45b75bd7a4a.png'),
(6, 'https://i0.wp.com/www.transportelatino.com/wp-content/uploads/2017/11/tundra9.jpg?resize=850%2C560&ssl=1'),
(7, 'https://file.kelleybluebookimages.com/kbb/base/evox/CP/9104/2014-Toyota-Sienna-front_9104_032_1870x848_1D6_cropped.png'),
(8, 'https://www.motortrend.com/uploads/sites/10/2015/11/2013-toyota-4runner-sr5-4x4-v6-suv-angular-front.png'),
(9, 'https://platform.cstatic-images.com/xlarge/in/v2/stock_photos/4ecde73e-4769-4e58-9815-d616d321c06b/a5a5cec2-a151-4f4b-aa18-440216b767a7.png'),
(10, 'https://www.motortrend.com/uploads/sites/10/2015/11/2011-toyota-land-cruiser-4wd-suv-angular-front.png?fit=around%7C875:492.1875'),
(11, 'https://www.buyatoyota.com/assets/img/vehicle-info/Prius/2021/hero_image_prius.png'),
(12, 'https://deltacomercial.com.do/cdn/modelos/yaris/yaris-gris-plata.png'),
(13, 'https://www.buyatoyota.com/assets/img/vehicle-info/Supra/2021/supra-hero.png'),
(14, 'https://www.buyatoyota.com/assets/img/vehicle-compare/compare-hero/2021/avalon_hybrid_compare_hero.png'),
(15, 'https://file.kelleybluebookimages.com/kbb/base/evox/CP/14668/2021-Toyota-C-HR-front_14668_032_1831x844_2TA_cropped.png'),
(16, 'https://file.kelleybluebookimages.com/kbb/base/evox/CP/14600/2021-Toyota-Venza-front_14600_032_1816x855_3T3_cropped.png'),
(17, 'https://www.buyatoyota.com/assets/img/vehicle-info/Mirai/2021/hero_image_mirai%20.png'),
(18, 'https://www.cars.com/i/large/in/v2/stock_photos/34b4bfca-ec5a-4bec-b375-1ff695280627/3230f18e-b0e8-4b19-a7d4-06d2f9b4acc6.png');
/*
--(19, 'https://www.toyota.astra.co.id/sites/default/files/2022-08/1%20crystal%20white%20pearl.png'),
--(20, 'https://www.motortrend.com/uploads/sites/10/2020/12/2021-toyota-prius-xle-hybrid-5door-hatchback-angular-front.png');
*/

 SELECT * FROM Clientes
 SELECT * FROM Vehiculos
 SELECT * FROM Ventas

/*

Algunas consultas básicas para obtener todos los registros 
de cada tabla en el modelo de base de datos propuesto:
*/

--Para obtener todos los registros de la tabla "Vehiculos":

SELECT * FROM Vehiculos;

--Para obtener todos los registros de la tabla "Clientes":
SELECT * FROM Clientes;

--Para obtener todos los registros de la tabla "Ventas":
SELECT * FROM Ventas;

--Para obtener todos los registros de la tabla "Empleados":

SELECT * FROM vendedor;
--Para obtener todos los registros de la tabla "Asignaciones":

SELECT * FROM Asignaciones;
--Para obtener todos los registros de la tabla "Inventario":

SELECT * FROM Inventario;
--Para obtener todos los registros de la tabla "Modelos_URL":

SELECT * FROM Modelos_URL;

--Algunas consultas utilizando funciones matemáticas, lógicas y de fecha,
--con conteo, promedio (AVG), entre otras:

--Conteo de vehículos vendidos por año:

SELECT Anio, COUNT(Anio) as Numero_Ventas_x_Año
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
GROUP BY Anio
ORDER BY Anio;

--Promedio de precio de venta de vehículos por año:

SELECT Anio, AVG(Precio_Venta) as Promedio_Precio
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
GROUP BY Anio
ORDER BY Anio;

--Conteo de ventas realizadas por cada empleado:

SELECT vendedor.Nombre, COUNT(Asignaciones.ID_Empleado) as Numero_Ventas
FROM vendedor
INNER JOIN Asignaciones ON vendedor.ID = Asignaciones.ID_Empleado
GROUP BY vendedor.Nombre;

--Conteo de ventas realizadas por cada modelo de vehículo:

SELECT Modelo, COUNT(Ventas.ID_Vehiculo) as Numero_Ventas
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
GROUP BY Modelo;

--Conteo de ventas realizadas en cada mes:

SELECT MONTH(Fecha_Venta) as Mes, COUNT(ID) as Numero_Ventas
FROM Ventas
GROUP BY MONTH(Fecha_Venta);

/*
La siguiente consulta te mostrará el nombre del mes junto con 
el número de ventas realizadas en ese mes:
*/

WITH months(month_number, month_name) AS (
    SELECT 1, 'Enero' UNION
    SELECT 2, 'Febrero' UNION
    SELECT 3, 'Marzo' UNION
    SELECT 4, 'Abril' UNION
    SELECT 5, 'Mayo' UNION
    SELECT 6, 'Junio' UNION
    SELECT 7, 'Julio' UNION
    SELECT 8, 'Agosto' UNION
    SELECT 9, 'Septiembre' UNION
    SELECT 10, 'Octubre' UNION
    SELECT 11, 'Noviembre' UNION
    SELECT 12, 'Diciembre'
)

SELECT months.month_name, COUNT(Ventas.ID) as Numero_Ventas
FROM Ventas
INNER JOIN months ON MONTH(Fecha_Venta) = months.month_number
GROUP BY months.month_name, MONTH(Fecha_Venta)
ORDER BY MONTH(Fecha_Venta);

/*
Esta consulta utiliza una tabla temporal conocida como 
"CTE (Common Table Expression)" que se utiliza para crear 
una tabla temporal, con los nombres de los meses y sus respectivos 
números, que luego se relaciona con la tabla "Ventas" para obtener
el nombre del mes correspondiente al número de mes en la fecha de venta.*/

select * from Vehiculos

--Conteo de ventas realizadas por cada marca:

SELECT Modelo, COUNT(Ventas.ID_Vehiculo) as Numero_Ventas
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
GROUP BY Modelo;

/*
consulta que muestra todos los registros relacionados de las tablas
"Vehiculos", "Clientes", "Ventas", "Empleados" y "Modelos_URL" utilizando JOIN:
*/

SELECT Vehiculos.Modelo, Vehiculos.Anio, Vehiculos.Precio_ventas, Vehiculos.Modelo, 
Clientes.Nombre as Nombre_Cliente, Clientes.Direccion, Clientes.Telefono, 
Ventas.Fecha_Venta, Ventas.Precio_Venta,
vendedor.Nombre as Nombre_Empleado, vendedor.Direccion, vendedor.Telefono,
Modelos_URL.URL
FROM Vehiculos 
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
INNER JOIN vendedor ON Ventas.ID = vendedor.ID
INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo

 --HACER UNA CONSULTA QUE MUESTRE EL ID, MODELO, AÑO, PRECIO DE COMPRA, CLIENTE, DIRECCION, TELEFONO, FECHA, PRECIO_VENTAS, VENDEDOR,IMAGEN URL:

SELECT Vehiculos.ID,Vehiculos.Modelo, Vehiculos.Anio, Vehiculos.Precio_compra,
Clientes.Nombre as Nombre_Cliente, Clientes.Direccion, Clientes.Telefono, 
Ventas.Fecha_Venta, Ventas.Precio_Venta,
vendedor.Nombre as Nombre_Empleado,
Modelos_URL.URL
FROM Vehiculos 
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
INNER JOIN Asignaciones ON Asignaciones.ID_Venta = Ventas.ID
INNER JOIN vendedor ON Asignaciones.ID_Empleado = vendedor.ID
INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo

/*

Esta consulta utiliza JOIN para relacionar las tablas "Vehiculos",
"Clientes", "Ventas", "Empleados" y "Modelos_URL" mediante las claves
foráneas en cada tabla. La consulta devuelve todos los campos de cada
tabla relacionada, incluyendo el modelo, el año, el precio, la marca 
del vehículo, el nombre del cliente, la dirección, el teléfono, la 
fecha de venta, el precio de venta, el nombre del empleado, la dirección,
el teléfono, y la URL del modelo de vehículo.

*/

/*

Para crear una vista a partir de la consulta anterior, puedes
utilizar el siguiente comando en SQL Server:
*/

CREATE or alter VIEW vw_Ventas_Vehiculos
AS
SELECT Vehiculos.ID,Vehiculos.Modelo, Vehiculos.Anio, Vehiculos.Precio_compra,
Clientes.Nombre as Nombre_Cliente, Clientes.Direccion, Clientes.Telefono, 
Ventas.Fecha_Venta, Ventas.Precio_Venta,
vendedor.Nombre as Nombre_Empleado,
Modelos_URL.URL
FROM Vehiculos 
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
INNER JOIN Asignaciones ON Asignaciones.ID_Venta = Ventas.ID
INNER JOIN vendedor ON Asignaciones.ID_Empleado = vendedor.ID
INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo
go

select * from vw_Ventas_Vehiculos

CREATE or alter VIEW vw_Ventas_Vehiculos2
AS
SELECT Vehiculos.Modelo, Vehiculos.Anio, 
Clientes.Nombre as Nombre_Cliente, Clientes.Direccion as Direccion_Cliente, Clientes.Telefono,
Ventas.Fecha_Venta, Vehiculos.Precio_compra, Ventas.Precio_Venta, Ventas.Cantidad, Ventas.Cantidad * Precio_Venta AS Total,
vendedor.Nombre as Nombre_Empleado, vendedor.Direccion as Direccion_Empleado, vendedor.Telefono as Telefono_Empleado,
Modelos_URL.URL,  fv.foto_Vendedor_url, 
Inventario.Cantidad AS Existencia,
SUM(Ventas.Cantidad) as Cantidad_Vendida,
(Inventario.Cantidad - SUM(Ventas.Cantidad)) As Stock_Actual
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
INNER JOIN Asignaciones ON Asignaciones.ID_Venta = Ventas.ID
INNER JOIN vendedor ON Asignaciones.ID_Empleado = vendedor.ID
INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo
INNER JOIN Inventario ON Inventario.ID_Vehiculo = Vehiculos.ID
INNER JOIN Fotos_vendedor FV ON FV.ID_vendedor = vendedor.ID
GROUP BY Vehiculos.Modelo, Vehiculos.Anio, Vehiculos.Precio_ventas, 
Clientes.Nombre, Clientes.Direccion, Clientes.Telefono,
Ventas.Fecha_Venta,Precio_compra, Ventas.Precio_Venta, Ventas.Cantidad,
vendedor.Nombre, vendedor.Direccion, vendedor.Telefono,
Modelos_URL.URL, fv.foto_Vendedor_url, Inventario.Cantidad
go

--VEMOS COMO QUEDA LA VISTA:

SELECT * FROM vw_Ventas_Vehiculos2

/*
Con este comando se crea una vista llamada "vw_Ventas_Vehiculos"
que tiene los mismos resultados que la consulta anterior. La ventaja 
de usar una vista es que puedes acceder a los datos de la consulta 
mediante un nombre simple, como si fuera una tabla, y puedes usarla
en otras consultas
*/

 CREATE OR ALTER VIEW vw_Ventas_Vehiculos5 AS
SELECT Vehiculos.Modelo, Vehiculos.Anio,
Clientes.Nombre AS Nombre_Cliente, Clientes.Direccion AS Direccion_Cliente, Clientes.Telefono,
Ventas.Fecha_Venta, Ventas.Precio_Venta, Ventas.Cantidad, Ventas.Cantidad * Ventas.Precio_Venta AS Total,
vendedor.Nombre AS Nombre_Empleado, vendedor.Direccion AS Direccion_Empleado, vendedor.Telefono AS Telefono_Empleado,
Modelos_URL.URL, FV.foto_Vendedor_url,
SUM(Ventas.Cantidad) AS Cantidad_Vendida,
(Inventario.Cantidad - SUM(Ventas.Cantidad)) AS Stock_Actual
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
INNER JOIN Asignaciones ON Asignaciones.ID_Venta = Ventas.ID
INNER JOIN vendedor ON Asignaciones.ID_Empleado = vendedor.ID
INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo
INNER JOIN Inventario ON Inventario.ID_Vehiculo = Vehiculos.ID
INNER JOIN Fotos_vendedor FV ON FV.ID_vendedor = Empleados.ID
GROUP BY Vehiculos.Modelo, Vehiculos.Anio,
Clientes.Nombre, Clientes.Direccion, Clientes.Telefono,
Ventas.Fecha_Venta, Ventas.Precio_Venta, Ventas.Cantidad,
vendedor.Nombre, vendedor.Direccion, vendedor.Telefono,
Modelos_URL.URL, FV.foto_Vendedor_url, Inventario.Cantidad
ORDER BY Ventas.Fecha_Venta DESC, Vehiculos.Modelo ASC;

  SELECT * FROM vw_Ventas_Vehiculos5

CREATE OR ALTER VIEW vw_Ventas_Vehiculos6
AS
SELECT 
    Vehiculos.Modelo, 
    Vehiculos.Anio, 
    Clientes.Nombre AS Nombre_Cliente, 
    Clientes.Direccion AS Direccion_Cliente, 
    Clientes.Telefono, 
    Ventas.Fecha_Venta, 
    Vehiculos.Precio_compra, 
    Ventas.Precio_Venta, 
    Ventas.Cantidad, 
    Ventas.Cantidad * Precio_Venta AS Total,
    vendedor.Nombre AS Nombre_Empleado, 
    vendedor.Direccion AS Direccion_Empleado, 
    vendedor.Telefono AS Telefono_Empleado,
    Modelos_URL.URL,  
    fv.foto_Vendedor_url, 
    Inventario.Cantidad AS Existencia,
    SUM(Ventas.Cantidad) AS Cantidad_Vendida,
    (Inventario.Cantidad - SUM(Ventas.Cantidad)) AS Stock_Actual
FROM 
    Vehiculos
    INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
    INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
    INNER JOIN Asignaciones ON Asignaciones.ID_Venta = Ventas.ID
    INNER JOIN vendedor ON Asignaciones.ID_Empleado = vendedor.ID
    INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo
    INNER JOIN Inventario ON Inventario.ID_Vehiculo = Vehiculos.ID
    INNER JOIN Fotos_vendedor FV ON FV.ID_vendedor = vendedor.ID
GROUP BY 
    Vehiculos.Modelo, 
    Vehiculos.Anio, 
    Vehiculos.Precio_ventas, 
    Clientes.Nombre, 
    Clientes.Direccion, 
    Clientes.Telefono,
    Ventas.Fecha_Venta, 
    Precio_compra, 
    Ventas.Precio_Venta, 
    Ventas.Cantidad,
    vendedor.Nombre, 
    vendedor.Direccion, 
    vendedor.Telefono,
    Modelos_URL.URL, 
    fv.foto_Vendedor_url, 
    Inventario.Cantidad


	select * from vw_Ventas_Vehiculos6




CREATE VIEW vw_Ventas_Totales AS
SELECT ID, Fecha_Venta, Cantidad, Precio_Venta, Cantidad * Precio_Venta AS Total
FROM Ventas;

select * from vw_Ventas_Totales

INSERT INTO Ventas (ID_Vehiculo, ID_Cliente, Fecha_Venta, Precio_Venta, Cantidad) VALUES
    (1, 1, '2020-01-01', 25000, RAND() * 10),
    (2, 2, '2019-02-01', 22000, RAND() * 10),
    (3, 3, '2018-03-01', 30000, RAND() * 10),
    (4, 4, '2017-04-01', 35000, RAND() * 10),
    (5, 5, '2016-05-01', 27000, RAND() * 10),
    (6, 6, '2015-06-01', 32000, RAND() * 10),
    (7, 7, '2014-07-01', 28000, RAND() * 10),
    (8, 8, '2013-08-01', 31000, RAND() * 10),
    (9, 9, '2012-09-01', 33000, RAND() * 10),
    (10, 10,'2011-10-01', 35000, RAND() * 10);


--Se puede crear un trigger para actualizar el inventario de vehículos cada vez que se realiza una venta o se anula una venta:
CREATE TRIGGER tr_Ventas_Inventario
ON Ventas
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM DELETED)
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            UPDATE Inventario SET Cantidad = Cantidad + (SELECT Cantidad FROM DELETED) - (SELECT Cantidad FROM INSERTED)
            WHERE ID_Vehiculo = (SELECT ID_Vehiculo FROM DELETED);
        END
        ELSE
        BEGIN
            UPDATE Inventario SET Cantidad = Cantidad + (SELECT Cantidad FROM DELETED)
            WHERE ID_Vehiculo = (SELECT ID_Vehiculo FROM DELETED);
        END
    END
    ELSE
    BEGIN
        UPDATE Inventario SET Cantidad = Cantidad - (SELECT Cantidad FROM INSERTED)
        WHERE ID_Vehiculo = (SELECT ID_Vehiculo FROM INSERTED);
    END
END


CREATE or alter  VIEW vw_Vehiculos_Inventario_Ventas AS
SELECT
    v.ID AS ID_Vehiculo,
    v.Modelo,
    v.Anio,
    v.Precio_ventas,
    i.Cantidad AS Existencias,
    SUM(vent.Cantidad) AS Ventas
FROM
    Vehiculos v
    LEFT JOIN Inventario i ON v.ID = i.ID_Vehiculo
    LEFT JOIN Ventas vent ON v.ID = vent.ID_Vehiculo
GROUP BY
    v.ID, v.Modelo, v.Anio, v.Precio_ventas, i.Cantidad



select * from vw_Vehiculos_Inventario_Ventas
select * from Inventario

CREATE or alter VIEW V_Vehiculos_Inventario_Ventas AS
SELECT 
    Vehiculos.ID,
    Modelo,
    Anio,
    Precio_ventas,
    (Inventario.Cantidad - ISNULL(SUM(Ventas.Cantidad), 0)) AS Stock_Actual
FROM 
    Vehiculos
    LEFT JOIN Inventario ON Vehiculos.ID = Inventario.ID_Vehiculo
    LEFT JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
GROUP BY 
    Vehiculos.ID,
    Modelo,
    Anio,
     Precio_ventas,
    Inventario.Cantidad


select * from V_Vehiculos_Inventario_Ventas


CREATE OR ALTER VIEW V_Inventario_Ventas
AS
SELECT DISTINCT
I.ID,
I.ID_Vehiculo as Codigo,
V.ID_Cliente,
C.Nombre as Nombre_Cliente,
V.Fecha_Venta,
V.ID_Vehiculo,
I.Cantidad AS Existencia,
(I.Cantidad - SUM(V.Cantidad)) As Stock_Actual,
v.Cantidad as Cantidad_Vendida
FROM Inventario I
LEFT JOIN Ventas V ON V.ID_Vehiculo = I.ID_Vehiculo
LEFT JOIN Clientes C ON C.ID = V.ID_Cliente
GROUP BY I.ID, I.ID_Vehiculo, I.Cantidad,v.Cantidad, V.ID_Cliente, C.Nombre, V.Fecha_Venta, V.ID_Vehiculo;

select * from V_Inventario_Ventas



CREATE OR ALTER VIEW V_Inventario_Ventas_v2
AS
SELECT DISTINCT
I.ID,
I.ID_Vehiculo as Codigo,
V.ID_Cliente,
C.Nombre as Nombre_Cliente,
V.Fecha_Venta,
V.ID_Vehiculo,
I.Cantidad AS Existencia,
(I.Cantidad - SUM(V.Cantidad)) As Stock_Actual,
v.Cantidad as Cantidad_Vendida
FROM Inventario I
LEFT JOIN Ventas V ON V.ID_Vehiculo = I.ID_Vehiculo
LEFT JOIN Clientes C ON C.ID = V.ID_Cliente
GROUP BY I.ID, I.ID_Vehiculo, I.Cantidad,v.Cantidad, V.ID_Cliente, C.Nombre, V.Fecha_Venta, V.ID_Vehiculo;

select * from V_Inventario_Ventas_v2

CREATE OR ALTER VIEW V_Inventario_Ventas_v3
AS
SELECT
I.ID_Vehiculo as Codigo,
V.ID_Cliente,
C.Nombre as Nombre_Cliente,
I.Cantidad AS Existencia,
SUM(V.Cantidad) as Cantidad_Vendida,

(I.Cantidad - SUM(V.Cantidad)) As Stock_Actual
FROM Inventario I
LEFT JOIN Ventas V ON V.ID_Vehiculo = I.ID_Vehiculo
LEFT JOIN Clientes C ON C.ID = V.ID_Cliente
GROUP BY I.ID_Vehiculo, I.Cantidad, V.ID_Cliente, C.Nombre;

select * from V_Inventario_Ventas_v3


CREATE OR ALTER VIEW V_Inventario_Ventas_v4
AS
SELECT
I.ID_Vehiculo as Codigo,
V.ID_Cliente,
C.Nombre as Nombre_Cliente,
Vehiculos.Modelo,
I.Cantidad AS Existencia,
SUM(V.Cantidad) as Cantidad_Vendida,
(I.Cantidad - SUM(V.Cantidad)) As Stock_Actual
FROM Inventario I
JOIN Ventas V ON V.ID_Vehiculo = I.ID_Vehiculo
JOIN Clientes C ON C.ID = V.ID_Cliente
JOIN Vehiculos ON I.ID_Vehiculo = Vehiculos.ID
INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo
INNER JOIN Inventario ON Inventario.ID_Vehiculo = Vehiculos.ID
GROUP BY I.ID_Vehiculo, I.Cantidad, V.ID_Cliente, C.Nombre, Vehiculos.Modelo;


select * from V_Inventario_Ventas_v4

select * from Ventas
select * from Clientes
select * from Vehiculos
select * from vendedor
select * from Fotos_vendedor

SELECT * FROM Modelos_URL




--SELECCIONAR LA TABLA PARA VER LOS REGISTROS:

SELECT * FROM Ventas 
SELECT * FROM clientes 
SELECT * FROM vendedor 
SELECT * FROM Vehiculos



TRUNCATE TABLE Ventas;


--VAMOS A INSERTAR 50 VEHICULOS:

UPDATE Vehiculos SET Stock = 10000





DECLARE @StartDate DATE = '2020-01-01';
DECLARE @EndDate DATE = '2024-04-10';

WHILE @StartDate <= @EndDate
BEGIN
    DECLARE @VendedoresCursor CURSOR;
    DECLARE @VendorID INT;

    SET @VendedoresCursor = CURSOR FOR
    SELECT ID FROM vendedor;

    OPEN @VendedoresCursor;

    FETCH NEXT FROM @VendedoresCursor INTO @VendorID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @ClientesCursor CURSOR;
        DECLARE @CustomerID INT;

        SET @ClientesCursor = CURSOR FOR
        SELECT ID FROM Clientes;

        OPEN @ClientesCursor;

        FETCH NEXT FROM @ClientesCursor INTO @CustomerID;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @RandomVehicleID INT = (
                SELECT TOP 1 ID
                FROM Vehiculos
                WHERE Stock > 0 -- Tomar vehículos con stock
                ORDER BY NEWID() -- Aleatoriamente
            );

            DECLARE @PrecioVenta DECIMAL(10, 2);

            SELECT @PrecioVenta = ISNULL(Precio_ventas, 0) -- Precio predeterminado si es nulo
            FROM Vehiculos
            WHERE ID = @RandomVehicleID;

            DECLARE @Cantidad INT = ABS(CAST(RAND() * 2 AS INT)) + 1;

            IF @PrecioVenta IS NOT NULL -- Verificar si el precio obtenido no es nulo
            BEGIN
                INSERT INTO Ventas (ID_Vehiculo, ID_Cliente, ID_Vendedor, Fecha_Venta, Cantidad, Precio_Venta)
                VALUES (
                    @RandomVehicleID,
                    @CustomerID,
                    @VendorID,
                    @StartDate,
                    @Cantidad,
                    @PrecioVenta
                );

                -- Actualizar el stock del vehículo después de la venta
                UPDATE Vehiculos
                SET Stock = Stock - @Cantidad
                WHERE ID = @RandomVehicleID;
            END

            FETCH NEXT FROM @ClientesCursor INTO @CustomerID;
        END

        CLOSE @ClientesCursor;
        DEALLOCATE @ClientesCursor;

        FETCH NEXT FROM @VendedoresCursor INTO @VendorID;
    END

    CLOSE @VendedoresCursor;
    DEALLOCATE @VendedoresCursor;

    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END

