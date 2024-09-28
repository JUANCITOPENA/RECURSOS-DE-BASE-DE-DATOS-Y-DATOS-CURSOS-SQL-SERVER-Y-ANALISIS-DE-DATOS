-- Creación de la base de datos
CREATE DATABASE TiendaVehiculos;
GO

-- Usar la base de datos
USE TiendaVehiculos;
GO

-- Crear la tabla Categorias
CREATE TABLE Categorias (
    CategoriaID INT PRIMARY KEY IDENTITY(1,1),
    NombreCategoria NVARCHAR(50) NOT NULL
);
GO

-- Crear la tabla Productos
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    NombreProducto NVARCHAR(100) NOT NULL,
    CategoriaID INT,
    Precio DECIMAL(10, 2),
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);
GO

-- Agregar la columna Stock a la tabla Productos
ALTER TABLE Productos
ADD Stock INT NOT NULL DEFAULT 0;
GO

UPDATE Productos  SET Stock = 5000

SELECT * FROM Productos

-- Crear la tabla Imagenes
CREATE TABLE Imagenes (
    ImagenID INT PRIMARY KEY IDENTITY(1,1),
    ProductoID INT,
    URL NVARCHAR(255),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);
GO

-- Crear la tabla de dimensión para Vendedores
CREATE TABLE Vendedores (
    VendedorID INT PRIMARY KEY IDENTITY(1,1),
    NombreVendedor NVARCHAR(100),
    Pais NVARCHAR(100)
);
GO

-- Crear la tabla de dimensión para Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    NombreCliente NVARCHAR(100),
    Pais NVARCHAR(100)
);
GO

-- Crear la tabla de dimensión para Ubicaciones
CREATE TABLE Ubicaciones (
    UbicacionID INT PRIMARY KEY IDENTITY(1,1),
    Ciudad NVARCHAR(100),
    Pais NVARCHAR(100)
);
GO

-- Crear la tabla de hechos para Ventas
CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY IDENTITY(1,1),
    Fecha DATE,
    ProductoID INT,
    VendedorID INT,
    ClienteID INT,
    UbicacionID INT,
    Cantidad INT,
    MontoTotal DECIMAL(10, 2), -- MontoTotal se actualizará con un trigger
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID),
    FOREIGN KEY (VendedorID) REFERENCES Vendedores(VendedorID),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (UbicacionID) REFERENCES Ubicaciones(UbicacionID)
);
GO

-- Crear un trigger para actualizar MontoTotal después de insertar o actualizar una fila en la tabla Ventas
CREATE TRIGGER trg_AfterInsertUpdateVentas
ON Ventas
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Ventas
    SET MontoTotal = i.Cantidad * p.Precio
    FROM inserted i
    JOIN Productos p ON i.ProductoID = p.ProductoID
    WHERE Ventas.VentaID = i.VentaID;
END;
GO

-- Insertar datos en la tabla Categorias
INSERT INTO Categorias (NombreCategoria)
VALUES 
('Motor'),
('Transmisión'),
('Frenos'),
('Suspensión'),
('Electrónica'),
('Carrocería'),
('Escape'),
('Interior'),
('Ruedas'),
('Accesorios');
GO


-- Insertar 25 productos de piezas de vehículos en la tabla Productos
INSERT INTO Productos (NombreProducto, CategoriaID, Precio_Compra, Precio_Venta, Stock)
VALUES 
    -- Primer conjunto de productos con descuentos
    ('Alternador', 1, 95.00, 85.50, 1000),  -- 10% descuento
    ('Freno de Mano', 2, 25.00, 21.25, 1000),  -- 15% descuento
    ('Radiador', 3, 180.00, 158.40, 1000),  -- 12% descuento
    ('Espejo Retrovisor', 4, 50.00, 40.00, 1000),  -- 20% descuento
    ('Filtro de Aire', 5, 20.00, 15.00, 1000),  -- 25% descuento
    ('Embrague', 6, 120.00, 98.40, 1000),  -- 18% descuento
    ('Correa de Distribución', 7, 30.00, 23.40, 1000),  -- 22% descuento
    ('Bomba de Agua', 8, 70.00, 59.50, 1000),  -- 15% descuento
    ('Juego de Pastillas de Freno', 9, 40.00, 32.00, 1000),  -- 20% descuento
    ('Aros de Buje', 10, 55.00, 49.50, 1000),  -- 10% descuento
    ('Cárter de Aceite', 1, 60.00, 52.80, 1000),  -- 12% descuento
    ('Manguera de Radiador', 2, 35.00, 29.75, 1000),  -- 15% descuento
    ('Tirantes de Suspensión', 3, 70.00, 56.00, 1000),  -- 20% descuento
    ('Bombilla de Faros', 4, 25.00, 22.50, 1000),  -- 10% descuento
    ('Termostato', 5, 40.00, 32.80, 1000),  -- 18% descuento
    ('Bujía de Encendido', 1, 10.00, 15.00, 1000),
    ('Filtro de Aceite', 1, 7.50, 10.00, 1000),
    ('Disco de Freno', 3, 30.00, 45.00, 1000),
    ('Amortiguador', 4, 60.00, 80.00, 1000),
    ('Batería de Coche', 5, 90.00, 120.00, 1000),
    ('Capó', 6, 150.00, 200.00, 1000),
    ('Silenciador', 7, 35.00, 50.00, 1000),
    ('Asiento de Cuero', 8, 180.00, 250.00, 1000),
    ('Llantas', 9, 75.00, 100.00, 1000),
    ('Portaequipajes', 10, 55.00, 75.00, 1000);
