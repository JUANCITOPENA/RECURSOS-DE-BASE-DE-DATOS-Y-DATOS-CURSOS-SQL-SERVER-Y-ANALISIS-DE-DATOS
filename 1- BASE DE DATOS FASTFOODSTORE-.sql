-- Crear la base de datos
CREATE DATABASE BASE_DE_DATOS_FASTFOODSTORE;
GO

-- Usar la base de datos creada
USE BASE_DE_DATOS_FASTFOODSTORE;
GO

-- Crear la tabla de Dimensión: Categorías
CREATE TABLE Categorias (
    CategoriaID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL
);
GO

--Ver la Tabla creada:

select * from Categorias

-- Crear la tabla de Dimensión: Productos
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(255) NULL,
    FechaIngreso DATE NOT NULL,
    CategoriaID INT NOT NULL,
    PrecioCompra DECIMAL(10, 2) NOT NULL,
    PrecioVenta DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);
GO

--Ver la Tabla creada:

select * from Productos



-- Crear la tabla de Dimensión: Ubicaciones
CREATE TABLE Ubicaciones (
    UbicacionID INT PRIMARY KEY IDENTITY(1,1),
    Ciudad NVARCHAR(100) NOT NULL,
    Pais NVARCHAR(100) NOT NULL

);
GO


--Ver la Tabla creada:

select * from Ubicaciones



-- Crear la tabla de Dimensión: Vendedores
CREATE TABLE Vendedores (
    VendedorID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    UbicacionID INT NOT NULL,
    FOREIGN KEY (UbicacionID) REFERENCES Ubicaciones(UbicacionID)
);
GO


--Ver la Tabla creada:

select * from Vendedores

-- Crear la tabla Foto_vendedor
CREATE TABLE Foto_vendedor (
    ImagenID INT PRIMARY KEY IDENTITY(1,1),
    Direccion_Web VARCHAR(255),
    VendedorID INT,
    FOREIGN KEY (VendedorID) REFERENCES Vendedores(VendedorID)
);
GO

--Ver la Tabla creada:

select * from Foto_vendedor


-- Crear la tabla de Dimensión: Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    UbicacionID INT NOT NULL,
    FOREIGN KEY (UbicacionID) REFERENCES Ubicaciones(UbicacionID)
);
GO


--Ver la Tabla creada:

select * from Clientes



-- Crear la tabla de Imágenes
CREATE TABLE Imagenes_Productos (
    ImagenID INT PRIMARY KEY IDENTITY(1,1),
    ProductoID INT,
    URL NVARCHAR(255),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);
GO

--Ver la Tabla creada:

select * from Imagenes_Productos


-- Crear la tabla de Hechos: Ventas
CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY IDENTITY(1,1),
    Fecha DATE NOT NULL,
    ProductoID INT NOT NULL,
    VendedorID INT NOT NULL,
    ClienteID INT NOT NULL,
    UbicacionID INT NOT NULL,
    Cantidad INT NOT NULL,
    MontoTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID),
    FOREIGN KEY (VendedorID) REFERENCES Vendedores(VendedorID),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (UbicacionID) REFERENCES Ubicaciones(UbicacionID)
);
GO

--Ver la Tabla creada:

select * from Ventas


-- Eliminar el trigger existente si ya está creado
IF OBJECT_ID('trg_CalcularMontoTotal', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER trg_CalcularMontoTotal;
END
GO

-- Crear el trigger para calcular el MontoTotal en la tabla Ventas
CREATE TRIGGER trg_CalcularMontoTotal
ON Ventas
AFTER INSERT, UPDATE
AS
BEGIN
    -- Actualizar el MontoTotal basado en el precio del producto y la cantidad
    UPDATE v
    SET v.MontoTotal = i.Cantidad * p.PrecioVenta
    FROM Ventas v
    JOIN inserted i ON v.VentaID = i.VentaID
    JOIN Productos p ON i.ProductoID = p.ProductoID;
END;
GO

-- Crear trigger para validar ubicación
CREATE OR ALTER TRIGGER trg_ValidarUbicacion
ON Ventas
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Vendedores v ON i.VendedorID = v.VendedorID
        JOIN Clientes c ON i.ClienteID = c.ClienteID
        WHERE v.UbicacionID != c.UbicacionID
    )
    BEGIN
        RAISERROR('El vendedor y el cliente deben estar en la misma ubicación.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO


-- Borrar todos los registros de la tabla Producto
DELETE FROM Productos;

-- Reiniciar el contador de identidad para que comience en 1
DBCC CHECKIDENT ('Productos', RESEED, 0);

-- Insertar registros en la tabla de Categorías
INSERT INTO Categorias (Nombre) VALUES
    ('Comida Rápida'),
    ('Bebidas'),
    ('Postres'),
    ('Comida Internacional'),
    ('Ensaladas'),
    ('Platos Principales'),
    ('Comida Mexicana'),
    ('Mariscos'),
    ('Cocina Tradicional'),
    ('Panadería');
GO


-- Inserción de datos en la tabla Productos con Categorías Asignadas
INSERT INTO Productos (Nombre, Descripcion, FechaIngreso, CategoriaID, PrecioCompra, PrecioVenta, Stock)
VALUES 
    ('Hamburguesa', 'Deliciosa hamburguesa con carne, lechuga, tomate y queso', GETDATE(), 1, 100, 150, 100),
    ('Pizza', 'Pizza recién horneada con los ingredientes de tu elección', GETDATE(), 1, 150, 200, 80),
    ('Hot Dog', 'Hot dog clásico con salchicha, pan y tus aderezos favoritos', GETDATE(), 1, 75, 100, 120),
    ('Papas Fritas', 'Papas fritas crujientes y doradas, perfectas como acompañamiento', GETDATE(), 1, 30, 50, 150),
    ('Refresco', 'Bebida refrescante de tu sabor favorito', GETDATE(), 2, 30, 50, 200),
    ('Pollo Frito', 'Trozos de pollo crujientes y sabrosos', GETDATE(), 6, 150, 180, 90),
    ('Ensalada César', 'Ensalada fresca con lechuga, crutones, pollo y aderezo César', GETDATE(), 5, 100, 120, 70),
    ('Tacos', 'Tacos mexicanos con carne, guacamole, salsa y cilantro', GETDATE(), 7, 130, 160, 100),
    ('Sushi Roll', 'Rollos de sushi variados con pescado fresco y arroz', GETDATE(), 4, 200, 250, 60),
    ('Alitas de Pollo', 'Alitas de pollo picantes o a la barbacoa', GETDATE(), 1, 100, 130, 110),
    ('Pasta Alfredo', 'Pasta con salsa Alfredo cremosa y queso parmesano', GETDATE(), 6, 140, 170, 80),
    ('Empanadas', 'Empanadas rellenas de carne, pollo o queso', GETDATE(), 10, 70, 90, 130),
    ('Burrito', 'Burrito mexicano con carne, frijoles, arroz y salsa', GETDATE(), 7, 110, 140, 90),
    ('Sándwich Club', 'Sándwich con pollo, tocino, lechuga, tomate y mayonesa', GETDATE(), 1, 90, 110, 120),
    ('Arroz con Pollo', 'Plato tradicional de arroz con pollo y vegetales', GETDATE(), 9, 130, 160, 80),
    ('Ceviche', 'Ceviche de pescado fresco marinado con limón y especias', GETDATE(), 8, 170, 200, 70),
    ('Churrasco', 'Churrasco argentino con carne asada y chimichurri', GETDATE(), 4, 180, 220, 60),
    ('Sopa de Tortilla', 'Sopa mexicana de tortilla con pollo, aguacate y queso', GETDATE(), 7, 100, 120, 100),
    ('Pastel de Chocolate', 'Delicioso pastel de chocolate con cobertura de ganache', GETDATE(), 3, 150, 180, 90),
    ('Gelatina', 'Gelatina de frutas frescas con crema batida', GETDATE(), 3, 60, 80, 150);
GO


--VER LOS PRODUCTOS INSERTADOS:

SELECT * FROM Productos

-- Actualizar el stock de todos los productos a 2000
UPDATE Productos
SET Stock = 5000;
GO

-- Insertar datos en la tabla Imagenes_Productos
INSERT INTO Imagenes_Productos (ProductoID, URL)
VALUES 
(1, 'https://via.placeholder.com/150?text=Producto+1'),
(2, 'https://via.placeholder.com/150?text=Producto+2'),
(3, 'https://via.placeholder.com/150?text=Producto+3'),
(4, 'https://via.placeholder.com/150?text=Producto+4'),
(5, 'https://via.placeholder.com/150?text=Producto+5'),
(6, 'https://via.placeholder.com/150?text=Producto+6'),
(7, 'https://via.placeholder.com/150?text=Producto+7'),
(8, 'https://via.placeholder.com/150?text=Producto+8'),
(9, 'https://via.placeholder.com/150?text=Producto+9'),
(10, 'https://via.placeholder.com/150?text=Producto+10'),
(11, 'https://via.placeholder.com/150?text=Producto+11'),
(12, 'https://via.placeholder.com/150?text=Producto+12'),
(13, 'https://via.placeholder.com/150?text=Producto+13'),
(14, 'https://via.placeholder.com/150?text=Producto+14'),
(15, 'https://via.placeholder.com/150?text=Producto+15'),
(16, 'https://via.placeholder.com/150?text=Producto+16'),
(17, 'https://via.placeholder.com/150?text=Producto+17'),
(18, 'https://via.placeholder.com/150?text=Producto+18'),
(19, 'https://via.placeholder.com/150?text=Producto+19'),
(20, 'https://via.placeholder.com/150?text=Producto+20');
GO


--VER LAS IMAGINES DE LOS PRODUCTOS INSERTADOS 

SELECT * FROM Imagenes_Productos

SELECT * FROM Productos

-- Insertar registros en la tabla de Ubicaciones
INSERT INTO Ubicaciones (Ciudad, Pais) VALUES
('Madrid', 'España'),
('Barcelona', 'España'),
('Lima', 'Perú'),
('Buenos Aires', 'Argentina'),
('Santiago', 'Chile'),
('Bogotá', 'Colombia'),
('Ciudad de México', 'México'),
('San José', 'Costa Rica'),
('Montevideo', 'Uruguay'),
('Quito', 'Ecuador'),
('Caracas', 'Venezuela'),
('La Paz', 'Bolivia'),
('Asunción', 'Paraguay'),
('Santo Domingo', 'República Dominicana'),
('Havana', 'Cuba');
GO


--VER las Ubicaciones INSERTADOS:

SELECT * FROM Ubicaciones


-- Insertar registros en la tabla de Vendedores con nombres actualizados
INSERT INTO Vendedores (Nombre, Email, UbicacionID) VALUES
('Juan Perez', 'juan.perez@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Madrid')),
('Maria Vizcaino', 'maria.vizcaino@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Barcelona')),
('Ana Santana', 'ana.santana@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Lima')),
('Luis Diaz', 'luis.diaz@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Buenos Aires')),
('Sofia Bergara', 'sofia.bergara@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Santiago')),
('Jorge Ramos', 'jorge.ramos@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Madrid')),
('Juan Comila', 'juan.comila@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Barcelona')),
('Juan Gabriel', 'juan.gabriel@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Lima')),
('Juan Perez', 'juan.perez2@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Buenos Aires')),
('Juan Gabriel', 'juan.gabriel2@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Santiago')),
('Juan Perez', 'juan.perez3@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Madrid')),
('Maria Vizcaino', 'maria.vizcaino2@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Barcelona')),
('Carlos Santos', 'carlos.santos@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Lima')),
('Ana Santana', 'ana.santana2@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Buenos Aires')),
('Sofia Bergara', 'sofia.bergara2@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Santiago'));
GO

