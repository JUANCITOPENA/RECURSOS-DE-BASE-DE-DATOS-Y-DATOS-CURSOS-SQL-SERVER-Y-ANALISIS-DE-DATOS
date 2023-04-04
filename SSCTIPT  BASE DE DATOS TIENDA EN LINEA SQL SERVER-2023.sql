/*
Una vez que tenemos nuestro modelo ER, podemos crear una base de datos en SQL Server utilizando el Administrador de Servicios
de SQL Server. A continuación, se presenta un ejemplo de cómo se puede crear una base de datos y las tablas necesarias para 
implementar el modelo ER que se ha diseñado.

Creación de la base de datos:

Primero, abrimos el Administrador de Servicios de SQL Server y nos conectamos al servidor en el que queremos crear la base
de datos. Luego, hacemos clic derecho en "Bases de datos" y seleccionamos "Nueva base de datos". En el cuadro de diálogo
que aparece, escribimos un nombre para nuestra base de datos (por ejemplo, "TiendaEnLinea") y hacemos clic en "Aceptar".

Creación de las tablas:

Una vez creada la base de datos, podemos crear las tablas que corresponden a las entidades del modelo ER. Para ello, 
podemos utilizar el Diseñador de Tablas de SQL Server. A continuación, se presenta un ejemplo de cómo se podrían crear 
las tablas para el modelo ER de una tienda en línea:

*/

--Para crear una base de datos en SQL Server basada en el modelo de tienda en línea, se pueden seguir los siguientes pasos:

--Abra el SQL Server Management Studio y conéctese a la instancia del servidor donde se desea crear la base de datos.

--Seleccione "Nueva consulta" en la barra de herramientas y ejecute el siguiente script para crear la base de datos:

CREATE DATABASE tienda_en_linea;
GO

--Seleccione la base de datos recién creada en el panel de navegación del Explorador de objetos.

use  tienda_en_linea;

--Ejecute los siguientes scripts para crear las tablas necesarias:

--Tabla "Clientes":

CREATE TABLE Clientes (
id_cliente INT PRIMARY KEY,
nombre_cliente VARCHAR(50),
apellidos_cliente VARCHAR(50),
email VARCHAR(100),
direccion VARCHAR(200),
telefono VARCHAR(20)
)

--Tabla "Categorias":

CREATE TABLE Categorias (
id_categoria INT PRIMARY KEY,
nombre_categoria VARCHAR(50),
descripcion VARCHAR(200)
)

--Tabla "Productos":

CREATE TABLE Productos (
id_producto INT PRIMARY KEY,
nombre_producto VARCHAR(100),
descripcion VARCHAR(500),
precio DECIMAL(10,2),
stock INT,
id_categoria INT,
FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
)
--Tabla "Pedidos":

CREATE TABLE Pedidos (
id_pedido INT PRIMARY KEY,
fecha_pedido DATETIME,
id_cliente INT,
FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
)

--Tabla "DetallePedidos":

CREATE TABLE DetallePedidos (
id_detalle_pedido INT PRIMARY KEY,
id_pedido INT,
id_producto INT,
cantidad INT,
precio DECIMAL(10,2),
FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
)

/*
Creación de las restricciones de integridad referencial:

Finalmente, para garantizar la integridad referencial entre las tablas, podemos crear las restricciones correspondientes
utilizando el Diseñador de Tablas de SQL Server. En este caso, las restricciones de integridad referencial se han definido
en las tablas "Productos", "Pedidos" y "DetallePedidos" mediante la cláusula FOREIGN KEY.

*/

ALTER TABLE Productos
ADD CONSTRAINT CK_ProductoPrecio CHECK (precio > 0);

ALTER TABLE DetallePedidos
ADD CONSTRAINT CK_DetallePedidoCantidad CHECK (cantidad > 0);

ALTER TABLE DetallePedidos
ADD CONSTRAINT CK_DetallePedidoPrecio CHECK (precio > 0);

CREATE UNIQUE NONCLUSTERED INDEX idx_ProductoNombre
ON Productos (nombre_producto);

