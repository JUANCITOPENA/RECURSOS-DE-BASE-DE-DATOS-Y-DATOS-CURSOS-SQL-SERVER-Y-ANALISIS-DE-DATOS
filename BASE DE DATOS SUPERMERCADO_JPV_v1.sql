/*

Manual Completo de Base de Datos en SQL Server para SUPERMERCADO_JPV_V3

Introducción: En este manual, aprenderemos a diseñar y gestionar una base de datos completa para un supermercado utilizando SQL Server. 
La base de datos denominada SUPERMERCADO_JPV_V3 incluirá varias tablas relacionadas entre sí para manejar información 
sobre regiones, provincias, géneros, vendedores, fotos de vendedores, productos, fotos de productos, clientes y ventas. 
Además, implementaremos triggers para automatizar actualizaciones de precios y stocks.

Contenidos:
Conceptos Básicos
¿Qué es una Base de Datos?
¿Qué es SQL Server?
¿Qué es SQL?
Introducción a las Bases de Datos Relacionales
Componentes de una Base de Datos Relacional
Conceptos Avanzados:
Normalización
Integridad Referencial
Triggers y Procedimientos Almacenados
Optimización de Consultas
Seguridad en SQL Server

Paso a Paso para Crear la Base de Datos SUPERMERCADO_JPV_V3:

Crear la Base de Datos
Crear Tablas y Relaciones
Insertar Datos de Ejemplo
Implementar Triggers para Automatización
Consultar y Verificar Datos

1. Conceptos Básicos: ¿Qué es una Base de Datos?:

Una base de datos es un conjunto de datos organizados de manera que pueden ser fácilmente accedidos,
gestionados y actualizados. Las bases de datos están diseñadas para permitir el almacenamiento, recuperación
y manejo de grandes cantidades de información de manera eficiente.

¿Qué es SQL Server?

SQL Server es un sistema de gestión de bases de datos relacionales desarrollado por Microsoft. Está diseñado
para manejar una amplia gama de aplicaciones de bases de datos, desde pequeñas hasta grandes aplicaciones empresariales.

¿Qué es SQL?

SQL (Structured Query Language) es el lenguaje estándar para la gestión y manipulación de bases de datos relacionales.
SQL permite crear, leer, actualizar y eliminar datos en una base de datos.

Introducción a las Bases de Datos Relacionales:

Las bases de datos relacionales almacenan datos en tablas. Cada tabla tiene columnas (campos) y filas (registros).
Las tablas pueden estar relacionadas entre sí mediante claves primarias y claves foráneas.

Componentes de una Base de Datos Relacional:

Tablas: Estructuras que almacenan datos.
Campos: Columnas en una tabla que definen el tipo de datos.
Registros: Filas en una tabla que representan una entrada individual de datos.
Claves Primarias: Identificadores únicos para cada registro en una tabla.
Claves Foráneas: Campos que crean una relación entre dos tablas.

2. Conceptos Avanzados:

Normalización
La normalización es el proceso de organizar los datos en una base de datos para reducir la redundancia y mejorar la
integridad de los datos. Esto se logra dividiendo los datos en tablas y definiendo relaciones entre ellas.

Integridad Referencial:

La integridad referencial asegura que las relaciones entre las tablas permanezcan consistentes. Por ejemplo, si una
tabla A tiene una clave foránea que apunta a una clave primaria en la tabla B, no se puede eliminar un registro en la
tabla B si hay registros en la tabla A que referencian ese registro.

Triggers y Procedimientos Almacenados:

Triggers: Son scripts que se ejecutan automáticamente en respuesta a ciertos eventos en una tabla (INSERT, UPDATE, DELETE).
Procedimientos Almacenados: Son conjuntos de instrucciones SQL que se guardan y pueden ejecutarse cuando sea necesario.
Optimización de Consultas

La optimización de consultas implica escribir consultas SQL de manera eficiente para mejorar el rendimiento de la base de
datos. Esto puede incluir el uso de índices, vistas y procedimientos almacenados.

Seguridad en SQL Server:

La seguridad en SQL Server incluye la gestión de usuarios, roles y permisos para asegurar que solo las personas autorizadas
puedan acceder y manipular los datos.


*/


-- Crear una Base de Datos
CREATE DATABASE SUPERMERCADO_JPV_V3;
GO

-- Usar la Base de Datos
USE SUPERMERCADO_JPV_V3;
GO

-- Crear la tabla REGION
CREATE TABLE REGION (
    ID_REGION INT PRIMARY KEY,
    REGION VARCHAR(50) UNIQUE NOT NULL, -- Asegura que el nombre de la región sea único y no nulo
    fecha_creacion DATETIME DEFAULT GETDATE() NOT NULL,
    fecha_actualizacion DATETIME DEFAULT GETDATE() NOT NULL
);
GO

-- Crear la tabla PROVINCIAS
CREATE TABLE PROVINCIAS (
    id_provincia INT PRIMARY KEY,
    nombreProvincia VARCHAR(100) NOT NULL,
    id_region INT NOT NULL,
    latitud DECIMAL(10, 7) NOT NULL,
    longitud DECIMAL(10, 7) NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE() NOT NULL,
    fecha_actualizacion DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT FK_PROVINCIAS_REGION FOREIGN KEY (id_region) REFERENCES REGION(ID_REGION)
);
GO

SELECT* FROM PROVINCIAS

-- Crear la tabla Genero
CREATE TABLE Genero (
    ID_Genero INT PRIMARY KEY,
    Genero VARCHAR(50) NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE() NOT NULL,
    fecha_actualizacion DATETIME DEFAULT GETDATE() NOT NULL
);
GO

-- Crear la tabla VENDEDOR
CREATE TABLE VENDEDOR (
    ID_VENDEDOR INT PRIMARY KEY,
    VENDEDOR VARCHAR(100) NOT NULL,
    id_genero INT NOT NULL, -- Cambiado a INT para relacionar con la tabla Genero
    SUCURSAL VARCHAR(100) NOT NULL,
    PROVINCIA INT NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE() NOT NULL,
    fecha_actualizacion DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT FK_VENDEDOR_GENERO FOREIGN KEY (id_genero) REFERENCES Genero(ID_Genero),
    CONSTRAINT FK_VENDEDOR_PROVINCIAS FOREIGN KEY (PROVINCIA) REFERENCES PROVINCIAS(id_provincia)
);
GO

SELECT * FROM VENDEDOR
SELECT* FROM PROVINCIAS

-- Crear la tabla FOTOS_VENDEDOR
CREATE TABLE FOTOS_VENDEDOR (
    ID_Foto INT PRIMARY KEY,
    foto_Vendedor_url VARCHAR(255) NOT NULL,
    ID_vendedor INT NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE() NOT NULL,
    fecha_actualizacion DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT FK_FOTOS_VENDEDOR_VENDEDOR FOREIGN KEY (ID_vendedor) REFERENCES VENDEDOR(ID_VENDEDOR)
);
GO
-- Verificar la tabla y sus registros:
SELECT * FROM FOTOS_VENDEDOR;

