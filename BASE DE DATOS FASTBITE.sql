/*

Proyecto: Sistema de Gesti�n para un Restaurante de Comida R�pida en Santo Domingo Oeste, Rep�blica Dominicana

Descripci�n del Proyecto:

El objetivo de este proyecto es desarrollar un sistema de gesti�n integral para un restaurante de comida r�pida ubicado
en Santo Domingo Oeste, Rep�blica Dominicana. El sistema permitir� gestionar las operaciones de venta, la log�stica de
entrega, el control de inventario y la administraci�n de clientes y empleados.

Modelo de Datos:

El modelo de datos ha sido cuidadosamente dise�ado para reflejar la estructura organizativa y las operaciones del restaurante.
Se ha optado por un enfoque de modelado estrella, donde la tabla de ventas (Facturas) es el punto central, conectada a otras 
entidades relevantes como clientes, vendedores, entregadores y productos. Adem�s, se han aplicado conceptos de copo de nieve
para normalizar la estructura y reducir la redundancia de datos.

Raz�n del Modelo:

El modelo se ha dise�ado de esta manera para asegurar la eficiencia operativa y la coherencia en los datos. 
Al centrarse en la tabla de ventas, se simplifica la gesti�n de transacciones y se facilita el an�lisis de datos. 
Las relaciones entre las entidades, como la asignaci�n de entregadores a clientes y la ubicaci�n de los sectores y clientes, permiten una log�stica de entrega eficiente y precisa. Adem�s, la inclusi�n de campos como latitud y longitud en las tablas de sector y cliente permite un seguimiento geoespacial de las operaciones.

Tablas del Sistema:

Clientes: Contiene la informaci�n personal y de ubicaci�n de los clientes, incluyendo su asignaci�n de entregador para la entrega de pedidos.
Vendedores: Registra los datos de los vendedores, incluyendo su turno de trabajo.
Entregadores: Almacena la informaci�n de los entregadores, tambi�n con sus respectivos turnos.
Productos: Lista los productos disponibles en el restaurante, con su descripci�n y precio.
Tipo de Compra y Tipo de Pagos: Define los diferentes tipos de compra y m�todos de pago aceptados.
Ciudad y Sector: Representa la estructura geogr�fica del �rea de operaciones del restaurante, con los sectores dentro de la ciudad.
Facturas y Detalle de Factura: Registra las ventas realizadas, con detalles de los productos vendidos y los montos asociados.
Implementaci�n:

Para la implementaci�n del sistema, se utilizar� SQL Server como motor de base de datos. 
Se crear� un esquema de base de datos siguiendo el modelo propuesto, con la definici�n de tablas, 
relaciones y restricciones adecuadas para garantizar la integridad de los datos.


*/

-- Crear y usar la base de datos
CREATE DATABASE FastBite;

--Usar la Base de datos
USE FastBite;

-- Script para crear la tabla Ciudad
CREATE TABLE Ciudad (
    ciudad_id INT PRIMARY KEY,
    nombre NVARCHAR(100)
);

-- Script para crear la tabla Sector
CREATE TABLE Sector (
    sector_id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    ciudad_id INT FOREIGN KEY REFERENCES Ciudad(ciudad_id),
    ubicacion_gps_latitud DECIMAL(10, 8),
    ubicacion_gps_longitud DECIMAL(11, 8)
);

-- Script para crear la tabla Vendedores
CREATE TABLE Vendedores (
    vendedor_id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(100),
    turno NVARCHAR(50)
);

-- Script para crear la tabla Entregadores
CREATE TABLE Entregadores (
    entregador_id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(100),
    turno NVARCHAR(50)
);

-- Script para crear la tabla Clientes
CREATE TABLE Clientes (
    cliente_id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(100),
    direccion NVARCHAR(255),
    telefono NVARCHAR(20),
    correo_electronico NVARCHAR(100),
    ubicacion_gps_latitud DECIMAL(10, 8),
    ubicacion_gps_longitud DECIMAL(11, 8),
    sector_id INT FOREIGN KEY REFERENCES Sector(sector_id),
    entregador_asignado_id INT FOREIGN KEY REFERENCES Entregadores(entregador_id)
);

-- Script para crear la tabla TipoCompra
CREATE TABLE TipoCompra (
    tipo_compra_id INT PRIMARY KEY,
    nombre NVARCHAR(100)
);

-- Script para crear la tabla TipoPagos
CREATE TABLE TipoPagos (
    tipo_pago_id INT PRIMARY KEY,
    nombre NVARCHAR(100)
);

-- Script para crear la tabla Productos
CREATE TABLE Productos (
    producto_id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    descripcion NVARCHAR(255),
    precio DECIMAL(10, 2),
    cantidad_disponible INT
);

-- Script para crear la tabla Facturas
CREATE TABLE Facturas (
    factura_id INT PRIMARY KEY,
    cliente_id INT FOREIGN KEY REFERENCES Clientes(cliente_id),
    vendedor_id INT FOREIGN KEY REFERENCES Vendedores(vendedor_id),
    entregador_id INT FOREIGN KEY REFERENCES Entregadores(entregador_id),
    fecha_factura DATETIME,
    tipo_pago_id INT FOREIGN KEY REFERENCES TipoPagos(tipo_pago_id),
    tipo_compra_id INT FOREIGN KEY REFERENCES TipoCompra(tipo_compra_id),
    monto_total DECIMAL(10, 2)
);

-- Script para crear la tabla DetalleFactura
CREATE TABLE DetalleFactura (
    detalle_factura_id INT PRIMARY KEY,
    factura_id INT FOREIGN KEY REFERENCES Facturas(factura_id),
    producto_id INT FOREIGN KEY REFERENCES Productos(producto_id),
    cantidad INT,
    precio_unitario DECIMAL(10, 2),
    monto_subtotal DECIMAL(10, 2)
);



-- Inserci�n de datos en la tabla Ciudad
INSERT INTO Ciudad (ciudad_id, nombre)
VALUES 
    (1, 'Santo Domingo Oeste'),
    (2, 'Santo Domingo Este'),
    (3, 'Santo Domingo Sur'),
    (4, 'Santo Domingo Norte'),
    (5, 'Santo Domingo Distrito')

