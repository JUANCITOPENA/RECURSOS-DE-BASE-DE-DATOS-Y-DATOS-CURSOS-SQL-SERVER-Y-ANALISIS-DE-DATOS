-- Crear la base de datos
CREATE DATABASE ReclamosBancarios_v1;
GO

-- Usar la base de datos
USE ReclamosBancarios_v1;
GO

-- Crear tabla Clientes si no existe
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Clientes' AND xtype='U')
BEGIN
    CREATE TABLE Clientes (
        id_cliente INT IDENTITY(1,1) PRIMARY KEY,
        nombre_cliente VARCHAR(100),
        tipo_cliente VARCHAR(50)
    );
END

-- Crear tabla Reclamos si no existe
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Reclamos' AND xtype='U')
BEGIN
    CREATE TABLE Reclamos (
        id_reclamo INT IDENTITY(1,1) PRIMARY KEY,
        fecha_reclamo DATE,
        id_cliente INT,
        categoria_reclamo VARCHAR(50),
        descripcion_reclamo VARCHAR(MAX),
        monto_involucrado DECIMAL(10, 2),
        FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
    );
END


-- Crear la tabla CategoriaDescripcion
CREATE TABLE CategoriaDescripcion (
    id_categoria INT PRIMARY KEY IDENTITY(1,1),
    categoria VARCHAR(50) NOT NULL,
    descripcion TEXT NOT NULL
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


-- Integración de la tabla Prestamos
CREATE TABLE Prestamos (
    id_prestamo INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    monto_prestamo DECIMAL(10, 2) NOT NULL,
    tasa_interes DECIMAL(5, 2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    duracion_meses INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Integración de la tabla Ahorros
CREATE TABLE Ahorros (
    id_ahorro INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    saldo_actual DECIMAL(10, 2) NOT NULL,
    tasa_interes DECIMAL(5, 2) NOT NULL,
    fecha_apertura DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Integración de la tabla Retiros
CREATE TABLE Retiros (
    id_retiro INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    id_cuenta_ahorro INT NOT NULL,
    monto_retiro DECIMAL(10, 2) NOT NULL,
    fecha_retiro DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_cuenta_ahorro) REFERENCES Ahorros(id_ahorro)
);

-- Integración de la tabla Hipotecas
CREATE TABLE Hipotecas (
    id_hipoteca INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT NOT NULL,
    monto_hipoteca DECIMAL(18, 2) NOT NULL,
    tasa_interes DECIMAL(5, 2) NOT NULL,
    duracion_meses INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);


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
('Marta Vargas', 'Individual'),
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
GO


CREATE PROCEDURE GenerarDatosReclamos
    @cantidad INT,
    @fecha_inicio DATE,
    @fecha_fin DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;

    WHILE @i <= @cantidad
    BEGIN
        -- Generar datos para la tabla Reclamos
        DECLARE @id_cliente_reclamo INT;
        SELECT TOP 1 @id_cliente_reclamo = id_cliente FROM Clientes ORDER BY NEWID();

        IF @id_cliente_reclamo IS NOT NULL
        BEGIN
            DECLARE @fecha_reclamo DATE = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % (DATEDIFF(DAY, @fecha_inicio, @fecha_fin) + 1)), @fecha_inicio);
            DECLARE @categoria_reclamo VARCHAR(50) = CASE WHEN (ABS(CHECKSUM(NEWID()) % 3) + 1) = 1 THEN 'Fraude' 
                                                          WHEN (ABS(CHECKSUM(NEWID()) % 3) + 1) = 2 THEN 'Errores en la cuenta'
                                                          ELSE 'Servicio al cliente' END;
            DECLARE @descripcion_reclamo VARCHAR(MAX) = CASE WHEN @categoria_reclamo = 'Fraude' THEN
                                                             CASE WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 1 THEN 'Cargo no reconocido en la tarjeta de crédito'
                                                                  WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 2 THEN 'Transferencia no autorizada'
                                                                  WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 3 THEN 'Phishing'
                                                                  WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 4 THEN 'Robo de identidad'
                                                                  WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 5 THEN 'Compra no autorizada'
                                                                  ELSE 'Uso indebido de tarjeta de crédito' END
                                                             WHEN @categoria_reclamo = 'Errores en la cuenta' THEN
                                                             CASE WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 1 THEN 'Depósito no reflejado en la cuenta'
                                                                  WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 2 THEN 'Doble cargo en la tarjeta de débito'
                                                                  WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 3 THEN 'Error en el saldo disponible'
                                                                  WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 4 THEN 'Transferencia no realizada'
                                                                  WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 5 THEN 'Cobro de comisiones no justificadas'
                                                                  ELSE 'Pago no reflejado en el préstamo' END
                                                             ELSE
                                                             CASE WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 1 THEN 'Mal trato en la sucursal'
                                                                  WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 2 THEN 'Tardanza en la resolución de problemas'
                                                                  WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 3 THEN 'Información incorrecta proporcionada'
                                                                  WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 4 THEN 'Larga espera en atención telefónica'
                                                                  WHEN (ABS(CHECKSUM(NEWID()) % 6) + 1) = 5 THEN 'Actitud poco profesional del personal'
                                                                  ELSE 'Error en la apertura de cuenta' END END;
            DECLARE @monto_involucrado DECIMAL(10, 2) = CASE WHEN @categoria_reclamo = 'Fraude' THEN ABS(CHECKSUM(NEWID()) % 1000) + 100.00
                                                             WHEN @categoria_reclamo = 'Errores en la cuenta' THEN ABS(CHECKSUM(NEWID()) % 500) + 50.00
                                                             ELSE 0.00 END;

            INSERT INTO Reclamos (fecha_reclamo, id_cliente, categoria_reclamo, descripcion_reclamo, monto_involucrado)
            VALUES (@fecha_reclamo, @id_cliente_reclamo, @categoria_reclamo, @descripcion_reclamo, @monto_involucrado);
        END

        SET @i = @i + 1;
    END
END;
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
('Marta Vargas', 'Individual'),
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
GO

select * from Clientes

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
('2024-08-29', 20, 'Errores en la cuenta', 'Problemas con el cajero automático', 100.00),
('2024-09-05', 21, 'Fraude', 'Transferencia no autorizada', 400.00),
('2024-10-12', 22, 'Errores en la cuenta', 'Doble cargo en la tarjeta de débito', 150.00),
('2024-11-14', 23, 'Servicio al cliente', 'Tardanza en la resolución de problemas', NULL),
('2024-12-20', 24, 'Fraude', 'Phishing', 650.00),
('2024-01-09', 25, 'Errores en la cuenta', 'Error en el saldo disponible', 200.00),
('2024-02-12', 26, 'Servicio al cliente', 'Información incorrecta proporcionada', NULL),
('2024-03-15', 27, 'Fraude', 'Robo de identidad', 900.00),
('2024-04-22', 28, 'Errores en la cuenta', 'Transferencia no realizada', 400.00),
('2024-05-17', 29, 'Servicio al cliente', 'Larga espera en atención telefónica', NULL),
('2024-06-20', 30, 'Fraude', 'Compra no autorizada', 250.00);
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
(16, 'Resuelto', '2024-04-25', 'Reembolso y medidas de seguridad', 'Cliente satisfecho con la solución'),
(17, 'Resuelto', '2024-05-22', 'Actualización del saldo del préstamo', 'Error corregido en el sistema'),
(18, 'Cerrado', '2024-06-30', 'Mejoras en el proceso de apertura de cuentas', 'Cliente informado de las mejoras'),
(19, 'Resuelto', '2024-07-19', 'Reembolso del monto afectado', 'Cliente satisfecho con la solución'),
(20, 'Resuelto', '2024-08-27', 'Reembolso del monto afectado', 'Cliente satisfecho con la solución'),
(21, 'Resuelto', '2024-09-10', 'Reembolso del monto afectado', 'Cliente satisfecho con la solución'),
(22, 'Resuelto', '2024-10-14', 'Corrección del doble cargo', 'Cliente informado de la corrección'),
(23, 'Cerrado', '2024-11-18', 'Mejoras en el proceso de atención', 'Cliente informado de las mejoras'),
(24, 'Resuelto', '2024-12-22', 'Reembolso y cambio de tarjeta', 'Cliente satisfecho con la solución'),
(25, 'Resuelto', '2024-01-14', 'Corrección del saldo', 'Error corregido en el sistema'),
(26, 'Cerrado', '2024-02-15', 'Capacitación al personal', 'Cliente informado de las acciones tomadas'),
(27, 'Resuelto', '2024-03-20', 'Reembolso y medidas de seguridad', 'Cliente satisfecho con la solución'),
(28, 'Resuelto', '2024-04-25', 'Realización de la transferencia', 'Cliente informado de la corrección'),
(29, 'Cerrado', '2024-05-22', 'Mejoras en el tiempo de espera', 'Cliente informado de las mejoras'),
(30, 'Resuelto', '2024-06-27', 'Reembolso del monto afectado', 'Cliente satisfecho con la solución');
GO

EXEC GenerarDatosReclamos @cantidad = 100, @fecha_inicio = '2023-01-01', @fecha_fin = '2023-12-31';


-- Procedimiento almacenado para generar datos automáticamente
CREATE PROCEDURE GenerarDatosReclamos
    @cantidad INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;

    WHILE @i <= @cantidad
    BEGIN
        DECLARE @id_cliente INT = (SELECT TOP 1 id_cliente FROM Clientes ORDER BY NEWID());
        DECLARE @fecha_reclamo DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE());
        DECLARE @categoria_reclamo VARCHAR(50) = CASE WHEN (ABS(CHECKSUM(NEWID()) % 3) + 1) = 1 THEN 'Fraude' 
                                                      WHEN (ABS(CHECKSUM(NEWID()) % 3) + 1) = 2 THEN 'Errores en la cuenta'
                                                      ELSE 'Servicio al cliente' END;
        DECLARE @descripcion_reclamo VARCHAR(MAX) = CASE WHEN @categoria_reclamo = 'Fraude' THEN 'Transacción no autorizada'
                                                         WHEN @categoria_reclamo = 'Errores en la cuenta' THEN 'Discrepancia en el saldo'
                                                         ELSE 'Insatisfacción con el servicio' END;
        DECLARE @monto_involucrado DECIMAL(10, 2) = CASE WHEN @categoria_reclamo = 'Fraude' THEN ABS(CHECKSUM(NEWID()) % 1000) + 100.00
                                                          WHEN @categoria_reclamo = 'Errores en la cuenta' THEN ABS(CHECKSUM(NEWID()) % 500) + 50.00
                                                          ELSE NULL END;

        INSERT INTO Reclamos (fecha_reclamo, id_cliente, categoria_reclamo, descripcion_reclamo, monto_involucrado)
        VALUES (@fecha_reclamo, @id_cliente, @categoria_reclamo, @descripcion_reclamo, @monto_involucrado);

        SET @i = @i + 1;
    END