-- Crear la tabla PRODUCTO
CREATE TABLE PRODUCTO (
    ID_PRODUCTO INT PRIMARY KEY,
    PRODUCTO VARCHAR(100) NOT NULL,
    STOCK INT NOT NULL,
    PRECIO_COMPRA DECIMAL(10, 2) NOT NULL,
    PRECIO_VENTA DECIMAL(10, 2) NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE() NOT NULL,
    fecha_actualizacion DATETIME DEFAULT GETDATE() NOT NULL
);
GO

-- Crear la tabla FOTO_PRODUCTOS
CREATE TABLE FOTO_PRODUCTOS (
    ID_Foto INT PRIMARY KEY,
    foto_Productos_url VARCHAR(255) NOT NULL,
    ID_PRODUCTO INT NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE() NOT NULL,
    fecha_actualizacion DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT FK_FOTO_PRODUCTOS_PRODUCTO FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO(ID_PRODUCTO)
);
GO

-- Verificar la tabla y sus registros:
SELECT * FROM FOTO_PRODUCTOS;


-- Crear la tabla CLIENTE
CREATE TABLE CLIENTE (
    ID_CLIENTE INT PRIMARY KEY,
    NOMBRE_CLIENTE VARCHAR(100) NOT NULL,
    APELLIDO_CLIENTE VARCHAR(100) NOT NULL,
    id_region INT NOT NULL,
    id_provincia INT NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE() NOT NULL,
    fecha_actualizacion DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT FK_CLIENTE_PROVINCIAS FOREIGN KEY (id_provincia) REFERENCES PROVINCIAS(id_provincia),
    CONSTRAINT FK_CLIENTE_REGION FOREIGN KEY (id_region) REFERENCES REGION(ID_REGION)
);
GO

-- Seleccionar todos los registros de la tabla CLIENTE
SELECT * FROM CLIENTE;
GO

-- Seleccionar todos los registros de la tabla CLIENTE
SELECT * FROM PRODUCTO;
GO

-- Seleccionar todos los registros de la tabla CLIENTE
SELECT * FROM VENTAS;
GO


-- Actualizar el stock de todos los productos a un valor específico (por ejemplo, x = 200)
UPDATE PRODUCTO
SET STOCK = 20000; -- Aquí reemplaza 200 con el valor deseado para el stock

-- Verificar los registros actualizados
SELECT * FROM PRODUCTO;


-- Crear la tabla VENTAS
CREATE TABLE VENTAS (
    FECHA DATE NOT NULL,
    ID_PEDIDO INT PRIMARY KEY,
    ID_CLIENTE INT NOT NULL, -- Cambiado a INT para relacionar correctamente con la tabla CLIENTE
    ID_VENDEDOR INT NOT NULL, -- Cambiado a INT para relacionar correctamente con la tabla VENDEDOR
    ID_REGION INT NOT NULL,
    ID_PRODUCTO INT NOT NULL,
    CANTIDAD INT NOT NULL,
    PRECIO DECIMAL(10, 2) NOT NULL,
    TOTAL DECIMAL(10, 2) NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE() NOT NULL,
    fecha_actualizacion DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT FK_VENTAS_CLIENTE FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE),
    CONSTRAINT FK_VENTAS_VENDEDOR FOREIGN KEY (ID_VENDEDOR) REFERENCES VENDEDOR(ID_VENDEDOR),
    CONSTRAINT FK_VENTAS_REGION FOREIGN KEY (ID_REGION) REFERENCES REGION(ID_REGION),
    CONSTRAINT FK_VENTAS_PRODUCTO FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO(ID_PRODUCTO)
);
GO

-- Crear un trigger para actualizar el precio y el total en la tabla VENTAS
CREATE TRIGGER TR_VENTAS_UPDATE_TOTAL
ON VENTAS
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE VENTAS
    SET PRECIO = P.PRECIO_VENTA,
        TOTAL = I.CANTIDAD * P.PRECIO_VENTA,
        fecha_actualizacion = GETDATE()
    FROM INSERTED I
    JOIN PRODUCTO P ON I.ID_PRODUCTO = P.ID_PRODUCTO
    WHERE VENTAS.ID_PEDIDO = I.ID_PEDIDO;
END;
GO


-- Crear un trigger para actualizar el stock en la tabla PRODUCTO al realizar una venta
CREATE TRIGGER TR_ACTUALIZAR_STOCK_PRODUCTO
ON VENTAS
AFTER INSERT, UPDATE
AS
BEGIN
    -- Actualizar el stock en la tabla PRODUCTO
    UPDATE P
    SET P.STOCK = P.STOCK - I.CANTIDAD
    FROM PRODUCTO P
    JOIN INSERTED I ON P.ID_PRODUCTO = I.ID_PRODUCTO;
END;
GO

SELECT * FROM dbo.VENTAS;


-- Insertar datos en la tabla REGION
INSERT INTO REGION (ID_REGION, REGION) VALUES
(1, 'NORTE'),
(2, 'SUR'),
(3, 'ESTE'),
(4, 'OESTE');

-- Verificar la tabla y sus registros:
SELECT * FROM REGION;

-- Insertar datos en la tabla PROVINCIAS
INSERT INTO PROVINCIAS (id_provincia, nombreProvincia, id_region, latitud, longitud) VALUES
(1, 'La Altagracia', 1, 18.6167, -68.7167),
(2, 'El Seibo', 1, 18.7667, -69.0333),
(3, 'Hato Mayor', 1, 18.7667, -69.25),
(4, 'La Romana', 1, 18.4273, -68.9728),
(5, 'San Pedro de Macorís', 1, 18.4616, -69.2973),
(6, 'Santiago', 2, 19.4515, -70.6973),
(7, 'Puerto Plata', 2, 19.7907, -70.6907),
(8, 'Duarte', 2, 19.197, -70.684),
(9, 'Espaillat', 2, 19.5753, -70.6467),
(10, 'La Vega', 2, 19.2167, -70.5167),
(11, 'Azua', 3, 18.4667, -70.7333),
(12, 'Barahona', 3, 18.2085, -71.1007),
(13, 'San Juan', 3, 18.8067, -71.2294),
(14, 'San Cristóbal', 3, 18.4167, -70.1),
(15, 'Peravia', 3, 18.2833, -70.3333);

-- Verificar la tabla y sus registros:
SELECT * FROM PROVINCIAS;