GO



--===========================================================================================
--TAREA DE USTEDES BUSCAR E INSERTAR LAS IMAGENES DE CADA PRODCUTO CON FORMATO TRANSPARENTE
--===========================================================================================

-- Insertar datos en la tabla Imagenes para los productos
INSERT INTO Imagenes (ProductoID, URL)
VALUES 
    -- Primer conjunto de productos
    (1, 'https://example.com/imagenes/alternador.png'),
    (2, 'https://example.com/imagenes/freno_mano.png'),
    (3, 'https://example.com/imagenes/radiador.png'),
    (4, 'https://example.com/imagenes/espejo_retrovisor.png'),
    (5, 'https://example.com/imagenes/filtro_aire.png'),
    (6, 'https://example.com/imagenes/embrague.png'),
    (7, 'https://example.com/imagenes/correa_distribucion.png'),
    (8, 'https://example.com/imagenes/bomba_agua.png'),
    (9, 'https://example.com/imagenes/juego_pastillas_freno.png'),
    (10, 'https://example.com/imagenes/aros_buje.png'),
    (11, 'https://example.com/imagenes/carter_aceite.png'),
    (12, 'https://example.com/imagenes/manguera_radiador.png'),
    (13, 'https://example.com/imagenes/tirantes_suspension.png'),
    (14, 'https://example.com/imagenes/bombilla_faros.png'),
    (15, 'https://example.com/imagenes/termostato.png'),
    (16, 'https://example.com/imagenes/bujia_encendido.png'),
    (17, 'https://example.com/imagenes/filtro_aceite.png'),
    (18, 'https://example.com/imagenes/disco_freno.png'),
    (19, 'https://example.com/imagenes/amortiguador.png'),
    (20, 'https://example.com/imagenes/bateria_coche.png'),
    (21, 'https://example.com/imagenes/capo.png'),
    (22, 'https://example.com/imagenes/silenciador.png'),
    (23, 'https://example.com/imagenes/asiento_cuero.png'),
    (24, 'https://example.com/imagenes/llantas.png'),
    (25, 'https://example.com/imagenes/portaequipajes.png');
GO



-- Insertar datos en la tabla Vendedores
INSERT INTO Vendedores (NombreVendedor, Pais)
VALUES 
('Juan Pérez', 'México'),
('María López', 'España'),
('Carlos García', 'Argentina'),
('Ana Martínez', 'Chile'),
('Luis Fernández', 'Colombia'),
('Lucía Gómez', 'Perú'),
('Miguel Torres', 'Ecuador'),
('Sofía Sánchez', 'Uruguay'),
('Jorge Díaz', 'Paraguay'),
('Elena Ramírez', 'Bolivia'),
('Pedro Morales', 'Venezuela'),
('Laura Ortega', 'El Salvador'),
('Roberto López', 'Guatemala'),
('Jessica Martínez', 'Nicaragua'),
('Andrés Rodríguez', 'Costa Rica'),
('Alejandra Silva', 'Panamá'),
('David Gómez', 'Cuba'),
('Carolina López', 'República Dominicana'),
('Daniel Fernández', 'Puerto Rico'),
('Natalia Torres', 'Honduras');
GO

