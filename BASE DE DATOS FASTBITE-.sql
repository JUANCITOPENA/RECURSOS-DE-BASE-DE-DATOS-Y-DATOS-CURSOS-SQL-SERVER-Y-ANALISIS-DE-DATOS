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
    factura_id INT IDENTITY(1,1) PRIMARY KEY,
    cliente_id INT FOREIGN KEY REFERENCES Clientes(cliente_id),
    vendedor_id INT FOREIGN KEY REFERENCES Vendedores(vendedor_id),
    entregador_id INT FOREIGN KEY REFERENCES Entregadores(entregador_id),
    fecha_factura DATETIME,
    tipo_pago_id INT FOREIGN KEY REFERENCES TipoPagos(tipo_pago_id),
    tipo_compra_id INT FOREIGN KEY REFERENCES TipoCompra(tipo_compra_id),
    monto_total DECIMAL(10, 2)
);

CREATE TABLE DetallesFacturas (
    detalle_id INT IDENTITY(1,1) PRIMARY KEY,
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


select * from Productos


select * from Facturas
select * from DetallesFacturas 


-- Declaraci�n de variables
DECLARE @FechaAleatoria DATETIME;
DECLARE @MaxDetallesPorFactura INT;
DECLARE @contador INT;
DECLARE @FacturaID INT;
DECLARE @ClienteID INT;
DECLARE @VendedorID INT;
DECLARE @EntregadorID INT;
DECLARE @TipoPagoID INT;
DECLARE @TipoCompraID INT;
DECLARE @MontoTotal DECIMAL(10, 2);
DECLARE @ProductoID INT;
DECLARE @Cantidad INT;
DECLARE @PrecioUnitario DECIMAL(10, 2);
DECLARE @MontoSubtotal DECIMAL(10, 2);

-- Asignar valores a las variables
SET @FechaAleatoria = GETDATE(); -- Asignar la fecha actual
SET @MaxDetallesPorFactura = 10; -- M�ximo de detalles por factura
SET @contador = 0; -- Inicializar contador

-- Bucle para insertar facturas
WHILE @contador < 1000 -- Inserta 100 facturas aleatorias
BEGIN
    -- Obtener valores aleatorios para la factura
    SET @ClienteID = (SELECT TOP 1 cliente_id FROM Clientes ORDER BY NEWID());
    SET @VendedorID = (SELECT TOP 1 vendedor_id FROM Vendedores ORDER BY NEWID());
    SET @EntregadorID = (SELECT TOP 1 entregador_id FROM Entregadores ORDER BY NEWID());
    SET @TipoPagoID = (SELECT TOP 1 tipo_pago_id FROM TipoPagos ORDER BY NEWID());
    SET @TipoCompraID = (SELECT TOP 1 tipo_compra_id FROM TipoCompra ORDER BY NEWID());
    SET @MontoTotal = 0;

    -- Insertar en la tabla Facturas
    INSERT INTO Facturas (cliente_id, vendedor_id, entregador_id, fecha_factura, tipo_pago_id, tipo_compra_id, monto_total)
    VALUES (@ClienteID, @VendedorID, @EntregadorID, @FechaAleatoria, @TipoPagoID, @TipoCompraID, @MontoTotal);

    -- Obtener el ID de la factura reci�n insertada
    SET @FacturaID = SCOPE_IDENTITY();

    DECLARE @ContadorDetalle INT;
    SET @ContadorDetalle = 0;

    -- Bucle para insertar detalles de factura
    WHILE @ContadorDetalle < @MaxDetallesPorFactura
    BEGIN
        -- Obtener valores aleatorios para el detalle de factura
        SET @ProductoID = (SELECT TOP 1 producto_id FROM Productos ORDER BY NEWID());
        SET @Cantidad = CAST(RAND() * 5 AS INT) + 1;
        SET @PrecioUnitario = (SELECT precio FROM Productos WHERE producto_id = @ProductoID);
        SET @MontoSubtotal = @Cantidad * @PrecioUnitario;

        -- Insertar en la tabla DetallesFacturas
        INSERT INTO DetallesFacturas (factura_id, producto_id, cantidad, precio_unitario, monto_subtotal)
        VALUES (@FacturaID, @ProductoID, @Cantidad, @PrecioUnitario, @MontoSubtotal);

        -- Incrementar el monto total de la factura
        SET @MontoTotal = @MontoTotal + @MontoSubtotal;

        -- Incrementar el contador de detalles
        SET @ContadorDetalle = @ContadorDetalle + 1;
    END;

    -- Actualizar el monto total de la factura
    UPDATE Facturas
    SET monto_total = @MontoTotal
    WHERE factura_id = @FacturaID;

    -- Incrementar el contador de facturas
    SET @contador = @contador + 1;
END;


select * from Facturas
select * from DetallesFacturas 

DELETE FROM Facturas;
DELETE FROM DetallesFacturas;



-- Declaraci�n de variables
DECLARE @FechaInicial DATETIME;
DECLARE @FechaFinal DATETIME;
DECLARE @MaxDetallesPorFactura INT;
DECLARE @contador INT;
DECLARE @FacturaID INT;
DECLARE @ClienteID INT;
DECLARE @VendedorID INT;
DECLARE @EntregadorID INT;
DECLARE @TipoPagoID INT;
DECLARE @TipoCompraID INT;
DECLARE @MontoTotal DECIMAL(10, 2);
DECLARE @ProductoID INT;
DECLARE @Cantidad INT;
DECLARE @PrecioUnitario DECIMAL(10, 2);
DECLARE @MontoSubtotal DECIMAL(10, 2);
DECLARE @FechaAleatoria DATETIME; -- Declarar la variable aqu�

-- Asignar valores a las variables
SET @FechaInicial = '2010-01-01'; -- Fecha inicial para las facturas (ejemplo: 1 de enero de 2023)
SET @FechaFinal = '2024-06-15';   -- Fecha final para las facturas (ejemplo: 31 de diciembre de 2023)
SET @MaxDetallesPorFactura = 10;  -- M�ximo de detalles por factura
SET @contador = 0;                 -- Inicializar contador

-- Bucle para insertar facturas
WHILE @contador < 1000 -- Inserta 1000 facturas aleatorias
BEGIN
    -- Obtener fecha aleatoria dentro del rango especificado
    SET @FechaAleatoria = DATEADD(day, RAND() * DATEDIFF(day, @FechaInicial, @FechaFinal), @FechaInicial);

    -- Obtener valores aleatorios para la factura
    SET @ClienteID = (SELECT TOP 1 cliente_id FROM Clientes ORDER BY NEWID());
    SET @VendedorID = (SELECT TOP 1 vendedor_id FROM Vendedores ORDER BY NEWID());
    SET @EntregadorID = (SELECT TOP 1 entregador_id FROM Entregadores ORDER BY NEWID());
    SET @TipoPagoID = (SELECT TOP 1 tipo_pago_id FROM TipoPagos ORDER BY NEWID());
    SET @TipoCompraID = (SELECT TOP 1 tipo_compra_id FROM TipoCompra ORDER BY NEWID());
    SET @MontoTotal = 0;

    -- Insertar en la tabla Facturas
    INSERT INTO Facturas (cliente_id, vendedor_id, entregador_id, fecha_factura, tipo_pago_id, tipo_compra_id, monto_total)
    VALUES (@ClienteID, @VendedorID, @EntregadorID, @FechaAleatoria, @TipoPagoID, @TipoCompraID, @MontoTotal);

    -- Obtener el ID de la factura reci�n insertada
    SET @FacturaID = SCOPE_IDENTITY();

    DECLARE @ContadorDetalle INT;
    SET @ContadorDetalle = 0;

    -- Bucle para insertar detalles de factura
    WHILE @ContadorDetalle < @MaxDetallesPorFactura
    BEGIN
        -- Obtener valores aleatorios para el detalle de factura
        SET @ProductoID = (SELECT TOP 1 producto_id FROM Productos ORDER BY NEWID());
        SET @Cantidad = CAST(RAND() * 5 AS INT) + 1;
        SET @PrecioUnitario = (SELECT precio FROM Productos WHERE producto_id = @ProductoID);
        SET @MontoSubtotal = @Cantidad * @PrecioUnitario;

        -- Insertar en la tabla DetallesFacturas
        INSERT INTO DetallesFacturas (factura_id, producto_id, cantidad, precio_unitario, monto_subtotal)
        VALUES (@FacturaID, @ProductoID, @Cantidad, @PrecioUnitario, @MontoSubtotal);

        -- Incrementar el monto total de la factura
        SET @MontoTotal = @MontoTotal + @MontoSubtotal;

        -- Incrementar el contador de detalles
        SET @ContadorDetalle = @ContadorDetalle + 1;
    END;

    -- Actualizar el monto total de la factura
    UPDATE Facturas
    SET monto_total = @MontoTotal
    WHERE factura_id = @FacturaID;

    -- Incrementar el contador de facturas
    SET @contador = @contador + 1;
END;










--Consultas B�sicas
--Seleccionar todos los datos de la tabla Clientes:


SELECT * FROM Clientes;

--Contar el n�mero total de clientes:


SELECT COUNT(*) AS TotalClientes FROM Clientes;

SELECT COUNT(*) AS TotalVendedores FROM Vendedores;

SELECT COUNT(*) AS TotalCiudades FROM Ciudad;

SELECT COUNT(*) AS TotalEntregadores FROM Entregadores;

SELECT COUNT(*) AS TotalSectores FROM Sector;

SELECT COUNT(*) AS TotalTipo_Compra FROM TipoCompra;

SELECT COUNT(*) AS TotalTipo_Pago FROM TipoPagos;

SELECT COUNT(*) AS TotalProductos FROM Productos;

SELECT COUNT(*) AS TotalFacturas  FROM Facturas;

SELECT COUNT(*) AS TotalFacturasDetalles  FROM DetallesFacturas;


--Seleccionar los nombres de los clientes que viven en un sector espec�fico:


SELECT nombre FROM Clientes WHERE sector_id = 1;

--Obtener el total de ventas por cada vendedor:

SELECT * FROM information_schema.tables WHERE table_type = 'BASE TABLE';

SELECT 
    t.TABLE_NAME,
    c.COLUMN_NAME,
    c.DATA_TYPE,
    SUM(p.[rows]) AS NumeroRegistros
FROM 
    INFORMATION_SCHEMA.TABLES t
INNER JOIN 
    INFORMATION_SCHEMA.COLUMNS c ON t.TABLE_NAME = c.TABLE_NAME
LEFT JOIN 
    sys.partitions p ON OBJECT_ID(t.TABLE_SCHEMA + '.' + t.TABLE_NAME) = p.OBJECT_ID
WHERE 
    t.TABLE_TYPE = 'BASE TABLE'
GROUP BY 
    t.TABLE_NAME, c.COLUMN_NAME, c.DATA_TYPE
ORDER BY 
    t.TABLE_NAME;



SELECT vendedor_id, SUM(monto_total) AS TotalVentas
FROM Facturas
GROUP BY vendedor_id;

--Seleccionar las facturas emitidas en el �ltimo mes:


SELECT * FROM Facturas
WHERE fecha_factura BETWEEN DATEADD(MONTH, -1, GETDATE()) AND GETDATE();

--Obtener el nombre del cliente y el monto total de sus facturas:


SELECT c.nombre, f.monto_total
FROM Clientes c
JOIN Facturas f ON c.cliente_id = f.cliente_id;

--Seleccionar los productos cuyo precio sea mayor a 100:


SELECT * FROM Productos
WHERE precio > 100;

--Contar el n�mero de facturas por cada tipo de pago:


SELECT tipo_pago_id, COUNT(*) AS NumFacturas
FROM Facturas
GROUP BY tipo_pago_id;

--Obtener el promedio de la cantidad de productos en los detalles de facturas:


SELECT AVG(cantidad) AS PromedioCantidad
FROM DetallesFacturas;

--Seleccionar los clientes cuyo nombre empiece con 'A':


SELECT * FROM Clientes
WHERE nombre LIKE 'A%';

--Obtener el m�ximo y m�nimo monto total de las facturas:


SELECT MAX(monto_total) AS MaxMonto, MIN(monto_total) AS MinMonto
FROM Facturas;

--Seleccionar las facturas ordenadas por fecha:


SELECT * FROM Facturas
ORDER BY fecha_factura DESC;

--Obtener el nombre de los productos y su precio con un descuento del 10%:


SELECT nombre, precio, precio * 0.9 AS PrecioConDescuento
FROM Productos;

--Contar el n�mero de productos en cada factura:


SELECT factura_id, COUNT(*) AS NumProductos
FROM DetallesFacturas
GROUP BY factura_id;

--Seleccionar las facturas cuyo monto total est� entre 100 y 500:

SELECT * FROM Facturas
WHERE monto_total BETWEEN 100 AND 500;


--Consultas Avanzadas

--Obtener el top 5 de productos m�s vendidos:


SELECT TOP 5 producto_id, SUM(cantidad) AS TotalVendidos
FROM DetallesFacturas
GROUP BY producto_id
ORDER BY TotalVendidos DESC;

--Calcular el monto total de ventas por mes:


SELECT YEAR(fecha_factura) AS A�o, MONTH(fecha_factura) AS Mes, SUM(monto_total) AS TotalVentas
FROM Facturas
GROUP BY YEAR(fecha_factura), MONTH(fecha_factura)
ORDER BY A�o, Mes;

--Obtener el porcentaje de ventas por tipo de pago:


SELECT tipo_pago_id, 
       SUM(monto_total) AS TotalVentas, 
       SUM(monto_total) * 100.0 / (SELECT SUM(monto_total) FROM Facturas) AS PorcentajeVentas
FROM Facturas
GROUP BY tipo_pago_id;

--Seleccionar los clientes que han hecho m�s de 5 compras:


SELECT cliente_id, COUNT(*) AS NumCompras
FROM Facturas
GROUP BY cliente_id
HAVING COUNT(*) > 5;

--Obtener las ventas promedio diarias:


SELECT AVG(DailySales) AS VentasDiariasPromedio
FROM (
    SELECT CAST(fecha_factura AS DATE) AS Fecha, SUM(monto_total) AS DailySales
    FROM Facturas
    GROUP BY CAST(fecha_factura AS DATE)
) AS DailySales;

--Calcular el monto total de ventas por sector:



SELECT s.nombre, SUM(f.monto_total) AS TotalVentas
FROM Facturas f
JOIN Clientes c ON f.cliente_id = c.cliente_id
JOIN Sector s ON c.sector_id = s.sector_id
GROUP BY s.nombre;

--Obtener el rango de ventas de los vendedores:


SELECT vendedor_id, 
       SUM(monto_total) AS TotalVentas,
       RANK() OVER (ORDER BY SUM(monto_total) DESC) AS VentasRank
FROM Facturas
GROUP BY vendedor_id;

--Seleccionar las facturas con un monto total superior al promedio:


SELECT * FROM Facturas
WHERE monto_total > (SELECT AVG(monto_total) FROM Facturas);

-- el promedio, m�nimo y m�ximo monto de las facturas por tipo de pago:


SELECT tipo_pago_id, 
       AVG(monto_total) AS PromedioMonto, 
       MIN(monto_total) AS MinMonto, 
       MAX(monto_total) AS MaxMonto
FROM Facturas
GROUP BY tipo_pago_id;

--Contar el n�mero de productos vendidos por categor�a:


SELECT p.categoria, COUNT(df.producto_id) AS NumProductosVendidos
FROM DetallesFacturas df
JOIN Productos p ON df.producto_id = p.producto_id
GROUP BY p.categoria;

--Obtener el nombre del cliente y la cantidad de facturas que ha realizado:


SELECT c.nombre, COUNT(f.factura_id) AS NumFacturas
FROM Clientes c
JOIN Facturas f ON c.cliente_id = f.cliente_id
GROUP BY c.nombre;

--Seleccionar las ventas totales y promedio por vendedor y mes:


SELECT vendedor_id, 
       YEAR(fecha_factura) AS A�o, 
       MONTH(fecha_factura) AS Mes, 
       SUM(monto_total) AS TotalVentas,
       AVG(monto_total) AS PromedioVentas
FROM Facturas
GROUP BY vendedor_id, YEAR(fecha_factura), MONTH(fecha_factura);

--Calcular el monto total de ventas acumulado por d�a:


SELECT Fecha, SUM(monto_total) OVER (ORDER BY Fecha) AS VentasAcumuladas
FROM (
    SELECT CAST(fecha_factura AS DATE) AS Fecha, SUM(monto_total) AS monto_total
    FROM Facturas
    GROUP BY CAST(fecha_factura AS DATE)
) AS DailySales;

--Obtener el top 3 de clientes con m�s facturas:


SELECT TOP 3 cliente_id, COUNT(*) AS NumFacturas
FROM Facturas
GROUP BY cliente_id
ORDER BY NumFacturas DESC;

--Calcular el �ndice ABC de productos:


WITH ProductoVentas AS (
    SELECT producto_id, SUM(cantidad) AS TotalVendidos
    FROM DetallesFacturas
    GROUP BY producto_id
),
ProductoRank AS (
    SELECT producto_id, TotalVendidos,
           SUM(TotalVendidos) OVER (ORDER BY TotalVendidos DESC) * 1.0 /
           SUM(TotalVendidos) OVER () AS CumulativePercentage
    FROM ProductoVentas
)
SELECT producto_id, TotalVendidos,
       CASE
           WHEN CumulativePercentage <= 0.8 THEN 'A'
           WHEN CumulativePercentage <= 0.95 THEN 'B'
           ELSE 'C'
       END AS CategoriaABC
FROM ProductoRank;


-- Vistas
-- Vista de Ventas Totales por Vendedor y Mes:


CREATE VIEW VentasPorVendedorMes AS
SELECT vendedor_id, 
       YEAR(fecha_factura) AS A�o, 
       MONTH(fecha_factura) AS Mes, 
       SUM(monto_total) AS TotalVentas,
       AVG(monto_total) AS PromedioVentas
FROM Facturas
GROUP BY vendedor_id, YEAR(fecha_factura), MONTH(fecha_factura);

SELECT * FROM VentasPorVendedorMes


--Vista de Ventas Totales por Sector:


CREATE VIEW VentasPorSector AS
SELECT s.nombre AS Sector, SUM(f.monto_total) AS TotalVentas
FROM Facturas f
JOIN Clientes c ON f.cliente_id = c.cliente