-- Inserci�n de datos en la tabla Sector
INSERT INTO Sector (sector_id, nombre, ciudad_id, ubicacion_gps_latitud, ubicacion_gps_longitud)
VALUES 
    -- Sectores de Santo Domingo Oeste (ciudad_id = 1)
    (1, 'Los Alcarrizos Centro', 1, 18.5150, -70.0069),
    (2, 'Sabaneta de los Palmares', 1, 18.4794, -70.0294),
    (3, 'Pueblo Nuevo', 1, 18.4981, -70.0011),
    (4, 'La Ci�naga', 1, 18.4892, -70.0047),
    (5, 'La Yuca', 1, 18.5049, -70.0163),
    -- Sectores de Santo Domingo Este (ciudad_id = 2)
    (6, 'Villa Duarte', 2, 18.4893, -69.8347),
    (7, 'San Isidro', 2, 18.4915, -69.7866),
    (8, 'Ensanche Ozama', 2, 18.4703, -69.8721),
    (9, 'Savica', 2, 18.4769, -69.8601),
    (10, 'Los Mina', 2, 18.4801, -69.8558),
    -- Sectores de Santo Domingo Sur (ciudad_id = 3)
    (11, 'Los Prados de Arroyo Hondo', 3, 18.4885, -69.9607),
    (12, 'Los Prados de Santo Domingo', 3, 18.4819, -69.9619),
    (13, 'La Esperilla', 3, 18.4772, -69.9157),
    (14, 'La Zurza', 3, 18.4795, -69.8974),
    (15, 'La Julia', 3, 18.4746, -69.9275),
    -- Sectores de Santo Domingo Norte (ciudad_id = 4)
    (16, 'Villa Mella', 4, 18.5442, -69.8541),
    (17, 'Villa Consuelo', 4, 18.4832, -69.9029),
    (18, 'Villa Francisca', 4, 18.4829, -69.9068),
    (19, 'Herrera', 4, 18.4946, -69.9238),
    (20, 'Los Guaricanos', 4, 18.5786, -69.8259);


-- Inserci�n de datos en la tabla Vendedores
INSERT INTO Vendedores (vendedor_id, nombre, apellido, turno)
VALUES 
    (1, 'Juan', 'Mart�nez', 'Ma�ana'),
    (2, 'Ana', 'Garc�a', 'Tarde'),
    (3, 'Pedro', 'D�az', 'Noche'),
    (4, 'Mar�a', 'L�pez', 'Ma�ana'),
    (5, 'Carlos', 'Rodr�guez', 'Tarde'),
	(6, 'Alejandro', 'G�mez', 'Ma�ana'),
	(7, 'Luc�a', 'Hern�ndez', 'Tarde'),
	(8, 'Marcelo', 'Santos', 'Noche'),
	(9, 'Valeria', 'Garc�a', 'Ma�ana'),
	(10, 'Daniel', 'P�rez', 'Tarde');

-- Inserci�n de datos en la tabla Entregadores
INSERT INTO Entregadores (entregador_id, nombre, apellido, turno)
VALUES 
    (1, 'Luis', 'Hern�ndez', 'Ma�ana'),
    (2, 'Elena', 'Santana', 'Tarde'),
    (3, 'Pablo', 'G�mez', 'Noche'),
    (4, 'Laura', 'Fern�ndez', 'Ma�ana'),
    (5, 'Roberto', 'P�rez', 'Tarde'),
	(6, 'Luisa', 'Hern�ndez', 'Ma�ana'),
	(7, 'Eduardo', 'Santos', 'Tarde'),
	(8, 'Patricia', 'G�mez', 'Noche'),
	(9, 'Mario', 'Fern�ndez', 'Ma�ana'),
	(10, 'Gabriela', 'P�rez', 'Tarde');

select * from Entregadores