--VER LOS Vendedores INSERTADOS:

SELECT * FROM Vendedores

-- Insertar datos en la tabla Foto_vendedor
INSERT INTO Foto_vendedor (Direccion_Web, VendedorID) VALUES
('https://dl.dropbox.com/s/4bz1xriny7ro04g/A40.png', 1),
('https://dl.dropbox.com/s/yxe96df3xrzoc4y/A44.png', 2),
('https://dl.dropboxusercontent.com/s/2lks10yyiurw2b0/A33.png', 3),
('https://dl.dropbox.com/s/zgx7g0h0mxubhao/A21.png', 4),
('https://dl.dropboxusercontent.com/s/id0gj57k6z3m73q/A34.png', 5),
('https://dl.dropbox.com/s/1f9hzgblcmuen4a/A10.png', 6),
('https://dl.dropbox.com/s/jveyj0btov87izo/A38.png', 7),
('https://dl.dropbox.com/s/z4geyw1u2psmm47/A16.png', 8),
('https://uploaddeimagens.com.br/images/002/602/727/full/196-leonardo-cardoso.png', 9),
('https://uploaddeimagens.com.br/images/002/602/729/full/265-julio-lima.png', 10),
('https://dl.dropboxusercontent.com/s/xnimxsc4d2ie02f/A50.png', 11),
('https://uploaddeimagens.com.br/images/002/602/728/full/215-carla-ferreira.png', 12),
('https://dl.dropbox.com/s/0jkab8w6ie0h91z/A42.png', 13),
('https://dl.dropbox.com/s/ov3t5g3xt8wm8zg/A29.png', 14),
('https://dl.dropbox.com/s/27oq7ocj4q8a0z8/A46.png', 15);
GO

--VER LAS IMAGENES INSERTADAS:

SELECT * FROM Foto_vendedor

-- Insertar registros en la tabla de Clientes
INSERT INTO Clientes (Nombre, Email, UbicacionID) VALUES
('Pedro Sánchez', 'pedro.sanchez@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Madrid')),
('Laura Martínez', 'laura.martinez@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Barcelona')),
('Jorge Ramírez', 'jorge.ramirez@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Lima')),
('Sofía Díaz', 'sofia.diaz@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Buenos Aires')),
('Fernando Ruiz', 'fernando.ruiz@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Santiago')),
('Ana Belén Álvarez', 'ana.belen.alvarez@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Madrid')),
('Mario Castillo', 'mario.castillo@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Barcelona')),
('Sandra López', 'sandra.lopez@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Lima')),
('Antonio Fernández', 'antonio.fernandez@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Buenos Aires')),
('Natalia González', 'natalia.gonzalez@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Santiago')),
('Ricardo Peña', 'ricardo.pena@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Madrid')),
('Patricia Gómez', 'patricia.gomez@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Barcelona')),
('Eduardo Romero', 'eduardo.romero@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Lima')),
('Silvia Moreno', 'silvia.moreno@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Buenos Aires')),
('Daniela Ruiz', 'daniela.ruiz@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Santiago')),
('Luis Alberto Ortega', 'luis.alberto.ortega@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Madrid')),
('Monica Fernández', 'monica.fernandez@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Barcelona')),
('Julio Martínez', 'julio.martinez@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Lima')),
('Carmen Muñoz', 'carmen.munoz@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Buenos Aires')),
('Mauricio Torres', 'mauricio.torres@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Santiago')),
('Alejandro Vargas', 'alejandro.vargas@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Madrid')),
('Viviana Moreno', 'viviana.moreno@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Barcelona')),
('Héctor Castillo', 'hector.castillo@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Lima')),
('Paola Gómez', 'paola.gomez@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Buenos Aires')),
('Javier Peña', 'javier.pena@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Santiago')),
('Verónica Ortega', 'veronica.ortega@example.com', (SELECT UbicacionID FROM Ubicaciones WHERE Ciudad = 'Madrid'));
GO




SELECT * FROM Ventas;
SELECT * FROM Clientes;
SELECT * FROM Productos;
SELECT * FROM Ubicaciones;
SELECT * FROM Vendedores;
SELECT * FROM Imagenes_Productos;
SELECT * FROM Categorias;