-- Insertar más datos en la tabla Clientes
INSERT INTO Clientes (NombreCliente, Pais)
VALUES 
('Pedro González', 'México'),
('Laura Rodríguez', 'España'),
('Francisco Romero', 'Argentina'),
('Patricia Morales', 'Chile'),
('Javier Ortega', 'Colombia'),
('Marta Vázquez', 'Perú'),
('Fernando Castillo', 'Ecuador'),
('Adriana Núñez', 'Uruguay'),
('Ricardo Herrera', 'Paraguay'),
('Carmen Jiménez', 'Bolivia'),
('Gabriel Soto', 'México'),
('Silvia Martínez', 'España'),
('Luis Fernández', 'Argentina'),
('Valeria Gómez', 'Chile'),
('Oscar Ruiz', 'Colombia'),
('Claudia López', 'Perú'),
('Andrés Morales', 'Ecuador'),
('Verónica Castro', 'Uruguay'),
('Manuel Díaz', 'Paraguay'),
('Paola Rivas', 'Bolivia'),
('Alejandro López', 'México'),
('Elena Morales', 'España'),
('Santiago Pérez', 'Argentina'),
('Natalia Ramírez', 'Chile'),
('Eduardo Vargas', 'Colombia'),
('Marcela Gómez', 'Perú'),
('Ricardo Silva', 'Ecuador'),
('Julia Cordero', 'Uruguay'),
('Daniela Mendoza', 'Paraguay'),
('Victor Hugo', 'Bolivia'),
('Sofía Rivera', 'México'),
('Luis Felipe', 'España'),
('Carlos Mora', 'Argentina'),
('Mariana Delgado', 'Chile'),
('Juan Pablo', 'Colombia'),
('Sonia Martínez', 'Perú'),
('Diego Vargas', 'Ecuador'),
('Karla Méndez', 'Uruguay'),
('José Luis', 'Paraguay'),
('Nina Rodríguez', 'Bolivia'),
('Rafael López', 'México'),
('Andrea Fernández', 'España'),
('Miguel Ángel', 'Argentina'),
('Sandra Gómez', 'Chile'),
('Julian Peña', 'Colombia'),
('Gabriela Muñoz', 'Perú'),
('Héctor Pérez', 'Ecuador'),
('Nerea González', 'Uruguay'),
('Andrés Pérez', 'Paraguay'),
('Lina María', 'Bolivia'),
('Ricardo Fernández', 'México');
GO


-- Insertar datos en la tabla Ubicaciones
INSERT INTO Ubicaciones (Ciudad, Pais)
VALUES 
('Ciudad de México', 'México'),
('Madrid', 'España'),
('Buenos Aires', 'Argentina'),
('Santiago', 'Chile'),
('Bogotá', 'Colombia'),
('Lima', 'Perú'),
('Quito', 'Ecuador'),
('Montevideo', 'Uruguay'),
('Asunción', 'Paraguay'),
('La Paz', 'Bolivia'),
('Caracas', 'Venezuela'),
('San Salvador', 'El Salvador'),
('Guatemala City', 'Guatemala'),
('Managua', 'Nicaragua'),
('Honduras', 'Tegucigalpa'),
('San José', 'Costa Rica'),
('Panamá City', 'Panamá'),
('Havana', 'Cuba'),
('Santo Domingo', 'República Dominicana'),
('Hato Rey', 'Puerto Rico');
GO

-- Insertar datos en la tabla Ventas (ejemplo de 30 registros)
INSERT INTO Ventas (Fecha, ProductoID, VendedorID, ClienteID, UbicacionID, Cantidad, MontoTotal)
VALUES 
('2023-01-01', 1, 1, 1, 1, 2, 0),
('2023-01-02', 2, 2, 2, 2, 3, 0),
('2023-01-03', 3, 3, 3, 3, 1, 0),
('2023-01-04', 4, 4, 4, 4, 2, 0),
('2023-01-05', 5, 5, 5, 5, 3, 0),
('2023-01-06', 6, 6, 6, 6, 4, 0),
('2023-01-07', 7, 7, 7, 7, 5, 0),
('2023-01-08', 8, 8, 8, 8, 1, 0),
('2023-01-09', 9, 9, 9, 9, 2, 0),
('2023-01-10', 10, 10, 10, 10, 3, 0),
('2023-01-11', 1, 1, 1, 1, 1, 0),
('2023-01-12', 2, 2, 2, 2, 2, 0),
('2023-01-13', 3, 3, 3, 3, 3, 0),
('2023-01-14', 4, 4, 4, 4, 4, 0),
('2023-01-15', 5, 5, 5, 5, 5, 0),
('2023-01-16', 6, 6, 6, 6, 1, 0),
('2023-01-17', 7, 7, 7, 7, 2, 0),
('2023-01-18', 8, 8, 8, 8, 3, 0),
('2023-01-19', 9, 9, 9, 9, 4, 0),
('2023-01-20', 10, 10, 10, 10, 5, 0),
('2023-01-21', 1, 1, 1, 1, 3, 0),
('2023-01-22', 2, 2, 2, 2, 4, 0),
('2023-01-23', 3, 3, 3, 3, 5, 0),
('2023-01-24', 4, 4, 4, 4, 1, 0),
('2023-01-25', 5, 5, 5, 5, 2, 0),
('2023-01-26', 6, 6, 6, 6, 3, 0),
('2023-01-27', 7, 7, 7, 7, 4, 0),
('2023-01-28', 8, 8, 8, 8, 5, 0),
('2023-01-29', 9, 9, 9, 9, 1, 0),
('2023-01-30', 10, 10, 10, 10, 1, 0);
GO



