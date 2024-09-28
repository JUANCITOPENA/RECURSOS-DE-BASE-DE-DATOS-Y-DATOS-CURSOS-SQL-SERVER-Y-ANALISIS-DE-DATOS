-- Creación de la base de datos
CREATE DATABASE FERRETERIA_FERRA;
GO

-- Usar la base de datos
USE FERRETERIA_FERRA;
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
('Herramientas de Mano'),
('Herramientas Eléctricas'),
('Materiales de Construcción'),
('Ferretería de Jardín'),
('Pinturas y Barnices'),
('Electricidad'),
('Fontanería'),
('Seguridad'),
('Accesorios de Carpintería'),
('Suministros de Taller'),
('Equipo de Protección Personal'),
('Adhesivos y Selladores'),
('Iluminación'),
('Clavos y Tornillos'),
('Equipo de Medición'),
('Artículos para Automóviles'),
('Artículos de Mantenimiento'),
('Productos de Limpieza'),
('Organización y Almacenaje'),
('Sistemas de Fijación');
GO

-- Insertar datos en la tabla Productos
INSERT INTO Productos (NombreProducto, CategoriaID, Precio)
VALUES 
('Martillo de Acero - Stanley', 1, 25.00),
('Destornillador de Precisión - Bosch', 1, 15.00),
('Taladro Inalámbrico - DeWalt', 2, 120.00),
('Sierra Circular - Makita', 2, 200.00),
('Cemento Portland - Holcim', 3, 10.00),
('Ladrillos - Ladrillos del Sur', 3, 0.50),
('Tijeras de Jardín - Fiskars', 4, 30.00),
('Fungicida para Plantas - Bayer', 4, 12.00),
('Pintura Acrílica - PPG', 5, 45.00),
('Barniz para Madera - Sikkens', 5, 35.00),
('Cable Eléctrico - Nexans', 6, 2.00),
('Interruptor de Luz - Schneider', 6, 5.00),
('Tubería de PVC - Tigre', 7, 3.00),
('Grifo Monomando - Grohe', 7, 80.00),
('Cámara de Seguridad - Ring', 8, 150.00),
('Cerradura Electrónica - Yale', 8, 120.00),
('Sierra de Calar - Black & Decker', 9, 70.00),
('Lijadora Orbital - Bosch', 9, 90.00),
('Lubricante Multiusos - WD-40', 10, 10.00),
('Escoba de Cerdas - Vileda', 10, 12.00),
('Guantes de Trabajo - Carhartt', 11, 20.00),
('Máscara de Seguridad - 3M', 11, 25.00),
('Pegamento de Contacto - Loctite', 12, 8.00),
('Sellador de Juntas - Sika', 12, 9.00),
('Bombilla LED - Philips', 13, 7.00),
('Focos Halógenos - Osram', 13, 12.00),
('Clavos de Acero - A. Phillips', 14, 5.00),
('Tornillos de Madera - Hilti', 14, 6.00),
('Calibrador Digital - Mitutoyo', 15, 50.00),
('Juego de Llaves de Impacto - Craftsman', 15, 85.00),
('Kit de Reparación de Automóviles - Bosch', 16, 100.00),
('Aspiradora de Taller - Kärcher', 16, 120.00),
('Limpiador de Alfombras - Bissell', 17, 90.00),
('Organizador de Herramientas - Stanley', 18, 45.00),
('Ganchos de Almacenaje - Rubbermaid', 19, 15.00),
('Cinta Métrica - Stanley', 20, 8.00),
('Anclajes para Pared - Toggler', 20, 7.00);
GO

SELECT * FROM Productos


--===========================================================================================
--TAREA DE USTEDES BUSCAR E INSERTAR LAS IMAGENES DE CADA PRODCUTO CON FORMATO TRANSPARENTE
--===========================================================================================

-- Insertar datos en la tabla Imagenes
INSERT INTO Imagenes (ProductoID, URL)
VALUES 
(1, 'https://example.com/imagenes/martillo_acero_stanley.jpg'),
(2, 'https://example.com/imagenes/destornillador_precision_bosch.jpg'),
(3, 'https://example.com/imagenes/taladro_inalambrico_dewalt.jpg'),
(4, 'https://example.com/imagenes/sierra_circular_makita.jpg'),
(5, 'https://example.com/imagenes/cemento_portland_holcim.jpg'),
(6, 'https://example.com/imagenes/ladrillos_ladrillos_del_sur.jpg'),
(7, 'https://example.com/imagenes/tijeras_jardin_fiskars.jpg'),
(8, 'https://example.com/imagenes/fungicida_plantas_bayer.jpg'),
(9, 'https://example.com/imagenes/pintura_acrilica_ppg.jpg'),
(10, 'https://example.com/imagenes/barniz_madera_sikkens.jpg'),
(11, 'https://example.com/imagenes/cable_electrico_nexans.jpg'),
(12, 'https://example.com/imagenes/interruptor_luz_schneider.jpg'),
(13, 'https://example.com/imagenes/tuberia_pvc_tigre.jpg'),
(14, 'https://example.com/imagenes/grifo_monomando_grohe.jpg'),
(15, 'https://example.com/imagenes/camara_seguridad_ring.jpg'),
(16, 'https://example.com/imagenes/cerradura_electronica_yale.jpg'),
(17, 'https://example.com/imagenes/sierra_de_calar_black_decker.jpg'),
(18, 'https://example.com/imagenes/lijadora_orbital_bosch.jpg'),
(19, 'https://example.com/imagenes/lubricante_multiusos_wd40.jpg'),
(20, 'https://example.com/imagenes/escoba_cerdas_vileda.jpg'),
(21, 'https://example.com/imagenes/paleta_madera_carpintero.jpg'),
(22, 'https://example.com/imagenes/llave_inglesa_gedore.jpg'),
(23, 'https://example.com/imagenes/mescla_cemento_trex.jpg'),
(24, 'https://example.com/imagenes/pincel_pintura_rex.jpg'),
(25, 'https://example.com/imagenes/pegamento_ceramico_grout.jpg'),
(26, 'https://example.com/imagenes/aspiradora_industrial_karcher.jpg'),
(27, 'https://example.com/imagenes/amoladora_electronica_dewalt.jpg'),
(28, 'https://example.com/imagenes/taladro_percutor_makita.jpg'),
(29, 'https://example.com/imagenes/guantes_proteccion_3m.jpg'),
(30, 'https://example.com/imagenes/fresadora_madera_bosch.jpg'),
(31, 'https://example.com/imagenes/camisa_algodon_nike.jpg'),
(32, 'https://example.com/imagenes/pantalones_mezclilla_levi.jpg'),
(33, 'https://example.com/imagenes/chaqueta_cuero_adidas.jpg'),
(34, 'https://example.com/imagenes/zapatos_cuero_clarks.jpg'),
(35, 'https://example.com/imagenes/cinturon_cuero_tommy.jpg'),
(36, 'https://example.com/imagenes/ropa_deportiva_under_armour.jpg'),
(37, 'https://example.com/imagenes/vestido_noche_zara.jpg');
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
('Elena Ramírez', 'Bolivia');
GO

-- Insertar datos en la tabla Clientes
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
('Carmen Jiménez', 'Bolivia');
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
CREATE VIEW DetallesCompletosVentas AS
SELECT v.VentaID, v.Fecha, c.NombreCliente, ven.NombreVendedor, p.NombreProducto, v.Cantidad, v.MontoTotal, u.Ciudad, u.Pais
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