CREATE UNIQUE NONCLUSTERED INDEX idx_CategoriaNombre
ON Categorias (nombre_categoria);


--Insertar 10 Registros en la Tabla "Clientes":

INSERT INTO Clientes (id_cliente, nombre_cliente, apellidos_cliente, email, direccion, telefono) VALUES
(1, 'Juan', 'Pérez', 'juanperez@gmail.com', 'Calle 1 #23', '809-123-4567'),
(2, 'María', 'García', 'mariagarcia@gmail.com', 'Calle 2 #45', '809-234-5678'),
(3, 'Pedro', 'Jiménez', 'pedrojimenez@gmail.com', 'Calle 3 #67', '809-345-6789'),
(4, 'Ana', 'Sánchez', 'anasanchez@gmail.com', 'Calle 4 #89', '809-456-7890'),
(5, 'Luis', 'Gómez', 'luisgomez@gmail.com', 'Calle 5 #12', '809-567-8901'),
(6, 'Laura', 'Hernández', 'laurahernandez@gmail.com', 'Calle 6 #34', '809-678-9012'),
(7, 'Carlos', 'Torres', 'carlostorres@gmail.com', 'Calle 7 #56', '809-789-0123'),
(8, 'Sofía', 'Díaz', 'sofiadiaz@gmail.com', 'Calle 8 #78', '809-890-1234'),
(9, 'Jorge', 'Martínez', 'jorgemartinez@gmail.com', 'Calle 9 #01', '809-901-2345'),
(10, 'Marta', 'Romero', 'martaromero@gmail.com', 'Calle 10 #23A','809-012-3456');


-- Insertar 10 registros mas en la tabla Clientes:

INSERT INTO Clientes VALUES (11, 'Juan', 'Perez', 'juanperez@example.com', 'Calle Falsa 123', '809-555-1234');
INSERT INTO Clientes VALUES (12, 'Maria', 'Gonzalez', 'mariagonzalez@example.com', 'Avenida Siempre Viva 742', '809-555-5678');
INSERT INTO Clientes VALUES (13, 'Pedro', 'Sanchez', 'pedrosanchez@example.com', 'Plaza Mayor 1', '809-555-4321');
INSERT INTO Clientes VALUES (14, 'Ana', 'Ramirez', 'anaramirez@example.com', 'Calle Real 2', '809-555-8765');
INSERT INTO Clientes VALUES (15, 'Carlos', 'Lopez', 'carloslopez@example.com', 'Calle Luna 7', '809-555-9876');
INSERT INTO Clientes VALUES (16, 'Laura', 'Garcia', 'lauragarcia@example.com', 'Calle Sol 12', '809-555-3456');
INSERT INTO Clientes VALUES (17, 'Manuel', 'Ruiz', 'manuelruiz@example.com', 'Paseo de la Castellana 200', '809-555-2345');
INSERT INTO Clientes VALUES (18, 'Sara', 'Fernandez', 'sarafernandez@example.com', 'Avenida del Mar 5', '809-555-6543');
INSERT INTO Clientes VALUES (19, 'Diego', 'Martinez', 'diegomartinez@example.com', 'Callejón del Gato 8', '809-555-7890');
INSERT INTO Clientes VALUES (20, 'Isabel', 'Diaz', 'isabeldiaz@example.com', 'Calle del Olvido 15', '809-555-9012');

--Tabla "Categorias":

INSERT INTO Categorias (id_categoria, nombre_categoria, descripcion) VALUES 
(1, 'Electrónica', 'Productos electrónicos de todo tipo'),
(2, 'Hogar', 'Productos para el hogar, decoración, electrodomésticos, etc.'),
(3, 'Deportes', 'Productos deportivos, ropa, accesorios, etc.'),
(4, 'Música', 'CDs, vinilos, instrumentos, etc.'),
(5, 'Libros', 'Todo tipo de libros, tanto de ficción como de no ficción'),
(6, 'Juguetes', 'Juguetes para todas las edades y gustos'),
(7, 'Moda', 'Ropa y accesorios de moda'),
(8, 'Belleza', 'Productos de belleza y cuidado personal'),
(9, 'Alimentos', 'Productos alimentarios de todo tipo'),
(10, 'Muebles', 'Muebles para el hogar, tanto modernos como clásicos');

