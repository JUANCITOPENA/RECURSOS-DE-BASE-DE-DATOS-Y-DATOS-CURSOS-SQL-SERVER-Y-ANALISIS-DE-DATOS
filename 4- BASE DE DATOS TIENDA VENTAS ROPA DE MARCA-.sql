-- Creación de la base de datos
CREATE DATABASE BASE_DATOS_TIENDA_ROPAS_MARCAS;
GO

-- Usar la base de datos
USE BASE_DATOS_TIENDA_ROPAS_MARCAS;
GO

-- Crear la tabla Categorias
CREATE TABLE Categorias (
    CategoriaID INT PRIMARY KEY IDENTITY(1,1),
    NombreCategoria NVARCHAR(50) NOT NULL
);
GO

-- Crear la tabla Productos con el campo Stock
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    NombreProducto NVARCHAR(100) NOT NULL,
    CategoriaID INT,
    Precio_Compra DECIMAL(10, 2),
    Precio_Ventas DECIMAL(10, 2),
    Stock INT NOT NULL,  -- Nuevo campo Stock
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



--VER LA TABLÄ

SELECT * FROM  Ventas


-- Crear un trigger para actualizar MontoTotal después de insertar o actualizar una fila en la tabla Ventas
CREATE OR ALTER TRIGGER trg_AfterInsertUpdateVentas
ON Ventas
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Ventas
    SET MontoTotal = i.Cantidad * p.Precio_Ventas
    FROM inserted i
    JOIN Productos p ON i.ProductoID = p.ProductoID
    WHERE Ventas.VentaID = i.VentaID;
END;
GO




-- Insertar datos en la tabla Categorías
INSERT INTO Categorias (NombreCategoria)
VALUES 
('Hamburguesas'),
('Pizzas'),
('Hot Dogs'),
('Tacos'),
('Sándwiches'),
('Nuggets'),
('Papas Fritas'),
('Bebidas'),
('Ensaladas'),
('Postres');
GO


-- Eliminar la tabla Productos
DROP TABLE Productos;
GO

-- Insertar los datos en la tabla Productos con el campo Stock
INSERT INTO Productos (NombreProducto, CategoriaID, Precio_Compra, Precio_Ventas, Stock)
VALUES 
    ('Camisa de Algodón - Nike', 1, 25.00, 25.00 * (1 - 0.30), 1000),  -- 30% menos
    ('Pantalones de Mezclilla - Levi''s', 2, 40.00, 40.00 * (1 - 0.29), 1000),  -- 29% menos
    ('Chaqueta de Cuero - Adidas', 3, 150.00, 150.00 * (1 - 0.28), 1000),  -- 28% menos
    ('Zapatos de Cuero - Clarks', 4, 100.00, 100.00 * (1 - 0.27), 1000),  -- 27% menos
    ('Cinturón de Cuero - Tommy Hilfiger', 5, 30.00, 30.00 * (1 - 0.30), 1000),  -- 30% menos
    ('Ropa Deportiva Set - Under Armour', 6, 60.00, 60.00 * (1 - 0.26), 1000),  -- 26% menos
    ('Vestido de Noche - Zara', 7, 80.00, 80.00 * (1 - 0.25), 1000),  -- 25% menos
    ('Traje de Oficina - Hugo Boss', 8, 200.00, 200.00 * (1 - 0.28), 1000),  -- 28% menos
    ('Boxers de Algodón - Calvin Klein', 9, 15.00, 15.00 * (1 - 0.27), 1000),  -- 27% menos
    ('Juego de Sábanas - Brooklinen', 10, 50.00, 50.00 * (1 - 0.29), 1000),  -- 29% menos
    ('Camiseta Deportiva - Puma', 1, 20.00 * (1 - 0.28), 20.00, 1000),  -- 28% menos
    ('Jeans Ajustados - Diesel', 2, 70.00 * (1 - 0.30), 70.00, 1000),  -- 30% menos
    ('Chaqueta de Lana - North Face', 3, 180.00 * (1 - 0.25), 180.00, 1000),  -- 25% menos
    ('Botas de Montaña - Timberland', 4, 120.00 * (1 - 0.26), 120.00, 1000),  -- 26% menos
    ('Gorra de Béisbol - New Era', 5, 25.00 * (1 - 0.27), 25.00, 1000),  -- 27% menos
    ('Conjunto Deportivo - Nike', 6, 90.00 * (1 - 0.30), 90.00, 1000),  -- 30% menos
    ('Blusa Casual - Mango', 7, 35.00 * (1 - 0.29), 35.00, 1000),  -- 29% menos
    ('Abrigo de Invierno - Patagonia', 8, 250.00 * (1 - 0.28), 250.00, 1000),  -- 28% menos
    ('Calzoncillos Boxer - H&M', 9, 10.00 * (1 - 0.25), 10.00, 1000),  -- 25% menos
    ('Toallas de Baño - Ralph Lauren', 10, 45.00 * (1 - 0.26), 45.00, 1000),  -- 26% menos
    ('Sombrero de Paja - Panama Jack', 5, 30.00 * (1 - 0.27), 30.00, 1000),  -- 27% menos
    ('Polo Clásico - Lacoste', 1, 50.00 * (1 - 0.30), 50.00, 1000),  -- 30% menos
    ('Pantalones Cortos - Adidas', 2, 25.00 * (1 - 0.29), 25.00, 1000),  -- 29% menos
    ('Chaleco Acolchado - Uniqlo', 3, 60.00 * (1 - 0.28), 60.00, 1000),  -- 28% menos
    ('Sandalias de Cuero - Birkenstock', 4, 70.00 * (1 - 0.25), 70.00, 1000),  -- 25% menos
    ('Reloj Deportivo - Casio', 6, 90.00 * (1 - 0.26), 90.00, 1000);  -- 26% menos
