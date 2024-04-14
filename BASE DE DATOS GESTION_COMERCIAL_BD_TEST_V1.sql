--CREA UNA BASE DE DATOS CON CODIGO:
create database GESTION_COMERCIAL_BD_TEST_V3;
go

--USER LA BASE DE DATOS CREADA

USE GESTION_COMERCIAL_BD_TEST_V3;

-- Crear tabla Producto (PRODUCTO):

CREATE TABLE PRODUCTO (
    codigo INT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    precio_compra DECIMAL(18,2)NOT NULL,
	precio_ventas DECIMAL(18,2) NOT NULL,
    existencia INT NOT NULL,
    fecha_ingreso DATE NOT NULL
);

-- Crear tabla Region:

CREATE TABLE Region (
    id_region INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Crear tabla Provincia:

CREATE TABLE Provincia (
    id_provincia INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    longitud DECIMAL(10, 6),
    latitud DECIMAL(10, 6),
    id_region INT,
    FOREIGN KEY (id_region) REFERENCES Region(id_region)
);

--Tabla de Cliente (CLIENTE):

CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) UNIQUE,
    direccion VARCHAR(100),
    id_provincia INT,
    FOREIGN KEY (id_provincia) REFERENCES Provincia(id_provincia)
);


 --Tabla de Vendedor (VENDEDOR):

CREATE TABLE VENDEDOR (
    id_vendedor INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) UNIQUE,
    direccion VARCHAR(100),
    id_provincia INT,
    FOREIGN KEY (id_provincia) REFERENCES Provincia(id_provincia)
);

-- Crear tabla Condicion_Pago:

CREATE TABLE CONDICION_PAGO (
    id_condicion INT PRIMARY KEY,
    condicion VARCHAR(50) NOT NULL
);


--Tabla de Factura (FACTURA):

CREATE TABLE FACTURA (
    id_factura INT PRIMARY KEY,
    id_cliente INT,
    id_vendedor INT,
    fecha DATE NOT NULL,
    total DECIMAL(18,2) NOT NULL,
	id_condicion int not null,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES VENDEDOR(id_vendedor),
    FOREIGN KEY (id_condicion) REFERENCES CONDICION_PAGO(id_condicion)
);


--Tabla de Detalle de Factura (DETALLE_FACTURA):

CREATE TABLE DETALLE_FACTURA (
    id_detalle INT PRIMARY KEY,
    id_factura INT,
    codigo_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(18,2) NOT NULL,
    total_linea DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (id_factura) REFERENCES FACTURA(id_factura),
    FOREIGN KEY (codigo_producto) REFERENCES PRODUCTO(codigo)
);



-- Trigger para calcular el total de la factura en FACTURA:

CREATE OR ALTER TRIGGER calcular_total_factura ON DETALLE_FACTURA
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
  
    DECLARE @id_factura INT;
    DECLARE @total DECIMAL(18,2);
    
    -- Obtener el ID de la factura afectada
    SELECT @id_factura = id_factura FROM INSERTED;
    
    -- Calcular el total de la factura
    SELECT @total = SUM(df.cantidad * df.precio_unitario)
    FROM DETALLE_FACTURA df
    WHERE df.id_factura = @id_factura;
    
    -- Actualizar el total en la tabla FACTURA
    UPDATE FACTURA
    SET total = @total
    WHERE id_factura = @id_factura;
END;
GO

-- Trigger para calcular el precio unitario en DETALLE_FACTURA:

CREATE OR ALTER TRIGGER calcular_precio_unitario ON DETALLE_FACTURA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar el precio unitario en la tabla DETALLE_FACTURA
    UPDATE df
    SET precio_unitario = p.precio_ventas
    FROM DETALLE_FACTURA df
    INNER JOIN INSERTED i ON df.id_detalle = i.id_detalle
    INNER JOIN PRODUCTO p ON df.codigo_producto = p.codigo;
END;
GO

/*
Vamos a implementar un trigger que controle el stock o existencia en la tabla de PRODUCTO, 
necesitaremos crear un trigger INSTEAD OF INSERT en la tabla DETALLE_FACTURA. 
Este trigger verificará si la cantidad de productos vendidos está disponible en el
stock antes de permitir que la factura se inserte en la base de datos.

*/

CREATE OR ALTER TRIGGER controlar_stock_venta ON DETALLE_FACTURA
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_factura INT;
    DECLARE @id_producto INT;
    DECLARE @cantidad INT;
    DECLARE @stock_actual INT;

    -- Obtener los valores de la inserción
    SELECT @id_factura = id_factura,
           @id_producto = codigo_producto,
           @cantidad = cantidad
    FROM INSERTED;

    -- Obtener el stock actual del producto
    SELECT @stock_actual = existencia
    FROM PRODUCTO
    WHERE codigo = @id_producto;

    -- Verificar si hay suficiente stock para la venta
    IF @cantidad <= @stock_actual
    BEGIN
        -- Realizar la venta actualizando el stock
        UPDATE PRODUCTO
        SET existencia = @stock_actual - @cantidad
        WHERE codigo = @id_producto;

        -- Insertar la factura
        INSERT INTO DETALLE_FACTURA (id_factura, codigo_producto, cantidad)
        VALUES (@id_factura, @id_producto, @cantidad);
        
        -- Mostrar mensaje de venta exitosa
        PRINT 'Venta realizada exitosamente.';
    END
    ELSE
    BEGIN
        -- Mostrar mensaje de producto insuficiente
        PRINT 'Producto insuficiente para completar la venta.';
    END;
END;


-- Insertar datos en la tabla PRODUCTO con precios de compra y venta ajustado":

INSERT INTO PRODUCTO (codigo, descripcion, precio_compra, precio_ventas, existencia, fecha_ingreso)
VALUES 
(1000, 'LAPTOP GAMER - Gama ASUS ROG', 42500.84, 50000.99, 10, '2024-11-03'),
(1001, 'LAPTOP GAMER - HP OMEN 15', 41667.84, 49000.99, 10, '2024-11-03'),
(1002, 'LAPTOP GAMER - Laptop Dell G5 15 5510 GAMING', 45000.84, 60000.99, 10, '2024-11-03'),
(1003, 'MOUSE GAMER - Mouse Dell Alienware 610M', 850.84, 1000.99, 10, '2024-11-03'),
(1004, 'TECLADO GAMER - HP Pavilion Gaming Keyboard 800', 17000.84, 20000.99, 10, '2024-11-03'),
(1005, 'BOCINAS X -Logitech G560 LIGHTSYNC', 21250.84, 25000.99, 10, '2024-11-03'),
(1006, 'MONITOR LG 27" - LG UltraGear 27GN750-B', 12750.84, 15000.99, 10, '2024-11-03'),
(1007, 'IMPRESORA EPSON WIFI - Epson EcoTank ET-4760', 6800.84, 8000.99, 10, '2024-11-03'),
(1008, 'ROUTER TP-LINK - TP-Link Archer C7', 2550.84, 3000.99, 10, '2024-11-03'),
(1009, 'DISCO DURO EXTERNO 1TB - Seagate Expansion Portable 1TB', 3400.84, 4000.99, 10, '2024-11-03'),
(1010, 'MEMORIA RAM KINGSTON 8GB - HyperX Fury DDR4 8GB', 1275.84, 1500.99, 10, '2024-11-03'),
(1011, 'TABLET SAMSUNG GALAXY TAB - Samsung Galaxy Tab S7', 10200.84, 12000.99, 10, '2024-11-03'),
(1012, 'AURICULARES SONY INALÁMBRICOS - Sony WH-1000XM4', 2550.84, 3000.99, 10, '2024-11-03'),
(1013, 'CÁMARA WEB LOGITECH - Logitech C920 HD Pro', 4250.84, 5000.99, 10, '2024-11-03'),
(1014, 'CARGADOR PORTÁTIL ANKER - Anker PowerCore 26800', 1700.84, 2000.99, 10, '2024-11-03'),
(1015, 'SOPORTE AJUSTABLE PARA LAPTOP - Nulaxy Adjustable Laptop Stand', 850.84, 1000.99, 10, '2024-11-03');


/*
-- Renombrar la columna 'precio' a 'precio_ventas'

-- Verificar que la actualización se realizó correctamente

SELECT * FROM PRODUCTO;

-- Actualizar el precio de compra en la tabla PRODUCTO con un descuento aleatorio entre el 15% y el 25%
UPDATE PRODUCTO
SET precio_compra = ROUND(precio * (1 - RAND() * 0.1 - 0.15), 2)
WHERE codigo IN (1000, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015);

*/

--ACTUALIZAR TODOS LOS PRODUCTOS A 3000 UNIDADES:

UPDATE PRODUCTO
SET existencia = 3000;




-- Para actualizar la descripción de todos los productos con un modelo y número, podemos usar la instrucción UPDATE de la siguiente manera:

UPDATE PRODUCTO
SET descripcion = 
    CASE 
        WHEN codigo = 1000 THEN 'LAPTOP ASUS GAMER'
        WHEN codigo = 1001 THEN 'LAPTOP HP GAMER'
        WHEN codigo = 1002 THEN 'LAPTOP DELL GAMER'
        WHEN codigo = 1003 THEN 'MOUSE DELL GAMER'
        WHEN codigo = 1004 THEN 'TECLADO HP GAMER '
        WHEN codigo = 1005 THEN 'BOCINAS X LOGITECH'
        WHEN codigo = 1006 THEN 'MONITOR LG 27"'
        WHEN codigo = 1007 THEN 'IMPRESORA EPSON WIFI'
        WHEN codigo = 1008 THEN 'ROUTER TP-LINK'
        WHEN codigo = 1009 THEN 'DISCO SEGATE DURO EXTERNO 1TB '
        WHEN codigo = 1010 THEN 'MEMORIA RAM KINGSTON 8GB'
        WHEN codigo = 1011 THEN 'TABLET SAMSUNG GALAXY TAB'
        WHEN codigo = 1012 THEN 'AURICULARES SONY INALÁMBRICOS'
        WHEN codigo = 1013 THEN 'CÁMARA WEB LOGITECH'
        WHEN codigo = 1014 THEN 'CARGADOR PORTÁTIL ANKER'
        WHEN codigo = 1015 THEN 'SOPORTE AJUSTABLE PARA LAPTOP NULAXY'
        ELSE descripcion  
    END;

-- Convertir toda la columna 'descripcion' a mayúsculas

UPDATE PRODUCTO
SET descripcion = UPPER(descripcion);


-- Crear tabla CATEGORIA_MARCA
CREATE TABLE CATEGORIA_MARCA (
    id_categoria_marca INT IDENTITY(1,1) PRIMARY KEY,
    nombre_categoria_marca NVARCHAR(100)
);

-- Insertar datos en la tabla CATEGORIA_MARCA
INSERT INTO CATEGORIA_MARCA (nombre_categoria_marca) VALUES 
('ASUS'),
('HP'),
('DELL'),
('LOGITECH'),
('LG'),
('EPSON'),
('TP-LINK'),
('SEAGATE'),
('KINGSTON'),
('SAMSUNG'),
('SONY'),
('ANKER'),
('NULAXY');

select * from CATEGORIA_MARCA



-- Añadir columna id_categoria_marca a la tabla PRODUCTO:

ALTER TABLE PRODUCTO
ADD id_categoria_marca INT;

-- Actualizar la tabla PRODUCTO con el id_categoria_marca correspondiente para cada producto

