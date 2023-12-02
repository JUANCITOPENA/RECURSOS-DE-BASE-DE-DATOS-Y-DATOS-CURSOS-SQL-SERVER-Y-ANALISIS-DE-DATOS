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
CREATE DATABASE VENTAS_VEHICULOS_TOYOTA_2023_V4;
GO

--USAR LA BASE DE DATOS:
USE VENTAS_VEHICULOS_TOYOTA_2023_V4;
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

--SELECCIONAR TABLA PARA VER ESTRUCTURA:

 SELECT * FROM Fotos_vendedor

-- CREAR LA TABLA MODELOS_URL QUE ALMACENA LA IMAGEN:

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

--SELECCIONAMOS LA TABLA:

SELECT * FROM PAIS

--ejemplo de cómo insertar 18 registros en cada tabla:

INSERT INTO Vehiculos (Modelo, Anio, Precio_compra, Precio_ventas, Stock)
VALUES
('Corolla', 2020, 20000.00, 28000.00,20),
('Camry', 2020, 25000.00, 35000.00,20),
('RAV4', 2020, 30000.00, 38000.00,20),
('Highlander', 2020, 35000.00, 43000.00,20),
('Tacoma', 2020, 27000.00, 33000.00,20),
('Tundra', 2020, 35000.00, 39000.00,20),
('Prius', 2020, 24000.00, 28000.00,20),
('Yaris', 2020, 18000.00, 21000.00,20),
('Sienna', 2020, 33000.00, 37000.00,20),
('4Runner', 2020, 37000.00, 43000.00,20),
('Supra', 2020, 51000.00, 66000.00,20),
('Avalon', 2020, 38000.00, 45000.00,20),
('C-HR', 2020, 22000.00, 28000.00,20),
('Venza', 2020, 32000.00, 38000.00,20),
('Mirai', 2020, 50000.00, 65000.00,20),
('GR Supra', 2020, 55000.00, 65000.00,20),
('GR 86', 2020, 28000.00, 34000.00,20),
('Prius Prime', 2020, 28000.00, 35000.00,20)

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
    ('Sofía Torres', 'Calle 12', '809-555-5566',11),
    ('Héctor Núñez', 'Calle 13', '809-555-5567',1),
    ('Adriana Ortiz', 'Calle 14', '809-555-5568',1),
    ('Raúl Vargas', 'Calle 15', '809-555-5569',1),
    ('Julia Fernández', 'Calle 16', '809-555-5570',5),
    ('Gustavo Medina', 'Calle 17', '809-555-5571', 6),
    ('Silvia Jiménez', 'Calle 18', '809-555-5572',1),
    ('Mario Aguilar', 'Calle 19', '809-555-5573', 10),
    ('Natalia Ruiz', 'Calle 20', '809-555-5574', 11),
    ('Andrés Castro', 'Calle 21', '809-555-5575', 5),
	('Lidia Pineda', 'Calle 22', '809-555-5576', 1),
    ('Carlos Gutiérrez', 'Calle 23', '809-555-5577', 4),
    ('Marcela Miranda', 'Calle 24', '809-555-5578', 7),
    ('Federico Mendoza', 'Calle 25', '809-555-5579', 8),
    ('Gabriela Torres', 'Calle 26', '809-555-5580', 7),
    ('Diego Sánchez', 'Calle 27', '809-555-5581', 6),
    ('Valeria Gómez', 'Calle 28', '809-555-5582', 1),
    ('Ricardo Salas', 'Calle 29', '809-555-5583', 2),
    ('Isabel García', 'Calle 30', '809-555-5584', 2),
    ('Francisco Méndez', 'Calle 31', '809-555-5585', 4),
    ('Alejandra Vega', 'Calle 32', '809-555-5586', 2),
    ('Javier Ortega', 'Calle 33', '809-555-5587', 7),
    ('Paulina Ramírez', 'Calle 34', '809-555-5588', 1),
    ('Mario Hernández', 'Calle 35', '809-555-5589', 2),
    ('Carolina Torres', 'Calle 36', '809-555-5590', 5),
    ('Andrea Reyes', 'Calle 37', '809-555-5591', 10),
    ('Miguel Jiménez', 'Calle 38', '809-555-5592', 8),
    ('Sara González', 'Calle 39', '809-555-5593', 9),
    ('Eduardo Medina', 'Calle 40', '809-555-5594', 1),
    ('Renata Castellanos', 'Calle 41', '809-555-5595', 1);

--VAMOS HACER UNA CONSULTA PARA LOS REGISTROS:

SELECT * FROM Clientes

 --INSERTAMOS REGISTROS EN LA TABLA Empleados:

INSERT INTO vendedor (Nombre, Direccion, Telefono) VALUES
    ('Juan Perez', 'Calle A', '809-555-5501'),
    ('Maria Vizcaino', 'Calle B', '809-555-5502'),
    ('Carlos Santos', 'Calle C', '809-555-5503'),
    ('Ana Santana', 'Calle D', '809-555-5504'),
    ('Luis Diaz', 'Calle E', '809-555-5505'),
    ('Sofia Bergara', 'Calle F', '809-555-5506'),
    ('Jorge Ramos', 'Calle G', '809-555-5507'),
    ('Juan Comila', 'Calle H', '809-555-5508'),
    ('Gabriela Mistral', 'Calle I', '809-555-5509'),
    ('Juan Gabrie;', 'Calle J', '809-555-5510');

	--SELECCIONAMOS LA TABLA PARA LOS REGISTROS:

SELECT * FROM vendedor
SELECT * FROM Vehiculos
SELECT * FROM Ventas

--TGrigger que rebaja automaticamente el Stock en la Tabla de Vehiculo cada vez que se realice una venta:

CREATE TRIGGER tr_Ventas_ActualizaStock_v1
ON Ventas
AFTER INSERT
AS
BEGIN
-- Actualizar stock cuando se inserta una o varias ventas
UPDATE Vehiculos
SET Stock = Stock - (SELECT SUM(Cantidad) FROM inserted WHERE inserted.ID_Vehiculo = Vehiculos.ID)
WHERE EXISTS (SELECT * FROM inserted WHERE inserted.ID_Vehiculo = Vehiculos.ID);
END

