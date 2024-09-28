-- Creaci�n de la base de datos
CREATE DATABASE JOYERIASTORE;
GO

-- Usar la base de datos
USE JOYERIASTORE;
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


-- Crear la tabla Imagenes
CREATE TABLE Imagenes (
    ImagenID INT PRIMARY KEY IDENTITY(1,1),
    ProductoID INT,
    URL NVARCHAR(255),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);
GO

-- Crear la tabla de dimensi�n para Vendedores
CREATE TABLE Vendedores (
    VendedorID INT PRIMARY KEY IDENTITY(1,1),
    NombreVendedor NVARCHAR(100),
    Pais NVARCHAR(100)
);
GO

-- Crear la tabla de dimensi�n para Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    NombreCliente NVARCHAR(100),
    Pais NVARCHAR(100)
);
GO

-- Crear la tabla de dimensi�n para Ubicaciones
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
    MontoTotal DECIMAL(10, 2), -- MontoTotal se actualizar� con un trigger
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID),
    FOREIGN KEY (VendedorID) REFERENCES Vendedores(VendedorID),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (UbicacionID) REFERENCES Ubicaciones(UbicacionID)
);
GO

-- Crear un trigger para actualizar MontoTotal despu�s de insertar o actualizar una fila en la tabla Ventas
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
('Anillos'),
('Collares'),
('Pulseras'),
('Pendientes'),
('Relojes'),
('Broches'),
('Alianzas'),
('Dijes'),
('Charms'),
('Joyer�a Infantil');
GO


-- Insertar datos en la tabla Productos
INSERT INTO Productos (NombreProducto, CategoriaID, Precio)
VALUES 
('Anillo de Oro - Cartier', 1, 500.00),
('Anillo de Plata - Tiffany', 1, 150.00),
('Collar de Perlas - Mikimoto', 2, 800.00),
('Collar de Diamantes - Harry Winston', 2, 2000.00),
('Pulsera de Oro - Pandora', 3, 300.00),
('Pulsera de Plata - Swarovski', 3, 120.00),
('Pendientes de Oro - Bvlgari', 4, 450.00),
('Pendientes de Plata - Tiffany', 4, 100.00),
('Reloj de Oro - Rolex', 5, 10000.00),
('Reloj de Plata - Omega', 5, 5000.00),
('Broche de Oro - Van Cleef & Arpels', 6, 600.00),
('Broche de Plata - David Yurman', 6, 200.00),
('Alianza de Oro - Cartier', 7, 700.00),
('Alianza de Plata - Tiffany', 7, 250.00),
('Dije de Oro - Piaget', 8, 350.00),
('Dije de Plata - Chopard', 8, 150.00),
('Charm de Oro - Pandora', 9, 200.00),
('Charm de Plata - Swarovski', 9, 80.00),
('Joyer�a Infantil - Pulsera de Oro - Tiffany', 10, 300.00),
('Joyer�a Infantil - Pendientes de Plata - Swarovski', 10, 100.00),
('Joyer�a Infantil - Anillo de Oro - Pandora', 10, 250.00),
('Joyer�a Infantil - Collar de Plata - Tiffany', 10, 150.00),
('Joyer�a Infantil - Dije de Oro - Chopard', 10, 200.00),
('Joyer�a Infantil - Charm de Plata - Swarovski', 10, 50.00),
('Pendientes de Diamantes - Harry Winston', 4, 3000.00);
GO


SELECT * FROM Productos


--===========================================================================================
--TAREA DE USTEDES BUSCAR E INSERTAR LAS IMAGENES DE CADA PRODCUTO CON FORMATO TRANSPARENTE
--===========================================================================================

-- Insertar datos en la tabla Imagenes
INSERT INTO Imagenes (ProductoID, URL)
VALUES 
(1, 'https://int.cartier.com/content/dam/rcq/car/58/71/74/587174.png'),
(2, 'https://anillosdecompromisoac.com/wp-content/uploads/2023/08/anillo-compromiso-tiffany-2.png'),
(3, 'https://example.com/imagenes/collar_perlas_mikimoto.jpg'),
(4, 'https://example.com/imagenes/collar_diamantes_harry_winston.jpg'),
(5, 'https://example.com/imagenes/pulsera_oro_pandora.jpg'),
(6, 'https://example.com/imagenes/pulsera_plata_swarovski.jpg'),
(7, 'https://example.com/imagenes/pendientes_oro_bvlgari.jpg'),
(8, 'https://example.com/imagenes/pendientes_plata_tiffany.jpg'),
(9, 'https://example.com/imagenes/reloj_oro_rolex.jpg'),
(10, 'https://example.com/imagenes/reloj_plata_omega.jpg'),
(11, 'https://example.com/imagenes/broche_oro_van_cleef_arpels.jpg'),
(12, 'https://example.com/imagenes/broche_plata_david_yurman.jpg'),
(13, 'https://example.com/imagenes/alianza_oro_cartier.jpg'),
(14, 'https://example.com/imagenes/alianza_plata_tiffany.jpg'),
(15, 'https://example.com/imagenes/dije_oro_piaget.jpg'),
(16, 'https://example.com/imagenes/dije_plata_chopard.jpg'),
(17, 'https://example.com/imagenes/charm_oro_pandora.jpg'),
(18, 'https://example.com/imagenes/charm_plata_swarovski.jpg'),
(19, 'https://example.com/imagenes/joyeria_infantil_pulsera_oro_tiffany.jpg'),
(20, 'https://example.com/imagenes/joyeria_infantil_pendientes_plata_swarovski.jpg'),
(21, 'https://example.com/imagenes/joyeria_infantil_anillo_oro_pandora.jpg'),
(22, 'https://example.com/imagenes/joyeria_infantil_collar_plata_tiffany.jpg'),
(23, 'https://example.com/imagenes/joyeria_infantil_dije_oro_chopard.jpg'),
(24, 'https://example.com/imagenes/joyeria_infantil_charm_plata_swarovski.jpg'),
(25, 'https://example.com/imagenes/pendientes_diamantes_harry_winston.jpg');
GO