UPDATE PRODUCTO
SET id_categoria_marca =
    CASE 
        WHEN codigo = 1000 THEN 1  -- LAPTOP ASUS GAMER
        WHEN codigo = 1001 THEN 2  -- LAPTOP HP GAMER
        WHEN codigo = 1002 THEN 3  -- LAPTOP DELL GAMER
        WHEN codigo = 1003 THEN 4  -- MOUSE DELL GAMER
        WHEN codigo = 1004 THEN 2  -- TECLADO HP GAMER
        WHEN codigo = 1005 THEN 5  -- BOCINAS X Logitech
        WHEN codigo = 1006 THEN 6  -- MONITOR LG 27"
        WHEN codigo = 1007 THEN 7  -- IMPRESORA EPSON WIFI
        WHEN codigo = 1008 THEN 8  -- ROUTER TP-LINK
        WHEN codigo = 1009 THEN 9  -- DISCO SEGATE DURO EXTERNO 1TB
        WHEN codigo = 1010 THEN 10 -- MEMORIA RAM KINGSTON 8GB
        WHEN codigo = 1011 THEN 11 -- TABLET SAMSUNG GALAXY TAB
        WHEN codigo = 1012 THEN 12 -- AURICULARES SONY INALÁMBRICOS
        WHEN codigo = 1013 THEN 4  -- CÁMARA WEB LOGITECH
        WHEN codigo = 1014 THEN 13 -- CARGADOR PORTÁTIL ANKER
        WHEN codigo = 1015 THEN 14 -- SOPORTE AJUSTABLE PARA LAPTOP Nulaxy
    END;


select * from PRODUCTO

-- Insertar regiones de la República Dominicana:

INSERT INTO Region (id_region, nombre) VALUES 
(1, 'Norte'),
(2, 'Sur'),
(3, 'Este'),
(4, 'Oeste'),
(5, 'Nordeste'),
(6, 'Noroeste'),
(7, 'Suroeste'),
(8, 'Sureste');

SELECT * FROM Region


-- Insertar provincias de la República Dominicana con sus coordenadas y regiones correspondientes:

INSERT INTO Provincia (id_provincia, nombre, longitud, latitud, id_region) VALUES 
(1, 'Distrito Nacional', -69.9177, 18.4861, 3),
(2, 'Azua', -70.7379, 18.4538, 4),
(3, 'Bahoruco', -71.5167, 18.4500, 7),
(4, 'Barahona', -71.1041, 18.2085, 7),
(5, 'Dajabón', -71.7172, 19.5485, 6),
(6, 'Duarte', -70.9847, 19.2860, 8),
(7, 'El Seibo', -69.0479, 18.7648, 8),
(8, 'Espaillat', -70.5265, 19.6259, 1),
(9, 'Independencia', -71.7251, 18.7059, 7),
(10, 'La Altagracia', -68.5806, 18.5820, 3),
(11, 'La Romana', -68.9718, 18.4273, 3),
(12, 'La Vega', -70.5049, 19.2155, 1),
(13, 'María Trinidad Sánchez', -69.8462, 19.3835, 5),
(14, 'Monseñor Nouel', -70.3210, 18.9592, 1),
(15, 'Monte Cristi', -71.6492, 19.8500, 6),
(16, 'Monte Plata', -69.7857, 18.8083, 3),
(17, 'Pedernales', -71.7217, 18.0384, 7),
(18, 'Peravia', -70.6860, 18.4342, 2),
(19, 'Puerto Plata', -70.6970, 19.7808, 1),
(20, 'Samaná', -69.4167, 19.2000, 5),
(21, 'San Cristóbal', -70.4149, 18.4157, 2),
(22, 'San José de Ocoa', -70.5026, 18.5436, 4),
(23, 'San Juan', -71.5352, 18.8074, 7),
(24, 'San Pedro de Macorís', -69.2971, 18.4616, 3),
(25, 'Sánchez Ramírez', -70.1980, 18.7690, 8),
(26, 'Santiago', -70.6483, 19.4582, 1),
(27, 'Santiago Rodríguez', -71.3436, 19.4667, 6),
(28, 'Santo Domingo', -69.9013, 18.4667, 3),
(29, 'Valverde', -71.3315, 19.5544, 6),
(30, 'Santo Domingo Este', -69.8333, 18.5000, 3),
(31, 'Santo Domingo Oeste', -70.0000, 18.5000, 3);


SELECT * FROM Provincia

-- Insertar clientes en República Dominicana:

INSERT INTO CLIENTE (id_cliente, nombre, telefono, direccion, id_provincia) VALUES 
(1, 'Ana García', '809-123-4561', 'Calle 1, Distrito Nacional', 1),
(2, 'Juan López', '809-123-4562', 'Avenida 2, Azua', 2),
(3, 'María Martínez', '809-123-4563', 'Calle 3, Bahoruco', 3),
(4, 'Pedro Rodríguez', '809-123-4564', 'Avenida 4, Barahona', 4),
(5, 'Laura Hernández', '809-123-4565', 'Calle 5, Dajabón', 5),
(6, 'Carlos Pérez', '809-123-4566', 'Avenida 6, Duarte', 6),
(7, 'Sofía González', '809-123-4567', 'Calle 7, El Seibo', 7),
(8, 'Luisa Gómez', '809-123-4568', 'Avenida 8, Espaillat', 8),
(9, 'Javier Ramírez', '809-123-4569', 'Calle 9, Independencia', 9),
(10, 'Natalia Suárez', '809-123-4570', 'Avenida 10, La Altagracia', 10),
(11, 'Miguel Torres', '809-123-4571', 'Calle 11, La Romana', 11),
(12, 'Angela Díaz', '809-123-4572', 'Avenida 12, La Vega', 12),
(13, 'Fernando Castillo', '809-123-4573', 'Calle 13, María Trinidad Sánchez', 13),
(14, 'Carmen Acosta', '809-123-4574', 'Avenida 14, Monseñor Nouel', 14),
(15, 'Rafael Jiménez', '809-123-4575', 'Calle 15, Monte Cristi', 15),
(16, 'Elena Reyes', '809-123-4576', 'Avenida 16, Monte Plata', 16),
(17, 'Mario Santana', '809-123-4577', 'Calle 17, Pedernales', 17),
(18, 'Gabriela Cruz', '809-123-4578', 'Avenida 18, Peravia', 18),
(19, 'Rosa Vargas', '809-123-4579', 'Calle 19, Puerto Plata', 19),
(20, 'Daniel Ortiz', '809-123-4580', 'Avenida 20, Samaná', 20),
(21, 'Ana Castillo', '809-123-4581', 'Calle 21, San Cristóbal', 21),
(22, 'Juan García', '809-123-4582', 'Avenida 22, San José de Ocoa', 22),
(23, 'María López', '809-123-4583', 'Calle 23, San Juan', 23),
(24, 'Pedro Martínez', '809-123-4584', 'Avenida 24, San Pedro de Macorís', 24),
(25, 'Laura Rodríguez', '809-123-4585', 'Calle 25, Sánchez Ramírez', 25),
(26, 'Carlos Hernández', '809-123-4586', 'Avenida 26, Santiago', 26),
(27, 'Sofía Pérez', '809-123-4587', 'Calle 27, Santiago Rodríguez', 27),
(28, 'Luisa González', '809-123-4588', 'Avenida 28, Santo Domingo', 28),
(29, 'Javier Gómez', '809-123-4589', 'Calle 29, Santo Domingo Este', 30),
(30, 'Natalia Suárez', '809-123-4590', 'Avenida 30, Santo Domingo Oeste', 31),
(31, 'Miguel Torres', '809-123-4591', 'Calle 31, Valverde', 29),
(32, 'Angela Díaz', '809-123-4592', 'Avenida 32, Santiago', 26),
(33, 'Fernando Castillo', '809-123-4593', 'Calle 33, La Romana', 11),
(34, 'Carmen Acosta', '809-123-4594', 'Avenida 34, Peravia', 18),
(35, 'Rafael Jiménez', '809-123-4595', 'Calle 35, La Vega', 12),
(36, 'Elena Reyes', '809-123-4596', 'Avenida 36, Monte Cristi', 15),
(37, 'Mario Santana', '809-123-4597', 'Calle 37, Pedernales', 17),
(38, 'Gabriela Cruz', '809-123-4598', 'Avenida 38, Monte Plata', 16),
(39, 'Rosa Vargas', '809-123-4599', 'Calle 39, Puerto Plata', 19),
(40, 'Daniel Ortiz', '809-123-4600', 'Avenida 40, Samaná', 20);

SELECT * FROM CLIENTE

-- Insertar vendedores en República Dominicana:

INSERT INTO VENDEDOR (id_vendedor, nombre, telefono, direccion, id_provincia) VALUES 
(1, 'Pedro García', '809-234-5671', 'Calle 1, Distrito Nacional', 1),
(2, 'María López', '809-234-5672', 'Avenida 2, Azua', 2),
(3, 'Juan Martínez', '809-234-5673', 'Calle 3, Bahoruco', 3),
(4, 'Laura Rodríguez', '809-234-5674', 'Avenida 4, Barahona', 4),
(5, 'Carlos Pérez', '809-234-5675', 'Calle 5, Dajabón', 5),
(6, 'Sofía González', '809-234-5676', 'Avenida 6, Duarte', 6),
(7, 'Luisa Gómez', '809-234-5677', 'Calle 7, El Seibo', 7),
(8, 'Javier Ramírez', '809-234-5678', 'Avenida 8, Espaillat', 8),
(9, 'Natalia Suárez', '809-234-5679', 'Calle 9, Independencia', 9),
(10, 'Miguel Torres', '809-234-5680', 'Avenida 10, La Altagracia', 10),
(11, 'Angela Díaz', '809-234-5681', 'Calle 11, La Romana', 11),
(12, 'Fernando Castillo', '809-234-5682', 'Avenida 12, La Vega', 12),
(13, 'Carmen Acosta', '809-234-5683', 'Calle 13, María Trinidad Sánchez', 13),
(14, 'Rafael Jiménez', '809-234-5684', 'Avenida 14, Monseñor Nouel', 14),
(15, 'Elena Reyes', '809-234-5685', 'Calle 15, Monte Cristi', 15);


SELECT * FROM VENDEDOR

INSERT INTO VENDEDOR (id_vendedor, nombre, telefono, direccion, id_provincia) VALUES 
(16, 'Gabriel Martínez', '809-234-5686', 'Avenida 16, Pedernales', 16),
(17, 'Ana Rodríguez', '809-234-5687', 'Calle 17, Peravia', 17),
(18, 'José Pérez', '809-234-5688', 'Avenida 18, Puerto Plata', 18),
(19, 'Marina Gómez', '809-234-5689', 'Calle 19, Hermanas Mirabal', 19),
(20, 'David Suárez', '809-234-5690', 'Avenida 20, Samaná', 20),
(21, 'Sara Castillo', '809-234-5691', 'Calle 21, Sánchez Ramírez', 21),
(22, 'Manuel Torres', '809-234-5692', 'Avenida 22, San Cristóbal', 22),
(23, 'Lucía Díaz', '809-234-5693', 'Calle 23, San José de Ocoa', 23),
(24, 'Francisco Ramírez', '809-234-5694', 'Avenida 24, San Juan', 24),
(25, 'Laura Hernández', '809-234-5695', 'Calle 25, San Pedro de Macorís', 25),
(26, 'Daniel Acosta', '809-234-5696', 'Avenida 26, Santiago', 26),
(27, 'Carolina Jiménez', '809-234-5697', 'Calle 27, Santiago Rodríguez', 27),
(28, 'Jorge Reyes', '809-234-5698', 'Avenida 28, Santo Domingo', 28),
(29, 'Verónica Martínez', '809-234-5699', 'Calle 29, Valverde', 29),
(30, 'Pedro Gómez', '809-234-5700', 'Avenida 30, Monte Plata', 30),
(31, 'María Suárez', '809-234-5701', 'Calle 31, Hato Mayor', 31);



SELECT * FROM VENDEDOR

-- Insertar registros de ejemplo:

INSERT INTO CONDICION_PAGO (id_condicion, condicion)
VALUES
    (1, '30 días'),
    (2, 'Contado'),
    (3, '60 días'),
    (4, 'Cheque a 30 días'),
    (5, 'Cheque a 60 días'),
    (6, 'Tarjeta de crédito'),
    (7, 'Transferencia bancaria');

--SELECCIONAMOS LA TABLA PARA VERLA

SELECT * FROM CONDICION_PAGO


--SELECCIONAMOS LA TABLA PARA VERLA

select * from FACTURA
select * from DETALLE_FACTURA
select * from PRODUCTO