END;
GO

-- Ejemplo de llamada al procedimiento almacenado
EXEC GenerarDatosReclamos @cantidad = 1000;
GO


-- Insertar datos de ejemplo en las tablas Prestamos, Ahorros, Retiros y Hipotecas (ya proporcionados en consultas anteriores).

-- Relaciones adicionales con la tabla Clientes (ejemplo de cómo relacionarlas)
-- En las sentencias CREATE TABLE anteriores, ya se han definido las claves foráneas hacia la tabla Clientes.
-- Esto asegura que cada préstamo, cuenta de ahorro, retiro y hipoteca esté asociado a un cliente específico.

-- Ejemplo de consulta para obtener datos relacionados (JOIN entre tablas)
SELECT *
FROM Prestamos p
JOIN Clientes c ON p.id_cliente = c.id_cliente;

-- Esta consulta combina datos de la tabla Prestamos con los datos del cliente correspondiente, permitiendo análisis coherentes basados en la información de clientes y sus transacciones financieras.

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


-- Procedimiento almacenado para generar datos automáticamente en las tablas financieras
CREATE PROCEDURE GenerarDatosFinancieros
    @cantidad INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;

    WHILE @i <= @cantidad
    BEGIN
        -- Generar datos para la tabla Prestamos
        DECLARE @id_cliente_prestamo INT = (SELECT TOP 1 id_cliente FROM Clientes ORDER BY NEWID());
        DECLARE @monto_prestamo DECIMAL(10, 2) = ABS(CHECKSUM(NEWID()) % 10000) + 1000.00;
        DECLARE @tasa_interes_prestamo DECIMAL(5, 2) = RAND() * 10;
        DECLARE @fecha_inicio_prestamo DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE());
        DECLARE @duracion_meses_prestamo INT = ABS(CHECKSUM(NEWID()) % 12) + 12;

        INSERT INTO Prestamos (id_cliente, monto_prestamo, tasa_interes, fecha_inicio, duracion_meses)
        VALUES (@id_cliente_prestamo, @monto_prestamo, @tasa_interes_prestamo, @fecha_inicio_prestamo, @duracion_meses_prestamo);

        -- Generar datos para la tabla Ahorros
        DECLARE @id_cliente_ahorro INT = (SELECT TOP 1 id_cliente FROM Clientes ORDER BY NEWID());
        DECLARE @saldo_actual DECIMAL(10, 2) = ABS(CHECKSUM(NEWID()) % 10000) + 500.00;
        DECLARE @tasa_interes_ahorro DECIMAL(5, 2) = RAND() * 5;
        DECLARE @fecha_apertura_ahorro DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE());

        INSERT INTO Ahorros (id_cliente, saldo_actual, tasa_interes, fecha_apertura)
        VALUES (@id_cliente_ahorro, @saldo_actual, @tasa_interes_ahorro, @fecha_apertura_ahorro);

        -- Generar datos para la tabla Retiros
        DECLARE @id_cliente_retiro INT = (SELECT TOP 1 id_cliente FROM Clientes ORDER BY NEWID());
        DECLARE @id_cuenta_ahorro INT = (SELECT TOP 1 id_ahorro FROM Ahorros ORDER BY NEWID());
        DECLARE @monto_retiro DECIMAL(10, 2) = ABS(CHECKSUM(NEWID()) % 1000) + 50.00;
        DECLARE @fecha_retiro DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE());

        INSERT INTO Retiros (id_cliente, id_cuenta_ahorro, monto_retiro, fecha_retiro)
        VALUES (@id_cliente_retiro, @id_cuenta_ahorro, @monto_retiro, @fecha_retiro);

        -- Generar datos para la tabla Hipotecas
        DECLARE @id_cliente_hipoteca INT = (SELECT TOP 1 id_cliente FROM Clientes ORDER BY NEWID());
        DECLARE @monto_hipoteca DECIMAL(18, 2) = ABS(CHECKSUM(NEWID()) % 500000) + 50000.00;
        DECLARE @tasa_interes_hipoteca DECIMAL(5, 2) = RAND() * 8;
        DECLARE @duracion_meses_hipoteca INT = ABS(CHECKSUM(NEWID()) % 240) + 60;
        DECLARE @fecha_inicio_hipoteca DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE());

        INSERT INTO Hipotecas (id_cliente, monto_hipoteca, tasa_interes, duracion_meses, fecha_inicio)
        VALUES (@id_cliente_hipoteca, @monto_hipoteca, @tasa_interes_hipoteca, @duracion_meses_hipoteca, @fecha_inicio_hipoteca);

        SET @i = @i + 1;
    END