--Tabla "Productos":

INSERT INTO Productos (id_producto, nombre_producto, descripcion, precio, stock, id_categoria)
VALUES 
(1, 'Camisa', 'Camisa de algodón', 25.00, 50, 1),
(2, 'Pantalón', 'Pantalón de mezclilla', 35.50, 30, 1),
(3, 'Zapatos', 'Zapatos de piel', 70.00, 20, 2),
(4, 'Gorra', 'Gorra deportiva', 15.00, 100, 3),
(5, 'Chamarra', 'Chamarra de cuero', 120.00, 10, 1),
(6, 'Bolsa', 'Bolsa de piel', 80.00, 15, 2),
(7, 'Reloj', 'Reloj de acero inoxidable', 50.00, 25, 3),
(8, 'Billetera', 'Billetera de piel', 25.00, 50, 2),
(9, 'Sombrero', 'Sombrero de lana', 20.00, 30, 3),
(10, 'Chaleco', 'Chaleco de mezclilla', 45.00, 15, 1)


INSERT INTO Productos VALUES (19, 'Botas de montaña', 'Botas para excursionismo y montañismo', 89.99, 25, 3);
INSERT INTO Productos VALUES (20, 'Camiseta deportiva', 'Camiseta de poliéster para hacer ejercicio', 19.99, 50, 2);
INSERT INTO Productos VALUES (21, 'Mancuernas ajustables', 'Juego de mancuernas de hasta 20kg', 199.99, 10, 5);
INSERT INTO Productos VALUES (22, 'Cinta de correr', 'Cinta de correr eléctrica para entrenar en casa', 799.99, 5, 4);
INSERT INTO Productos VALUES (23, 'Barra de dominadas', 'Barra para hacer dominadas en casa', 59.99, 15, 5);
INSERT INTO Productos VALUES (24, 'Bicicleta de montaña', 'Bicicleta para todo terreno', 999.99, 8, 3);
INSERT INTO Productos VALUES (25, 'Gafas de natación', 'Gafas para natación profesionales', 29.99, 20, 1);
INSERT INTO Productos VALUES (26, 'Guantes de boxeo', 'Guantes de boxeo de cuero', 69.99, 12, 6);
INSERT INTO Productos VALUES (27, 'Pelota de baloncesto', 'Pelota de baloncesto profesional', 24.99, 30, 2);
INSERT INTO Productos VALUES (28, 'Cuerda de saltar', 'Cuerda para saltar de alta velocidad', 9.99, 40, 5);

INSERT INTO Productos VALUES 
(29, 'Teclado inalámbrico', 'Teclado para computadora sin necesidad de cables', 35.99, 50, 4),
(30, 'Mouse óptico', 'Mouse para computadora con sensor óptico', 15.99, 100, 4),
(31, 'Silla ergonómica', 'Silla para oficina con diseño ergonómico', 199.99, 20, 2),
(32, 'Laptop ultradelgada', 'Laptop ultradelgada y ligera', 899.99, 10, 3),
(33, 'Smartphone', 'Teléfono inteligente con pantalla de 6 pulgadas', 399.99, 30, 1),
(34, 'Impresora láser', 'Impresora láser blanco y negro', 249.99, 15, 5),
(35, 'Audífonos inalámbricos', 'Audífonos inalámbricos con cancelación de ruido', 129.99, 25, 4),
(36, 'Cámara digital', 'Cámara digital de alta resolución', 299.99, 5, 6),
(37, 'Tablet', 'Tablet con pantalla de 10 pulgadas', 199.99, 20, 3),
(38, 'Monitor de pantalla plana', 'Monitor de pantalla plana de 24 pulgadas', 149.99, 10, 2);


--INSERTAR DATOS EN LA TABLA DE PEDIDOS":
--Pedidos (id_pedido, fecha_pedido, id_cliente):

