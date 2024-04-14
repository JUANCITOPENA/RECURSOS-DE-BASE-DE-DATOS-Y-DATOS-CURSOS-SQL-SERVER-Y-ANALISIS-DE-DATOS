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
CREATE DATABASE VENTAS_VEHICULOS_TOYOTA_2023_V5;
GO

--USAR LA BASE DE DATOS:
USE VENTAS_VEHICULOS_TOYOTA_2023_V5
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

CREATE TABLE Modelos_URL (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ID_Vehiculo INT FOREIGN KEY REFERENCES Vehiculos(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    URL VARCHAR(255) NOT NULL
);


-- CREAR TABLA Asignaciones:

CREATE TABLE Asignaciones (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ID_Venta INT FOREIGN KEY REFERENCES Ventas(ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    ID_Vendedor INT FOREIGN KEY REFERENCES Vendedor(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);


SELECT * FROM Asignaciones

--CREAR TABLA Inventario:

CREATE TABLE Inventario (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ID_Vehiculo INT FOREIGN KEY REFERENCES Vehiculos(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    Cantidad INT NOT NULL
);

SELECT * FROM Inventario

--Para crear la tabla categoría y relacionarla con la tabla Vehiculos, podemos utilizar el siguiente código:

--CREAR TABLA Categoria

CREATE TABLE Categoria (
ID INT PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(255) NOT NULL
);

-- CREAR TABLA Vehiculo_Categoria

CREATE TABLE Vehiculo_Categoria (
ID_Vehiculo INT FOREIGN KEY REFERENCES Vehiculos(ID) ON UPDATE CASCADE ON DELETE CASCADE,
ID_Categoria INT FOREIGN KEY REFERENCES Categoria(ID) ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY (ID_Vehiculo, ID_Categoria)
);

	
/*
La tabla Categoria tiene un campo de ID autoincrementable y un campo de Nombre para el nombre de
la categoría. La tabla Vehiculo_Categoria tiene dos campos de clave foránea que se relacionan con 
la tabla Vehiculos y la tabla Categoria, respectivamente. Esta tabla funciona como una tabla de 
unión entre Vehiculos y Categoria, ya que permite relacionar varios vehículos con una o varias 
categorías. La clave primaria se compone de los campos de clave foránea ID_Vehiculo y ID_Categoria.

*/


SELECT * FROM PAIS
SELECT * FROM Clientes
SELECT * FROM Vehiculos
SELECT * FROM Ventas
SELECT * FROM vendedor
SELECT * FROM Fotos_vendedor
SELECT * FROM Asignaciones
SELECT * FROM Inventario
SELECT * FROM Modelos_URL
SELECT * FROM Vehiculo_Categoria
SELECT * FROM Categoria

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

-- PODEMOS HACER UN INSERT CON CANTIDAD O PONER CERO CANTIDAD COMO EN LO SIGUINETE:

INSERT INTO Vehiculos (Modelo, Anio, Precio_compra, Precio_ventas, Stock)
VALUES
('Corolla', 2021, 20000.00, 28000.00, 0),
('Camry', 2021, 25000.00, 35000.00, 0),
('RAV4', 2021, 30000.00, 38000.00, 0),
('Highlander', 2021, 35000.00, 43000.00, 0),
('Tacoma', 2021, 27000.00, 33000.00, 0),
('Tundra', 2021, 35000.00, 39000.00, 0),
('Prius', 2021, 24000.00, 28000.00, 0),
('Yaris', 2021, 18000.00, 21000.00, 0),
('Sienna', 2021, 33000.00, 37000.00, 0),
('4Runner', 2021, 37000.00, 43000.00, 0),
('Supra', 2021, 51000.00, 66000.00, 0),
('Avalon', 2021, 38000.00, 45000.00, 0),
('C-HR', 2021, 22000.00, 28000.00, 0),
('Venza', 2021, 32000.00, 38000.00, 0),
('Mirai', 2021, 50000.00, 65000.00, 0),
('GR Supra', 2021, 55000.00, 65000.00, 0),
('GR 86', 2021, 28000.00, 34000.00, 0),
('Prius Prime', 2021, 28000.00, 35000.00, 0);


--Y LUEGO HACER UN UPDATE A TODOS CON :

UPDATE Vehiculos
SET Stock = 1000;


-- O PODEMOS HACER UN  HACER UN INSERT COMO ESTE 20 VEHICULOS PARA TODOS:

-- Insertar datos en la nueva tabla Vehiculos con el ID ajustado
INSERT INTO Vehiculos (Modelo, Anio, Precio_compra, Precio_ventas, Stock)
SELECT Modelo, Anio, Precio_compra, Precio_ventas, Stock
FROM (
    VALUES
    ('Corolla', 2021, 20000.00, 28000.00, 20),
    ('Camry', 2021, 25000.00, 35000.00, 20),
    ('RAV4', 2021, 30000.00, 38000.00, 20),
    ('Highlander', 2021, 35000.00, 43000.00, 20),
    ('Tacoma', 2021, 27000.00, 33000.00, 20),
    ('Tundra', 2021, 35000.00, 39000.00, 20),
    ('Prius', 2021, 24000.00, 28000.00, 20),
    ('Yaris', 2021, 18000.00, 21000.00, 20),
    ('Sienna', 2021, 33000.00, 37000.00, 20),
    ('4Runner', 2021, 37000.00, 43000.00, 20),
    ('Supra', 2021, 51000.00, 66000.00, 20),
    ('Avalon', 2021, 38000.00, 45000.00, 20),
    ('C-HR', 2021, 22000.00, 28000.00, 20),
    ('Venza', 2021, 32000.00, 38000.00, 20),
    ('Mirai', 2021, 50000.00, 65000.00, 20),
    ('GR Supra', 2021, 55000.00, 65000.00, 20),
    ('GR 86', 2021, 28000.00, 34000.00, 20),
    ('Prius Prime', 2021, 28000.00, 35000.00, 20)
) AS V (Modelo, Anio, Precio_compra, Precio_ventas, Stock);

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


--seleccionamos para los registros:

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

--seleccionamos para los registros:

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



-- Insertar las categorías correspondientes a cada modelo

INSERT INTO Categoria (Nombre) VALUES
('Sedán'),
('SUV'),
('Pickup'),
('Híbrido'),
('Deportivo');

-- Asignar categorías a cada vehículo en la tabla Vehiculo_Categoria
INSERT INTO Vehiculo_Categoria (ID_Vehiculo, ID_Categoria) VALUES
(1, 1), -- Corolla -> Sedán
(2, 1), -- Camry -> Sedán
(3, 2), -- RAV4 -> SUV
(4, 2), -- Highlander -> SUV
(5, 3), -- Tacoma -> Pickup
(6, 3), -- Tundra -> Pickup
(7, 4), -- Prius -> Híbrido
(8, 1), -- Yaris -> Sedán
(9, 2), -- Sienna -> SUV
(10, 2), -- 4Runner -> SUV
(11, 5), -- Supra -> Deportivo
(12, 1), -- Avalon -> Sedán
(13, 2), -- C-HR -> SUV
(14, 2), -- Venza -> SUV
(15, 4), -- Mirai -> Híbrido
(16, 5), -- GR Supra -> Deportivo
(17, 5), -- GR 86 -> Deportivo
(18, 4); -- Prius Prime -> Híbrido

--SELECCIONAMOS TODAS LAS TABLAS PARA VER COMO HAN QUEDADO:


SELECT * FROM vendedor

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



SELECT * FROM Modelos_URL

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


--VAMOS HACER UNA CONSULTA PARA LOS REGISTROS:

SELECT * FROM Clientes

SELECT * FROM Ventas


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

-------

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
(18, 40,8, '2023-04-18', 1, 35000.00),
(1, 1, 1, '2023-05-01', 1, 28000.00),
(2, 2, 2, '2023-05-02', 1, 35000.00),
(3, 3, 3, '2023-05-03', 2, 38000.00),
(4, 4, 4, '2023-05-04', 1, 43000.00),
(5, 5, 5, '2023-06-05', 1, 33000.00),
(6, 6, 6, '2023-06-06', 1, 39000.00),
(7, 7, 7, '2023-06-07', 1, 28000.00),
(8, 8, 8, '2023-06-08', 1, 21000.00),
(9, 9, 9, '2023-07-09', 2, 37000.00),
(10, 10, 10, '2023-07-10', 1, 43000.00),
(11, 11, 1, '2023-07-11', 1, 66000.00),
(12, 12, 2, '2023-07-12', 1, 45000.00),
(13, 13, 3, '2023-07-13', 1, 28000.00),
(14, 14, 4, '2023-08-14', 1, 38000.00),
(15, 15, 5, '2023-08-15', 2, 65000.00),
(16, 16, 6, '2023-08-16', 1, 65000.00),
(17, 17, 7, '2023-08-17', 1, 34000.00),
(18, 18, 8, '2023-08-18', 1, 35000.00),
(1, 19, 1, '2023-09-01', 1, 28000.00),
(2, 20, 2, '2023-09-02', 1, 35000.00),
(3, 21, 3, '2023-09-03', 2, 38000.00),
(4, 22, 4, '2023-09-04', 1, 43000.00),
(5, 23, 5, '2023-10-05', 1, 33000.00),
(6, 24, 6, '2023-10-06', 1, 39000.00),
(7, 25, 7, '2023-10-07', 1, 28000.00),
(8, 26, 8, '2023-10-08', 1, 21000.00),
(9, 27, 9, '2023-11-09', 2, 37000.00),
(10, 28, 10, '2023-11-10', 1, 43000.00),
(11, 29, 1, '2023-11-11', 1, 66000.00),
(12, 30, 2, '2023-11-12', 1, 45000.00),
(13, 31, 3, '2023-11-13', 1, 28000.00),
(14, 32, 4, '2023-12-14', 1, 38000.00),
(15, 33, 5, '2023-12-15', 2, 65000.00),
(16, 34, 6, '2023-12-16', 1, 65000.00),
(17, 35, 7, '2023-12-17', 1, 34000.00),
(18, 36, 8, '2023-12-18', 1, 35000.00),
(15, 37, 5, '2023-12-25', 2, 65000.00),
(16, 38, 6, '2023-12-27', 1, 65000.00),
(17, 39, 7, '2023-12-28', 1, 34000.00),
(18, 40, 8, '2023-12-31', 1, 35000.00);


INSERT INTO Ventas (ID_Vehiculo, ID_Cliente, ID_Vendedor, Fecha_Venta, Cantidad, Precio_Venta)
VALUES
(5, 5, 5, '2024-01-05', 1, 33000.00),
(6, 6, 6, '2024-01-06', 1, 39000.00),
(7, 7, 7, '2024-01-07', 1, 28000.00),
(8, 8, 8, '2024-01-08', 1, 21000.00),
(9, 9, 9, '2024-01-09', 2, 37000.00),
(10, 10, 10, '2024-01-10', 1, 43000.00),
(11, 11, 1, '2024-01-11', 1, 66000.00),
(12, 12, 2, '2024-01-12', 1, 45000.00),
(13, 13, 3, '2024-01-13', 1, 28000.00),
(14, 14, 4, '2024-01-14', 1, 38000.00),
(15, 15, 5, '2024-01-15', 2, 65000.00),
(16, 16, 6, '2024-01-16', 1, 65000.00),
(17, 17, 7, '2024-01-17', 1, 34000.00),
(18, 18, 8, '2024-01-18', 1, 35000.00),
(1, 19, 1, '2024-01-19', 1, 28000.00),
(2, 20, 2, '2024-01-20', 1, 35000.00),
(3, 21, 3, '2024-01-21', 2, 38000.00),
(4, 22, 4, '2024-01-22', 1, 43000.00),
(5, 23, 5, '2024-01-23', 1, 33000.00),
(6, 24, 6, '2024-01-24', 1, 39000.00),
(7, 25, 7, '2024-01-25', 1, 28000.00),
(8, 26, 8, '2024-01-26', 1, 21000.00),
(9, 27, 9, '2024-01-27', 2, 37000.00),
(10, 28, 10, '2024-01-28', 1, 43000.00),
(11, 29, 1, '2024-01-29', 1, 66000.00),
(12, 30, 2, '2024-01-30', 1, 45000.00),
(13, 31, 3, '2024-01-31', 1, 28000.00),
(14, 32, 4, '2024-02-01', 1, 38000.00),
(15, 33, 5, '2024-02-02', 2, 65000.00),
(16, 34, 6, '2024-02-03', 1, 65000.00),
(17, 35, 7, '2024-02-04', 1, 34000.00),
(18, 36, 8, '2024-02-05', 1, 35000.00),
(15, 37, 5, '2024-02-06', 2, 65000.00),
(16, 38, 6, '2024-02-07', 1, 65000.00),
(17, 39, 7, '2024-02-08', 1, 34000.00),
(18, 40, 8, '2024-02-09', 1, 35000.00);


INSERT INTO Ventas (ID_Vehiculo, ID_Cliente, ID_Vendedor, Fecha_Venta, Cantidad, Precio_Venta)
VALUES
(1, 1, 1, '2024-02-10', 1, 28000.00),
(2, 2, 2, '2024-02-11', 1, 35000.00),
(3, 3, 3, '2024-02-12', 2, 38000.00),
(4, 4, 4, '2024-02-13', 1, 43000.00),
(5, 5, 5, '2024-02-14', 1, 33000.00),
(6, 6, 6, '2024-02-15', 1, 39000.00),
(7, 7, 7, '2024-02-16', 1, 28000.00),
(8, 8, 8, '2024-02-17', 1, 21000.00),
(9, 9, 9, '2024-02-18', 2, 37000.00),
(10, 10, 10, '2024-02-19', 1, 43000.00),
(11, 11, 1, '2024-02-20', 1, 66000.00),
(12, 12, 2, '2024-02-21', 1, 45000.00),
(13, 13, 3, '2024-02-22', 1, 28000.00),
(14, 14, 4, '2024-02-23', 1, 38000.00),
(15, 15, 5, '2024-02-24', 2, 65000.00),
(16, 16, 6, '2024-02-25', 1, 65000.00),
(17, 17, 7, '2024-02-26', 1, 34000.00),
(18, 18, 8, '2024-02-27', 1, 35000.00),
(1, 19, 1, '2024-02-28', 1, 28000.00),
(2, 20, 2, '2024-02-29', 1, 35000.00),
(3, 21, 3, '2024-03-01', 2, 38000.00),
(4, 22, 4, '2024-03-02', 1, 43000.00),
(5, 23, 5, '2024-03-03', 1, 33000.00),
(6, 24, 6, '2024-03-04', 1, 39000.00),
(7, 25, 7, '2024-03-05', 1, 28000.00),
(8, 26, 8, '2024-03-06', 1, 21000.00),
(9, 27, 9, '2024-03-07', 2, 37000.00),
(10, 28, 10, '2024-03-08', 1, 43000.00),
(11, 29, 1, '2024-03-09', 1, 66000.00),
(12, 30, 2, '2024-03-10', 1, 45000.00),
(13, 31, 3, '2024-03-11', 1, 28000.00),
(14, 32, 4, '2024-03-12', 1, 38000.00),
(15, 33, 5, '2024-03-13', 2, 65000.00),
(16, 34, 6, '2024-03-14', 1, 65000.00),
(17, 35, 7, '2024-03-15', 1, 34000.00),
(18, 36, 8, '2024-03-16', 1, 35000.00),
(1, 37, 1, '2024-03-17', 1, 28000.00),
(2, 38, 2, '2024-03-18', 1, 35000.00),
(3, 39, 3, '2024-03-19', 2, 38000.00),
(4, 40, 4, '2024-03-20', 1, 43000.00),
(5, 1, 5, '2024-04-01', 1, 33000.00),
(6, 2, 6, '2024-04-02', 1, 39000.00),
(7, 3, 7, '2024-04-03', 1, 28000.00),
(8, 4, 8, '2024-04-04', 1, 21000.00),
(9, 5, 9, '2024-04-05', 2, 37000.00),
(10, 6, 10, '2024-04-06', 1, 43000.00),
(11, 7, 1, '2024-04-07', 1, 66000.00),
(12, 8, 2, '2024-04-08', 1, 45000.00),
(13, 9, 3, '2024-04-09', 1, 28000.00);


--SELECCIONAR LA TABLA PARA VER LOS REGISTROS:

SELECT * FROM Ventas
SELECT * FROM Vehiculos


--INSERTAMOS REGISTROS EN LA TABLA Asignaciones:

-- Insertar asignaciones para cada vendedor con el ID de venta correspondiente

INSERT INTO Asignaciones (ID_Venta, ID_Vendedor)
SELECT ID AS ID_Venta, 
    (ROW_NUMBER() OVER (ORDER BY ID) - 1) % 10 + 1 AS ID_Vendedor
FROM Ventas;


--SELECIONAR LA TABLA DE VEHICULOS:

SELECT * FROM Asignaciones
SELECT * FROM Clientes
SELECT * FROM Vehiculos
SELECT * FROM Ventas
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


-- Estadísticas de ventas por vendedor.

SELECT v.ID, v.Nombre AS Nombre_Vendedor, COUNT(ve.ID) AS Total_Ventas, SUM(ve.Cantidad) AS Total_Cantidad, SUM(ve.Precio_Venta) AS Total_Ventas_Monto
FROM Vendedor v
LEFT JOIN Ventas ve ON v.ID = ve.ID_Vendedor
GROUP BY v.ID, v.Nombre;


--ver la tabla vendedor
select * from vendedor

--contar los vendedores
SELECT COUNT(DISTINCT ID_Vendedor) AS Total_Vendedores
FROM Ventas;

--Conteo de ventas realizadas por cada modelo de vehículo:

SELECT Modelo, COUNT(Ventas.ID_Vehiculo) as Numero_Ventas
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
GROUP BY Modelo;


-- Esta consulta cuenta el número de ventas por modelo de vehículo para cada vendedor.
SELECT vendedor.Nombre AS Nombre_Vendedor, Vehiculos.Modelo, COUNT(Ventas.ID_Vehiculo) AS Numero_Ventas
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Asignaciones ON Ventas.ID = Asignaciones.ID_Venta
INNER JOIN vendedor ON Asignaciones.ID_Vendedor = vendedor.ID
GROUP BY vendedor.Nombre, Vehiculos.Modelo;



-- Esta consulta cuenta el número de ventas y calcula el monto total de ventas por modelo de vehículo para cada vendedor.
SELECT vendedor.Nombre AS Nombre_Vendedor, 
       Vehiculos.Modelo, 
       COUNT(Ventas.ID_Vehiculo) AS Numero_Ventas,
       SUM(Ventas.Precio_Venta) AS Monto_Total_Ventas
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Asignaciones ON Ventas.ID = Asignaciones.ID_Venta
INNER JOIN vendedor ON Asignaciones.ID_Vendedor = vendedor.ID
GROUP BY vendedor.Nombre, Vehiculos.Modelo;



-- Esta consulta cuenta el número de ventas y calcula el monto total de ventas por modelo de vehículo para cada cliente.
SELECT cliente.Nombre AS Nombre_Cliente, 
       Vehiculos.Modelo, 
       COUNT(Ventas.ID_Vehiculo) AS Numero_Ventas,
       SUM(Ventas.Precio_Venta) AS Monto_Total_Ventas
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Clientes cliente ON Ventas.ID_Cliente = cliente.ID
GROUP BY cliente.Nombre, Vehiculos.Modelo;


-- Esta consulta cuenta el número de ventas y calcula el monto total de ventas por categoría de vehículo para cada cliente.
SELECT cliente.Nombre AS Nombre_Cliente, 
       Categoria.Nombre AS Categoria_Vehiculo,
       COUNT(Ventas.ID_Vehiculo) AS Numero_Ventas,
       SUM(Ventas.Precio_Venta) AS Monto_Total_Ventas
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Vehiculo_Categoria ON Vehiculos.ID = Vehiculo_Categoria.ID_Vehiculo
INNER JOIN Categoria ON Vehiculo_Categoria.ID_Categoria = Categoria.ID
INNER JOIN Clientes cliente ON Ventas.ID_Cliente = cliente.ID
GROUP BY cliente.Nombre, Categoria.Nombre;


-- Esta consulta cuenta el número de ventas y calcula el monto total de ventas por cliente, país del cliente y categoría de vehículo.
SELECT cliente.Nombre AS Nombre_Cliente, 
       pais.NOMBRE_PAIS AS Pais_Cliente,
       Categoria.Nombre AS Categoria_Vehiculo,
       COUNT(Ventas.ID_Vehiculo) AS Numero_Ventas,
       SUM(Ventas.Precio_Venta) AS Monto_Total_Ventas
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Vehiculo_Categoria ON Vehiculos.ID = Vehiculo_Categoria.ID_Vehiculo
INNER JOIN Categoria ON Vehiculo_Categoria.ID_Categoria = Categoria.ID
INNER JOIN Clientes cliente ON Ventas.ID_Cliente = cliente.ID
INNER JOIN Pais pais ON cliente.ID_pais = pais.ID_PAIS
GROUP BY cliente.Nombre, pais.NOMBRE_PAIS, Categoria.Nombre;

-- Esta consulta cuenta el número de ventas y calcula el monto total de ventas por cliente, país del cliente, categoría de vehículo y vendedor.
SELECT cliente.Nombre AS Nombre_Cliente, 
       pais.NOMBRE_PAIS AS Pais_Cliente,
       Categoria.Nombre AS Categoria_Vehiculo,
       vendedor.Nombre AS Nombre_Vendedor,
       COUNT(Ventas.ID_Vehiculo) AS Numero_Ventas,
       SUM(Ventas.Precio_Venta) AS Monto_Total_Ventas
FROM Vehiculos
INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
INNER JOIN Vehiculo_Categoria ON Vehiculos.ID = Vehiculo_Categoria.ID_Vehiculo
INNER JOIN Categoria ON Vehiculo_Categoria.ID_Categoria = Categoria.ID
INNER JOIN Clientes cliente ON Ventas.ID_Cliente = cliente.ID
INNER JOIN Pais pais ON cliente.ID_pais = pais.ID_PAIS
INNER JOIN Asignaciones ON Ventas.ID = Asignaciones.ID_Venta
INNER JOIN vendedor ON Asignaciones.ID_Vendedor = vendedor.ID
GROUP BY cliente.Nombre, pais.NOMBRE_PAIS, Categoria.Nombre, vendedor.Nombre;

-- Esta consulta cuenta el total de vendedores en la tabla "vendedor".
SELECT COUNT(*) AS Total_Vendedores FROM vendedor;

-- Esta consulta cuenta el número de vendedores que tienen al menos una asignación de ventas en la tabla "Asignaciones".
SELECT COUNT(DISTINCT ID_Vendedor) AS Vendedores_Con_Ventas FROM Asignaciones;

-- Esta consulta selecciona los vendedores que no tienen ventas asociadas en la tabla "Ventas".
SELECT DISTINCT vendedor.ID, vendedor.Nombre
FROM vendedor
LEFT JOIN Asignaciones ON vendedor.ID = Asignaciones.ID_Vendedor
LEFT JOIN Ventas ON Asignaciones.ID_Venta = Ventas.ID
WHERE Ventas.ID IS NULL;

-- Mostrar todos los registros de la tabla PAIS
SELECT * FROM PAIS;

-- Mostrar todos los registros de la tabla Clientes
SELECT * FROM Clientes;

-- Mostrar todos los registros de la tabla Categoria
SELECT * FROM Categoria;

-- Mostrar todos los registros de la tabla Vehiculo_Categoria
SELECT * FROM Vehiculo_Categoria;


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
INNER JOIN vendedor ON Asignaciones.ID_Vendedor = vendedor.ID
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
INNER JOIN vendedor ON Asignaciones.ID_Vendedor = vendedor.ID
INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo
go

--ver la vista:
select * from vw_Ventas_Vehiculos

/*
Vista que muestra detalles de ventas de vehículos, incluyendo información sobre el modelo, año, cliente, 
empleado/vendedor, inventario y modelos de URL. Calcula el total de ventas, la cantidad vendida y el stock
actual por vehículo.
*/

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
INNER JOIN vendedor ON Asignaciones.ID_Vendedor = vendedor.ID
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
INNER JOIN vendedor ON Asignaciones.ID_Vendedor = vendedor.ID
INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo
INNER JOIN Inventario ON Inventario.ID_Vehiculo = Vehiculos.ID
INNER JOIN Fotos_vendedor FV ON FV.ID_vendedor = vendedor.ID
GROUP BY Vehiculos.Modelo, Vehiculos.Anio,
Clientes.Nombre, Clientes.Direccion, Clientes.Telefono,
Ventas.Fecha_Venta, Ventas.Precio_Venta, Ventas.Cantidad,
vendedor.Nombre, vendedor.Direccion, vendedor.Telefono,
Modelos_URL.URL, FV.foto_Vendedor_url, Inventario.Cantidad;

SELECT * FROM vw_Ventas_Vehiculos5


/*
crea o altera una vista llamada vw_Ventas_Vehiculos6 que proporciona detalles sobre las ventas
de vehículos, incluyendo información sobre el modelo y año del vehículo, el cliente, el empleado/vendedor, 
el inventario y los modelos de URL. La vista calcula el total de ventas y el stock actual de cada 
vehículo en inventario.

*/

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
    INNER JOIN vendedor ON Asignaciones.ID_Vendedor = vendedor.ID
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

--Ver la Vista:

select * from vw_Ventas_Vehiculos6
/*

Este comando crea o altera una vista llamada vw_Ventas_Vehiculos6 que proporciona detalles sobre 
las ventas de vehículos, incluyendo información sobre el modelo y año del vehículo, el cliente,
el empleado/vendedor, el inventario y los modelos de URL. Además, calcula el total de ventas y el
stock actual de cada vehículo en inventario.

*/

CREATE OR ALTER VIEW vw_Ventas_Vehiculos6 AS
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
    Ventas.Cantidad * Ventas.Precio_Venta AS Total,
    vendedor.Nombre AS Nombre_Empleado, 
    vendedor.Direccion AS Direccion_Empleado, 
    vendedor.Telefono AS Telefono_Empleado,
    Modelos_URL.URL,  
    fv.foto_Vendedor_url, 
    Inventario.Cantidad AS Existencia,
    (Inventario.Cantidad - ISNULL(SUM(Ventas.Cantidad), 0)) AS Stock_Actual
FROM 
    Vehiculos
    INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
    INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
    INNER JOIN Asignaciones ON Asignaciones.ID_Venta = Ventas.ID
    INNER JOIN vendedor ON Asignaciones.ID_Vendedor = vendedor.ID
    INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo
    INNER JOIN Inventario ON Inventario.ID_Vehiculo = Vehiculos.ID
    INNER JOIN Fotos_vendedor FV ON FV.ID_vendedor = vendedor.ID
GROUP BY 
    Vehiculos.Modelo, 
    Vehiculos.Anio, 
    Clientes.Nombre, 
    Clientes.Direccion, 
    Clientes.Telefono,
    Ventas.Fecha_Venta, 
    Vehiculos.Precio_compra, 
    Ventas.Precio_Venta, 
    Ventas.Cantidad,
    vendedor.Nombre, 
    vendedor.Direccion, 
    vendedor.Telefono,
    Modelos_URL.URL, 
    fv.foto_Vendedor_url, 
    Inventario.Cantidad;

-- VER LA VISTA
SELECT * FROM vw_Ventas_Vehiculos6


-- Crea una vista llamada vw_Ventas_Totales que muestra el ID de la venta, la fecha de venta, la cantidad vendida, el precio de venta y el total de la venta para cada registro en la tabla "Ventas".
CREATE VIEW vw_Ventas_Totales AS
SELECT ID, Fecha_Venta, Cantidad, Precio_Venta, Cantidad * Precio_Venta AS Total
FROM Ventas;

--VER LA VISTA:

select * from vw_Ventas_Totales

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

-- Crea o altera una vista llamada vw_Ventas_Vehiculos6 que proporciona detalles sobre las ventas de vehículos, incluyendo información sobre el modelo y año del vehículo, el cliente, el empleado/vendedor, el inventario y los modelos de URL. Además, muestra el stock actual de cada vehículo en inventario.
CREATE OR ALTER VIEW vw_Ventas_Vehiculos6 AS
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
    Ventas.Cantidad * Ventas.Precio_Venta AS Total,
    vendedor.Nombre AS Nombre_Empleado, 
    vendedor.Direccion AS Direccion_Empleado, 
    vendedor.Telefono AS Telefono_Empleado,
    Modelos_URL.URL,  
    fv.foto_Vendedor_url, 
    IV.Stock_Actual
FROM 
    Vehiculos
    INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
    INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
    INNER JOIN Asignaciones ON Asignaciones.ID_Venta = Ventas.ID
    INNER JOIN vendedor ON Asignaciones.ID_Vendedor = vendedor.ID
    INNER JOIN Modelos_URL ON Vehiculos.ID = Modelos_URL.ID_Vehiculo
    INNER JOIN (
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
                ) IV ON IV.ID = Vehiculos.ID
    INNER JOIN Fotos_vendedor FV ON FV.ID_vendedor = vendedor.ID;

-- Muestra los datos de la vista vw_Ventas_Vehiculos6
SELECT * FROM vw_Ventas_Vehiculos6;

-- Selecciona el modelo, año, precio de ventas y stock actual de los vehículos con stock negativo en el inventario.

SELECT 
    Modelo, -- Selecciona el modelo del vehículo
    Anio, -- Selecciona el año del vehículo
    Precio_ventas, -- Selecciona el precio de ventas del vehículo
    (Inventario.Cantidad - ISNULL(SUM(Ventas.Cantidad), 0)) AS Stock_Actual -- Calcula el stock actual restando la cantidad vendida de la cantidad en inventario, teniendo en cuenta los casos donde no hay ventas
FROM 
    Vehiculos -- Tabla de vehículos
    LEFT JOIN Inventario ON Vehiculos.ID = Inventario.ID_Vehiculo -- Une la tabla de vehículos con la tabla de inventario basado en el ID del vehículo
    LEFT JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo -- Une la tabla de vehículos con la tabla de ventas basado en el ID del vehículo
GROUP BY 
    Vehiculos.ID, -- Agrupa por el ID del vehículo
    Modelo, -- Agrupa por el modelo del vehículo
    Anio, -- Agrupa por el año del vehículo
    Precio_ventas, -- Agrupa por el precio de ventas del vehículo
    Inventario.Cantidad -- Agrupa por la cantidad en inventario
HAVING 
    (Inventario.Cantidad - ISNULL(SUM(Ventas.Cantidad), 0)) < 0; -- Filtra los registros donde el stock actual es menor que cero (es decir, hay más ventas que inventario disponible)




SELECT 
    Vehiculos.ID AS ID_Vehiculo,
    Vehiculos.Modelo, 
    Vehiculos.Anio, 
    Clientes.Nombre AS Nombre_Cliente, 
    Ventas.Fecha_Venta, 
    Ventas.Cantidad AS Cantidad_Solicitada,
    (Inventario.Cantidad - ISNULL(SUM(Ventas.Cantidad), 0)) AS Stock_Actual
FROM 
    Vehiculos
    INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
    INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
    LEFT JOIN Inventario ON Vehiculos.ID = Inventario.ID_Vehiculo
GROUP BY 
    Vehiculos.ID,
    Vehiculos.Modelo, 
    Vehiculos.Anio, 
    Clientes.Nombre,
    Ventas.Fecha_Venta,
    Inventario.Cantidad,
    Ventas.Cantidad
HAVING 
    (Inventario.Cantidad - ISNULL(SUM(Ventas.Cantidad), 0)) <= 0;


SELECT 
    Vehiculos.ID AS ID_Vehiculo,
    Vehiculos.Modelo, 
    Vehiculos.Anio, 
    Clientes.Nombre AS Nombre_Cliente, 
    Ventas.Fecha_Venta, 
    Ventas.Cantidad AS Cantidad_Solicitada,
    (Inventario.Cantidad - ISNULL(SUM(Ventas.Cantidad), 0)) AS Stock_Actual
FROM 
    Vehiculos
    INNER JOIN Ventas ON Vehiculos.ID = Ventas.ID_Vehiculo
    INNER JOIN Clientes ON Ventas.ID_Cliente = Clientes.ID
    LEFT JOIN Inventario ON Vehiculos.ID = Inventario.ID_Vehiculo
GROUP BY 
    Vehiculos.ID,
    Vehiculos.Modelo, 
    Vehiculos.Anio, 
    Clientes.Nombre,
    Ventas.Fecha_Venta,
    Inventario.Cantidad,
    Ventas.Cantidad
HAVING 
    (Inventario.Cantidad - ISNULL(SUM(Ventas.Cantidad), 0)) <= 0;



-- Vista que muestra el inventario actual de vehículos junto con las ventas realizadas y calcula el stock actual por vehículo.

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

--VER LA VISTA:

select * from V_Inventario_Ventas_v3


-- Vista que muestra el inventario y ventas de vehículos, calculando el stock actual por vehículo, con el nombre del cliente y el modelo del vehículo.

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

--ver vista:

select * from V_Inventario_Ventas_v4

/*
Este procedimiento almacenado devuelve las ventas realizadas dentro de un rango de 
fechas especificado, incluyendo detalles como el ID de venta, fecha de venta, país,
cliente, vendedor, modelo del vehículo, cantidad vendida, precios y margen bruto.

*/

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


--EJECUTAR EL PROCEDIMIENTO ALMACENADO CON UNA FCHA X:

EXEC SP_Ventas_PorFecha_v_2023_2 '2020-01-01', '2020-12-31';

/*
-- Este procedimiento almacenado devuelve las ventas realizadas dentro de un rango de fechas especificado, 
incluyendo detalles como el ID de venta, fecha de venta, país, cliente, vendedor, modelo del vehículo,
cantidad vendida, precios y margen bruto.
*/

CREATE OR ALTER PROCEDURE SP_Ventas_PorFecha_v_2023_2_Inventarios
    @Fecha_Inicio datetime,
    @Fecha_Fin datetime
AS
BEGIN
    SELECT 
        V.ID AS ID_Venta, 
        V.Fecha_Venta, 
        P.NOMBRE_PAIS as Pais,
        C.Nombre AS Cliente, 
        C.Direccion AS Direccion_Cliente, 
        C.Telefono AS Telefono_Cliente,
        E.Nombre AS Vendedor,
        CT.Nombre AS Categoria,
        VH.Modelo, 
        VH.Precio_compra, 
        VH.Precio_ventas,
        VH.Stock AS Stock_Inicial,
        SUM(V.Cantidad) AS Cantidad,
        (VH.Stock - SUM(V.Cantidad)) AS Stock_Actual,
        SUM(V.Total) AS Total, -- Aplicamos SUM() a Ventas.Total para obtener el total acumulado de ventas
        (SUM(V.Cantidad) * (VH.Precio_ventas - VH.Precio_compra)) AS Margen_bruto,
        ((SUM(V.Cantidad) * (VH.Precio_ventas - VH.Precio_compra)) / (SUM(V.Total))) * 100 AS "%_Margen"
    FROM 
        Ventas V
    INNER JOIN 
        Vehiculos VH ON V.ID_Vehiculo = VH.ID
    INNER JOIN 
        Vehiculo_Categoria VH_Cat ON VH.ID = VH_Cat.ID_Vehiculo
    INNER JOIN 
        Categoria CT ON VH_Cat.ID_Categoria = CT.ID
    INNER JOIN 
        Clientes C ON V.ID_Cliente = C.ID
    INNER JOIN 
        Vendedor E ON V.ID_Vendedor = E.ID
    INNER JOIN 
        Pais P ON C.ID_pais = P.ID_PAIS
    INNER JOIN 
        Modelos_URL M ON VH.ID = M.ID_Vehiculo
    INNER JOIN 
        Fotos_vendedor F ON V.ID_Vendedor = F.ID_vendedor
    WHERE 
        V.Fecha_Venta BETWEEN @Fecha_Inicio AND @Fecha_Fin
    GROUP BY 
        V.ID, 
        V.Fecha_Venta, 
        P.NOMBRE_PAIS,
        C.Nombre, 
        C.Direccion, 
        C.Telefono,
        E.Nombre,
        VH.Modelo, 
        VH.Precio_compra, 
        VH.Precio_ventas,
        CT.Nombre,
        VH.Stock;
END;

--EJECUTAR EL PROCEDIMIENTO ALMACENADO:

EXEC SP_Ventas_PorFecha_v_2023_2_Inventarios '2020-01-01', '2024-04-09';


--VISTA NUEVA PARA INVENTARIO:

CREATE OR ALTER VIEW V_Vehiculos_Inventario_Ventas AS
SELECT 
    Vehiculos.ID,
    Vehiculos.Modelo,
    Vehiculos.Anio,
    Vehiculos.Precio_ventas,
    (Inventario.Cantidad - ISNULL((SELECT SUM(Cantidad) FROM Ventas WHERE Ventas.ID_Vehiculo = Vehiculos.ID), 0)) AS Stock_Actual
FROM 
    Vehiculos
    LEFT JOIN Inventario ON Vehiculos.ID = Inventario.ID_Vehiculo;


/*
Este procedimiento almacenado calcula y muestra las ventas realizadas dentro de un 
rango de fechas especificado, junto con detalles como el ID de venta, fecha de venta, 
país, cliente, vendedor, modelo del vehículo, cantidad vendida, precios y margen bruto.

Además, calcula el stock actual restando la cantidad vendida del stock inicial y 
proporciona el margen bruto como un porcentaje del total de ventas.

*/


CREATE OR ALTER PROCEDURE SP_Ventas_PorFecha_v_2023_2_Stok_Actual_0
    @Fecha_Inicio datetime,
    @Fecha_Fin datetime
AS
BEGIN
    SELECT 
        V.ID AS ID_Venta, 
        V.Fecha_Venta, 
        P.NOMBRE_PAIS as Pais,
        C.Nombre AS Cliente, 
        C.Direccion AS Direccion_Cliente, 
        C.Telefono AS Telefono_Cliente,
        E.Nombre AS Vendedor,
        CT.Nombre AS Categoria,
        VH.Modelo, 
        VH.Precio_compra, 
        VH.Precio_ventas,
        VH.Stock AS Stock_Inicial,
        ISNULL(SUM(V.Cantidad), 0) AS Cantidad_Vendida,
        (VH.Stock - ISNULL(StockVenta.CantidadVendida, 0)) AS Stock_Actual,
        SUM(V.Total) AS Total_Ventas,
        (ISNULL(SUM(V.Cantidad), 0) * (VH.Precio_ventas - VH.Precio_compra)) AS Margen_bruto,
        ((ISNULL(SUM(V.Cantidad), 0) * (VH.Precio_ventas - VH.Precio_compra)) / SUM(V.Total)) * 100 AS "%_Margen"
    FROM 
        Ventas V
    RIGHT JOIN 
        Vehiculos VH ON V.ID_Vehiculo = VH.ID
    LEFT JOIN 
        Vehiculo_Categoria VH_Cat ON VH.ID = VH_Cat.ID_Vehiculo
    LEFT JOIN 
        Categoria CT ON VH_Cat.ID_Categoria = CT.ID
    LEFT JOIN 
        Clientes C ON V.ID_Cliente = C.ID
    LEFT JOIN 
        Vendedor E ON V.ID_Vendedor = E.ID
    LEFT JOIN 
        Pais P ON C.ID_pais = P.ID_PAIS
    LEFT JOIN 
        Modelos_URL M ON VH.ID = M.ID_Vehiculo
    LEFT JOIN 
        Fotos_vendedor F ON V.ID_Vendedor = F.ID_vendedor
    LEFT JOIN 
        (SELECT ID_Vehiculo, SUM(Cantidad) AS CantidadVendida 
         FROM Ventas 
         WHERE Fecha_Venta BETWEEN @Fecha_Inicio AND @Fecha_Fin 
         GROUP BY ID_Vehiculo) StockVenta ON VH.ID = StockVenta.ID_Vehiculo
    WHERE V.Fecha_Venta BETWEEN @Fecha_Inicio AND @Fecha_Fin
    GROUP BY 
        V.ID, 
        V.Fecha_Venta, 
        P.NOMBRE_PAIS,
        C.Nombre, 
        C.Direccion, 
        C.Telefono,
        E.Nombre,
        VH.Modelo, 
        VH.Precio_compra, 
        VH.Precio_ventas,
        CT.Nombre,
        VH.Stock,
        StockVenta.CantidadVendida; -- Agregar StockVenta.CantidadVendida en la cláusula GROUP BY
END;

--EJECUTAR EL PROCEDIMIENTO:

EXEC SP_Ventas_PorFecha_v_2023_2_Stok_Actual_0 '2020-01-01', '2024-04-09';


--SELECCIONAR LA TABLA PARA VER LOS REGISTROS:

SELECT * FROM Ventas;