-- Insertar datos en la tabla Vendedores
INSERT INTO Vendedores (NombreVendedor, Pais)
VALUES 
('Juan P�rez', 'M�xico'),
('Mar�a L�pez', 'Espa�a'),
('Carlos Garc�a', 'Argentina'),
('Ana Mart�nez', 'Chile'),
('Luis Fern�ndez', 'Colombia'),
('Luc�a G�mez', 'Per�'),
('Miguel Torres', 'Ecuador'),
('Sof�a S�nchez', 'Uruguay'),
('Jorge D�az', 'Paraguay'),
('Elena Ram�rez', 'Bolivia');
GO

-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (NombreCliente, Pais)
VALUES 
('Pedro Gonz�lez', 'M�xico'),
('Laura Rodr�guez', 'Espa�a'),
('Francisco Romero', 'Argentina'),
('Patricia Morales', 'Chile'),
('Javier Ortega', 'Colombia'),
('Marta V�zquez', 'Per�'),
('Fernando Castillo', 'Ecuador'),
('Adriana N��ez', 'Uruguay'),
('Ricardo Herrera', 'Paraguay'),
('Carmen Jim�nez', 'Bolivia');
GO

-- Insertar datos en la tabla Ubicaciones
INSERT INTO Ubicaciones (Ciudad, Pais)
VALUES 
('Ciudad de M�xico', 'M�xico'),
('Madrid', 'Espa�a'),
('Buenos Aires', 'Argentina'),
('Santiago', 'Chile'),
('Bogot�', 'Colombia'),
('Lima', 'Per�'),
('Quito', 'Ecuador'),
('Montevideo', 'Uruguay'),
('Asunci�n', 'Paraguay'),
('La Paz', 'Bolivia');
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

--Seleccionar la Tabla :

select * from Ventas;



-- Procedimiento almacenado para generar registros de ventas
CREATE PROCEDURE GenerarVentas
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
EXEC GenerarVentas '2020-02-01', '2024-07-30', 15000;
GO

select * from Ventas

-- Crear vistas para an�lisis de ventas

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

-- Vista de ventas totales por pa�s
CREATE VIEW VentasTotalesPorPais AS
SELECT u.Pais, SUM(v.MontoTotal) AS TotalVentas
FROM Ventas v
INNER JOIN Ubicaciones u ON v.UbicacionID = u.UbicacionID
GROUP BY u.Pais;
GO

-- Seleccionar todos los registros de la vista VentasTotalesPorPais
SELECT * FROM VentasTotalesPorPais;
GO

-- Vista que combina todas las tablas de nuestro esquema de modelo estrella
CREATE VIEW DetallesCompletosVentas_imagenes AS
SELECT v.VentaID, v.Fecha, c.NombreCliente, ven.NombreVendedor, p.NombreProducto, v.Cantidad,
v.MontoTotal, u.Ciudad, u.Pais, i.URL
FROM Ventas v
INNER JOIN Clientes c ON v.ClienteID = c.ClienteID
INNER JOIN Vendedores ven ON v.VendedorID = ven.VendedorID
INNER JOIN Productos p ON v.ProductoID = p.ProductoID
INNER JOIN Ubicaciones u ON v.UbicacionID = u.UbicacionID
INNER JOIN Imagenes I ON P.ProductoID = I.ProductoID;
GO


CREATE OR ALTER VIEW DetallesCompletosVentas_imagenes AS
SELECT 
    v.VentaID, 
    v.Fecha, 
    c.NombreCliente, 
    ven.NombreVendedor, 
    p.NombreProducto, 
    v.Cantidad, 
    v.MontoTotal * 57.57 AS MontoTotalEnDOP,  -- Multiplicando por el valor constante del d�lar
    u.Ciudad, 
    u.Pais, 
    i.URL
FROM 
    Ventas v
INNER JOIN 
    Clientes c ON v.ClienteID = c.ClienteID
INNER JOIN 
    Vendedores ven ON v.VendedorID = ven.VendedorID
INNER JOIN 
    Productos p ON v.ProductoID = p.ProductoID
INNER JOIN 
    Ubicaciones u ON v.UbicacionID = u.UbicacionID
INNER JOIN 
    Imagenes i ON p.ProductoID = i.ProductoID;
GO


-- Seleccionar todos los registros de la vista DetallesCompletosVentas
SELECT * FROM DetallesCompletosVentas_imagenes;
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