INSERT INTO Pedidos VALUES (1, '2022-01-01 12:00:00', 1);
INSERT INTO Pedidos VALUES (2, '2022-01-02 14:30:00', 2);
INSERT INTO Pedidos VALUES (3, '2022-01-03 10:00:00', 3);
INSERT INTO Pedidos VALUES (4, '2022-01-04 16:45:00', 4);
INSERT INTO Pedidos VALUES (5, '2022-01-05 09:15:00', 5);
INSERT INTO Pedidos VALUES (6, '2022-01-06 11:30:00', 6);
INSERT INTO Pedidos VALUES (7, '2022-01-07 13:20:00', 7);
INSERT INTO Pedidos VALUES (8, '2022-01-08 15:10:00', 8);
INSERT INTO Pedidos VALUES (9, '2022-01-09 17:00:00', 9);
INSERT INTO Pedidos VALUES (10, '2022-01-10 12:45:00', 10);
INSERT INTO Pedidos VALUES (11, '2023-04-02 12:30:00', 2);
INSERT INTO Pedidos VALUES (12, '2023-04-02 13:45:00', 3);
INSERT INTO Pedidos VALUES (13, '2023-04-02 14:15:00', 1);
INSERT INTO Pedidos VALUES (14, '2023-04-02 15:20:00', 4);
INSERT INTO Pedidos VALUES (15, '2023-04-02 16:10:00', 2);
INSERT INTO Pedidos VALUES (16, '2023-04-02 17:05:00', 1);
INSERT INTO Pedidos VALUES (17, '2023-04-02 18:00:00', 3);
INSERT INTO Pedidos VALUES (18, '2023-04-02 19:15:00', 4);
INSERT INTO Pedidos VALUES (19, '2023-04-02 20:25:00', 1);
INSERT INTO Pedidos VALUES (20, '2023-04-02 21:30:00', 2);
INSERT INTO Pedidos VALUES (21, '2023-04-02 10:30:00', 3);
INSERT INTO Pedidos VALUES (22, '2023-04-03 12:15:00', 1);
INSERT INTO Pedidos VALUES (23, '2023-04-04 09:00:00', 4);
INSERT INTO Pedidos VALUES (24, '2023-04-05 15:45:00', 2);
INSERT INTO Pedidos VALUES (25, '2023-04-06 18:30:00', 3);
INSERT INTO Pedidos VALUES (26, '2023-04-07 11:00:00', 1);
INSERT INTO Pedidos VALUES (27, '2023-04-08 14:20:00', 4);
INSERT INTO Pedidos VALUES (28, '2023-04-09 17:00:00', 2);
INSERT INTO Pedidos VALUES (29, '2023-04-10 08:45:00', 3);
INSERT INTO Pedidos VALUES (30, '2023-04-11 13:10:00', 1);
INSERT INTO Pedidos VALUES (31, '2023-04-02 10:30:00', 5);
INSERT INTO Pedidos VALUES (32, '2023-04-02 11:00:00', 2);
INSERT INTO Pedidos VALUES (33, '2023-04-02 12:15:00', 3);
INSERT INTO Pedidos VALUES (34, '2023-04-02 13:30:00', 1);
INSERT INTO Pedidos VALUES (35, '2023-04-02 14:45:00', 4);
INSERT INTO Pedidos VALUES (36, '2023-04-03 08:00:00', 6);
INSERT INTO Pedidos VALUES (37, '2023-04-03 09:15:00', 7);
INSERT INTO Pedidos VALUES (38, '2023-04-03 10:30:00', 8);
INSERT INTO Pedidos VALUES (39, '2023-04-03 11:45:00', 9);
INSERT INTO Pedidos VALUES (40, '2023-04-03 12:00:00', 10);
INSERT INTO Pedidos VALUES (41, '2023-04-03 13:15:00', 3);
INSERT INTO Pedidos VALUES (42, '2023-04-03 14:30:00', 4);
INSERT INTO Pedidos VALUES (43, '2023-04-03 15:45:00', 5);
INSERT INTO Pedidos VALUES (44, '2023-04-03 16:00:00', 6);
INSERT INTO Pedidos VALUES (45, '2023-04-04 09:15:00', 1);
INSERT INTO Pedidos VALUES (46, '2023-04-04 10:30:00', 2);
INSERT INTO Pedidos VALUES (47, '2023-04-03 16:30:00', 3);
INSERT INTO Pedidos VALUES (48, '2023-04-03 17:45:00', 4);
INSERT INTO Pedidos VALUES (49, '2023-04-03 18:00:00', 5);
INSERT INTO Pedidos VALUES (50, '2023-04-03 19:15:00', 6);
INSERT INTO Pedidos VALUES (51, '2023-04-04 09:30:00', 7);
INSERT INTO Pedidos VALUES (52, '2023-04-04 10:45:00', 8);
INSERT INTO Pedidos VALUES (53, '2023-04-04 11:00:00', 9);
INSERT INTO Pedidos VALUES (54, '2023-04-04 12:15:00', 10);
INSERT INTO Pedidos VALUES (55, '2023-04-04 14:30:00', 1);
INSERT INTO Pedidos VALUES (56, '2023-04-04 15:45:00', 2);