--Borrar el Trigger:

 DROP TRIGGER  tr_Ventas_ActualizaStock_v1

--Modificar el trigger anterior para validar la cantidad de stock antes de actualizarlo
--y mostrar un mensaje de error si el stock es insuficiente para satisfacer la venta:

CREATE OR ALTER TRIGGER tr_Ventas_ActualizaStock_v2
ON Ventas
AFTER INSERT
AS
BEGIN
    -- Verificar si hay suficiente stock disponible
    IF EXISTS (SELECT * FROM Vehiculos v INNER JOIN inserted i ON v.ID = i.ID_Vehiculo WHERE v.Stock < i.Cantidad)
    BEGIN
        RAISERROR ('Existencia insuficiente', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
    
    -- Actualizar el stock
    UPDATE Vehiculos
    SET Stock = Stock - (SELECT SUM(Cantidad) FROM inserted WHERE inserted.ID_Vehiculo = Vehiculos.ID)
    WHERE EXISTS (SELECT * FROM inserted WHERE inserted.ID_Vehiculo = Vehiculos.ID);
END


--Borrar el Trigger:

 DROP TRIGGER tr_Ventas_ActualizaStock_v2

 CREATE OR ALTER TRIGGER tr_Ventas_ActualizaStock_v4
ON Ventas
AFTER INSERT
AS
BEGIN
    -- Verificar si hay suficiente stock disponible
    IF EXISTS (SELECT * FROM Vehiculos v INNER JOIN inserted i ON v.ID = i.ID_Vehiculo WHERE v.Stock < i.Cantidad)
    BEGIN
        RAISERROR ('Existencia insuficiente, Favor Contactar con Almacen', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
    
    -- Actualizar el stock
    UPDATE Vehiculos
    SET Stock = CASE
        WHEN (Stock - (SELECT SUM(Cantidad) FROM inserted WHERE inserted.ID_Vehiculo = Vehiculos.ID)) < 0 THEN 0
        ELSE (Stock - (SELECT SUM(Cantidad) FROM inserted WHERE inserted.ID_Vehiculo = Vehiculos.ID))
    END
    WHERE EXISTS (SELECT * FROM inserted WHERE inserted.ID_Vehiculo = Vehiculos.ID);
END


--INSERTAR REGISTROS EN LA TABLA DE VENTAS: 2020

INSERT INTO Ventas (ID_Vehiculo, ID_Cliente, ID_Vendedor, Fecha_Venta, Cantidad, Precio_Venta)
VALUES
(1, 1,1, '2020-01-01', 1, 28000.00),
(2, 2,2, '2020-01-02', 1, 35000.00),
(3, 3,3, '2020-01-03', 2, 38000.00),
(4, 4,4, '2020-01-04', 1, 43000.00),
(5, 5,5, '2020-02-05', 1, 33000.00),
(6, 6,6, '2020-02-06', 1, 39000.00),
(7, 7,7, '2020-02-07', 1, 28000.00),
(8, 8,8, '2020-02-08', 1, 21000.00),
(9, 9,9, '2020-03-09', 2, 37000.00),
(10, 10,10,'2020-03-10', 1, 43000.00),
(11, 11,1, '2020-03-11', 1, 66000.00),
(12, 12,2, '2020-03-12', 1, 45000.00),
(13, 13,3, '2020-03-13', 1, 28000.00),
(14, 14,4, '2020-04-14', 1, 38000.00),
(15, 15,5, '2020-04-15', 2, 65000.00),
(16, 16,6, '2020-04-16', 1, 65000.00),
(17, 17,7, '2020-04-17', 1, 34000.00),
(18, 18,8, '2020-04-18', 1, 35000.00),
(1, 19,1, '2020-01-01', 1, 28000.00),
(2, 20,2, '2020-01-02', 1, 35000.00),
(3, 21,3, '2020-01-03', 2, 38000.00),
(4, 22,4, '2020-01-04', 1, 43000.00),
(5, 23,5, '2020-02-05', 1, 33000.00),
(6, 24,6, '2020-02-06', 1, 39000.00),
(7, 25,7, '2020-02-07', 1, 28000.00),
(8, 26,8, '2020-02-08', 1, 21000.00),
(9, 27,9, '2020-03-09', 2, 37000.00),
(10, 28,10,'2020-03-10', 1, 43000.00),
(11, 29,1, '2020-03-11', 1, 66000.00),
(12, 30,2, '2020-03-12', 1, 45000.00),
(13, 31,3, '2020-03-13', 1, 28000.00),
(14, 32,4, '2020-04-14', 1, 38000.00),
(15, 33,5, '2020-04-15', 2, 65000.00),
(16, 34,6, '2020-04-16', 1, 65000.00),
(17, 35,7, '2020-04-17', 1, 34000.00),
(18, 36,8, '2020-04-18', 1, 35000.00),
(15, 37,5, '2020-04-15', 2, 65000.00),
(16, 38,6, '2020-04-16', 1, 65000.00),
(17, 39,7, '2020-04-17', 1, 34000.00),
(18, 40,8, '2020-04-18', 1, 35000.00),
(1, 1,1, '2020-05-01', 1, 28000.00),
(2, 2,2, '2020-05-02', 1, 35000.00),
(3, 3,3, '2020-05-03', 2, 38000.00),
(4, 4,4, '2020-05-04', 1, 43000.00),
(5, 5,5, '2020-06-05', 1, 33000.00),
(6, 6,6, '2020-06-06', 1, 39000.00),
(7, 7,7, '2020-06-07', 1, 28000.00),
(8, 8,8, '2020-07-08', 1, 21000.00),
(9, 9,9, '2020-07-09', 2, 37000.00),
(10, 10,10,'2020-07-10', 1, 43000.00),
(11, 11,1, '2020-08-11', 1, 66000.00),
(12, 12,2, '2020-08-12', 1, 45000.00),
(13, 13,3, '2020-08-13', 1, 28000.00),
(14, 14,4, '2020-08-14', 1, 38000.00),
(15, 15,5, '2020-09-15', 2, 65000.00),
(16, 16,6, '2020-09-16', 1, 65000.00),
(17, 17,7, '2020-09-17', 1, 34000.00),
(18, 18,8, '2020-09-18', 1, 35000.00),
(1, 19,1, '2020-09-01', 1, 28000.00),
(2, 20,2, '2020-10-02', 1, 35000.00),
(3, 21,3, '2020-10-03', 2, 38000.00),
(4, 22,4, '2020-10-04', 1, 43000.00),
(5, 23,5, '2020-10-05', 1, 33000.00),
(6, 24,6, '2020-10-06', 1, 39000.00),
(7, 25,7, '2020-10-07', 1, 28000.00),
(8, 26,8, '2020-10-08', 1, 21000.00),
(9, 27,9, '2020-11-09', 2, 37000.00),
(10, 28,10,'2020-11-10', 1, 43000.00),
(11, 29,1, '2020-11-11', 1, 66000.00),
(12, 30,2, '2020-12-12', 1, 45000.00),
(13, 31,3, '2020-12-13', 1, 28000.00),
(14, 32,4, '2020-12-14', 1, 38000.00),
(15, 33,5, '2020-12-15', 2, 65000.00),
(16, 34,6, '2020-12-16', 1, 65000.00),
(17, 35,7, '2020-12-17', 1, 34000.00),
(18, 36,8, '2020-12-18', 1, 35000.00),
(15, 37,5, '2020-12-25', 2, 65000.00),
(16, 38,6, '2020-12-27', 1, 65000.00),
(17, 39,7, '2020-12-28', 1, 34000.00),
(18, 40,8, '2020-12-31', 1, 35000.00)

--SELECCIONAR LA TABLA PARA VER LOS REGISTROS:

SELECT * FROM Ventas
SELECT * FROM Vehiculos
 
--INSERTAR REGISTROS EN LA TABLA DE VENTAS: 2021

INSERT INTO Ventas (ID_Vehiculo, ID_Cliente, ID_Vendedor, Fecha_Venta, Cantidad, Precio_Venta)
VALUES
(1, 1,1, '2021-01-01', 1, 28000.00),
(2, 2,2, '2021-01-02', 1, 35000.00),
(3, 3,3, '2021-01-03', 2, 38000.00),
(4, 4,4, '2021-01-04', 1, 43000.00),
(5, 5,5, '2021-02-05', 1, 33000.00),
(6, 6,6, '2021-02-06', 1, 39000.00),
(7, 7,7, '2021-02-07', 1, 28000.00),
(8, 8,8, '2021-02-08', 1, 21000.00),
(9, 9,9, '2021-03-09', 2, 37000.00),
(10, 10,10,'2021-03-10', 1, 43000.00),
(11, 11,1, '2021-03-11', 1, 66000.00),
(12, 12,2, '2021-03-12', 1, 45000.00),
(13, 13,3, '2021-03-13', 1, 28000.00),
(14, 14,4, '2021-04-14', 1, 38000.00),
(15, 15,5, '2021-04-15', 2, 65000.00),
(16, 16,6, '2021-04-16', 1, 65000.00),
(17, 17,7, '2021-04-17', 1, 34000.00),
(18, 18,8, '2021-04-18', 1, 35000.00),
(1, 19,1, '2021-01-01', 1, 28000.00),
(2, 20,2, '2021-01-02', 1, 35000.00),
(3, 21,3, '2021-01-03', 2, 38000.00),
(4, 22,4, '2021-01-04', 1, 43000.00),
(5, 23,5, '2021-02-05', 1, 33000.00),
(6, 24,6, '2021-02-06', 1, 39000.00),
(7, 25,7, '2021-02-07', 1, 28000.00),
(8, 26,8, '2021-02-08', 1, 21000.00),
(9, 27,9, '2021-03-09', 2, 37000.00),
(10, 28,10,'2021-03-10', 1, 43000.00),
(11, 29,1, '2021-03-11', 1, 66000.00),
(12, 30,2, '2021-03-12', 1, 45000.00),
(13, 31,3, '2021-03-13', 1, 28000.00),
(14, 32,4, '2021-04-14', 1, 38000.00),
(15, 33,5, '2021-04-15', 2, 65000.00),
(16, 34,6, '2021-04-16', 1, 65000.00),
(17, 35,7, '2021-04-17', 1, 34000.00),
(18, 36,8, '2021-04-18', 1, 35000.00),
(15, 37,5, '2021-04-15', 2, 65000.00),
(16, 38,6, '2021-04-16', 1, 65000.00),
(17, 39,7, '2021-04-17', 1, 34000.00),
(18, 40,8, '2021-04-18', 1, 35000.00),
(1, 1,1, '2021-05-01', 1, 28000.00),
(2, 2,2, '2021-05-02', 1, 35000.00),
(3, 3,3, '2021-05-03', 2, 38000.00),
(4, 4,4, '2021-05-04', 1, 43000.00),
(5, 5,5, '2021-06-05', 1, 33000.00),
(6, 6,6, '2021-06-06', 1, 39000.00),
(7, 7,7, '2021-06-07', 1, 28000.00),
(8, 8,8, '2021-07-08', 1, 21000.00),
(9, 9,9, '2021-07-09', 2, 37000.00),
(10, 10,10,'2021-07-10', 1, 43000.00),
(11, 11,1, '2021-08-11', 1, 66000.00),
(12, 12,2, '2021-08-12', 1, 45000.00),
(13, 13,3, '2021-08-13', 1, 28000.00),
(14, 14,4, '2021-08-14', 1, 38000.00),
(15, 15,5, '2021-09-15', 2, 65000.00),
(16, 16,6, '2021-09-16', 1, 65000.00),
(17, 17,7, '2021-09-17', 1, 34000.00),
(18, 18,8, '2021-09-18', 1, 35000.00),
(1, 19,1, '2021-09-01', 1, 28000.00),
(2, 20,2, '2021-10-02', 1, 35000.00),
(3, 21,3, '2021-10-03', 2, 38000.00),
(4, 22,4, '2021-10-04', 1, 43000.00),
(5, 23,5, '2021-10-05', 1, 33000.00),
(6, 24,6, '2021-10-06', 1, 39000.00),
(7, 25,7, '2021-10-07', 1, 28000.00),
(8, 26,8, '2021-10-08', 1, 21000.00),
(9, 27,9, '2021-11-09', 2, 37000.00),
(10, 28,10,'2021-11-10', 1, 43000.00),
(11, 29,1, '2021-11-11', 1, 66000.00),
(12, 30,2, '2021-12-12', 1, 45000.00),
(13, 31,3, '2021-12-13', 1, 28000.00),
(14, 32,4, '2021-12-14', 1, 38000.00),
(15, 33,5, '2021-12-15', 2, 65000.00),
(16, 34,6, '2021-12-16', 1, 65000.00),
(17, 35,7, '2021-12-17', 1, 34000.00),
(18, 36,8, '2021-12-18', 1, 35000.00),
(15, 37,5, '2021-12-25', 2, 65000.00),
(16, 38,6, '2021-12-27', 1, 65000.00),
(17, 39,7, '2021-12-28', 1, 34000.00),
(18, 40,8, '2021-12-31', 1, 35000.00)

--SELECCIONAR LA TABLA PARA VER LOS REGISTROS:

SELECT * FROM Ventas
SELECT * FROM Vehiculos

--VAMOS A INSERTAR 50 VEHICULOS:

UPDATE Vehiculos SET Stock = 50



--INSERTAR REGISTROS EN LA TABLA DE VENTAS: 2022

INSERT INTO Ventas (ID_Vehiculo, ID_Cliente, ID_Vendedor, Fecha_Venta, Cantidad, Precio_Venta)
VALUES
(1, 1,1, '2022-01-01', 1, 28000.00),
(2, 2,2, '2022-01-02', 1, 35000.00),
(3, 3,3, '2022-01-03', 2, 38000.00),
(4, 4,4, '2022-01-04', 1, 43000.00),
(5, 5,5, '2022-02-05', 1, 33000.00),
(6, 6,6, '2022-02-06', 1, 39000.00),
(7, 7,7, '2022-02-07', 1, 28000.00),
(8, 8,8, '2022-02-08', 1, 21000.00),
(9, 9,9, '2022-03-09', 2, 37000.00),
(10, 10,10,'2022-03-10', 1, 43000.00),
(11, 11,1, '2022-03-11', 1, 66000.00),
(12, 12,2, '2022-03-12', 1, 45000.00),
(13, 13,3, '2022-03-13', 1, 28000.00),
(14, 14,4, '2022-04-14', 1, 38000.00),
(15, 15,5, '2022-04-15', 2, 65000.00),
(16, 16,6, '2022-04-16', 1, 65000.00),
(17, 17,7, '2022-04-17', 1, 34000.00),
(18, 18,8, '2022-04-18', 1, 35000.00),
(1, 19,1, '2022-01-01', 1, 28000.00),
(2, 20,2, '2022-01-02', 1, 35000.00),
(3, 21,3, '2022-01-03', 2, 38000.00),
(4, 22,4, '2022-01-04', 1, 43000.00),
(5, 23,5, '2022-02-05', 1, 33000.00),
(6, 24,6, '2022-02-06', 1, 39000.00),
(7, 25,7, '2022-02-07', 1, 28000.00),
(8, 26,8, '2022-02-08', 1, 21000.00),
(9, 27,9, '2022-03-09', 2, 37000.00),
(10, 28,10,'2022-03-10', 1, 43000.00),
(11, 29,1, '2022-03-11', 1, 66000.00),
(12, 30,2, '2022-03-12', 1, 45000.00),
(13, 31,3, '2022-03-13', 1, 28000.00),
(14, 32,4, '2022-04-14', 1, 38000.00),
(15, 33,5, '2022-04-15', 2, 65000.00),
(16, 34,6, '2022-04-16', 1, 65000.00),
(17, 35,7, '2022-04-17', 1, 34000.00),
(18, 36,8, '2022-04-18', 1, 35000.00),
(15, 37,5, '2022-04-15', 2, 65000.00),
(16, 38,6, '2022-04-16', 1, 65000.00),
(17, 39,7, '2022-04-17', 1, 34000.00),
(18, 40,8, '2022-04-18', 1, 35000.00),
(1, 1,1, '2022-05-01', 1, 28000.00),
(2, 2,2, '2022-05-02', 1, 35000.00),
(3, 3,3, '2022-05-03', 2, 38000.00),
(4, 4,4, '2022-05-04', 1, 43000.00),
(5, 5,5, '2022-06-05', 1, 33000.00),
(6, 6,6, '2022-06-06', 1, 39000.00),
(7, 7,7, '2022-06-07', 1, 28000.00),
(8, 8,8, '2022-07-08', 1, 21000.00),
(9, 9,9, '2022-07-09', 2, 37000.00),
(10, 10,10,'2022-07-10', 1, 43000.00),
(11, 11,1, '2022-08-11', 1, 66000.00),
(12, 12,2, '2022-08-12', 1, 45000.00),
(13, 13,3, '2022-08-13', 1, 28000.00),
(14, 14,4, '2022-08-14', 1, 38000.00),
(15, 15,5, '2022-09-15', 2, 65000.00),
(16, 16,6, '2022-09-16', 1, 65000.00),
(17, 17,7, '2022-09-17', 1, 34000.00),
(18, 18,8, '2022-09-18', 1, 35000.00),
(1, 19,1, '2022-09-01', 1, 28000.00),
(2, 20,2, '2022-10-02', 1, 35000.00),
(3, 21,3, '2022-10-03', 2, 38000.00),
(4, 22,4, '2022-10-04', 1, 43000.00),
(5, 23,5, '2022-10-05', 1, 33000.00),
(6, 24,6, '2022-10-06', 1, 39000.00),
(7, 25,7, '2022-10-07', 1, 28000.00),
(8, 26,8, '2022-10-08', 1, 21000.00),
(9, 27,9, '2022-11-09', 2, 37000.00),
(10, 28,10,'2022-11-10', 1, 43000.00),
(11, 29,1, '2022-11-11', 1, 66000.00),
(12, 30,2, '2022-12-12', 1, 45000.00),
(13, 31,3, '2022-12-13', 1, 28000.00),
(14, 32,4, '2022-12-14', 1, 38000.00),
(15, 33,5, '2022-12-15', 2, 65000.00),
(16, 34,6, '2022-12-16', 1, 65000.00),
(17, 35,7, '2022-12-17', 1, 34000.00),
(18, 36,8, '2022-12-18', 1, 35000.00),
(15, 37,5, '2022-12-25', 2, 65000.00),
(16, 38,6, '2022-12-27', 1, 65000.00),
(17, 39,7, '2022-12-28', 1, 34000.00),
(18, 40,8, '2022-12-31', 1, 35000.00)

--SELECCIONAR LA TABLA PARA VER LOS REGISTROS:

SELECT * FROM Ventas

--INSERTAR REGISTROS EN LA TABLA DE VENTAS: 2023


INSERT INTO Ventas (ID_Vehiculo, ID_Cliente, ID_Vendedor, Fecha_Venta, Cantidad, Precio_Venta)
VALUES
(1, 1,1, '2023-01-01', 1, 28000.00),
(2, 2,2, '2023-01-02', 1, 35000.00),
(3, 3,3, '2023-01-03', 2, 38000.00),
(4, 4,4, '2023-01-04', 1, 43000.00),
(5, 5,5, '2023-02-05', 1, 33000.00),
(6, 6,6, '2023-02-06', 1, 39000.00),
(7, 7,7, '2023-02-07', 1, 28000.00),
(8, 8,8, '2023-02-08', 1, 21000.00),
(9, 9,9, '2023-03-09', 2, 37000.00),
(10, 10,10,'2023-03-10', 1, 43000.00),
(11, 11,1, '2023-03-11', 1, 66000.00),
(12, 12,2, '2023-03-12', 1, 45000.00),
(13, 13,3, '2023-03-13', 1, 28000.00),
(14, 14,4, '2023-04-14', 1, 38000.00),
(15, 15,5, '2023-04-15', 2, 65000.00),
(16, 16,6, '2023-04-16', 1, 65000.00),
(17, 17,7, '2023-04-17', 1, 34000.00),
(18, 18,8, '2023-04-18', 1, 35000.00),
(1, 19,1, '2023-01-01', 1, 28000.00),
(2, 20,2, '2023-01-02', 1, 35000.00),
(3, 21,3, '2023-01-03', 2, 38000.00),
(4, 22,4, '2023-01-04', 1, 43000.00),
(5, 23,5, '2023-02-05', 1, 33000.00),
(6, 24,6, '2023-02-06', 1, 39000.00),
(7, 25,7, '2023-02-07', 1, 28000.00),
(8, 26,8, '2023-02-08', 1, 21000.00),
(9, 27,9, '2023-03-09', 2, 37000.00),
(10, 28,10,'2023-03-10', 1, 43000.00),
(11, 29,1, '2023-03-11', 1, 66000.00),
(12, 30,2, '2023-03-12', 1, 45000.00),
(13, 31,3, '2023-03-13', 1, 28000.00),
(14, 32,4, '2023-04-14', 1, 38000.00),
(15, 33,5, '2023-04-15', 2, 65000.00),
(16, 34,6, '2023-04-16', 1, 65000.00),
(17, 35,7, '2023-04-17', 1, 34000.00),
(18, 36,8, '2023-04-18', 1, 35000.00),
(15, 37,5, '2023-04-15', 2, 65000.00),
(16, 38,6, '2023-04-16', 1, 65000.00),
(17, 39,7, '2023-04-17', 1, 34000.00),
(18, 40,8, '2023-04-18', 1, 35000.00)



--SELECCIONAR LA TABLA PARA VER LOS REGISTROS:

SELECT * FROM Ventas

 SELECT * FROM Clientes
 SELECT * FROM Vehiculos
 SELECT * FROM Ventas


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

--EL MISMO EJEMPLO PERO AGREGANDO CANTIDAD Y MONTO:

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

SELECT months.month_name, COUNT(Ventas.ID) as Numero_Ventas, SUM(Ventas.Cantidad) as Cantidad_Vendida, SUM(Ventas.Total) as Monto_Vendido
FROM Ventas
INNER JOIN months ON MONTH(Fecha_Venta) = months.month_number
GROUP BY months.month_name, MONTH(Fecha_Venta)
ORDER BY MONTH(Fecha_Venta);


--Conteo de ventas realizadas por cada marca:

SELECT Modelo, COUNT(Ventas.ID_Vehiculo) as Numero_Ventas
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
GROUP BY Modelo;


SELECT Modelo, COUNT(Ventas.ID_Vehiculo) as Numero_Ventas, SUM(Ventas.Cantidad) as Cantidad_Vendida, SUM(Ventas.Precio_Venta * Ventas.Cantidad) as Total_Vendido
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
GROUP BY Modelo;




 --HACER UNA CONSULTA QUE MUESTRE EL ID, MODELO, AÑO, PRECIO DE COMPRA, CLIENTE, DIRECCION, TELEFONO, FECHA, PRECIO_VENTAS, VENDEDOR,IMAGEN URL:

SELECT Vehiculos.ID,Vehiculos.Modelo, Vehiculos.Anio as Fecha_Entrada_Almacen, Vehiculos.Precio_compra,
Clientes.Nombre as Nombre_Cliente, Clientes.Direccion, Clientes.Telefono, 
Ventas.Fecha_Venta, Ventas.Precio_Venta,
vendedor.Nombre as Nombre_Empleado,
Modelos_URL.URL	 AS Image_Modelo
FROM Vehiculos 
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
INNER JOIN vendedor ON vendedor.ID= ventas.ID_Vendedor
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


SELECT Vehiculos.ID, Vehiculos.Modelo, YEAR(Ventas.Fecha_Venta) as Año_Venta, Vehiculos.Precio_compra,
Clientes.Nombre as Nombre_Cliente, Clientes.Direccion, Clientes.Telefono, 
Ventas.Fecha_Venta, Ventas.Precio_Venta,
vendedor.Nombre as Nombre_Empleado,
Modelos_URL.URL AS Image_Modelo
FROM Vehiculos 
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
INNER JOIN vendedor ON vendedor.ID = ventas.ID_Vendedor
INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo;


CREATE or alter  VIEW vw_Ventas_Totales AS
SELECT ID, Fecha_Venta, Cantidad, Precio_Venta, Cantidad * Precio_Venta AS Total
FROM Ventas;

select * from vw_Ventas_Totales

select * from Vehiculos
select * from Ventas



CREATE OR ALTER VIEW vw_Ventas_Totales_v4 AS
SELECT V.ID, V.Fecha_Venta, V.Cantidad,
V.Cantidad * VE.Precio_compra as Total_Precio_Compra,
V.Cantidad * V.Precio_Venta AS Total_Precio_Ventas,
(V.Cantidad * (V.Precio_Venta - VE.Precio_compra)) AS Margen_Bruto
FROM Ventas V
INNER JOIN Vehiculos VE ON VE.ID = V.ID_Vehiculo;

 select * from vw_Ventas_Totales_v4


 CREATE OR ALTER VIEW vw_Ventas_Totales_v5 AS
SELECT V.ID, V.Fecha_Venta, V.Cantidad,
V.Cantidad * VE.Precio_compra as Total_Precio_Compra,
V.Cantidad * V.Precio_Venta AS Total_Precio_Ventas,
(V.Cantidad * (V.Precio_Venta - VE.Precio_compra)) AS Margen_total,
((V.Cantidad * (V.Precio_Venta - VE.Precio_compra)) / (V.Cantidad * V.Precio_Venta)) * 100 AS "%_Margen"
FROM Ventas V
INNER JOIN Vehiculos VE ON VE.ID = V.ID_Vehiculo;

 select * from vw_Ventas_Totales_v5


--Vista para ventas de vehículos Toyota por ID:

CREATE VIEW ventas_por_id AS
SELECT 
    Ventas.ID, 
    Vehiculos.Modelo, 
    Ventas.Fecha_Venta,
    Clientes.Nombre AS Nombre_Cliente, 
    Clientes.Direccion, 
    Clientes.Telefono, 
    vendedor.Nombre AS Nombre_Empleado,
    Vehiculos.Precio_compra,
    Ventas.Precio_Venta,
    Ventas.Cantidad,
    Ventas.Total,
    Modelos_URL.URL AS Modelo_URL,
    Fotos_vendedor.foto_Vendedor_url
FROM 
    Ventas 
    JOIN Vehiculos ON Ventas.ID_Vehiculo = Vehiculos.ID
    JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
    JOIN vendedor ON Ventas.ID_Vendedor = vendedor.ID
    JOIN Modelos_URL ON Ventas.ID_Vehiculo = Modelos_URL.ID_Vehiculo
    JOIN Fotos_vendedor ON Ventas.ID_Vendedor = Fotos_vendedor.ID_vendedor;

--SELECCIONAMOS LA VISTA ventas_por_id

SELECT * FROM ventas_por_id


--Vista para ventas de vehículos Toyota por modelo:
CREATE or alter VIEW ventas_por_modelo AS
SELECT 
    Ventas.ID, 
	pais.NOMBRE_PAIS,
    Vehiculos.Modelo, 
    Ventas.Fecha_Venta,
    Clientes.Nombre AS Nombre_Cliente, 
    Clientes.Direccion, 
    Clientes.Telefono, 
    vendedor.Nombre AS Nombre_Empleado,
    Vehiculos.Precio_compra,
    Ventas.Precio_Venta,
    Ventas.Cantidad,
    Ventas.Total,
    Modelos_URL.URL AS Modelo_URL,
    Fotos_vendedor.foto_Vendedor_url
FROM 
    Ventas 
    JOIN Vehiculos ON Ventas.ID_Vehiculo = Vehiculos.ID
    JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
    JOIN vendedor ON Ventas.ID_Vendedor = vendedor.ID
    JOIN Modelos_URL ON Ventas.ID_Vehiculo = Modelos_URL.ID_Vehiculo
    JOIN Fotos_vendedor ON Ventas.ID_Vendedor = Fotos_vendedor.ID_vendedor
	JOIN PAIS ON PAIS.ID_PAIS= Clientes.ID_pais


--SELECCIONAMOS LA VISTA ventas_por_id

SELECT * FROM ventas_por_modelo


--Vista para ventas de vehículos Toyota por fecha de venta:

CREATE OR ALTER VIEW ventas_por_fecha AS
SELECT 
    Ventas.ID, 
    Vehiculos.Modelo, 
    Ventas.Fecha_Venta,
    Clientes.Nombre AS Nombre_Cliente, 
    Clientes.Direccion, 
    Clientes.Telefono, 
    vendedor.Nombre AS Nombre_Empleado,
    Vehiculos.Precio_compra,
    Ventas.Precio_Venta,
    Ventas.Cantidad,
    Ventas.Total,
    Modelos_URL.URL AS Modelo_URL,
    Fotos_vendedor.foto_Vendedor_url
FROM 
    Ventas 
    JOIN Vehiculos ON Ventas.ID_Vehiculo = Vehiculos.ID
    JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
    JOIN vendedor ON Ventas.ID_Vendedor = vendedor.ID
    JOIN Modelos_URL ON Ventas.ID_Vehiculo = Modelos_URL.ID_Vehiculo
    JOIN Fotos_vendedor ON Ventas.ID_Vendedor = Fotos_vendedor.ID_vendedor


--SELECCIONAMOS LA VISTA:

SELECT * FROM ventas_por_fecha




-- VAMOS A CREAR UN TRIGGER QUE ACTUALICE EL INVENTARIO SEGUN SE REALICEN VENTAS:

CREATE TRIGGER tr_Ventas_ActualizaStock
ON Ventas
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Actualizar stock cuando se inserta o actualiza una venta
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        UPDATE Vehiculos
        SET Stock = Stock - (SELECT Cantidad FROM inserted WHERE inserted.ID_Vehiculo = Vehiculos.ID)
        WHERE EXISTS (SELECT * FROM inserted WHERE inserted.ID_Vehiculo = Vehiculos.ID);
    END
    
    -- Actualizar stock cuando se elimina una venta
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        UPDATE Vehiculos
        SET Stock = Stock + (SELECT Cantidad FROM deleted WHERE deleted.ID_Vehiculo = Vehiculos.ID)
        WHERE EXISTS (SELECT * FROM deleted WHERE deleted.ID_Vehiculo = Vehiculos.ID);
    END
END


 DROP TRIGGER tr_Ventas_ActualizaStock





--VAMOS A PROBAR EL TRIGGER:

INSERT INTO Ventas (ID_Vehiculo, ID_Cliente, ID_Vendedor, Fecha_Venta, Cantidad, Precio_Venta)
VALUES
(1, 1,1, '2023-04-28', 4, 28000.00);

SELECT * FROM Vehiculos


--CREAR UNA VISTA CON EL STOCK:

CREATE OR ALTER VIEW VentasToyotaPorFecha AS
SELECT V.ID AS ID_Venta, V.Fecha_Venta, 
    C.Nombre AS Nombre_Cliente, C.Direccion AS Direccion_Cliente, C.Telefono AS Telefono_Cliente, 
    E.Nombre AS Vendedor, 
    VH.Modelo, VH.Precio_compra, VH.Precio_ventas, 
	VH.Stock AS Stock_Inicial, 
	V.Cantidad,
    (VH.Stock - SUM(V.Cantidad)) AS Stock_Actual,
	V.Total, 
    M.URL AS URL_Modelo, 
    F.foto_Vendedor_url AS Foto_Vendedor 
FROM Ventas V
INNER JOIN Vehiculos VH ON V.ID_Vehiculo = VH.ID
INNER JOIN Clientes C ON V.ID_Cliente = C.ID
INNER JOIN vendedor E ON V.ID_Vendedor = E.ID
INNER JOIN Modelos_URL M ON VH.ID = M.ID_Vehiculo
INNER JOIN Fotos_vendedor F ON V.ID_Vendedor = F.ID_vendedor
GROUP BY V.ID, V.Fecha_Venta, V.Cantidad, V.Precio_Venta, V.Total, 
    C.Nombre, C.Direccion, C.Telefono, 
    E.Nombre, 
    VH.Modelo,VH.Precio_compra, VH.Precio_ventas, 
    M.URL, 
    F.foto_Vendedor_url, 
    VH.Stock;

SELECT * FROM VentasToyotaPorFecha


select * from vendedor
select * from Fotos_vendedor

select * from Vehiculos
					  


CREATE OR ALTER VIEW VentasToyotaPorFecha_v2 AS
SELECT V.ID AS ID_Venta, V.Fecha_Venta, p.NOMBRE_PAIS as Pais,
C.Nombre AS Nombre_Cliente, C.Direccion AS Direccion_Cliente, C.Telefono AS Telefono_Cliente,
E.Nombre AS Vendedor,
VH.Modelo, VH.Precio_compra, VH.Precio_ventas,
VH.Stock AS Stock_Inicial,
V.Cantidad,
(VH.Stock - SUM(V.Cantidad)) AS Stock_Actual,
V.Total,
(V.Cantidad * (VH.Precio_ventas - VH.Precio_compra)) AS Margen_bruto,
((V.Cantidad * (VH.Precio_ventas - VH.Precio_compra)) / (V.Cantidad * VH.Precio_ventas)) * 100 AS "%_Margen",
M.URL AS URL_Modelo,
F.foto_Vendedor_url AS Foto_Vendedor
FROM Ventas V
INNER JOIN Vehiculos VH ON V.ID_Vehiculo = VH.ID
INNER JOIN Clientes C ON V.ID_Cliente = C.ID
INNER JOIN vendedor E ON V.ID_Vendedor = E.ID
INNER JOIN PAIS P ON c.ID_pais=p.ID_PAIS
INNER JOIN Modelos_URL M ON VH.ID = M.ID_Vehiculo
INNER JOIN Fotos_vendedor F ON V.ID_Vendedor = F.ID_vendedor
GROUP BY V.ID, V.Fecha_Venta, p.NOMBRE_PAIS,V.Cantidad, V.Precio_Venta, V.Total,
C.Nombre, C.Direccion, C.Telefono,
E.Nombre,
VH.Modelo,VH.Precio_compra, VH.Precio_ventas,
M.URL,
F.foto_Vendedor_url,
VH.Stock;


SELECT * FROM VentasToyotaPorFecha_v2


--Clientes que no han comprado:

CREATE OR ALTER VIEW ClientesSinCompras AS
SELECT C.ID, C.Nombre, C.Direccion, C.Telefono, P.NOMBRE_PAIS as Pais
FROM Clientes C
INNER JOIN PAIS P ON C.ID_pais = P.ID_PAIS
WHERE C.ID NOT IN (SELECT DISTINCT V.ID_Cliente FROM Ventas V);

SELECT * FROM ClientesSinCompras

--Vehículos que no se han vendido:

CREATE OR ALTER VIEW VehiculosSinVentas AS
SELECT VH.ID, VH.Modelo, VH.Precio_compra, VH.Precio_ventas, VH.Stock, M.URL AS URL_Modelo
FROM Vehiculos VH
INNER JOIN Modelos_URL M ON VH.ID = M.ID_Vehiculo
WHERE VH.ID NOT IN (SELECT DISTINCT ID_Vehiculo FROM Ventas);

SELECT * FROM VehiculosSinVentas


--Países sin ventas:

CREATE OR ALTER VIEW PaisesSinVentas AS
SELECT P.ID_PAIS, P.NOMBRE_PAIS
FROM PAIS P
WHERE P.ID_PAIS NOT IN (SELECT DISTINCT C.ID_pais FROM Clientes C INNER JOIN Ventas V ON C.ID = V.ID_Cliente);

SELECT * FROM PaisesSinVentas


--VAMOS A  CREAR UN PROCEDIMIENTO ALMACENADO CON DOS PARAMETROS (FECHA INICIAL Y FINAL)

--El siguiente es un procedimiento almacenado que permitirá hacer consultas en un reporte
--con Cristal Report y C# usando Visual Studio 2019 y 2022. El procedimiento cuenta con dos
--parámetros, la fecha inicial y final, y realiza una selección de información sobre ventas
--de vehículos. La información seleccionada incluye el ID de la venta, la fecha de la venta,
--el país, el cliente, la dirección y teléfono del cliente, el vendedor, la categoría del
--vehículo, el modelo del vehículo, el precio de compra y venta, el stock inicial y actual,
--la cantidad vendida, el total de la venta, el margen bruto y el porcentaje de margen. Además,
--también incluye la URL del modelo y la foto del vendedor.

--El código del procedimiento almacenado es el siguiente:

CREATE OR ALTER PROCEDURE SP_Ventas_PorFecha_v_2023_2
@Fecha_Inicio datetime,
@Fecha_Fin datetime
AS
SELECT V.ID AS ID_Venta, V.Fecha_Venta, p.NOMBRE_PAIS as Pais,
C.Nombre AS Cliente, C.Direccion AS Direccion_Cliente, C.Telefono AS Telefono_Cliente,
E.Nombre AS Vendedor,
CT.Nombre AS Categoria,
VH.Modelo, VH.Precio_compra, VH.Precio_ventas,
VH.Stock AS Stock_Inicial,
V.Cantidad,
(VH.Stock - SUM(V.Cantidad)) AS Stock_Actual,
V.Total,
(V.Cantidad * (VH.Precio_ventas - VH.Precio_compra)) AS Margen_bruto,
((V.Cantidad * (VH.Precio_ventas - VH.Precio_compra)) / (V.Cantidad * VH.Precio_ventas)) * 100 AS "%_Margen"
FROM Ventas V
INNER JOIN Vehiculos VH ON V.ID_Vehiculo = VH.ID
INNER JOIN Vehiculo_Categoria VH_Cat ON VH.ID = VH_Cat.ID_Vehiculo
INNER JOIN categoria CT ON VH_Cat.ID_Categoria = CT.ID
INNER JOIN Clientes C ON V.ID_Cliente = C.ID
INNER JOIN vendedor E ON V.ID_Vendedor = E.ID
INNER JOIN PAIS P ON c.ID_pais=p.ID_PAIS
INNER JOIN Modelos_URL M ON VH.ID = M.ID_Vehiculo
INNER JOIN Fotos_vendedor F ON V.ID_Vendedor = F.ID_vendedor
WHERE V.Fecha_Venta BETWEEN @Fecha_Inicio AND @Fecha_Fin
GROUP BY V.ID, V.Fecha_Venta, p.NOMBRE_PAIS,V.Cantidad, V.Precio_Venta, V.Total,
C.Nombre, C.Direccion, C.Telefono,
E.Nombre,
VH.Modelo,VH.Precio_compra, VH.Precio_ventas,
CT.Nombre,
VH.Stock;



EXEC SP_Ventas_PorFecha_v_2023_2 '2020-01-01', '2020-12-31';


-- CREAMOS UNA VISTA CON EL REPORTE QUE NECESITAMOS:

CREATE OR ALTER VIEW VW_Ventas_PorFecha_v_2023_2
AS
SELECT V.ID AS ID_Venta, V.Fecha_Venta, p.NOMBRE_PAIS as Pais,
C.Nombre AS Cliente, C.Direccion AS Direccion_Cliente, C.Telefono AS Telefono_Cliente,
E.Nombre AS Vendedor, f.foto_Vendedor_url, 
CT.Nombre AS Categoria,
VH.Modelo, m.URL,vh.Precio_compra, VH.Precio_ventas,
VH.Stock AS Stock_Inicial,
V.Cantidad,
(VH.Stock - SUM(V.Cantidad)) AS Stock_Actual,
V.Total,
(V.Cantidad * (VH.Precio_ventas - VH.Precio_compra)) AS Margen_bruto,
((V.Cantidad * (VH.Precio_ventas - VH.Precio_compra)) / (V.Cantidad * VH.Precio_ventas)) * 100 AS "%_Margen"
FROM Ventas V
INNER JOIN Vehiculos VH ON V.ID_Vehiculo = VH.ID
INNER JOIN Vehiculo_Categoria VH_Cat ON VH.ID = VH_Cat.ID_Vehiculo
INNER JOIN categoria CT ON VH_Cat.ID_Categoria = CT.ID
INNER JOIN Clientes C ON V.ID_Cliente = C.ID
INNER JOIN vendedor E ON V.ID_Vendedor = E.ID
INNER JOIN PAIS P ON c.ID_pais=p.ID_PAIS
INNER JOIN Modelos_URL M ON VH.ID = M.ID_Vehiculo
INNER JOIN Fotos_vendedor F ON V.ID_Vendedor = F.ID_vendedor
GROUP BY V.ID, V.Fecha_Venta, p.NOMBRE_PAIS,V.Cantidad, V.Precio_Venta, V.Total,
C.Nombre, C.Direccion, C.Telefono,
E.Nombre,f.foto_Vendedor_url,
VH.Modelo,m.URL,vh.Precio_compra, VH.Precio_ventas,
CT.Nombre,
VH.Stock;

--HACEMOS UN SELECT A LA VISTA Y VEMOS TODOS LOS REGISTROS:

SELECT * FROM VW_Ventas_PorFecha_v_2023_2