-- Crear un trigger para actualizar el stock después de una venta
CREATE OR ALTER TRIGGER trgActualizarStock
ON Ventas
AFTER INSERT
AS
BEGIN
    -- Actualizar el stock de los productos en la tabla Productos
    UPDATE Productos
    SET Stock = Stock - i.Cantidad
    FROM Productos p
    INNER JOIN inserted i ON p.ProductoID = i.ProductoID;
END;
GO



-- Procedimiento almacenado para generar registros de ventas
CREATE OR ALTER  PROCEDURE GenerarVentas
    @FechaInicio DATE,
    @FechaFin DATE,
    @Cantidad INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Fecha DATE;
    DECLARE @ProductoID INT;
    DECLARE @VendedorID INT;
    DECLARE @ClienteID INT;
    DECLARE @UbicacionID INT;
    DECLARE @CantidadVenta INT;
    DECLARE @i INT = 0;

    WHILE @i < @Cantidad
    BEGIN
        -- Generar una fecha aleatoria entre FechaInicio y FechaFin
        SET @Fecha = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % (DATEDIFF(DAY, @FechaInicio, @FechaFin) + 1)), @FechaInicio);

        -- Seleccionar ProductoID aleatorio
        SET @ProductoID = (SELECT TOP 1 ProductoID FROM Productos ORDER BY NEWID());

        -- Seleccionar VendedorID aleatorio
        SET @VendedorID = (SELECT TOP 1 VendedorID FROM Vendedores ORDER BY NEWID());

        -- Seleccionar ClienteID aleatorio
        SET @ClienteID = (SELECT TOP 1 ClienteID FROM Clientes ORDER BY NEWID());

        -- Seleccionar UbicacionID aleatorio
        SET @UbicacionID = (SELECT TOP 1 UbicacionID FROM Ubicaciones ORDER BY NEWID());

        -- Generar una cantidad aleatoria de venta
        SET @CantidadVenta = ABS(CHECKSUM(NEWID()) % 10) + 1;

        -- Insertar la venta en la tabla de hechos
        INSERT INTO Ventas (Fecha, ProductoID, VendedorID, ClienteID, UbicacionID, Cantidad, MontoTotal)
        VALUES (@Fecha, @ProductoID, @VendedorID, @ClienteID, @UbicacionID, @CantidadVenta, 0);

        SET @i = @i + 1;
    END
END;
GO

-- Ejecutar el procedimiento almacenado para generar ventas
EXEC GenerarVentas '2020-02-01', '2024-08-13', 10000;
GO


-- Crear vistas para análisis de ventas

-- Vista de detalles de ventas por cliente y producto
CREATE VIEW DetallesVentasClienteProducto AS
SELECT c.NombreCliente, p.NombreProducto, v.Cantidad, v.MontoTotal
FROM Ventas v
INNER JOIN Clientes c ON v.ClienteID = c.ClienteID
INNER JOIN Productos p ON v.ProductoID = p.ProductoID;
GO

-- Seleccionar todos los registros de la vista DetallesVentasClienteProducto
SELECT * FROM DetallesVentasClienteProducto;
GO

-- Vista de ventas totales por país
CREATE OR ALTER VIEW VentasTotalesPorPais AS
SELECT u.Pais, SUM(v.MontoTotal) AS TotalVentas
FROM Ventas v
INNER JOIN Ubicaciones u ON v.UbicacionID = u.UbicacionID
GROUP BY u.Pais;
GO

-- Seleccionar todos los registros de la vista VentasTotalesPorPais
SELECT * FROM VentasTotalesPorPais;
GO

-- Vista que combina todas las tablas de nuestro esquema de modelo estrella
CREATE OR ALTER VIEW DetallesCompletosVentas AS
SELECT v.VentaID, v.Fecha, u.Ciudad, u.Pais, c.NombreCliente, ven.NombreVendedor, p.NombreProducto, v.Cantidad,
v.MontoTotal * 59.75 AS MontoTotalEnDOP
FROM Ventas v
INNER JOIN Clientes c ON v.ClienteID = c.ClienteID
INNER JOIN Vendedores ven ON v.VendedorID = ven.VendedorID
INNER JOIN Productos p ON v.ProductoID = p.ProductoID
INNER JOIN Ubicaciones u ON v.UbicacionID = u.UbicacionID;
GO