--DetallePedidos (id_detalle_pedido, id_pedido, id_producto, cantidad, precio) :

INSERT INTO DetallePedidos VALUES (1, 1, 1, 2, 30.50);
INSERT INTO DetallePedidos VALUES (2, 1, 2, 1, 15.25);
INSERT INTO DetallePedidos VALUES (3, 1, 4, 3, 7.99);
INSERT INTO DetallePedidos VALUES (4, 2, 3, 2, 20.00);
INSERT INTO DetallePedidos VALUES (5, 2, 5, 1, 12.75);
INSERT INTO DetallePedidos VALUES (6, 3, 6, 4, 5.50);
INSERT INTO DetallePedidos VALUES (7, 3, 2, 2, 15.25);
INSERT INTO DetallePedidos VALUES (8, 4, 1, 1, 30.50);
INSERT INTO DetallePedidos VALUES (9, 4, 5, 3, 12.75);
INSERT INTO DetallePedidos VALUES (10, 5, 3, 1, 10.00);
INSERT INTO DetallePedidos VALUES (11, 5, 4, 2, 7.99);
INSERT INTO DetallePedidos VALUES (12, 5, 2, 1, 15.25);
INSERT INTO DetallePedidos VALUES (13, 6, 1, 3, 30.50);
INSERT INTO DetallePedidos VALUES (14, 6, 5, 2, 12.75);
INSERT INTO DetallePedidos VALUES (15, 7, 3, 3, 10.00);
INSERT INTO DetallePedidos VALUES (16, 7, 4, 1, 7.99);
INSERT INTO DetallePedidos VALUES (17, 8, 2, 4, 15.25);
INSERT INTO DetallePedidos VALUES (18, 8, 5, 1, 12.75);
INSERT INTO DetallePedidos VALUES (19, 8, 1, 1, 30.50);
INSERT INTO DetallePedidos VALUES (20, 9, 3, 2, 10.00);
INSERT INTO DetallePedidos VALUES (21, 8, 6, 2, 11.00);
INSERT INTO DetallePedidos VALUES (22, 8, 3, 1, 20.00);
INSERT INTO DetallePedidos VALUES (23, 9, 2, 3, 15.25);
INSERT INTO DetallePedidos VALUES (24, 9, 4, 2, 7.99);
INSERT INTO DetallePedidos VALUES (25, 9, 5, 1, 12.75);
INSERT INTO DetallePedidos VALUES (26, 10, 1, 1, 30.50);
INSERT INTO DetallePedidos VALUES (27, 10, 3, 2, 20.00);
INSERT INTO DetallePedidos VALUES (28, 11, 4, 3, 7.99);
INSERT INTO DetallePedidos VALUES (29, 11, 5, 2, 12.75);
INSERT INTO DetallePedidos VALUES (30, 11, 6, 1, 5.50);
INSERT INTO DetallePedidos VALUES (31, 12, 1, 2, 30.50);
INSERT INTO DetallePedidos VALUES (32, 12, 2, 1, 15.25);
INSERT INTO DetallePedidos VALUES (33, 12, 4, 3, 7.99);
INSERT INTO DetallePedidos VALUES (34, 13, 3, 2, 20.00);
INSERT INTO DetallePedidos VALUES (35, 13, 5, 1, 12.75);
INSERT INTO DetallePedidos VALUES (36, 14, 6, 4, 5.50);
INSERT INTO DetallePedidos VALUES (37, 14, 2, 2, 15.25);
INSERT INTO DetallePedidos VALUES (38, 15, 1, 1, 30.50);
INSERT INTO DetallePedidos VALUES (39, 15, 5, 3, 12.75);
INSERT INTO DetallePedidos VALUES (40, 16, 3, 1, 10.00);
INSERT INTO DetallePedidos VALUES (41, 16, 2, 1, 15.25);
INSERT INTO DetallePedidos VALUES (42, 16, 4, 2, 7.99);
INSERT INTO DetallePedidos VALUES (43, 16, 5, 1, 12.75);
INSERT INTO DetallePedidos VALUES (44, 17, 3, 2, 20.00);
INSERT INTO DetallePedidos VALUES (45, 17, 6, 1, 5.50);
INSERT INTO DetallePedidos VALUES (46, 18, 1, 2, 30.50);
INSERT INTO DetallePedidos VALUES (47, 18, 2, 1, 15.25);
INSERT INTO DetallePedidos VALUES (48, 18, 4, 3, 7.99);
INSERT INTO DetallePedidos VALUES (49, 19, 5, 2, 12.75);
INSERT INTO DetallePedidos VALUES (50, 20, 3, 1, 10.00);
INSERT INTO DetallePedidos VALUES (41, 16, 4, 2, 7.99);
INSERT INTO DetallePedidos VALUES (42, 16, 5, 1, 12.75);
INSERT INTO DetallePedidos VALUES (43, 17, 2, 2, 15.25);
INSERT INTO DetallePedidos VALUES (44, 17, 3, 1, 20.00);
INSERT INTO DetallePedidos VALUES (45, 17, 4, 3, 7.99);
INSERT INTO DetallePedidos VALUES (46, 18, 1, 1, 30.50);

