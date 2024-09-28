-- Crear una Base de Datos
CREATE DATABASE SUPERMERCADO_JPV_V4;
GO

-- Usar la Base de Datos
USE SUPERMERCADO_JPV_V4;
GO

-- Crear la tabla PROVINCIAS
CREATE TABLE PROVINCIAS (
    id_provincia INT PRIMARY KEY,
    nombreProvincia VARCHAR(100),
    id_region INT,
    latitud DECIMAL(10, 7),
    longitud DECIMAL(10, 7)
);
GO



-- Crear la tabla Genero
CREATE TABLE Genero (
    ID_Genero INT PRIMARY KEY,
    Genero VARCHAR(50)
);
GO
-- Crear la tabla VENDEDOR
CREATE TABLE VENDEDOR (
    ID_VENDEDOR INT PRIMARY KEY,
    VENDEDOR VARCHAR(100),
    id_genero INT, -- Cambiado a INT para relacionar con la tabla Genero
    SUCURSAL VARCHAR(100),
    PROVINCIA INT,
    CONSTRAINT FK_VENDEDOR_GENERO FOREIGN KEY (id_genero) REFERENCES Genero(ID_Genero),
    CONSTRAINT FK_VENDEDOR_PROVINCIAS FOREIGN KEY (PROVINCIA) REFERENCES PROVINCIAS(id_provincia)
);
GO


-- Crear la tabla FOTOS_VENDEDOR
CREATE TABLE FOTOS_VENDEDOR (
    ID_Foto INT PRIMARY KEY,
    foto_Vendedor_url VARCHAR(255),
    ID_vendedor INT,
    CONSTRAINT FK_FOTOS_VENDEDOR_VENDEDOR FOREIGN KEY (ID_vendedor) REFERENCES VENDEDOR(ID_VENDEDOR)
);
GO

-- Crear la tabla PRODUCTO
CREATE TABLE PRODUCTO (
    ID_PRODUCTO INT PRIMARY KEY,
    PRODUCTO VARCHAR(100),
    STOCK INT,
    PRECIO_COMPRA DECIMAL(10, 2),
    PRECIO_VENTA DECIMAL(10, 2)  -- Corregido: Cambiado de PRECIO_VENTAS a PRECIO_VENTA
);
GO

-- Crear la tabla FOTO_PRODUCTOS
CREATE TABLE FOTO_PRODUCTOS (
    ID_Foto INT PRIMARY KEY,
    foto_Productos_url VARCHAR(255),
    ID_PRODUCTO INT,
    CONSTRAINT FK_FOTO_PRODUCTOS_PRODUCTO FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO(ID_PRODUCTO)
);
GO


-- Crear la tabla REGION
CREATE TABLE REGION (
    ID_REGION INT PRIMARY KEY,
    REGION VARCHAR(50) UNIQUE -- Asegura que el nombre de la región sea único
);



select * from PROVINCIAS

-- Crear la tabla CLIENTE
CREATE TABLE CLIENTE (
    ID_CLIENTE INT PRIMARY KEY,
    NOMBRE_CLIENTE VARCHAR(100),
    APELLIDO_CLIENTE VARCHAR(100),
    id_region INT,
    id_provincia INT,
    CONSTRAINT FK_CLIENTE_PROVINCIAS FOREIGN KEY (id_provincia) REFERENCES PROVINCIAS(id_provincia),
    CONSTRAINT FK_CLIENTE_REGION FOREIGN KEY (id_region) REFERENCES REGION(ID_REGION) -- Asumiendo que REGION es una tabla que debería existir
);
GO

-- Seleccionar todos los registros de la tabla CLIENTE
SELECT * FROM CLIENTE;
GO