-- Seleccionar todos los registros de la vista DetallesCompletosVentas
SELECT * FROM DetallesCompletosVentas;
GO

-- Consultas tipo preguntas y test para negocio de operaciones

-- SELECT
SELECT * FROM Productos;

-- INSERT
INSERT INTO Productos (NombreProducto, CategoriaID, Precio) VALUES ('Tablet', 1, 300.00);

-- UPDATE
UPDATE Productos SET Precio = 350.00 WHERE NombreProducto = 'Tablet';

-- DELETE
DELETE FROM Productos WHERE NombreProducto = 'Tablet';

-- WHERE
SELECT * FROM Ventas WHERE Cantidad > 2;

-- ORDER BY
SELECT * FROM Productos ORDER BY Precio DESC;

-- GROUP BY
SELECT CategoriaID, COUNT(*) AS NumeroProductos FROM Productos GROUP BY CategoriaID;

-- HAVING
SELECT CategoriaID, AVG(Precio) AS PrecioMedio FROM Productos GROUP BY CategoriaID HAVING AVG(Precio) > 100;

-- INNER JOIN
SELECT v.VentaID, c.NombreCliente, p.NombreProducto FROM Ventas v
INNER JOIN Clientes c ON v.ClienteID = c.ClienteID
INNER JOIN Productos p ON v.ProductoID = p.ProductoID;

-- LEFT JOIN
SELECT c.NombreCliente, v.VentaID FROM Clientes c
LEFT JOIN Ventas v ON c.ClienteID = v.ClienteID;

-- RIGHT JOIN
SELECT c.NombreCliente, v.VentaID FROM Clientes c
RIGHT JOIN Ventas v ON c.ClienteID = v.ClienteID;

-- FULL JOIN
SELECT c.NombreCliente, v.VentaID FROM Clientes c
FULL JOIN Ventas v ON c.ClienteID = v.ClienteID;

-- UNION
SELECT NombreCliente AS Nombre FROM Clientes
UNION
SELECT NombreVendedor AS Nombre FROM Vendedores;

-- UNION ALL
SELECT NombreCliente AS Nombre FROM Clientes
UNION ALL
SELECT NombreVendedor AS Nombre FROM Vendedores;

-- SUBQUERIES
SELECT * FROM Productos WHERE Precio > (SELECT AVG(Precio) FROM Productos);

-- EXISTS
SELECT * FROM Clientes WHERE EXISTS (SELECT * FROM Ventas WHERE Clientes.ClienteID = Ventas.ClienteID);

-- CASE
SELECT NombreProducto, Precio, 
    CASE 
        WHEN Precio > 500 THEN 'Caro'
        WHEN Precio BETWEEN 100 AND 500 THEN 'Moderado'
        ELSE 'Barato'
    END AS CategoriaPrecio
FROM Productos;

-- WITH (CTE)
WITH VentasPorCliente AS (
    SELECT ClienteID, SUM(MontoTotal) AS TotalGastado FROM Ventas GROUP BY ClienteID
)
SELECT c.NombreCliente, v.TotalGastado FROM Clientes c
INNER JOIN VentasPorCliente v ON c.ClienteID = v.ClienteID;

-- DISTINCT
SELECT DISTINCT Pais FROM Ubicaciones;

-- TOP (LIMIT en otros SGBD)
SELECT TOP 5 * FROM Productos ORDER BY Precio DESC;


-- CREACION DE VISTA PARA CREAR DASHBOARD: RECIRDAR AGREGAR LOS CAMPOS DE LA TABLA IMAGENES QUE DEBEN BUSCAR LA URL.

CREATE OR ALTER VIEW DetallesCompletosVentas AS
SELECT v.VentaID, v.Fecha, u.Ciudad, u.Pais, c.NombreCliente, ven.NombreVendedor, p.NombreProducto, v.Cantidad,
v.MontoTotal * 59.75 AS MontoTotalEnDOP
FROM Ventas v
INNER JOIN Clientes c ON v.ClienteID = c.ClienteID
INNER JOIN Vendedores ven ON v.VendedorID = ven.VendedorID
INNER JOIN Productos p ON v.ProductoID = p.ProductoID
INNER JOIN Ubicaciones u ON v.UbicacionID = u.UbicacionID;
GO