END;
GO



-- Ejemplo de llamada al procedimiento almacenado para generar 100 registros
EXEC GenerarDatosFinancieros @cantidad = 1000;
GO





CREATE VIEW Vista_InfoCliente AS
SELECT c.id_cliente, c.nombre_cliente, c.tipo_cliente,
       ISNULL(SUM(a.saldo_actual), 0) AS saldo_actual_ahorros,
       ISNULL(SUM(p.monto_prestamo), 0) AS monto_total_prestamos
FROM Clientes c
LEFT JOIN Ahorros a ON c.id_cliente = a.id_cliente
LEFT JOIN Prestamos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente, c.tipo_cliente;


select * from Vista_InfoCliente





CREATE VIEW Vista_ReclamosResoluciones AS
SELECT r.id_reclamo, r.fecha_reclamo, r.id_cliente, r.categoria_reclamo, r.descripcion_reclamo,
       r.monto_involucrado, res.estado_reclamo, res.fecha_resolucion, res.solucion_ofrecida, res.comentarios_adicionales
FROM Reclamos r
LEFT JOIN Resoluciones res ON r.id_reclamo = res.id_reclamo;






CREATE PROCEDURE GenerarDatosCompletos
    @cantidad INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;
    DECLARE @id_hipoteca INT; -- Declaración de la variable @id_hipoteca

    WHILE @i <= @cantidad
    BEGIN
        -- Generar datos para la tabla Prestamos
        DECLARE @id_cliente_prestamo INT = (SELECT TOP 1 id_cliente FROM Clientes ORDER BY NEWID());
        DECLARE @monto_prestamo DECIMAL(10, 2) = ABS(CHECKSUM(NEWID()) % 10000) + 1000.00;
        DECLARE @tasa_interes_prestamo DECIMAL(5, 2) = RAND() * 10;
        DECLARE @fecha_inicio_prestamo DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE());
        DECLARE @duracion_meses_prestamo INT = ABS(CHECKSUM(NEWID()) % 12) + 12;

        INSERT INTO Prestamos (id_cliente, monto_prestamo, tasa_interes, fecha_inicio, duracion_meses)
        VALUES (@id_cliente_prestamo, @monto_prestamo, @tasa_interes_prestamo, @fecha_inicio_prestamo, @duracion_meses_prestamo);

        -- Obtener el último id de préstamo insertado
        DECLARE @id_prestamo INT = SCOPE_IDENTITY();

        -- Generar datos para la tabla Ahorros
        DECLARE @id_cliente_ahorro INT = (SELECT TOP 1 id_cliente FROM Clientes ORDER BY NEWID());
        DECLARE @saldo_actual DECIMAL(10, 2) = ABS(CHECKSUM(NEWID()) % 10000) + 500.00;
        DECLARE @tasa_interes_ahorro DECIMAL(5, 2) = RAND() * 5;
        DECLARE @fecha_apertura_ahorro DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE());

        INSERT INTO Ahorros (id_cliente, saldo_actual, tasa_interes, fecha_apertura)
        VALUES (@id_cliente_ahorro, @saldo_actual, @tasa_interes_ahorro, @fecha_apertura_ahorro);

        -- Obtener el último id de ahorro insertado
        DECLARE @id_ahorro INT = SCOPE_IDENTITY();

        -- Generar datos para la tabla Retiros
        DECLARE @id_cliente_retiro INT = (SELECT TOP 1 id_cliente FROM Clientes ORDER BY NEWID());
        DECLARE @monto_retiro DECIMAL(10, 2) = ABS(CHECKSUM(NEWID()) % 1000) + 50.00;
        DECLARE @fecha_retiro DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE());

        INSERT INTO Retiros (id_cliente, id_cuenta_ahorro, monto_retiro, fecha_retiro)
        VALUES (@id_cliente_retiro, @id_ahorro, @monto_retiro, @fecha_retiro);

        -- Verificar si hay reclamos existentes para insertar
        DECLARE @id_reclamo INT = NULL;
        DECLARE @id_resolucion INT = NULL;
        DECLARE @id_cliente_reclamo INT = (SELECT TOP 1 id_cliente FROM Clientes ORDER BY NEWID());

        IF EXISTS (SELECT * FROM Reclamos WHERE id_cliente = @id_cliente_reclamo)
        BEGIN
            -- Obtener un reclamo existente aleatoriamente
            SELECT TOP 1 @id_reclamo = id_reclamo FROM Reclamos WHERE id_cliente = @id_cliente_reclamo ORDER BY NEWID();
            -- Obtener la resolución asociada al reclamo
            SELECT TOP 1 @id_resolucion = id_resolucion FROM Resoluciones WHERE id_reclamo = @id_reclamo;
        END

        -- Asignar un valor a @id_hipoteca (por ejemplo, utilizando alguna lógica específica)
        SET @id_hipoteca = ABS(CHECKSUM(NEWID()) % 100) + 1;

        -- Insertar datos para la tabla Reclamos utilizando los datos obtenidos o generados
        IF @id_reclamo IS NOT NULL
        BEGIN
            -- Insertar el reclamo existente
            INSERT INTO Reclamos (fecha_reclamo, id_cliente, categoria_reclamo, descripcion_reclamo, monto_involucrado)
            SELECT fecha_reclamo, id_cliente, categoria_reclamo, descripcion_reclamo, monto_involucrado
            FROM Reclamos
            WHERE id_reclamo = @id_reclamo;
        END
        ELSE
        BEGIN
            -- Generar datos para un nuevo reclamo
            DECLARE @fecha_reclamo DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE());
            DECLARE @categoria_reclamo VARCHAR(50) = CASE WHEN (ABS(CHECKSUM(NEWID()) % 3) + 1) = 1 THEN 'Fraude' 
                                                          WHEN (ABS(CHECKSUM(NEWID()) % 3) + 1) = 2 THEN 'Errores en la cuenta'
                                                          ELSE 'Servicio al cliente' END;
            DECLARE @descripcion_reclamo VARCHAR(MAX) = CASE WHEN @categoria_reclamo = 'Fraude' THEN 'Transacción no autorizada'
                                                             WHEN @categoria_reclamo = 'Errores en la cuenta' THEN 'Discrepancia en el saldo'
                                                             ELSE 'Insatisfacción con el servicio' END;
            DECLARE @monto_involucrado DECIMAL(10, 2) = CASE WHEN @categoria_reclamo = 'Fraude' THEN ABS(CHECKSUM(NEWID()) % 1000) + 100.00
                                                              WHEN @categoria_reclamo = 'Errores en la cuenta' THEN ABS(CHECKSUM(NEWID()) % 500) + 50.00
                                                              ELSE NULL END;

            INSERT INTO Reclamos (fecha_reclamo, id_cliente, categoria_reclamo, descripcion_reclamo, monto_involucrado)
            VALUES (@fecha_reclamo, @id_cliente_prestamo, @categoria_reclamo, @descripcion_reclamo, @monto_involucrado);
        END

        -- Obtener el último id de reclamo insertado
        SET @id_reclamo = SCOPE_IDENTITY();

        -- Insertar datos para la tabla Resoluciones utilizando los datos obtenidos o generados
        IF @id_resolucion IS NOT NULL
        BEGIN
            -- Insertar la resolución existente
            INSERT INTO Resoluciones (id_reclamo, estado_reclamo, fecha_resolucion, solucion_ofrecida, comentarios_adicionales)
            SELECT id_reclamo, estado_reclamo, fecha_resolucion, solucion_ofrecida, comentarios_adicionales
            FROM Resoluciones
            WHERE id_resolucion = @id_resolucion;
        END
        ELSE
        BEGIN
            -- Generar datos para una nueva resolución
            DECLARE @estado_reclamo VARCHAR(50) = CASE WHEN @id_reclamo IS NOT NULL THEN 'Resuelto' ELSE 'Cerrado' END;
            DECLARE @fecha_resolucion DATE = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 30), GETDATE());
            DECLARE @solucion_ofrecida VARCHAR(MAX) = CASE WHEN @estado_reclamo = 'Resuelto' THEN 'Cliente satisfecho con la solución'
                                                            ELSE 'Cliente informado de las acciones tomadas' END;
            DECLARE @comentarios_adicionales VARCHAR(MAX) = CASE WHEN @estado_reclamo = 'Resuelto' THEN 'Error corregido en el sistema'
                                                                 ELSE 'Cliente informado de las mejoras' END;

            INSERT INTO Resoluciones (id_reclamo, estado_reclamo, fecha_resolucion, solucion_ofrecida, comentarios_adicionales)
            VALUES (@id_reclamo, @estado_reclamo, @fecha_resolucion, @solucion_ofrecida, @comentarios_adicionales);
        END

        SET @i = @i + 1;
    END