-- Inserci�n de datos en la tabla Clientes
INSERT INTO Clientes (cliente_id, nombre, apellido, direccion, telefono, correo_electronico, ubicacion_gps_latitud, ubicacion_gps_longitud, sector_id, entregador_asignado_id)
VALUES 
    -- Cliente en Santo Domingo Oeste (Sector 1)
    (1, 'Mar�a', 'Gonz�lez', 'Calle 1 #123', '809-123-4567', 'maria@gmail.com', 18.4896, -69.9389, 1, 1),
    (2, 'Jos�', 'Santos', 'Calle 2 #456', '809-987-6543', 'jose@hotmail.com', 18.4901, -69.9378, 1, 2),
    (3, 'Ana', 'D�az', 'Calle 3 #789', '809-456-7890', 'ana@yahoo.com', 18.4892, -69.9405, 1, 3),
    (4, 'Carlos', 'Mart�nez', 'Calle 4 #1011', '809-234-5678', 'carlos@gmail.com', 18.4910, -69.9412, 1, 4),
    (5, 'Laura', 'L�pez', 'Calle 5 #1315', '809-345-6789', 'laura@hotmail.com', 18.4925, -69.9423, 1, 5),
    -- Continuar con m�s clientes en otros sectores...
    -- Cliente en Santo Domingo Este (Sector 6)
    (6, 'Pedro', 'Ram�rez', 'Avenida 6 #789', '809-678-1234', 'pedro@gmail.com', 18.4890, -69.8345, 6, 1),
    (7, 'Marta', 'G�mez', 'Calle 7 #1011', '809-789-2345', 'marta@hotmail.com', 18.4913, -69.7859, 7, 2),
    (8, 'Juan', 'P�rez', 'Avenida 8 #1213', '809-890-3456', 'juan@yahoo.com', 18.4712, -69.8727, 8, 3),
    (9, 'Luisa', 'Hern�ndez', 'Calle 9 #1415', '809-901-4567', 'luisa@gmail.com', 18.4775, -69.8598, 9, 4),
    (10, 'Andr�s', 'Torres', 'Avenida 10 #1617', '809-912-5678', 'andres@hotmail.com', 18.4798, -69.8572, 10, 5),
    -- Cliente en Santo Domingo Sur (Sector 11)
    (11, 'Sof�a', 'S�nchez', 'Calle 11 #1819', '809-923-6789', 'sofia@gmail.com', 18.4881, -69.9612, 11, 1),
    (12, 'Roberto', 'Cruz', 'Avenida 12 #2021', '809-934-7890', 'roberto@hotmail.com', 18.4811, -69.9625, 12, 2),
    (13, 'Elena', 'Dominguez', 'Calle 13 #2223', '809-945-8901', 'elena@yahoo.com', 18.4778, -69.9165, 13, 3),
    (14, 'Javier', 'Ortega', 'Avenida 14 #2425', '809-956-9012', 'javier@gmail.com', 18.4791, -69.8962, 14, 4),
    (15, 'Camila', 'Mart�n', 'Calle 15 #2627', '809-967-0123', 'camila@hotmail.com', 18.4754, -69.9278, 15, 5),
    -- Cliente en Santo Domingo Norte (Sector 16)
    (16, 'Alejandro', 'Garc�a', 'Avenida 16 #2829', '809-978-1234', 'alejandro@yahoo.com', 18.5450, -69.8535, 16, 1),
    (17, 'Marcela', 'Fern�ndez', 'Calle 17 #3031', '809-989-2345', 'marcela@gmail.com', 18.4842, -69.9025, 17, 2),
    (18, 'Ricardo', 'Luna', 'Avenida 18 #3233', '809-990-3456', 'ricardo@hotmail.com', 18.4835, -69.9071, 18, 3),
    (19, 'Carmen', 'Vargas', 'Calle 19 #3435', '809-901-4567', 'carmen@yahoo.com', 18.4951, -69.9235, 19, 4),
    (20, 'Gabriel', 'Castillo', 'Avenida 20 #3637', '809-912-5678', 'gabriel@gmail.com', 18.5792, -69.8265, 20, 5),
    -- Continuar con m�s clientes en otros sectores...
    -- Cliente en Hato Nuevo (Sector 7)
    (21, 'Luis', 'Rodr�guez', 'Calle 6 #789', '809-567-8901', 'luis@example.com', 18.4859, -70.0158, 7, 1),
    -- Cliente en Pantanal (Sector 8)
    (22, 'Ana', 'Fern�ndez', 'Calle 7 #1011', '809-678-9012', 'ana@example.com', 18.5025, -70.0203, 8, 2),
    -- Cliente en Guaricano (Sector 9)
    (23, 'David', 'P�rez', 'Calle 8 #1213', '809-789-0123', 'david@example.com', 18.5159, -70.0022, 9, 3),
    -- Cliente en Manoguayabo (Sector 10)
    (24, 'Sof�a', 'Hern�ndez', 'Calle 9 #1415', '809-890-1234', 'sofia@example.com', 18.4903, -70.0149, 10, 4),
    -- Cliente en Los Cacicazgos (Sector 11)
    (25, 'Juan', 'Garc�a', 'Calle 10 #1617', '809-901-2345', 'juan@example.com', 18.4815, -70.0249, 11, 5),
    -- Cliente en Los Girasoles (Sector 12)
    (26, 'Mar�a', 'S�nchez', 'Calle 11 #1819', '809-012-3456', 'maria@example.com', 18.5020, -70.0058, 12, 1),
    -- Cliente en Los Jardines Metropolitanos (Sector 13)
    (27, 'Pedro', 'L�pez', 'Calle 12 #2021', '809-123-4567', 'pedro@example.com', 18.5089, -70.0031, 13, 2),
    -- Cliente en Los Mameyes (Sector 14)
    (28, 'Laura', 'Ram�rez', 'Calle 13 #2223', '809-234-5678', 'laura@example.com', 18.4862, -70.0258, 14, 3),
    -- Cliente en Los Prados (Sector 15)
    (29, 'Carlos', 'Mart�nez', 'Calle 14 #2425', '809-345-6789', 'carlos@example.com', 18.4853, -70.0102, 15, 4),
    -- Cliente en Los R�os (Sector 16)
    (30, 'Ana', 'Gonz�lez', 'Calle 15 #2627', '809-456-7890', 'ana@example.com', 18.4771, -70.0145, 16, 5),
    -- Cliente en Villa Mella (Sector 16)
    (31, 'Jos�', 'Santos', 'Calle 16 #2829', '809-567-8901', 'jose@example.com', 18.5438, -69.8553, 16, 1),
    -- Cliente en Villa Consuelo (Sector 17)
    (32, 'Mar�a', 'Fern�ndez', 'Calle 17 #3031', '809-678-9012', 'maria@example.com', 18.4823, -69.9019, 17, 2),
    -- Cliente en Villa Francisca (Sector 18)
    (33, 'David', 'P�rez', 'Calle 18 #3233', '809-789-0123', 'david@example.com', 18.4816, -69.9065, 18, 3),
    -- Cliente en Herrera (Sector 19)
    (34, 'Sof�a', 'Hern�ndez', 'Calle 19 #3435', '809-890-1234', 'sofia@example.com', 18.4951, -69.9223, 19, 4),
    -- Cliente en Los Guaricanos (Sector 20)
    (35, 'Juan', 'Garc�a', 'Calle 20 #3637', '809-901-2345', 'juan@example.com', 18.5795, -69.8253, 20, 5),
    -- Continuar con m�s clientes en otros sectores...
    -- Cliente en Villa Aura (Sector 19)
    (36, 'Laura', 'Ram�rez', 'Calle 21 #3839', '809-012-3456', 'laura@example.com', 18.5082, -70.0109, 19, 1),
    -- Cliente en Villa Mar�a (Sector 20)
    (37, 'Carlos', 'Mart�nez', 'Calle 22 #4041', '809-123-4567', 'carlos@example.com', 18.5148, -69.9998, 20, 2),
    -- Cliente en Los Alcarrizos Centro (Sector 1)
    (38, 'Ana', 'Gonz�lez', 'Calle 23 #4243', '809-234-5678', 'ana@example.com', 18.5145, -70.0072, 1, 3),
    -- Cliente en Sabaneta de los Palmares (Sector 2)
    (39, 'Pedro', 'L�pez', 'Calle 24 #4445', '809-345-6789', 'pedro@example.com', 18.4789, -70.0302, 2, 4),
    -- Cliente en Pueblo Nuevo (Sector 3)
    (40, 'Sof�a', 'Hern�ndez', 'Calle 25 #4647', '809-456-7890', 'sofia@example.com', 18.4995, -70.0028, 3, 5);

	-- Continuaci�n de la inserci�n de datos en la tabla Clientes