GO

--VER LA TABLÄ

SELECT * FROM  Productos

UPDATE Productos SET STOCK =2000



--===========================================================================================
--TAREA DE USTEDES BUSCAR E INSERTAR LAS IMAGENES DE CADA PRODCUTO CON FORMATO TRANSPARENTE
--===========================================================================================


-- Insertar datos en la tabla Imágenes
INSERT INTO Imagenes (ProductoID, URL)
VALUES 
(1, 'https://static.nike.com/a/images/t_default/5d19d9be-e39d-4091-b9d4-643d7334542e/GG+M+NK+SS+CTN+DORM+PACK+CREW.png'),
(2, 'https://cdnx.jumpseller.com/bendita-bodega/image/45601802/resize/450/450?1708102773'),
(3, 'https://la.louisvuitton.com/images/is/image/lv/1/PP_VP_L/louis-vuitton-chamarra-reversible-monograma-shibori--HOL85EZRF744_PM2_Front%20view.jpg'),
(4, 'https://i5.walmartimages.com/seo/Clarks-Wallabee-Men-s-2-Eyelet-Lace-Up-Suede-Shoes-In-Cola-Size-10-5_7e4a471d-c480-41c0-8275-d0daaae0b9ce.91bf4663860441dc7728ef5c86f7cb9e.jpeg'),
(5, 'https://stayhard.com/cdn/shop/files/61077-23_001.png?v=1693378294&width=1200'),
(6, 'https://yanetennis.com/2031-large_default/ropa-under-armour-nina-negrogrisblanco.jpg'),
(7, 'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1679408963-1677768147-306917-06-6400b5c473b71.png?crop=1xw:1xh;center,top&resize=980:*'),
(8, 'https://shop.saxdepartment.com/storage/images/products/1693572115UL40ypdx.png'),
(9, 'https://static.flexdog.es/flexdog-2/products/images/a3b1dd64-2637-4afd-89a8-22efe16e13df_instyle_ai.jpeg?width=640&quality=70'),
(10, 'https://crdms.images.consumerreports.org/c_lfill,w_480,q_auto,f_auto,dpr_1/prod/products/cr/models/396402-sheets-l-l-bean-pima-cotton-percale-280tc-10000035'),
(11, 'https://shop.navi.gg/files/resized/products/gameday_1.650x622.png'),
(12, 'https://media.vogue.mx/photos/65b05cd1f49e26635843d354/master/w_1600%2Cc_limit/12.png'),
(13, 'https://clonethehype.com/wp-content/uploads/2022/02/Chaqueta-Nuptse-The-North-Face-gris-cerrada.jpg-450x535.png'),
(14, 'https://i.pinimg.com/originals/5c/69/ba/5c69bab6cc94a0076e3cab8f151ce156.png'),
(15, 'https://endorfinacultural.com/wp-content/uploads/2019/03/New-Era-MLB-1.png'),
(16, 'https://acdn.mitiendanube.com/stores/001/312/744/products/afasgdhfyguioio1-f23dc33127218212ff16654542719940-480-0.png'),
(17, 'https://png.pngtree.com/png-vector/20240725/ourmid/pngtree-plain-white-long-sleeve-shirt-isolated-on-transparent-background-png-image_13221863.png'),
(18, 'https://cdn.shopify.com/s/files/1/0012/1661/0359/files/WBS18_84065_DLMB.png?10117'),
(19, 'https://www.bjornborg.com/media/images/2195_58a0316e73-10002886-mp005-1-original.jpg?auto=format&w=1300&q=70'),
(20, 'https://www.nordicnest.es/assets/blobs/njrd-toalla-de-bano-stripes-100x150-cm-gris/572485-01_1_ProductImageMain-7bfa163b23.png?preset=tiny&dpr=2  '),
(21, 'https://dinalsom.com/wp-content/uploads/2023/04/GARDELIANO-STANDARD-VENTILADO-CANELA.png'),
(22, 'https://www.ecru.es/cdn/shop/files/polo-unisex-lacoste-de-pique-de-algodon-classic-fit-azul-polos-lacoste-ecru-1_grande.png?v=1716450337'), 
(23, 'https://www.sportyfied.com/thumbs/regular/adidas_hb0575_front_700x700.png'),
(24, 'https://media.vogue.mx/photos/6526e5730647b08dee8b1373/master/w_1600%2Cc_limit/giubbotto%2520smanicato%252017.png'),
(25, 'https://www.courir.es/dw/image/v2/BCCL_PRD/on/demandware.static/-/Sites-master-catalog-courir/default/dw0b6e8a96/images/hi-res/001504455_101.png?sw=600&sh=600&sm=fit&frz-v=33'),
(26, 'https://www.casio.com/content/dam/casio/product-info/locales/mx/es-ar/timepiece/product/watch/D/DW/dwh/dw-h5600-1/assets/DW-H5600-1.png.transform/main-visual-sp/image.png');
GO