END;
GO


EXEC GenerarDatosCompletos @cantidad = 100;




USE ReclamosBancarios_v1;
GO

-- Drop procedure if exists
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GenerarDatosCompletos_v1')
BEGIN
    DROP PROCEDURE GenerarDatosCompletos_v1;
END
GO

CREATE PROCEDURE GenerarDatosCompletos_v1
    @cantidad INT,
    @fecha_inicio DATE,
    @fecha_fin DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @i INT = 1;

    WHILE @i <= @cantidad
    BEGIN
        -- Generar datos para la tabla Prestamos
        DECLARE @id_cliente_prestamo INT;
        SELECT TOP 1 @id_cliente_prestamo = id_cliente FROM Clientes ORDER BY NEWID();

        IF @id_cliente_prestamo IS NOT NULL
        BEGIN
            DECLARE @monto_prestamo DECIMAL(10, 2) = ABS(CHECKSUM(NEWID()) % 10000) + 1000.00;
            DECLARE @tasa_interes_prestamo DECIMAL(5, 2) = RAND() * 10;
            DECLARE @fecha_inicio_prestamo DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), @fecha_inicio);
            DECLARE @duracion_meses_prestamo INT = ABS(CHECKSUM(NEWID()) % 12) + 12;

            INSERT INTO Prestamos (id_cliente, monto_prestamo, tasa_interes, fecha_inicio, duracion_meses)
            VALUES (@id_cliente_prestamo, @monto_prestamo, @tasa_interes_prestamo, @fecha_inicio_prestamo, @duracion_meses_prestamo);
        END

        -- Generar datos para la tabla Ahorros
        DECLARE @id_cliente_ahorro INT;
        SELECT TOP 1 @id_cliente_ahorro = id_cliente FROM Clientes ORDER BY NEWID();

        IF @id_cliente_ahorro IS NOT NULL
        BEGIN
            DECLARE @saldo_actual DECIMAL(10, 2) = ABS(CHECKSUM(NEWID()) % 10000) + 500.00;
            DECLARE @tasa_interes_ahorro DECIMAL(5, 2) = RAND() * 5;
            DECLARE @fecha_apertura_ahorro DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), @fecha_inicio);

            INSERT INTO Ahorros (id_cliente, saldo_actual, tasa_interes, fecha_apertura)
            VALUES (@id_cliente_ahorro, @saldo_actual, @tasa_interes_ahorro, @fecha_apertura_ahorro);
        END

        -- Generar datos para la tabla Retiros
        DECLARE @id_cliente_retiro INT;
        SELECT TOP 1 @id_cliente_retiro = id_cliente FROM Clientes ORDER BY NEWID();

        IF @id_cliente_retiro IS NOT NULL
        BEGIN
            -- Obtener el id de la cuenta de ahorros correspondiente
            DECLARE @id_cuenta_ahorro INT;
            SELECT TOP 1 @id_cuenta_ahorro = id_cuenta_ahorro FROM Ahorros WHERE id_cliente = @id_cliente_retiro;

            DECLARE @monto_retiro DECIMAL(10, 2) = ABS(CHECKSUM(NEWID()) % 1000) + 50.00;
            DECLARE @fecha_retiro DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), @fecha_inicio);

            INSERT INTO Retiros (id_cliente, id_cuenta_ahorro, monto_retiro, fecha_retiro)
            VALUES (@id_cliente_retiro, @id_cuenta_ahorro, @monto_retiro, @fecha_retiro);
        END

        -- Generar datos para la tabla Reclamos y Resoluciones
        DECLARE @id_cliente_reclamo INT;
        SELECT TOP 1 @id_cliente_reclamo = id_cliente FROM Clientes ORDER BY NEWID();

        IF @id_cliente_reclamo IS NOT NULL
        BEGIN
            -- Insertar datos para la tabla Reclamos
            DECLARE @fecha_reclamo DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), @fecha_inicio);
            DECLARE @categoria_reclamo VARCHAR(50) = CASE WHEN (ABS(CHECKSUM(NEWID()) % 3) + 1) = 1 THEN 'Fraude' 
                                                          WHEN (ABS(CHECKSUM(NEWID()) % 3) + 1) = 2 THEN 'Errores en la cuenta'
                                                          ELSE 'Servicio al cliente' END;
            DECLARE @descripcion_reclamo VARCHAR(MAX) = CASE WHEN @categoria_reclamo = 'Fraude' THEN 'Transacción no autorizada'
                                                             WHEN @categoria_reclamo = 'Errores en la cuenta' THEN 'Discrepancia en el saldo'
                                                             ELSE 'Insatisfacción con el servicio' END;
            DECLARE @monto_involucrado DECIMAL(10, 2) = CASE WHEN @categoria_reclamo = 'Fraude' THEN ABS(CHECKSUM(NEWID()) % 1000) + 100.00
                                                              WHEN @categoria_reclamo = 'Errores en la cuenta' THEN ABS(CHECKSUM(NEWID()) % 500) + 50.00
                                                              ELSE 0.00 END;

            INSERT INTO Reclamos (fecha_reclamo, id_cliente, categoria_reclamo, descripcion_reclamo, monto_involucrado)
            VALUES (@fecha_reclamo, @id_cliente_reclamo, @categoria_reclamo, @descripcion_reclamo, @monto_involucrado);

            -- Obtener el último id de reclamo insertado
            DECLARE @id_reclamo INT = SCOPE_IDENTITY();

            -- Insertar datos para la tabla Resoluciones
            DECLARE @estado_reclamo VARCHAR(50) = CASE WHEN @id_reclamo IS NOT NULL THEN 'Resuelto' ELSE 'Cerrado' END;
            DECLARE @fecha_resolucion DATE = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 30), @fecha_inicio);
            DECLARE @solucion_ofrecida VARCHAR(MAX) = CASE WHEN @estado_reclamo = 'Resuelto' THEN 'Cliente satisfecho con la solución'
                                                            ELSE 'Cliente informado de las acciones tomadas' END;
            DECLARE @comentarios_adicionales VARCHAR(MAX) = CASE WHEN @estado_reclamo = 'Resuelto' THEN 'Error corregido en el sistema'
                                                                 ELSE 'Cliente informado de las mejoras' END;

            INSERT INTO Resoluciones (id_reclamo, estado_reclamo, fecha_resolucion, solucion_ofrecida, comentarios_adicionales)
            VALUES (@id_reclamo, @estado_reclamo, @fecha_resolucion, @solucion_ofrecida, @comentarios_adicionales);
        END

        SET @i = @i + 1;
    END