INSERT INTO Clientes (cliente_id, nombre, apellido, direccion, telefono, correo_electronico, ubicacion_gps_latitud, ubicacion_gps_longitud, sector_id, entregador_asignado_id)
VALUES 
    -- Cliente en Villa Aurora (Sector 19)
    (41, 'Luis', 'G�mez', 'Calle 26 #4849', '809-567-8901', 'luis@example.com', 18.5089, -70.0101, 19, 1),
    -- Cliente en Villa Mercedes (Sector 20)
    (42, 'Elena', 'P�rez', 'Calle 27 #5051', '809-678-9012', 'elena@example.com', 18.5223, -69.9934, 20, 2),
    -- Cliente en Los Alcarrizos Norte (Sector 1)
    (43, 'Pablo', 'Mart�nez', 'Calle 28 #5253', '809-789-0123', 'pablo@example.com', 18.5245, -70.0123, 1, 3),
    -- Cliente en Sabana Perdida (Sector 2)
    (44, 'Laura', 'Gonz�lez', 'Calle 29 #5455', '809-890-1234', 'laura@example.com', 18.4932, -70.0345, 2, 4),
    -- Cliente en Los Tres Brazos (Sector 3)
    (45, 'Roberto', 'Santos', 'Calle 30 #5657', '809-901-2345', 'roberto@example.com', 18.5098, -70.0156, 3, 5),
    -- Cliente en Los Prados II (Sector 15)
    (46, 'Marta', 'Fern�ndez', 'Calle 31 #5860', '809-012-3456', 'marta@example.com', 18.4945, -70.0089, 15, 1),
    -- Cliente en Villa Juana (Sector 17)
    (47, 'Juan', 'Hern�ndez', 'Calle 32 #6062', '809-123-4567', 'juan@example.com', 18.4923, -69.9178, 17, 2),
    -- Cliente en Villa Mar�a II (Sector 20)
    (48, 'Ana', 'Mart�nez', 'Calle 33 #6264', '809-234-5678', 'ana@example.com', 18.5043, -69.9923, 20, 3),
    -- Cliente en Villa Consuelo II (Sector 17)
    (49, 'Pedro', 'Garc�a', 'Calle 34 #6466', '809-345-6789', 'pedro@example.com', 18.4812, -69.9224, 17, 4),
    -- Cliente en Los R�os II (Sector 16)
    (50, 'Sof�a', 'Santana', 'Calle 35 #6668', '809-456-7890', 'sofia@example.com', 18.4876, -70.0102, 16, 5);



-- Inserci�n de datos en la tabla TipoCompra
INSERT INTO TipoCompra (tipo_compra_id, nombre)
VALUES 
    (1, 'Para llevar'),
    (2, 'Para comer aqu�'),
    (3, 'A domicilio');

-- Inserci�n de datos en la tabla TipoPagos
INSERT INTO TipoPagos (tipo_pago_id, nombre)
VALUES 
    (1, 'Efectivo'),
    (2, 'Tarjeta de cr�dito'),
    (3, 'Transferencia bancaria');

-- Inserci�n de datos en la tabla Productos
INSERT INTO Productos (producto_id, nombre, descripcion, precio, cantidad_disponible)
VALUES 
    (1, 'Hamburguesa', 'Deliciosa hamburguesa con carne, lechuga, tomate y queso', 150, 100),
    (2, 'Pizza', 'Pizza reci�n horneada con los ingredientes de tu elecci�n', 200, 80),
    (3, 'Hot Dog', 'Hot dog cl�sico con salchicha, pan y tus aderezos favoritos', 100, 120),
    (4, 'Papas Fritas', 'Papas fritas crujientes y doradas, perfectas como acompa�amiento', 50, 150),
    (5, 'Refresco', 'Bebida refrescante de tu sabor favorito', 50, 200),
    (6, 'Pollo Frito', 'Trozos de pollo crujientes y sabrosos', 180, 90),
    (7, 'Ensalada C�sar', 'Ensalada fresca con lechuga, crutones, pollo y aderezo C�sar', 120, 70),
    (8, 'Tacos', 'Tacos mexicanos con carne, guacamole, salsa y cilantro', 160, 100),
    (9, 'Sushi Roll', 'Rollos de sushi variados con pescado fresco y arroz', 250, 60),
    (10, 'Alitas de Pollo', 'Alitas de pollo picantes o a la barbacoa', 130, 110),
    (11, 'Pasta Alfredo', 'Pasta con salsa Alfredo cremosa y queso parmesano', 170, 80),
    (12, 'Empanadas', 'Empanadas rellenas de carne, pollo o queso', 90, 130),
    (13, 'Burrito', 'Burrito mexicano con carne, frijoles, arroz y salsa', 140, 90),
    (14, 'S�ndwich Club', 'S�ndwich con pollo, tocino, lechuga, tomate y mayonesa', 110, 120),
    (15, 'Arroz con Pollo', 'Plato tradicional de arroz con pollo y vegetales', 160, 80),
    (16, 'Ceviche', 'Ceviche de pescado fresco marinado con lim�n y especias', 200, 70),
    (17, 'Churrasco', 'Churrasco argentino con carne asada y chimichurri', 220, 60),
    (18, 'Sopa de Tortilla', 'Sopa mexicana de tortilla con pollo, aguacate y queso', 120, 100),
    (19, 'Pastel de Chocolate', 'Delicioso pastel de chocolate con cobertura de ganache', 180, 90),
    (20, 'Gelatina', 'Gelatina de frutas frescas con crema batida', 80, 150);


select * from Facturas
select * from DetalleFactura


-- Insertar una venta en la tabla de Facturas
INSERT INTO Facturas (factura_id, cliente_id, vendedor_id, entregador_id, fecha_factura, tipo_pago_id, tipo_compra_id, monto_total)
VALUES
    (1, 1, 1, 1, '2024-02-16 10:00:00', 1, 1, 50.00);

-- Insertar 20 registros adicionales en la tabla de Facturas

INSERT INTO Facturas (factura_id, cliente_id, vendedor_id, entregador_id, fecha_factura, tipo_pago_id, tipo_compra_id, monto_total)
VALUES
    (2, 2, 2, 2, '2024-02-16 11:00:00', 2, 1, 75.00),
    (3, 3, 3, 3, '2024-02-16 12:00:00', 1, 2, 100.00),
    (4, 4, 4, 4, '2024-02-16 13:00:00', 3, 2, 120.00),
    (5, 5, 5, 5, '2024-02-16 14:00:00', 2, 3, 90.00),
    (6, 6, 6, 6, '2024-02-16 15:00:00', 1, 3, 85.00),
    (7, 7, 7, 7, '2024-02-16 16:00:00', 3, 1, 60.00),
    (8, 8, 8, 8, '2024-02-16 17:00:00', 2, 2, 110.00),
    (9, 9, 9, 9, '2024-02-16 18:00:00', 1, 1, 70.00),
    (10, 10, 10, 10, '2024-02-16 19:00:00', 2, 3, 95.00),
    (11, 11, 1, 1, '2024-02-16 20:00:00', 3, 2, 105.00),
    (12, 12, 2, 2, '2024-02-16 21:00:00', 1, 3, 80.00),
    (13, 13, 3, 3, '2024-02-16 22:00:00', 2, 1, 55.00),
    (14, 14, 4, 4, '2024-02-16 23:00:00', 1, 2, 115.00),
    (15, 15, 5, 5, '2024-02-16 09:00:00', 3, 3, 125.00),
    (16, 16, 6, 6, '2024-02-17 10:00:00', 2, 1, 45.00),
    (17, 17, 7, 7, '2024-02-17 11:00:00', 1, 1, 65.00),
    (18, 18, 8, 8, '2024-02-17 12:00:00', 3, 2, 95.00),
    (19, 19, 9, 9, '2024-02-17 13:00:00', 2, 3, 85.00),
    (20, 20, 10, 10, '2024-02-17 14:00:00', 1, 3, 75.00),
    (21, 1, 1, 1, '2024-02-17 15:00:00', 1, 1, 50.00),
    (22, 2, 2, 2, '2024-02-17 16:00:00', 2, 1, 75.00);

