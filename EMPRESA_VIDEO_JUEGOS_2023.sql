-- Crear la base de datos
CREATE DATABASE EMPRESA_VIDEO_JUEGOS_2023;
GO

-- Usar la base de datos
USE EMPRESA_VIDEO_JUEGOS_2023;

-- Crear tabla Juego
CREATE TABLE Juego (
    ID_juego INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_lanzamiento DATE NOT NULL,
    clasificacion_edad VARCHAR(10) NOT NULL,
    genero VARCHAR(50) NOT NULL,
    desarrollador VARCHAR(50) NOT NULL,
    editor VARCHAR(50) NOT NULL
);

-- Crear tabla Plataforma
CREATE TABLE Plataforma (
    ID_plataforma INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fabricante VARCHAR(50) NOT NULL,
    fecha_lanzamiento DATE NOT NULL
);

-- Crear tabla Distribuidor
CREATE TABLE Distribuidor (
    ID_distribuidor INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL
);

-- Crear tabla Venta
CREATE TABLE Venta (
    ID_venta INT PRIMARY KEY,
    fecha_venta DATE NOT NULL,
    cantidad_juegos_vendidos INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    ID_juego INT,
    ID_distribuidor INT,
    FOREIGN KEY (ID_juego) REFERENCES Juego(ID_juego),
    FOREIGN KEY (ID_distribuidor) REFERENCES Distribuidor(ID_distribuidor)
);

-- Crear tabla Usuario
CREATE TABLE Usuario (
    ID_usuario INT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    pais VARCHAR(50) NOT NULL
);

-- Crear tabla Descarga
CREATE TABLE Descarga (
    ID_descarga INT PRIMARY KEY,
    fecha_descarga DATE NOT NULL,
    ID_juego INT,
    ID_usuario INT,
    FOREIGN KEY (ID_juego) REFERENCES Juego(ID_juego),
    FOREIGN KEY (ID_usuario) REFERENCES Usuario(ID_usuario)
);


-- Insertar 10 registros en la tabla Juego con nombres de juegos reales
INSERT INTO Juego (ID_juego, nombre, fecha_lanzamiento, clasificacion_edad, genero, desarrollador, editor)
VALUES (1, 'FIFA 22', '2021-10-01', 'A', 'Deportes', 'EA Sports', 'Electronic Arts'),
       (2, 'The Legend of Zelda: Breath of the Wild', '2017-03-03', 'E', 'Aventura', 'Nintendo', 'Nintendo'),
       (3, 'Call of Duty: Warzone', '2020-03-10', 'M', 'Battle Royale', 'Infinity Ward', 'Activision'),
       (4, 'Grand Theft Auto V', '2013-09-17', 'M', 'Acción', 'Rockstar North', 'Rockstar Games'),
       (5, 'Assassins Creed Valhalla', '2020-11-10', 'M', 'Acción-Aventura', 'Ubisoft Montreal', 'Ubisoft'),
       (6, 'Minecraft', '2011-11-18', 'E', 'Sandbox', 'Mojang Studios', 'Microsoft Studios'),
       (7, 'Super Smash Bros. Ultimate', '2018-12-07', 'E', 'Lucha', 'Bandai Namco Studios', 'Nintendo'),
       (8, 'Fortnite', '2017-07-25', 'T', 'Battle Royale', 'Epic Games', 'Epic Games'),
       (9, 'God of War', '2018-04-20', 'M', 'Acción-Aventura', 'Santa Monica Studio', 'Sony Interactive Entertainment'),
       (10, 'The Witcher 3: Wild Hunt', '2015-05-19', 'M', 'RPG', 'CD Projekt', 'CD Projekt');