/*
    Trigger para controlar el stock después de la inserción de detalles de factura.

    Funcionalidad:
    - Después de insertar nuevos detalles de factura, este trigger actualiza automáticamente la existencia de productos
      y el total de cada línea de factura en función de la cantidad y el precio unitario de los productos vendidos.

    Notas:
    - Este trigger se activa después de la inserción en la tabla DETALLE_FACTURA.
    - Actualiza la existencia de productos en la tabla PRODUCTO y el total de cada línea de factura en DETALLE_FACTURA.
*/

CREATE OR ALTER TRIGGER controlar_stock_venta ON DETALLE_FACTURA
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_factura INT, @codigo_producto INT, @cantidad INT, @precio_unitario DECIMAL(18,2), @total_linea DECIMAL(18,2);

    -- Declarar un cursor para recorrer las filas insertadas en la tabla 'DETALLE_FACTURA'
    DECLARE cursor_detalle CURSOR FOR
    SELECT id_factura, codigo_producto, cantidad, precio_unitario 
    FROM INSERTED;

    -- Abrir el cursor
    OPEN cursor_detalle;

    -- Iniciar el bucle de cursor
    FETCH NEXT FROM cursor_detalle INTO @id_factura, @codigo_producto, @cantidad, @precio_unitario;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Actualizar el stock del producto
        UPDATE PRODUCTO
        SET existencia = existencia - @cantidad
        WHERE codigo = @codigo_producto;

        -- Calcular el total_linea
        SET @total_linea = @cantidad * @precio_unitario;
        
        -- Actualizar la fila en la tabla 'DETALLE_FACTURA' con el valor de 'total_linea'
        UPDATE DETALLE_FACTURA
        SET total_linea = @total_linea
        WHERE id_factura = @id_factura AND codigo_producto = @codigo_producto;

        -- Obtener la siguiente fila del cursor
        FETCH NEXT FROM cursor_detalle INTO @id_factura, @codigo_producto, @cantidad, @precio_unitario;
    END;

    -- Cerrar el cursor
    CLOSE cursor_detalle;
    DEALLOCATE cursor_detalle;
END;





select * from FACTURA ORDER BY fecha ASC
select * from DETALLE_FACTURA


select * from PRODUCTO
select * from FACTURA
select * from DETALLE_FACTURA

-- Este trigger controla el stock de productos antes de realizar una venta.
-- Se ejecuta en lugar de una operación de inserción (INSTEAD OF INSERT) en la tabla DETALLE_FACTURA.
-- Su propósito es garantizar que no se realicen ventas si no hay suficiente stock disponible.
-- Si hay suficiente stock, actualiza el stock del producto en la tabla PRODUCTO y registra la venta en DETALLE_FACTURA.
-- Si no hay suficiente stock, muestra un mensaje indicando que el producto es insuficiente para completar la venta.


CREATE OR ALTER TRIGGER controlar_stock_venta ON DETALLE_FACTURA
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_factura INT;
    DECLARE @id_producto INT;
    DECLARE @cantidad INT;
    DECLARE @stock_actual INT;

    -- Obtener los valores de la inserción
    SELECT @id_factura = id_factura,
           @id_producto = codigo_producto,
           @cantidad = cantidad
    FROM INSERTED;

    -- Obtener el stock actual del producto
    SELECT @stock_actual = existencia
    FROM PRODUCTO
    WHERE codigo = @id_producto;

    -- Verificar si hay suficiente stock para la venta
    IF @cantidad <= @stock_actual
    BEGIN
        -- Realizar la venta actualizando el stock
        UPDATE PRODUCTO
        SET existencia = @stock_actual - @cantidad
        WHERE codigo = @id_producto;

        -- Insertar la factura
        INSERT INTO DETALLE_FACTURA (id_detalle, id_factura, codigo_producto, cantidad, precio_unitario, total_linea)
        SELECT id_detalle, id_factura, codigo_producto, cantidad, precio_unitario, cantidad * precio_unitario
        FROM INSERTED;
        
        -- Mostrar mensaje de venta exitosa
        PRINT 'Venta realizada exitosamente.';
    END
    ELSE
    BEGIN
        -- Mostrar mensaje de producto insuficiente
        PRINT 'Producto insuficiente para completar la venta.';
    END;
END;



-- Este script genera facturas ficticias con detalles de factura aleatorios para un rango de fechas específico.
-- Comienza obteniendo el próximo ID disponible para las facturas en la tabla FACTURA.
-- Luego, itera a través de un bucle WHILE para generar las facturas.
-- Para cada factura, se elige aleatoriamente un cliente, un vendedor y una condición de pago.
-- Se generan detalles de factura aleatorios para cada factura, donde se elige aleatoriamente un producto con existencia disponible.
-- Se calcula el total de la línea para cada detalle de factura y se inserta en la tabla DETALLE_FACTURA.
-- La existencia del producto se actualiza automáticamente mediante el trigger controlar_stock_venta.
-- El script continúa hasta alcanzar el límite especificado de facturas o hasta que se agote el rango de fechas.



DECLARE @contador INT = (SELECT ISNULL(MAX(id_factura), 0) + 1 FROM FACTURA); -- Iniciar desde el próximo ID disponible
DECLARE @fecha_inicial DATE = '2019-01-01'; -- Define la fecha inicial
DECLARE @fecha_final DATE = '2024-03-29'; -- Define la fecha final

WHILE @contador <= 3600 -- Define aquí el número máximo de facturas
BEGIN
    -- Incrementar la fecha conforme al id_factura
    DECLARE @fecha DATE = DATEADD(DAY, @contador - 1, @fecha_inicial);

    -- Insertar factura si la fecha está dentro del rango
    IF @fecha BETWEEN @fecha_inicial AND @fecha_final
    BEGIN
        -- Obtener un cliente aleatorio
        DECLARE @id_cliente INT = (SELECT TOP 1 id_cliente FROM CLIENTE ORDER BY NEWID());

        -- Obtener un vendedor aleatorio
        DECLARE @id_vendedor INT = (SELECT TOP 1 id_vendedor FROM VENDEDOR ORDER BY NEWID());

        -- Obtener una condición de pago aleatoria
        DECLARE @id_condicion_pago INT = (SELECT TOP 1 id_condicion FROM CONDICION_PAGO ORDER BY NEWID());

        -- Insertar factura
        INSERT INTO FACTURA (id_factura, id_cliente, id_vendedor, fecha, total, id_condicion)
        VALUES (@contador, @id_cliente, @id_vendedor, @fecha, 0.00, @id_condicion_pago); -- Asumiendo que el total puede ser 0 al inicio

        DECLARE @num_detalles INT = CAST(RAND() * 5 + 1 AS INT); -- Número aleatorio de detalles entre 1 y 5
        DECLARE @detalle_counter INT = 1;

        WHILE @detalle_counter <= @num_detalles
        BEGIN
            -- Obtener un producto aleatorio con existencia disponible
            DECLARE @codigo_producto INT = (SELECT TOP 1 codigo FROM PRODUCTO WHERE existencia > 0 ORDER BY NEWID());
            DECLARE @cantidad INT = (SELECT CASE WHEN existencia > 5 THEN CAST(RAND() * 5 + 1 AS INT) ELSE existencia END FROM PRODUCTO WHERE codigo = @codigo_producto);

            -- Obtener el precio unitario del producto
            DECLARE @precio_ventas DECIMAL(18,2) = (SELECT precio_ventas FROM PRODUCTO WHERE codigo = @codigo_producto);

            -- Calcular el total de la línea
            DECLARE @total_linea DECIMAL(18,2) = ISNULL(@cantidad * @precio_ventas, 0.00);

            -- Insertar el detalle de la factura
            INSERT INTO DETALLE_FACTURA (id_detalle, id_factura, codigo_producto, cantidad, precio_unitario, total_linea)
            VALUES (@contador * 1000 + @detalle_counter, @contador, @codigo_producto, @cantidad, @precio_ventas, @total_linea);

            -- Actualizar la existencia del producto (y el total_linea automáticamente a través del trigger)
            -- El trigger controlar_stock_venta se encargará de actualizar la existencia y el total_linea
            -- Este script no necesita hacerlo explícitamente

            SET @detalle_counter = @detalle_counter + 1;
        END;
    END;

    SET @contador = @contador + 1;
END;







CREATE SEQUENCE dbo.FacturaIDSequence
    START WITH 1
    INCREMENT BY 1;


select * from FACTURA ORDER BY fecha ASC
select * from DETALLE_FACTURA
select * from PRODUCTO




UPDATE PRODUCTO
SET existencia = 2700,
    fecha_ingreso = GETDATE();


--SELECCIONA TODO DE LA TABLA PRDOCUCTO

SELECT * FROM PRODUCTO



--VAMOS A PREGUNTARLE A LA BASE DE DATOS SOBRE LAS INFORMACIONES QUE TIENE:

-- LAS CONSULTAS VAN A ESTAR DIVIDAS POR GRUPO:  Grupo 1: Consultas Básicas

--Consulta SELECT simple:

SELECT * FROM PRODUCTO;

-- Esta consulta selecciona todos los registros de la tabla PRODUCTO.

--Consulta SELECT con WHERE:

SELECT * FROM PRODUCTO WHERE existencia > 1400;
-- Esta consulta selecciona los productos que tienen existencia mayor que cero.

--Consulta SELECT con ORDER BY:

SELECT * FROM PRODUCTO ORDER BY precio_compra DESC;

-- Esta consulta selecciona todos los productos y los ordena por precio_compra de forma descendente.

SELECT * FROM PRODUCTO ORDER BY precio_ventas DESC;

-- Esta consulta selecciona todos los productos y los ordena por precio_ventas de forma descendente.

--Consulta SELECT con LIMIT:


SELECT TOP 10 * FROM PRODUCTO;

-- Esta consulta selecciona los primeros 10 registros de la tabla PRODUCTO.

--Consulta SELECT con LIKE:

SELECT * FROM PRODUCTO WHERE descripcion LIKE '%LAPTOP%';
-- Esta consulta selecciona los productos cuya descripción contiene la palabra "LAPTOP".


SELECT * FROM PRODUCTO WHERE descripcion LIKE '%DELL%';
-- Esta consulta selecciona los productos cuya descripción contiene la palabra "DELL".

--Consulta SELECT con IN:


SELECT * FROM PRODUCTO WHERE codigo IN (1001, 1003, 1005);
-- Esta consulta selecciona los productos cuyos códigos son 1001, 1003 o 1005.

--Consulta SELECT con BETWEEN:

SELECT * FROM PRODUCTO WHERE precio_compra BETWEEN 1000 AND 5000;
-- Esta consulta selecciona los productos cuyo precio está entre 1000 y 5000.

SELECT * FROM PRODUCTO WHERE precio_ventas BETWEEN 1000 AND 5000;
-- Esta consulta selecciona los productos cuyo precio está entre 1000 y 5000.

--Consulta SELECT con COUNT:

SELECT COUNT(*) AS total_productos FROM PRODUCTO;
-- Esta consulta cuenta el total de productos en la tabla PRODUCTO.

--Consulta SELECT con SUM:

SELECT SUM(existencia) AS existencia_total FROM PRODUCTO;
-- Esta consulta calcula la suma total de existencias de todos los productos.

-- Consulta para calcular el monto total del stock basado en el precio de compra y el precio de venta.
SELECT 
    -- Calcula el monto total del stock basado en el precio de compra.
    SUM(existencia * precio_compra) AS monto_stock_compra,
    -- Calcula el monto total del stock basado en el precio de venta.
    SUM(existencia * precio_ventas) AS monto_stock_venta
FROM PRODUCTO;


-- Consulta para calcular el monto total del stock basado en el precio de compra y precio de venta,
-- así como el margen total en dinero y en porcentaje.
SELECT 
    -- Calcula el monto total del stock basado en el precio de compra
    SUM(existencia * precio_compra) AS monto_stock_compra,
    -- Calcula el monto total del stock basado en el precio de venta
    SUM(existencia * precio_ventas) AS monto_stock_venta,
    -- Calcula el margen total en dinero, que es la diferencia entre el precio de venta y el precio de compra,
    -- multiplicado por la existencia de cada producto, y luego sumado para todos los productos.
    SUM(existencia * (precio_ventas - precio_compra)) AS margen_dinero,
    -- Calcula el margen total en porcentaje, que es el margen total en dinero dividido por el costo total del stock (precio de compra total),
    -- luego multiplicado por 100 para obtener el porcentaje.
    (SUM(existencia * (precio_ventas - precio_compra)) / SUM(existencia * precio_compra)) * 100 AS margen_porcentaje
