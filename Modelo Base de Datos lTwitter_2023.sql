--zCrear una Base de Datos:
CREATE DATABASE Tweets_2023;
GO

--Usar la Base de Datos:
USE Tweets_2023;

-- Crear tabla Usuarios
CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    fecha_creacion DATE NOT NULL,
    descripcion VARCHAR(200)
);

-- Crear tabla Tweets
CREATE TABLE Tweets (
    id_tweet INT PRIMARY KEY,
    contenido VARCHAR(280) NOT NULL,
    fecha_creacion DATE NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- Crear tabla Retweets
CREATE TABLE Retweets (
    id_retweet INT PRIMARY KEY,
    id_tweet_original INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_creacion DATE NOT NULL,
    FOREIGN KEY (id_tweet_original) REFERENCES Tweets(id_tweet),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- Crear tabla Hashtags
CREATE TABLE Hashtags (
id_hashtag INT PRIMARY KEY,
nombre_hashtag VARCHAR(50) NOT NULL,
id_usuario INT NOT NULL,
FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

-- Crear tabla Menciones
CREATE TABLE Menciones (
    id_mencion INT PRIMARY KEY,
    id_usuario_mencionado INT NOT NULL,
    id_tweet INT NOT NULL,
    FOREIGN KEY (id_usuario_mencionado) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_tweet) REFERENCES Tweets(id_tweet)
);

-- Crear tabla Seguidores
CREATE TABLE Seguidores (
    id_seguidor INT PRIMARY KEY,
    id_usuario_seguidor INT NOT NULL,
    id_usuario_seguido INT NOT NULL,
    fecha_creacion DATE NOT NULL,
    FOREIGN KEY (id_usuario_seguidor) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_usuario_seguido) REFERENCES Usuarios(id_usuario)
);


--VAMOS A PROBAR INSERTAR REGISTROS EN LAS TABLAS:

-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (id_usuario, nombre_usuario, correo_electronico, fecha_creacion, descripcion)
VALUES
(1, 'JuanPerez', 'juanperez@example.com', '2022-01-01', 'Amante de la tecnología y los deportes'),
(2, 'MariaGarcia', 'mariagarcia@example.com', '2022-01-02', 'Apasionada por la música y los viajes'),
(3, 'PedroDiaz', 'pedrodiaz@example.com', '2022-01-03', 'Fanático de la literatura y la gastronomía'),
(4, 'LauraMartinez', 'lauramartinez@example.com', '2022-01-04', 'Interesada en el cine y la moda'),
(5, 'RobertoSanchez', 'robertosanchez@example.com', '2022-01-05', 'Amante de la fotografía y el arte');

-- Insertar datos en la tabla Tweets
INSERT INTO Tweets (id_tweet, contenido, fecha_creacion, id_usuario)
VALUES
(1, 'Mi primer tweet', '2022-01-01', 1),
(2, 'Hoy es un gran día', '2022-01-02', 2),
(3, 'Estoy emocionado por mi próximo viaje', '2022-01-03', 3),
(4, 'Me encanta la nueva película de terror', '2022-01-04', 4),
(5, 'Una obra de arte increíble en la galería de arte', '2022-01-05', 5);

-- Insertar datos en la tabla Retweets
INSERT INTO Retweets (id_retweet, id_tweet_original, id_usuario, fecha_creacion)
VALUES
(1, 3, 2, '2022-01-01'),
(2, 5, 1, '2022-01-02'),
(3, 2, 5, '2022-01-03'),
(4, 1, 4, '2022-01-04'),
(5, 4, 3, '2022-01-05');

-- Insertar datos en la tabla Hashtags
INSERT INTO Hashtags (id_hashtag, nombre_hashtag, id_usuario)
VALUES
(1, 'Tecnología', 1),
(2, 'Música', 2),
(3, 'Viajes', 3),
(4, 'Cine', 4),
(5, 'Arte', 5);

-- Insertar datos en la tabla Menciones
INSERT INTO Menciones (id_mencion, id_usuario_mencionado, id_tweet)
VALUES
(1, 2, 1),
(2, 3, 2),
(3, 4, 3),
(4, 5, 4),
(5, 1, 5);

-- Insertar datos en la tabla Seguidores
INSERT INTO Seguidores (id_seguidor, id_usuario_seguidor, id_usuario_seguido, fecha_creacion)
VALUES
(1, 2, 1, '2022-01-01'),
(2, 3, 1, '2022-01-02'),
(3, 4, 1, '2022-01-03'),
(4, 5, 1, '2022-01-04'),
(5, 1, 2, '2022-01-05'),
(6, 1, 3, '2022-01-06'),
(7, 1, 4, '2022-01-07'),
(8, 1, 5, '2022-01-08');

 
-- Verificar datos insertados en la tabla Usuarios
SELECT * FROM Usuarios;

-- Verificar datos insertados en la tabla Tweets
SELECT * FROM Tweets;

-- Verificar datos insertados en la tabla Retweets
SELECT * FROM Retweets;

-- Verificar datos insertados en la tabla Hashtags
SELECT * FROM Hashtags;

-- Verificar datos insertados en la tabla Menciones
SELECT * FROM Menciones;

-- Verificar datos insertados en la tabla Seguidores
SELECT * FROM Seguidores;


--VAMOS A PROBAR INSERTAR MAS REGISTROS:

-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (id_usuario, nombre_usuario, correo_electronico, fecha_creacion, descripcion)
VALUES
(6, 'AnaCastro', 'anacastro@example.com', '2022-01-06', 'Aficionada al deporte y la comida saludable'),
(7, 'DiegoRamirez', 'diegoramirez@example.com', '2022-01-07', 'Amante de la música clásica y el cine independiente'),
(8, 'SofiaGutierrez', 'sofiagutierrez@example.com', '2022-01-08', 'Apasionada por la moda y el diseño de interiores'),
(9, 'ManuelFernandez', 'manuelfernandez@example.com', '2022-01-09', 'Fanático de la literatura y el teatro'),
(10, 'CarlaRodriguez', 'carlarodriguez@example.com', '2022-01-10', 'Interesada en la fotografía y el arte moderno');

-- Insertar datos en la tabla Tweets
INSERT INTO Tweets (id_tweet, contenido, fecha_creacion, id_usuario)
VALUES
(6, 'Comenzando mi día con energía', '2022-01-06', 6),
(7, 'Acabo de descubrir un nuevo restaurante', '2022-01-07', 7),
(8, 'Planeando mi próximo viaje', '2022-01-08', 8),
(9, '¿Alguien quiere ver una película esta noche?', '2022-01-09', 9),
(10, '¡Qué hermosa exposición de arte!', '2022-01-10', 10);

-- Insertar datos en la tabla Retweets
INSERT INTO Retweets (id_retweet, id_tweet_original, id_usuario, fecha_creacion)
VALUES
(6, 7, 6, '2022-01-06'),
(7, 10, 7, '2022-01-07'),
(8, 9, 8, '2022-01-08'),
(9, 6, 9, '2022-01-09'),
(10, 8, 10, '2022-01-10');

-- Insertar datos en la tabla Hashtags
INSERT INTO Hashtags (id_hashtag, nombre_hashtag, id_usuario)
VALUES
(6, 'Deporte', 6),
(7, 'Comida', 7),
(8, 'Turismo', 8),
(9, 'Cineindependiente', 7),
(10, 'Diseñodeinteriores', 8);

-- Insertar datos en la tabla Menciones
INSERT INTO Menciones (id_mencion, id_usuario_mencionado, id_tweet)
VALUES
(6, 5, 6),
(7, 4, 7),
(8, 3, 8),
(9, 2, 9),
(10, 1, 10);

-- Insertar datos en la tabla Seguidores
INSERT INTO Seguidores (id_seguidor, id_usuario_seguidor, id_usuario_seguido, fecha_creacion)
VALUES
(9, 1, 9, '2022-01-09'),
(10, 2, 10, '2022-01-10'),
(11, 3, 6, '2022-01-11'),
(12, 4, 8, '2022-01-12'),
(13, 5, 7, '2022-01-13');

 --VAMOS A VET DODOS LOS REGISTROS INSERTAMOS:

--Seleccionar todos los usuarios de la tabla Usuarios:

SELECT * FROM Usuarios;

--Seleccionar los nombres de todos los usuarios de la tabla Usuarios:

SELECT nombre_usuario FROM Usuarios;

--Seleccionar los tweets y su contenido de la tabla Tweets:

SELECT id_tweet, contenido FROM Tweets;

--Seleccionar todos los retweets de la tabla Retweets:

SELECT * FROM Retweets;

--Seleccionar los hashtags y su nombre de la tabla Hashtags:

SELECT id_hashtag, nombre_hashtag FROM Hashtags;

--Seleccionar las menciones y su id_usuario_mencionado de la tabla Menciones:

SELECT id_mencion, id_usuario_mencionado FROM Menciones;

--Seleccionar todos los seguidores de la tabla Seguidores:

SELECT * FROM Seguidores;

--Seleccionar los usuarios que se han registrado después del 2022-01-08 de la tabla Usuarios:

SELECT * FROM Usuarios WHERE fecha_creacion > '2022-01-08';

--Seleccionar los tweets de los usuarios con id_usuario 6 y 7 de la tabla Tweets:

SELECT * FROM Tweets WHERE id_usuario IN (6,7);

--Seleccionar los retweets de los usuarios con id_usuario 8 y 9 de la tabla Retweets:

SELECT * FROM Retweets WHERE id_usuario IN (8,9);

--Seleccionar los hashtags de los usuarios con id_usuario 10 y que contengan la palabra "arte" en el nombre de la tabla Hashtags:

SELECT * FROM Hashtags WHERE id_usuario = 10 AND nombre_hashtag LIKE '%arte%';

--Seleccionar los tweets que contengan la palabra "viaje" o "película" en su contenido de la tabla Tweets:

SELECT * FROM Tweets WHERE contenido LIKE '%viaje%' OR contenido LIKE '%película%';

--Seleccionar la cantidad de menciones por tweet de la tabla Menciones:

SELECT id_tweet, COUNT(id_mencion) AS cantidad_menciones FROM Menciones GROUP BY id_tweet;

--Seleccionar el nombre del usuario que tiene más seguidores de la tabla Seguidores:

SELECT TOP 1 u.nombre_usuario, COUNT(s.id_seguidor) AS cantidad_seguidores 
FROM Seguidores s
JOIN Usuarios u ON s.id_usuario_seguido = u.id_usuario 
GROUP BY u.nombre_usuario 
ORDER BY cantidad_seguidores DESC;

--Seleccionar el contenido del tweet más reciente de cada usuario de la tabla Tweets:

SELECT t.contenido, t.fecha_creacion, u.nombre_usuario 
FROM Usuarios u 
JOIN Tweets t ON u.id_usuario = t.id_usuario 
WHERE t.fecha_creacion = (SELECT MAX(t2.fecha_creacion) FROM Tweets t2)


--VAMOS A PROBAR INSERTAR MAS REGISTROS:

-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (id_usuario, nombre_usuario, correo_electronico, fecha_creacion, descripcion)
VALUES
(11, 'PedroLopez', 'pedrolopez@example.com', '2022-01-11', 'Fanático de los videojuegos y la tecnología'),
(12, 'LauraHernandez', 'laurahernandez@example.com', '2022-01-12', 'Interesada en la moda y la belleza'),
(13, 'MarioGarcia', 'mariogarcia@example.com', '2022-01-13', 'Amante de los deportes extremos y la aventura'),
(14, 'PaolaRuiz', 'paolaruiz@example.com', '2022-01-14', 'Apasionada por la literatura y la música indie'),
(15, 'JorgeCastillo', 'jorgecastillo@example.com', '2022-01-15', 'Interesado en la política y la economía');

-- Insertar datos en la tabla Tweets
INSERT INTO Tweets (id_tweet, contenido, fecha_creacion, id_usuario)
VALUES
(11, 'Haciendo ejercicio en el parque', '2022-01-11', 11),
(12, '¡Qué delicioso almuerzo!', '2022-01-12', 12),
(13, 'Saltando en paracaídas', '2022-01-13', 13),
(14, 'Leyendo mi libro favorito', '2022-01-14', 14),
(15, 'Analizando los resultados electorales', '2022-01-15', 15);

-- Insertar datos en la tabla Retweets
INSERT INTO Retweets (id_retweet, id_tweet_original, id_usuario, fecha_creacion)
VALUES
(11, 12, 11, '2022-01-11'),
(12, 15, 12, '2022-01-12'),
(13, 11, 13, '2022-01-13'),
(14, 14, 14, '2022-01-14'),
(15, 13, 15, '2022-01-15');

-- Insertar datos en la tabla Hashtags
INSERT INTO Hashtags (id_hashtag, nombre_hashtag, id_usuario)
VALUES
(11, 'Fitness', 11),
(12, 'ComidaSaludable', 12),
(13, 'DeportesExtremos', 13),
(14, 'Literatura', 14),
(15, 'Política', 15);

-- Insertar datos en la tabla Menciones
INSERT INTO Menciones (id_mencion, id_usuario_mencionado, id_tweet)
VALUES
(11, 9, 11),
(12, 10, 12),
(13, 11, 13),
(14, 12, 14),
(15, 13, 15);

-- Insertar datos en la tabla Seguidores
INSERT INTO Seguidores (id_seguidor, id_usuario_seguidor, id_usuario_seguido, fecha_creacion)
VALUES
(14, 1, 13, '2022-01-14'),
(15, 2, 14, '2022-01-15'),
(16, 3, 11, '2022-01-16'),
(17, 4, 15, '2022-01-17'),
(18, 5, 12, '2022-01-18'),
(19, 6, 11, '2022-01-19'),
(20, 7, 15, '2022-01-20'),
(21, 8, 13, '2022-01-21'),
(22, 9, 14, '2022-01-22'),
(23, 10, 12, '2022-01-23');

--INSERTEMOS DATOS AHORA DEL 2023:


-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (id_usuario, nombre_usuario, correo_electronico, fecha_creacion, descripcion)
VALUES
(16, 'CarolinaMartinez', 'carolinamartinez@example.com', '2023-01-01', 'Amante de los animales y la naturaleza'),
(17, 'LuisGonzalez', 'luisgonzalez@example.com', '2023-02-10', 'Interesado en la tecnología y los videojuegos'),
(18, 'AnaJimenez', 'anajimenez@example.com', '2023-03-15', 'Apasionada por el arte y la cultura'),
(19, 'JuanPerez', 'juanperez@example.com', '2023-04-20', 'Fanático del deporte y la nutrición'),
(20, 'MariaGomez', 'mariagomez@example.com', '2023-04-25', 'Interesada en la moda y la belleza');

-- Insertar datos en la tabla Tweets
INSERT INTO Tweets (id_tweet, contenido, fecha_creacion, id_usuario)
VALUES
(16, 'Disfrutando del sol en la playa', '2023-01-02', 16),
(17, 'Jugando el nuevo juego de rol', '2023-02-12', 17),
(18, 'Visitando una exposición de arte contemporáneo', '2023-03-20', 18),
(19, 'Entrenando en el gimnasio', '2023-04-22', 19),
(20, 'Descubriendo nuevas tendencias de maquillaje', '2023-04-30', 20);

-- Insertar datos en la tabla Retweets
INSERT INTO Retweets (id_retweet, id_tweet_original, id_usuario, fecha_creacion)
VALUES
(16, 17, 16, '2023-01-05'),
(17, 20, 17, '2023-02-15'),
(18, 18, 18, '2023-03-25'),
(19, 19, 19, '2023-04-23'),
(20, 16, 20, '2023-04-30');

-- Insertar datos en la tabla Hashtags
INSERT INTO Hashtags (id_hashtag, nombre_hashtag, id_usuario)
VALUES
(16, 'Playa', 16),
(17, 'Videojuegos', 17),
(18, 'ArteContemporáneo', 18),
(19, 'Fitness', 19),
(20, 'Maquillaje', 20);

-- Insertar datos en la tabla Menciones
INSERT INTO Menciones (id_mencion, id_usuario_mencionado, id_tweet)
VALUES
(16, 15, 16),
(17, 14, 17),
(18, 13, 18),
(19, 12, 19),
(20, 11, 20);

-- Insertar datos en la tabla Seguidores
INSERT INTO Seguidores (id_seguidor, id_usuario_seguidor, id_usuario_seguido, fecha_creacion)
VALUES
(24, 1, 16, '2023-01-03'),
(25, 2, 17, '2023-02-11'),
(26, 3, 18, '2023-03-16'),
(27, 4, 19, '2023-04-21'),
(28, 5, 20, '2023-04-26'),
(29, 6, 16, '2023-01-07'),
(30, 7, 17, '2023-02-12'),
(31, 8, 18, '2023-03-17'),
(32, 9, 19, '2023-04-22'),
(33, 10, 20, '2023-04-27');

--INSERTAMOS 10 REGISTROS MAS:

-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (id_usuario, nombre_usuario, correo_electronico, fecha_creacion, descripcion)
VALUES
(21, 'GabrielaSanchez', 'gabrielasanchez@example.com', '2023-05-01', 'Amante de los viajes y la gastronomía'),
(22, 'AndresRojas', 'andresrojas@example.com', '2023-05-15', 'Interesado en el cine y la literatura'),
(23, 'CarlaGarcia', 'carlagarcia@example.com', '2023-06-01', 'Apasionada por la moda y el diseño'),
(24, 'DanielRuiz', 'danielruiz@example.com', '2023-06-15', 'Fanático del deporte y la vida saludable'),
(25, 'MartaLopez', 'martalopez@example.com', '2023-06-30', 'Interesada en la tecnología y la programación'),
(26, 'AnaRamirez', 'anaramirez@example.com', '2023-05-03', 'Amante del arte y la cultura'),
(27, 'LuisaFernandez', 'luisafernandez@example.com', '2023-05-17', 'Interesada en la fotografía y el diseño gráfico'),
(28, 'MarioPerez', 'marioperez@example.com', '2023-06-02', 'Apasionado por la música y los conciertos'),
(29, 'JuliaGonzalez', 'juliagonzalez@example.com', '2023-06-16', 'Fanática de la literatura y el cine'),
(30, 'CarlosMartinez', 'carlosmartinez@example.com', '2023-06-30', 'Interesado en la política y los debates');

-- Insertar datos en la tabla Tweets
INSERT INTO Tweets (id_tweet, contenido, fecha_creacion, id_usuario)
VALUES
(21, 'Comiendo en el mejor restaurante de la ciudad', '2023-05-05', 21),
(22, 'Viendo una película clásica', '2023-05-20', 22),
(23, 'Diseñando mi nueva colección de moda', '2023-06-05', 23),
(24, 'Entrenando en el parque', '2023-06-15', 24),
(25, 'Programando mi nueva app', '2023-06-30', 25),
(26, 'Visitando una exposición de arte', '2023-05-10', 26),
(27, 'Tomando fotos en el parque', '2023-05-22', 27),
(28, 'Asistiendo a un concierto en vivo', '2023-06-07', 28),
(29, 'Leyendo mi libro favorito', '2023-06-16', 29),
(30, 'Siguiendo el debate presidencial', '2023-06-30', 30);

-- Insertar datos en la tabla Retweets
INSERT INTO Retweets (id_retweet, id_tweet_original, id_usuario, fecha_creacion)
VALUES
(21, 24, 21, '2023-05-06'),
(22, 27, 22, '2023-05-21'),
(23, 26, 23, '2023-06-06'),
(24, 25, 24, '2023-06-16'),
(25, 30, 25, '2023-06-30'),
(26, 21, 26, '2023-05-12'),
(27, 23, 27, '2023-05-25'),
(28, 28, 28, '2023-06-10'),
(29, 22, 29, '2023-06-18'),
(30, 29, 30, '2023-06-30');

-- Insertar datos en la tabla Hashtags
INSERT INTO Hashtags (id_hashtag, nombre_hashtag, id_usuario)
VALUES
(21, 'Gastronomía', 21),
(22, 'CineClásico', 22),
(23, 'DiseñodeModa', 23),
(24, 'Fitness', 24),
(25, 'Programación', 25),
(26, 'Arte', 26),
(27, 'Fotografía', 27),
(28, 'Música', 28),
(29, 'Literatura', 29),
(30, 'Política', 30);

-- Insertar datos en la tabla Menciones
INSERT INTO Menciones (id_mencion, id_usuario_mencionado, id_tweet)
VALUES
(21, 15, 21),
(22, 14, 22),
(23, 13, 23),
(24, 12, 24),
(25, 11, 25),
(26, 16, 26),
(27, 17, 27),
(28, 18, 28),
(29, 19, 29),
(30, 20, 30);

-- Insertar datos en la tabla Seguidores
INSERT INTO Seguidores (id_seguidor, id_usuario_seguidor, id_usuario_seguido, fecha_creacion)
VALUES
(34, 1, 21, '2023-05-03'),
(35, 2, 22, '2023-05-17'),
(36, 3, 23, '2023-06-02'),
(37, 4, 24, '2023-06-16'),
(38, 5, 25, '2023-06-30'),
(39, 6, 26, '2023-05-07'),
(40, 7, 27, '2023-05-21'),
(41, 8, 28, '2023-06-06'),
(42, 9, 29, '2023-06-16'),
(43, 10, 30, '2023-06-30');




--VAMOS A JUGAR UN POCO CON LAS VISTAS, PARA VER MAS DETALLES DE LAS TABLAS:

--Vista de Tweets con Retweets y Usuarios: Esta vista muestra todos los tweets y 
--retweets realizados, junto con el usuario que los publicó. Además, se incluye 
--información adicional del usuario como el nombre y la descripción.

CREATE OR ALTER VIEW VistaTweets AS
SELECT t.id_tweet, t.fecha_creacion, t.id_usuario, 
       u.nombre_usuario as 'Nombre de Usuario', u.descripcion 'Descripcion o Bio', t.contenido as 'Contenido del Tweet',
	   r.id_retweet, r.id_tweet_original, t.contenido AS tweet_original,  r.fecha_creacion AS fecha_retweet
FROM Tweets t
LEFT JOIN Retweets r ON t.id_tweet = r.id_tweet_original
INNER JOIN Usuarios u ON t.id_usuario = u.id_usuario;

--VEMOS LA VISTA:

SELECT * FROM VistaTweets
select * from Retweets
select * from Tweets

--Vista de Usuarios y sus seguidores: Esta vista muestra información de los usuarios y sus seguidores, 
--junto con sus fechas de seguimiento. Se incluye información adicional del usuario como el correo 
--electrónico y la fecha de creación.

CREATE OR ALTER VIEW VistaSeguidores AS
SELECT s.id_seguidor, s.fecha_creacion, u.id_usuario, u.nombre_usuario, u.correo_electronico, u.fecha_creacion AS fecha_usuario
FROM Seguidores s
INNER JOIN Usuarios u ON s.id_usuario_seguido = u.id_usuario;

--VEMOS LA VISTA:

SELECT * FROM VistaSeguidores

--Vista de Usuarios y sus menciones: Esta vista muestra información de los usuarios y 
--las menciones que recibieron --en sus tweets, junto con el contenido del tweet. Se 
--incluye información adicional del usuario como el correo electrónico y la fecha de creación.

CREATE OR ALTER VIEW VistaMenciones AS
SELECT m.id_mencion, m.id_usuario_mencionado, m.id_tweet, t.contenido, 
       u.id_usuario, u.nombre_usuario, u.correo_electronico, u.fecha_creacion AS fecha_usuario
FROM Menciones m
INNER JOIN Tweets t ON m.id_tweet = t.id_tweet
INNER JOIN Usuarios u ON t.id_usuario = u.id_usuario;

--VEMOS LA VISTA:

SELECT * FROM VistaMenciones


--Vista de Usuarios y su actividad en Twitter: Esta vista muestra información de los usuarios y
--su actividad en Twitter, incluyendo el número de tweets y retweets que han publicado, así 
--como el número de seguidores que tienen.


CREATE OR ALTER VIEW VistaActividad AS
SELECT u.id_usuario, u.nombre_usuario, u.correo_electronico, u.fecha_creacion, 
       COUNT(DISTINCT t.id_tweet) AS num_tweets, COUNT(DISTINCT r.id_retweet) AS num_retweets, 
       COUNT(DISTINCT s.id_seguidor) AS num_seguidores
FROM Usuarios u
LEFT JOIN Tweets t ON u.id_usuario = t.id_usuario
LEFT JOIN Retweets r ON t.id_tweet = r.id_tweet_original
LEFT JOIN Seguidores s ON u.id_usuario = s.id_usuario_seguido
GROUP BY u.id_usuario, u.nombre_usuario, u.correo_electronico, u.fecha_creacion;


--VEMOS LA VISTA:

SELECT * FROM VistaActividad

--Vista de Usuarios y sus retweets: Esta vista muestra información de los usuarios y 
--los retweets que realizaron, junto con el contenido del tweet original que retweetearon. 
--Se incluye información adicional del usuario como el correo electrónico y la fecha de creación.

CREATE OR ALTER VIEW VistaUsuariosRetweets AS
SELECT r.id_retweet, r.fecha_creacion, r.id_tweet_original, t.contenido AS tweet_original, 
       u.id_usuario, u.nombre_usuario, u.correo_electronico, u.fecha_creacion AS fecha_usuario
FROM Retweets r
INNER JOIN Tweets t ON r.id_tweet_original = t.id_tweet
INNER JOIN Usuarios u ON r.id_usuario = u.id_usuario;

--VEMOS LA VISTA:

SELECT * FROM VistaUsuariosRetweets

--Vista de Usuarios y su interacción: Esta vista muestra información de los usuarios
--y su interacción en Twitter, incluyendo el número de menciones que han recibido y 
--el número de usuarios que los mencionaron.

CREATE OR ALTER VIEW VistaInteraccion AS
SELECT u.id_usuario, u.nombre_usuario, u.correo_electronico, u.fecha_creacion, 
       COUNT(DISTINCT m.id_mencion) AS num_menciones, COUNT(DISTINCT m.id_usuario_mencionado) AS num_usuarios_mencionaron
FROM Usuarios u
LEFT JOIN Menciones m ON u.id_usuario = m.id_usuario_mencionado
GROUP BY u.id_usuario, u.nombre_usuario, u.correo_electronico, u.fecha_creacion;

 --VEMOS LA VISTA:

SELECT * FROM VistaInteraccion


--Vista de Tweets y sus hashtags: Esta vista muestra información de los tweets
--y los hashtags que utilizaron, junto con el usuario que los publicó. Se incluye
--información adicional del usuario como el nombre y la descripción.

CREATE OR ALTER VIEW VistaTweetsHashtags AS
SELECT h.id_hashtag, h.nombre_hashtag, h.id_usuario, t.id_tweet, t.contenido, t.fecha_creacion, 
       u.nombre_usuario, u.descripcion
FROM Hashtags h
INNER JOIN Tweets t ON h.id_usuario = t.id_usuario
INNER JOIN Usuarios u ON t.id_usuario = u.id_usuario;

  --VEMOS LA VISTA:

SELECT * FROM VistaTweetsHashtags


--Vista de Tweets y sus menciones: Esta vista muestra información de los tweets y
--las menciones que recibieron, junto con el usuario que los publicó. Se incluye 
--información adicional del usuario como el nombre y la descripción.

CREATE OR ALTER VIEW VistaTweetsMenciones AS
SELECT m.id_mencion, m.id_usuario_mencionado, m.id_tweet, t.contenido AS tweet, t.fecha_creacion, 
       u.nombre_usuario, u.descripcion
FROM Menciones m
INNER JOIN Tweets t ON m.id_tweet = t.id_tweet
INNER JOIN Usuarios u ON t.id_usuario = u.id_usuario;


  --VEMOS LA VISTA:

SELECT * FROM VistaTweetsMenciones

--Vista de Usuarios y sus seguidos: Esta vista muestra información de los usuarios 
--y los usuarios que siguen, junto con sus fechas de seguimiento. Se incluye información
--adicional del usuario como el correo electrónico y la fecha de creación.

CREATE OR ALTER VIEW VistaSeguidos AS
SELECT s.id_seguidor, s.fecha_creacion, u.id_usuario, u.nombre_usuario, u.correo_electronico, u.fecha_creacion AS fecha_usuario
FROM Seguidores s
INNER JOIN Usuarios u ON s.id_usuario_seguidor = u.id_usuario;


--VistaTweets
SELECT * FROM VistaTweets;

--VistaSeguidores
SELECT * FROM VistaSeguidores;

--VistaMenciones
SELECT * FROM VistaMenciones;

--VistaHashtags
SELECT * FROM VistaTweetsHashtags;


--VistaActividad
SELECT * FROM VistaActividad;

--VistaUsuariosRetweets

SELECT * FROM VistaUsuariosRetweets;

--VistaInteraccion

SELECT * FROM VistaInteraccion;

--VistaTweetsHashtags
SELECT * FROM VistaTweetsHashtags;

--VistaTweetsMenciones
SELECT * FROM VistaTweetsMenciones;

--VistaSeguidos
SELECT * FROM VistaSeguidos;


 --TAREA A REALIZAR, EN LA BASE DE DATOS TWEETS_2023: RESPONDE CADA UNA DE ESTAS PREGUNTAS:
 /*
   EN UN DOCUMENTO EN WORD COMO EL QUE TE ESTOY PASANDO, COPIA LA CAPTURA DE PANTALLA DE LA CONSULTA
   DEBAJO DE LA PREGUNTA SQL, ASI CON CADA UNA.

   NOTA: EL DOCUMENTO EN WORD GUARDO: TAREA_BASE_DE_DATPS_TWWETS_2023_NOMBRE_APELLIDOl: 
   ESTO ES OBLIGATORIO PARA TODOS:

 */

--Mostrar todos los usuarios registrados en la tabla Usuarios:
SELECT * FROM Usuarios;

--Mostrar todos los tweets registrados en la tabla Tweets:
SELECT * FROM Tweets;

--Mostrar todos los retweets registrados en la tabla Retweets:
SELECT * FROM Retweets;

--Mostrar todos los hashtags registrados en la tabla Hashtags:
SELECT * FROM Hashtags;

--Mostrar todas las menciones registradas en la tabla Menciones:
SELECT * FROM Menciones;

--Mostrar todos los seguidores registrados en la tabla Seguidores:
SELECT * FROM Seguidores;

--Mostrar la cantidad de usuarios registrados en la tabla Usuarios:
SELECT COUNT(*) AS 'Cantidad de usuarios' FROM Usuarios;

--Mostrar la cantidad de tweets registrados en la tabla Tweets:
SELECT COUNT(*) AS 'Cantidad de tweets' FROM Tweets;

--Mostrar la cantidad de retweets registrados en la tabla Retweets:
SELECT COUNT(*) AS 'Cantidad de retweets' FROM Retweets;

--Mostrar la cantidad de hashtags registrados en la tabla Hashtags:
SELECT COUNT(*) AS 'Cantidad de hashtags' FROM Hashtags;

--Mostrar la cantidad de menciones registradas en la tabla Menciones:
SELECT COUNT(*) AS 'Cantidad de menciones' FROM Menciones;

--Mostrar la cantidad de seguidores registrados en la tabla Seguidores:
SELECT COUNT(*) AS 'Cantidad de seguidores' FROM Seguidores;

--Mostrar los usuarios que han registrado al menos un tweet en la tabla Tweets:
SELECT DISTINCT u.* FROM Usuarios u JOIN Tweets t ON u.id_usuario = t.id_usuario;

--Mostrar los tweets registrados por un usuario en particular:
SELECT * FROM Tweets WHERE id_usuario = 1;

--Mostrar los retweets registrados por un usuario en particular:
SELECT * FROM Retweets WHERE id_usuario = 1;
 
--Mostrar los tweets de un usuario en particular que han sido mencionados por otros usuarios:
SELECT t.* FROM Tweets t JOIN Menciones m ON t.id_tweet = m.id_tweet WHERE m.id_usuario_mencionado = 1;

--Mostrar los usuarios que un usuario en particular sigue:
SELECT u.* FROM Usuarios u JOIN Seguidores s ON u.id_usuario = s.id_usuario_seguido WHERE s.id_usuario_seguidor = 1;

--Mostrar los usuarios que siguen a un usuario en particular:
SELECT u.* FROM Usuarios u JOIN Seguidores s ON u.id_usuario = s.id_usuario_seguido WHERE s.id_usuario_seguido = 1;

--Mostrar los tweets que contienen un hashtag en particular:
SELECT t.* FROM Tweets t JOIN Hashtags h ON t.id_usuario = h.id_usuario WHERE h.nombre_hashtag = 'hashtag';

--Mostrar los usuarios que han mencionado a un usuario en particular en sus tweets:
SELECT u.* FROM Usuarios u JOIN Menciones m ON u.id_usuario = m.id_usuario_mencionado WHERE m.id_tweet IN (SELECT id_tweet FROM Tweets WHERE id_usuario = 1);

--Mostrar los tweets de un usuario en particular que han sido mencionados por otros usuarios:
SELECT t.* FROM Tweets t JOIN Menciones m ON t.id_tweet = m.id_tweet WHERE t.id_usuario = 1;

--Mostrar los usuarios que un usuario en particular sigue:
SELECT u.* FROM Usuarios u JOIN Seguidores s ON u.id_usuario = s.id_usuario_seguido WHERE s.id_usuario_seguidor = 1;

--Mostrar los usuarios que siguen a un usuario en particular:
SELECT u.* FROM Usuarios u JOIN Seguidores s ON u.id_usuario = s.id_usuario_seguido WHERE s.id_usuario_seguido = 1;

--Seleccionar todos los usuarios cuyos nombres empiezan con la letra "A":

SELECT * FROM Usuarios WHERE nombre_usuario LIKE 'A%';

--Actualizar la descripción de un usuario:

UPDATE Usuarios SET descripcion = 'Soy un amante de los gatos' WHERE id_usuario = 1;

--Eliminar un tweet específico:

DELETE FROM Tweets WHERE id_tweet = 1;

--Crear una nueva tabla de comentarios para los tweets:

CREATE TABLE Comentarios (
    id_comentario INT PRIMARY KEY,
    contenido VARCHAR(280) NOT NULL,
    fecha_creacion DATE NOT NULL,
    id_usuario INT NOT NULL,
    id_tweet INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_tweet) REFERENCES Tweets(id_tweet)
);

 --INSETRTA ESTOS DATOS:

INSERT INTO Comentarios (id_comentario, contenido, fecha_creacion, id_usuario, id_tweet) VALUES
(1, '¡Excelente tweet! Me encanta', '2022-04-01', 1, 1),
(2, 'Totalmente de acuerdo, gran reflexión', '2022-04-02', 2, 1),
(3, 'Creo que podrías profundizar más en el tema...', '2022-04-03', 3, 1),
(4, 'Qué gracioso, me hiciste reír con este tweet', '2022-04-04', 4, 2),
(5, 'Muy buen aporte, no lo había visto de esa forma', '2022-04-05', 5, 3),
(6, 'No estoy de acuerdo, creo que estás equivocado', '2022-04-06', 6, 4),
(7, 'Excelente punto de vista, me has hecho reflexionar', '2022-04-07', 7, 5),
(8, 'No sé si estoy de acuerdo contigo, tendríamos que discutirlo', '2022-04-08', 8, 6),
(9, 'Este tweet es una obra de arte, ¡felicitaciones!', '2022-04-09', 9, 7),
(10, 'No entiendo muy bien lo que quieres decir...', '2022-04-10', 10, 7);


--Mostrar todos los comentarios hechos por un usuario en particular:

SELECT * FROM Comentarios WHERE id_usuario = 5;

--Reemplaza <id_del_usuario> con el ID del usuario cuyos comentarios quieres ver.