INSERT INTO Juego (ID_juego, nombre, fecha_lanzamiento, clasificacion_edad, genero, desarrollador, editor)
VALUES (11, 'Apex Legends', '2019-02-04', 'T', 'Battle Royale', 'Respawn Entertainment', 'Electronic Arts'),
       (12, 'Final Fantasy VII Remake', '2020-04-10', 'T', 'RPG', 'Square Enix', 'Square Enix'),
       (13, 'Overwatch', '2016-05-24', 'T', 'Shooter', 'Blizzard Entertainment', 'Blizzard Entertainment'),
       (14, 'Red Dead Redemption 2', '2018-10-26', 'M', 'Acción-Aventura', 'Rockstar Games', 'Rockstar Games'),
       (15, 'Cyberpunk 2077', '2020-12-10', 'M', 'RPG', 'CD Projekt', 'CD Projekt'),
       (16, 'Halo Infinite', '2021-12-08', 'T', 'Shooter', '343 Industries', 'Xbox Game Studios'),
       (17, 'F1 2021', '2021-07-16', 'E', 'Deportes', 'Codemasters', 'Electronic Arts'),
       (18, 'Resident Evil Village', '2021-05-07', 'M', 'Survival Horror', 'Capcom', 'Capcom'),
       (19, 'Sekiro: Shadows Die Twice', '2019-03-22', 'M', 'Acción-Aventura', 'FromSoftware', 'Activision'),
       (20, 'Mass Effect Legendary Edition', '2021-05-14', 'M', 'RPG', 'BioWare', 'Electronic Arts');


-- Insertar registro 1
INSERT INTO Plataforma (ID_plataforma, nombre, fabricante, fecha_lanzamiento) 
VALUES (1, 'PlayStation 5', 'Sony', '2020-11-12');

-- Insertar registro 2
INSERT INTO Plataforma (ID_plataforma, nombre, fabricante, fecha_lanzamiento) 
VALUES (2, 'Xbox Series X', 'Microsoft', '2020-11-10');

-- Insertar registro 3
INSERT INTO Plataforma (ID_plataforma, nombre, fabricante, fecha_lanzamiento) 
VALUES (3, 'Nintendo Switch', 'Nintendo', '2017-03-03');

-- Insertar registro 4
INSERT INTO Plataforma (ID_plataforma, nombre, fabricante, fecha_lanzamiento) 
VALUES (4, 'PlayStation 4', 'Sony', '2013-11-15');

-- Insertar registro 5
INSERT INTO Plataforma (ID_plataforma, nombre, fabricante, fecha_lanzamiento) 
VALUES (5, 'Xbox One', 'Microsoft', '2013-11-22');

-- Insertar registros en la tabla Distribuidor
INSERT INTO Distribuidor (ID_distribuidor, nombre, pais, direccion) 
VALUES (1, 'Electronic Arts', 'Estados Unidos', 'Redwood City, California'),
       (2, 'Ubisoft', 'Francia', 'Montreuil, Francia'),
       (3, 'Activision Blizzard', 'Estados Unidos', 'Santa Monica, California'),
       (4, 'Sony Interactive Entertainment', 'Japón', 'Tokio, Japón'),
       (5, 'Microsoft Corporation', 'Estados Unidos', 'Redmond, Washington'),
       (6, 'Nintendo Co., Ltd.', 'Japón', 'Kioto, Japón'),
       (7, 'Take-Two Interactive Software, Inc.', 'Estados Unidos', 'Nueva York, Estados Unidos'),
       (8, 'Square Enix Holdings Co., Ltd.', 'Japón', 'Tokio, Japón'),
       (9, 'Bandai Namco Entertainment Inc.', 'Japón', 'Tokio, Japón'),
       (10, 'Capcom Co., Ltd.', 'Japón', 'Osaka, Japón');


-- Insertar 10 registros en la tabla Usuario
INSERT INTO Usuario (ID_usuario, nombre_usuario, correo_electronico, pais)
VALUES (1, 'JuanPerez', 'juan.perez@example.com', 'México'),
       (2, 'MariaGomez', 'maria.gomez@example.com', 'Argentina'),
       (3, 'CarlosSanchez', 'carlos.sanchez@example.com', 'España'),
       (4, 'AnaMartinez', 'ana.martinez@example.com', 'Colombia'),
       (5, 'PedroRodriguez', 'pedro.rodriguez@example.com', 'Chile'),
       (6, 'LauraGonzalez', 'laura.gonzalez@example.com', 'Perú'),
       (7, 'AlejandroLopez', 'alejandro.lopez@example.com', 'Brasil'),
       (8, 'IsabellaFernandez', 'isabella.fernandez@example.com', 'Estados Unidos'),
       (9, 'DiegoTorres', 'diego.torres@example.com', 'Canadá'),
       (10, 'SofiaRamirez', 'sofia.ramirez@example.com', 'Francia');