END;
GO


-- Execute procedure
EXEC GenerarDatosCompletos_v1 @cantidad = 300, @fecha_inicio = '2020-01-01', @fecha_fin = '2024-07-31';








-- Insertar datos en la tabla CategoriaDescripcion
INSERT INTO CategoriaDescripcion (categoria, descripcion)
VALUES
    ('Fraude', 'Cargo no reconocido en la tarjeta de crédito'),
    ('Errores en la cuenta', 'Depósito no reflejado en la cuenta'),
    ('Servicio al cliente', 'Mal trato en la sucursal'),
    ('Fraude', 'Transferencia no autorizada'),
    ('Errores en la cuenta', 'Doble cargo en la tarjeta de débito'),
    ('Servicio al cliente', 'Tardanza en la resolución de problemas'),
    ('Fraude', 'Phishing'),
    ('Errores en la cuenta', 'Error en el saldo disponible'),
    ('Servicio al cliente', 'Información incorrecta proporcionada'),
    ('Fraude', 'Robo de identidad'),
    ('Errores en la cuenta', 'Transferencia no realizada'),
    ('Servicio al cliente', 'Larga espera en atención telefónica'),
    ('Fraude', 'Compra no autorizada'),
    ('Errores en la cuenta', 'Cobro de comisiones no justificadas'),
    ('Servicio al cliente', 'Actitud poco profesional del personal'),
    ('Fraude', 'Uso indebido de tarjeta de crédito'),
    ('Errores en la cuenta', 'Pago no reflejado en el préstamo'),
    ('Servicio al cliente', 'Error en la apertura de cuenta'),
    ('Fraude', 'Transacción sospechosa'),
    ('Errores en la cuenta', 'Problemas con el cajero automático'),
    ('Fraude', 'Transferencia no autorizada'),
    ('Errores en la cuenta', 'Doble cargo en la tarjeta de débito'),
    ('Servicio al cliente', 'Tardanza en la resolución de problemas'),
    ('Fraude', 'Phishing'),
    ('Errores en la cuenta', 'Error en el saldo disponible'),
    ('Servicio al cliente', 'Información incorrecta proporcionada'),
    ('Fraude', 'Robo de identidad'),
    ('Errores en la cuenta', 'Transferencia no realizada'),
    ('Servicio al cliente', 'Larga espera en atención telefónica'),
    ('Fraude', 'Compra no autorizada');