FROM PRODUCTO;



--Consulta SELECT con AVG:

SELECT AVG(precio_compra) AS precio_promedio FROM PRODUCTO;
-- Esta consulta calcula el precio promedio de todos los productos.

SELECT AVG(precio_ventas) AS precio_promedio FROM PRODUCTO;
-- Esta consulta calcula el precio promedio de todos los productos.


--Consulta SELECT con MAX:


SELECT MAX(precio_compra) AS precio_maximo FROM PRODUCTO;
-- Esta consulta obtiene el precio máximo de todos los productos.

--Consulta SELECT con MIN:


SELECT MIN(precio_compra) AS precio_minimo FROM PRODUCTO;
-- Esta consulta obtiene el precio mínimo de todos los productos.


SELECT MAX(precio_ventas) AS precio_maximo FROM PRODUCTO;
-- Esta consulta obtiene el precio máximo de todos los productos.

SELECT MIN(precio_ventas) AS precio_minimo FROM PRODUCTO;

-- Esta consulta obtiene el precio mínimo de todos los productos.

-- Consulta para obtener el total máximo de ventas
SELECT MAX(total) AS total_maximo FROM FACTURA;
-- Esta consulta obtiene el total máximo de todas las ventas.

-- Consulta para obtener el total mínimo de ventas
SELECT MIN(total) AS total_minimo FROM FACTURA;
-- Esta consulta obtiene el total mínimo de todas las ventas.


-- Esta consulta une la tabla PRODUCTO con la tabla CLIENTE mediante la columna id_cliente.

--Consulta SELECT con INNER JOIN:


SELECT p.codigo,p.fecha_ingreso, p.descripcion, p.existencia, p.precio_compra, p.precio_ventas, d.cantidad
FROM PRODUCTO p
INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto;

-- Este select recupera información sobre los productos junto con la cantidad vendida en cada factura
SELECT p.codigo, p.fecha_ingreso, p.descripcion, p.existencia, p.precio_compra, p.precio_ventas, d.cantidad,
    (d.cantidad * (p.precio_ventas - p.precio_compra)) AS margen_monto,
    -- Calcula el margen de beneficio en monto para cada producto
    ((p.precio_ventas - p.precio_compra) / p.precio_compra) * 100 AS margen_porcentaje
FROM PRODUCTO p
INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto;



-- Este script SQL selecciona varias columnas de la tabla PRODUCTO junto con la cantidad de cada producto vendido, 
-- y luego calcula el margen de beneficio tanto en monto como en porcentaje para cada producto en función del precio 
-- de compra y el precio de venta. Los resultados se obtienen mediante un JOIN con la tabla DETALLE_FACTURA, donde se 
-- relacionan los productos vendidos con sus respectivas facturas. El margen de beneficio en porcentaje se redondea a 
-- 2 decimales.

SELECT p.codigo, p.fecha_ingreso, p.descripcion, p.existencia, p.precio_compra, p.precio_ventas, d.cantidad,
    (d.cantidad * (p.precio_ventas - p.precio_compra)) AS margen_monto,
    -- Calcula el margen de beneficio en monto para cada producto
    ROUND(((p.precio_ventas - p.precio_compra) / p.precio_compra) * 100, 2) AS margen_porcentaje
FROM PRODUCTO p
INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto;



-- Este script SQL selecciona varias columnas de la tabla PRODUCTO junto con la cantidad de cada producto vendido, 
-- y luego calcula el margen de beneficio tanto en monto como en porcentaje para cada producto en función del precio 
-- de compra y el precio de venta. Los resultados se obtienen mediante un JOIN con la tabla DETALLE_FACTURA, donde se 
-- relacionan los productos vendidos con sus respectivas facturas. El margen de beneficio en porcentaje se redondea a 
-- 2 decimales.
SELECT p.codigo, p.fecha_ingreso, p.descripcion, p.existencia, p.precio_compra, p.precio_ventas, d.cantidad,
    (d.cantidad * (p.precio_ventas - p.precio_compra)) AS margen_monto,
    -- Calcula el margen de beneficio en monto para cada producto
    CAST(ROUND(((p.precio_ventas - p.precio_compra) / p.precio_compra) * 100, 2) AS DECIMAL(18,2)) AS margen_porcentaje
FROM PRODUCTO p
INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto;

-- Este SELECT recupera información sobre los productos junto con la cantidad vendida en cada factura,
-- pero solo selecciona los productos que tienen una cantidad vendida mayor que 3 en al menos una factura.

SELECT p.codigo, p.descripcion, p.precio_compra, p.existencia, p.fecha_ingreso, d.cantidad
FROM PRODUCTO p
INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto
WHERE d.cantidad > 3;


-- Esta consulta utiliza GROUP BY para agrupar las ventas de productos por su código y descripción,
-- luego utiliza HAVING para filtrar solo aquellos productos cuyo total de ventas sea superior a 1000.
SELECT p.codigo, p.descripcion, SUM(d.total_linea) AS total_ventas
FROM PRODUCTO p
INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto
GROUP BY p.codigo, p.descripcion
HAVING SUM(d.total_linea) > 1000;


-- Esta consulta utiliza una subconsulta para seleccionar los productos con la existencia máxima.
SELECT codigo, descripcion, precio_ventas, existencia
FROM PRODUCTO
WHERE existencia = (SELECT MAX(existencia) FROM PRODUCTO);

-- Esta consulta muestra el total de ventas por vendedor.
SELECT v.nombre AS vendedor, SUM(df.total_linea) AS total_ventas
FROM VENDEDOR v
JOIN FACTURA f ON v.id_vendedor = f.id_vendedor
JOIN DETALLE_FACTURA df ON f.id_factura = df.id_factura
GROUP BY v.nombre;


-- Esta consulta muestra los productos con existencia menor 1600 igual a 1600.
SELECT codigo, descripcion, existencia
FROM PRODUCTO
WHERE existencia <= 1600

-- Esta consulta muestra el total de ventas por mes.
SELECT MONTH(f.fecha) AS mes, YEAR(f.fecha) AS año, SUM(df.total_linea) AS total_ventas
FROM FACTURA f
JOIN DETALLE_FACTURA df ON f.id_factura = df.id_factura
GROUP BY MONTH(f.fecha), YEAR(f.fecha);

-- Esta consulta muestra los productos cuyo precio de venta es mayor que el precio promedio de todos los productos.
SELECT codigo, descripcion, precio_ventas
FROM PRODUCTO
WHERE precio_ventas > (SELECT AVG(precio_ventas) FROM PRODUCTO);


-- Esta consulta muestra todas las ventas realizadas por clientes cuyo nombre contiene 'pedro'.
SELECT f.id_factura, f.fecha, c.nombre AS Cliente, v.nombre AS Vendedor, f.total AS TOTAL
FROM FACTURA f
JOIN CLIENTE c ON f.id_cliente = c.id_cliente
JOIN VENDEDOR v ON f.id_vendedor = v.id_vendedor
WHERE f.id_cliente IN (SELECT id_cliente FROM CLIENTE WHERE nombre LIKE '%pedro%');



-- Esta consulta muestra los clientes que tienen más facturas en la base de datos, junto con el número total de facturas y el monto total gastado.
SELECT c.id_cliente, c.nombre, COUNT(f.id_factura) AS total_facturas, SUM(f.total) AS monto_total
FROM CLIENTE c
JOIN FACTURA f ON c.id_cliente = f.id_cliente
WHERE c.id_cliente IN (SELECT id_cliente FROM FACTURA GROUP BY id_cliente HAVING COUNT(*) > 5)
GROUP BY c.id_cliente, c.nombre;




--Consulta con CASE:

SELECT descripcion,
    CASE
        WHEN existencia > 0 THEN 'Disponible'
        ELSE 'Agotado'
    END AS estado
FROM PRODUCTO;


---Creación de una vista básica:


-- Esta vista muestra la cantidad vendida y el monto total de ventas para cada producto.
CREATE OR ALTER VIEW Vista_Ventas_Productos AS
SELECT p.codigo, p.descripcion, 
       SUM(d.cantidad) AS cantidad_vendida,
       SUM(d.total_linea) AS monto_total_ventas
FROM PRODUCTO p
INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto
GROUP BY p.codigo, p.descripcion;


--SELECIONA LA VISTA: Vista_Ventas_Productos

SELECT * FROM Vista_Ventas_Productos




--Stored Procedure para INSERT en PRODUCTO:


CREATE OR ALTER PROCEDURE InsertarProducto 
    @codigo INT,
    @descripcion VARCHAR(100),
    @precio_compra DECIMAL(18,2),
    @precio_ventas DECIMAL(18,2),
    @existencia INT,
    @fecha_ingreso DATE,
    @id_categoria_marca INT  -- Nuevo parámetro para la categoría o marca del producto
AS
BEGIN
    IF EXISTS (SELECT 1 FROM PRODUCTO WHERE codigo = @codigo OR descripcion = @descripcion)
    BEGIN
        PRINT 'No se puede insertar el producto. El código o la descripción ya existen.';
    END
    ELSE
    BEGIN
        INSERT INTO PRODUCTO (codigo, descripcion, precio_compra, precio_ventas, existencia, fecha_ingreso, id_categoria_marca)  -- Se agrega id_categoria_marca en la lista de columnas
        VALUES (@codigo, @descripcion, @precio_compra, @precio_ventas, @existencia, @fecha_ingreso, @id_categoria_marca);  -- Se agrega el valor del parámetro id_categoria_marca
        PRINT 'Producto insertado correctamente.';
    END
END;



-- Probar el stored procedure InsertarProducto

-- Insertar un smart TV
-- Probar el stored procedure InsertarProducto

-- Insertar un smart TV
EXEC InsertarProducto 
    @codigo = 2000,
    @descripcion = 'Smart TV',
    @precio_compra = 15000.00,
    @precio_ventas = 20000.00,
    @existencia = 10,
    @fecha_ingreso = '2024-03-29',
    @id_categoria_marca = 15; -- Supongamos que el ID de la categoría o marca es 1

SELECT * FROM PRODUCTO;



-- Insertar un smartphone
EXEC InsertarProducto 
    @codigo = 2001,
    @descripcion = 'Smartphone',
    @precio_compra = 10000.00,
    @precio_ventas = 15000.00,
    @existencia = 8,
    @fecha_ingreso = '2024-03-29',
    @id_categoria_marca = 14; -- Supongamos que el ID de la categoría o marca es 2

SELECT * FROM PRODUCTO;

-- Insertar una laptop (que ya existe)
EXEC InsertarProducto 
    @codigo = 1000,
    @descripcion = 'LAPTOP ASUS GAMER - Gama ASUS ROG',
    @precio_compra = 42500.84,
    @precio_ventas = 50000.99,
    @existencia = 1613,
    @fecha_ingreso = '2024-11-03',
    @id_categoria_marca = 1; -- Supongamos que el ID de la categoría o marca es 3



SELECT * FROM PRODUCTO
SELECT * FROM CATEGORIA_MARCA

-- INSERTAR ESAS DOS CATEGORIA:

-- Insertar la categoría para Smart TV LG
INSERT INTO CATEGORIA_MARCA (nombre_categoria_marca) VALUES ('Smart TV LG');

-- Insertar la categoría para Smartphone Samsung
INSERT INTO CATEGORIA_MARCA (nombre_categoria_marca) VALUES ('Smartphone Samsung');


-- Stored Procedure para INSERT en PRODUCTO con validación de duplicados
CREATE OR ALTER PROCEDURE InsertarProducto_Concatenacion 
    @codigo INT,
    @descripcion VARCHAR(100),
    @precio_compra DECIMAL(18,2),
    @precio_ventas DECIMAL(18,2),
    @existencia INT,
    @fecha_ingreso DATE,
    @id_categoria_marca INT  -- Nuevo parámetro para la categoría o marca del producto