-- Crear la tabla VENTAS
CREATE TABLE VENTAS (
    FECHA DATE,
    ID_PEDIDO INT PRIMARY KEY,
    ID_CLIENTE VARCHAR(10), -- Cambiado a VARCHAR para aceptar 'C-10001' como ID de cliente
    ID_VENDEDOR VARCHAR(10), -- Cambiado a VARCHAR para aceptar 'VD-10001' como ID de vendedor
    ID_REGION INT,
    ID_PRODUCTO INT,
    CANTIDAD INT,
    PRECIO DECIMAL(10, 2),
    TOTAL DECIMAL(10, 2),
    CONSTRAINT FK_VENTAS_CLIENTE FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE),
    CONSTRAINT FK_VENTAS_VENDEDOR FOREIGN KEY (ID_VENDEDOR) REFERENCES VENDEDOR(ID_VENDEDOR),
    CONSTRAINT FK_VENTAS_REGION FOREIGN KEY (ID_REGION) REFERENCES REGION(ID_REGION), -- Ajustar si la tabla REGION está definida
    CONSTRAINT FK_VENTAS_PRODUCTO FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO(ID_PRODUCTO)
);





-- Insertar datos en la tabla REGION
INSERT INTO REGION (ID_REGION, REGION) VALUES
(1, 'NORTE'),
(2, 'SUR'),
(3, 'ESTE'),
(4, 'OESTE');

--ver latabla y sus registros:

select * from REGION

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

--ver latabla y sus registros:

select * from PROVINCIAS


--insertar 30 registros a la tabla de Cliente
INSERT INTO CLIENTE (ID_CLIENTE, NOMBRE_CLIENTE, APELLIDO_CLIENTE, id_region, id_provincia) VALUES
(1, 'Alejandro', 'Perez', 1, 1),
(2, 'María', 'Vizcaino', 2, 1),
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

--ver latabla y sus registros:

select * from CLIENTE


-- Insertar los géneros
INSERT INTO Genero (ID_Genero, Genero) VALUES
(1, 'Masculino'),
(2, 'Femenino'),
(3, 'Otros');

--ver latabla y sus registros:

select * from Genero


-- Insertar los vendedores
INSERT INTO VENDEDOR (ID_VENDEDOR, VENDEDOR, GENERO, SUCURSAL, PROVINCIA) VALUES
(1, 'Juan Perez', 'M', 'Sucursal A', 1),
(2, 'Maria Vizcaino', 'F', 'Sucursal B', 2),
(3, 'Ana Santana', 'F', 'Sucursal C', 1),
(4, 'Luis Diaz', 'M', 'Sucursal D', 2),
(5, 'Sofia Bergara', 'F', 'Sucursal A', 3),
(6, 'Jorge Ramos', 'M', 'Sucursal B', 1),
(7, 'Juan Comila', 'M', 'Sucursal C', 2),
(8, 'Juan Gabrie', 'M', 'Sucursal D', 3),
(9, 'Carlos Santos', 'M', 'Sucursal A', 1);


--ver latabla y sus registros:

select * from VENDEDOR




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

--ver latabla y sus registros:

select * from PRODUCTO


-- Insertar datos en la tabla FOTO_PRODUCTOS
INSERT INTO FOTO_PRODUCTOS (ID_Foto, foto_Productos_url, ID_PRODUCTO) VALUES
(1, 'https://png.pngtree.com/png-vector/20240206/ourmid/pngtree-gallon-of-milk-isolated-on-white-drink-cutout-lactosefresh-png-image_11635524.png', 1),
(2, 'https://hslegumbres.com.ar/wp-content/uploads/2019/09/legumbres-min.png', 2),
(3, 'https://png.pngtree.com/png-clipart/20231122/original/pngtree-group-of-fresh-fruits-many-photo-png-image_13690072.png', 3),
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

--ver latabla y sus registros:

select * from FOTO_PRODUCTOS
select * from VENDEDOR