-- 10 CONSULTAS BASICAS PARA PREGUNTAR AL SQL
--Mostrar todos los clientes:

SELECT * FROM Clientes;

--Buscar un cliente por su ID:

SELECT * FROM Clientes WHERE id_cliente = 1;

--Buscar un cliente por su nombre y apellidos:

SELECT * FROM Clientes WHERE nombre_cliente = 'Juan' AND apellidos_cliente = 'Pérez';

--Mostrar todas las categorías:

SELECT * FROM Categorias;

--Buscar una categoría por su ID:

SELECT * FROM Categorias WHERE id_categoria = 1;

--Buscar una categoría por su nombre:

SELECT * FROM Categorias WHERE nombre_categoria = 'Electrónica';

--Mostrar todos los productos:

SELECT * FROM Productos;

--Buscar un producto por su ID:

SELECT * FROM Productos WHERE id_producto = 1;

--Buscar todos los productos de una categoría en particular:

SELECT * FROM Productos WHERE id_categoria = 2;

--Mostrar todos los pedidos:

SELECT * FROM Pedidos;

--Buscar un pedido por su ID:

SELECT * FROM Pedidos WHERE id_pedido = 1;

--Buscar todos los pedidos de un cliente en particular:

SELECT * FROM Pedidos WHERE id_cliente = 2;

--Mostrar todos los detalles de pedidos:

SELECT * FROM DetallePedidos;

--Buscar un detalle de pedido por su ID:

SELECT * FROM DetallePedidos WHERE id_detalle_pedido = 1;

--Buscar todos los detalles de pedido de un pedido en particular:

SELECT * FROM DetallePedidos WHERE id_pedido = 1;


--15 consultas avanzadas que puedes hacer sobre las tablas que has creado:

--Obtener el nombre, apellidos y email de todos los clientes que han realizado un pedido en el último mes:

SELECT c.nombre_cliente, c.apellidos_cliente, c.email
FROM Clientes c
INNER JOIN Pedidos p ON c.id_cliente = p.id_cliente
WHERE p.fecha_pedido >= DATEADD(month, -1, GETDATE())