--Mostrar todos los comentarios hechos en un tweet en particular:

SELECT * FROM Comentarios WHERE id_tweet = 2;

--Reemplaza <id_del_tweet> con el ID del tweet en el cual quieres ver los comentarios.

--Mostrar todos los comentarios

SELECT COUNT(*) AS total_comentarios FROM Comentarios;

--Mostrar todos los comentarios	y quien los realizo:

SELECT u.id_usuario, u.nombre_usuario, COUNT(c.id_comentario) AS total_comentarios
FROM Usuarios u
JOIN Comentarios c ON u.id_usuario = c.id_usuario
GROUP BY u.id_usuario, u.nombre_usuario


select * from Usuarios


--Esta consulta te dará el promedio de comentarios por tweet en la tabla "Comentarios".

--Obtener la cantidad total de tweets en la base de datos:

SELECT COUNT(*) FROM Tweets;

--Obtener el tweet más largo en la base de datos con la fucnion ( MAX y LEN):

SELECT MAX(LEN(contenido)) AS 'Longitud máxima de tweet' FROM Tweets;

--Obtener el tweet más largo en la base de datos y quien lo realizo con la fucnion ( MAX y LEN) y JOIN:

SELECT u.nombre_usuario, MAX(LEN(t.contenido)) AS 'Longitud máxima de tweet'
FROM Tweets t
JOIN Usuarios u ON t.id_usuario = u.id_usuario
GROUP BY u.nombre_usuario
ORDER BY MAX(LEN(t.contenido)) DESC

