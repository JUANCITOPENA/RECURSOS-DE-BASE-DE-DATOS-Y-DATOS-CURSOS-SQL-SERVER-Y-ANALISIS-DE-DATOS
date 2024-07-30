-- Crear la base de datos
CREATE DATABASE ReclamosBancarios;
GO

-- Usar la base de datos
USE ReclamosBancarios;
GO

-- Crear la tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    nombre_cliente VARCHAR(100) NOT NULL,
    tipo_cliente VARCHAR(50) NOT NULL
);
GO

-- Crear la tabla Reclamos
CREATE TABLE Reclamos (
    id_reclamo INT PRIMARY KEY IDENTITY(1,1),
    fecha_reclamo DATE NOT NULL,
    id_cliente INT NOT NULL,
    categoria_reclamo VARCHAR(50) NOT NULL,
    descripcion_reclamo TEXT NOT NULL,
    monto_involucrado DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);
GO

-- Crear la tabla Resoluciones
CREATE TABLE Resoluciones (
    id_resolucion INT PRIMARY KEY IDENTITY(1,1),
    id_reclamo INT NOT NULL,
    estado_reclamo VARCHAR(50) NOT NULL,
    fecha_resolucion DATE,
    solucion_ofrecida TEXT,
    comentarios_adicionales TEXT,
    FOREIGN KEY (id_reclamo) REFERENCES Reclamos(id_reclamo)
);
GO

-- Crear índices en las columnas utilizadas frecuentemente en consultas
CREATE INDEX idx_fecha_reclamo ON Reclamos(fecha_reclamo);
CREATE INDEX idx_estado_reclamo ON Resoluciones(estado_reclamo);
GO



-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (nombre_cliente, tipo_cliente) VALUES 
('Juan Perez', 'Individual'),
('Maria Garcia', 'Individual'),
('Carlos Fernandez', 'Empresa'),
('Ana Rodriguez', 'Individual'),
('Luis Martinez', 'Empresa'),
('Carmen Lopez', 'Individual'),
('Jose Sanchez', 'Empresa'),
('Laura Diaz', 'Individual'),
('Fernando Gomez', 'Individual'),
('Sofia Romero', 'Individual'),
('Miguel Torres', 'Empresa'),
('Teresa Alvarez', 'Individual'),
('Andres Ruiz', 'Empresa'),
('Patricia Jimenez', 'Individual'),
('Alejandro Gutierrez', 'Individual'),
('Lucia Hernandez', 'Empresa'),
('Pedro Castro', 'Individual'),
('Elena Morales', 'Individual'),
('Jorge Herrera', 'Empresa'),
('Marta Vargas', 'Individual');
GO

-- Insertar datos en la tabla Reclamos
INSERT INTO Reclamos (fecha_reclamo, id_cliente, categoria_reclamo, descripcion_reclamo, monto_involucrado) VALUES 
('2024-01-15', 1, 'Fraude', 'Cargo no reconocido en la tarjeta de crédito', 500.00),
('2024-02-10', 2, 'Errores en la cuenta', 'Depósito no reflejado en la cuenta', 1200.00),
('2024-03-05', 3, 'Servicio al cliente', 'Mal trato en la sucursal', NULL),
('2024-04-20', 4, 'Fraude', 'Transferencia no autorizada', 300.00),
('2024-05-12', 5, 'Errores en la cuenta', 'Doble cargo en la tarjeta de débito', 150.00),
('2024-06-15', 6, 'Servicio al cliente', 'Tardanza en la resolución de problemas', NULL),
('2024-07-08', 7, 'Fraude', 'Phishing', 750.00),
('2024-08-23', 8, 'Errores en la cuenta', 'Error en el saldo disponible', 200.00),
('2024-09-14', 9, 'Servicio al cliente', 'Información incorrecta proporcionada', NULL),
('2024-10-01', 10, 'Fraude', 'Robo de identidad', 1000.00),
('2024-11-11', 11, 'Errores en la cuenta', 'Transferencia no realizada', 400.00),
('2024-12-19', 12, 'Servicio al cliente', 'Larga espera en atención telefónica', NULL),
('2024-01-03', 13, 'Fraude', 'Compra no autorizada', 250.00),
('2024-02-14', 14, 'Errores en la cuenta', 'Cobro de comisiones no justificadas', 75.00),
('2024-03-22', 15, 'Servicio al cliente', 'Actitud poco profesional del personal', NULL),
('2024-04-30', 16, 'Fraude', 'Uso indebido de tarjeta de crédito', 600.00),
('2024-05-18', 17, 'Errores en la cuenta', 'Pago no reflejado en el préstamo', 1300.00),
('2024-06-25', 18, 'Servicio al cliente', 'Error en la apertura de cuenta', NULL),
('2024-07-12', 19, 'Fraude', 'Transacción sospechosa', 850.00),
('2024-08-29', 20, 'Errores en la cuenta', 'Problemas con el cajero automático', 100.00);
GO