-- Insertar 30 registros en la tabla CLIENTE
INSERT INTO CLIENTE (ID_CLIENTE, NOMBRE_CLIENTE, APELLIDO_CLIENTE, id_region, id_provincia) VALUES
(1, 'Alejandro', 'Perez', 1, 1),
(2, 'María', 'Vizcaino', 2, 2),
(3, 'José', 'Santana', 1, 2),
(4, 'Laura', 'Diaz', 2, 2),
(5, 'Carlos', 'Bergara', 1, 3),
(6, 'Lucía', 'Ramos', 2, 3),
(7, 'Juan', 'Comila', 1, 1),
(8, 'Ana', 'Gabrie', 2, 1),
(9, 'Luis', 'Diaz', 1, 2),
(10, 'Carmen', 'Santana', 2, 2),
(11, 'Miguel', 'Ramos', 1, 3),
(12, 'Sofía', 'Comila', 2, 3),
(13, 'Pablo', 'Perez', 1, 1),
(14, 'Isabel', 'Vizcaino', 2, 1),
(15, 'Diego', 'Santana', 1, 2),
(16, 'Paula', 'Diaz', 2, 2),
(17, 'Francisco', 'Bergara', 1, 3),
(18, 'Marta', 'Ramos', 2, 3),
(19, 'Antonio', 'Comila', 1, 1),
(20, 'Elena', 'Gabrie', 2, 1),
(21, 'Javier', 'Diaz', 1, 2),
(22, 'Sara', 'Santana', 2, 2),
(23, 'Andrés', 'Ramos', 1, 3),
(24, 'Claudia', 'Comila', 2, 3),
(25, 'Manuel', 'Perez', 1, 1),
(26, 'Patricia', 'Vizcaino', 2, 1),
(27, 'David', 'Santana', 1, 2),
(28, 'Teresa', 'Diaz', 2, 2),
(29, 'Sergio', 'Bergara', 1, 3),
(30, 'Julia', 'Ramos', 2, 3);

-- Verificar la tabla y sus registros:
SELECT * FROM CLIENTE;

-- Insertar los géneros
INSERT INTO Genero (ID_Genero, Genero) VALUES
(1, 'Masculino'),
(2, 'Femenino'),
(3, 'Otros');

-- Verificar la tabla y sus registros:
SELECT * FROM Genero;

-- Insertar los vendedores
INSERT INTO VENDEDOR (ID_VENDEDOR, VENDEDOR, id_genero, SUCURSAL, PROVINCIA) VALUES
    (1, 'Juan Perez', 1, 'Sucursal A', 1),
    (2, 'Maria Vizcaino', 2, 'Sucursal B', 2),
    (3, 'Ana Santana', 2, 'Sucursal C', 3),
    (4, 'Luis Diaz', 1, 'Sucursal D', 4),
    (5, 'Sofia Bergara', 2, 'Sucursal A', 5),
    (6, 'Jorge Ramos', 1, 'Sucursal B', 6),
    (7, 'Juan Comila', 1, 'Sucursal C', 7),
    (8, 'Juan Gabrie', 1, 'Sucursal D', 8),
    (9, 'Carlos Santos', 1, 'Sucursal A', 9),
    (10, 'Julio Linarez', 1, 'Sucursal B', 10),
    (11, 'Pedro Gómez', 1, 'Sucursal C', 11),
    (12, 'María Rodríguez', 2, 'Sucursal D', 12),
    (13, 'Alejandro Pérez', 1, 'Sucursal A', 13),
    (14, 'Lucía López', 2, 'Sucursal B', 14),
    (15, 'Laura de la Rosa', 2, 'Sucursal C', 15);
go


-- Verificar los registros insertados en la tabla VENDEDOR
SELECT * FROM VENDEDOR;

-- Verificar la tabla y sus registros:
SELECT * FROM VENDEDOR;

-- Insertar datos en la tabla PRODUCTO
INSERT INTO PRODUCTO (ID_PRODUCTO, PRODUCTO, STOCK, PRECIO_COMPRA, PRECIO_VENTA) VALUES
(1, 'Leche', 100, 50.00, 70.00),
(2, 'Legumbres', 200, 30.00, 50.00),
(3, 'Frutas frescas', 150, 20.00, 40.00),
(4, 'Pan integral', 300, 40.00, 60.00),
(5, 'Aceite', 250, 45.00, 65.00),
(6, 'Arroz', 350, 25.00, 45.00),
(7, 'Huevos', 400, 35.00, 55.00),
(8, 'Yogur', 180, 30.00, 50.00),
(9, 'Aceite de oliva', 130, 60.00, 80.00),
(10, 'Agua potable', 500, 10.00, 30.00),
(11, 'Verduras frescas', 220, 15.00, 35.00),
(12, 'Carne de pollo', 270, 55.00, 75.00),
(13, 'Pescado', 160, 50.00, 70.00),
(14, 'Queso', 140, 65.00, 85.00),
(15, 'Miel', 190, 75.00, 95.00);

-- Verificar la tabla y sus registros:
SELECT * FROM PRODUCTO;