AS
BEGIN
    IF EXISTS (SELECT 1 FROM PRODUCTO WHERE codigo = @codigo OR descripcion = @descripcion)
    BEGIN
        DECLARE @mensaje_error VARCHAR(200);
        SET @mensaje_error = 'No se puede insertar el producto. El código ' + CAST(@codigo AS VARCHAR) + ' o la descripción "' + @descripcion + '" ya existen.';
        PRINT @mensaje_error;
    END
    ELSE
    BEGIN
        INSERT INTO PRODUCTO (codigo, descripcion, precio_compra, precio_ventas, existencia, fecha_ingreso, id_categoria_marca)
        VALUES (@codigo, @descripcion, @precio_compra, @precio_ventas, @existencia, @fecha_ingreso, @id_categoria_marca);
        PRINT 'Producto insertado correctamente.';
    END
END;


-- Insertar una laptop (que ya existe)
EXEC InsertarProducto_Concatenacion 
    @codigo = 1000,
    @descripcion = 'LAPTOP ASUS GAMER - Gama ASUS ROG',
    @precio_compra = 42500.84,
    @precio_ventas = 50000.99,
    @existencia = 1613,
    @fecha_ingreso = '2024-11-03',
    @id_categoria_marca = 1; -- ID correspondiente a la marca ASUS


SELECT * FROM PRODUCTO


-- Stored Procedure para actualizar la existencia de un producto
CREATE OR ALTER PROCEDURE ActualizarExistenciaProducto
    @codigo INT,
    @nueva_existencia INT,
    @id_categoria_marca INT = NULL  -- Nuevo parámetro para la categoría o marca del producto
AS
BEGIN
    IF EXISTS (SELECT 1 FROM PRODUCTO WHERE codigo = @codigo)
    BEGIN
        UPDATE PRODUCTO
        SET existencia = @nueva_existencia,
            id_categoria_marca = @id_categoria_marca
        WHERE codigo = @codigo;
        PRINT 'Existencia del producto actualizada correctamente.';
    END
    ELSE
    BEGIN
        PRINT 'No se puede actualizar la existencia del producto. El producto con código ' + CAST(@codigo AS VARCHAR) + ' no existe.';
    END
END;




-- Actualizar existencia de un producto existente
EXEC ActualizarExistenciaProducto
    @codigo = 1000,
    @nueva_existencia = 2000;



SELECT * FROM PRODUCTO
SELECT * FROM CATEGORIA_MARCA


-- Actualizar existencia de un producto existente
EXEC ActualizarExistenciaProducto
    @codigo = 1000,
    @nueva_existencia = 2000,
    @id_categoria_marca = 1; -- Asigna 14 al parámetro @id_categoria_marca


-- Actualizar existencia de un producto existente
EXEC ActualizarExistenciaProducto
    @codigo = 2000,
    @nueva_existencia = 1000,
    @id_categoria_marca = 15; -- Asigna 14 al parámetro @id_categoria_marca

-- Actualizar existencia de un producto existente
EXEC ActualizarExistenciaProducto
    @codigo = 2001,
    @nueva_existencia = 1000,
    @id_categoria_marca = 14; -- Asigna 14 al parámetro @id_categoria_marca


-- Intentar actualizar la existencia de un producto que no existe
EXEC ActualizarExistenciaProducto
    @codigo = 9999, -- Suponiendo que 9999 no existe en la tabla PRODUCTO
    @nueva_existencia = 500;


SELECT * FROM PRODUCTO



CREATE or alter  PROCEDURE ActualizarExistenciaProductoPorDescripcion
    @descripcion VARCHAR(100),
    @nueva_existencia INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM PRODUCTO WHERE descripcion = @descripcion)
    BEGIN
        UPDATE PRODUCTO
        SET existencia = @nueva_existencia
        WHERE descripcion = @descripcion;
        PRINT 'Producto actualizado correctamente : ' + @descripcion;
    END
    ELSE
    BEGIN
        PRINT 'No se pudo actualizar la existencia. El producto con descripción ' + @descripcion + ' no existe.';
    END
END;



-- Actualizar existencia de un producto existente por descripción
EXEC ActualizarExistenciaProductoPorDescripcion
    @descripcion = 'LAPTOP ASUS GAMER - Gama ASUS ROG',
    @nueva_existencia = 1500;




CREATE OR ALTER PROCEDURE ActualizarExistenciaProductoPorDescripcion_v2
    @codigo INT,
    @descripcion VARCHAR(100),
    @nueva_existencia INT,
    @nueva_fecha DATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM PRODUCTO WHERE codigo = @codigo)
    BEGIN
        UPDATE PRODUCTO
        SET descripcion = CASE WHEN @descripcion <> '' THEN @descripcion ELSE descripcion END,
            existencia = CASE WHEN @nueva_existencia IS NOT NULL THEN @nueva_existencia ELSE existencia END,
            fecha_ingreso = CASE WHEN @nueva_fecha IS NOT NULL THEN @nueva_fecha ELSE fecha_ingreso END
        WHERE codigo = @codigo;

        IF @@ROWCOUNT > 0
        BEGIN
            PRINT 'Producto actualizado correctamente.';
        END
        ELSE
        BEGIN
            PRINT 'No se pudo actualizar el producto. Revise los parámetros proporcionados.';
        END
    END
    ELSE
    BEGIN
        PRINT 'No se puede actualizar el producto. El producto con código ' + CAST(@codigo AS VARCHAR) + ' no existe.';
    END
END;


SELECT * FROM PRODUCTO

-- Actualizar existencia de Smart TV con una mejor descripción
EXEC ActualizarExistenciaProductoPorDescripcion_v2
    @codigo = 2000,
    @descripcion = 'Smart TV Samsung 50 pulgadas 4K',
    @nueva_existencia = 1750,
    @nueva_fecha = NULL;

-- Actualizar existencia de Smartphone con una mejor descripción
EXEC ActualizarExistenciaProductoPorDescripcion_v2
    @codigo = 2001,
    @descripcion = 'Smartphone Samsung Galaxy S20',
    @nueva_existencia = 1600,
    @nueva_fecha = NULL;



---Stored Procedure para DELETE en CLIENTE:


CREATE OR ALTER PROCEDURE EliminarProducto
    @codigo INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM PRODUCTO WHERE codigo = @codigo)
    BEGIN
        DELETE FROM PRODUCTO
        WHERE codigo = @codigo;
        PRINT 'Producto eliminado correctamente.';
    END
    ELSE
    BEGIN
        PRINT 'No se puede eliminar el producto. El producto con código ' + CAST(@codigo AS VARCHAR) + ' no existe.';
    END
END;

-- Eliminar el producto con código 2000
EXEC EliminarProducto @codigo = 2000;


SELECT * FROM PRODUCTO




-- Esta consulta muestra el nombre del producto y su estado de existencia basado en la cantidad disponible.

SELECT descripcion,
       CASE
           WHEN existencia > 0 THEN 'Disponible'
           ELSE 'Agotado'
       END AS estado_existencia
FROM PRODUCTO;


--Consulta SELECT con WHEN:


SELECT descripcion,
       CASE existencia
           WHEN 0 THEN 'Agotado'
           WHEN 1 THEN 'Bajo'
           WHEN 2 THEN 'Medio'
           ELSE 'Alto'
       END AS estado_existencia
FROM PRODUCTO;


-- Esta consulta muestra el nombre del producto y su estado de existencia según la cantidad disponible.


--Consulta SELECT con THEN:

-- Esta consulta muestra el nombre del producto y su estado de existencia basado en la cantidad disponible utilizando THEN.

SELECT descripcion,
       CASE
           WHEN existencia <= 0 THEN 'Agotado'
           WHEN existencia BETWEEN 1000 AND 2000 THEN 'Bajo'
           WHEN existencia BETWEEN 2000 AND 3000 THEN 'Medio'
           ELSE 'Alto'
       END AS estado_existencia
FROM PRODUCTO;



--Para clasificar los productos según el monto de las ventas, podrías usar una consulta similar a la siguiente:

SELECT descripcion,
       CASE
           WHEN total_ventas <= 10000 THEN 'Categoría A'
           WHEN total_ventas BETWEEN 10001 AND 50000 THEN 'Categoría B'
           WHEN total_ventas BETWEEN 50001 AND 100000 THEN 'Categoría C'
           ELSE 'Categoría D'
       END AS categoria_monto
FROM (
    SELECT p.descripcion, SUM(d.total_linea) AS total_ventas
    FROM PRODUCTO p
    INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto
    GROUP BY p.descripcion
) AS ventas_por_producto;


SELECT * FROM FACTURA
SELECT * FROM DETALLE_FACTURA


/*
Este script SQL calcula la categoría de monto para cada producto basándose en la suma total de las líneas de factura.
Los productos se agrupan por su descripción y se asigna una categoría de acuerdo con los siguientes criterios:
- Categoría A: Suma total de líneas de factura <= 100,000
- Categoría B: Suma total de líneas de factura entre 100,001 y 500,000
- Categoría C: Suma total de líneas de factura entre 500,001 y 1,000,000
- Categoría D: Suma total de líneas de factura superior a 1,000,000
*/
SELECT p.descripcion,
       CASE
           WHEN SUM(d.total_linea) <= 100000 THEN 'Categoría A'
           WHEN SUM(d.total_linea) BETWEEN 100001 AND 500000 THEN 'Categoría B'
           WHEN SUM(d.total_linea) BETWEEN 500001 AND 1000000 THEN 'Categoría C'
           ELSE 'Categoría D'
       END AS categoria_monto
FROM PRODUCTO p
INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto
INNER JOIN FACTURA f ON d.id_fact


/*
Este script SQL selecciona los primeros 5000 productos con la cantidad total vendida y el total de ventas para cada uno.
Los productos se agrupan por su descripción y se ordenan en orden descendente según la cantidad total vendida.
*/
SELECT TOP 5000 p.descripcion AS Producto, SUM(d.cantidad) AS Cantidad_Vendida, SUM(v.total) AS Total
FROM PRODUCTO p
INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto
INNER JOIN FACTURA v ON v.id_factura = d.id_factura
GROUP BY p.descripcion
ORDER BY SUM(d.cantidad) DESC;
*/


/*
Este script SQL calcula el total de ventas para cada producto, los ordena por su total de ventas en orden descendente
y los clasifica en categorías ('A', 'B' o 'C') basadas en sus totales de ventas.
*/

WITH VentasProducto AS (
    SELECT p.descripcion AS Producto, SUM(v.total) AS Total
    FROM PRODUCTO p
    INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto
    INNER JOIN FACTURA v ON v.id_factura = d.id_factura
    GROUP BY p.descripcion
),
VentasOrdenadas AS (
    SELECT Producto, Total,
           ROW_NUMBER() OVER (ORDER BY Total DESC) AS Posicion_Total
    FROM VentasProducto
)
SELECT Producto, Total,
       CASE 
           WHEN Total > 70000000.00 THEN 'A'
           WHEN Total >= 50000000 AND Total < 70000000 THEN 'B'
           ELSE 'C'
       END AS Clasificacion_Total
FROM VentasOrdenadas
ORDER BY Total DESC;

/*
Este script SQL realiza una clasificación de productos basada en el total de ventas.
Primero, se calcula el total de ventas para cada producto utilizando la tabla PRODUCTO, DETALLE_FACTURA y FACTURA, y se almacena en una tabla temporal llamada VentasProducto.
Luego, se selecciona el nombre del producto y su total de ventas de la tabla VentasProducto.
Finalmente, se asigna una clasificación (A, B o C) a cada producto en función de su total de ventas, y se ordenan los resultados por el total de ventas de forma descendente.
*/
WITH VentasProducto AS (
    SELECT p.descripcion AS Producto, SUM(v.total) AS Total
    FROM PRODUCTO p
    INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto
    INNER JOIN FACTURA v ON v.id_factura = d.id_factura
    GROUP BY p.descripcion
)
SELECT Producto, Total,
       CASE 
           WHEN Total > 70000000.00 THEN 'A'
           WHEN Total >= 50000000 AND Total < 70000000 THEN 'B'
           ELSE 'C'
       END AS Clasificacion_Total