-- Eliminar el trigger existente si ya está creado
IF OBJECT_ID('trg_ActualizarStock', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER trg_ActualizarStock;
END
GO


-- Crear el trigger para actualizar el stock en la tabla Productos
CREATE TRIGGER trg_ActualizarStock
ON Ventas
AFTER INSERT
AS
BEGIN
    -- Actualizar el stock en la tabla Productos
    UPDATE p
    SET p.Stock = p.Stock - i.Cantidad
    FROM Productos p
    JOIN inserted i ON p.ProductoID = i.ProductoID;
END;
GO


CREATE OR ALTER PROCEDURE GenerarVentasAleatorias
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
    DECLARE @Precio DECIMAL(10, 2);
    DECLARE @MontoTotal DECIMAL(10, 2);

    -- Limpiar la tabla de ventas antes de insertar nuevos datos
    TRUNCATE TABLE Ventas;

    -- Crear una tabla temporal con todos los vendedores y sus ubicaciones
    CREATE TABLE #Vendedores (VendedorID INT, UbicacionID INT);
    INSERT INTO #Vendedores (VendedorID, UbicacionID)
    SELECT VendedorID, UbicacionID FROM Vendedores;

    -- Generar ventas
    DECLARE @i INT = 0;
    WHILE @i < @Cantidad
    BEGIN
        -- Generar una fecha aleatoria entre FechaInicio y FechaFin
        SET @Fecha = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % DATEDIFF(DAY, @FechaInicio, @FechaFin)), @FechaInicio);

        -- Seleccionar un VendedorID aleatorio
        SELECT TOP 1 
            @VendedorID = VendedorID,
            @UbicacionID = UbicacionID
        FROM #Vendedores
        ORDER BY NEWID();

        -- Seleccionar un ClienteID aleatorio en la misma ubicación que el vendedor
        SELECT TOP 1 
            @ClienteID = ClienteID
        FROM Clientes
        WHERE UbicacionID = @UbicacionID
        ORDER BY NEWID();

        -- Seleccionar un ProductoID aleatorio
        SELECT TOP 1 
            @ProductoID = ProductoID
        FROM Productos
        ORDER BY NEWID();

        -- Generar una cantidad aleatoria entre 1 y 10
        SET @CantidadVenta = ABS(CHECKSUM(NEWID()) % 10) + 1;

        -- Obtener el precio del producto seleccionado
        SELECT @Precio = PrecioVenta FROM Productos WHERE ProductoID = @ProductoID;

        -- Calcular el monto total
        SET @MontoTotal = @CantidadVenta * @Precio;

        -- Insertar el registro en la tabla de Ventas
        INSERT INTO Ventas (Fecha, ProductoID, VendedorID, ClienteID, UbicacionID, Cantidad, MontoTotal)
        VALUES (@Fecha, @ProductoID, @VendedorID, @ClienteID, @UbicacionID, @CantidadVenta, @MontoTotal);

        -- Volver a llenar la tabla temporal si no quedan más vendedores
        IF NOT EXISTS (SELECT 1 FROM #Vendedores WHERE VendedorID = @VendedorID)
        BEGIN
            -- Volver a llenar la tabla temporal con todos los vendedores
            TRUNCATE TABLE #Vendedores;
            INSERT INTO #Vendedores (VendedorID, UbicacionID)
            SELECT VendedorID, UbicacionID FROM Vendedores;
        END

        SET @i = @i + 1;
    END

    -- Limpiar la tabla temporal
    DROP TABLE #Vendedores;
END;
GO

-- Ejecutar el procedimiento almacenado para generar ventas aleatorias
EXEC GenerarVentasAleatorias '2020-01-01', '2024-08-13', 10000;
GO

select * from Ventas

-- Consultar el número de ventas por vendedor
SELECT v.VendedorID, COUNT(*) AS NumeroVentas
FROM Vendedores v
LEFT JOIN Ventas ve ON v.VendedorID = ve.VendedorID
GROUP BY v.VendedorID
ORDER BY v.VendedorID;
GO



-- Crear vista: Detalles de ventas combinando todas las tablas incluyendo imágenes, stock original y actual
CREATE OR ALTER VIEW VistaDetallesCompletos_Imagenes_Stock AS
SELECT 
    v.VentaID,
    v.Fecha,
    u.Pais,
    u.Ciudad,
    c.Nombre AS Cliente,
    ven.Nombre AS Vendedor,
    CT.Nombre AS Categoria_Producto,
    p.Nombre AS Producto,
    p.PrecioCompra AS 'Precio Compra',
    p.PrecioVenta AS 'Precio Ventas',
    v.Cantidad,
    v.MontoTotal,
    I.URL AS Foto_Producto,
	FV.Direccion_Web  AS Foto_vendedor,
    p.Stock AS Stock_Original,
    p.Stock - v.Cantidad AS Stock_Actual
FROM 
    Ventas v 
INNER JOIN 
    Clientes c ON v.ClienteID = c.ClienteID
INNER JOIN 
    Ubicaciones u ON v.UbicacionID = u.UbicacionID
INNER JOIN 
    Productos p ON v.ProductoID = p.ProductoID
INNER JOIN 
    Vendedores ven ON v.VendedorID = ven.VendedorID
INNER JOIN 
    Imagenes_Productos I ON p.ProductoID = I.ProductoID
INNER JOIN 
    Foto_vendedor FV ON FV.VendedorID = V.VendedorID
INNER JOIN 
    Categorias CT ON p.CategoriaID = CT.CategoriaID;
GO


-- Seleccionar todos los registros de la vista de detalles completos con imágenes
SELECT * FROM VistaDetallesCompletos_Imagenes_Stock;
GO

--DATOS PARA CONECTAR EN EXCEL O POWER BI:

--Nombre Servidor: ADVISERTECNOLOG
--Base de Datos:  BASE_DATOS_TECH_RD_JPV




-- Total de ventas por país
SELECT 
    u.Pais AS País,
    SUM(v.MontoTotal) AS TotalVentas
FROM 
    Ventas v
INNER JOIN 
    Ubicaciones u ON v.UbicacionID = u.UbicacionID
GROUP BY 
    u.Pais
ORDER BY 
    TotalVentas DESC;
GO

-- Total de ventas por ciudad
SELECT 
    u.Ciudad AS Ciudad,
    SUM(v.MontoTotal) AS TotalVentas
FROM 
    Ventas v
INNER JOIN 
    Ubicaciones u ON v.UbicacionID = u.UbicacionID
GROUP BY 
    u.Ciudad
ORDER BY 
    TotalVentas DESC;
GO

-- Total de ventas por cliente
SELECT 
    c.Nombre AS Cliente,
    SUM(v.MontoTotal) AS TotalVentas
FROM 
    Ventas v
INNER JOIN 
    Clientes c ON v.ClienteID = c.ClienteID
GROUP BY 
    c.Nombre
ORDER BY 
    TotalVentas DESC;
GO




-- Cantidad total de productos comprados por cliente

SELECT 
    c.Nombre AS Cliente,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
INNER JOIN 
    Clientes c ON v.ClienteID = c.ClienteID
GROUP BY 
    c.Nombre
ORDER BY 
    Monto_Total DESC;



-- Ventas promedio por cliente
SELECT 
    c.Nombre AS Cliente,
    AVG(v.MontoTotal) AS VentaPromedio
FROM 
    Ventas v
INNER JOIN 
    Clientes c ON v.ClienteID = c.ClienteID
GROUP BY 
    c.Nombre
ORDER BY 
    VentaPromedio DESC;
GO


-- ------------------------------
-- Consultas de Ventas
-- ------------------------------

-- Ventas por Vendedor
-- Esta consulta muestra la cantidad total y el monto total de ventas agrupado por vendedor.
SELECT 
    ven.Nombre AS Vendedor,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
INNER JOIN 
    Vendedores ven ON v.VendedorID = ven.VendedorID
GROUP BY 
    ven.Nombre
ORDER BY 
    Monto_Total DESC;
GO

-- Ventas por Categoría
-- Esta consulta muestra la cantidad total y el monto total de ventas agrupado por categoría de producto.
SELECT 
    ct.Nombre AS Categoria,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
INNER JOIN 
    Productos p ON v.ProductoID = p.ProductoID
INNER JOIN 
    Categorias ct ON p.CategoriaID = ct.CategoriaID
GROUP BY 
    ct.Nombre
ORDER BY 
    Monto_Total DESC;
GO

-- Ventas por Fecha
-- Esta consulta muestra la cantidad total y el monto total de ventas agrupado por fecha de venta.
SELECT 
    v.Fecha,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
GROUP BY 
    v.Fecha
ORDER BY 
    v.Fecha;
GO

-- Ventas por Ciudad
-- Esta consulta muestra la cantidad total y el monto total de ventas agrupado por ciudad de ubicación.
SELECT 
    u.Ciudad,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
INNER JOIN 
    Ubicaciones u ON v.UbicacionID = u.UbicacionID
GROUP BY 
    u.Ciudad
ORDER BY 
    Monto_Total DESC;
GO

-- Ventas por País
-- Esta consulta muestra la cantidad total y el monto total de ventas agrupado por país de ubicación.
SELECT 
    u.Pais,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
INNER JOIN 
    Ubicaciones u ON v.UbicacionID = u.UbicacionID
GROUP BY 
    u.Pais
ORDER BY 
    Monto_Total DESC;
GO

-- Top 10 Productos por Ventas
-- Esta consulta muestra los 10 productos con mayor monto total de ventas.
SELECT 
    p.Nombre AS Producto,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
INNER JOIN 
    Productos p ON v.ProductoID = p.ProductoID
GROUP BY 
    p.Nombre
ORDER BY 
    Monto_Total DESC;
GO


-- Ventas Mensuales
-- Esta consulta muestra la cantidad total y el monto total de ventas agrupado por mes y año.
SELECT 
    YEAR(v.Fecha) AS Año,
    MONTH(v.Fecha) AS Mes,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
GROUP BY 
    YEAR(v.Fecha),
    MONTH(v.Fecha)
ORDER BY 
    Año, Mes;
GO

-- Ventas Anuales
-- Esta consulta muestra la cantidad total y el monto total de ventas agrupado por año.
SELECT 
    YEAR(v.Fecha) AS Año,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
GROUP BY 
    YEAR(v.Fecha)
ORDER BY 
    Año;
GO

-- KPI: Total Ventas
-- Esta consulta muestra la cantidad total y el monto total de todas las ventas registradas.
SELECT 
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v;
GO

-- KPI: Promedio de Monto por Venta
-- Esta consulta muestra el promedio de monto por venta.
SELECT 
    AVG(v.MontoTotal) AS Promedio_Monto_Por_Venta
FROM 
    Ventas v;
GO


-- Ventas por País
-- Esta consulta muestra el total de ventas por país.
SELECT 
    u.Pais AS Pais,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
INNER JOIN 
    Ubicaciones u ON v.UbicacionID = u.UbicacionID
GROUP BY 
    u.Pais
ORDER BY 
    Monto_Total DESC;
GO

-- Ventas por Vendedor
-- Esta consulta muestra el total de ventas por vendedor.
SELECT 
    ven.Nombre AS Vendedor,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
INNER JOIN 
    Vendedores ven ON v.VendedorID = ven.VendedorID
GROUP BY 
    ven.Nombre
ORDER BY 
    Monto_Total DESC;
GO

-- Ventas por País y Vendedor
-- Esta consulta muestra el total de ventas por país y vendedor.
SELECT 
    u.Pais AS Pais,
    ven.Nombre AS Vendedor,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
INNER JOIN 
    Ubicaciones u ON v.UbicacionID = u.UbicacionID
INNER JOIN 
    Vendedores ven ON v.VendedorID = ven.VendedorID
GROUP BY 
    u.Pais, ven.Nombre
ORDER BY 
    Monto_Total DESC;
GO

-- Ventas por Categoría de Producto
-- Esta consulta muestra el total de ventas por categoría de producto.
SELECT 
    c.Nombre AS Categoria,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
INNER JOIN 
    Productos p ON v.ProductoID = p.ProductoID
INNER JOIN 
    Categorias c ON p.CategoriaID = c.CategoriaID
GROUP BY 
    c.Nombre
ORDER BY 
    Monto_Total DESC;
GO

-- Ventas por Fecha
-- Esta consulta muestra el total de ventas por fecha.
SELECT 
    v.Fecha,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
GROUP BY 
    v.Fecha
ORDER BY 
    v.Fecha;
GO

-- Ventas por Año
SELECT 
    YEAR(v.Fecha) AS Año,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
GROUP BY 
    YEAR(v.Fecha)
ORDER BY 
    Año;
GO


-- Ventas por Mes
SELECT 
    FORMAT(v.Fecha, 'MMMM') AS Mes,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
GROUP BY 
    FORMAT(v.Fecha, 'MMMM')
ORDER BY 
    Mes;
GO


-- Ventas por Mes
SELECT 
    FORMAT(v.Fecha, 'MMMM') AS Mes,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
GROUP BY 
    FORMAT(v.Fecha, 'MMMM')
ORDER BY 
    CASE FORMAT(v.Fecha, 'MMMM')
        WHEN 'January' THEN 1
        WHEN 'February' THEN 2
        WHEN 'March' THEN 3
        WHEN 'April' THEN 4
        WHEN 'May' THEN 5
        WHEN 'June' THEN 6
        WHEN 'July' THEN 7
        WHEN 'August' THEN 8
        WHEN 'September' THEN 9
        WHEN 'October' THEN 10
        WHEN 'November' THEN 11
        WHEN 'December' THEN 12
    END;
GO


-- Top 10 Productos por Ventas
-- Esta consulta muestra los 10 productos con mayor monto total de ventas.
SELECT 
    p.Nombre AS Producto,
    SUM(v.Cantidad) AS Cantidad_Total,
    SUM(v.MontoTotal) AS Monto_Total
FROM 
    Ventas v
INNER JOIN 
    Productos p ON v.ProductoID = p.ProductoID
GROUP BY 
    p.Nombre
ORDER BY 
    Monto_Total DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
GO


-- Paso 1: Sumar el Monto Total por Producto
WITH VentasPorProducto AS (
    SELECT 
        Producto,
        SUM(MontoTotal) AS Monto_Total
    FROM 
        VistaDetallesCompletos_Imagenes_Stock
    GROUP BY 
        Producto
),
VentasTotales AS (
    SELECT 
        SUM(Monto_Total) AS Total_Ventas
    FROM 
        VentasPorProducto
),
VentasConPorcentaje AS (
    SELECT 
        Producto,
        Monto_Total,
        SUM(Monto_Total) OVER (ORDER BY Monto_Total DESC ROWS UNBOUNDED PRECEDING) AS Monto_Total_Acumulado,
        (SUM(Monto_Total) OVER (ORDER BY Monto_Total DESC ROWS UNBOUNDED PRECEDING) / Total_Ventas) * 100 AS Porcentaje_Acumulado
    FROM 
        VentasPorProducto, VentasTotales
)
-- Mostrar todos los productos con su porcentaje acumulado
SELECT 
    Producto,
    Monto_Total,
    Monto_Total_Acumulado,
    Porcentaje_Acumulado
FROM 
    VentasConPorcentaje
ORDER BY 
    Monto_Total DESC;

/*

Diagrama de Pareto:

Qué es: Un gráfico que muestra la distribución de los problemas o causas en un conjunto de datos,
ordenados de mayor a menor según su frecuencia o impacto.

Propósito: Identificar las áreas que tienen el mayor impacto (por ejemplo, el 80% de los problemas 
provienen del 20% de las causas). Se basa en el principio de Pareto o la regla del 80/20.

Clasificación ABC
Qué es: Un método de clasificación que organiza los elementos (como productos, clientes, etc.)
en tres categorías: A, B y C.

Propósito: Priorizar los elementos en función de su importancia. Generalmente:

A: Los más importantes, que representan la mayor parte del valor (80% del impacto o valor).
B: Moderadamente importantes, con un impacto menor que A pero significativo.
C: Menos importantes, que representan el menor impacto o valor (menos del 5% del total).



*/


-- Paso 1: Sumar el Monto Total por Categoría
WITH VentasPorCategoria AS (
    SELECT 
        Categoria_Producto,
        SUM(MontoTotal) AS Monto_Total
    FROM 
        VistaDetallesCompletos_Imagenes_Stock
    GROUP BY 
        Categoria_Producto
),
VentasTotales AS (
    SELECT 
        SUM(Monto_Total) AS Total_Ventas
    FROM 
        VentasPorCategoria
),
VentasConPorcentaje AS (
    SELECT 
        Categoria_Producto,
        Monto_Total,
        SUM(Monto_Total) OVER (ORDER BY Monto_Total DESC ROWS UNBOUNDED PRECEDING) AS Monto_Total_Acumulado,
        (SUM(Monto_Total) OVER (ORDER BY Monto_Total DESC ROWS UNBOUNDED PRECEDING) / Total_Ventas) * 100 AS Porcentaje_Acumulado
    FROM 
        VentasPorCategoria, VentasTotales
)
-- Mostrar todas las categorías con su porcentaje acumulado
SELECT 
    Categoria_Producto,
    Monto_Total,
    Monto_Total_Acumulado,
    Porcentaje_Acumulado
FROM 
    VentasConPorcentaje
ORDER BY 
    Monto_Total DESC;


-- Paso 1: Sumar el Monto Total por Producto
WITH VentasPorProducto AS (
    SELECT 
        Producto,
        SUM(MontoTotal) AS Monto_Total
    FROM 
        VistaDetallesCompletos_Imagenes_Stock
    GROUP BY 
        Producto
),
VentasTotales AS (
    SELECT 
        SUM(Monto_Total) AS Total_Ventas
    FROM 
        VentasPorProducto
),
VentasConPorcentaje AS (
    SELECT 
        Producto,
        Monto_Total,
        SUM(Monto_Total) OVER (ORDER BY Monto_Total DESC ROWS UNBOUNDED PRECEDING) AS Monto_Total_Acumulado,
        (SUM(Monto_Total) OVER (ORDER BY Monto_Total DESC ROWS UNBOUNDED PRECEDING) / Total_Ventas) * 100 AS Porcentaje_Acumulado
    FROM 
        VentasPorProducto, VentasTotales
),
ClasificacionABC AS (
    SELECT 
        Producto,
        Monto_Total,
        Monto_Total_Acumulado,
        Porcentaje_Acumulado,
        CASE
            WHEN Porcentaje_Acumulado <= 80 THEN 'A'
            WHEN Porcentaje_Acumulado <= 95 THEN 'B'
            ELSE 'C'
        END AS Clasificacion_ABC
    FROM 
        VentasConPorcentaje
)
-- Mostrar todos los productos con su porcentaje acumulado y clasificación ABC
SELECT 
    Producto,
    Monto_Total,
    Monto_Total_Acumulado,
    Porcentaje_Acumulado,
    Clasificacion_ABC
FROM 
    ClasificacionABC
ORDER BY 
    Monto_Total DESC;



/*
Para aplicar el Principio de Pareto y la Clasificación ABC a los datos que has proporcionado, 
sigamos estos pasos en el contexto de ventas e inventarios:

1. Análisis del Principio de Pareto (80/20)
Este principio sugiere que una pequeña proporción de tus productos generará la mayor parte de 
tus ventas. Para aplicarlo:

Calcular el 80% de las ventas:

Suma las ventas totales por producto usando la tabla Ventas. Puedes usar una consulta SQL 
para obtener los productos que contribuyen al 80% de las ventas.

Identificar los productos más valiosos:

Encuentra qué productos están en el top 20% que generan el 80% de las ventas. Esto se hace
ordenando los productos por monto total y acumulando hasta alcanzar el 80% de las ventas totales.

*/
WITH VentasPorProducto AS (
    SELECT ProductoID, SUM(MontoTotal) AS TotalVentas
    FROM Ventas
    GROUP BY ProductoID
),
VentasOrdenadas AS (
    SELECT *, 
           SUM(TotalVentas) OVER (ORDER BY TotalVentas DESC) AS VentasAcumuladas,
           SUM(TotalVentas) OVER () AS VentasTotales
    FROM VentasPorProducto
)
SELECT ProductoID, TotalVentas
FROM VentasOrdenadas
WHERE VentasAcumuladas <= 0.8 * VentasTotales;


WITH VentasPorProducto AS (
    SELECT ProductoID, SUM(MontoTotal) AS TotalVentas
    FROM Ventas
    GROUP BY ProductoID
),
Clasificacion AS (
    SELECT ProductoID, TotalVentas,
           NTILE(3) OVER (ORDER BY TotalVentas DESC) AS Categoria
    FROM VentasPorProducto
)
SELECT ProductoID, TotalVentas,
       CASE WHEN Categoria = 1 THEN 'A'
            WHEN Categoria = 2 THEN 'B'
            ELSE 'C'
       END AS CategoriaABC
FROM Clasificacion;




-- Paso 1: Sumar el Monto Total y la Cantidad Vendida por Producto
WITH VentasPorProducto AS (
    SELECT 
        p.Nombre AS Producto,
        SUM(v.MontoTotal) AS Monto_Total,
        SUM(v.Cantidad) AS Cantidad_Vendida
    FROM 
        Ventas v
    JOIN 
        Productos p ON v.ProductoID = p.ProductoID
    GROUP BY 
        p.Nombre
),

-- Paso 2: Calcular el Total de Ventas
VentasTotales AS (
    SELECT 
        SUM(Monto_Total) AS Total_Ventas
    FROM 
        VentasPorProducto
),

-- Paso 3: Calcular el Monto Total Acumulado y el Porcentaje Acumulado
VentasConPorcentaje AS (
    SELECT 
        Producto,
        Monto_Total,
        Cantidad_Vendida,
        SUM(Monto_Total) OVER (ORDER BY Monto_Total DESC ROWS UNBOUNDED PRECEDING) AS Monto_Total_Acumulado,
        (SUM(Monto_Total) OVER (ORDER BY Monto_Total DESC ROWS UNBOUNDED PRECEDING) / Total_Ventas) * 100 AS Porcentaje_Acumulado
    FROM 
        VentasPorProducto, VentasTotales
),

-- Paso 4: Obtener la Información del Producto (Incluye Stock Actual)
ProductosConInfo AS (
    SELECT
        v.Producto,
        p.Stock - v.Cantidad_Vendida AS Stock_Actual,  -- Stock inicial menos la cantidad vendida
        p.Stock AS Stock_Inicial, -- Stock inicial para mostrar
        v.Monto_Total,
        v.Cantidad_Vendida,
        v.Monto_Total_Acumulado,
        v.Porcentaje_Acumulado,
        CASE
            WHEN v.Porcentaje_Acumulado <= 80 THEN 'A'
            WHEN v.Porcentaje_Acumulado <= 95 THEN 'B'
            ELSE 'C'
        END AS Clasificacion_ABC,
        CASE
            WHEN p.Stock - v.Cantidad_Vendida < 0 THEN 'Stock insuficiente'
            ELSE 'Stock adecuado'
        END AS Comentario,
        CASE
            WHEN v.Porcentaje_Acumulado <= 80 THEN 'Productos de alta rotación, representan una gran parte de las ventas. Priorizar stock y marketing.'
            WHEN v.Porcentaje_Acumulado <= 95 THEN 'Productos de rotación media, contribuyen moderadamente a las ventas. Mantener en stock y considerar promociones.'
            ELSE 'Productos de baja rotación, representan una menor parte de las ventas. Evaluar reducciones de stock o estrategias de marketing.'
        END AS Descripcion_Clasificacion
    FROM
        VentasConPorcentaje v
    JOIN
        Productos p ON v.Producto = p.Nombre
)

-- Mostrar todos los productos con su porcentaje acumulado, clasificación ABC, stock actual, comentario y descripción
SELECT 
    Producto,
    Stock_Inicial,
    Monto_Total,
    Cantidad_Vendida,
    Monto_Total_Acumulado,
    Porcentaje_Acumulado,
    Clasificacion_ABC,
    Stock_Actual,
    Comentario,
    Descripcion_Clasificacion
FROM 
    ProductosConInfo
ORDER BY 
    Monto_Total DESC;




-- Modificaciones a la tabla Productos
ALTER TABLE Productos
ADD UnidadMedida NVARCHAR(50);

-- Modificaciones a la tabla Ventas
ALTER TABLE Ventas
ADD EstadoVenta NVARCHAR(20);

-- Modificaciones a la tabla Clientes
ALTER TABLE Clientes
ADD Telefono NVARCHAR(20),
    Direccion NVARCHAR(255);

-- Modificaciones a la tabla Vendedores
ALTER TABLE Vendedores
ADD Telefono NVARCHAR(20),
    FechaContratacion DATE;

-- Crear índices para mejorar el rendimiento
CREATE INDEX IX_Productos_Nombre ON Productos(Nombre);
CREATE INDEX IX_Ventas_Fecha ON Ventas(Fecha);
CREATE INDEX IX_Clientes_Nombre ON Clientes(Nombre);
CREATE INDEX IX_Vendedores_Nombre ON Vendedores(Nombre);

-- Modificar el trigger trg_CalcularMontoTotal para incluir el estado de la venta
ALTER TRIGGER trg_CalcularMontoTotal
ON Ventas
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE v
    SET v.MontoTotal = i.Cantidad * p.PrecioVenta,
        v.EstadoVenta = 'Completada'
    FROM Ventas v
    JOIN inserted i ON v.VentaID = i.VentaID
    JOIN Productos p ON i.ProductoID = p.ProductoID;
END;

-- Modificar el procedimiento almacenado GenerarVentasAleatorias
ALTER PROCEDURE GenerarVentasAleatorias
    @FechaInicio DATE,
    @FechaFin DATE,
    @Cantidad INT
AS
BEGIN
    -- ... (código anterior)

    -- Modificar la inserción para incluir el nuevo campo EstadoVenta
    INSERT INTO Ventas (Fecha, ProductoID, VendedorID, ClienteID, UbicacionID, Cantidad, MontoTotal, EstadoVenta)
    VALUES (@Fecha, @ProductoID, @VendedorID, @ClienteID, @UbicacionID, @CantidadVenta, @MontoTotal, 'Completada');

    -- ... (resto del código)
END;

-- Modificar la vista VistaDetallesCompletos_Imagenes
ALTER VIEW VistaDetallesCompletos_Imagenes AS
SELECT 
    v.VentaID,
    v.Fecha,
    u.Pais,
    u.Ciudad,
    c.Nombre AS Cliente,
    c.Telefono AS TelefonoCliente,
    ven.Nombre AS Vendedor,
    ven.Telefono AS TelefonoVendedor,
    CT.Nombre AS Categoria_Producto,
    p.Nombre AS Producto,
    p.UnidadMedida,
    p.PrecioCompra as 'Precio Compra',
    p.PrecioVenta as 'Precio Ventas',
    v.Cantidad,
    v.MontoTotal,
    v.EstadoVenta,
    I.URL AS Foto_Producto
FROM 
    Ventas v 
INNER JOIN 
    Clientes c ON v.ClienteID = c.ClienteID
INNER JOIN 
    Ubicaciones u ON v.UbicacionID = u.UbicacionID
INNER JOIN 
    Productos p ON v.ProductoID = p.ProductoID
INNER JOIN 
    Vendedores ven ON v.VendedorID = ven.VendedorID
INNER JOIN 
    Imagenes_Productos I ON P.ProductoID = I.ProductoID
INNER JOIN 
    Categorias CT ON P.CategoriaID= CT.CategoriaID;



SELECT * FROM VistaDetallesCompletos_Imagenes


-- Actualizar la tabla Productos con UnidadMedida
UPDATE Productos
SET UnidadMedida = 
    CASE 
        WHEN CategoriaID IN (SELECT CategoriaID FROM Categorias WHERE Nombre IN ('Electrónica', 'Accesorios', 'Computadoras', 'Telefonía', 'Wearables')) THEN 'Unidad'
        WHEN CategoriaID IN (SELECT CategoriaID FROM Categorias WHERE Nombre IN ('Fotografía', 'Oficina', 'Gamer')) THEN 'Pieza'
        WHEN CategoriaID IN (SELECT CategoriaID FROM Categorias WHERE Nombre IN ('Hogar Inteligente')) THEN 'Set'
        ELSE 'Unidad'
    END;

-- Actualizar la tabla Ventas con EstadoVenta
UPDATE Ventas
SET EstadoVenta = 'Completada';

-- Actualizar la tabla Clientes con Telefono y Direccion
UPDATE Clientes
SET Telefono = CONCAT('+', ABS(CHECKSUM(NEWID()) % 90 + 10), ' ', 
                      ABS(CHECKSUM(NEWID()) % 900 + 100), ' ', 
                      ABS(CHECKSUM(NEWID()) % 9000 + 1000)),
    Direccion = CONCAT('Calle ', ABS(CHECKSUM(NEWID()) % 100 + 1), ', ', 
                       'No. ', ABS(CHECKSUM(NEWID()) % 1000 + 1), ', ',
                       Ciudad, ', ', Pais)
FROM Clientes c
JOIN Ubicaciones u ON c.UbicacionID = u.UbicacionID;

-- Actualizar la tabla Vendedores con Telefono y FechaContratacion
UPDATE Vendedores
SET Telefono = CONCAT('+', ABS(CHECKSUM(NEWID()) % 90 + 10), ' ', 
                      ABS(CHECKSUM(NEWID()) % 900 + 100), ' ', 
                      ABS(CHECKSUM(NEWID()) % 9000 + 1000)),
    FechaContratacion = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 1825), GETDATE());