--Obtener el número de productos que hay en cada categoría:

SELECT cat.nombre_categoria, COUNT(*) AS num_productos
FROM Categorias cat
INNER JOIN Productos p ON cat.id_categoria = p.id_categoria
GROUP BY cat.nombre_categoria

--Obtener el nombre, descripción y precio de los productos que están en stock:

SELECT nombre_producto, descripcion, precio
FROM Productos
WHERE stock > 0

--Obtener el número total de pedidos realizados por cada cliente:

SELECT c.nombre_cliente, COUNT(*) AS num_pedidos
FROM Clientes c
INNER JOIN Pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.nombre_cliente

--Obtener el número de productos vendidos en cada pedido, junto con su precio total:

SELECT id_pedido, COUNT(*) AS num_productos, SUM(precio) AS precio_total
FROM DetallePedidos
GROUP BY id_pedido

--Obtener el número de productos que han sido vendidos al menos una vez:

SELECT COUNT(DISTINCT id_producto) AS num_productos_vendidos
FROM DetallePedidos

--Obtener el nombre y apellidos de los clientes que han comprado productos de la categoría "Alimentos":

SELECT DISTINCT c.nombre_cliente, c.apellidos_cliente
FROM Clientes c
INNER JOIN Pedidos p ON c.id_cliente = p.id_cliente
INNER JOIN DetallePedidos dp ON p.id_pedido = dp.id_pedido
INNER JOIN Productos pr ON dp.id_producto = pr.id_producto
INNER JOIN Categorias cat ON pr.id_categoria = cat.id_categoria
WHERE cat.nombre_categoria LIKE '%A%'

--Obtener el número de productos vendidos en el año actual, por categoría:

SELECT cat.nombre_categoria, COUNT(*) AS num_productos_vendidos
FROM Categorias cat
INNER JOIN Productos p ON cat.id_categoria = p.id_categoria
INNER JOIN DetallePedidos dp ON p.id_producto = dp.id_producto
INNER JOIN Pedidos pe ON dp.id_pedido = pe.id_pedido
WHERE YEAR(pe.fecha_pedido) = YEAR(GETDATE())
GROUP BY cat.nombre_categoria

--Obtener el precio medio de los productos de la categoría "Tecnología":

SELECT AVG(precio) AS precio_medio
FROM Productos
WHERE id_categoria = (SELECT id_categoria FROM Categorias WHERE nombre_categoria like 'Hogar')

--Obtener el nombre de los productos que tienen una descripción que contiene la palabra "oferta":

SELECT nombre_producto
FROM Productos
WHERE descripcion LIKE '%Te%'

--Obtener el número de días que han pasado desde que se realizó cada pedido hasta hoy:

SELECT id_pedido, DATEDIFF(day, fecha_pedido, GETDATE()) AS dias_transcurridos
FROM Pedidos

--Obtener el número de productos que hay en stock de cada categoría, ordenado de mayor a menor:

SELECT p.id_pedido, p.fecha_pedido, c.nombre_cliente, c.apellidos_cliente 
FROM Pedidos p 
INNER JOIN Clientes c ON p.id_cliente = c.id_cliente 
WHERE c.nombre_cliente = 'Juan' AND c.apellidos_cliente = 'Pérez';

--Listar los detalles de los pedidos que contengan productos con la palabra "leche" en su nombre:


SELECT dp.id_detalle_pedido, p.nombre_producto, dp.cantidad, dp.precio 
FROM DetallePedidos dp 
INNER JOIN Productos p ON dp.id_producto = p.id_producto 
WHERE p.nombre_producto LIKE '%Chamarra%';

--Listar el número de productos de cada categoría:


SELECT c.nombre_categoria, COUNT(*) as cantidad_productos 
FROM Categorias c 
INNER JOIN Productos p ON c.id_categoria = p.id_categoria 
GROUP BY c.nombre_categoria;

--Listar el total de ventas por cada producto:


SELECT p.nombre_producto, SUM(dp.cantidad) as cantidad_vendida, SUM(dp.precio * dp.cantidad) as total_ventas 
FROM DetallePedidos dp 
INNER JOIN Productos p ON dp.id_producto = p.id_producto 
GROUP BY p.nombre_producto;