-- Insertar datos en la tabla FOTO_PRODUCTOS
INSERT INTO FOTO_PRODUCTOS (ID_Foto, foto_Productos_url, ID_PRODUCTO) VALUES
(1, 'https://png.pngtree.com/png-vector/20240206/ourmid/pngtree-gallon-of-milk-isolated-on-white-drink-cutout-lactosefresh-png-image_11635524.png', 1),
(2, 'https://hslegumbres.com.ar/wp-content/uploads/2019/09/legumbres-min.png', 2),
(3, 'https://png.png-clipart/20231122/original/pngtree-group-of-fresh-fruits-many-photo-png-image_13690072.png', 3),
(4, 'https://png.pngtree.com/png-clipart/20230929/original/pngtree-whole-wheat-bread-cutout-png-file-png-image_13018044.png', 4),
(5, 'https://cdn-icons-png.freepik.com/512/5029/5029264.png', 5),
(6, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4_WmdkkAcceSl35xcwCOyP36s_xHnu0Yh2A&s', 6),
(7, 'https://acdn.mitiendanube.com/stores/001/926/707/products/mesa-de-trabajo-11-ab4aedeb4966ce692416358047799893-640-0.png', 7),
(8, 'https://perulabecologic.com.pe/wp-content/uploads/2020/04/yogurt-natural-botella.png', 8),
(9, 'https://studikard.com/wp-content/uploads/2021/11/Aceite-de-oliva-extra-virgen.png', 9),
(10, 'https://www.lenntech.com/images/Water/bottled.png', 10),
(11, 'https://img.pikbest.com/origin/09/05/38/99KpIkbEsTxDy.png!w700wp', 11),
(12, 'https://carnessanpietro.com/wp-content/uploads/2023/12/carne_carne-para-bistec.png', 12),
(13, 'https://res.cloudinary.com/oita/image/upload/v1688057414/Merco/Parte%205/7720_PESCADO_PARA_CALDO_m4getv.png', 13),
(14, 'https://covica.es/wp-content/uploads/2022/11/QUESOS_36-removebg-preview.png', 14),
(15, 'https://prodexspa.com/wp-content/uploads/2023/05/foto_miel_apoyo_low.png', 15);

-- Verificar la tabla y sus registros:
SELECT * FROM FOTO_PRODUCTOS;

-- Insertar datos en la tabla FOTOS_VENDEDOR
INSERT INTO FOTOS_VENDEDOR (ID_FOTO, FOTO_VENDEDOR_URL, ID_VENDEDOR) VALUES
(1, 'https://dl.dropbox.com/s/4bz1xriny7ro04g/A40.png', 1),
(2, 'https://dl.dropbox.com/s/yxe96df3xrzoc4y/A44.png', 2),
(3, 'https://dl.dropboxusercontent.com/s/2lks10yyiurw2b0/A33.png', 3),
(4, 'https://dl.dropbox.com/s/zgx7g0h0mxubhao/A21.png', 4),
(5, 'https://dl.dropboxusercontent.com/s/id0gj57k6z3m73q/A34.png', 5),
(6, 'https://dl.dropbox.com/s/1f9hzgblcmuen4a/A10.png', 6),
(7, 'https://dl.dropbox.com/s/jveyj0btov87izo/A38.png', 7),
(8, 'https://dl.dropbox.com/s/z4geyw1u2psmm47/A16.png', 8),
(9, 'https://uploaddeimagens.com.br/images/002/602/727/full/196-leonardo-cardoso.png', 9),
(10, 'https://uploaddeimagens.com.br/images/002/602/729/full/265-julio-lima.png', 10),
(11, 'https://dl.dropboxusercontent.com/s/xnimxsc4d2ie02f/A50.png', 11),
(12, 'https://uploaddeimagens.com.br/images/002/602/728/full/215-carla-ferreira.png', 12),
(13, 'https://dl.dropbox.com/s/0jkab8w6ie0h91z/A42.png', 13),
(14, 'https://dl.dropboxusercontent.com/s/ov3t5g3xt8wm8zg/A29.png', 14),
(15, 'https://dl.dropbox.com/s/27oq7ocj4q8a0z8/A46.png', 15);

-- Verificar la tabla y sus registros:
SELECT * FROM FOTOS_VENDEDOR;

-- Insertar datos en la tabla VENTAS
-- Nota: He corregido los IDs de cliente y vendedor de acuerdo a tu esquema de datos
INSERT INTO VENTAS (FECHA, ID_PEDIDO, ID_CLIENTE, ID_VENDEDOR, ID_REGION, ID_PRODUCTO, CANTIDAD, PRECIO, TOTAL) VALUES
('2020-01-03', 1, 1, 1, 1, 1, 90, 40, 2700),
('2020-01-03', 2, 2, 2, 1, 2, 36, 65, 1800),
('2020-01-09', 3, 3, 3, 1, 3, 13, 55, 520),
('2020-01-10', 4, 4, 4, 1, 4, 71, 45, 2485),
('2020-01-17', 5, 5, 5, 1, 5, 48, 120, 4800);

-- Verificar la tabla y sus registros:
SELECT * FROM VENTAS;

-- Crear el trigger para actualizar el stock después de insertar en la tabla VENTAS
CREATE OR ALTER TRIGGER actualizar_stock_trigger
ON VENTAS
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE PRODUCTO
    SET STOCK = STOCK - i.CANTIDAD
    FROM PRODUCTO p
    INNER JOIN inserted i ON p.ID_PRODUCTO = i.ID_PRODUCTO;
END;

-- Verificar las ventas insertadas
SELECT * FROM VENTAS ORDER BY FECHA DESC;



--CREAR UNA SCRIPT CON LA GENERACION AUTOMATICA DE DATOS DE PRUEBAS:

-- Definir parámetros
DECLARE @FechaInicio DATE = '2024-08-16';
DECLARE @FechaFin DATE = '2024-08-16';
DECLARE @CantidadRegistros INT = 1000; -- Cambiar según la cantidad deseada

-- Variables auxiliares
DECLARE @ID_PEDIDO INT;
DECLARE @ID_CLIENTE INT;
DECLARE @ID_VENDEDOR INT;
DECLARE @ID_REGION INT;
DECLARE @ID_PRODUCTO INT;
DECLARE @CANTIDAD INT;
DECLARE @PRECIO DECIMAL(10, 2);
DECLARE @TOTAL DECIMAL(10, 2);
DECLARE @FechaVenta DATE;

-- Inicializar contador de pedidos
SELECT @ID_PEDIDO = ISNULL(MAX(ID_PEDIDO), 0) FROM VENTAS;

-- Generar ventas aleatorias
WHILE @CantidadRegistros > 0
BEGIN
    -- Generar valores aleatorios
    SELECT 
        @ID_PEDIDO = @ID_PEDIDO + 1,
        @ID_CLIENTE = (SELECT TOP 1 ID_CLIENTE FROM CLIENTE ORDER BY NEWID()),
        @ID_VENDEDOR = (SELECT TOP 1 ID_VENDEDOR FROM VENDEDOR ORDER BY NEWID()),
        @ID_REGION = (SELECT TOP 1 ID_REGION FROM REGION ORDER BY NEWID()),
        @ID_PRODUCTO = (SELECT TOP 1 ID_PRODUCTO FROM PRODUCTO ORDER BY NEWID()),
        @CANTIDAD = CAST(RAND() * 100 AS INT) + 1, -- Cantidad entre 1 y 100
        @PRECIO = (CAST(RAND() * 50 AS DECIMAL(10, 2)) + 50.00), -- Precio entre 50 y 100
        @FechaVenta = DATEADD(day, CAST(RAND() * (DATEDIFF(day, @FechaInicio, @FechaFin) + 1) AS INT), @FechaInicio);

    -- Calcular total
    SET @TOTAL = @CANTIDAD * @PRECIO;

    -- Insertar venta
    INSERT INTO VENTAS (FECHA, ID_PEDIDO, ID_CLIENTE, ID_VENDEDOR, ID_REGION, ID_PRODUCTO, CANTIDAD, PRECIO, TOTAL, fecha_creacion, fecha_actualizacion)
    VALUES (@FechaVenta, @ID_PEDIDO, @ID_CLIENTE, @ID_VENDEDOR, @ID_REGION, @ID_PRODUCTO, @CANTIDAD, @PRECIO, @TOTAL, GETDATE(), GETDATE());

    -- Decrementar contador
    SET @CantidadRegistros = @CantidadRegistros - 1;
END
GO

-- Asegurar al menos una venta por mes para cada vendedor y cada producto
DECLARE @CurrentDate DATE = @FechaInicio;
DECLARE @EndDate DATE = @FechaFin;

WHILE @CurrentDate <= @EndDate
BEGIN
    DECLARE @CurrentMonth INT = MONTH(@CurrentDate);
    DECLARE @CurrentYear INT = YEAR(@CurrentDate);

    DECLARE @VendorCursor CURSOR;
    DECLARE @ProductCursor CURSOR;

    DECLARE @CurrentVendor INT;
    DECLARE @CurrentProduct INT;

    SET @VendorCursor = CURSOR FOR SELECT ID_VENDEDOR FROM VENDEDOR;
    OPEN @VendorCursor;

    FETCH NEXT FROM @VendorCursor INTO @CurrentVendor;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @ProductCursor = CURSOR FOR SELECT ID_PRODUCTO FROM PRODUCTO;
        OPEN @ProductCursor;

        FETCH NEXT FROM @ProductCursor INTO @CurrentProduct;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            INSERT INTO VENTAS (FECHA, ID_PEDIDO, ID_CLIENTE, ID_VENDEDOR, ID_REGION, ID_PRODUCTO, CANTIDAD, PRECIO, TOTAL, fecha_creacion, fecha_actualizacion)
            SELECT
                DATEADD(day, CAST(RAND() * (DAY(EOMONTH(@CurrentDate)) - 1) AS INT), DATEFROMPARTS(@CurrentYear, @CurrentMonth, 1)),
                @ID_PEDIDO + 1,
                (SELECT TOP 1 ID_CLIENTE FROM CLIENTE WHERE ID_VENDEDOR = @CurrentVendor ORDER BY NEWID()),
                @CurrentVendor,
                (SELECT id_region FROM CLIENTE WHERE ID_CLIENTE = @ID_CLIENTE),
                @CurrentProduct,
                CAST(RAND() * 100 AS INT) + 1, -- Cantidad entre 1 y 100
                (CAST(RAND() * 50 AS DECIMAL(10, 2)) + 50.00), -- Precio entre 50 y 100
                (CAST(RAND() * 50 AS DECIMAL(10, 2)) + 50.00) * (CAST(RAND() * 100 AS INT) + 1), -- Total calculado aleatoriamente
                GETDATE(), GETDATE();

            SET @ID_PEDIDO = @ID_PEDIDO + 1;

            FETCH NEXT FROM @ProductCursor INTO @CurrentProduct;
        END;

        CLOSE @ProductCursor;
        DEALLOCATE @ProductCursor;

        FETCH NEXT FROM @VendorCursor INTO @CurrentVendor;
    END;

    CLOSE @VendorCursor;
    DEALLOCATE @VendorCursor;

    SET @CurrentDate = DATEADD(month, 1, @CurrentDate);
END;
GO


select * from CLIENTE

--VER LA TABLA VENTAS:

select * from VENTAS

-- Eliminar la tabla VENTAS
DROP TABLE VENTAS;



-- Verificar las ventas insertadas
SELECT * FROM VENTAS ORDER BY FECHA DESC;





SELECT
    C.ID_CLIENTE,
    C.NOMBRE_CLIENTE,
    C.APELLIDO_CLIENTE,
    CASE 
        WHEN COUNT(V.ID_PEDIDO) > 0 THEN 'Ha realizado compras'
        ELSE 'Nunca ha realizado una compra'
    END AS Clientes_Status
FROM
    CLIENTE C
LEFT JOIN
    VENTAS V ON C.ID_CLIENTE = V.ID_CLIENTE
GROUP BY
    C.ID_CLIENTE, C.NOMBRE_CLIENTE, C.APELLIDO_CLIENTE;


-- Consulta básica con JOIN y condición WHERE:
SELECT V.FECHA, V.ID_PEDIDO, C.NOMBRE_CLIENTE, P.PRODUCTO, V.CANTIDAD, V.PRECIO, V.TOTAL
FROM VENTAS V
INNER JOIN CLIENTE C ON V.ID_CLIENTE = C.ID_CLIENTE
INNER JOIN PRODUCTO P ON V.ID_PRODUCTO = P.ID_PRODUCTO
WHERE V.FECHA BETWEEN '2023-01-01' AND '2023-12-31';

-- Consulta con agrupación y función de suma:
SELECT V.ID_VENDEDOR, COUNT(*) AS Ventas_Realizadas, SUM(V.TOTAL) AS Total_Ventas
FROM VENTAS V
GROUP BY V.ID_VENDEDOR
ORDER BY Total_Ventas DESC;

-- Consulta con subconsulta correlacionada:
SELECT P.PRODUCTO, P.PRECIO_VENTA,
       (SELECT AVG(V.PRECIO) FROM VENTAS V WHERE V.ID_PRODUCTO = P.ID_PRODUCTO) AS Precio_Promedio_Venta
FROM PRODUCTO P;

-- Consulta con función de ventana (RANK) y partición:
SELECT V.ID_PEDIDO, V.FECHA, V.TOTAL,
       RANK() OVER(PARTITION BY V.ID_CLIENTE ORDER BY V.TOTAL DESC) AS Ranking_Ventas_Cliente
FROM VENTAS V;

-- Consulta con JOIN, CASE WHEN y función de agregación:
SELECT C.NOMBRE_CLIENTE,
       SUM(CASE WHEN V.TOTAL > 1000 THEN 1 ELSE 0 END) AS Ventas_Mayores_1000,
       AVG(V.TOTAL) AS Promedio_Total_Ventas
FROM VENTAS V
INNER JOIN CLIENTE C ON V.ID_CLIENTE = C.ID_CLIENTE
GROUP BY C.NOMBRE_CLIENTE;

-- Consulta con subconsulta y función de agregación:
SELECT P.PRODUCTO, P.PRECIO_VENTA,
       (SELECT SUM(V.CANTIDAD) FROM VENTAS V WHERE V.ID_PRODUCTO = P.ID_PRODUCTO) AS Total_Unidades_Vendidas
FROM PRODUCTO P;

-- Consulta con JOIN y ordenamiento (ORDER BY):
SELECT C.NOMBRE_CLIENTE, V.FECHA, V.TOTAL
FROM VENTAS V
INNER JOIN CLIENTE C ON V.ID_CLIENTE = C.ID_CLIENTE
ORDER BY V.FECHA DESC;

-- Consulta con función de agregación y filtro HAVING:
SELECT V.ID_VENDEDOR, COUNT(*) AS Total_Ventas,
       AVG(V.TOTAL) AS Promedio_Ventas
FROM VENTAS V
GROUP BY V.ID_VENDEDOR
HAVING COUNT(*) > 5;

-- Consulta con CTE (Common Table Expression) y JOIN:
WITH Ventas_Clientes AS (
    SELECT V.ID_CLIENTE, COUNT(*) AS Total_Ventas
    FROM VENTAS V
    GROUP BY V.ID_CLIENTE
)
SELECT C.NOMBRE_CLIENTE, VC.Total_Ventas
FROM Ventas_Clientes VC
INNER JOIN CLIENTE C ON VC.ID_CLIENTE = C.ID_CLIENTE;

-- Consulta con función de ventana (ROW_NUMBER) y filtrado:
SELECT V.ID_PEDIDO, V.FECHA, V.ID_CLIENTE, V.TOTAL,
       ROW_NUMBER() OVER(ORDER BY V.FECHA DESC) AS Numero_Fila
FROM VENTAS V
WHERE V.FECHA >= '2023-06-01';

-- Consulta con subconsulta correlacionada y función COUNT:
SELECT P.PRODUCTO,
       (SELECT COUNT(*) FROM VENTAS V WHERE V.ID_PRODUCTO = P.ID_PRODUCTO) AS Total_Ventas
FROM PRODUCTO P;

-- Consulta con función de ventana (DENSE_RANK) y partición:
SELECT V.ID_PEDIDO, V.FECHA, V.ID_CLIENTE, V.TOTAL,
       DENSE_RANK() OVER(ORDER BY V.TOTAL DESC) AS Ranking_Total_Ventas
FROM VENTAS V;



-- Consulta con subconsulta en la cláusula FROM y función SUM:
SELECT T1.Region, SUM(T1.Total_Ventas) AS Total_Ventas_Region
FROM (
    SELECT R.REGION, V.TOTAL AS Total_Ventas
    FROM VENTAS V
    INNER JOIN REGION R ON V.ID_REGION = R.ID_REGION
) AS T1
GROUP BY T1.Region;

-- Consulta con combinación de CASE WHEN y GROUP BY:
SELECT R.REGION,
       SUM(CASE WHEN V.TOTAL > 1000 THEN 1 ELSE 0 END) AS Ventas_Mayores_1000,
       AVG(V.TOTAL) AS Promedio_Total_Ventas
FROM VENTAS V
INNER JOIN REGION R ON V.ID_REGION = R.ID_REGION
GROUP BY R.REGION;

-- Consulta con función AVG y filtro por rango de fechas:
SELECT V.ID_VENDEDOR, AVG(V.TOTAL) AS Promedio_Ventas
FROM VENTAS V
WHERE V.FECHA BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY V.ID_VENDEDOR;

-- Consulta con subconsulta en la cláusula WHERE y ordenamiento:
SELECT C.NOMBRE_CLIENTE, V.FECHA, V.TOTAL
FROM VENTAS V
INNER JOIN CLIENTE C ON V.ID_CLIENTE = C.ID_CLIENTE
WHERE V.TOTAL = (SELECT MAX(TOTAL) FROM VENTAS WHERE ID_CLIENTE = V.ID_CLIENTE)
ORDER BY V.TOTAL DESC;

-- Consulta con función de ventana (LEAD) y partición:
SELECT V.ID_PEDIDO, V.FECHA, V.ID_CLIENTE, V.TOTAL,
       LEAD(V.TOTAL, 1, 0) OVER(PARTITION BY V.ID_CLIENTE ORDER BY V.FECHA) AS Siguiente_Total
FROM VENTAS V;

-- Consulta con JOIN y condición utilizando EXISTS:
SELECT C.NOMBRE_CLIENTE, V.FECHA, V.TOTAL
FROM VENTAS V
INNER JOIN CLIENTE C ON V.ID_CLIENTE = C.ID_CLIENTE
WHERE EXISTS (
    SELECT 1 FROM PRODUCTO P WHERE P.ID_PRODUCTO = V.ID_PRODUCTO AND P.STOCK <= 10
);

-- Consulta con combinación de funciones AVG y COUNT, y filtro HAVING:
SELECT V.ID_VENDEDOR, AVG(V.TOTAL) AS Promedio_Ventas, COUNT(*) AS Total_Ventas
FROM VENTAS V
GROUP BY V.ID_VENDEDOR
HAVING COUNT(*) >= 5;

select * from VENDEDOR
select * from FOTOS_VENDEDOR
select * from Genero

select vd.ID_VENDEDOR, vd.VENDEDOR,G.Genero, FV.foto_Vendedor_url
from vendedor vd
join genero g on vd.id_genero=g.ID_Genero 
join FOTOS_VENDEDOR fv on fv.ID_vendedor=vd.ID_VENDEDOR



-- Consulta 3: Mostrar el promedio de ventas diarias por región
SELECT R.REGION, AVG(V.TOTAL) AS PROMEDIO_VENTAS_DIARIAS
FROM VENTAS V
JOIN REGION R ON V.ID_REGION = R.ID_REGION
GROUP BY R.REGION;


-- Consulta 5: Obtener el detalle de ventas por cliente y producto, ordenado por fecha
SELECT C.NOMBRE_CLIENTE, C.APELLIDO_CLIENTE, P.PRODUCTO, V.FECHA, V.CANTIDAD, V.TOTAL
FROM VENTAS V
JOIN CLIENTE C ON V.ID_CLIENTE = C.ID_CLIENTE
JOIN PRODUCTO P ON V.ID_PRODUCTO = P.ID_PRODUCTO
ORDER BY V.FECHA DESC;


SELECT * FROM VENDEDOR
SELECT * FROM CLIENTE
SELECT * FROM VENTAS

SELECT * FROM VISTA_COMPLETA_VENTAS

-- Crear la vista completa de ventas con imágenes de productos y vendedores
CREATE OR ALTER VIEW  VISTA_COMPLETA_VENTAS AS
SELECT 
    V.ID_PEDIDO,
    V.FECHA,
    V.ID_CLIENTE,
    CONCAT(C.NOMBRE_CLIENTE, ' ', C.APELLIDO_CLIENTE) AS Cliente,
    V.ID_VENDEDOR,
    VD.VENDEDOR AS VENDEDOR,
    G.Genero AS Genero_Vendedor,
    VD.SUCURSAL AS Sucursal_Vendedor,
    P.nombreProvincia AS Provincia_Vendedor,
    P.latitud,
    P.longitud,
    R.REGION AS Region_Vendedor,
    V.ID_PRODUCTO,
    PR.PRODUCTO AS Nombre_Producto,
    PR.PRECIO_COMPRA,
    PR.PRECIO_VENTA,
    V.CANTIDAD,
    V.TOTAL AS INGRESO_TOTAL,
    FP.foto_Productos_url,
    FV.foto_Vendedor_url
FROM VENTAS V
INNER JOIN CLIENTE C ON V.ID_CLIENTE = C.ID_CLIENTE
INNER JOIN VENDEDOR VD ON V.ID_VENDEDOR = VD.ID_VENDEDOR
INNER JOIN Genero G ON VD.id_genero = G.ID_Genero
INNER JOIN PROVINCIAS P ON VD.PROVINCIA = P.id_provincia
INNER JOIN REGION R ON P.id_region = R.ID_REGION
INNER JOIN PRODUCTO PR ON V.ID_PRODUCTO = PR.ID_PRODUCTO
LEFT JOIN FOTO_PRODUCTOS FP ON PR.ID_PRODUCTO = FP.ID_PRODUCTO
LEFT JOIN FOTOS_VENDEDOR FV ON VD.ID_VENDEDOR = FV.ID_VENDEDOR;

--Hacer una Consulta  a la Vista:

SELECT * FROM VISTA_COMPLETA_VENTAS

--Calcular Ingreso Total, Cantidad Total, Costo Total y Margen Total:



SELECT 
    SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD) AS Ingreso_Total,
    SUM(VCV.CANTIDAD) AS Cantidad_Total,
    SUM(VCV.PRECIO_COMPRA * VCV.CANTIDAD) AS Costo_Total,
    SUM((VCV.PRECIO_VENTA - VCV.PRECIO_COMPRA) * VCV.CANTIDAD) AS Margen_Total,
    CASE 
        WHEN SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD) = 0 THEN 0
        ELSE SUM((VCV.PRECIO_VENTA - VCV.PRECIO_COMPRA) * VCV.CANTIDAD) / SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD)
    END AS Porcentaje_Margen
