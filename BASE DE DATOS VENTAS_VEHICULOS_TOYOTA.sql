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
CREATE DATABASE VENTAS_VEHICULOS_TOYOTA;
GO

--USAR LA BASE DE DATOS:
USE VENTAS_VEHICULOS_TOYOTA;
GO

CREATE TABLE Vehiculos (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Modelo VARCHAR(255) NOT NULL,
    Anio INT NOT NULL,
    Precio_compra DECIMAL(18,2) NOT NULL,
	Precio_ventas DECIMAL(18,2) not null,
    id_Marca VARCHAR(255) NOT NULL
);

CREATE TABLE Clientes (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Telefono VARCHAR(255) NOT NULL
);

CREATE TABLE Ventas (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ID_Vehiculo INT FOREIGN KEY REFERENCES Vehiculos(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ID_Cliente INT FOREIGN KEY REFERENCES Clientes(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    Fecha_Venta DATE NOT NULL,
	Cantidad int ,
    Precio_Venta DECIMAL(18,2) NOT NULL
);

ALTER TABLE Ventas
ADD Total AS Cantidad * Precio_Venta;



CREATE TABLE Empleados (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Telefono VARCHAR(255) NOT NULL
);

CREATE TABLE Asignaciones (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ID_Venta INT FOREIGN KEY REFERENCES Ventas(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ID_Empleado INT FOREIGN KEY REFERENCES Empleados(ID) ON UPDATE CASCADE ON DELETE CASCADE
);

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

/*
Nota: en esta propuesta se asume que el campo Marca en la tabla vehiculos 
se refiere a la marca del vehiculo, por lo tanto se establece una relación 
con la tabla modelos_url para poder tener acceso a la url de ese modelo 
segun la marca.
*/

--ejemplo de cómo insertar 10 registros en cada tabla:
INSERT INTO Vehiculos (Modelo, Anio, Precio, Marca)
VALUES
('Corolla', 2021, 20000.00, 'Toyota'),
('Camry', 2021, 25000.00, 'Toyota'),
('RAV4', 2021, 30000.00, 'Toyota'),
('Highlander', 2021, 35000.00, 'Toyota'),
('Tacoma', 2021, 27000.00, 'Toyota'),
('Tundra', 2021, 35000.00, 'Toyota'),
('Prius', 2021, 24000.00, 'Toyota'),
('Yaris', 2021, 18000.00, 'Toyota'),
('Sienna', 2021, 33000.00, 'Toyota'),
('4Runner', 2021, 37000.00, 'Toyota'),
('Supra', 2021, 51000.00, 'Toyota'),
('Avalon', 2021, 38000.00, 'Toyota'),
('C-HR', 2021, 22000.00, 'Toyota'),
('Land Cruiser', 2021, 85000.00, 'Toyota'),
('Sequoia', 2021, 50000.00, 'Toyota'),
('Venza', 2021, 32000.00, 'Toyota'),
('Mirai', 2021, 50000.00, 'Toyota'),
('GR Supra', 2021, 55000.00, 'Toyota'),
('GR 86', 2021, 28000.00, 'Toyota'),
('Prius Prime', 2021, 28000.00, 'Toyota');

INSERT INTO Clientes (Nombre, Direccion, Telefono) VALUES
    ('María García', 'Calle 2', '555-555-5556'),
    ('Pedro López', 'Calle 3', '555-555-5557'),
    ('Ana Martínez', 'Calle 4', '555-555-5558'),
    ('Luis Hernández', 'Calle 5', '555-555-5559'),
    ('Marta Gómez', 'Calle 6', '555-555-5560'),
    ('Jorge Ramírez', 'Calle 7', '555-555-5561'),
    ('Carla Rodríguez', 'Calle 8', '555-555-5562'),
    ('Alberto Díaz', 'Calle 9', '555-555-5563'),
    ('Lucía Sánchez', 'Calle 10', '555-555-5564'),
    ('David Flores', 'Calle 11', '555-555-5565'),
    ('Sofía Torres', 'Calle 12', '555-555-5566'),
    ('Héctor Núñez', 'Calle 13', '555-555-5567'),
    ('Adriana Ortiz', 'Calle 14', '555-555-5568'),
    ('Raúl Vargas', 'Calle 15', '555-555-5569'),
    ('Julia Fernández', 'Calle 16', '555-555-5570'),
    ('Gustavo Medina', 'Calle 17', '555-555-5571'),
    ('Silvia Jiménez', 'Calle 18', '555-555-5572'),
    ('Mario Aguilar', 'Calle 19', '555-555-5573'),
    ('Natalia Ruiz', 'Calle 20', '555-555-5574'),
    ('Andrés Castro', 'Calle 21', '555-555-5575'),
	('Lidia Pineda', 'Calle 22', '555-555-5576'),
    ('Carlos Gutiérrez', 'Calle 23', '555-555-5577'),
    ('Marcela Miranda', 'Calle 24', '555-555-5578'),
    ('Federico Mendoza', 'Calle 25', '555-555-5579'),
    ('Gabriela Torres', 'Calle 26', '555-555-5580'),
    ('Diego Sánchez', 'Calle 27', '555-555-5581'),
    ('Valeria Gómez', 'Calle 28', '555-555-5582'),
    ('Ricardo Salas', 'Calle 29', '555-555-5583'),
    ('Isabel García', 'Calle 30', '555-555-5584'),
    ('Francisco Méndez', 'Calle 31', '555-555-5585'),
    ('Alejandra Vega', 'Calle 32', '555-555-5586'),
    ('Javier Ortega', 'Calle 33', '555-555-5587'),
    ('Paulina Ramírez', 'Calle 34', '555-555-5588'),
    ('Mario Hernández', 'Calle 35', '555-555-5589'),
    ('Carolina Torres', 'Calle 36', '555-555-5590'),
    ('Andrea Reyes', 'Calle 37', '555-555-5591'),
    ('Miguel Jiménez', 'Calle 38', '555-555-5592'),
    ('Sara González', 'Calle 39', '555-555-5593'),
    ('Eduardo Medina', 'Calle 40', '555-555-5594'),
    ('Renata Castellanos', 'Calle 41', '555-555-5595');

INSERT INTO Ventas (ID_Vehiculo, ID_Cliente, Fecha_Venta, Precio_Venta, Cantidad) VALUES
    (1, 1, '2020-01-01', 25000,1),
    (2, 2, '2019-02-01', 22000,2),
    (3, 3, '2018-03-01', 30000, 5),
    (4, 4, '2017-04-01', 35000, 3),
    (5, 5, '2016-05-01', 27000, 2),
    (6, 6, '2015-06-01', 32000, 0),
    (7, 7, '2014-07-01', 28000, 3),
    (8, 8, '2013-08-01', 31000, 6),
    (9, 9, '2012-09-01', 33000, 1),
    (10, 10,'2011-10-01', 35000, 3);

INSERT INTO Empleados (Nombre, Direccion, Telefono) VALUES
    ('Juan', 'Calle A', '555-555-5555'),
    ('Maria', 'Calle B', '555-555-5555'),
    ('Carlos', 'Calle C', '555-555-5555'),
    ('Ana', 'Calle D', '555-555-5555'),
    ('Luis', 'Calle E', '555-555-5555'),
    ('Sofia', 'Calle F', '555-555-5555'),
    ('Jorge', 'Calle G', '555-555-5555'),
    ('Juan', 'Calle H', '555-555-5555'),
    ('Gabriela', 'Calle I', '555-555-5555'),
    ('Juan', 'Calle J', '555-555-5555');

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

INSERT INTO Inventario (ID_Vehiculo, Cantidad) VALUES
(1, 10),
(2, 20),
(3, 15),
(4, 5),
(5, 30),
(6, 40),
(7, 25),
(8, 35),
(9, 45),
(10, 50);

INSERT INTO Modelos_URL (ID_Vehiculo, URL) VALUES
(1, 'https://www.toyota.com/camry'),
(2, 'https://www.toyota.com/corolla'),
(3, 'https://www.toyota.com/rav4'),
(4, 'https://www.toyota.com/highlander'),
(5, 'https://www.toyota.com/tacoma'),
(6, 'https://www.toyota.com/tundra'),
(7, 'https://www.toyota.com/sienna'),
(8, 'https://www.toyota.com/4runner'),
(9, 'https://www.toyota.com/sequoia'),
(10, 'https://www.toyota.com/landcruiser');


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

SELECT * FROM Empleados;
--Para obtener todos los registros de la tabla "Asignaciones":

SELECT * FROM Asignaciones;
--Para obtener todos los registros de la tabla "Inventario":

SELECT * FROM Inventario;
--Para obtener todos los registros de la tabla "Modelos_URL":

SELECT * FROM Modelos_URL;

--Algunas consultas utilizando funciones matemáticas, lógicas y de fecha,
--con conteo, promedio (AVG), entre otras:

--Conteo de vehículos vendidos por año:

SELECT Anio, COUNT(Anio) as Numero_Ventas
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

SELECT Empleados.Nombre, COUNT(Asignaciones.ID_Empleado) as Numero_Ventas
FROM Empleados
INNER JOIN Asignaciones ON Empleados.ID = Asignaciones.ID_Empleado
GROUP BY Empleados.Nombre;

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


--Conteo de ventas realizadas por cada marca:

SELECT Marca, COUNT(Ventas.ID_Vehiculo) as Numero_Ventas
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
GROUP BY Marca;

/*
consulta que muestra todos los registros relacionados de las tablas
"Vehiculos", "Clientes", "Ventas", "Empleados" y "Modelos_URL" utilizando JOIN:
*/

SELECT Vehiculos.Modelo, Vehiculos.Anio, Vehiculos.Precio, Vehiculos.Marca, 
Clientes.Nombre as Nombre_Cliente, Clientes.Direccion, Clientes.Telefono, 
Ventas.Fecha_Venta, Ventas.Precio_Venta,
Empleados.Nombre as Nombre_Empleado, Empleados.Direccion, Empleados.Telefono,
Modelos_URL.URL
FROM Vehiculos 
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
INNER JOIN Empleados ON Ventas.ID = Empleados.ID
INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo


SELECT Vehiculos.Modelo, Vehiculos.Anio, Vehiculos.Precio, Vehiculos.Marca, 
Clientes.Nombre as Nombre_Cliente, Clientes.Direccion, Clientes.Telefono, 
Ventas.Fecha_Venta, Ventas.Precio_Venta,
Empleados.Nombre as Nombre_Empleado, Empleados.Direccion, Empleados.Telefono,
Modelos_URL.URL
FROM Vehiculos 
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
INNER JOIN Asignaciones ON Asignaciones.ID_Venta = Ventas.ID
INNER JOIN Empleados ON Asignaciones.ID_Empleado = Empleados.ID
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
SELECT Vehiculos.Modelo, Vehiculos.Anio, Vehiculos.Precio, Vehiculos.Marca, 
Clientes.Nombre as Nombre_Cliente, Clientes.Direccion as Direccion_Cliente, Clientes.Telefono, 
Ventas.Fecha_Venta, Ventas.Precio_Venta, Ventas.Cantidad,Ventas.Cantidad * Precio_Venta AS Total,
Empleados.Nombre as Nombre_Empleado, Empleados.Direccion as Direccion_Empleado, Empleados.Telefono as Telefono_Empleado,
Modelos_URL.URL
FROM Vehiculos 
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
INNER JOIN Asignaciones ON Asignaciones.ID_Venta = Ventas.ID
INNER JOIN Empleados ON Asignaciones.ID_Empleado = Empleados.ID
INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo
go

select * from vw_Ventas_Vehiculos2

CREATE or alter VIEW vw_Ventas_Vehiculos2
AS
SELECT Vehiculos.Modelo, Vehiculos.Anio, Vehiculos.Precio, Vehiculos.Marca,
Clientes.Nombre as Nombre_Cliente, Clientes.Direccion as Direccion_Cliente, Clientes.Telefono,
Ventas.Fecha_Venta, Ventas.Precio_Venta, Ventas.Cantidad, Ventas.Cantidad * Precio_Venta AS Total,
Empleados.Nombre as Nombre_Empleado, Empleados.Direccion as Direccion_Empleado, Empleados.Telefono as Telefono_Empleado,
Modelos_URL.URL,
Inventario.Cantidad AS Existencia,
SUM(Ventas.Cantidad) as Cantidad_Vendida,
(Inventario.Cantidad - SUM(Ventas.Cantidad)) As Stock_Actual
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
INNER JOIN Asignaciones ON Asignaciones.ID_Venta = Ventas.ID
INNER JOIN Empleados ON Asignaciones.ID_Empleado = Empleados.ID
INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo
INNER JOIN Inventario ON Inventario.ID_Vehiculo = Vehiculos.ID
GROUP BY Vehiculos.Modelo, Vehiculos.Anio, Vehiculos.Precio, Vehiculos.Marca,
Clientes.Nombre, Clientes.Direccion, Clientes.Telefono,
Ventas.Fecha_Venta, Ventas.Precio_Venta, Ventas.Cantidad,
Empleados.Nombre, Empleados.Direccion, Empleados.Telefono,
Modelos_URL.URL, Inventario.Cantidad
go

ALTER TABLE Ventas
ADD Total AS Cantidad * Precio_Venta;

/*
Con este comando se crea una vista llamada "vw_Ventas_Vehiculos"
que tiene los mismos resultados que la consulta anterior. La ventaja 
de usar una vista es que puedes acceder a los datos de la consulta 
mediante un nombre simple, como si fuera una tabla, y puedes usarla
en otras consultas
*/

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
    v.Precio,
    v.Marca,
    i.Cantidad AS Existencias,
    SUM(vent.Cantidad) AS Ventas
FROM
    Vehiculos v
    LEFT JOIN Inventario i ON v.ID = i.ID_Vehiculo
    LEFT JOIN Ventas vent ON v.ID = vent.ID_Vehiculo
GROUP BY
    v.ID, v.Modelo, v.Anio, v.Precio, v.Marca, i.Cantidad



select * from vw_Vehiculos_Inventario_Ventas
select * from Inventario

CREATE or alter VIEW V_Vehiculos_Inventario_Ventas AS
SELECT 
    Vehiculos.ID,
    Modelo,
    Anio,
    Precio,
    Marca,
    (Inventario.Cantidad - ISNULL(SUM(Ventas.Cantidad), 0)) AS Stock_Actual
FROM 
    Vehiculos
    LEFT JOIN Inventario ON Vehiculos.ID = Inventario.ID_Vehiculo
    LEFT JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
GROUP BY 
    Vehiculos.ID,
    Modelo,
    Anio,
    Precio,
    Marca,
    Inventario.Cantidad


select * from V_Inventario_Ventas


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

CREATE OR ALTER VIEW V_Inventario_Ventas
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

CREATE OR ALTER VIEW V_Inventario_Ventas
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
LEFT JOIN Ventas V ON V.ID_Vehiculo = I.ID_Vehiculo
LEFT JOIN Clientes C ON C.ID = V.ID_Cliente
LEFT JOIN Vehiculos ON I.ID_Vehiculo = Vehiculos.ID
GROUP BY I.ID_Vehiculo, I.Cantidad, V.ID_Cliente, C.Nombre, Vehiculos.Modelo;

select * from V_Inventario_Ventas
select * from vw_Ventas_Vehiculos2