--CTE-Ejemplo 1: Supongamos que queremos obtener información de todos los clientes cuyo nombre
--empieza por la letra "A". Podríamos utilizar una CTE para obtener los resultados de esta forma:

WITH ClientesA AS (
  SELECT * FROM Clientes WHERE nombre_cliente LIKE 'A%'
)
SELECT * FROM ClientesA;

/*
La primera consulta utiliza la cláusula WITH para definir la CTE llamada "ClientesA". Esta CTE se encarga
de seleccionar todos los clientes cuyo nombre comienza con la letra "A". Luego, la segunda consulta utiliza
la CTE "ClientesA" para seleccionar y mostrar todos los datos de estos clientes.
*/


/*

Ejemplo 2 CTE: 
Supongamos que queremos obtener información de todos los productos cuyo nombre contenga la palabra "CAMISA". 
Podríamos utilizar una CTE para obtener los resultados de esta forma:
*/

WITH ProductosCamisa AS (
  SELECT * FROM Productos WHERE nombre_producto LIKE '%cami%'
)
SELECT id_producto, nombre_producto, precio FROM ProductosCamisa;




--Otro jemplo de CTE sería para obtener los productos que contienen la palabra "C" en su nombre.
--Utilizaremos la función LIKE en la consulta para buscar los productos que contienen la palabra "C" 
--y utilizaremos una CTE para ordenarlos por orden alfabético. 

WITH productos_filtrados AS (
    SELECT *
    FROM Productos
    WHERE nombre_producto LIKE '%C%'
   
)
SELECT *
FROM productos_filtrados



/*
 Para crear una vista que muestre los nombres de todas las tablas sin los IDs y 
 un reporte transaccional de todas las operaciones, se pueden utilizar las siguientes consultas:
*/

CREATE OR ALTER VIEW VistaReporte AS
SELECT 
    CONCAT(C.nombre_cliente, ' ', C.apellidos_cliente) AS cliente, 
    C.direccion AS direccion_cliente,
    C.telefono AS telefono_cliente,
	P.nombre_producto AS producto, 
    P.descripcion AS descripcion_producto,
    Cat.nombre_categoria AS categoria_producto,
	DP.cantidad AS cantidad, 
    DP.precio AS precio, 
    DP.cantidad * DP.precio AS total 
FROM 
    Clientes C 
    JOIN Pedidos Pd ON C.id_cliente = Pd.id_cliente 
    JOIN DetallePedidos DP ON Pd.id_pedido = DP.id_pedido 
    JOIN Productos P ON DP.id_producto = P.id_producto 
    JOIN Categorias Cat ON P.id_categoria = Cat.id_categoria;

--seleccionar la vista:

SELECT * FROM VistaReporte;

--insertar 10 pedidos mas:'
INSERT INTO Pedidos (id_pedido, fecha_pedido, id_cliente)
VALUES
(57, '2023-04-03 09:00:00', 1),
(58, '2023-04-03 10:30:00', 2),
(59, '2023-04-03 11:15:00', 3),
(60, '2023-04-03 12:00:00', 4),
(61, '2023-04-03 13:30:00', 5),
(62, '2023-04-03 14:00:00', 1),
(63, '2023-04-03 15:45:00', 2),
(64, '2023-04-03 16:30:00', 3),
(65, '2023-04-03 17:15:00', 4),
(66, '2023-04-03 18:00:00', 5);


INSERT INTO DetallePedidos (id_detalle_pedido, id_pedido, id_producto, cantidad, precio) 
VALUES
(57, 57, 33, 29, 399.99),
(58, 58, 29, 31, 35.99),
(99, 59, 30, 31, 15.99),
(60, 60, 34, 32, 249.99),
(61, 61, 31, 33, 199.99),
(62, 62, 37, 24, 199.99),
(63, 63, 32, 38, 899.99),
(64, 64, 35, 37, 129.99),
(65, 65, 29, 37, 35.99),
(66, 66, 36, 36, 299.99);



--seleccionar la vista:

SELECT * FROM VistaReporte;