-- Insertar datos en la tabla FOTOS_VENDEDOR
INSERT INTO FOTOS_VENDEDOR (ID_Foto, foto_Vendedor_url, ID_vendedor) VALUES
(1, 'https://dl.dropbox.com/s/4bz1xriny7ro04g/A40.png', '1'),
(2, 'https://dl.dropbox.com/s/yxe96df3xrzoc4y/A44.png', '2'),
(3, 'https://dl.dropboxusercontent.com/s/2lks10yyiurw2b0/A33.png', '3'),
(4, 'https://dl.dropbox.com/s/zgx7g0h0mxubhao/A21.png', '4'),
(5, 'https://dl.dropboxusercontent.com/s/id0gj57k6z3m73q/A34.png', '5'),
(6, 'https://dl.dropbox.com/s/1f9hzgblcmuen4a/A10.png', '6'),
(7, 'https://dl.dropbox.com/s/jveyj0btov87izo/A38.png', '7'),
(8, 'https://dl.dropbox.com/s/z4geyw1u2psmm47/A16.png', '8'),
(9, 'https://dl.dropbox.com/s/4bz1xriny7ro04g/A40.png', '9'),
(10, 'https://dl.dropbox.com/s/z4geyw1u2psmm47/A16.png', '10'),
(11, 'https://dl.dropbox.com/s/4bz1xriny7ro04g/A40.png', '11'),
(12, 'https://dl.dropbox.com/s/yxe96df3xrzoc4y/A44.png', '12'),
(13, 'https://dl.dropbox.com/s/0jkab8w6ie0h91z/A42.png', '13'),
(14, 'https://dl.dropboxusercontent.com/s/2lks10yyiurw2b0/A33.png', '14'),
(15, 'https://dl.dropboxusercontent.com/s/id0gj57k6z3m73q/A34.png', '15');


--ver latabla y sus registros:

select * from FOTOS_VENDEDOR


-- Insert data into VENTAS table
INSERT INTO VENTAS (FECHA, ID_PEDIDO, ID_CLIENTE, ID_VENDEDOR, ID_REGION, ID_PRODUCTO, CANTIDAD, PRECIO, TOTAL) VALUES
('2020-01-03', 1, 'C-10001', 'VD-10001', 1, -10001, 90, 40, 2700),
('2020-01-03', 2, 'C-10002', 'VD-10002', 1, -10002, 36, 65, 1800),
('2020-01-09', 3, 'C-10003', 'VD-10003', 1, -10003, 13, 55, 520),
('2020-01-10', 4, 'C-10004', 'VD-10004', 1, -10004, 71, 45, 2485),
('2020-01-17', 5, 'C-10005', 'VD-10005', 1, -10005, 48, 120, 4800);


--ver latabla y sus registros:

select * from VENTAS


-- Insertar datos aleatorios en la tabla VENTAS
INSERT INTO VENTAS (FECHA, ID_PEDIDO, ID_CLIENTE, ID_VENDEDOR, ID_REGION, ID_PRODUCTO, CANTIDAD, PRECIO, TOTAL)
SELECT 
    DATEADD(day, -FLOOR(RAND() * 730), GETDATE()) as FECHA, -- FECHA aleatoria en los últimos dos años
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as ID_PEDIDO, -- ID_PEDIDO secuencial
    'C-' + CAST(10000 + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as VARCHAR(10)) as ID_CLIENTE, -- ID_CLIENTE como 'C-1000X'
    'VD-' + CAST(10000 + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as VARCHAR(10)) as ID_VENDEDOR, -- ID_VENDEDOR como 'VD-1000X'
    1 as ID_REGION, -- ID_REGION fijo en 1
    -10000 + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as ID_PRODUCTO, -- ID_PRODUCTO como -10000 + secuencial
    FLOOR(RAND() * 100) + 1 as CANTIDAD, -- CANTIDAD aleatoria entre 1 y 100
    FLOOR(RAND() * 100) + 50 as PRECIO, -- PRECIO aleatorio entre 50 y 149
    (FLOOR(RAND() * 50) + 1) * (FLOOR(RAND() * 10) + 1) * 10 as TOTAL -- TOTAL calculado aleatoriamente
FROM 
    sys.objects a, sys.objects b; -- Tablas ficticias para la generación de datos