-- Verificar los datos actualizados
SELECT TOP 10 * FROM Productos;
SELECT TOP 10 * FROM Ventas;
SELECT TOP 10 * FROM Clientes;
SELECT TOP 10 * FROM Vendedores;



-- Actualizar el procedimiento almacenado GenerarVentasAleatorias
ALTER PROCEDURE GenerarVentasAleatorias
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
    DECLARE @Precio DECIMAL(10, 2);
    DECLARE @MontoTotal DECIMAL(10, 2);
    DECLARE @EstadoVenta NVARCHAR(20);

    -- Limpiar la tabla de ventas antes de insertar nuevos datos
    TRUNCATE TABLE Ventas;

    -- Crear una tabla temporal con todos los vendedores y sus ubicaciones
    CREATE TABLE #Vendedores (VendedorID INT, UbicacionID INT);
    INSERT INTO #Vendedores (VendedorID, UbicacionID)
    SELECT VendedorID, UbicacionID FROM Vendedores;

    -- Generar ventas
    DECLARE @i INT = 0;
    WHILE @i < @Cantidad
    BEGIN
        -- Generar una fecha aleatoria entre FechaInicio y FechaFin
        SET @Fecha = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % DATEDIFF(DAY, @FechaInicio, @FechaFin)), @FechaInicio);

        -- Seleccionar un VendedorID aleatorio
        SELECT TOP 1 
            @VendedorID = VendedorID,
            @UbicacionID = UbicacionID
        FROM #Vendedores
        ORDER BY NEWID();

        -- Seleccionar un ClienteID aleatorio en la misma ubicación que el vendedor
        SELECT TOP 1 
            @ClienteID = ClienteID
        FROM Clientes
        WHERE UbicacionID = @UbicacionID
        ORDER BY NEWID();

        -- Seleccionar un ProductoID aleatorio
        SELECT TOP 1 
            @ProductoID = ProductoID
        FROM Productos
        ORDER BY NEWID();

        -- Generar una cantidad aleatoria entre 1 y 10
        SET @CantidadVenta = ABS(CHECKSUM(NEWID()) % 10) + 1;

        -- Obtener el precio del producto seleccionado
        SELECT @Precio = PrecioVenta FROM Productos WHERE ProductoID = @ProductoID;

        -- Calcular el monto total
        SET @MontoTotal = @CantidadVenta * @Precio;

        -- Generar un estado de venta aleatorio
        SET @EstadoVenta = CASE ABS(CHECKSUM(NEWID()) % 100)
            WHEN 0 THEN 'Cancelada'
            WHEN 1 THEN 'Pendiente'
            ELSE 'Completada'
        END;

        -- Insertar el registro en la tabla de Ventas
        INSERT INTO Ventas (Fecha, ProductoID, VendedorID, ClienteID, UbicacionID, Cantidad, MontoTotal, EstadoVenta)
        VALUES (@Fecha, @ProductoID, @VendedorID, @ClienteID, @UbicacionID, @CantidadVenta, @MontoTotal, @EstadoVenta);

        -- Volver a llenar la tabla temporal si no quedan más vendedores
        IF NOT EXISTS (SELECT 1 FROM #Vendedores WHERE VendedorID = @VendedorID)
        BEGIN
            -- Volver a llenar la tabla temporal con todos los vendedores
            TRUNCATE TABLE #Vendedores;
            INSERT INTO #Vendedores (VendedorID, UbicacionID)
            SELECT VendedorID, UbicacionID FROM Vendedores;
        END

        SET @i = @i + 1;
    END

    -- Limpiar la tabla temporal
    DROP TABLE #Vendedores;
END;
GO

-- Ejecutar el procedimiento almacenado para generar ventas aleatorias
EXEC GenerarVentasAleatorias '2024-01-01', '2024-08-13', 12000;
GO

-- Verificar los nuevos datos generados
SELECT TOP 12000 * FROM Ventas;



/*
Este procedimiento almacenado, `GenerarVentasAleatorias`, tiene como objetivo generar de manera automática
un conjunto de ventas aleatorias para un período de tiempo especificado. 

El proceso se realiza en los siguientes pasos:

1. **Parámetros de Entrada**:
   - `@FechaInicio`: Fecha inicial del rango para la generación de ventas.
   - `@FechaFin`: Fecha final del rango para la generación de ventas.
   - `@Cantidad`: Cantidad de ventas aleatorias a generar.

2. **Preparación del Entorno**:
   - Se limpian los datos existentes en la tabla `Ventas`.
   - Se crean tablas temporales para almacenar los vendedores y productos disponibles.

3. **Generación de Ventas**:
   - En un bucle `WHILE`, se generan ventas aleatorias basadas en:
     - Fecha aleatoria dentro del rango especificado.
     - Selección aleatoria de un vendedor y un cliente en la misma ubicación.
     - Selección aleatoria de un producto y cantidad vendida.
     - Cálculo del monto total basado en el precio del producto y la cantidad vendida.
     - Asignación de un estado aleatorio a la venta (`Completada`, `Pendiente`, `Cancelada`).
   - Después de usar un vendedor o producto, se eliminan temporalmente para evitar repeticiones excesivas
   y se vuelven a cargar si es necesario.

4. **Finalización**:
   - Se eliminan las tablas temporales utilizadas.
   
Este procedimiento es útil para simular ventas en un entorno de prueba, generando datos realistas para pruebas de
rendimiento, análisis de datos, o desarrollo de características relacionadas con la gestión de ventas.
*/

-- Actualizar el procedimiento almacenado GenerarVentasAleatorias
ALTER PROCEDURE GenerarVentasAleatorias
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
    DECLARE @Precio DECIMAL(10, 2);
    DECLARE @MontoTotal DECIMAL(10, 2);
    DECLARE @EstadoVenta NVARCHAR(20);
    DECLARE @Pais NVARCHAR(50);
    DECLARE @ClienteUbicacionID INT;
    DECLARE @VendedorUbicacionID INT;

    -- Limpiar la tabla de ventas antes de insertar nuevos datos
    TRUNCATE TABLE Ventas;

    -- Crear una tabla temporal con todos los vendedores y sus ubicaciones
    CREATE TABLE #Vendedores (VendedorID INT, UbicacionID INT, Pais NVARCHAR(50), Ciudad NVARCHAR(50));
    INSERT INTO #Vendedores (VendedorID, UbicacionID, Pais, Ciudad)
    SELECT v.VendedorID, v.UbicacionID, u.Pais, u.Ciudad
    FROM Vendedores v
    JOIN Ubicaciones u ON v.UbicacionID = u.UbicacionID;

    -- Crear una tabla temporal con todos los productos
    CREATE TABLE #Productos (ProductoID INT);
    INSERT INTO #Productos (ProductoID)
    SELECT ProductoID FROM Productos;

    -- Generar ventas
    DECLARE @i INT = 0;
    WHILE @i < @Cantidad
    BEGIN
        -- Generar una fecha aleatoria entre FechaInicio y FechaFin
        SET @Fecha = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % DATEDIFF(DAY, @FechaInicio, @FechaFin)), @FechaInicio);

        -- Seleccionar un VendedorID aleatorio
        SELECT TOP 1 
            @VendedorID = VendedorID,
            @UbicacionID = UbicacionID,
            @Pais = Pais
        FROM #Vendedores
        ORDER BY NEWID();

        -- Seleccionar un ClienteID aleatorio en el mismo país que el vendedor
        SELECT TOP 1 
            @ClienteID = c.ClienteID,
            @ClienteUbicacionID = u.UbicacionID
        FROM Clientes c
        JOIN Ubicaciones u ON c.UbicacionID = u.UbicacionID
        WHERE u.Pais = @Pais  -- Comparar con la variable @Pais en lugar de PaisID
        ORDER BY NEWID();

        -- Verificar si el cliente y el vendedor están en la misma ubicación
        SELECT @VendedorUbicacionID = UbicacionID
        FROM #Vendedores
        WHERE VendedorID = @VendedorID;

        IF @ClienteUbicacionID <> @VendedorUbicacionID
        BEGIN
            -- Si no están en la misma ubicación, continuar con la siguiente iteración
            CONTINUE;
        END

        -- Seleccionar un ProductoID aleatorio
        SELECT TOP 1 
            @ProductoID = ProductoID
        FROM #Productos
        ORDER BY NEWID();

        -- Generar una cantidad aleatoria entre 1 y 10
        SET @CantidadVenta = ABS(CHECKSUM(NEWID()) % 10) + 1;

        -- Obtener el precio del producto seleccionado
        SELECT @Precio = PrecioVenta FROM Productos WHERE ProductoID = @ProductoID;

        -- Calcular el monto total
        SET @MontoTotal = @CantidadVenta * @Precio;

        -- Generar un estado de venta aleatorio
        SET @EstadoVenta = CASE ABS(CHECKSUM(NEWID()) % 100)
            WHEN 0 THEN 'Cancelada'
            WHEN 1 THEN 'Pendiente'
            ELSE 'Completada'
        END;

        -- Insertar el registro en la tabla de Ventas
        INSERT INTO Ventas (Fecha, ProductoID, VendedorID, ClienteID, UbicacionID, Cantidad, MontoTotal, EstadoVenta)
        VALUES (@Fecha, @ProductoID, @VendedorID, @ClienteID, @UbicacionID, @CantidadVenta, @MontoTotal, @EstadoVenta);

        -- Eliminar el vendedor y producto usados de las tablas temporales
        DELETE FROM #Vendedores WHERE VendedorID = @VendedorID;
        DELETE FROM #Productos WHERE ProductoID = @ProductoID;

        -- Volver a llenar las tablas temporales si están vacías
        IF NOT EXISTS (SELECT 1 FROM #Vendedores)
        BEGIN
            INSERT INTO #Vendedores (VendedorID, UbicacionID, Pais, Ciudad)
            SELECT v.VendedorID, v.UbicacionID, u.Pais, u.Ciudad
            FROM Vendedores v
            JOIN Ubicaciones u ON v.UbicacionID = u.UbicacionID;
        END

        IF NOT EXISTS (SELECT 1 FROM #Productos)
        BEGIN
            INSERT INTO #Productos (ProductoID)
            SELECT ProductoID FROM Productos;
        END

        SET @i = @i + 1;
    END

    -- Limpiar las tablas temporales
    DROP TABLE #Vendedores;
    DROP TABLE #Productos;
END;
GO

-- Ejecutar el procedimiento almacenado para generar ventas aleatorias
EXEC GenerarVentasAleatorias '2019-01-01', '2024-12-31', 12000;
GO


-- Crear vista: Detalles de ventas combinando todas las tablas incluyendo imágenes, stock original y actual
CREATE OR ALTER VIEW VistaDetallesCompletos_Imagenes_Stock AS
SELECT 
    v.VentaID,
    v.Fecha,
    u.Pais,
    u.Ciudad,
    c.Nombre AS Cliente,
    ven.Nombre AS Vendedor,
    CT.Nombre AS Categoria_Producto,
    p.Nombre AS Producto,
    p.PrecioCompra AS 'Precio Compra',
    p.PrecioVenta AS 'Precio Ventas',
    v.Cantidad,
    v.MontoTotal,
    I.URL AS Foto_Producto,
	FV.Direccion_Web  AS Foto_vendedor,
    p.Stock AS Stock_Original,
    p.Stock - v.Cantidad AS Stock_Actual
FROM 
    Ventas v 
INNER JOIN 
    Clientes c ON v.ClienteID = c.ClienteID
INNER JOIN 
    Ubicaciones u ON v.UbicacionID = u.UbicacionID
INNER JOIN 
    Productos p ON v.ProductoID = p.ProductoID
INNER JOIN 
    Vendedores ven ON v.VendedorID = ven.VendedorID
INNER JOIN 
    Imagenes_Productos I ON p.ProductoID = I.ProductoID
INNER JOIN 
    Foto_vendedor FV ON FV.VendedorID = V.VendedorID
INNER JOIN 
    Categorias CT ON p.CategoriaID = CT.CategoriaID;
GO

SELECT * FROM VistaDetallesCompletos_Imagenes_Stock


CREATE OR ALTER VIEW VistaDetallesCompletos_Imagenes_Stock AS
SELECT 
    v.VentaID,
    v.Fecha,
    u.Pais,
    u.Ciudad,
    c.Nombre AS Cliente,
    ven.Nombre AS Vendedor,
    CT.Nombre AS Categoria_Producto,
    p.Nombre AS Producto,
    p.PrecioCompra AS 'Precio Compra',
    p.PrecioVenta AS 'Precio Ventas',
    v.Cantidad,
    v.MontoTotal * 57.57 AS MontoTotalEnDOP,  -- Multiplicando por el valor constante del dólar
    I.URL AS Foto_Producto,
    FV.Direccion_Web AS Foto_vendedor,
    p.Stock AS Stock_Original,
    p.Stock - v.Cantidad AS Stock_Actual
FROM 
    Ventas v 
INNER JOIN 
    Clientes c ON v.ClienteID = c.ClienteID
INNER JOIN 
    Ubicaciones u ON v.UbicacionID = u.UbicacionID
INNER JOIN 
    Productos p ON v.ProductoID = p.ProductoID
INNER JOIN 
    Vendedores ven ON v.VendedorID = ven.VendedorID
INNER JOIN 
    Imagenes_Productos I ON p.ProductoID = I.ProductoID
INNER JOIN 
    Foto_vendedor FV ON FV.VendedorID = ven.VendedorID
INNER JOIN 
    Categorias CT ON p.CategoriaID = CT.CategoriaID;
GO



-- Seleccionar todos los registros de la vista de detalles completos con imágenes
SELECT * FROM VistaDetallesCompletos_Imagenes_Stock;
GO



/*
Este script realiza un análisis ABC sobre los productos vendidos en base a su
monto total acumulado y porcentaje acumulado de ventas. 

El análisis se lleva a cabo en los siguientes pasos:

1. **VentasPorProducto**: Suma el monto total de ventas y la cantidad vendida por cada producto.
2. **VentasTotales**: Calcula el total de ventas de todos los productos.
3. **VentasConPorcentaje**: Calcula el monto total acumulado de cada producto y el porcentaje 
acumulado de ventas, que se utiliza para clasificar los productos según el modelo ABC.
4. **ProductosConInfo**: Proporciona información detallada de cada producto, incluyendo el stock
actual, la clasificación ABC y comentarios adicionales basados en la disponibilidad de stock y
la importancia del producto en las ventas.

El resultado final muestra una lista de productos ordenados por su monto total de ventas, junto 
con su clasificación ABC, estado de stock, y una descripción que sugiere acciones estratégicas para cada producto.
*/



-- Paso 1: Sumar el Monto Total y la Cantidad Vendida por Producto
WITH VentasPorProducto AS (
    SELECT 
        p.Nombre AS Producto,
        SUM(v.MontoTotal) AS Monto_Total,
        SUM(v.Cantidad) AS Cantidad_Vendida
    FROM 
        Ventas v
    JOIN 
        Productos p ON v.ProductoID = p.ProductoID
    GROUP BY 
        p.Nombre
),

-- Paso 2: Calcular el Total de Ventas
VentasTotales AS (
    SELECT 
        SUM(Monto_Total) AS Total_Ventas
    FROM 
        VentasPorProducto
),

-- Paso 3: Calcular el Monto Total Acumulado y el Porcentaje Acumulado
VentasConPorcentaje AS (
    SELECT 
        Producto,
        Monto_Total,
        Cantidad_Vendida,
        SUM(Monto_Total) OVER (ORDER BY Monto_Total DESC ROWS UNBOUNDED PRECEDING) AS Monto_Total_Acumulado,
        (SUM(Monto_Total) OVER (ORDER BY Monto_Total DESC ROWS UNBOUNDED PRECEDING) / Total_Ventas) * 100 AS Porcentaje_Acumulado
    FROM 
        VentasPorProducto, VentasTotales
),

-- Paso 4: Obtener la Información del Producto (Incluye Stock Actual)
ProductosConInfo AS (
    SELECT
        v.Producto,
        p.Stock - v.Cantidad_Vendida AS Stock_Actual,  -- Stock inicial menos la cantidad vendida
        p.Stock AS Stock_Inicial, -- Stock inicial para mostrar
        v.Monto_Total,
        v.Cantidad_Vendida,
        v.Monto_Total_Acumulado,
        v.Porcentaje_Acumulado,
        CASE
            WHEN v.Porcentaje_Acumulado <= 80 THEN 'A'
            WHEN v.Porcentaje_Acumulado <= 95 THEN 'B'
            ELSE 'C'
        END AS Clasificacion_ABC,
        CASE
            WHEN p.Stock - v.Cantidad_Vendida < 0 THEN 'Stock insuficiente'
            ELSE 'Stock adecuado'
        END AS Comentario,
        CASE
            WHEN v.Porcentaje_Acumulado <= 80 THEN 'Productos de alta rotación, representan una gran parte de las ventas. Priorizar stock y marketing.'
            WHEN v.Porcentaje_Acumulado <= 95 THEN 'Productos de rotación media, contribuyen moderadamente a las ventas. Mantener en stock y considerar promociones.'
            ELSE 'Productos de baja rotación, representan una menor parte de las ventas. Evaluar reducciones de stock o estrategias de marketing.'
        END AS Descripcion_Clasificacion
    FROM
        VentasConPorcentaje v
    JOIN
        Productos p ON v.Producto = p.Nombre
)

-- Mostrar todos los productos con su porcentaje acumulado, clasificación ABC, stock actual, comentario y descripción
SELECT 
    Producto,
    Stock_Inicial,
    Monto_Total,
    Cantidad_Vendida,
    Monto_Total_Acumulado,
    Porcentaje_Acumulado,
    Clasificacion_ABC,
    Stock_Actual,
    Comentario,
    Descripcion_Clasificacion
FROM 
    ProductosConInfo
ORDER BY 
    Monto_Total DESC;