FROM VISTA_COMPLETA_VENTAS VCV;


SELECT 
    SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD) AS Ingreso_Total,
    SUM(VCV.CANTIDAD) AS Cantidad_Total,
    SUM(VCV.PRECIO_COMPRA * VCV.CANTIDAD) AS Costo_Total,
    SUM((VCV.PRECIO_VENTA - VCV.PRECIO_COMPRA) * VCV.CANTIDAD) AS Margen_Total,
    CASE 
        WHEN SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD) = 0 THEN 0
        ELSE SUM((VCV.PRECIO_VENTA - VCV.PRECIO_COMPRA) * VCV.CANTIDAD) / SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD)
    END AS Porcentaje_Margen
FROM VISTA_COMPLETA_VENTAS VCV;






--Ranking de Clientes:
WITH Rankings_Clientes AS (
    SELECT 
        VCV.ID_CLIENTE,VCV.Cliente,
        SUM(VCV.INGRESO_TOTAL) AS Ingreso_Total_Cliente,
        RANK() OVER (ORDER BY SUM(VCV.INGRESO_TOTAL) DESC) AS Ranking_Cliente
    FROM VISTA_COMPLETA_VENTAS VCV
    GROUP BY VCV.ID_CLIENTE,VCV.Cliente
)
SELECT *
FROM Rankings_Clientes;