-- Insertar 20 registros adicionales en la tabla de Facturas


-- Insertar detalles de factura para las primeras 20 facturas
INSERT INTO DetalleFactura (detalle_factura_id, factura_id, producto_id, cantidad, precio_unitario, monto_subtotal)
VALUES
    (1, 1, 1, 2, 10.00, 20.00),
    (2, 2, 3, 1, 30.00, 30.00),
    (3, 3, 2, 3, 15.00, 45.00),
    (4, 4, 4, 2, 25.00, 50.00),
    (5, 5, 1, 1, 10.00, 10.00),
    (6, 6, 5, 2, 20.00, 40.00),
    (7, 7, 3, 1, 30.00, 30.00),
    (8, 8, 2, 3, 15.00, 45.00),
    (9, 9, 4, 2, 25.00, 50.00),
    (10, 10, 1, 1, 10.00, 10.00),
    (11, 11, 5, 2, 20.00, 40.00),
    (12, 12, 3, 1, 30.00, 30.00),
    (13, 13, 2, 3, 15.00, 45.00),
    (14, 14, 4, 2, 25.00, 50.00),
    (15, 15, 1, 1, 10.00, 10.00),
    (16, 16, 5, 2, 20.00, 40.00),
    (17, 17, 3, 1, 30.00, 30.00),
    (18, 18, 2, 3, 15.00, 45.00),
    (19, 19, 4, 2, 25.00, 50.00),
    (20, 20, 1, 1, 10.00, 10.00);


-- Insertar detalles de factura para las primeras 50 facturas

-- Factura 1
INSERT INTO DetalleFactura (detalle_factura_id, factura_id, producto_id, cantidad, precio_unitario, monto_subtotal)
VALUES
    (1, 1, 1, 2, 10.00, 20.00), -- Producto 1, 2 unidades
    (2, 1, 2, 1, 30.00, 30.00), -- Producto 2, 1 unidad
    (3, 1, 3, 3, 15.00, 45.00); -- Producto 3, 3 unidades

-- Factura 2
INSERT INTO DetalleFactura (detalle_factura_id, factura_id, producto_id, cantidad, precio_unitario, monto_subtotal)
VALUES
    (4, 2, 2, 2, 30.00, 60.00), -- Producto 2, 2 unidades
    (5, 2, 4, 1, 25.00, 25.00), -- Producto 4, 1 unidad
    (6, 2, 5, 3, 20.00, 60.00); -- Producto 5, 3 unidades

-- Factura 3
INSERT INTO DetalleFactura (detalle_factura_id, factura_id, producto_id, cantidad, precio_unitario, monto_subtotal)
VALUES
    (7, 3, 1, 1, 10.00, 10.00), -- Producto 1, 1 unidad
    (8, 3, 3, 2, 15.00, 30.00), -- Producto 3, 2 unidades
    (9, 3, 4, 1, 25.00, 25.00); -- Producto 4, 1 unidad

-- Continuar as� para las siguientes facturas

-- Par�metros de entrada
DECLARE @FechaInicial DATETIME = '2020-01-01'; -- Fecha inicial
DECLARE @FechaFinal DATETIME = '2024-02-17';   -- Fecha final
DECLARE @CantidadRegistros_Facturas INT = 20000;           -- Cantidad de registros a generar
DECLARE @CantidadRegistros_DetalleFactura INT = 40000
-- Variables locales
DECLARE @contador INT;
DECLARE @MaxFacturaID INT;

-- Obtener el m�ximo ID de factura existente
SELECT @MaxFacturaID = MAX(factura_id) FROM Facturas;

-- Inicializar el contador para comenzar desde el siguiente ID
SET @contador = ISNULL(@MaxFacturaID, 0) + 1;

-- Bucle para insertar registros en la tabla Facturas
WHILE @contador <= @MaxFacturaID + @CantidadRegistros
BEGIN
    -- Generar una fecha aleatoria dentro del rango especificado
    DECLARE @FechaAleatoria DATETIME;
    SET @FechaAleatoria = DATEADD(second, RAND() * DATEDIFF(second, @FechaInicial, @FechaFinal), @FechaInicial);

    -- Insertar en la tabla Facturas
    INSERT INTO Facturas (factura_id, cliente_id, vendedor_id, entregador_id, fecha_factura, tipo_pago_id, tipo_compra_id, monto_total)
    VALUES (
        @contador,                       -- factura_id (contador)
        CAST(RAND() * 50 AS INT) + 1,   -- cliente_id (n�meros aleatorios entre 1 y 50)
        CAST(RAND() * 10 AS INT) + 1,   -- vendedor_id (n�meros aleatorios entre 1 y 10)
        CAST(RAND() * 10 AS INT) + 1,   -- entregador_id (n�meros aleatorios entre 1 y 10)
        @FechaAleatoria,                -- fecha_factura (fecha aleatoria)
        CAST(RAND() * 3 AS INT) + 1,    -- tipo_pago_id (n�meros aleatorios entre 1 y 3)
        CAST(RAND() * 3 AS INT) + 1,    -- tipo_compra_id (n�meros aleatorios entre 1 y 3)
        ROUND(RAND() * 200, 2)         -- monto_total (n�meros aleatorios entre 0 y 200)
    );

    SET @contador = @contador + 1;
END;

-- Bucle para insertar detalles de factura para las facturas reci�n insertadas
SET @contador = ISNULL(@MaxFacturaID, 0) + 1;