-- Insertar registros en la tabla Descarga
INSERT INTO Descarga (ID_descarga, fecha_descarga, ID_juego, ID_usuario)
VALUES (1, '2023-04-01', 1, 1),
       (2, '2023-04-02', 2, 2),
       (3, '2023-04-03', 3, 3),
       (4, '2023-04-04', 4, 4),
       (5, '2023-04-05', 5, 5),
       (6, '2023-04-06', 6, 6),
       (7, '2023-04-07', 7, 7),
       (8, '2023-04-08', 8, 8),
       (9, '2023-04-09', 9, 9),
       (10, '2023-04-10', 10, 10);

-- Insertar registros en tabla Descarga
INSERT INTO Descarga (ID_descarga, fecha_descarga, ID_juego, ID_usuario)
VALUES (11, '2022-01-01', 2, 3),
       (12, '2022-02-15', 1, 4),
       (13, '2022-03-10', 4, 5),
       (14, '2022-04-05', 3, 6),
       (15, '2022-05-20', 2, 7),
       (16, '2022-06-30', 1, 8),
       (17, '2022-07-15', 3, 9),
       (18, '2022-08-20', 4, 10),
       (19, '2022-09-05', 2, 10),
       (20, '2022-10-10', 1, 1);

SELECT * FROM DESCARGA

 -- Insertar 10 registros en la tabla Venta

-- Registro 1
INSERT INTO Venta (ID_venta, fecha_venta, cantidad_juegos_vendidos, precio_unitario, ID_juego, ID_distribuidor)
VALUES (1, '2023-04-04', 5, 49.99, 1, 1);

-- Registro 2
INSERT INTO Venta (ID_venta, fecha_venta, cantidad_juegos_vendidos, precio_unitario, ID_juego, ID_distribuidor)
VALUES (2, '2023-04-04', 3, 29.99, 2, 2);

-- Registro 3
INSERT INTO Venta (ID_venta, fecha_venta, cantidad_juegos_vendidos, precio_unitario, ID_juego, ID_distribuidor)
VALUES (3, '2023-04-04', 10, 19.99, 3, 3);

-- Registro 4
INSERT INTO Venta (ID_venta, fecha_venta, cantidad_juegos_vendidos, precio_unitario, ID_juego, ID_distribuidor)
VALUES (4, '2023-04-04', 2, 39.99, 4, 4);

-- Registro 5
INSERT INTO Venta (ID_venta, fecha_venta, cantidad_juegos_vendidos, precio_unitario, ID_juego, ID_distribuidor)
VALUES (5, '2023-04-04', 7, 24.99, 5, 5);

-- Registro 6
INSERT INTO Venta (ID_venta, fecha_venta, cantidad_juegos_vendidos, precio_unitario, ID_juego, ID_distribuidor)
VALUES (6, '2023-04-04', 4, 44.99, 6, 6);

-- Registro 7
INSERT INTO Venta (ID_venta, fecha_venta, cantidad_juegos_vendidos, precio_unitario, ID_juego, ID_distribuidor)
VALUES (7, '2023-04-04', 6, 29.99, 7, 7);

-- Registro 8
INSERT INTO Venta (ID_venta, fecha_venta, cantidad_juegos_vendidos, precio_unitario, ID_juego, ID_distribuidor)
VALUES (8, '2023-04-04', 3, 19.99, 8, 8);

-- Registro 9
INSERT INTO Venta (ID_venta, fecha_venta, cantidad_juegos_vendidos, precio_unitario, ID_juego, ID_distribuidor)
VALUES (9, '2023-04-04', 8, 34.99, 9, 9);