--Ranking de Vendedores:
WITH Rankings_Vendedores AS (
    SELECT 
        VCV.ID_VENDEDOR,VCV.VENDEDOR,
        SUM(VCV.INGRESO_TOTAL) AS Ingreso_Total_Vendedor,
        RANK() OVER (ORDER BY SUM(VCV.INGRESO_TOTAL) DESC) AS Ranking_Vendedor
    FROM VISTA_COMPLETA_VENTAS VCV
    GROUP BY VCV.ID_VENDEDOR,VCV.VENDEDOR
)
SELECT *
FROM Rankings_Vendedores;

--Ranking de Productos:

WITH Rankings_Productos AS (
    SELECT 
        VCV.ID_PRODUCTO,VCV.Nombre_Producto AS Producto,
        SUM(VCV.INGRESO_TOTAL) AS Ingreso_Total_Producto,
        RANK() OVER (ORDER BY SUM(VCV.INGRESO_TOTAL) DESC) AS Ranking_Producto
    FROM VISTA_COMPLETA_VENTAS VCV
    GROUP BY VCV.ID_PRODUCTO, VCV.Nombre_Producto 
)
SELECT *
FROM Rankings_Productos;


/*

Explicación:

Ingreso Total, Cantidad Total, Costo Total y Margen Total: Estas consultas utilizan 
funciones de agregación (SUM) para calcular los totales necesarios directamente desde 
la vista VISTA_COMPLETA_VENTAS.

Ranking de Clientes: Se utiliza CONCAT para unir el nombre y apellido del cliente.
Luego se calcula el ingreso total y se asigna un ranking basado en ese valor, agrupando por ID_CLIENTE.

Ranking de Vendedores: Se une el nombre del vendedor desde la tabla VENDEDOR (VD.VENDEDOR)
y se calcula el ingreso total por vendedor, asignando un ranking correspondiente basado en ese criterio.

Ranking de Productos: Se utiliza el nombre del producto desde la tabla PRODUCTO (PR.PRODUCTO)
y se calcula el ingreso total por producto, asignando un ranking basado en el ingreso total acumulado.


*/