WHILE @contador <= @MaxFacturaID + @CantidadRegistros
BEGIN
    -- Insertar detalles de factura
    INSERT INTO DetalleFactura (factura_id, producto_id, cantidad, precio_unitario, monto_subtotal)
    VALUES (
        @contador,                      -- factura_id (id de factura reci�n insertada)
        CAST(RAND() * 20 AS INT) + 1,  -- producto_id (n�meros aleatorios entre 1 y 20)
        CAST(RAND() * 5 AS INT) + 1,   -- cantidad (n�meros aleatorios entre 1 y 5)
        ROUND(RAND() * 100 + 50, 2),   -- precio_unitario (n�meros aleatorios entre 50 y 150)
        NULL                            -- monto_subtotal (se calcular� autom�ticamente)
    );

    SET @contador = @contador + 1;
END;




-- Par�metros de entrada
DECLARE @FechaInicial DATETIME = '2020-01-01'; -- Fecha inicial
DECLARE @FechaFinal DATETIME = '2024-02-17';   -- Fecha final
DECLARE @CantidadRegistros_Facturas INT = 20000;           -- Cantidad de registros de facturas a generar
DECLARE @MaxDetallesPorFactura INT = 5;  -- M�ximo de detalles por factura
DECLARE @PrecioMinimo DECIMAL(10, 2) = 50.00;
DECLARE @PrecioMaximo DECIMAL(10, 2) = 150.00;

-- Variables locales
DECLARE @contador INT;
DECLARE @MaxFacturaID INT;

-- Obtener el m�ximo ID de factura existente
SELECT @MaxFacturaID = ISNULL(MAX(factura_id), 0) FROM Facturas;

-- Inicializar el contador para comenzar desde el siguiente ID
SET @contador = ISNULL(@MaxFacturaID, 0) + 1;

-- Bucle para insertar registros en la tabla Facturas y detalles de factura
WHILE @contador <= @MaxFacturaID + @CantidadRegistros_Facturas
BEGIN
    -- Generar una fecha aleatoria dentro del rango especificado
    DECLARE @FechaAleatoria DATETIME;
    SET @FechaAleatoria = DATEADD(second, RAND() * DATEDIFF(second, @FechaInicial, @FechaFinal), @FechaInicial);

    -- Insertar en la tabla Facturas
    INSERT INTO Facturas (factura_id, cliente_id, vendedor_id, entregador_id, fecha_factura, tipo_pago_id, tipo_compra_id, monto_total)
    VALUES (
        @contador,                       -- factura_id (contador)
        CAST(RAND() * 50 AS INT) + 1,   -- cliente_id (n�meros aleatorios entre 1 y 50)
        CAST(RAND() * 10 AS INT) + 1,   -- vendedor_id (n�meros aleatorios entre 1 y 10)
        CAST(RAND() * 10 AS INT) + 1,   -- entregador_id (n�meros aleatorios entre 1 y 10)
        @FechaAleatoria,                -- fecha_factura (fecha aleatoria)
        CAST(RAND() * 3 AS INT) + 1,    -- tipo_pago_id (n�meros aleatorios entre 1 y 3)
        CAST(RAND() * 3 AS INT) + 1,    -- tipo_compra_id (n�meros aleatorios entre 1 y 3)
        ROUND(RAND() * 200, 2)         -- monto_total (n�meros aleatorios entre 0 y 200)
    );

    -- Obtener el ID de la factura reci�n insertada
    DECLARE @FacturaID INT = @@IDENTITY;

    -- Generar un n�mero aleatorio de detalles para esta factura
    DECLARE @CantidadDetalles INT;
    SET @CantidadDetalles = CAST(RAND() * @MaxDetallesPorFactura AS INT) + 1;

    -- Insertar detalles de factura para la factura actual
    DECLARE @ContadorDetalle INT = 1;
    WHILE @ContadorDetalle <= @CantidadDetalles
    BEGIN
        -- Insertar detalle de factura
        INSERT INTO DetalleFactura (factura_id, producto_id, cantidad, precio_unitario, monto_subtotal)
        VALUES (
            @FacturaID,                      -- factura_id (id de factura reci�n insertada)
            CAST(RAND() * 20 AS INT) + 1,   -- producto_id (n�meros aleatorios entre 1 y 20)
            CAST(RAND() * 5 AS INT) + 1,    -- cantidad (n�meros aleatorios entre 1 y 5)
            ROUND(RAND() * (@PrecioMaximo - @PrecioMinimo) + @PrecioMinimo, 2),  -- precio_unitario (n�meros aleatorios entre el precio m�nimo y m�ximo)
            NULL                             -- monto_subtotal (se calcular� autom�ticamente)
        );
        
        SET @ContadorDetalle = @ContadorDetalle + 1;
    END;

    SET @contador = @contador + 1;
END;




select * from Facturas
select * from DetalleFactura

-- Eliminar todos los registros de la tabla DetalleFactura y obtener el conteo de registros eliminados
DECLARE @ConteoDetalles INT;
DELETE FROM DetalleFactura;
SET @ConteoDetalles = @@ROWCOUNT;

-- Eliminar todos los registros de la tabla Facturas y obtener el conteo de registros eliminados
DECLARE @ConteoFacturas INT;
DELETE FROM Facturas;
SET @ConteoFacturas = @@ROWCOUNT;

-- Mostrar el conteo de registros eliminados
SELECT 'Registros eliminados de DetalleFactura: ' + CAST(@ConteoDetalles AS NVARCHAR(MAX)) AS [DetalleFactura],
       'Registros eliminados de Facturas: ' + CAST(@ConteoFacturas AS NVARCHAR(MAX)) AS [Facturas];



-- Script para generar facturas y detalles de factura utilizando datos de las tablas existentes
-- Variables
DECLARE @FechaInicial DATETIME = '2020-01-01'; -- Fecha inicial
DECLARE @FechaFinal DATETIME = '2024-02-17';   -- Fecha final
DECLARE @CantidadRegistros_Facturas INT = 20000;           -- Cantidad de registros de facturas a generar
DECLARE @MaxDetallesPorFactura INT = 5;  -- M�ximo de detalles por factura

-- Inicializar contador
DECLARE @contador INT = 1;