-- Registro 10
INSERT INTO Venta (ID_venta, fecha_venta, cantidad_juegos_vendidos, precio_unitario, ID_juego, ID_distribuidor)
VALUES (10, '2023-04-04', 1, 49.99, 10, 10);



  -- Insertar 10 registros en la tabla Venta
INSERT INTO Venta (ID_venta, fecha_venta, cantidad_juegos_vendidos, precio_unitario, ID_juego, ID_distribuidor)
VALUES
(11, '2022-01-01', 5, 39.99, 1, 2),
(12, '2022-01-02', 3, 49.99, 3, 1),
(13, '2022-01-03', 7, 29.99, 2, 3),
(14, '2022-01-04', 2, 19.99, 5, 2),
(15, '2022-01-05', 10, 59.99, 4, 3),
(16, '2022-01-06', 6, 39.99, 1, 1),
(17, '2022-01-07', 4, 29.99, 3, 2),
(18, '2022-01-08', 8, 49.99, 2, 3),
(19, '2022-01-09', 1, 9.99, 4, 1),
(20, '2022-01-10', 9, 54.99, 5, 2);

INSERT INTO Venta (ID_venta, fecha_venta, cantidad_juegos_vendidos, precio_unitario, ID_juego, ID_distribuidor)
VALUES (21, '2023-04-04', 5, 29.99, 2, 3),
       (22, '2023-04-05', 3, 19.99, 1, 2),
       (23, '2023-04-06', 10, 39.99, 5, 1),
       (24, '2023-04-07', 8, 24.99, 3, 3),
       (25, '2023-04-08', 4, 14.99, 4, 2),
       (26, '2023-04-09', 6, 34.99, 6, 1),
       (27, '2023-04-10', 2, 9.99, 7, 3),
       (28, '2023-04-11', 7, 29.99, 8, 2),
       (29, '2023-04-12', 9, 19.99, 9, 1),
       (30, '2023-04-13', 3, 24.99, 10, 3);

-- Insertar 10 registros ficticios en la tabla Venta a partir del ID_venta 21

INSERT INTO Venta (ID_venta, fecha_venta, cantidad_juegos_vendidos, precio_unitario, ID_juego, ID_distribuidor)
VALUES (31, '2023-04-01', 5, 49.99, 1, 1),
       (32, '2023-04-02', 3, 39.99, 2, 2),
       (33, '2023-04-03', 2, 29.99, 3, 3),
       (34, '2023-04-04', 1, 19.99, 4, 4),
       (35, '2023-04-05', 4, 59.99, 5, 5),
       (36, '2023-04-06', 6, 79.99, 6, 6),
       (37, '2023-04-07', 3, 39.99, 7, 7),
       (38, '2023-04-08', 2, 29.99, 8, 8),
       (39, '2023-04-09', 5, 49.99, 9, 9),
       (40, '2023-04-10', 1, 19.99, 10, 10);




BEGIN TRANSACTION;
COMMIT;


--16 consultas básicas que podrías realizar en la base de datos, utilizando diferentes funciones y cláusulas:

--1-Consulta para obtener todos los juegos de la tabla "Juego":

SELECT *
FROM Juego;

--2-Consulta para obtener los nombres de los juegos y su clasificación de edad de la tabla "Juego":

SELECT nombre, clasificacion_edad
FROM Juego;

--3-Consulta para obtener los nombres de los juegos y sus fechas de lanzamiento, ordenados por fecha de lanzamiento de forma ascendente, de la tabla "Juego":

SELECT nombre, fecha_lanzamiento
FROM Juego
ORDER BY fecha_lanzamiento ASC;

--4-Consulta para obtener la cantidad total de juegos vendidos en la tabla "Venta":

SELECT SUM(cantidad_juegos_vendidos) as total_juegos_vendidos
FROM Venta;

--5-Consulta para obtener el promedio de precio unitario de los juegos vendidos en la tabla "Venta":