-- Vista de Ventas Detallada con Totales, Margen y Rankings

CREATE OR ALTER VIEW VISTA_COMPLETA_VENTAS_TOTAL_INGRESOS_MARGEN_COSTO_PORCENTAJE_MARGEN_RANKIN AS
SELECT 
    V.ID_PEDIDO,
    V.FECHA,
    V.ID_CLIENTE,
    CONCAT(C.NOMBRE_CLIENTE, ' ', C.APELLIDO_CLIENTE) AS Cliente,
    V.ID_VENDEDOR,
    VD.VENDEDOR AS VENDEDOR,
    G.Genero AS Genero_Vendedor,
    VD.SUCURSAL AS Sucursal_Vendedor,
    P.nombreProvincia AS Provincia_Vendedor,
    P.latitud,
    P.longitud,
    R.REGION AS Region_Vendedor,
    V.ID_PRODUCTO,
    PR.PRODUCTO AS Nombre_Producto,
    PR.PRECIO_COMPRA,
    PR.PRECIO_VENTA,
    V.CANTIDAD,
    SUM(V.TOTAL) AS INGRESO_TOTAL,
    SUM(V.CANTIDAD * PR.PRECIO_COMPRA) AS COSTO_TOTAL,
    SUM(V.CANTIDAD * (PR.PRECIO_VENTA - PR.PRECIO_COMPRA)) AS MARGEN_TOTAL,
    100 * SUM(V.CANTIDAD * (PR.PRECIO_VENTA - PR.PRECIO_COMPRA)) / NULLIF(SUM(V.TOTAL), 0) AS PORCENTAJE_MARGEN,
    RANK() OVER (PARTITION BY V.ID_CLIENTE ORDER BY SUM(V.TOTAL) DESC) AS RANKING_CLIENTE,
    RANK() OVER (PARTITION BY V.ID_VENDEDOR ORDER BY SUM(V.TOTAL) DESC) AS RANKING_VENDEDOR,
    RANK() OVER (PARTITION BY V.ID_PRODUCTO ORDER BY SUM(V.TOTAL) DESC) AS RANKING_PRODUCTO,
    FP.foto_Productos_url,
    FV.foto_Vendedor_url
FROM VENTAS V
INNER JOIN CLIENTE C ON V.ID_CLIENTE = C.ID_CLIENTE
INNER JOIN VENDEDOR VD ON V.ID_VENDEDOR = VD.ID_VENDEDOR
INNER JOIN Genero G ON VD.id_genero = G.ID_Genero
INNER JOIN PROVINCIAS P ON VD.PROVINCIA = P.id_provincia
INNER JOIN REGION R ON P.id_region = R.ID_REGION
INNER JOIN PRODUCTO PR ON V.ID_PRODUCTO = PR.ID_PRODUCTO
LEFT JOIN FOTO_PRODUCTOS FP ON PR.ID_PRODUCTO = FP.ID_PRODUCTO
LEFT JOIN FOTOS_VENDEDOR FV ON VD.ID_VENDEDOR = FV.ID_VENDEDOR
GROUP BY 
    V.ID_PEDIDO,
    V.FECHA,
    V.ID_CLIENTE,
    C.NOMBRE_CLIENTE,
    C.APELLIDO_CLIENTE,
    V.ID_VENDEDOR,
    VD.VENDEDOR,
    G.Genero,
    VD.SUCURSAL,
    P.nombreProvincia,
    P.latitud,
    P.longitud,
    R.REGION,
    V.ID_PRODUCTO,
    PR.PRODUCTO,
    PR.PRECIO_COMPRA,
    PR.PRECIO_VENTA,
    V.CANTIDAD,
    FP.foto_Productos_url,
    FV.foto_Vendedor_url;