-- Insertar datos en la tabla Resoluciones
INSERT INTO Resoluciones (id_reclamo, estado_reclamo, fecha_resolucion, solucion_ofrecida, comentarios_adicionales) VALUES 
(1, 'Resuelto', '2024-01-20', 'Reembolso del monto afectado', 'Cliente satisfecho con la solución'),
(2, 'Resuelto', '2024-02-15', 'Actualización del saldo', 'Error corregido en el sistema'),
(3, 'Cerrado', '2024-03-10', 'Disciplina al empleado', 'Cliente notificado de las acciones tomadas'),
(4, 'Resuelto', '2024-04-25', 'Reembolso y bloqueo de la cuenta', 'Medidas de seguridad mejoradas'),
(5, 'Resuelto', '2024-05-17', 'Corrección del doble cargo', 'Cliente informado de la corrección'),
(6, 'Cerrado', '2024-06-20', 'Mejoras en el proceso de atención', 'Cliente informado de las mejoras'),
(7, 'Resuelto', '2024-07-13', 'Reembolso y cambio de tarjeta', 'Cliente satisfecho con la solución'),
(8, 'Resuelto', '2024-08-28', 'Corrección del saldo', 'Error corregido en el sistema'),
(9, 'Cerrado', '2024-09-19', 'Capacitación al personal', 'Cliente informado de las acciones tomadas'),
(10, 'Resuelto', '2024-10-06', 'Reembolso y medidas de seguridad', 'Cliente satisfecho con la solución'),
(11, 'Resuelto', '2024-11-16', 'Realización de la transferencia', 'Cliente informado de la corrección'),
(12, 'Cerrado', '2024-12-24', 'Mejoras en el tiempo de espera', 'Cliente informado de las mejoras'),
(13, 'Resuelto', '2024-01-08', 'Reembolso del monto afectado', 'Cliente satisfecho con la solución'),
(14, 'Resuelto', '2024-02-19', 'Devolución de comisiones', 'Cliente informado de la corrección'),
(15, 'Cerrado', '2024-03-27', 'Capacitación al personal', 'Cliente informado de las acciones tomadas'),
(16, 'Resuelto', '2024-05-05', 'Reembolso y cambio de tarjeta', 'Cliente satisfecho con la solución'),
(17, 'Resuelto', '2024-06-01', 'Actualización del saldo del préstamo', 'Error corregido en el sistema'),
(18, 'Cerrado', '2024-07-01', 'Mejoras en el proceso de apertura', 'Cliente informado de las mejoras'),
(19, 'Resuelto', '2024-07-17', 'Reembolso y bloqueo de la cuenta', 'Cliente satisfecho con la solución'),
(20, 'Resuelto', '2024-09-03', 'Corrección del problema del cajero', 'Cliente informado de la corrección');
GO


--Consultas básicas y avanzadas que puedes realizar sobre la base de datos ReclamosBancarios que acabamos de crear:

--Consultas Básicas: Listar todos los clientes:

SELECT * FROM Clientes;

--Listar todos los reclamos:

SELECT * FROM Reclamos;

--Listar todas las resoluciones:

SELECT * FROM Resoluciones;

--Listar los reclamos resueltos junto con sus resoluciones correspondientes:


SELECT r.*, rs.*
FROM Reclamos r
INNER JOIN Resoluciones rs ON r.id_reclamo = rs.id_reclamo
WHERE rs.estado_reclamo = 'Resuelto';

---Contar la cantidad total de reclamos:

SELECT COUNT(*) AS Total_Reclamos FROM Reclamos;

--Consultas Avanzadas:Encontrar los clientes con más reclamos:

SELECT c.nombre_cliente, COUNT(r.id_reclamo) AS Total_Reclamos
FROM Clientes c
LEFT JOIN Reclamos r ON c.id_cliente = r.id_cliente
GROUP BY c.nombre_cliente
ORDER BY Total_Reclamos DESC;

--Calcular el monto total de reclamos involucrados:


SELECT SUM(monto_involucrado) AS Monto_Total_Reclamos FROM Reclamos;

--Encontrar la fecha del primer reclamo de cada cliente:


SELECT c.nombre_cliente, MIN(r.fecha_reclamo) AS Primer_Reclamo
FROM Clientes c
LEFT JOIN Reclamos r ON c.id_cliente = r.id_cliente
GROUP BY c.nombre_cliente;

--Encontrar el estado más común de los reclamos:


SELECT TOP 5 estado_reclamo, COUNT(*) AS Total
FROM Resoluciones
GROUP BY estado_reclamo
ORDER BY Total DESC;

--Calcular el promedio de días que tardan en resolver los reclamos:

SELECT AVG(DATEDIFF(day, r.fecha_reclamo, rs.fecha_resolucion)) AS Promedio_Dias_Resolucion
FROM Reclamos r
INNER JOIN Resoluciones rs ON r.id_reclamo = rs.id_reclamo
WHERE rs.estado_reclamo = 'Resuelto';

 /*
---Estas consultas deberían proporcionarte una buena base para explorar y analizar los datos en tu base de datos
ReclamosBancarios. Si necesitas más consultas o tienes requisitos específicos, no dudes en pedirme más ayuda.

*/


--consultas más avanzadas con preguntas más detalladas sobre la base de datos de reclamos bancarios:

--¿Cuál es el promedio de tiempo que tarda cada tipo de cliente en resolver sus reclamos?


SELECT c.tipo_cliente, AVG(DATEDIFF(day, r.fecha_reclamo, rs.fecha_resolucion)) AS Promedio_Dias_Resolucion
FROM Clientes c
INNER JOIN Reclamos r ON c.id_cliente = r.id_cliente
INNER JOIN Resoluciones rs ON r.id_reclamo = rs.id_reclamo
WHERE rs.estado_reclamo = 'Resuelto'
GROUP BY c.tipo_cliente;

--Esta consulta proporciona el promedio de días que tardan en resolverse los reclamos para cada tipo de cliente.

--¿Cuál es la categoría de reclamo más común para los clientes individuales?


SELECT r.categoria_reclamo, COUNT(*) AS Total
FROM Clientes c
INNER JOIN Reclamos r ON c.id_cliente = r.id_cliente
WHERE c.tipo_cliente = 'Individual'
GROUP BY r.categoria_reclamo
ORDER BY Total DESC

SELECT TOP 1 r.categoria_reclamo, COUNT(*) AS Total
FROM Clientes c
INNER JOIN Reclamos r ON c.id_cliente = r.id_cliente
WHERE c.tipo_cliente = 'Individual'
GROUP BY r.categoria_reclamo
ORDER BY Total DESC;

--Esta consulta identifica la categoría de reclamo más común entre los clientes individuales.

--¿Cuál es la proporción de reclamos resueltos en comparación con los reclamos totales por mes?