FROM VentasProducto
ORDER BY Total DESC;


/*
Este script SQL calcula el total de ventas para cada producto y luego asigna una clasificación (A, B o C) a cada producto en función de su total de ventas.
Primero, se calcula el total de ventas para cada producto utilizando la tabla PRODUCTO, DETALLE_FACTURA y FACTURA, y se almacena en una tabla temporal llamada VentasProducto.
Luego, se asigna un rango (Rank) a cada producto en función de su total de ventas, y se asigna una clasificación (A, B o C) a cada producto.
Finalmente, se seleccionan el nombre del producto, su total de ventas, su rango y su clasificación de la tabla VentasOrdenadas, y se ordenan los resultados por el total de ventas de forma descendente.
*/
WITH VentasProducto AS (
    SELECT p.descripcion AS Producto, SUM(v.total) AS Total
    FROM PRODUCTO p
    INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto
    INNER JOIN FACTURA v ON v.id_factura = d.id_factura
    GROUP BY p.descripcion
),
VentasOrdenadas AS (
    SELECT Producto, Total,
           ROW_NUMBER() OVER (ORDER BY Total DESC) AS Rank,
           CASE 
               WHEN Total > 70000000.00 THEN 'A'
               WHEN Total >= 50000000 AND Total < 70000000 THEN 'B'
               ELSE 'C'
           END AS Clasificacion_Total
    FROM VentasProducto
)
SELECT Producto, Total, Rank, Clasificacion_Total
FROM VentasOrdenadas
ORDER BY Total DESC;


/*
Este script SQL calcula el total de ventas para cada producto y luego asigna una clasificación (A, B o C) a cada producto en función de su total de ventas.
Además, calcula el rango (Rank), el total acumulado de ventas (Acumulado), el total general de ventas (TotalGeneral) y el porcentaje acumulado de ventas (PorcentajeAcumulado).
Primero, se calcula el total de ventas para cada producto utilizando la tabla PRODUCTO, DETALLE_FACTURA y FACTURA, y se almacena en una tabla temporal llamada VentasProducto.
Luego, se asigna un rango (Rank), se calcula el total acumulado de ventas (Acumulado) y se determina la clasificación (A, B o C) para cada producto.
Finalmente, se seleccionan el nombre del producto, su total de ventas, su rango, su total acumulado de ventas, su porcentaje acumulado de ventas y su clasificación de la tabla VentasOrdenadas, y se ordenan los resultados por el total de ventas de forma descendente.
*/

WITH VentasProducto AS (
    SELECT p.descripcion AS Producto, SUM(v.total) AS Total
    FROM PRODUCTO p
    INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto
    INNER JOIN FACTURA v ON v.id_factura = d.id_factura
    GROUP BY p.descripcion
),
VentasOrdenadas AS (
    SELECT Producto, Total,
           ROW_NUMBER() OVER (ORDER BY Total DESC) AS Rank,
           SUM(Total) OVER (ORDER BY Total DESC) AS Acumulado,
           SUM(Total) OVER () AS TotalGeneral,
           ROUND((SUM(Total) OVER (ORDER BY Total DESC) / SUM(Total) OVER ()) * 100, 2) AS PorcentajeAcumulado,
           CASE 
               WHEN Total > 70000000.00 THEN 'A'
               WHEN Total >= 50000000 AND Total < 70000000 THEN 'B'
               ELSE 'C'
           END AS Clasificacion_Total
    FROM VentasProducto
)
SELECT Producto, Total, Rank, Acumulado, PorcentajeAcumulado, Clasificacion_Total
FROM VentasOrdenadas
ORDER BY Total DESC;




-- Este script calcula el ranking, acumulado y clasificación de productos de acuerdo a sus ventas totales,
-- aplicando el principio de Pareto para identificar el 80% y 90% de las ventas totales.
-- Utiliza las tablas PRODUCTO, DETALLE_FACTURA y FACTURA para obtener la información necesaria.
-- La tabla de salida muestra el producto, el total de ventas, el rango, el total acumulado,
-- el porcentaje acumulado, la clasificación según el total de ventas y la clasificación de Pareto.

WITH VentasProducto AS (
    -- Calcula el total de ventas por producto
    SELECT p.descripcion AS Producto, SUM(v.total) AS Total
    FROM PRODUCTO p
    INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto
    INNER JOIN FACTURA v ON v.id_factura = d.id_factura
    GROUP BY p.descripcion
),
VentasOrdenadas AS (
    -- Ordena los productos por total de ventas y asigna un rango
    SELECT Producto, Total,
           ROW_NUMBER() OVER (ORDER BY Total DESC) AS Rank,
           SUM(Total) OVER (ORDER BY Total DESC) AS Acumulado,
           SUM(Total) OVER () AS TotalGeneral,
           SUM(Total) OVER () AS '% Acumulado',
           -- Clasificación de productos por nivel de ventas
           CASE 
               WHEN Total > 70000000.00 THEN 'A'
               WHEN Total >= 50000000 AND Total < 70000000 THEN 'B'
               ELSE 'C'
           END AS Clasificacion_Total
    FROM VentasProducto
),
Pareto AS (
    -- Clasifica los productos según el principio de Pareto (80%, 90%)
    SELECT *,
           CASE
               WHEN Acumulado <= 0.8 * TotalGeneral THEN '80% Pareto'
               WHEN Acumulado <= 0.9 * TotalGeneral THEN '90% Pareto'
               ELSE 'Restante'
           END AS Clasificacion_Pareto
    FROM VentasOrdenadas
)
-- Selecciona los resultados finales y agrega comentarios explicativos
SELECT Producto, Total, Rank, Acumulado, 
       ROUND((Acumulado / TotalGeneral) * 100, 2) AS '% Acumulado', 
       Clasificacion_Total, Clasificacion_Pareto
FROM Pareto
ORDER BY Total DESC;


/*
Este script SQL calcula la cantidad total vendida para cada producto y luego asigna una clasificación (A, B o C) a cada producto en función de su cantidad vendida.
Primero, se calcula la cantidad total vendida para cada producto utilizando la tabla PRODUCTO, DETALLE_FACTURA y FACTURA, y se almacena en una tabla temporal llamada VentasProducto.
Luego, se asigna un rango (Posicion_Cantidad) a cada producto en función de su cantidad vendida.
Finalmente, se selecciona el nombre del producto, su cantidad vendida y su clasificación (A, B o C) de la tabla VentasOrdenadas, y se ordenan los resultados por la cantidad vendida de forma descendente.
*/

WITH VentasProducto AS (
    SELECT p.descripcion AS Producto, SUM(d.cantidad) AS Cantidad_Vendida
    FROM PRODUCTO p
    INNER JOIN DETALLE_FACTURA d ON p.codigo = d.codigo_producto
    INNER JOIN FACTURA v ON v.id_factura = d.id_factura
    GROUP BY p.descripcion
),
VentasOrdenadas AS (
    SELECT Producto, Cantidad_Vendida,
           ROW_NUMBER() OVER (ORDER BY Cantidad_Vendida DESC) AS Posicion_Cantidad
    FROM VentasProducto
)
SELECT Producto, Cantidad_Vendida,
       CASE 
           WHEN Cantidad_Vendida > 1120 THEN 'A'
           WHEN Cantidad_Vendida >= 1050 AND Cantidad_Vendida < 1120 THEN 'B'
           ELSE 'C'
       END AS Clasificacion_Cantidad
FROM VentasOrdenadas
ORDER BY Cantidad_Vendida DESC;



-- Esta consulta muestra el nombre del producto y su estado de existencia, considerando si está agotado o disponible.

--Consulta SELECT con DISTINCT:

SELECT DISTINCT f.id_cliente, c.nombre AS nombre_cliente, p.descripcion AS descripcion_producto, f.total
FROM FACTURA f
JOIN DETALLE_FACTURA d ON f.id_factura = d.id_factura
JOIN CLIENTE c ON f.id_cliente = c.id_cliente
JOIN PRODUCTO p ON d.codigo_producto = p.codigo;

--Consulta SELECT con DISTINCT y otras tablas relacionadas:
SELECT DISTINCT f.id_cliente, c.nombre AS nombre_cliente, p.descripcion AS descripcion_producto, f.total, f.fecha, r.nombre AS nombre_region
FROM FACTURA f
JOIN DETALLE_FACTURA d ON f.id_factura = d.id_factura
JOIN CLIENTE c ON f.id_cliente = c.id_cliente
JOIN PRODUCTO p ON d.codigo_producto = p.codigo
JOIN Provincia pr ON c.id_provincia = pr.id_provincia
JOIN Region r ON pr.id_region = r.id_region;


-- Consulta SELECT con DISTINCT y agrupación por mes:
SELECT 
    DATEPART(MONTH, f.fecha) AS mes,
    SUM(f.total) AS total_ventas,
    COUNT(DISTINCT f.id_cliente) AS total_clientes,
    COUNT(f.id_factura) AS total_facturas,
    SUM(d.cantidad) AS total_cantidad_vendida,
    AVG(f.total) AS promedio_venta
FROM 
    FACTURA f
JOIN 
    DETALLE_FACTURA d ON f.id_factura = d.id_factura
GROUP BY 
    DATEPART(MONTH, f.fecha)
ORDER BY 
    mes;


-- Consulta SELECT con DISTINCT y agrupación por mes:
SELECT 
    DATEPART(MONTH, f.fecha) AS mes,
    c.nombre AS nombre_cliente,
    SUM(f.total) AS total_ventas,
    COUNT(DISTINCT f.id_cliente) AS total_clientes,
    COUNT(f.id_factura) AS total_facturas,
    SUM(d.cantidad) AS total_cantidad_vendida,
    AVG(f.total) AS promedio_venta
FROM 
    FACTURA f
JOIN 
    DETALLE_FACTURA d ON f.id_factura = d.id_factura
JOIN 
    CLIENTE c ON f.id_cliente = c.id_cliente
GROUP BY 
    DATEPART(MONTH, f.fecha), c.nombre
ORDER BY 
    mes;

-- Consulta SELECT con DISTINCT y agrupación por mes sin el total de clientes:
SELECT 
    DATEPART(MONTH, f.fecha) AS mes,
    c.nombre AS nombre_cliente,
    SUM(f.total) AS total_ventas,
    COUNT(f.id_factura) AS total_facturas,
    SUM(d.cantidad) AS total_cantidad_vendida,
    AVG(f.total) AS promedio_venta
FROM 
    FACTURA f
JOIN 
    DETALLE_FACTURA d ON f.id_factura = d.id_factura
JOIN 
    CLIENTE c ON f.id_cliente = c.id_cliente
GROUP BY 
    DATEPART(MONTH, f.fecha), c.nombre
ORDER BY 
    mes;


-- Consulta SELECT con DISTINCT y agrupación por mes sin el total de clientes:
SELECT 
    c.id_cliente,
    c.nombre AS nombre_cliente,
    SUM(f.total) AS total_ventas,
    COUNT(f.id_factura) AS total_facturas,
    SUM(d.cantidad) AS total_cantidad_vendida,
    AVG(f.total) AS promedio_venta
FROM 
    FACTURA f
JOIN 
    DETALLE_FACTURA d ON f.id_factura = d.id_factura
JOIN 
    CLIENTE c ON f.id_cliente = c.id_cliente
GROUP BY 
    c.id_cliente, c.nombre
ORDER BY 
    total_ventas DESC;


-- Consulta SELECT con agrupación por descripción del producto:
SELECT 
    p.descripcion AS descripcion_producto,
    SUM(d.cantidad) AS total_cantidad_vendida,
    SUM(d.total_linea) AS total_ventas
FROM 
    DETALLE_FACTURA d
JOIN 
    PRODUCTO p ON d.codigo_producto = p.codigo
GROUP BY 
    p.descripcion
ORDER BY 
    total_ventas DESC;