SELECT * FROM VISTA_COMPLETA_VENTAS_TOTAL_INGRESOS_MARGEN_COSTO_PORCENTAJE_MARGEN_RANKIN





--VEAMOS ALGUNAS TABLAS:

SELECT * FROM VENTAS

SELECT * FROM PRODUCTO

-- Crear la vista completa de ventas con imágenes de productos y vendedores
CREATE OR ALTER VIEW  VISTA_COMPLETA_VENTAS AS
SELECT 
    V.ID_PEDIDO,
    V.FECHA,
    V.ID_CLIENTE,
    CONCAT(C.NOMBRE_CLIENTE, ' ', C.APELLIDO_CLIENTE) AS Cliente,
    V.ID_VENDEDOR,
    VD.VENDEDOR AS VENDEDOR,
    G.Genero AS Genero_Vendedor,
    VD.SUCURSAL AS Sucursal_Vendedor,
    P.nombreProvincia AS Provincia_Vendedor,
    P.latitud,
    P.longitud,
    R.REGION AS Region_Vendedor,
    V.ID_PRODUCTO,
    PR.PRODUCTO AS Nombre_Producto,
    PR.PRECIO_COMPRA,
    PR.PRECIO_VENTA,
    V.CANTIDAD,
    V.TOTAL AS INGRESO_TOTAL,
    FP.foto_Productos_url,
    FV.foto_Vendedor_url
FROM VENTAS V
INNER JOIN CLIENTE C ON V.ID_CLIENTE = C.ID_CLIENTE
INNER JOIN VENDEDOR VD ON V.ID_VENDEDOR = VD.ID_VENDEDOR
INNER JOIN Genero G ON VD.id_genero = G.ID_Genero
INNER JOIN PROVINCIAS P ON VD.PROVINCIA = P.id_provincia
INNER JOIN REGION R ON P.id_region = R.ID_REGION
INNER JOIN PRODUCTO PR ON V.ID_PRODUCTO = PR.ID_PRODUCTO
LEFT JOIN FOTO_PRODUCTOS FP ON PR.ID_PRODUCTO = FP.ID_PRODUCTO
LEFT JOIN FOTOS_VENDEDOR FV ON VD.ID_VENDEDOR = FV.ID_VENDEDOR;

--Hacer una Consulta  a la Vista:

SELECT * FROM VISTA_COMPLETA_VENTAS

SELECT 
    SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD) AS Ingreso_Total,
    SUM(VCV.CANTIDAD) AS Cantidad_Total,
    SUM(VCV.PRECIO_COMPRA * VCV.CANTIDAD) AS Costo_Total,
    SUM((VCV.PRECIO_VENTA - VCV.PRECIO_COMPRA) * VCV.CANTIDAD) AS Margen_Total,
    CASE 
        WHEN SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD) = 0 THEN 0
        ELSE SUM((VCV.PRECIO_VENTA - VCV.PRECIO_COMPRA) * VCV.CANTIDAD) / SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD)
    END AS Porcentaje_Margen
FROM VISTA_COMPLETA_VENTAS VCV;



SELECT 
    COUNT(*) AS Total_Registros,
    SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD) AS Ingreso_Total,
    SUM(VCV.CANTIDAD) AS Cantidad_Total,
    SUM(VCV.PRECIO_COMPRA * VCV.CANTIDAD) AS Costo_Total,
    SUM((VCV.PRECIO_VENTA - VCV.PRECIO_COMPRA) * VCV.CANTIDAD) AS Margen_Total,
    CASE 
        WHEN SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD) = 0 THEN 0
        ELSE SUM((VCV.PRECIO_VENTA - VCV.PRECIO_COMPRA) * VCV.CANTIDAD) / SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD)
    END AS Porcentaje_Margen
FROM VISTA_COMPLETA_VENTAS VCV;



SELECT 
    COUNT(*) AS Total_Registros,
    SUM(CASE WHEN YEAR(VCV.FECHA) = YEAR(GETDATE()) THEN VCV.PRECIO_VENTA * VCV.CANTIDAD ELSE 0 END) AS Venta_Ano_Actual,
    SUM(CASE WHEN YEAR(VCV.FECHA) = YEAR(GETDATE()) - 1 THEN VCV.PRECIO_VENTA * VCV.CANTIDAD ELSE 0 END) AS Venta_Ano_Anterior,
    SUM(CASE WHEN YEAR(VCV.FECHA) = YEAR(GETDATE()) THEN VCV.PRECIO_VENTA * VCV.CANTIDAD ELSE 0 END) -
    SUM(CASE WHEN YEAR(VCV.FECHA) = YEAR(GETDATE()) - 1 THEN VCV.PRECIO_VENTA * VCV.CANTIDAD ELSE 0 END) AS Diferencia,
    CASE 
        WHEN SUM(CASE WHEN YEAR(VCV.FECHA) = YEAR(GETDATE()) - 1 THEN VCV.PRECIO_VENTA * VCV.CANTIDAD ELSE 0 END) = 0 THEN NULL
        ELSE (SUM(CASE WHEN YEAR(VCV.FECHA) = YEAR(GETDATE()) THEN VCV.PRECIO_VENTA * VCV.CANTIDAD ELSE 0 END) -
              SUM(CASE WHEN YEAR(VCV.FECHA) = YEAR(GETDATE()) - 1 THEN VCV.PRECIO_VENTA * VCV.CANTIDAD ELSE 0 END)) * 100.0 /
              SUM(CASE WHEN YEAR(VCV.FECHA) = YEAR(GETDATE()) - 1 THEN VCV.PRECIO_VENTA * VCV.CANTIDAD ELSE 0 END)
    END AS Crecimiento_Porcentual,
    SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD) AS Ingreso_Total,
    SUM(VCV.CANTIDAD) AS Cantidad_Total,
    SUM(VCV.PRECIO_COMPRA * VCV.CANTIDAD) AS Costo_Total,
    SUM((VCV.PRECIO_VENTA - VCV.PRECIO_COMPRA) * VCV.CANTIDAD) AS Margen_Total,
    CASE 
        WHEN SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD) = 0 THEN 0
        ELSE SUM((VCV.PRECIO_VENTA - VCV.PRECIO_COMPRA) * VCV.CANTIDAD) / SUM(VCV.PRECIO_VENTA * VCV.CANTIDAD)
    END AS Porcentaje_Margen
FROM 
    VISTA_COMPLETA_VENTAS VCV;