SELECT 
    MONTH(r.fecha_reclamo) AS Mes, 
    YEAR(r.fecha_reclamo) AS Año,
    COUNT(*) AS Total_Reclamos,
    SUM(CASE WHEN rs.estado_reclamo = 'Resuelto' THEN 1 ELSE 0 END) AS Reclamos_Resueltos,
    CAST(SUM(CASE WHEN rs.estado_reclamo = 'Resuelto' THEN 1 ELSE 0 END) AS DECIMAL) / COUNT(*) AS Proporcion_Resueltos
FROM Reclamos r
LEFT JOIN Resoluciones rs ON r.id_reclamo = rs.id_reclamo
GROUP BY MONTH(r.fecha_reclamo), YEAR(r.fecha_reclamo)
ORDER BY Año, Mes;

--Esta consulta muestra la proporción de reclamos resueltos en comparación con el total de reclamos por mes y año.

SELECT 
    MONTH(r.fecha_reclamo) AS Mes, 
    YEAR(r.fecha_reclamo) AS Año,
    COUNT(*) AS Total_Reclamos,
    SUM(r.monto_involucrado) AS Monto_Total,
    SUM(CASE WHEN rs.estado_reclamo = 'Resuelto' THEN 1 ELSE 0 END) AS Reclamos_Resueltos,
    CAST(SUM(CASE WHEN rs.estado_reclamo = 'Resuelto' THEN 1 ELSE 0 END) AS DECIMAL) / COUNT(*) AS Proporcion_Resueltos
FROM Reclamos r
LEFT JOIN Resoluciones rs ON r.id_reclamo = rs.id_reclamo
GROUP BY MONTH(r.fecha_reclamo), YEAR(r.fecha_reclamo)
ORDER BY Año, Mes;



--¿Cuál es la cantidad total de dinero involucrado en reclamos no resueltos por cada categoría de reclamo?


SELECT r.categoria_reclamo, SUM(r.monto_involucrado) AS Monto_Total
FROM Reclamos r
LEFT JOIN Resoluciones rs ON r.id_reclamo = rs.id_reclamo
WHERE rs.estado_reclamo IS NULL
GROUP BY r.categoria_reclamo;


--Esta consulta muestra la cantidad total de dinero involucrado en reclamos no resueltos para cada categoría de reclamo.

 SELECT r.categoria_reclamo, SUM(r.monto_involucrado) AS Monto_Total
FROM Reclamos r
WHERE NOT EXISTS (
    SELECT 1
    FROM Resoluciones rs
    WHERE rs.id_reclamo = r.id_reclamo
)
GROUP BY r.categoria_reclamo;


---¿Cuál es el día de la semana con la mayor cantidad de reclamos?


SELECT 
    DATENAME(weekday, r.fecha_reclamo) AS Dia_Semana,
    COUNT(*) AS Total_Reclamos
FROM Reclamos r
GROUP BY DATENAME(weekday, r.fecha_reclamo)
ORDER BY Total_Reclamos DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;

--Esta consulta identifica el día de la semana con la mayor cantidad de reclamos registrados.


--Consulta para que te muestre el día de la semana con la mayor cantidad de reclamos, pero de manera que se muestre cada día:
 SELECT 
    DATENAME(weekday, r.fecha_reclamo) AS Dia_Semana,
    COUNT(*) AS Total_Reclamos
FROM Reclamos r
GROUP BY DATENAME(weekday, r.fecha_reclamo)
ORDER BY Total_Reclamos DESC;


-- Insertar datos adicionales en la tabla Clientes
INSERT INTO Clientes (nombre_cliente, tipo_cliente) VALUES 
('Daniel Ramirez', 'Individual'),
('Carolina Suarez', 'Individual'),
('Ricardo Torres', 'Empresa'),
('Sandra Ortiz', 'Individual'),
('Diego Vargas', 'Empresa'),
('Julia Fernandez', 'Individual'),
('Roberto Gonzalez', 'Empresa'),
('Valeria Lopez', 'Individual'),
('Martín Sánchez', 'Individual'),
('Verónica Pérez', 'Individual'),
('Gabriel Martínez', 'Empresa'),
('Estefanía Rodríguez', 'Individual'),
('Fabián Ruiz', 'Empresa'),
('Natalia Castro', 'Individual'),
('Javier Hernández', 'Individual'),
('Liliana Martínez', 'Empresa'),
('Alejandra González', 'Individual'),
('Sebastián Pérez', 'Individual'),
('Paula Ramírez', 'Empresa'),
('Juan Pablo Díaz', 'Individual');

-- Insertar datos adicionales en la tabla Reclamos
INSERT INTO Reclamos (fecha_reclamo, id_cliente, categoria_reclamo, descripcion_reclamo, monto_involucrado) VALUES 
('2024-10-15', 1, 'Errores en la cuenta', 'Cobro duplicado en el estado de cuenta', 200.00),
('2024-11-10', 2, 'Fraude', 'Clonación de tarjeta de crédito', 800.00),
('2024-12-05', 3, 'Servicio al cliente', 'Negligencia en atención telefónica', NULL),
('2024-10-20', 4, 'Errores en la cuenta', 'Error en la tasa de interés', 150.00),
('2024-11-12', 5, 'Fraude', 'Uso indebido de cuenta bancaria', 700.00),
('2024-12-25', 6, 'Servicio al cliente', 'Problema con la transferencia electrónica', NULL),
('2024-10-08', 7, 'Errores en la cuenta', 'Cobro incorrecto de comisiones', 300.00),
('2024-11-23', 8, 'Fraude', 'Phishing por correo electrónico', 600.00),
('2024-12-10', 9, 'Servicio al cliente', 'Falta de información sobre productos', NULL),
('2024-10-05', 10, 'Errores en la cuenta', 'Cargo no reconocido en la cuenta de ahorros', 250.00),
('2024-11-20', 11, 'Fraude', 'Transacción no autorizada en la banca en línea', 900.00),
('2024-12-15', 12, 'Servicio al cliente', 'Tiempo de espera prolongado en la sucursal', NULL),
('2024-10-01', 13, 'Errores en la cuenta', 'Cambio incorrecto en la tasa de cambio', 180.00),
('2024-11-25', 14, 'Fraude', 'Compra con tarjeta de débito no autorizada', 400.00),
('2024-12-30', 15, 'Servicio al cliente', 'Problemas con la atención al cliente en línea', NULL),
('2024-10-18', 16, 'Errores en la cuenta', 'Cargos no reflejados en el estado de cuenta', 220.00),
('2024-11-15', 17, 'Fraude', 'Fraude con tarjeta de crédito en línea', 750.00),
('2024-12-28', 18, 'Servicio al cliente', 'Falta de respuesta en atención telefónica', NULL),
('2024-10-12', 19, 'Errores en la cuenta', 'Transferencia no reflejada en el saldo', 280.00),
('2024-11-30', 20, 'Fraude', 'Cobro duplicado en la tarjeta de crédito', 850.00);