--Obtener el tweet más largo en la base de datos, quien lo realizo y cual es el tweets con la fucnion ( MAX y LEN) y JOIN:

SELECT u.nombre_usuario, t.contenido, MAX(LEN(t.contenido)) AS 'Longitud máxima de tweet'
FROM Tweets t
JOIN Usuarios u ON t.id_usuario = u.id_usuario
GROUP BY u.nombre_usuario, t.contenido
ORDER BY MAX(LEN(t.contenido)) DESC;



--Obtener la cantidad promedio de seguidores por usuario:

SELECT AVG(COUNT(id_seguidor)) AS 'Promedio de seguidores por usuario' FROM Seguidores GROUP BY id_usuario_seguido;

--Obtener el número total de menciones para cada usuario:

SELECT id_usuario_mencionado, COUNT(*) AS 'Cantidad de menciones' FROM Menciones GROUP BY id_usuario_mencionado;

--Obtener el usuario que ha creado el tweet más reciente:

SELECT TOP 1 id_usuario, MAX(fecha_creacion) AS 'Fecha de último tweet' FROM Tweets GROUP BY id_usuario ORDER BY MAX(fecha_creacion) DESC;

--Obtener los tweets que contienen la palabra "gato":

SELECT * FROM Tweets WHERE contenido LIKE '%gato%';