-- Bucle para insertar registros en la tabla Facturas y detalles de factura
WHILE @contador <= @CantidadRegistros_Facturas
BEGIN
    -- Generar una fecha aleatoria dentro del rango especificado
    DECLARE @FechaAleatoria DATETIME;
    SET @FechaAleatoria = DATEADD(second, RAND() * DATEDIFF(second, @FechaInicial, @FechaFinal), @FechaInicial);

    -- Insertar en la tabla Facturas
    INSERT INTO Facturas (cliente_id, vendedor_id, entregador_id, fecha_factura, tipo_pago_id, tipo_compra_id, monto_total)
    VALUES (
        (SELECT TOP 1 cliente_id FROM Clientes ORDER BY NEWID()),   -- cliente_id (seleccionar un cliente aleatorio)
        (SELECT TOP 1 vendedor_id FROM Vendedores ORDER BY NEWID()),  -- vendedor_id (seleccionar un vendedor aleatorio)
        (SELECT TOP 1 entregador_id FROM Entregadores ORDER BY NEWID()),  -- entregador_id (seleccionar un entregador aleatorio)
        @FechaAleatoria,                -- fecha_factura (fecha aleatoria)
        (SELECT TOP 1 tipo_pago_id FROM TipoPagos ORDER BY NEWID()), -- tipo_pago_id (seleccionar un tipo de pago aleatorio)
        (SELECT TOP 1 tipo_compra_id FROM TipoCompra ORDER BY NEWID()), -- tipo_compra_id (seleccionar un tipo de compra aleatorio)
        ROUND(RAND() * 200, 2)         -- monto_total (n�meros aleatorios entre 0 y 200)
    );

    -- Obtener el ID de la factura reci�n insertada
    DECLARE @FacturaID INT = SCOPE_IDENTITY();

    -- Generar un n�mero aleatorio de detalles para esta factura
    DECLARE @CantidadDetalles INT;
    SET @CantidadDetalles = CAST(RAND() * @MaxDetallesPorFactura AS INT) + 1;

    -- Insertar detalles de factura para la factura actual
    DECLARE @ContadorDetalle INT = 1;
    WHILE @ContadorDetalle <= @CantidadDetalles
    BEGIN
        -- Insertar detalle de factura
        INSERT INTO DetalleFactura (factura_id, producto_id, cantidad, precio_unitario, monto_subtotal)
        VALUES (
            @FacturaID,                      -- factura_id (id de factura reci�n insertada)
            (SELECT TOP 1 producto_id FROM Productos ORDER BY NEWID()),  -- producto_id (seleccionar un producto aleatorio)
            CAST(RAND() * 5 AS INT) + 1,    -- cantidad (n�meros aleatorios entre 1 y 5)
            (SELECT precio FROM Productos WHERE producto_id = (SELECT TOP 1 producto_id FROM Productos ORDER BY NEWID())), -- precio_unitario (obtener el precio del producto seleccionado)
            0                               -- monto_subtotal (inicializar con 0)
        );
        
        SET @ContadorDetalle = @ContadorDetalle + 1;
    END;

    SET @contador = @contador + 1;
END;



-- Declaraci�n de variables
DECLARE @FechaAleatoria DATETIME;
DECLARE @MaxDetallesPorFactura INT;
DECLARE @contador INT;

-- Asignar valores a las variables
-- Puedes cambiar estas asignaciones seg�n tus necesidades
SET @FechaAleatoria = GETDATE(); -- Ejemplo de asignaci�n a la fecha actual
SET @MaxDetallesPorFactura = 10; -- Ejemplo de asignaci�n a 10
SET @contador = 0; -- Inicializar contador a 0

-- Ejemplo de una consulta utilizando las variables
-- Supongamos que tienes una tabla llamada Facturas y otra llamada DetallesFactura

-- Consulta para obtener facturas y sus detalles, limitando el n�mero de detalles por factura
SELECT 
    f.FacturaID, 
    f.Fecha, 
    d.DetalleID, 
    d.ProductoID, 
    d.Cantidad 
FROM 
    Facturas f
JOIN 
    DetallesFactura d ON f.FacturaID = d.FacturaID
WHERE 
    d.Fecha = @FechaAleatoria -- Filtrar por la fecha aleatoria
ORDER BY 
    f.Fecha, d.DetalleID;

-- Ejemplo de l�gica adicional usando @MaxDetallesPorFactura y @contador
-- Supongamos que quieres limitar el n�mero de detalles por factura

-- Cursor para recorrer las facturas
DECLARE factura_cursor CURSOR FOR
SELECT FacturaID
FROM Facturas
ORDER BY Fecha;

OPEN factura_cursor;
FETCH NEXT FROM factura_cursor INTO @contador;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Aqu� puedes poner la l�gica para procesar cada factura
    -- Por ejemplo, contar los detalles y limitar a @MaxDetallesPorFactura
    PRINT 'Procesando factura ' + CAST(@contador AS VARCHAR);

    FETCH NEXT FROM factura_cursor INTO @contador;
END

CLOSE factura_cursor;
DEALLOCATE factura_cursor;



-- Seleccionar todos los productos
SELECT * FROM Productos;

-- Crear una vista para mostrar las facturas de un cliente
CREATE VIEW VistaFacturasCliente AS
SELECT f.factura_id, f.fecha_factura, f.monto_total, c.nombre AS cliente_nombre, c.apellido AS cliente_apellido
FROM Facturas f
JOIN Clientes c ON f.cliente_id = c.cliente_id;


-- Seleccionar todos los productos
SELECT * FROM VistaFacturasCliente;



-- Preguntas y Consultas para Test de An�lisis de Datos con SQL Server

-- 1. Sentencias b�sicas (SELECT, INSERT, UPDATE, DELETE)

-- a) Selecciona todos los clientes del sector "Los Alcarrizos".
SELECT * FROM Clientes c
JOIN Sector s ON c.sector_id = s.sector_id
WHERE s.nombre = 'Los Alcarrizos';

-- b) Inserta un nuevo producto en la tabla Productos.
INSERT INTO Productos (producto_id, nombre, descripcion, precio, cantidad_disponible)
VALUES (101, 'Hamburguesa Especial', 'Hamburguesa con doble carne y queso', 250.00, 100);

-- c) Actualiza el precio de todos los productos, aument�ndolo en un 10%.
UPDATE Productos
SET precio = precio * 1.10;

-- d) Elimina todas las facturas con m�s de un a�o de antig�edad.
DELETE FROM Facturas
WHERE fecha_factura < DATEADD(YEAR, -1, GETDATE());

-- 2. Funciones integradas

-- a) Calcula el promedio de ventas diarias del �ltimo mes.
SELECT AVG(monto_total) as promedio_ventas_diarias
FROM Facturas
WHERE fecha_factura >= DATEADD(MONTH, -1, GETDATE())
GROUP BY CAST(fecha_factura AS DATE);