select * from Vendedores

-- Insertar  Vendedores 
INSERT INTO Vendedores (NombreVendedor, Pais)
VALUES 
('Roberto Castillo', 'Brasil'),
('Gabriela Moreno', 'Venezuela'),
('Pedro Rivas', 'Guatemala'),
('Mónica Herrera', 'Honduras'),
('Andrés Mendoza', 'Panamá'),
('Isabel Ortega', 'Costa Rica'),
('Fernando Álvarez', 'El Salvador'),
('Patricia Jiménez', 'República Dominicana'),
('Diego Navarro', 'Cuba'),
('Carmen Vargas', 'Nicaragua'),
('Rafael Delgado', 'Puerto Rico'),
('Verónica Soto', 'Haití'),
('Eduardo Silva', 'Jamaica'),
('Daniela Paredes', 'Trinidad y Tobago'),
('José Cruz', 'Guyana');
GO

-- Insertar 30 clientes adicionales en la tabla Vendedores
INSERT INTO Clientes(NombreCliente, Pais)
VALUES 
('Alberto Espinosa', 'México'),
('Beatriz Rodríguez', 'España'),
('Diego Muñoz', 'Argentina'),
('Florencia Vargas', 'Chile'),
('Hugo Pérez', 'Colombia'),
('Irene Morales', 'Perú'),
('Julio Ramírez', 'Ecuador'),
('Karen Álvarez', 'Uruguay'),
('Lucas Romero', 'Paraguay'),
('Natalia Cruz', 'Bolivia'),
('Osvaldo Paredes', 'Brasil'),
('Paloma García', 'Venezuela'),
('Quintín Hernández', 'Guatemala'),
('Raquel Sánchez', 'Honduras'),
('Sebastián Medina', 'Panamá'),
('Teresa Ruiz', 'Costa Rica'),
('Ulises Domínguez', 'El Salvador'),
('Valeria Nieto', 'República Dominicana'),
('Wilfredo Flores', 'Cuba'),
('Ximena Pérez', 'Nicaragua'),
('Yolanda Castro', 'Puerto Rico'),
('Zacarías Luna', 'Haití'),
('Álvaro Serrano', 'Jamaica'),
('Bárbara Reyes', 'Trinidad y Tobago'),
('Cristina Castillo', 'Guyana'),
('Damián López', 'México'),
('Esther Ortega', 'España'),
('Felipe González', 'Argentina'),
('Gloria Ramírez', 'Chile'),
('Héctor Suárez', 'Colombia');
GO