-- Insertar datos adicionales en la tabla Resoluciones
INSERT INTO Resoluciones (id_reclamo, estado_reclamo, fecha_resolucion, solucion_ofrecida, comentarios_adicionales) VALUES 
(21, 'Resuelto', '2024-10-20', 'Reembolso del monto afectado', 'Cliente satisfecho con la solución'),
(22, 'Resuelto', '2024-11-15', 'Bloqueo de tarjeta y reembolso', 'Cliente informado sobre seguridad'),
(23, 'Cerrado', '2024-12-10', 'Entrenamiento al personal', 'Cliente notificado de mejoras'),
(24, 'Resuelto', '2024-10-25', 'Reversión del cargo', 'Error corregido en el sistema'),
(25, 'Resuelto', '2024-11-18', 'Reembolso del monto afectado', 'Cliente satisfecho con la solución'),
(26, 'Cerrado', '2024-12-31', 'Mejoras en la plataforma en línea', 'Cliente notificado de cambios'),
(27, 'Resuelto', '2024-10-13', 'Reembolso del monto afectado', 'Cliente satisfecho con la solución'),
(28, 'Resuelto', '2024-11-28', 'Bloqueo de la cuenta y reembolso', 'Cliente informado sobre seguridad'),
(29, 'Cerrado', '2024-12-15', 'Entrenamiento al personal', 'Cliente notificado de mejoras'),
(30, 'Resuelto', '2024-10-10', 'Reembolso del monto afectado', 'Cliente satisfecho con la solución'),
(31, 'Resuelto', '2024-11-22', 'Bloqueo de tarjeta y reembolso', 'Cliente informado sobre seguridad'),
(32, 'Cerrado', '2024-12-05', 'Entrenamiento al personal', 'Cliente notificado de mejoras'),
(33, 'Resuelto', '2024-10-05', 'Reversión del cargo', 'Error corregido en el sistema'),
(34, 'Resuelto', '2024-11-30', 'Reembolso del monto afectado', 'Cliente satisfecho con la solución'),
(35, 'Cerrado', '2024-12-20', 'Mejoras en la plataforma en línea', 'Cliente notificado de cambios'),
(36, 'Resuelto', '2024-10-18', 'Reembolso del monto afectado', 'Cliente satisfecho con la solución'),
(37, 'Resuelto', '2024-12-03', 'Bloqueo de la cuenta y reembolso', 'Cliente informado sobre seguridad'),
(38, 'Cerrado', '2024-12-25', 'Entrenamiento al personal', 'Cliente notificado de mejoras'),
(39, 'Resuelto', '2024-10-15', 'Reembolso del monto afectado', 'Cliente satisfecho con la solución'),
(40, 'Resuelto', '2024-12-01', 'Bloqueo de tarjeta y reembolso', 'Cliente informado sobre seguridad');


--Vamos a diseñar algunas tablas adicionales relacionadas con clientes y transacciones bancarias:

/*
Prestamos:
Esta tabla puede almacenar información sobre los préstamos que los clientes han adquirido. Puede 
contener detalles como el monto del préstamo, la tasa de interés, la fecha de inicio, la duración del préstamo, etc.

*/

 CREATE TABLE Prestamos (
    id_prestamo INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    monto_prestamo DECIMAL(10, 2) NOT NULL,
    tasa_interes DECIMAL(5, 2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    duracion_meses INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

/*
Cuentas de Ahorros:
Esta tabla puede almacenar información sobre las cuentas de ahorro de los clientes,
incluyendo el saldo actual, la tasa de interés, la fecha de apertura, etc.
*/

 CREATE TABLE Ahorros (
    id_ahorro INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    saldo_actual DECIMAL(10, 2) NOT NULL,
    tasa_interes DECIMAL(5, 2) NOT NULL,
    fecha_apertura DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);





/*
Retiros:
Esta tabla puede registrar los retiros realizados por los clientes de sus cuentas de ahorro.
*/
 CREATE TABLE Retiros (
    id_retiro INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    id_cuenta_ahorro INT NOT NULL,
    monto_retiro DECIMAL(10, 2) NOT NULL,
    fecha_retiro DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_cuenta_ahorro) REFERENCES Ahorros(id_ahorro)
);





/*
Hipotecas:  tabla para hipotecas sería valiosa en un sistema bancario.

*/
 CREATE TABLE Hipotecas (
    id_hipoteca INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    monto_hipoteca DECIMAL(18, 2) NOT NULL,
    tasa_interes DECIMAL(5, 2) NOT NULL,
    duracion_meses INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

  --Para la tabla de Prestamos:::

 INSERT INTO Prestamos (id_cliente, monto_prestamo, tasa_interes, fecha_inicio, duracion_meses) VALUES
(1, 15000.00, 6.5, '2023-05-10', 48),
(2, 20000.00, 7.0, '2023-07-15', 60),
(3, 25000.00, 6.0, '2023-08-20', 36),
(4, 30000.00, 5.5, '2023-09-25', 48),
(5, 20000.00, 6.25, '2023-10-30', 36),
(6, 18000.00, 6.75, '2023-11-05', 60),
(7, 22000.00, 5.75, '2023-12-10', 36),
(8, 27000.00, 5.0, '2024-01-15', 48),
(9, 16000.00, 6.25, '2024-02-20', 60),
(10, 30000.00, 5.75, '2024-03-25', 36),
(11, 25000.00, 6.0, '2024-04-30', 48),
(12, 22000.00, 6.5, '2024-05-05', 60),
(13, 18000.00, 5.5, '2024-06-10', 48),
(14, 19000.00, 6.75, '2024-07-15', 36),
(15, 32000.00, 5.0, '2024-08-20', 48),
(16, 26000.00, 6.25, '2024-09-25', 60),
(17, 23000.00, 6.0, '2024-10-30', 48),
(18, 28000.00, 5.5, '2024-11-05', 60),
(19, 21000.00, 6.75, '2024-12-10', 36),
(20, 30000.00, 5.75, '2025-01-15', 48);

 --Para la tabla de Ahorros::

 INSERT INTO Ahorros (id_cliente, saldo_actual, tasa_interes, fecha_apertura) VALUES
(1, 5000.00, 0.75, '2023-05-10'),
(2, 7500.00, 0.85, '2023-07-15'),
(3, 6000.00, 0.65, '2023-08-20'),
(4, 10000.00, 0.9, '2023-09-25'),
(5, 8000.00, 0.8, '2023-10-30'),
(6, 7000.00, 0.75, '2023-11-05'),
(7, 5500.00, 0.7, '2023-12-10'),
(8, 9500.00, 0.85, '2024-01-15'),
(9, 6300.00, 0.75, '2024-02-20'),
(10, 8500.00, 0.9, '2024-03-25'),
(11, 7200.00, 0.8, '2024-04-30'),
(12, 6800.00, 0.65, '2024-05-05'),
(13, 5600.00, 0.75, '2024-06-10'),
(14, 6100.00, 0.7, '2024-07-15'),
(15, 9000.00, 0.85, '2024-08-20'),
(16, 7300.00, 0.75, '2024-09-25'),
(17, 6700.00, 0.8, '2024-10-30'),
(18, 8100.00, 0.65, '2024-11-05'),
(19, 5800.00, 0.9, '2024-12-10'),
(20, 9400.00, 0.7, '2025-01-15');

--Para la tabla de Retiros::

  INSERT INTO Retiros (id_cliente, id_cuenta_ahorro, monto_retiro, fecha_retiro) VALUES
(1, 1, 200.00, '2023-05-12'),
(2, 2, 300.00, '2023-07-18'),
(3, 3, 250.00, '2023-08-25'),
(4, 4, 400.00, '2023-10-01'),
(5, 5, 350.00, '2023-11-06'),
(6, 6, 280.00, '2023-12-12'),
(7, 7, 320.00, '2024-01-17'),
(8, 8, 380.00, '2024-02-22'),
(9, 9, 270.00, '2024-03-27'),
(10, 10, 420.00, '2024-05-02'),
(11, 11, 310.00, '2024-06-07'),
(12, 12, 290.00, '2024-07-12'),
(13, 13, 260.00, '2024-08-17'),
(14, 14, 330.00, '2024-09-22'),
(15, 15, 390.00, '2024-10-27'),
(16, 16, 295.00, '2024-12-02'),
(17, 17, 280.00, '2025-01-07'),
(18, 18, 410.00, '2025-02-11'),
(19, 19, 350.00, '2025-03-18'),
(20, 20, 300.00, '2025-04-23');


--Para la tabla de Hipotecas:

INSERT INTO Hipotecas (id_cliente, monto_hipoteca, tasa_interes, duracion_meses, fecha_inicio) VALUES
(1, 200000.00, 4.5, 240, '2023-05-10'),
(2, 300000.00, 4.0, 360, '2023-07-15'),
(3, 250000.00, 3.75, 180, '2023-08-20'),
(4, 400000.00, 5.0, 300, '2023-09-25'),
(5, 350000.00, 4.25, 240, '2023-10-30'),
(6, 280000.00, 4.2, 360, '2023-11-05'),
(7, 320000.00, 4.75, 180, '2023-12-10'),
(8, 380000.00, 4.3, 240, '2024-01-15'),
(9, 270000.00, 3.9, 300, '2024-02-20'),
(10, 420000.00, 4.6, 180, '2024-03-25'),
(11, 310000.00, 3.8, 240, '2024-04-30'),
(12, 290000.00, 4.2, 360, '2024-05-05'),
(13, 260000.00, 4.0, 300, '2024-06-10'),
(14, 330000.00, 4.4, 180, '2024-07-15'),
(15, 390000.00, 4.7, 240, '2024-08-20'),
(16, 295000.00, 3.85, 360, '2024-09-25'),
(17, 280000.00, 4.25, 300, '2024-10-30'),
(18, 410000.00, 4.55, 180, '2024-11-05'),
(19, 350000.00, 4.1, 240, '2024-12-10'),
(20, 300000.00, 4.45, 300, '2025-01-15');




--Consultas básicas:

--Mostrar todos los clientes:


SELECT * FROM Clientes;

--Mostrar todos los préstamos:


SELECT * FROM Prestamos;

--Mostrar todos los retiros:


SELECT * FROM Retiros;

--Mostrar todos los ahorros:


SELECT * FROM Ahorros;


SELECT * FROM Reclamos;

--Mostrar la cantidad total de préstamos otorgados:


SELECT COUNT(*) AS Total_Prestamos FROM Prestamos;

--Mostrar el saldo actual de todos los ahorros:


SELECT SUM(saldo_actual) AS Total_Ahorros FROM Ahorros;

--Mostrar el monto total de todos los retiros realizados:


SELECT SUM(monto_retiro) AS Total_Retiros FROM Retiros;

--Mostrar el cliente con el préstamo más grande:


SELECT TOP 1 id_cliente, MAX(monto_prestamo) AS Monto_Prestamo
FROM Prestamos
GROUP BY id_cliente
ORDER BY Monto_Prestamo DESC;

--Mostrar el promedio de tasa de interés de todos los préstamos:


SELECT AVG(tasa_interes) AS Tasa_Interes_Promedio FROM Prestamos;

--Mostrar la fecha de apertura más reciente de una cuenta de ahorros:



SELECT MAX(fecha_apertura) AS Ultima_Apertura FROM Ahorros;

--Consultas avanzadas:

--Calcular el saldo total actual de todos los ahorros de los clientes con préstamos:



SELECT SUM(a.saldo_actual) AS Saldo_Total_Ahorros
FROM Ahorros a
INNER JOIN Clientes c ON a.id_cliente = c.id_cliente
INNER JOIN Prestamos p ON c.id_cliente = p.id_cliente;

--Encontrar el cliente con el mayor saldo de ahorros:



SELECT TOP 1 id_cliente, saldo_actual
FROM Ahorros
ORDER BY saldo_actual DESC;

--Mostrar los préstamos con una tasa de interés superior al promedio:



SELECT * FROM Prestamos
WHERE tasa_interes > (SELECT AVG(tasa_interes) FROM Prestamos);

--Calcular el saldo promedio de todas las cuentas de ahorros:



SELECT AVG(saldo_actual) AS Saldo_Promedio_Ahorros FROM Ahorros;

--Encontrar la cantidad total de retiros realizados por clientes individuales:

 SELECT c.nombre_cliente, COUNT(r.id_retiro) AS Total_Retiros
FROM Clientes c
INNER JOIN Retiros r ON c.id_cliente = r.id_cliente
GROUP BY c.nombre_cliente;

--Mostrar el cliente con el saldo de ahorros más bajo:

SELECT TOP 1 id_cliente, saldo_actual
FROM Ahorros
ORDER BY saldo_actual ASC;

--Calcular el monto total de todos los préstamos vencidos (con una duración en meses menor a 12):

SELECT SUM(monto_prestamo) AS Monto_Total_Prestamos_Vencidos
FROM Prestamos
WHERE duracion_meses < 12;

--Encontrar la cantidad total de retiros realizados en cada mes:

SELECT MONTH(fecha_retiro) AS Mes, COUNT(id_retiro) AS Total_Retiros
FROM Retiros
GROUP BY MONTH(fecha_retiro);

--Mostrar los clientes que tienen tanto préstamos como cuentas de ahorros:

SELECT c.*
FROM Clientes c
WHERE EXISTS (SELECT 1 FROM Prestamos WHERE id_cliente = c.id_cliente)
AND EXISTS (SELECT 1 FROM Ahorros WHERE id_cliente = c.id_cliente);

--Calcular el monto total de préstamos para cada cliente y ordenarlos de mayor a menor:

SELECT c.nombre_cliente, SUM(p.monto_prestamo) AS Monto_Total_Prestamos
FROM Clientes c
INNER JOIN Prestamos p ON c.id_cliente = p.id_cliente
GROUP BY c.nombre_cliente
ORDER BY Monto_Total_Prestamos DESC;


SELECT 
    c.id_cliente,
    c.nombre_cliente,
    c.tipo_cliente,
    p.id_prestamo,
    p.monto_prestamo,
    p.tasa_interes AS tasa_interes_prestamo,
    p.fecha_inicio AS fecha_inicio_prestamo,
    p.duracion_meses AS duracion_meses_prestamo,
    a.id_ahorro,
    a.saldo_actual AS saldo_ahorro,
    a.tasa_interes AS tasa_interes_ahorro,
    a.fecha_apertura AS fecha_apertura_ahorro,
    r.id_retiro,
    r.id_cuenta_ahorro,
    r.monto_retiro,
    r.fecha_retiro
FROM 
    Clientes c
LEFT JOIN 
    Prestamos p ON c.id_cliente = p.id_cliente
LEFT JOIN 
    Ahorros a ON c.id_cliente = a.id_cliente
LEFT JOIN 
    Retiros r ON a.id_ahorro = r.id_cuenta_ahorro;


	SELECT 
    c.id_cliente,
    c.nombre_cliente,
    c.tipo_cliente,
    p.id_prestamo,
    p.monto_prestamo,
    p.tasa_interes AS tasa_interes_prestamo,
    p.fecha_inicio AS fecha_inicio_prestamo,
    p.duracion_meses AS duracion_meses_prestamo,
    a.id_ahorro,
    a.saldo_actual AS saldo_ahorro,
    a.tasa_interes AS tasa_interes_ahorro,
    a.fecha_apertura AS fecha_apertura_ahorro,
    r.id_retiro,
    r.id_cuenta_ahorro,
    r.monto_retiro,
    r.fecha_retiro
FROM 
    Clientes c
LEFT JOIN 
    Prestamos p ON c.id_cliente = p.id_cliente
LEFT JOIN 
    Ahorros a ON c.id_cliente = a.id_cliente
LEFT JOIN 
    Retiros r ON a.id_ahorro = r.id_cuenta_ahorro;



SELECT 
    c.id_cliente,
    c.nombre_cliente,
    c.tipo_cliente,
    p.id_prestamo,
    p.monto_prestamo,
    p.tasa_interes AS tasa_interes_prestamo,
    p.fecha_inicio AS fecha_inicio_prestamo,
    p.duracion_meses AS duracion_meses_prestamo,
    a.id_ahorro,
    a.saldo_actual AS saldo_ahorro,
    a.tasa_interes AS tasa_interes_ahorro,
    a.fecha_apertura AS fecha_apertura_ahorro,
    r.id_retiro,
    r.id_cuenta_ahorro,
    r.monto_retiro,
    r.fecha_retiro,
    'Prestamo' AS tipo_transaccion
FROM 
    Clientes c
LEFT JOIN 
    Prestamos p ON c.id_cliente = p.id_cliente
LEFT JOIN 
    Ahorros a ON c.id_cliente = a.id_cliente
LEFT JOIN 
    Retiros r ON a.id_ahorro = r.id_cuenta_ahorro
UNION ALL
SELECT 
    c.id_cliente,
    c.nombre_cliente,
    c.tipo_cliente,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    a.id_ahorro,
    a.saldo_actual,
    a.tasa_interes,
    a.fecha_apertura,
    NULL,
    NULL,
    NULL,
    NULL,
    'Ahorro' AS tipo_transaccion
FROM 
    Clientes c
LEFT JOIN 
    Ahorros a ON c.id_cliente = a.id_cliente
UNION ALL
SELECT 
    c.id_cliente,
    c.nombre_cliente,
    c.tipo_cliente,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    r.id_retiro,
    r.id_cuenta_ahorro,
    r.monto_retiro,
    r.fecha_retiro,
    'Retiro' AS tipo_transaccion
FROM 
    Clientes c
LEFT JOIN 
    Retiros r ON c.id_cliente = r.id_cliente;





 -- Insertar transacciones para clientes sin transacciones de préstamo
INSERT INTO Prestamos (id_cliente, monto_prestamo, tasa_interes, fecha_inicio, duracion_meses)
SELECT id_cliente, 5000.00, 0.05, '2024-06-01', 12
FROM Clientes
WHERE id_cliente NOT IN (SELECT DISTINCT id_cliente FROM Prestamos);

-- Insertar transacciones para clientes sin transacciones de ahorro
INSERT INTO Ahorros (id_cliente, saldo_actual, tasa_interes, fecha_apertura)
SELECT id_cliente, 1000.00, 0.03, '2024-06-01'
FROM Clientes
WHERE id_cliente NOT IN (SELECT DISTINCT id_cliente FROM Ahorros);

-- Insertar transacciones para clientes sin transacciones de retiro
INSERT INTO Retiros (id_cliente, id_cuenta_ahorro, monto_retiro, fecha_retiro)
SELECT id_cliente, id_ahorro, 200.00, '2024-06-01'
FROM Ahorros
WHERE id_ahorro NOT IN (SELECT DISTINCT id_cuenta_ahorro FROM Retiros);



SELECT 
    c.id_cliente,
    c.nombre_cliente,
    c.tipo_cliente,
    p.id_prestamo,
    p.monto_prestamo,
    p.tasa_interes AS tasa_interes_prestamo,
    p.fecha_inicio AS fecha_inicio_prestamo,
    p.duracion_meses AS duracion_meses_prestamo,
    a.id_ahorro,
    a.saldo_actual AS saldo_ahorro,
    a.saldo_actual - COALESCE(SUM(r.monto_retiro), 0) AS monto_actual_ahorrado,
    a.tasa_interes AS tasa_interes_ahorro,
    a.fecha_apertura AS fecha_apertura_ahorro,
    r.id_retiro,
    r.id_cuenta_ahorro,
    r.monto_retiro,
    r.fecha_retiro
FROM 
    Clientes c
LEFT JOIN 
    Prestamos p ON c.id_cliente = p.id_cliente
LEFT JOIN 
    Ahorros a ON c.id_cliente = a.id_cliente
LEFT JOIN 
    Retiros r ON a.id_ahorro = r.id_cuenta_ahorro
GROUP BY
    c.id_cliente,
    c.nombre_cliente,
    c.tipo_cliente,
    p.id_prestamo,
    p.monto_prestamo,
    p.tasa_interes,
    p.fecha_inicio,
    p.duracion_meses,
    a.id_ahorro,
    a.saldo_actual,
    a.tasa_interes,
    a.fecha_apertura,
    r.id_retiro,
    r.id_cuenta_ahorro,
    r.monto_retiro,
    r.fecha_retiro;


/*

Para convertir los valores de las transacciones a pesos dominicanos utilizando una tasa de cambio del dólar,
necesitaremos la tasa de cambio actual del dólar a pesos dominicanos. Una vez que tengamos esa tasa de cambio, 
podemos multiplicar los montos en dólares por esta tasa para convertirlos a pesos dominicanos.

Aquí hay un ejemplo de cómo podríamos escribir un script SQL para realizar esta conversión. Vamos a asumir 
que la tasa de cambio es de 58 pesos dominicanos por dólar:

*/

 -- Definir la tasa de cambio del dólar a pesos dominicanos
DECLARE @tasa_cambio DECIMAL(10, 2) = 58.00;

-- Actualizar los montos de préstamo a pesos dominicanos
UPDATE Prestamos
SET monto_prestamo = monto_prestamo * @tasa_cambio;

-- Actualizar los saldos actuales de ahorro a pesos dominicanos
UPDATE Ahorros
SET saldo_actual = saldo_actual * @tasa_cambio;

-- Actualizar los montos de retiro a pesos dominicanos
UPDATE Retiros
SET monto_retiro = monto_retiro * @tasa_cambio;



SELECT 
    c.id_cliente,
    c.nombre_cliente,
    c.tipo_cliente,
    r.id_reclamo,
    r.fecha_reclamo,
    r.categoria_reclamo,
    r.descripcion_reclamo,
    r.monto_involucrado,
    rs.id_resolucion,
    rs.estado_reclamo,
    rs.fecha_resolucion,
    rs.solucion_ofrecida,
    rs.comentarios_adicionales
FROM 
    Clientes c
LEFT JOIN 
    Reclamos r ON c.id_cliente = r.id_cliente
LEFT JOIN 
    Resoluciones rs ON r.id_reclamo = rs.id_reclamo;



-- Actualizar inserción de reclamos para clientes sin reclamos registrados
UPDATE Reclamos
SET 
    fecha_reclamo = DATEADD(day, -ROUND(RAND(CHECKSUM(NEWID())) * 365, 0), GETDATE()),
    categoria_reclamo = 
        CASE 
            WHEN RAND(CHECKSUM(NEWID())) < 0.3 THEN 'Fraude'
            WHEN RAND(CHECKSUM(NEWID())) < 0.6 THEN 'Errores en la cuenta'
            ELSE 'Servicio al cliente'
        END,
    descripcion_reclamo = 
        CASE 
            WHEN RAND(CHECKSUM(NEWID())) < 0.3 THEN 'Transacción sospechosa'
            WHEN RAND(CHECKSUM(NEWID())) < 0.6 THEN 'Error en el saldo disponible'
            ELSE 'Problemas con la atención telefónica'
        END,
    monto_involucrado = ROUND(RAND(CHECKSUM(NEWID())) * 1000, 2)
WHERE id_cliente IN (
    SELECT id_cliente
    FROM Clientes
    WHERE id_cliente NOT IN (SELECT DISTINCT id_cliente FROM Reclamos)
);



--Consultas Básicas:
-- Listar todos los clientes:
SELECT * FROM Clientes;

-- Listar todos los reclamos:
SELECT * FROM Reclamos;

-- Listar todas las resoluciones:
SELECT * FROM Resoluciones;

-- Listar los reclamos resueltos junto con sus resoluciones correspondientes:
SELECT r.*, rs.*
FROM Reclamos r
INNER JOIN Resoluciones rs ON r.id_reclamo = rs.id_reclamo
WHERE rs.estado_reclamo = 'Resuelto';

-- Calcular la cantidad total de reclamos:
SELECT COUNT(*) AS Total_Reclamos FROM Reclamos;

--Consultas Avanzadas:

-- Encontrar los clientes con más reclamos:
SELECT c.nombre_cliente, COUNT(r.id_reclamo) AS Total_Reclamos
FROM Clientes c
LEFT JOIN Reclamos r ON c.id_cliente = r.id_cliente
GROUP BY c.nombre_cliente
ORDER BY Total_Reclamos DESC;

-- Calcular el monto total de reclamos involucrados:
SELECT SUM(monto_involucrado) AS Monto_Total_Reclamos FROM Reclamos;

-- Encontrar la fecha del primer reclamo de cada cliente:
SELECT c.nombre_cliente, MIN(r.fecha_reclamo) AS Primer_Reclamo
FROM Clientes c
LEFT JOIN Reclamos r ON c.id_cliente = r.id_cliente
GROUP BY c.nombre_cliente;

-- Encontrar el estado más común de los reclamos:
SELECT TOP 5 estado_reclamo, COUNT(*) AS Total
FROM Resoluciones
GROUP BY estado_reclamo
ORDER BY Total DESC;

-- Calcular el promedio de días que tardan en resolver los reclamos:
SELECT AVG(DATEDIFF(day, r.fecha_reclamo, rs.fecha_resolucion)) AS Promedio_Dias_Resolucion
FROM Reclamos r
INNER JOIN Resoluciones rs ON r.id_reclamo = rs.id_reclamo
WHERE rs.estado_reclamo = 'Resuelto';

-- Consultas Avanzadas con preguntas más detalladas:

-- ¿Cuál es el promedio de tiempo que tarda cada tipo de cliente en resolver sus reclamos?
SELECT c.tipo_cliente, AVG(DATEDIFF(day, r.fecha_reclamo, rs.fecha_resolucion)) AS Promedio_Dias_Resolucion
FROM Clientes c
INNER JOIN Reclamos r ON c.id_cliente = r.id_cliente
INNER JOIN Resoluciones rs ON r.id_reclamo = rs.id_reclamo
WHERE rs.estado_reclamo = 'Resuelto'
GROUP BY c.tipo_cliente;

-- ¿Cuál es la categoría de reclamo más común para los clientes individuales?
SELECT TOP 1 r.categoria_reclamo, COUNT(*) AS Total
FROM Clientes c
INNER JOIN Reclamos r ON c.id_cliente = r.id_cliente
WHERE c.tipo_cliente = 'Individual'
GROUP BY r.categoria_reclamo
ORDER BY Total DESC;

-- ¿Cuál es la proporción de reclamos resueltos en comparación con los reclamos totales por mes?
SELECT 
    MONTH(r.fecha_reclamo) AS Mes, 
    YEAR(r.fecha_reclamo) AS Año,
    COUNT(*) AS Total_Reclamos,
    SUM(CASE WHEN rs.estado_reclamo = 'Resuelto' THEN 1 ELSE 0 END) AS Reclamos_Resueltos,
    CAST(SUM(CASE WHEN rs.estado_reclamo = 'Resuelto' THEN 1 ELSE 0 END) AS DECIMAL) / COUNT(*) AS Proporcion_Resueltos
FROM Reclamos r
LEFT JOIN Resoluciones rs ON r.id_reclamo = rs.id_reclamo
GROUP BY MONTH(r.fecha_reclamo), YEAR(r.fecha_reclamo)
ORDER BY Año, Mes;

-- ¿Cuál es la cantidad total de dinero involucrado en reclamos no resueltos por cada categoría de reclamo?
SELECT r.categoria_reclamo, SUM(r.monto_involucrado) AS Monto_Total
FROM Reclamos r
WHERE NOT EXISTS (
    SELECT 1
    FROM Resoluciones rs
    WHERE rs.id_reclamo = r.id_reclamo
)
GROUP BY r.categoria_reclamo;

-- ¿Cuál es el día de la semana con la mayor cantidad de reclamos?
SELECT 
    DATENAME(weekday, r.fecha_reclamo) AS Dia_Semana,
    COUNT(*) AS Total_Reclamos
FROM Reclamos r
GROUP BY DATENAME(weekday, r.fecha_reclamo)
ORDER BY Total_Reclamos DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;