--Obtener el tiempo promedio en dias de un tweets:

SELECT id_usuario, nombre_usuario, DATEDIFF(day, fecha_creacion, GETDATE()) AS 'Tiempo transcurrido (días)'
FROM Usuarios;

--Obtener el tiempo promedio en dias de un tweets:

SELECT id_usuario, nombre_usuario, DATEDIFF(MONTH, fecha_creacion, GETDATE()) AS 'Tiempo transcurrido (días)'
FROM Usuarios;

--Obtener el tiempo promedio en mes de un tweets:

SELECT id_usuario, nombre_usuario, DATEDIFF(YEAR, fecha_creacion, GETDATE()) AS 'Tiempo transcurrido (días)'
FROM Usuarios;

--Obtener el tiempo promedio en año de un tweets:

SELECT id_usuario, nombre_usuario, DATEDIFF(WEEK, fecha_creacion, GETDATE()) AS 'Tiempo transcurrido (días)'
FROM Usuarios;

--Obtener los usuarios que no tienen seguidores:

SELECT u.* FROM Usuarios u LEFT JOIN Seguidores s ON u.id_usuario = s.id_usuario_seguido WHERE s.id_usuario_seguido IS NULL;

--Obtener los tweets y sus respectivos comentarios para un usuario en particular:

SELECT t.*, c.* FROM Tweets t LEFT JOIN Comentarios c ON t.id_tweet = c.id_tweet WHERE t.id_usuario = 1;

SELECT * FROM Usuarios

/*

Para simular tweets negativos y positivos criticando a una marca, red social o político, se pueden utilizar 
expresiones que reflejen descontento, desaprobación o insatisfacción con la entidad en cuestión. A continuación 
se presenta un ejemplo de cómo insertar varios tweets negativos y positivos en la tabla "Tweets":


*/


-- Insertar tweets negativos

INSERT INTO Tweets (id_tweet, contenido, fecha_creacion, id_usuario)
VALUES
(31, 'No puedo creer lo malo que es el servicio al cliente de la marca X #pesimo', '2023-05-01', 21),
(32, 'La última actualización de la red social Y es un desastre total #fail', '2023-05-02', 22),
(33, 'El político Z es un mentiroso y un corrupto #verguenza', '2023-05-03', 23),
(34, 'La calidad de los productos de la marca X ha caído en picada #decepcion', '2023-05-04', 24),
(35, 'La política económica del gobierno actual es un fracaso total #desastre', '2023-05-05', 25);

-- Insertar tweets positivos

INSERT INTO Tweets (id_tweet, contenido, fecha_creacion, id_usuario)
VALUES
(36, 'Estoy muy contento con el nuevo diseño de la página web de la marca X #mejora', '2023-05-06', 26),
(37, 'La red social Y ha mejorado mucho en la velocidad de carga de las imágenes #agilidad', '2023-05-07', 27),
(38, 'El político Z ha implementado una política pública muy beneficiosa para la sociedad #progreso', '2023-05-08', 28),
(39, 'La marca X ha lanzado un producto innovador que cumple con todas mis expectativas #excelencia', '2023-05-09', 29),
(40, 'La política de seguridad del gobierno actual ha disminuido la delincuencia en mi comunidad #seguridad', '2023-05-10', 30);