SELECT id_vendedor, COUNT(*) AS total_facturas
FROM FACTURA
GROUP BY id_vendedor;

-- Esta consulta cuenta el número total de facturas agrupadas por el id del vendedor.

--Consulta SELECT con HAVING:

SELECT id_vendedor, COUNT(*) AS total_facturas
FROM FACTURA
GROUP BY id_vendedor
HAVING COUNT(*) > 10;

-- Esta consulta cuenta el número total de facturas agrupadas por el id del vendedor y muestra solo aquellos con más de 10 facturas.


--Continuaré con el resto de las consultas en la próxima respuesta.

--Grupo 5: Consultas con CTE (Common Table Expressions)

--Consulta SELECT con CTE:


WITH FacturasTotales AS (
    SELECT id_cliente, COUNT(*) AS total_facturas
    FROM FACTURA
    GROUP BY id_cliente
)
SELECT id_cliente, total_facturas
FROM FacturasTotales
WHERE total_facturas > 5;

-- Esta vista muestra todos los productos disponibles (con existencia mayor a cero).

CREATE VIEW VistaProductosDisponibles AS
SELECT *
FROM PRODUCTO
WHERE existencia > 0;

select * from VistaProductosDisponibles

-- Esta vista muestra los detalles de todas las facturas, incluyendo información sobre el cliente, el vendedor y los productos.
CREATE or alter VIEW VistaFacturasDetalles AS
SELECT f.id_factura, f.fecha, c.nombre AS cliente, v.nombre AS vendedor, df.codigo_producto, p.descripcion AS producto, df.cantidad, df.total_linea
FROM FACTURA f
INNER JOIN CLIENTE c ON f.id_cliente = c.id_cliente
INNER JOIN VENDEDOR v ON f.id_vendedor = v.id_vendedor
INNER JOIN DETALLE_FACTURA df ON f.id_factura = df.id_factura
INNER JOIN PRODUCTO p ON df.codigo_producto = p.codigo;


select * from VistaFacturasDetalles


CREATE OR ALTER VIEW VistaFacturasDetalles_region AS
SELECT f.id_factura, f.fecha, c.nombre AS cliente, 
    c.id_provincia AS id_provincia_cliente, 
    pr.nombre AS provincia_cliente, 
    r.nombre AS region_cliente, 
    v.nombre AS vendedor, 
    v.id_provincia AS id_provincia_vendedor, 
    prv.nombre AS provincia_vendedor, 
    reg.nombre AS region_vendedor, 
    df.codigo_producto, 
    p.descripcion AS producto, 
    df.cantidad, 
    df.total_linea
FROM 
    FACTURA f 
	INNER JOIN CLIENTE c ON f.id_cliente = c.id_cliente
	INNER JOIN VENDEDOR v ON f.id_vendedor = v.id_vendedor
	INNER JOIN DETALLE_FACTURA df ON f.id_factura = df.id_factura
	INNER JOIN PRODUCTO p ON df.codigo_producto = p.codigo
	LEFT JOIN Provincia pr ON c.id_provincia = pr.id_provincia
	LEFT JOIN Region r ON pr.id_region = r.id_region
	LEFT JOIN Provincia prv ON v.id_provincia = prv.id_provincia
	LEFT JOIN Region reg ON prv.id_region = reg.id_region;


select * from VistaFacturasDetalles_region


DECLARE @existencia_minima INT;
SET @existencia_minima = 5;

DECLARE @sql NVARCHAR(MAX);
SET @sql = 'SELECT * FROM PRODUCTO WHERE existencia >= ' + CAST(@existencia_minima AS NVARCHAR);

EXEC sp_executesql @sql;
-- Este ejemplo muestra cómo construir y ejecutar dinámicamente una consulta SQL basada en una variable.


CREATE OR ALTER VIEW VistaFacturasDetalles_Mes AS
SELECT 
    f.id_factura, 
    MONTH(f.fecha) AS mes_factura,
    YEAR(f.fecha) AS año_factura,
    c.nombre AS cliente, 
    c.id_provincia AS id_provincia_cliente, 
    pr.nombre AS provincia_cliente, 
    r.nombre AS region_cliente, 
    v.nombre AS vendedor, 
    v.id_provincia AS id_provincia_vendedor, 
    prv.nombre AS provincia_vendedor, 
    reg.nombre AS region_vendedor, 
    df.codigo_producto, 
    p.descripcion AS producto, 
    df.cantidad, 
    df.total_linea
FROM 
    FACTURA f
INNER JOIN 
    CLIENTE c ON f.id_cliente = c.id_cliente
INNER JOIN 
    VENDEDOR v ON f.id_vendedor = v.id_vendedor
INNER JOIN 
    DETALLE_FACTURA df ON f.id_factura = df.id_factura
INNER JOIN 
    PRODUCTO p ON df.codigo_producto = p.codigo
LEFT JOIN 
    Provincia pr ON c.id_provincia = pr.id_provincia
LEFT JOIN 
    Region r ON pr.id_region = r.id_region
LEFT JOIN 
    Provincia prv ON v.id_provincia = prv.id_provincia
LEFT JOIN 
    Region reg ON prv.id_region = reg.id_region
GROUP BY 
    f.id_factura, 
    YEAR(f.fecha), 
    MONTH(f.fecha), 
    c.nombre, 
    c.id_provincia, 
    pr.nombre, 
    r.nombre, 
    v.nombre, 
    v.id_provincia, 
    prv.nombre, 
    reg.nombre, 
    df.codigo_producto, 
    p.descripcion, 
    df.cantidad, 
    df.total_linea;

--VER LA VISTA:

select * from VistaFacturasDetalles_Mes



CREATE OR ALTER VIEW VistaVentasMensualesCliente AS
SELECT 
    c.id_cliente,
    c.nombre AS cliente,
    YEAR(f.fecha) AS año,
    MONTH(f.fecha) AS mes,
    SUM(df.total_linea) AS total_ventas
FROM 
    FACTURA f
INNER JOIN 
    CLIENTE c ON f.id_cliente = c.id_cliente
INNER JOIN 
    DETALLE_FACTURA df ON f.id_factura = df.id_factura
GROUP BY 
    c.id_cliente,
    c.nombre,
    YEAR(f.fecha),
    MONTH(f.fecha);

-- VER LA VISTA:

select * from VistaVentasMensualesCliente


CREATE OR ALTER VIEW VistaVentasAnualesCliente_yer AS
SELECT 
    c.id_cliente,
    c.nombre AS cliente,
    YEAR(f.fecha) AS año,
    SUM(df.total_linea) AS total_ventas
FROM 
    FACTURA f
INNER JOIN 
    CLIENTE c ON f.id_cliente = c.id_cliente
INNER JOIN 
    DETALLE_FACTURA df ON f.id_factura = df.id_factura
GROUP BY 
    c.id_cliente,
    c.nombre,
    YEAR(f.fecha);

-- VER LA VISTA: 

select * from VistaVentasAnualesCliente_yer order by año desc



CREATE OR ALTER VIEW VistaCompleta AS
SELECT 
    f.id_factura,
    f.fecha AS fecha_factura,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.telefono AS telefono_cliente,
    c.direccion AS direccion_cliente,
    v.id_vendedor,
    v.nombre AS nombre_vendedor,
    v.telefono AS telefono_vendedor,
    v.direccion AS direccion_vendedor,
    p.codigo AS codigo_producto,
    p.descripcion AS descripcion_producto,
    p.precio_ventas AS precio_producto,
    p.existencia AS existencia_inicial,
    df.cantidad AS cantidad_vendida,
    df.total_linea AS monto,
    (p.existencia - SUM(df.cantidad)) AS stock_actual,
    pr.id_provincia,
    pr.nombre AS nombre_provincia,
    r.id_region,
    r.nombre AS nombre_region
FROM 
    FACTURA f
INNER JOIN 
    CLIENTE c ON f.id_cliente = c.id_cliente
INNER JOIN 
    VENDEDOR v ON f.id_vendedor = v.id_vendedor
INNER JOIN 
    DETALLE_FACTURA df ON f.id_factura = df.id_factura
INNER JOIN 
    PRODUCTO p ON df.codigo_producto = p.codigo
INNER JOIN 
    Provincia pr ON c.id_provincia = pr.id_provincia
INNER JOIN 
    Region r ON pr.id_region = r.id_region
GROUP BY 
    f.id_factura,
    f.fecha,
    c.id_cliente,
    c.nombre,
    c.telefono,
    c.direccion,
    v.id_vendedor,
    v.nombre,
    v.telefono,
    v.direccion,
    p.codigo,
    p.descripcion,
    p.precio_ventas,
    p.existencia,
    df.cantidad,
    df.total_linea,
    pr.id_provincia,
    pr.nombre,
    r.id_region,
    r.nombre;




	
select * from VistaCompleta



/*
Esta vista completa de informe combina datos de múltiples tablas para generar un informe detallado de facturas, clientes, vendedores y productos.
Cada fila de la vista contiene información sobre una factura específica, incluyendo detalles del cliente y del vendedor, así como los productos vendidos en esa factura.
Se calcula el stock actual de cada producto restando la cantidad vendida de la existencia inicial.
Además, se calcula el margen de ganancia tanto en términos monetarios como en porcentaje para cada producto.
*/
CREATE OR ALTER VIEW VistaCompleta_Reporte AS
SELECT f.id_factura AS IdFactura,f.fecha AS FechaFactura,c.nombre AS NombreCliente,
    c.telefono AS TelefonoCliente,c.direccion AS DireccionCliente, pr.nombre AS ProvinciaCliente,
    r.nombre AS RegionCliente, v.nombre AS NombreVendedor,v.telefono AS TelefonoVendedor,
    v.direccion AS DireccionVendedor,prv.nombre AS ProvinciaVendedor,rg.nombre AS RegionVendedor,
    p.descripcion AS Producto,p.existencia AS ExistenciaInicial,p.precio_compra AS Precio_Compra,
    p.precio_ventas AS Precio_Venta, df.cantidad AS CantidadVendida, df.total_linea AS Monto,
    (p.existencia - SUM(df.cantidad)) AS StockActual,
	(p.precio_ventas - p.precio_compra) AS Margen_Ganancia_Dinero,
    ((p.precio_ventas - p.precio_compra) / p.precio_ventas) * 100 AS Margen_Ganancia_Porcentaje
FROM FACTURA f
INNER JOIN CLIENTE c ON f.id_cliente = c.id_cliente
INNER JOIN VENDEDOR v ON f.id_vendedor = v.id_vendedor
INNER JOIN DETALLE_FACTURA df ON f.id_factura = df.id_factura
INNER JOIN PRODUCTO p ON df.codigo_producto = p.codigo
INNER JOIN Provincia pr ON c.id_provincia = pr.id_provincia
INNER JOIN Region r ON pr.id_region = r.id_region
INNER JOIN Provincia prv ON v.id_provincia = prv.id_provincia
INNER JOIN Region rg ON prv.id_region = rg.id_region
GROUP BY f.id_factura,f.fecha,c.nombre,c.telefono,c.direccion,pr.nombre,r.nombre,v.nombre,v.telefono,
    v.direccion, prv.nombre,rg.nombre,p.descripcion,p.precio_compra,p.precio_ventas, p.existencia,  df.cantidad,
    df.total_linea;

--VER VISTA: 

select * from VistaCompleta_Reporte


/*
Esta vista completa de informe combina datos de múltiples tablas para generar un informe detallado de facturas, clientes, vendedores y productos.
Cada fila de la vista contiene información sobre una factura específica, incluyendo detalles del cliente y del vendedor, así como los productos vendidos en esa factura.
Se calcula el stock actual de cada producto restando la cantidad vendida de la existencia inicial.
Además, se calcula el margen de ganancia tanto en términos monetarios como en porcentaje para cada producto.
*/