GO











SELECT 
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
    a.tasa_interes AS tasa_interes_ahorro,
    a.fecha_apertura AS fecha_apertura_ahorro,
    r.id_retiro,
    r.monto_retiro,
    r.fecha_retiro,
    (SELECT TOP 1 fecha_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) AS ultima_fecha_reclamo,
    (SELECT TOP 1 categoria_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) AS ultima_categoria_reclamo,
    (SELECT TOP 1 estado_reclamo FROM Resoluciones WHERE id_reclamo = (SELECT TOP 1 id_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) ORDER BY fecha_resolucion DESC) AS estado_ultimo_reclamo,
    (SELECT TOP 1 fecha_resolucion FROM Resoluciones WHERE id_reclamo = (SELECT TOP 1 id_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) ORDER BY fecha_resolucion DESC) AS fecha_resolucion_ultimo_reclamo,
    (SELECT TOP 1 solucion_ofrecida FROM Resoluciones WHERE id_reclamo = (SELECT TOP 1 id_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) ORDER BY fecha_resolucion DESC) AS solucion_ofrecida_ultimo_reclamo
FROM 
    Clientes c
LEFT JOIN 
    Prestamos p ON c.id_cliente = p.id_cliente
LEFT JOIN 
    Ahorros a ON c.id_cliente = a.id_cliente