-- b) Encuentra el producto m�s vendido y el menos vendido.
WITH ProductoVentas AS (
    SELECT p.producto_id, p.nombre,
           SUM(df.cantidad) as total_vendido
    FROM Productos p
    LEFT JOIN DetalleFactura df ON p.producto_id = df.producto_id
    GROUP BY p.producto_id, p.nombre
)
SELECT TOP 1 nombre as producto_mas_vendido, total_vendido
FROM ProductoVentas
ORDER BY total_vendido DESC;

SELECT TOP 1 nombre as producto_menos_vendido, total_vendido
FROM ProductoVentas
ORDER BY total_vendido ASC;

-- c) Lista los 5 clientes que han realizado m�s compras, ordenados de mayor a menor.
SELECT TOP 5 c.nombre, c.apellido, COUNT(f.factura_id) as total_compras
FROM Clientes c
JOIN Facturas f ON c.cliente_id = f.cliente_id
GROUP BY c.cliente_id, c.nombre, c.apellido
ORDER BY total_compras DESC;

-- d) Calcula la diferencia en d�as entre la primera y la �ltima venta.
SELECT DATEDIFF(DAY, MIN(fecha_factura), MAX(fecha_factura)) as dias_entre_ventas
FROM Facturas;

-- 3. Consultas avanzadas con JOINs

-- a) Obt�n un reporte de ventas que incluya: ID de factura, nombre del cliente, nombre del vendedor, 
--    fecha de la factura, monto total y m�todo de pago.
SELECT f.factura_id, 
       CONCAT(c.nombre, ' ', c.apellido) as cliente,
       CONCAT(v.nombre, ' ', v.apellido) as vendedor,
       f.fecha_factura,
       f.monto_total,
       tp.nombre as metodo_pago
FROM Facturas f
INNER JOIN Clientes c ON f.cliente_id = c.cliente_id
INNER JOIN Vendedores v ON f.vendedor_id = v.vendedor_id
INNER JOIN TipoPagos tp ON f.tipo_pago_id = tp.tipo_pago_id;

-- b) Genera un informe de productos vendidos por sector, incluyendo el nombre del producto, 
--    la cantidad vendida y el nombre del sector.
SELECT p.nombre as producto, 
       SUM(df.cantidad) as cantidad_vendida,
       s.nombre as sector
FROM DetalleFactura df
INNER JOIN Facturas f ON df.factura_id = f.factura_id
INNER JOIN Clientes c ON f.cliente_id = c.cliente_id
INNER JOIN Sector s ON c.sector_id = s.sector_id
INNER JOIN Productos p ON df.producto_id = p.producto_id
GROUP BY p.nombre, s.nombre
ORDER BY s.nombre, cantidad_vendida DESC;

-- c) Crea una vista que muestre el rendimiento de los entregadores, incluyendo el n�mero de entregas, 
--    el monto total entregado y el tiempo promedio de entrega.
CREATE VIEW RendimientoEntregadores AS
SELECT e.entregador_id,
       CONCAT(e.nombre, ' ', e.apellido) as entregador,
       COUNT(f.factura_id) as numero_entregas,
       SUM(f.monto_total) as monto_total_entregado,
       AVG(DATEDIFF(MINUTE, f.fecha_factura, f.fecha_entrega)) as tiempo_promedio_entrega
FROM Entregadores e
LEFT JOIN Facturas f ON e.entregador_id = f.entregador_id
GROUP BY e.entregador_id, e.nombre, e.apellido;

-- 4. Consultas con subconsultas y funciones avanzadas

-- a) Encuentra los clientes que han realizado compras por encima del promedio general.
SELECT c.cliente_id, c.nombre, c.apellido, AVG(f.monto_total) as promedio_compras
FROM Clientes c
INNER JOIN Facturas f ON c.cliente_id = f.cliente_id
GROUP BY c.cliente_id, c.nombre, c.apellido
HAVING AVG(f.monto_total) > (SELECT AVG(monto_total) FROM Facturas);

-- b) Calcula el porcentaje de ventas de cada producto respecto al total de ventas.
WITH VentasTotales AS (
    SELECT SUM(monto_total) as total_ventas FROM Facturas
)
SELECT p.nombre as producto,
       SUM(df.cantidad * df.precio_unitario) as ventas_producto,
       (SUM(df.cantidad * df.precio_unitario) / (SELECT total_ventas FROM VentasTotales)) * 100 as porcentaje_ventas
FROM Productos p
INNER JOIN DetalleFactura df ON p.producto_id = df.producto_id
GROUP BY p.producto_id, p.nombre
ORDER BY porcentaje_ventas DESC;

-- c) Identifica los sectores con mayor y menor crecimiento en ventas comparando el �ltimo mes con el mes anterior.
WITH VentasPorSectorMes AS (
    SELECT s.sector_id, s.nombre as sector,
           YEAR(f.fecha_factura) as anio,
           MONTH(f.fecha_factura) as mes,
           SUM(f.monto_total) as ventas_totales
    FROM Facturas f
    INNER JOIN Clientes c ON f.cliente_id = c.cliente_id
    INNER JOIN Sector s ON c.sector_id = s.sector_id
    WHERE f.fecha_factura >= DATEADD(MONTH, -2, GETDATE())
    GROUP BY s.sector_id, s.nombre, YEAR(f.fecha_factura), MONTH(f.fecha_factura)
)
SELECT v1.sector,
       v1.ventas_totales as ventas_mes_actual,
       v2.ventas_totales as ventas_mes_anterior,
       ((v1.ventas_totales - v2.ventas_totales) / v2.ventas_totales) * 100 as porcentaje_crecimiento
FROM VentasPorSectorMes v1
JOIN VentasPorSectorMes v2 ON v1.sector_id = v2.sector_id
    AND v1.anio = v2.anio
    AND v1.mes = v2.mes + 1
ORDER BY porcentaje_crecimiento DESC;

-- 5. Preguntas adicionales

-- a) �C�mo optimizar�as la consulta de rendimiento de entregadores si la tabla de Facturas creciera significativamente?
-- b) Dise�a una estrategia para implementar un sistema de recomendaci�n de productos basado en el historial de compras de los clientes.
-- c) Prop�n una modificaci�n al esquema actual para incluir un sistema de lealtad de clientes con puntos por compra.
-- d) �C�mo implementar�as un an�lisis de series temporales para predecir las ventas futuras bas�ndote en los datos hist�ricos?
-- e) Dise�a una consulta para identificar patrones de compra inusuales que podr�an indicar fraude.