SELECT AVG(precio_unitario) as promedio_precio_unitario
FROM Venta;

--6-Consulta para obtener la cantidad de juegos vendidos por distribuidor, ordenados por cantidad de juegos vendidos de forma descendente:

SELECT ID_distribuidor, SUM(cantidad_juegos_vendidos) as total_juegos_vendidos
FROM Venta
GROUP BY ID_distribuidor
ORDER BY total_juegos_vendidos DESC;

--7-Consulta para obtener los juegos vendidos en una fecha específica de la tabla "Venta":

SELECT *
FROM Venta
WHERE fecha_venta = '2023-04-04';

--8-Consulta para obtener los juegos vendidos por un distribuidor específico en la tabla "Venta":

SELECT *
FROM Venta
WHERE ID_distribuidor = 3;

--9-Consulta para obtener los juegos vendidos por un distribuidor específico y en una fecha específica de la tabla "Venta":

SELECT *
FROM Venta
WHERE ID_distribuidor = 3 AND fecha_venta = '2023-04-03';

--10-Consulta para obtener los juegos descargados por un usuario específico en la tabla "Descarga":

SELECT *
FROM Descarga
WHERE ID_usuario = 1;

--11-Consulta para obtener los juegos descargados por un usuario específico en una fecha específica de la tabla "Descarga":

SELECT *
FROM Descarga
WHERE ID_usuario = 1 AND fecha_descarga = '2022-10-10';

--12-Consulta para obtener los juegos descargados por un usuario específico y que pertenezcan a un género específico en la tabla "Descarga":

SELECT *
FROM Descarga
JOIN Juego ON Descarga.ID_juego = Juego.ID_juego
WHERE genero = 'Aventura' AND ID_usuario = 10

SELECT * FROM  Juego

--13-Consulta para obtener la diferencia en días entre la fecha de lanzamiento y la fecha de descarga de los juegos en la tabla "Descarga":

SELECT d.ID_juego, J.nombre, DATEDIFF(DAY, j.fecha_lanzamiento, d.fecha_descarga) as diferencia_dias
FROM Descarga d
JOIN Juego j ON d.ID_juego = j.ID_juego;


--14-Consulta que muestra el promedio de precio unitario de los juegos vendidos por distribuidor:

SELECT d.nombre AS 'Nombre del Distribuidor', AVG(v.precio_unitario) AS 'Promedio de Precio Unitario'
FROM Venta v
JOIN Distribuidor d ON v.ID_distribuidor = d.ID_distribuidor
GROUP BY d.nombre;

--15-Consulta que muestra el total de juegos vendidos y el ingreso total generado por cada distribuidor:

SELECT d.nombre AS 'Nombre del Distribuidor', SUM(v.cantidad_juegos_vendidos) AS 'Total de Juegos Vendidos', SUM(v.cantidad_juegos_vendidos * v.precio_unitario) AS 'Ingreso Total'
FROM Venta v
JOIN Distribuidor d ON v.ID_distribuidor = d.ID_distribuidor
GROUP BY d.nombre;

/*Estas consultas utilizan funciones de agregación como AVG y SUM para calcular promedios y sumas 
de valores, así como JOIN para combinar datos de diferentes tablas y GROUP BY para agrupar los resultados 
por distribuidor. También se utilizan alias para mejorar la legibilidad de los resultados.

*/

-- 16-Consulta para obtener la cantidad de juegos vendidos por distribuidor y su posición de ranking, ordenados por  
-- nombre de distribuidor y cantidad de juegos vendidos:

SELECT d.nombre AS 'Nombre Distribuidor', SUM(v.cantidad_juegos_vendidos) AS 'Cantidad Juegos Vendidos', 
       RANK() OVER (ORDER BY SUM(v.cantidad_juegos_vendidos) DESC) AS [Ranking]
FROM Venta v
INNER JOIN Distribuidor d ON v.ID_distribuidor = d.ID_distribuidor
GROUP BY d.nombre
ORDER BY [Ranking] ASC;