LEFT JOIN 
    Retiros r ON c.id_cliente = r.id_cliente;






	DECLARE @tableName NVARCHAR(MAX)
DECLARE cur CURSOR FOR 
    SELECT TABLE_NAME 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE = 'BASE TABLE'

OPEN cur

FETCH NEXT FROM cur INTO @tableName

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @sql NVARCHAR(MAX)
    SET @sql = 'DELETE FROM ' + @tableName
    EXEC sp_executesql @sql
    
    FETCH NEXT FROM cur INTO @tableName
END

CLOSE cur
DEALLOCATE cur

-- 1. Desactivar todas las restricciones de clave externa
EXEC sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'

-- 2. Eliminar datos de todas las tablas
EXEC sp_MSForEachTable 'DELETE FROM ?'

-- 3. Activar todas las restricciones de clave externa nuevamente
EXEC sp_msforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL'


-- Consultas avanzadas

-- Consulta de reclamos pendientes
SELECT 
    r.id_reclamo, 
    c.nombre_cliente, 
    r.fecha_reclamo, 
    r.categoria_reclamo, 
    r.descripcion_reclamo
FROM 
    Reclamos r
JOIN 
    Clientes c ON r.id_cliente = c.id_cliente
LEFT JOIN 
    Resoluciones res ON r.id_reclamo = res.id_reclamo