--VER LA TABLA:

select * from Vendedores


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
('Río de Janeiro', 'Brasil'),
('Caracas', 'Venezuela'),
('Ciudad de Guatemala', 'Guatemala'),
('Tegucigalpa', 'Honduras'),
('Ciudad de Panamá', 'Panamá'),
('San José', 'Costa Rica'),
('San Salvador', 'El Salvador'),
('Santo Domingo', 'República Dominicana'),
('La Habana', 'Cuba'),
('Managua', 'Nicaragua'),
('San Juan', 'Puerto Rico'),
('Puerto Príncipe', 'Haití'),
('Kingston', 'Jamaica'),
('Puerto España', 'Trinidad y Tobago'),
('Georgetown', 'Guyana'),
('Guadalajara', 'México'),
('Barcelona', 'España'),
('Córdoba', 'Argentina'),
('Valparaíso', 'Chile'),
('Medellín', 'Colombia');
GO

--VER LA TABLA:

select * from Ubicaciones



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
CREATE OR ALTER PROCEDURE GenerarVentas
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


--VER LOS REGISTROS INSERTADOS EN LA TABLA DE VENTAS:

SELECT * FROM Ventas

-- Crear el trigger para actualizar el stock en Productos
CREATE TRIGGER ActualizarStock
ON Ventas
AFTER INSERT
AS
BEGIN
    -- Actualizar el stock en Productos basado en las ventas
    UPDATE Productos
    SET Stock = Stock - i.Cantidad
    FROM Productos p
    INNER JOIN inserted i ON p.ProductoID = i.ProductoID;
END;
GO


SELECT * FROM  Productos



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

-- Vista que combina todas las tablas de nuestro esquema de modelo estrella CON EL CALCULO EN DOLAR (59.75) HOY 13/08/2024

CREATE OR ALTER VIEW DetallesCompletosVentas AS
SELECT v.VentaID, v.Fecha, u.Ciudad, u.Pais, c.NombreCliente, ven.NombreVendedor, p.NombreProducto, p.Precio_Ventas, v.Cantidad,
 v.MontoTotal * 59.75 AS MontoTotalEnDOP  -- Multiplicando por el valor constante del dólar
FROM Ventas v
INNER JOIN Clientes c ON v.ClienteID = c.ClienteID
INNER JOIN Vendedores ven ON v.VendedorID = ven.VendedorID
INNER JOIN Productos p ON v.ProductoID = p.ProductoID
INNER JOIN Ubicaciones u ON v.UbicacionID = u.UbicacionID;
GO



-- Seleccionar todos los registros de la vista VentasTotalesPorPais
SELECT * FROM DetallesCompletosVentas;
GO