-- VAMOS A Insertar 15 tweets negativos MAS  

INSERT INTO Tweets (id_tweet, contenido, fecha_creacion, id_usuario)
VALUES
(41, 'El servicio al cliente de la marca Y es una burla #pésimo', '2023-05-06', 26),
(42, 'La comida del restaurante Z es deplorable #terrible', '2023-05-07', 27),
(43, 'El servicio de entrega de la tienda X es el peor que he visto #desastroso', '2023-05-08', 28),
(44, 'El nuevo diseño del sitio web de la empresa Y es una pesadilla #desastroso', '2023-05-09', 29),
(45, 'El último producto lanzado por la compañía Z es una completa decepción #malo', '2023-05-10', 30),
(46, 'La atención médica en el hospital X es un desastre #horrible', '2023-05-11', 1),
(47, 'El tráfico en la ciudad Y es un infierno #caos', '2023-05-12', 2),
(48, 'El servicio de transporte público de la ciudad Z es un desastre #terrible', '2023-05-13', 13),
(49, 'El hotel X es una vergüenza #horrible', '2023-05-14', 3),
(50, 'El servicio de internet de la compañía Y es el peor que he experimentado #desastroso', '2023-05-15', 14),
(51, 'El sistema educativo actual es un fracaso total #vergüenza', '2023-05-16', 15),
(52, 'El último libro del autor Z es aburrido y mal escrito #pésimo', '2023-05-17', 17),
(53, 'La calidad del servicio de comida en el restaurante X ha caído en picada #decepcion', '2023-05-18', 18),
(54, 'El servicio de atención al cliente de la compañía Y es insuficiente #terrible', '2023-05-19', 19),
(55, 'La última película del director Z es una pérdida de tiempo y dinero #horrible', '2023-05-20', 20);