WHERE 
    res.id_resolucion IS NULL;
GO

-- Consulta de resolución por cliente
SELECT 
    c.nombre_cliente, 
    COUNT(res.id_resolucion) AS total_resoluciones
FROM 
    Clientes c
JOIN 
    Reclamos r ON c.id_cliente = r.id_cliente
JOIN 
    Resoluciones res ON r.id_reclamo = res.id_reclamo
GROUP BY 
    c.nombre_cliente;
GO



--Consulta para ver todos los registros de reclamos:Esta consulta devuelve todos los reclamos junto con el nombre del cliente relacionado.

SELECT r.id_reclamo, r.fecha_reclamo, c.nombre_cliente, r.categoria_reclamo, r.descripcion_reclamo, r.monto_involucrado, r.descripcion_reclamo
FROM Reclamos r
INNER JOIN Clientes c ON r.id_cliente = c.id_cliente;

DECLARE @id_cliente INT = 1; -- Cambia el valor por el ID del cliente deseado

SELECT r.id_reclamo, r.fecha_reclamo, r.categoria_reclamo, r.descripcion_reclamo, r.monto_involucrado, r.descripcion_reclamo
FROM Reclamos r
WHERE r.id_cliente = @id_cliente;

DECLARE @categoria_reclamo VARCHAR(50) = 'Fraude'; -- Cambia por la categoría deseada
DECLARE @estado VARCHAR(50) = 'En proceso'; -- Cambia por el estado deseado


SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Reclamos';

-- Consulta para ver los reclamos agrupados por estado
SELECT estado, COUNT(*) as cantidad_reclamos
FROM (
    SELECT estado = CASE 
                    WHEN r.descripcion_reclamo LIKE '%Fraude%' THEN 'Fraude'
                    WHEN r.descripcion_reclamo LIKE '%Errores en la cuenta%' THEN 'Errores en la cuenta'
                    ELSE 'Servicio al cliente'
                END
    FROM Reclamos r
) AS reclamos_con_estado
GROUP BY estado;


-- Consulta para ver todos los registros de reclamos
SELECT id_reclamo, fecha_reclamo, id_cliente, categoria_reclamo, descripcion_reclamo, monto_involucrado
FROM Reclamos;

-- Consulta para ver los reclamos agrupados por categoría
SELECT categoria_reclamo, COUNT(*) as cantidad_reclamos
FROM Reclamos
GROUP BY categoria_reclamo;

-- Consulta para ver los reclamos agrupados por estado
SELECT estado, COUNT(*) as cantidad_reclamos
FROM (
    SELECT estado = CASE 
                    WHEN r.descripcion_reclamo LIKE '%Fraude%' THEN 'Fraude'
                    WHEN r.descripcion_reclamo LIKE '%Errores en la cuenta%' THEN 'Errores en la cuenta'
                    ELSE 'Servicio al cliente'
                END
    FROM Reclamos r
) AS reclamos_con_estado
GROUP BY estado;













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