CREATE OR ALTER VIEW VistaCompleta_Reporte_v2 AS
SELECT 
    f.id_factura AS IdFactura,
    f.fecha AS FechaFactura,
    c.nombre AS NombreCliente,
    c.telefono AS TelefonoCliente,
    c.direccion AS DireccionCliente, 
    pr.nombre AS ProvinciaCliente,
    r.nombre AS RegionCliente, 
    v.nombre AS NombreVendedor,
    v.telefono AS TelefonoVendedor,
    v.direccion AS DireccionVendedor,
    prv.nombre AS ProvinciaVendedor,
    rg.nombre AS RegionVendedor,
    p.descripcion AS Producto,
    p.existencia AS ExistenciaInicial,
    p.precio_compra AS Precio_Compra,
    p.precio_ventas AS Precio_Venta, 
    df.cantidad AS CantidadVendida, 
    df.total_linea AS Monto,
    (p.existencia - SUM(df.cantidad)) AS StockActual,
    (p.precio_ventas - p.precio_compra) AS Margen,
    CAST(((p.precio_ventas - p.precio_compra) / p.precio_ventas) * 100 AS DECIMAL(10,2)) AS '% Margen'
FROM 
    FACTURA f
INNER JOIN 
    CLIENTE c ON f.id_cliente = c.id_cliente
INNER JOIN 
    VENDEDOR v ON f.id_vendedor = v.id_vendedor
INNER JOIN 
    DETALLE_FACTURA df ON f.id_factura = df.id_factura
INNER JOIN 
    PRODUCTO p ON df.codigo_producto = p.codigo
INNER JOIN 
    Provincia pr ON c.id_provincia = pr.id_provincia
INNER JOIN 
    Region r ON pr.id_region = r.id_region
INNER JOIN 
    Provincia prv ON v.id_provincia = prv.id_provincia
INNER JOIN 
    Region rg ON prv.id_region = rg.id_region
GROUP BY 
    f.id_factura,
    f.fecha,
    c.nombre,
    c.telefono,
    c.direccion,
    pr.nombre,
    r.nombre,
    v.nombre,
    v.telefono,
    v.direccion,
    prv.nombre,
    rg.nombre,
    p.descripcion,
    p.precio_compra,
    p.precio_ventas, 
    p.existencia,  
    df.cantidad,
    df.total_linea;



select * from VistaCompleta_Reporte_v2


select * from PRODUCTO
	

select * from VistaCompleta_Reporte_Marge_Impuestos
/*
Esta vista ampliada del informe incluye el cálculo de impuestos sobre el precio de venta de los productos. 
Se agrega una columna para el subtotal con ITBIS (Impuesto sobre la Transferencia de Bienes Industrializados y Servicios) al 18%.
También se calcula el monto total con ITBIS incluido para cada línea de factura.
*/
CREATE OR ALTER VIEW VistaCompleta_Reporte_Marge_Impuestos AS
SELECT 
    f.id_factura AS IdFactura,
    f.fecha AS FechaFactura,
    c.nombre AS NombreCliente,
    c.telefono AS TelefonoCliente,
    c.direccion AS DireccionCliente, 
    pr.nombre AS ProvinciaCliente,
    r.nombre AS RegionCliente, 
    v.nombre AS NombreVendedor,
    v.telefono AS TelefonoVendedor,
    v.direccion AS DireccionVendedor,
    prv.nombre AS ProvinciaVendedor,
    rg.nombre AS RegionVendedor,
    p.descripcion AS Producto,
    p.existencia AS ExistenciaInicial,
    p.precio_compra AS Precio_Compra,
    p.precio_ventas AS Precio_Venta, 
    -- Subtotal con ITBIS (18%)
    ROUND((p.precio_ventas * 0.18), 2) AS Subtotal_ITBIS,
    df.cantidad AS CantidadVendida, 
    -- Monto total con ITBIS
    ROUND((df.total_linea + (df.total_linea * 0.18)), 2) AS Monto,
    (p.existencia - SUM(df.cantidad)) AS StockActual,
    (p.precio_ventas - p.precio_compra) AS Margen,
    CAST(((p.precio_ventas - p.precio_compra) / p.precio_ventas) * 100 AS DECIMAL(10,2)) AS '% Margen'
FROM 
    FACTURA f
INNER JOIN 
    CLIENTE c ON f.id_cliente = c.id_cliente
INNER JOIN 
    VENDEDOR v ON f.id_vendedor = v.id_vendedor
INNER JOIN 
    DETALLE_FACTURA df ON f.id_factura = df.id_factura
INNER JOIN 
    PRODUCTO p ON df.codigo_producto = p.codigo
INNER JOIN 
    Provincia pr ON c.id_provincia = pr.id_provincia
INNER JOIN 
    Region r ON pr.id_region = r.id_region
INNER JOIN 
    Provincia prv ON v.id_provincia = prv.id_provincia
INNER JOIN 
    Region rg ON prv.id_region = rg.id_region
GROUP BY 
    f.id_factura,
    f.fecha,
    c.nombre,
    c.telefono,
    c.direccion,
    pr.nombre,
    r.nombre,
    v.nombre,
    v.telefono,
    v.direccion,
    prv.nombre,
    rg.nombre,
    p.descripcion,
    p.precio_compra,
    p.precio_ventas, 
    p.existencia,  
    df.cantidad,
    df.total_linea;



select * from VistaCompleta_Reporte_Marge_Impuestos_Contabilidad

/*
Esta vista ampliada del informe incluye cálculos contables relacionados con impuestos.
Se agrega una columna para el impuesto al valor agregado (ITBIS) al 18% sobre el precio de venta de cada producto vendido.
También se calcula el monto total con el impuesto incluido para cada línea de factura.
*/
CREATE OR ALTER VIEW VistaCompleta_Reporte_Marge_Impuestos_Contabilidad AS
SELECT 
    f.id_factura AS IdFactura,
    f.fecha AS FechaFactura,
    c.nombre AS NombreCliente,
    c.telefono AS TelefonoCliente,
    c.direccion AS DireccionCliente, 
    pr.nombre AS ProvinciaCliente,
    r.nombre AS RegionCliente, 
    v.nombre AS NombreVendedor,
    v.telefono AS TelefonoVendedor,
    v.direccion AS DireccionVendedor,
    prv.nombre AS ProvinciaVendedor,
    rg.nombre AS RegionVendedor,
    p.descripcion AS Producto,
    p.existencia AS ExistenciaInicial,
    p.precio_compra AS Precio_Compra,
    p.precio_ventas AS Precio_Venta, 
    df.cantidad AS CantidadVendida, 
    df.total_linea AS Monto,
    -- Calcula el impuesto al valor agregado (ITBIS) al 18%
    ROUND((p.precio_ventas * df.cantidad) * 0.18, 2) AS Subtotal_ITBIS,
    -- Calcula el monto total con el impuesto incluido
    ROUND(df.total_linea + ((p.precio_ventas * df.cantidad) * 0.18), 2) AS Monto_con_ITBIS,
    (p.precio_ventas - p.precio_compra) AS Margen,
    CAST(((p.precio_ventas - p.precio_compra) / p.precio_ventas) * 100 AS DECIMAL(10,2)) AS '% Margen'
FROM 
    FACTURA f
INNER JOIN 
    CLIENTE c ON f.id_cliente = c.id_cliente
INNER JOIN 
    VENDEDOR v ON f.id_vendedor = v.id_vendedor
INNER JOIN 
    DETALLE_FACTURA df ON f.id_factura = df.id_factura
INNER JOIN 
    PRODUCTO p ON df.codigo_producto = p.codigo
INNER JOIN 
    Provincia pr ON c.id_provincia = pr.id_provincia
INNER JOIN 
    Region r ON pr.id_region = r.id_region
INNER JOIN 
    Provincia prv ON v.id_provincia = prv.id_provincia
INNER JOIN 
    Region rg ON prv.id_region = rg.id_region
GROUP BY 
    f.id_factura,
    f.fecha,
    c.nombre,
    c.telefono,
    c.direccion,
    pr.nombre,
    r.nombre,
    v.nombre,
    v.telefono,
    v.direccion,
    prv.nombre,
    rg.nombre,
    p.descripcion,
    p.precio_compra,
    p.precio_ventas, 
    p.existencia,  
    df.cantidad,
    df.total_linea;

--VER LA VISTA:

select * from VistaCompleta_Reporte_Marge_Impuestos_Contabilidad



/*
Esta vista ampliada del informe incluye cálculos contables relacionados con impuestos, costos e ingresos.
Se agrega una columna para la condición de pago del cliente.
Se calcula el impuesto al valor agregado (ITBIS) al 18% sobre el precio de venta de cada producto vendido.
También se calcula el monto total con el impuesto incluido para cada línea de factura.
Además, se calcula el costo total de los productos vendidos y el ingreso total de las ventas.
Finalmente, se calcula el margen y el porcentaje de margen para cada línea de factura.
*/
CREATE OR ALTER VIEW VistaCompleta_Reporte_Marge_Impuestos_Contabilidad AS
SELECT 
    f.id_factura AS IdFactura,
    f.fecha AS FechaFactura,
    c.nombre AS NombreCliente,
    c.telefono AS TelefonoCliente,
    c.direccion AS DireccionCliente, 
    pr.nombre AS ProvinciaCliente,
    r.nombre AS RegionCliente, 
	cp.condicion AS CondicionPagoCliente,
    v.nombre AS NombreVendedor,
    v.telefono AS TelefonoVendedor,
    v.direccion AS DireccionVendedor,
    prv.nombre AS ProvinciaVendedor,
    rg.nombre AS RegionVendedor,
    p.descripcion AS Producto,
    p.existencia AS ExistenciaInicial,
    p.precio_compra AS Precio_Compra,
    p.precio_ventas AS Precio_Venta, 
    df.cantidad AS CantidadVendida, 
    df.total_linea AS Monto,
    -- Calcula el impuesto al valor agregado (ITBIS) al 18%
    ROUND((p.precio_ventas * df.cantidad) * 0.18, 2) AS Subtotal_ITBIS,
    -- Calcula el monto total con el impuesto incluido
    ROUND(df.total_linea + ((p.precio_ventas * df.cantidad) * 0.18), 2) AS Monto_con_ITBIS,
    -- Calcula el costo total de los productos vendidos
    ROUND(p.precio_compra * df.cantidad, 2) AS Costo_Total,
    -- Calcula el ingreso total de las ventas
    ROUND(df.total_linea + ((p.precio_ventas * df.cantidad) * 0.18), 2) AS Ingreso_Total,
    -- Calcula el margen
    ROUND((df.total_linea + ((p.precio_ventas * df.cantidad) * 0.18)) - (p.precio_compra * df.cantidad), 2) AS Margen,
    -- Calcula el porcentaje de margen
    CAST(((ROUND((df.total_linea + ((p.precio_ventas * df.cantidad) * 0.18)) - (p.precio_compra * df.cantidad), 2)) / (ROUND(df.total_linea + ((p.precio_ventas * df.cantidad) * 0.18), 2))) * 100 AS DECIMAL(10,2)) AS '% Margen'
FROM 
    FACTURA f
INNER JOIN 
    CLIENTE c ON f.id_cliente = c.id_cliente
INNER JOIN 
    CONDICION_PAGO cp ON f.id_condicion = cp.id_condicion
INNER JOIN 
    VENDEDOR v ON f.id_vendedor = v.id_vendedor
INNER JOIN 
    DETALLE_FACTURA df ON f.id_factura = df.id_factura
INNER JOIN 
    PRODUCTO p ON df.codigo_producto = p.codigo
INNER JOIN 
    Provincia pr ON c.id_provincia = pr.id_provincia
INNER JOIN 
    Region r ON pr.id_region = r.id_region
INNER JOIN 
    Provincia prv ON v.id_provincia = prv.id_provincia
INNER JOIN 
    Region rg ON prv.id_region = rg.id_region
GROUP BY 
    f.id_factura,
    f.fecha,
    c.nombre,
    c.telefono,
    c.direccion,
	cp.condicion,
    pr.nombre,
    r.nombre,
    v.nombre,
    v.telefono,
    v.direccion,
    prv.nombre,
    rg.nombre,
    p.descripcion,
    p.precio_compra,
    p.precio_ventas, 
    p.existencia,  
    df.cantidad,
    df.total_linea;


select * from VistaCompleta_Reporte_Marge_Impuestos_Contabilidad