-- Insertar tweets positivos
INSERT INTO Tweets (id_tweet, contenido, fecha_creacion, id_usuario)
VALUES
(56, 'El servicio al cliente de la marca X es excepcional #excelente', '2023-05-11', 11),
(57, 'La nueva actualización de la red social Y es impresionante #innovación', '2023-05-12', 12),
(58, 'El político Z ha propuesto una iniciativa muy beneficiosa para el medio ambiente #sostenibilidad', '2023-05-13', 3),
(59, 'La marca X ha lanzado un producto de alta calidad y a un precio razonable #oportunidad', '2023-05-14', 4),
(60, 'La política educativa del gobierno actual ha mejorado significativamente el sistema educativo #mejora', '2023-05-15', 5),
(61, 'Estoy muy agradecido con el servicio de atención al cliente de la empresa X #agradecimiento', '2023-05-16', 6),
(62, 'La red social Y ha implementado una función muy útil para la organización de los contactos #funcionalidad', '2023-05-17', 7),
(63, 'El político Z ha promovido una campaña de concientización sobre la importancia de la salud mental #concientización', '2023-05-18', 8),
(64, 'La marca X ha lanzado un producto que ha superado mis expectativas #sorpresa', '2023-05-19', 9),
(65, 'La política de empleo del gobierno actual ha generado nuevas oportunidades laborales en mi región #oportunidades', '2023-05-20', 10),
(66, 'El servicio de envío de la empresa X es muy eficiente y rápido #eficiencia', '2023-05-21', 1),
(67, 'La red social Y ha mejorado en la privacidad y seguridad de los datos de los usuarios #privacidad', '2023-05-22', 2),
(68, 'El político Z ha liderado una iniciativa para mejorar la infraestructura vial en mi ciudad #mejora', '2023-05-23', 3),
(69, 'La marca X ha mejorado la calidad de su atención al cliente #mejora', '2023-05-24', 4),
(70, 'La política de salud del gobierno actual ha implementado nuevas medidas para la prevención de enfermedades #prevención', '2023-05-25', 5);


--VistaTweets
SELECT * FROM VistaTweets;

--VistaTweets
SELECT * FROM Tweets;



-- EL CODIGO EN PYTHON PARA ESTO ES EL SIGUIENTE, ANALIZA LOS TWEETS QUE SEAN POSITIVOS, NEGATIVOS Y NEUTROS Y CREA UN GRAFICO "

/*
Para ejecutar el programa que hemos desarrollado, necesitarás instalar las siguientes herramientas:

Python: Es un lenguaje de programación popular utilizado en el análisis de datos y el aprendizaje automático. 
Puedes descargar e instalar Python desde su sitio web oficial: https://www.python.org/downloads/

PyODBC: Es un módulo de Python que proporciona una API para acceder a bases de datos relacionales.
Puedes instalar PyODBC usando pip, el gestor de paquetes de Python. En la línea de comandos, ejecuta
el siguiente comando: pip install pyodbc

NLTK: Es una biblioteca de procesamiento de lenguaje natural que proporciona herramientas y recursos 
para el análisis de texto. Puedes instalar NLTK usando pip. En la línea de comandos, ejecuta el siguiente
comando: pip install nltk

VaderLexicon: Es un recurso léxico utilizado por NLTK para analizar el sentimiento de los textos. 
Para descargarlo, abre una terminal de Python y ejecuta los siguientes comandos:

import nltk
nltk.download('vader_lexicon')

Matplotlib: Es una biblioteca de visualización de datos para Python. Puedes instalar Matplotlib usando pip.
En la línea de comandos, ejecuta el siguiente comando: pip install matplotlib

*/

---CODIGO FUENTE:

/*

import pyodbc
import nltk
from nltk.sentiment import SentimentIntensityAnalyzer
import matplotlib.pyplot as plt

# Descargar los recursos necesarios de NLTK
nltk.download('vader_lexicon')

# Crear una instancia del analizador de sentimiento de NLTK
sia = SentimentIntensityAnalyzer()

# Establecer la conexión a la base de datos
server = 'JUANCITO'
database = 'Tweets_2023'
username = 'JUANCITO'
password = '123456'
driver = '{ODBC Driver 17 for SQL Server}'
cnxn = pyodbc.connect(f'DRIVER={driver};SERVER={server};DATABASE={database};UID={username};PWD={password}')
cursor = cnxn.cursor()

# Realizar una consulta para obtener los tweets y sus hashtags
query = '''
SELECT contenido, SUBSTRING(contenido, CHARINDEX('#', contenido)+1, LEN(contenido)) AS hashtag
FROM Tweets
'''
cursor.execute(query)
tweets = cursor.fetchall()

# Cerrar la conexión a la base de datos
cursor.close()
cnxn.close()

# Clasificar el sentimiento de cada tweet y contar la cantidad de tweets por cada categoría
count_positivos = 0
count_negativos = 0
count_neutros = 0
for tweet in tweets:
    score = sia.polarity_scores(tweet[0])
    if score['compound'] > 0.1 or 'bueno' in tweet[1] or 'excelente' in tweet[1] or 'increible' in tweet[1]:
        count_positivos += 1
    elif score['compound'] < -0.1 or 'malo' in tweet[1] or 'horrible' in tweet[1] or 'desastroso' in tweet[1]:
        count_negativos += 1
    else:
        count_neutros += 1

# Crear el gráfico de barras
etiquetas = ['Positivo', 'Negativo', 'Neutro']
valores = [count_positivos, count_negativos, count_neutros]
plt.bar(etiquetas, valores, color=['green', 'red', 'yellow'])

# Configurar los detalles del gráfico
plt.title('Análisis de sentimiento de tweets')
plt.xlabel('Sentimiento')
plt.ylabel('Cantidad de tweets')
plt.text(0, sum(valores)+5, f'Total de tweets: {sum(valores)}', ha='center', fontsize=10)

# Agregar el total de tweets por categoría
for i, v in enumerate(valores):
    plt.text(i, v+5, str(v), color='black', ha='center')
plt.show()


*/

--FIN CODIGO FUENTE:
