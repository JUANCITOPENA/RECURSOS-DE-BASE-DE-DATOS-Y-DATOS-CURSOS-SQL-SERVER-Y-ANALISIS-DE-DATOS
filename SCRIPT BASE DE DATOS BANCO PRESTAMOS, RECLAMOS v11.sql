-- Crear la base de datos
CREATE DATABASE ReclamosBancarios_v2;
GO

-- Usar la base de datos
USE ReclamosBancarios_v2;
GO

-- Crear tabla Clientes si no existe
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Clientes' AND xtype='U')
BEGIN
    CREATE TABLE Clientes (
        id_cliente INT IDENTITY(1,1) PRIMARY KEY,
        nombre_cliente VARCHAR(100) NOT NULL,
        tipo_cliente VARCHAR(50) NOT NULL
    );
END
GO

-- Crear tabla Reclamos si no existe
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Reclamos' AND xtype='U')
BEGIN
    CREATE TABLE Reclamos (
        id_reclamo INT IDENTITY(1,1) PRIMARY KEY,
        fecha_reclamo DATE NOT NULL,
        id_cliente INT NOT NULL,
        categoria_reclamo VARCHAR(50) NOT NULL,
        descripcion_reclamo VARCHAR(MAX) NOT NULL,
        monto_involucrado DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
    );
END
GO

-- Crear la tabla CategoriaDescripcion
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='CategoriaDescripcion' AND xtype='U')
BEGIN
    CREATE TABLE CategoriaDescripcion (
        id_categoria INT PRIMARY KEY IDENTITY(1,1),
        categoria VARCHAR(50) NOT NULL,
        descripcion TEXT NOT NULL
    );
END
GO

-- Crear la tabla Resoluciones
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Resoluciones' AND xtype='U')
BEGIN
    CREATE TABLE Resoluciones (
        id_resolucion INT PRIMARY KEY IDENTITY(1,1),
        id_reclamo INT NOT NULL,
        estado_reclamo VARCHAR(50) NOT NULL,
        fecha_resolucion DATE NOT NULL,
        solucion_ofrecida TEXT NOT NULL,
        comentarios_adicionales TEXT NOT NULL,
        FOREIGN KEY (id_reclamo) REFERENCES Reclamos(id_reclamo)
    );
END
GO

-- Crear índices en las columnas utilizadas frecuentemente en consultas
CREATE INDEX idx_fecha_reclamo ON Reclamos(fecha_reclamo);
CREATE INDEX idx_estado_reclamo ON Resoluciones(estado_reclamo);
GO

-- Integración de la tabla Prestamos
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Prestamos' AND xtype='U')
BEGIN
    CREATE TABLE Prestamos (
        id_prestamo INT PRIMARY KEY IDENTITY(1,1),
        id_cliente INT NOT NULL,
        monto_prestamo DECIMAL(10, 2) NOT NULL,
        tasa_interes DECIMAL(5, 2) NOT NULL,
        fecha_inicio DATE NOT NULL,
        duracion_meses INT NOT NULL,
        FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
    );
END
GO

-- Integración de la tabla Ahorros
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Ahorros' AND xtype='U')
BEGIN
    CREATE TABLE Ahorros (
        id_ahorro INT PRIMARY KEY IDENTITY(1,1),
        id_cliente INT NOT NULL,
        saldo_actual DECIMAL(10, 2) NOT NULL,
        tasa_interes DECIMAL(5, 2) NOT NULL,
        fecha_apertura DATE NOT NULL,
        FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
    );
END
GO

-- Integración de la tabla Retiros
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Retiros' AND xtype='U')
BEGIN
    CREATE TABLE Retiros (
        id_retiro INT PRIMARY KEY IDENTITY(1,1),
        id_cliente INT NOT NULL,
        id_cuenta_ahorro INT NOT NULL,
        monto_retiro DECIMAL(10, 2) NOT NULL,
        fecha_retiro DATE NOT NULL,
        FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
        FOREIGN KEY (id_cuenta_ahorro) REFERENCES Ahorros(id_ahorro)
    );
END
GO

-- Integración de la tabla Hipotecas
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Hipotecas' AND xtype='U')
BEGIN
    CREATE TABLE Hipotecas (
        id_hipoteca INT PRIMARY KEY IDENTITY(1,1),
        id_cliente INT NOT NULL,
        monto_hipoteca DECIMAL(18, 2) NOT NULL,
        tasa_interes DECIMAL(5, 2) NOT NULL,
        duracion_meses INT NOT NULL,
        fecha_inicio DATE NOT NULL,
        FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
    );
END
GO


-- Insertar datos en Clientes
INSERT INTO Clientes (nombre_cliente, tipo_cliente)
VALUES 
('Juan Pérez', 'Personal'),
('María López', 'Empresarial'),
('Carlos Sánchez', 'Personal'),
('Ana Gómez', 'Empresarial'),
('Luis Rodríguez', 'Personal'),
('Laura Fernández', 'Empresarial'),
('Jorge Martínez', 'Personal'),
('Sofía Hernández', 'Empresarial'),
('Miguel Díaz', 'Personal'),
('Carmen Torres', 'Empresarial'),
('José Romero', 'Personal'),
('Paula Vázquez', 'Empresarial'),
('Fernando Castro', 'Personal'),
('Lucía Morales', 'Empresarial'),
('Raúl Navarro', 'Personal'),
('Elena Ruiz', 'Empresarial'),
('Diego Rivas', 'Personal'),
('Isabel Ortega', 'Empresarial'),
('Héctor Ramírez', 'Personal'),
('Victoria León', 'Empresarial'),
('Pedro Gutiérrez', 'Personal'),
('Gabriela Medina', 'Empresarial'),
('Andrés Herrera', 'Personal'),
('Julia Castro', 'Empresarial'),
('Martín Flores', 'Personal'),
('Valeria Martínez', 'Empresarial'),
('Javier Ramos', 'Personal'),
('Carolina López', 'Empresarial'),
('Roberto Pérez', 'Personal'),
('Camila Sánchez', 'Empresarial'),
('Daniel Ruiz', 'Personal'),
('Alejandra Gómez', 'Empresarial'),
('Francisco Torres', 'Personal'),
('Natalia Díaz', 'Empresarial'),
('Manuel García', 'Personal'),
('Paulina Ramírez', 'Empresarial'),
('Ricardo Soto', 'Personal'),
('Verónica Fernández', 'Empresarial'),
('David Jiménez', 'Personal'),
('Marina Herrera', 'Empresarial');
GO

-- Insertar datos en Clientes sin repetir nombres
INSERT INTO Clientes (nombre_cliente, tipo_cliente)
VALUES 
('Fabián Mendoza', 'Personal'),
('Lorena Castillo', 'Empresarial'),
('Rafael Jiménez', 'Personal'),
('Silvia Torres', 'Empresarial'),
('Gabriel Morales', 'Personal'),
('Adriana López', 'Empresarial'),
('Mateo Ramírez', 'Personal'),
('Renata Gómez', 'Empresarial'),
('Esteban Pérez', 'Personal'),
('Diana Martínez', 'Empresarial'),
('Javier Sánchez', 'Personal'),
('Carla Rodríguez', 'Empresarial'),
('Tomás Gutiérrez', 'Personal'),
('Beatriz González', 'Empresarial'),
('Alejandro Fernández', 'Personal'),
('Camila Ortega', 'Empresarial'),
('Emilio Vargas', 'Personal'),
('Sandra Herrera', 'Empresarial'),
('Sebastián Castro', 'Personal'),
('Isabella Ramírez', 'Empresarial'),
('Rodrigo Medina', 'Personal'),
('Valentina Silva', 'Empresarial'),
('Maximiliano Cruz', 'Personal'),
('Melissa Álvarez', 'Empresarial'),
('Hugo Molina', 'Personal'),
('Ana María Soto', 'Empresarial'),
('César Peralta', 'Personal'),
('Valeria Mendoza', 'Empresarial'),
('Nicolás Rojas', 'Personal'),
('Renée Martínez', 'Empresarial'),
('Gustavo Ortiz', 'Personal'),
('María José López', 'Empresarial'),
('Pablo Núñez', 'Personal'),
('Daniela Pérez', 'Empresarial'),
('Manuel Rodríguez', 'Personal'),
('Laura Sánchez', 'Empresarial'),
('Diego Torres', 'Personal'),
('Verónica Ruiz', 'Empresarial');
GO

--VER CLIENTES

SELECT * FROM Clientes

-- Insertar datos en Reclamos
INSERT INTO Reclamos (fecha_reclamo, id_cliente, categoria_reclamo, descripcion_reclamo, monto_involucrado)
VALUES 
('2024-01-01', 1, 'Fraude', 'Uso no autorizado de la tarjeta de crédito', 500.00),
('2024-01-02', 2, 'Servicio', 'Corte de servicio sin aviso previo', 300.00),
('2024-01-03', 3, 'Producto', 'Producto defectuoso recibido', 200.00),
('2024-01-04', 4, 'Cobranza', 'Cobro indebido en la cuenta', 150.00),
('2024-01-05', 5, 'Fraude', 'Transferencia no autorizada', 1000.00),
('2024-01-06', 6, 'Servicio', 'Demora en la atención al cliente', 250.00),
('2024-01-07', 7, 'Producto', 'Producto no entregado', 350.00),
('2024-01-08', 8, 'Cobranza', 'Intereses mal calculados', 400.00),
('2024-01-09', 9, 'Fraude', 'Clonación de tarjeta', 600.00),
('2024-01-10', 10, 'Servicio', 'Mala atención en sucursal', 100.00),
('2024-01-11', 11, 'Producto', 'Producto en mal estado', 120.00),
('2024-01-12', 12, 'Cobranza', 'Cobro duplicado', 700.00),
('2024-01-13', 13, 'Fraude', 'Acceso no autorizado a la cuenta', 800.00),
('2024-01-14', 14, 'Servicio', 'Fallo en la plataforma online', 220.00),
('2024-01-15', 15, 'Producto', 'Producto incompleto', 340.00),
('2024-01-16', 16, 'Cobranza', 'Cobro erróneo de comisiones', 180.00),
('2024-01-17', 17, 'Fraude', 'Phishing', 900.00),
('2024-01-18', 18, 'Servicio', 'Corte de servicio sin aviso', 130.00),
('2024-01-19', 19, 'Producto', 'Producto en mal estado', 240.00),
('2024-01-20', 20, 'Cobranza', 'Cobro indebido en la tarjeta', 160.00),
('2024-02-01', 21, 'Fraude', 'Cargo no reconocido en la cuenta', 450.00),
('2024-02-02', 22, 'Servicio', 'Tiempo prolongado de espera telefónica', 280.00),
('2024-02-03', 23, 'Producto', 'Producto incorrecto enviado', 190.00),
('2024-02-04', 24, 'Cobranza', 'Cobro de servicio cancelado', 170.00),
('2024-02-05', 25, 'Fraude', 'Robo de identidad', 1100.00),
('2024-02-06', 26, 'Servicio', 'Reactivación de servicio demorada', 320.00),
('2024-02-07', 27, 'Producto', 'Entrega de producto fuera de plazo', 380.00),
('2024-02-08', 28, 'Cobranza', 'Cobro doble en la factura', 420.00),
('2024-02-09', 29, 'Fraude', 'Estafa telefónica', 650.00),
('2024-02-10', 30, 'Servicio', 'Errores recurrentes en la factura', 150.00),
('2024-02-11', 31, 'Producto', 'Producto dañado durante envío', 130.00),
('2024-02-12', 32, 'Cobranza', 'Cobro excesivo de intereses', 780.00),
('2024-02-13', 33, 'Fraude', 'Suplantación de identidad online', 820.00),
('2024-02-14', 34, 'Servicio', 'Fallo en el servicio de atención al cliente', 240.00),
('2024-02-15', 35, 'Producto', 'Falta de piezas en el pedido', 360.00),
('2024-02-16', 36, 'Cobranza', 'Facturación incorrecta de servicios', 190.00),
('2024-02-17', 37, 'Fraude', 'Transacción no autorizada en cuenta', 950.00),
('2024-02-18', 38, 'Servicio', 'Demora en la instalación del servicio', 170.00),
('2024-02-19', 39, 'Producto', 'Producto defectuoso recibido', 270.00),
('2024-02-20', 40, 'Cobranza', 'Cobro indebido por mantenimiento', 140.00);
GO

-- Insertar datos en Reclamos para clientes del 40 al 78
INSERT INTO Reclamos (fecha_reclamo, id_cliente, categoria_reclamo, descripcion_reclamo, monto_involucrado)
VALUES 
('2024-02-21', 41, 'Fraude', 'Uso no autorizado de la tarjeta de débito', 580.00),
('2024-02-22', 42, 'Servicio', 'Mala atención en sucursal', 340.00),
('2024-02-23', 43, 'Producto', 'Entrega de producto incorrecto', 210.00),
('2024-02-24', 44, 'Cobranza', 'Cobro adicional no autorizado', 190.00),
('2024-02-25', 45, 'Fraude', 'Intento de suplantación de identidad', 1200.00),
('2024-02-26', 46, 'Servicio', 'Fallo en el servicio de reparación', 360.00),
('2024-02-27', 47, 'Producto', 'Producto entregado con defecto', 420.00),
('2024-02-28', 48, 'Cobranza', 'Cargo duplicado en tarjeta de crédito', 460.00),
('2024-02-29', 49, 'Fraude', 'Robo de información bancaria online', 690.00),
('2024-03-01', 50, 'Servicio', 'Retraso en la atención al cliente telefónica', 180.00),
('2024-03-02', 51, 'Producto', 'Piezas faltantes en el envío', 160.00),
('2024-03-03', 52, 'Cobranza', 'Cargos no reconocidos en factura', 800.00),
('2024-03-04', 53, 'Fraude', 'Intento de phishing por correo electrónico', 840.00),
('2024-03-05', 54, 'Servicio', 'Fallo en la entrega de servicios', 260.00),
('2024-03-06', 55, 'Producto', 'Entrega de producto dañado', 380.00),
('2024-03-07', 56, 'Cobranza', 'Cobro excesivo en factura de servicios', 200.00),
('2024-03-08', 57, 'Fraude', 'Suplantación de identidad en transacción', 980.00),
('2024-03-09', 58, 'Servicio', 'Demora en la instalación de equipo', 220.00),
('2024-03-10', 59, 'Producto', 'Producto defectuoso después de uso', 290.00),
('2024-03-11', 60, 'Cobranza', 'Cobro indebido por servicio cancelado', 180.00),
('2024-03-12', 61, 'Fraude', 'Intento de estafa telefónica', 510.00),
('2024-03-13', 62, 'Servicio', 'Respuesta tardía en la reparación', 300.00),
('2024-03-14', 63, 'Producto', 'Recepción de producto incorrecto', 230.00),
('2024-03-15', 64, 'Cobranza', 'Errores en el cálculo de intereses', 560.00),
('2024-03-16', 65, 'Fraude', 'Uso fraudulento de la cuenta bancaria', 720.00),
('2024-03-17', 66, 'Servicio', 'Fallo en el soporte técnico online', 280.00),
('2024-03-18', 67, 'Producto', 'Producto dañado en tránsito', 410.00),
('2024-03-19', 68, 'Cobranza', 'Facturación incorrecta en servicios', 240.00),
('2024-03-20', 69, 'Fraude', 'Cargo duplicado en tarjeta de débito', 990.00),
('2024-03-21', 70, 'Servicio', 'Retraso en la activación de servicios', 200.00),
('2024-03-22', 71, 'Producto', 'Falta de accesorios en el paquete', 180.00),
('2024-03-23', 72, 'Cobranza', 'Cobro adicional no autorizado', 820.00),
('2024-03-24', 73, 'Fraude', 'Estafa telefónica sobre servicios adicionales', 860.00),
('2024-03-25', 74, 'Servicio', 'Mala respuesta en línea de ayuda', 280.00),
('2024-03-26', 75, 'Producto', 'Producto incorrecto en pedido en línea', 390.00),
('2024-03-27', 76, 'Cobranza', 'Cargo no reconocido en la tarjeta de crédito', 210.00),
('2024-03-28', 77, 'Fraude', 'Intento de suplantación en línea', 1030.00),
('2024-03-29', 78, 'Servicio', 'Problemas recurrentes con el soporte al cliente', 190.00);
GO

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
    ('Fraude', 'Compra no autorizada'),
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
    ('Errores en la cuenta', 'Problemas con el cajero automático');
GO



SELECT * FROM Resoluciones;
GO

-- Insertar datos en Resoluciones con valores no nulos para fecha_resolucion
INSERT INTO Resoluciones (id_reclamo, estado_reclamo, fecha_resolucion, solucion_ofrecida, comentarios_adicionales)
VALUES 
(1, 'Resuelto', '2024-01-10', 'Reembolso completo', 'Cliente satisfecho con la resolución.'),
(2, 'En Proceso', '2024-01-15', 'Investigación en curso', 'Cliente informado del progreso.'),
(3, 'Pendiente', '2024-01-20', 'En proceso', 'Esperando respuesta del proveedor.'),
(4, 'Resuelto', '2024-01-20', 'Corrección del cobro', 'Cliente informado del ajuste.'),
(5, 'En Proceso', '2024-01-25', 'Reembolso parcial', 'Cliente aceptó la solución.'),
(6, 'Pendiente', '2024-01-30', 'En proceso', 'Requiere más información del cliente.'),
(7, 'Resuelto', '2024-01-30', 'Entrega del producto', 'Cliente confirmó la recepción.'),
(8, 'En Proceso', '2024-02-05', 'Revisión de intereses', 'Cliente informado de la revisión.'),
(9, 'Pendiente', '2024-02-10', 'En proceso', 'Esperando documentación adicional.'),
(10, 'Resuelto', '2024-02-10', 'Disculpa oficial', 'Cliente aceptó la disculpa.'),
(11, 'En Proceso', '2024-02-15', 'Reemplazo del producto', 'Cliente informó satisfacción parcial.'),
(12, 'Pendiente', '2024-02-20', 'En proceso', 'Caso escalado a supervisión.'),
(13, 'Resuelto', '2024-02-20', 'Cambio de credenciales', 'Cliente satisfecho con la seguridad.'),
(14, 'En Proceso', '2024-02-25', 'Revisión técnica', 'Cliente informado de la revisión.'),
(15, 'Pendiente', '2024-03-01', 'En proceso', 'Esperando resolución del proveedor.'),
(16, 'Resuelto', '2024-03-01', 'Ajuste de comisiones', 'Cliente informado del ajuste.'),
(17, 'En Proceso', '2024-03-05', 'Investigación en curso', 'Cliente informado del progreso.'),
(18, 'Pendiente', '2024-03-10', 'En proceso', 'Requiere más información del cliente.'),
(19, 'Resuelto', '2024-03-10', 'Reembolso parcial', 'Cliente aceptó la solución.'),
(20, 'En Proceso', '2024-03-15', 'Revisión del cobro', 'Cliente informado del ajuste.'),
(21, 'Resuelto', '2024-03-20', 'Reembolso completo', 'Cliente satisfecho con la resolución.'),
(22, 'En Proceso', '2024-03-25', 'Investigación en curso', 'Cliente informado del progreso.'),
(23, 'Pendiente', '2024-03-30', 'En proceso', 'Esperando respuesta del proveedor.'),
(24, 'Resuelto', '2024-04-01', 'Corrección del cobro', 'Cliente informado del ajuste.'),
(25, 'En Proceso', '2024-04-05', 'Reembolso parcial', 'Cliente aceptó la solución.'),
(26, 'Pendiente', '2024-04-10', 'En proceso', 'Requiere más información del cliente.'),
(27, 'Resuelto', '2024-04-10', 'Entrega del producto', 'Cliente confirmó la recepción.'),
(28, 'En Proceso', '2024-04-15', 'Revisión de intereses', 'Cliente informado de la revisión.'),
(29, 'Pendiente', '2024-04-20', 'En proceso', 'Esperando documentación adicional.'),
(30, 'Resuelto', '2024-04-20', 'Disculpa oficial', 'Cliente aceptó la disculpa.'),
(31, 'En Proceso', '2024-04-25', 'Reemplazo del producto', 'Cliente informó satisfacción parcial.'),
(32, 'Pendiente', '2024-04-30', 'En proceso', 'Caso escalado a supervisión.'),
(33, 'Resuelto', '2024-05-01', 'Cambio de credenciales', 'Cliente satisfecho con la seguridad.'),
(34, 'En Proceso', '2024-05-05', 'Revisión técnica', 'Cliente informado de la revisión.'),
(35, 'Pendiente', '2024-05-10', 'En proceso', 'Esperando resolución del proveedor.'),
(36, 'Resuelto', '2024-05-10', 'Ajuste de comisiones', 'Cliente informado del ajuste.'),
(37, 'En Proceso', '2024-05-15', 'Investigación en curso', 'Cliente informado del progreso.'),
(38, 'Pendiente', '2024-05-20', 'En proceso', 'Requiere más información del cliente.'),
(39, 'Resuelto', '2024-05-20', 'Reembolso parcial', 'Cliente aceptó la solución.'),
(40, 'En Proceso', '2024-05-25', 'Revisión del cobro', 'Cliente informado del ajuste.');
GO

-- Insertar datos en Resoluciones con valores no nulos para fecha_resolucion
INSERT INTO Resoluciones (id_reclamo, estado_reclamo, fecha_resolucion, solucion_ofrecida, comentarios_adicionales)
VALUES 
(41, 'En Proceso', '2024-02-05', 'Revisión de intereses', 'Cliente informado de la revisión.'),
(42, 'Pendiente', '2024-02-10', 'En proceso', 'Esperando documentación adicional.'),
(43, 'Resuelto', '2024-02-10', 'Disculpa oficial', 'Cliente aceptó la disculpa.'),
(44, 'En Proceso', '2024-02-15', 'Reemplazo del producto', 'Cliente informó satisfacción parcial.'),
(45, 'Pendiente', '2024-02-20', 'En proceso', 'Caso escalado a supervisión.'),
(46, 'Resuelto', '2024-02-20', 'Cambio de credenciales', 'Cliente satisfecho con la seguridad.'),
(47, 'En Proceso', '2024-02-25', 'Revisión técnica', 'Cliente informado de la revisión.'),
(48, 'Pendiente', '2024-03-01', 'En proceso', 'Esperando resolución del proveedor.'),
(49, 'Resuelto', '2024-03-01', 'Ajuste de comisiones', 'Cliente informado del ajuste.'),
(50, 'En Proceso', '2024-03-05', 'Investigación en curso', 'Cliente informado del progreso.'),
(51, 'Pendiente', '2024-03-10', 'En proceso', 'Requiere más información del cliente.'),
(52, 'Resuelto', '2024-03-10', 'Reembolso parcial', 'Cliente aceptó la solución.'),
(53, 'En Proceso', '2024-03-15', 'Revisión del cobro', 'Cliente informado del ajuste.'),
(54, 'Resuelto', '2024-03-20', 'Reembolso completo', 'Cliente satisfecho con la resolución.'),
(55, 'En Proceso', '2024-03-25', 'Investigación en curso', 'Cliente informado del progreso.'),
(56, 'Pendiente', '2024-03-30', 'En proceso', 'Esperando respuesta del proveedor.'),
(57, 'Resuelto', '2024-04-01', 'Corrección del cobro', 'Cliente informado del ajuste.'),
(58, 'En Proceso', '2024-04-05', 'Reembolso parcial', 'Cliente aceptó la solución.'),
(59, 'Pendiente', '2024-04-10', 'En proceso', 'Requiere más información del cliente.'),
(60, 'Resuelto', '2024-04-10', 'Entrega del producto', 'Cliente confirmó la recepción.'),
(61, 'En Proceso', '2024-04-15', 'Revisión de intereses', 'Cliente informado de la revisión.'),
(62, 'Pendiente', '2024-04-20', 'En proceso', 'Esperando documentación adicional.'),
(63, 'Resuelto', '2024-04-20', 'Disculpa oficial', 'Cliente aceptó la disculpa.'),
(64, 'En Proceso', '2024-04-25', 'Reemplazo del producto', 'Cliente informó satisfacción parcial.'),
(65, 'Pendiente', '2024-04-30', 'En proceso', 'Caso escalado a supervisión.'),
(66, 'Resuelto', '2024-05-01', 'Cambio de credenciales', 'Cliente satisfecho con la seguridad.'),
(67, 'En Proceso', '2024-05-05', 'Revisión técnica', 'Cliente informado de la revisión.'),
(68, 'Pendiente', '2024-05-10', 'En proceso', 'Esperando resolución del proveedor.'),
(69, 'Resuelto', '2024-05-10', 'Ajuste de comisiones', 'Cliente informado del ajuste.'),
(70, 'En Proceso', '2024-05-15', 'Investigación en curso', 'Cliente informado del progreso.'),
(71, 'Pendiente', '2024-05-20', 'En proceso', 'Requiere más información del cliente.'),
(72, 'Resuelto', '2024-05-20', 'Reembolso parcial', 'Cliente aceptó la solución.'),
(73, 'En Proceso', '2024-05-25', 'Revisión del cobro', 'Cliente informado del ajuste.'),
(74, 'Resuelto', '2024-06-01', 'Reembolso completo', 'Cliente satisfecho con la resolución.'),
(75, 'En Proceso', '2024-06-05', 'Investigación en curso', 'Cliente informado del progreso.'),
(76, 'Pendiente', '2024-06-10', 'En proceso', 'Esperando respuesta del proveedor.'),
(77, 'Resuelto', '2024-06-10', 'Corrección del cobro', 'Cliente informado del ajuste.'),
(78, 'En Proceso', '2024-06-15', 'Reembolso parcial', 'Cliente aceptó la solución.');
GO


-- Insertar datos en Prestamos
INSERT INTO Prestamos (id_cliente, monto_prestamo, tasa_interes, fecha_inicio, duracion_meses)
VALUES 
(1, 5000.00, 5.00, '2024-01-01', 24),
(2, 10000.00, 4.50, '2024-01-02', 36),
(3, 15000.00, 4.75, '2024-01-03', 48),
(4, 20000.00, 5.00, '2024-01-04', 60),
(5, 25000.00, 3.50, '2024-01-05', 72),
(6, 30000.00, 3.75, '2024-01-06', 24),
(7, 35000.00, 4.00, '2024-01-07', 36),
(8, 40000.00, 4.25, '2024-01-08', 48),
(9, 45000.00, 4.50, '2024-01-09', 60),
(10, 50000.00, 5.00, '2024-01-10', 72),
(11, 55000.00, 3.50, '2024-01-11', 24),
(12, 60000.00, 3.75, '2024-01-12', 36),
(13, 65000.00, 4.00, '2024-01-13', 48),
(14, 70000.00, 4.25, '2024-01-14', 60),
(15, 75000.00, 4.50, '2024-01-15', 72),
(16, 80000.00, 5.00, '2024-01-16', 24),
(17, 85000.00, 3.50, '2024-01-17', 36),
(18, 90000.00, 3.75, '2024-01-18', 48),
(19, 95000.00, 4.00, '2024-01-19', 60),
(20, 100000.00, 4.25, '2024-01-20', 72),
(21, 105000.00, 4.50, '2024-01-21', 24),
(22, 110000.00, 5.00, '2024-01-22', 36),
(23, 115000.00, 4.25, '2024-01-23', 48),
(24, 120000.00, 3.75, '2024-01-24', 60),
(25, 125000.00, 3.50, '2024-01-25', 72),
(26, 130000.00, 4.00, '2024-01-26', 24),
(27, 135000.00, 4.50, '2024-01-27', 36),
(28, 140000.00, 5.00, '2024-01-28', 48),
(29, 145000.00, 4.25, '2024-01-29', 60),
(30, 150000.00, 3.75, '2024-01-30', 72),
(31, 155000.00, 4.00, '2024-01-31', 24),
(32, 160000.00, 3.75, '2024-02-01', 36),
(33, 165000.00, 3.50, '2024-02-02', 48),
(34, 170000.00, 4.25, '2024-02-03', 60),
(35, 175000.00, 4.50, '2024-02-04', 72),
(36, 180000.00, 5.00, '2024-02-05', 24),
(37, 185000.00, 4.25, '2024-02-06', 36),
(38, 190000.00, 3.75, '2024-02-07', 48),
(39, 195000.00, 3.50, '2024-02-08', 60),
(40, 200000.00, 4.00, '2024-02-09', 72);
GO

-- Insertar datos en Prestamos
INSERT INTO Prestamos (id_cliente, monto_prestamo, tasa_interes, fecha_inicio, duracion_meses)
VALUES 
(41, 205000.00, 4.25, '2024-02-10', 24),
(42, 210000.00, 3.75, '2024-02-11', 36),
(43, 215000.00, 3.50, '2024-02-12', 48),
(44, 220000.00, 4.25, '2024-02-13', 60),
(45, 225000.00, 4.50, '2024-02-14', 72),
(46, 230000.00, 5.00, '2024-02-15', 24),
(47, 235000.00, 4.25, '2024-02-16', 36),
(48, 240000.00, 3.75, '2024-02-17', 48),
(49, 245000.00, 3.50, '2024-02-18', 60),
(50, 250000.00, 4.00, '2024-02-19', 72),
(51, 255000.00, 4.50, '2024-02-20', 24),
(52, 260000.00, 5.00, '2024-02-21', 36),
(53, 265000.00, 4.25, '2024-02-22', 48),
(54, 270000.00, 3.75, '2024-02-23', 60),
(55, 275000.00, 3.50, '2024-02-24', 72),
(56, 280000.00, 4.00, '2024-02-25', 24),
(57, 285000.00, 4.25, '2024-02-26', 36),
(58, 290000.00, 3.75, '2024-02-27', 48),
(59, 295000.00, 3.50, '2024-02-28', 60),
(60, 300000.00, 4.00, '2024-02-29', 72),
(61, 305000.00, 4.50, '2024-03-01', 24),
(62, 310000.00, 5.00, '2024-03-02', 36),
(63, 315000.00, 4.25, '2024-03-03', 48),
(64, 320000.00, 3.75, '2024-03-04', 60),
(65, 325000.00, 3.50, '2024-03-05', 72),
(66, 330000.00, 4.00, '2024-03-06', 24),
(67, 335000.00, 4.25, '2024-03-07', 36),
(68, 340000.00, 3.75, '2024-03-08', 48),
(69, 345000.00, 3.50, '2024-03-09', 60),
(70, 350000.00, 4.00, '2024-03-10', 72),
(71, 355000.00, 4.50, '2024-03-11', 24),
(72, 360000.00, 5.00, '2024-03-12', 36),
(73, 365000.00, 4.25, '2024-03-13', 48),
(74, 370000.00, 3.75, '2024-03-14', 60),
(75, 375000.00, 3.50, '2024-03-15', 72),
(76, 380000.00, 4.00, '2024-03-16', 24),
(77, 385000.00, 4.25, '2024-03-17', 36),
(78, 390000.00, 3.75, '2024-03-18', 48);
GO


-- Insertar datos en Ahorros
INSERT INTO Ahorros (id_cliente, saldo_actual, tasa_interes, fecha_apertura)
VALUES 
(1, 5000.00, 1.50, '2024-01-01'),
(2, 10000.00, 1.75, '2024-01-02'),
(3, 15000.00, 1.50, '2024-01-03'),
(4, 20000.00, 1.75, '2024-01-04'),
(5, 25000.00, 1.50, '2024-01-05'),
(6, 30000.00, 1.75, '2024-01-06'),
(7, 35000.00, 1.50, '2024-01-07'),
(8, 40000.00, 1.75, '2024-01-08'),
(9, 45000.00, 1.50, '2024-01-09'),
(10, 50000.00, 1.75, '2024-01-10'),
(11, 55000.00, 1.50, '2024-01-11'),
(12, 60000.00, 1.75, '2024-01-12'),
(13, 65000.00, 1.50, '2024-01-13'),
(14, 70000.00, 1.75, '2024-01-14'),
(15, 75000.00, 1.50, '2024-01-15'),
(16, 80000.00, 1.75, '2024-01-16'),
(17, 85000.00, 1.50, '2024-01-17'),
(18, 90000.00, 1.75, '2024-01-18'),
(19, 95000.00, 1.50, '2024-01-19'),
(20, 100000.00, 1.75, '2024-01-20'),
(21, 105000.00, 1.50, '2024-01-21'),
(22, 110000.00, 1.75, '2024-01-22'),
(23, 115000.00, 1.50, '2024-01-23'),
(24, 120000.00, 1.75, '2024-01-24'),
(25, 125000.00, 1.50, '2024-01-25'),
(26, 130000.00, 1.75, '2024-01-26'),
(27, 135000.00, 1.50, '2024-01-27'),
(28, 140000.00, 1.75, '2024-01-28'),
(29, 145000.00, 1.50, '2024-01-29'),
(30, 150000.00, 1.75, '2024-01-30'),
(31, 155000.00, 1.50, '2024-01-31'),
(32, 160000.00, 1.75, '2024-02-01'),
(33, 165000.00, 1.50, '2024-02-02'),
(34, 170000.00, 1.75, '2024-02-03'),
(35, 175000.00, 1.50, '2024-02-04'),
(36, 180000.00, 1.75, '2024-02-05'),
(37, 185000.00, 1.50, '2024-02-06'),
(38, 190000.00, 1.75, '2024-02-07'),
(39, 195000.00, 1.50, '2024-02-08'),
(40, 200000.00, 1.75, '2024-02-09');
GO

-- Insertar datos en Ahorros
INSERT INTO Ahorros (id_cliente, saldo_actual, tasa_interes, fecha_apertura)
VALUES 
(41, 205000.00, 1.50, '2024-02-10'),
(42, 210000.00, 1.75, '2024-02-11'),
(43, 215000.00, 1.50, '2024-02-12'),
(44, 220000.00, 1.75, '2024-02-13'),
(45, 225000.00, 1.50, '2024-02-14'),
(46, 230000.00, 1.75, '2024-02-15'),
(47, 235000.00, 1.50, '2024-02-16'),
(48, 240000.00, 1.75, '2024-02-17'),
(49, 245000.00, 1.50, '2024-02-18'),
(50, 250000.00, 1.75, '2024-02-19'),
(51, 255000.00, 1.50, '2024-02-20'),
(52, 260000.00, 1.75, '2024-02-21'),
(53, 265000.00, 1.50, '2024-02-22'),
(54, 270000.00, 1.75, '2024-02-23'),
(55, 275000.00, 1.50, '2024-02-24'),
(56, 280000.00, 1.75, '2024-02-25'),
(57, 285000.00, 1.50, '2024-02-26'),
(58, 290000.00, 1.75, '2024-02-27'),
(59, 295000.00, 1.50, '2024-02-28'),
(60, 300000.00, 1.75, '2024-02-29'),
(61, 305000.00, 1.50, '2024-03-01'),
(62, 310000.00, 1.75, '2024-03-02'),
(63, 315000.00, 1.50, '2024-03-03'),
(64, 320000.00, 1.75, '2024-03-04'),
(65, 325000.00, 1.50, '2024-03-05'),
(66, 330000.00, 1.75, '2024-03-06'),
(67, 335000.00, 1.50, '2024-03-07'),
(68, 340000.00, 1.75, '2024-03-08'),
(69, 345000.00, 1.50, '2024-03-09'),
(70, 350000.00, 1.75, '2024-03-10'),
(71, 355000.00, 1.50, '2024-03-11'),
(72, 360000.00, 1.75, '2024-03-12'),
(73, 365000.00, 1.50, '2024-03-13'),
(74, 370000.00, 1.75, '2024-03-14'),
(75, 375000.00, 1.50, '2024-03-15'),
(76, 380000.00, 1.75, '2024-03-16'),
(77, 385000.00, 1.50, '2024-03-17'),
(78, 390000.00, 1.75, '2024-03-18');
GO


-- Insertar datos en Retiros
INSERT INTO Retiros (id_cliente, id_cuenta_ahorro, monto_retiro, fecha_retiro)
VALUES 
(1, 1, 1000.00, '2024-01-01'),
(2, 2, 2000.00, '2024-01-02'),
(3, 3, 3000.00, '2024-01-03'),
(4, 4, 4000.00, '2024-01-04'),
(5, 5, 5000.00, '2024-01-05'),
(6, 6, 6000.00, '2024-01-06'),
(7, 7, 7000.00, '2024-01-07'),
(8, 8, 8000.00, '2024-01-08'),
(9, 9, 9000.00, '2024-01-09'),
(10, 10, 10000.00, '2024-01-10'),
(11, 11, 11000.00, '2024-01-11'),
(12, 12, 12000.00, '2024-01-12'),
(13, 13, 13000.00, '2024-01-13'),
(14, 14, 14000.00, '2024-01-14'),
(15, 15, 15000.00, '2024-01-15'),
(16, 16, 16000.00, '2024-01-16'),
(17, 17, 17000.00, '2024-01-17'),
(18, 18, 18000.00, '2024-01-18'),
(19, 19, 19000.00, '2024-01-19'),
(20, 20, 20000.00, '2024-01-20'),
(21, 21, 21000.00, '2024-01-21'),
(22, 22, 22000.00, '2024-01-22'),
(23, 23, 23000.00, '2024-01-23'),
(24, 24, 24000.00, '2024-01-24'),
(25, 25, 25000.00, '2024-01-25'),
(26, 26, 26000.00, '2024-01-26'),
(27, 27, 27000.00, '2024-01-27'),
(28, 28, 28000.00, '2024-01-28'),
(29, 29, 29000.00, '2024-01-29'),
(30, 30, 30000.00, '2024-01-30'),
(31, 31, 31000.00, '2024-01-31'),
(32, 32, 32000.00, '2024-02-01'),
(33, 33, 33000.00, '2024-02-02'),
(34, 34, 34000.00, '2024-02-03'),
(35, 35, 35000.00, '2024-02-04'),
(36, 36, 36000.00, '2024-02-05'),
(37, 37, 37000.00, '2024-02-06'),
(38, 38, 38000.00, '2024-02-07'),
(39, 39, 39000.00, '2024-02-08'),
(40, 40, 40000.00, '2024-02-09');
GO

-- Insertar datos en Retiros
INSERT INTO Retiros (id_cliente, id_cuenta_ahorro, monto_retiro, fecha_retiro)
VALUES 
(41, 41, 41000.00, '2024-02-10'),
(42, 42, 42000.00, '2024-02-11'),
(43, 43, 43000.00, '2024-02-12'),
(44, 44, 44000.00, '2024-02-13'),
(45, 45, 45000.00, '2024-02-14'),
(46, 46, 46000.00, '2024-02-15'),
(47, 47, 47000.00, '2024-02-16'),
(48, 48, 48000.00, '2024-02-17'),
(49, 49, 49000.00, '2024-02-18'),
(50, 50, 50000.00, '2024-02-19'),
(51, 51, 51000.00, '2024-02-20'),
(52, 52, 52000.00, '2024-02-21'),
(53, 53, 53000.00, '2024-02-22'),
(54, 54, 54000.00, '2024-02-23'),
(55, 55, 55000.00, '2024-02-24'),
(56, 56, 56000.00, '2024-02-25'),
(57, 57, 57000.00, '2024-02-26'),
(58, 58, 58000.00, '2024-02-27'),
(59, 59, 59000.00, '2024-02-28'),
(60, 60, 60000.00, '2024-02-29'),
(61, 61, 61000.00, '2024-03-01'),
(62, 62, 62000.00, '2024-03-02'),
(63, 63, 63000.00, '2024-03-03'),
(64, 64, 64000.00, '2024-03-04'),
(65, 65, 65000.00, '2024-03-05'),
(66, 66, 66000.00, '2024-03-06'),
(67, 67, 67000.00, '2024-03-07'),
(68, 68, 68000.00, '2024-03-08'),
(69, 69, 69000.00, '2024-03-09'),
(70, 70, 70000.00, '2024-03-10'),
(71, 71, 71000.00, '2024-03-11'),
(72, 72, 72000.00, '2024-03-12'),
(73, 73, 73000.00, '2024-03-13'),
(74, 74, 74000.00, '2024-03-14'),
(75, 75, 75000.00, '2024-03-15'),
(76, 76, 76000.00, '2024-03-16'),
(77, 77, 77000.00, '2024-03-17'),
(78, 78, 78000.00, '2024-03-18');
GO


-- Insertar datos en Hipotecas
INSERT INTO Hipotecas (id_cliente, monto_hipoteca, tasa_interes, duracion_meses, fecha_inicio)
VALUES 
(1, 150000.00, 3.00, 240, '2024-01-01'),
(2, 200000.00, 3.25, 300, '2024-01-02'),
(3, 250000.00, 3.50, 360, '2024-01-03'),
(4, 300000.00, 3.75, 240, '2024-01-04'),
(5, 350000.00, 3.00, 300, '2024-01-05'),
(6, 400000.00, 3.25, 360, '2024-01-06'),
(7, 450000.00, 3.50, 240, '2024-01-07'),
(8, 500000.00, 3.75, 300, '2024-01-08'),
(9, 550000.00, 3.00, 360, '2024-01-09'),
(10, 600000.00, 3.25, 240, '2024-01-10'),
(11, 650000.00, 3.50, 300, '2024-01-11'),
(12, 700000.00, 3.75, 360, '2024-01-12'),
(13, 750000.00, 3.00, 240, '2024-01-13'),
(14, 800000.00, 3.25, 300, '2024-01-14'),
(15, 850000.00, 3.50, 360, '2024-01-15'),
(16, 900000.00, 3.75, 240, '2024-01-16'),
(17, 950000.00, 3.00, 300, '2024-01-17'),
(18, 1000000.00, 3.25, 360, '2024-01-18'),
(19, 1050000.00, 3.50, 240, '2024-01-19'),
(20, 1100000.00, 3.75, 300, '2024-01-20'),
(21, 1150000.00, 3.00, 360, '2024-01-21'),
(22, 1200000.00, 3.25, 240, '2024-01-22'),
(23, 1250000.00, 3.50, 300, '2024-01-23'),
(24, 1300000.00, 3.75, 360, '2024-01-24'),
(25, 1350000.00, 3.00, 240, '2024-01-25'),
(26, 1400000.00, 3.25, 300, '2024-01-26'),
(27, 1450000.00, 3.50, 360, '2024-01-27'),
(28, 1500000.00, 3.75, 240, '2024-01-28'),
(29, 1550000.00, 3.00, 300, '2024-01-29'),
(30, 1600000.00, 3.25, 360, '2024-01-30'),
(31, 1650000.00, 3.50, 240, '2024-01-31'),
(32, 1700000.00, 3.75, 300, '2024-02-01'),
(33, 1750000.00, 3.00, 360, '2024-02-02'),
(34, 1800000.00, 3.25, 240, '2024-02-03'),
(35, 1850000.00, 3.50, 300, '2024-02-04'),
(36, 1900000.00, 3.75, 360, '2024-02-05'),
(37, 1950000.00, 3.00, 240, '2024-02-06'),
(38, 2000000.00, 3.25, 300, '2024-02-07'),
(39, 2050000.00, 3.50, 360, '2024-02-08'),
(40, 2100000.00, 3.75, 240, '2024-02-09');
GO

-- Insertar datos en Hipotecas
INSERT INTO Hipotecas (id_cliente, monto_hipoteca, tasa_interes, duracion_meses, fecha_inicio)
VALUES 
(41, 2150000.00, 3.00, 300, '2024-02-10'),
(42, 2200000.00, 3.25, 360, '2024-02-11'),
(43, 2250000.00, 3.50, 240, '2024-02-12'),
(44, 2300000.00, 3.75, 300, '2024-02-13'),
(45, 2350000.00, 3.00, 360, '2024-02-14'),
(46, 2400000.00, 3.25, 240, '2024-02-15'),
(47, 2450000.00, 3.50, 300, '2024-02-16'),
(48, 2500000.00, 3.75, 360, '2024-02-17'),
(49, 2550000.00, 3.00, 240, '2024-02-18'),
(50, 2600000.00, 3.25, 300, '2024-02-19'),
(51, 2650000.00, 3.50, 360, '2024-02-20'),
(52, 2700000.00, 3.75, 240, '2024-02-21'),
(53, 2750000.00, 3.00, 300, '2024-02-22'),
(54, 2800000.00, 3.25, 360, '2024-02-23'),
(55, 2850000.00, 3.50, 240, '2024-02-24'),
(56, 2900000.00, 3.75, 300, '2024-02-25'),
(57, 2950000.00, 3.00, 360, '2024-02-26'),
(58, 3000000.00, 3.25, 240, '2024-02-27'),
(59, 3050000.00, 3.50, 300, '2024-02-28'),
(60, 3100000.00, 3.75, 360, '2024-02-29'),
(61, 3150000.00, 3.00, 240, '2024-03-01'),
(62, 3200000.00, 3.25, 300, '2024-03-02'),
(63, 3250000.00, 3.50, 360, '2024-03-03'),
(64, 3300000.00, 3.75, 240, '2024-03-04'),
(65, 3350000.00, 3.00, 300, '2024-03-05'),
(66, 3400000.00, 3.25, 360, '2024-03-06'),
(67, 3450000.00, 3.50, 240, '2024-03-07'),
(68, 3500000.00, 3.75, 300, '2024-03-08'),
(69, 3550000.00, 3.00, 360, '2024-03-09'),
(70, 3600000.00, 3.25, 240, '2024-03-10'),
(71, 3650000.00, 3.50, 300, '2024-03-11'),
(72, 3700000.00, 3.75, 360, '2024-03-12'),
(73, 3750000.00, 3.00, 240, '2024-03-13'),
(74, 3800000.00, 3.25, 300, '2024-03-14'),
(75, 3850000.00, 3.50, 360, '2024-03-15'),
(76, 3900000.00, 3.75, 240, '2024-03-16'),
(77, 3950000.00, 3.00, 300, '2024-03-17'),
(78, 4000000.00, 3.25, 360, '2024-03-18');
GO

UPDATE Reclamos
SET categoria_reclamo = COALESCE(categoria_reclamo, ''),
    descripcion_reclamo = COALESCE(descripcion_reclamo, ''),
    monto_involucrado = COALESCE(monto_involucrado, 0.00)
WHERE categoria_reclamo IS NULL
   OR descripcion_reclamo IS NULL
   OR monto_involucrado IS NULL;


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


SELECT * FROM Reclamos;
SELECT * FROM Resoluciones;
SELECT * FROM Retiros;
SELECT * FROM Hipotecas;
SELECT * FROM Ahorros;
SELECT * FROM  Prestamos;
SELECT * FROM Clientes;


-- Limpiar tablas existentes
DELETE FROM Resoluciones;
DELETE FROM Retiros;
DELETE FROM Hipotecas;
DELETE FROM Ahorros;
DELETE FROM Prestamos;
DELETE FROM Reclamos;
DELETE FROM Clientes;
GO

-- Vaciar todas las tablas desde cero
DELETE FROM Resoluciones;
DBCC CHECKIDENT ('Resoluciones', RESEED, 0);

DELETE FROM Retiros;
DBCC CHECKIDENT ('Retiros', RESEED, 0);

DELETE FROM Hipotecas;
DBCC CHECKIDENT ('Hipotecas', RESEED, 0);

DELETE FROM Ahorros;
DBCC CHECKIDENT ('Ahorros', RESEED, 0);

DELETE FROM Prestamos;
DBCC CHECKIDENT ('Prestamos', RESEED, 0);

DELETE FROM Reclamos;
DBCC CHECKIDENT ('Reclamos', RESEED, 0);

DELETE FROM Clientes;
DBCC CHECKIDENT ('Clientes', RESEED, 0);
GO



-- Modificar tabla Ahorros para incluir la columna id_cuenta_ahorro
ALTER TABLE Ahorros
ADD id_cuenta_ahorro INT;

-- Luego, puedes actualizar el procedimiento almacenado GenerarDatosCompletos_v2 para utilizar esta columna correctamente.

DECLARE @num_registros INT = 500;  -- Número de registros a generar
DECLARE @fecha_inicio DATE = '2010-01-01';  -- Fecha de inicio
DECLARE @fecha_fin DATE = '2024-07-10';  -- Fecha de fin

-- Generar datos aleatorios para Prestamos
INSERT INTO Prestamos (id_cliente, monto_prestamo, tasa_interes, fecha_inicio, duracion_meses)
SELECT 
    TOP (@num_registros)
    id_cliente,
    ROUND(RAND() * 100000 + 5000, 2),  -- Monto aleatorio entre 5000 y 105000
    ROUND(RAND() * 4 + 3, 2),         -- Tasa de interés aleatoria entre 3% y 7%
    DATEADD(DAY, ROUND(RAND() * DATEDIFF(DAY, @fecha_inicio, @fecha_fin), 0), @fecha_inicio), -- Fecha de inicio aleatoria entre las fechas especificadas
    ROUND(RAND() * 60 + 12, 0)        -- Duración en meses aleatoria entre 12 y 72 meses
FROM 
    Clientes
ORDER BY 
    NEWID();

-- Generar datos aleatorios para Ahorros
INSERT INTO Ahorros (id_cliente, saldo_actual, tasa_interes, fecha_apertura)
SELECT 
    TOP (@num_registros)
    id_cliente,
    ROUND(RAND() * 50000 + 10000, 2),  -- Saldo actual aleatorio entre 10000 y 60000
    ROUND(RAND() * 1.5 + 1, 2),        -- Tasa de interés aleatoria entre 1% y 2.5%
    DATEADD(DAY, ROUND(RAND() * DATEDIFF(DAY, @fecha_inicio, @fecha_fin), 0), @fecha_inicio)  -- Fecha de apertura aleatoria entre las fechas especificadas
FROM 
    Clientes
ORDER BY 
    NEWID();

-- Generar datos aleatorios para Retiros
INSERT INTO Retiros (id_cliente, id_cuenta_ahorro, monto_retiro, fecha_retiro)
SELECT 
    TOP (@num_registros)
    id_cliente,
    ROUND(RAND() * 40 + 1, 0),          -- ID de cuenta de ahorro aleatorio entre 1 y 40
    ROUND(RAND() * 10000 + 1000, 2),   -- Monto de retiro aleatorio entre 1000 y 11000
    DATEADD(DAY, ROUND(RAND() * DATEDIFF(DAY, @fecha_inicio, @fecha_fin), 0), @fecha_inicio)  -- Fecha de retiro aleatoria entre las fechas especificadas
FROM 
    Clientes
ORDER BY 
    NEWID();

-- Generar datos aleatorios para Reclamos
INSERT INTO Reclamos (id_cliente, categoria_reclamo, descripcion_reclamo, monto_involucrado, fecha_reclamo)
SELECT 
    TOP (@num_registros)
    id_cliente,
    CASE ROUND(RAND() * 3, 0)
        WHEN 0 THEN 'Producto'
        WHEN 1 THEN 'Servicio'
        ELSE 'Facturación'
    END,
    CONCAT('Reclamo sobre ', 
        CASE ROUND(RAND() * 2, 0)
            WHEN 0 THEN 'problemas con la entrega'
            WHEN 1 THEN 'calidad del servicio'
            ELSE 'cobro incorrecto'
        END),
    ROUND(RAND() * 500 + 100, 2),      -- Monto involucrado aleatorio entre 100 y 600
    DATEADD(DAY, ROUND(RAND() * DATEDIFF(DAY, @fecha_inicio, @fecha_fin), 0), @fecha_inicio)  -- Fecha de reclamo aleatoria entre las fechas especificadas
FROM 
    Clientes
ORDER BY 
    NEWID();
	-- Generar datos aleatorios para Resoluciones
INSERT INTO Resoluciones (id_reclamo, estado_reclamo, fecha_resolucion, solucion_ofrecida, comentarios_adicionales)
SELECT 
    TOP (@num_registros)
    r.id_reclamo,
    CASE ROUND(RAND() * 1, 0)
        WHEN 0 THEN 'Pendiente'
        ELSE 'Resuelto'
    END,
    DATEADD(DAY, ROUND(RAND() * 30, 0), r.fecha_reclamo),  -- Fecha de resolución dentro de los 30 días siguientes al reclamo
    CONCAT('Solución propuesta para ', 
        CASE ROUND(RAND() * 2, 0)
            WHEN 0 THEN 'mejorar el servicio'
            WHEN 1 THEN 'ajustar la facturación'
            ELSE 'reembolsar el monto'
        END),
    'Comentario adicional aleatorio'
FROM 
    Reclamos r
ORDER BY 
    NEWID();


-- Generar datos aleatorios para Hipotecas
INSERT INTO Hipotecas (id_cliente, monto_hipoteca, tasa_interes, duracion_meses, fecha_inicio)
SELECT 
    TOP (@num_registros)
    id_cliente,
    ROUND(RAND() * 500000 + 100000, 2),  -- Monto de hipoteca aleatorio entre 100000 y 600000
    ROUND(RAND() * 3.5 + 3, 2),          -- Tasa de interés aleatoria entre 3% y 6.5%
    ROUND(RAND() * 360 + 120, 0),        -- Duración en meses aleatoria entre 120 y 480 meses
    DATEADD(DAY, ROUND(RAND() * DATEDIFF(DAY, @fecha_inicio, @fecha_fin), 0), @fecha_inicio)  -- Fecha de inicio aleatoria entre las fechas especificadas
FROM 
    Clientes
ORDER BY 
    NEWID();





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
    -- Última fecha y categoría de reclamo
    (SELECT TOP 1 fecha_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) AS ultima_fecha_reclamo,
    (SELECT TOP 1 categoria_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) AS ultima_categoria_reclamo,
    -- Estado del último reclamo según la solución ofrecida
    CASE 
        WHEN (SELECT TOP 1 estado_reclamo FROM Resoluciones WHERE id_reclamo = (SELECT TOP 1 id_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) ORDER BY fecha_resolucion DESC) = 'Resuelto'
            THEN 'Resuelto'
        WHEN (SELECT TOP 1 estado_reclamo FROM Resoluciones WHERE id_reclamo = (SELECT TOP 1 id_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) ORDER BY fecha_resolucion DESC) = 'Pendiente'
            THEN 'Pendiente'
        ELSE 'No Resuelto'
    END AS estado_ultimo_reclamo,
    -- Fecha de resolución del último reclamo
    (SELECT TOP 1 fecha_resolucion FROM Resoluciones WHERE id_reclamo = (SELECT TOP 1 id_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) ORDER BY fecha_resolucion DESC) AS fecha_resolucion_ultimo_reclamo,
    -- Solución ofrecida del último reclamo
    (SELECT TOP 1 solucion_ofrecida FROM Resoluciones WHERE id_reclamo = (SELECT TOP 1 id_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) ORDER BY fecha_resolucion DESC) AS solucion_ofrecida_ultimo_reclamo,
    -- Cálculo del tiempo de resolución del último reclamo
    DATEDIFF(DAY, 
        (SELECT TOP 1 fecha_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC), 
        (SELECT TOP 1 fecha_resolucion FROM Resoluciones WHERE id_reclamo = (SELECT TOP 1 id_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) ORDER BY fecha_resolucion DESC)
    ) AS tiempo_resolucion_ultimo_reclamo
FROM 
    Clientes c
LEFT JOIN 
    Prestamos p ON c.id_cliente = p.id_cliente
LEFT JOIN 
    Ahorros a ON c.id_cliente = a.id_cliente
LEFT JOIN 
    Retiros r ON c.id_cliente = r.id_cliente;




DECLARE @num_registros INT = 1000;  -- Número de registros a generar
DECLARE @fecha_inicio DATE = '2005-01-01';  -- Fecha de inicio
DECLARE @fecha_fin DATE = '2010-01-01';  -- Fecha de fin

-- Generar datos aleatorios para Prestamos
INSERT INTO Prestamos (id_cliente, monto_prestamo, tasa_interes, fecha_inicio, duracion_meses)
SELECT 
    TOP (@num_registros)
    id_cliente,
    ROUND(RAND() * 100000 + 5000, 2),  -- Monto aleatorio entre 5000 y 105000
    ROUND(RAND() * 4 + 3, 2),         -- Tasa de interés aleatoria entre 3% y 7%
    DATEADD(DAY, ROUND(RAND() * DATEDIFF(DAY, @fecha_inicio, @fecha_fin), 0), @fecha_inicio), -- Fecha de inicio aleatoria entre las fechas especificadas
    ROUND(RAND() * 60 + 12, 0)        -- Duración en meses aleatoria entre 12 y 72 meses
FROM 
    Clientes
ORDER BY 
    NEWID();

-- Generar datos aleatorios para Ahorros
INSERT INTO Ahorros (id_cliente, saldo_actual, tasa_interes, fecha_apertura)
SELECT 
    TOP (@num_registros)
    id_cliente,
    ROUND(RAND() * 50000 + 10000, 2),  -- Saldo actual aleatorio entre 10000 y 60000
    ROUND(RAND() * 1.5 + 1, 2),        -- Tasa de interés aleatoria entre 1% y 2.5%
    DATEADD(DAY, ROUND(RAND() * DATEDIFF(DAY, @fecha_inicio, @fecha_fin), 0), @fecha_inicio)  -- Fecha de apertura aleatoria entre las fechas especificadas
FROM 
    Clientes
ORDER BY 
    NEWID();

-- Generar datos aleatorios para Retiros
INSERT INTO Retiros (id_cliente, id_cuenta_ahorro, monto_retiro, fecha_retiro)
SELECT 
    TOP (@num_registros)
    id_cliente,
    ROUND(RAND() * 40 + 1, 0),          -- ID de cuenta de ahorro aleatorio entre 1 y 40
    ROUND(RAND() * 10000 + 1000, 2),   -- Monto de retiro aleatorio entre 1000 y 11000
    DATEADD(DAY, ROUND(RAND() * DATEDIFF(DAY, @fecha_inicio, @fecha_fin), 0), @fecha_inicio)  -- Fecha de retiro aleatoria entre las fechas especificadas
FROM 
    Clientes
ORDER BY 
    NEWID();

-- Generar datos aleatorios para Reclamos
INSERT INTO Reclamos (id_cliente, categoria_reclamo, descripcion_reclamo, monto_involucrado, fecha_reclamo)
SELECT 
    TOP (@num_registros)
    id_cliente,
    CASE ROUND(RAND() * 3, 0)
        WHEN 0 THEN 'Producto'
        WHEN 1 THEN 'Servicio'
        ELSE 'Facturación'
    END,
    CONCAT('Reclamo sobre ', 
        CASE ROUND(RAND() * 2, 0)
            WHEN 0 THEN 'problemas con la entrega'
            WHEN 1 THEN 'calidad del servicio'
            ELSE 'cobro incorrecto'
        END),
    ROUND(RAND() * 500 + 100, 2),      -- Monto involucrado aleatorio entre 100 y 600
    DATEADD(DAY, ROUND(RAND() * DATEDIFF(DAY, @fecha_inicio, @fecha_fin), 0), @fecha_inicio)  -- Fecha de reclamo aleatoria entre las fechas especificadas
FROM 
    Clientes
ORDER BY 
    NEWID();
-- Generar datos aleatorios para Resoluciones
INSERT INTO Resoluciones (id_reclamo, estado_reclamo, fecha_resolucion, solucion_ofrecida, comentarios_adicionales)
SELECT 
    TOP (@num_registros)
    r.id_reclamo,
    CASE ROUND(RAND() * 1, 0)
        WHEN 0 THEN 'Pendiente'
        ELSE 'Resuelto'
    END,
    DATEADD(DAY, ROUND(RAND() * 30, 0), r.fecha_reclamo),  -- Fecha de resolución dentro de los 30 días siguientes al reclamo
    CONCAT('Solución propuesta para ', 
        CASE ROUND(RAND() * 2, 0)
            WHEN 0 THEN 'mejorar el servicio'
            WHEN 1 THEN 'ajustar la facturación'
            ELSE 'reembolsar el monto'
        END),
    'Comentario adicional aleatorio'
FROM 
    Reclamos r
ORDER BY 
    NEWID();
-- Generar datos aleatorios para Hipotecas
INSERT INTO Hipotecas (id_cliente, monto_hipoteca, tasa_interes, duracion_meses, fecha_inicio)
SELECT 
    TOP (@num_registros)
    id_cliente,
    ROUND(RAND() * 500000 + 100000, 2),  -- Monto de hipoteca aleatorio entre 100000 y 600000
    ROUND(RAND() * 3.5 + 3, 2),          -- Tasa de interés aleatoria entre 3% y 6.5%
    ROUND(RAND() * 360 + 120, 0),        -- Duración en meses aleatoria entre 120 y 480 meses
    DATEADD(DAY, ROUND(RAND() * DATEDIFF(DAY, @fecha_inicio, @fecha_fin), 0), @fecha_inicio)  -- Fecha de inicio aleatoria entre las fechas especificadas
FROM 
    Clientes
ORDER BY 
    NEWID();



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
    -- Última fecha y categoría de reclamo
    (SELECT TOP 1 fecha_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) AS ultima_fecha_reclamo,
    (SELECT TOP 1 categoria_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) AS ultima_categoria_reclamo,
    -- Estado del último reclamo según la solución ofrecida
    CASE 
        WHEN (SELECT TOP 1 estado_reclamo FROM Resoluciones WHERE id_reclamo = (SELECT TOP 1 id_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) ORDER BY fecha_resolucion DESC) = 'Resuelto'
            THEN 'Resuelto'
        WHEN (SELECT TOP 1 estado_reclamo FROM Resoluciones WHERE id_reclamo = (SELECT TOP 1 id_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) ORDER BY fecha_resolucion DESC) = 'Pendiente'
            THEN 'Pendiente'
        ELSE 'No Resuelto'
    END AS estado_ultimo_reclamo,
    -- Fecha de resolución del último reclamo
    (SELECT TOP 1 fecha_resolucion FROM Resoluciones WHERE id_reclamo = (SELECT TOP 1 id_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) ORDER BY fecha_resolucion DESC) AS fecha_resolucion_ultimo_reclamo,
    -- Solución ofrecida del último reclamo
    (SELECT TOP 1 solucion_ofrecida FROM Resoluciones WHERE id_reclamo = (SELECT TOP 1 id_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) ORDER BY fecha_resolucion DESC) AS solucion_ofrecida_ultimo_reclamo,
    -- Cálculo del tiempo de resolución del último reclamo
    DATEDIFF(DAY, 
        (SELECT TOP 1 fecha_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC), 
        (SELECT TOP 1 fecha_resolucion FROM Resoluciones WHERE id_reclamo = (SELECT TOP 1 id_reclamo FROM Reclamos WHERE id_cliente = c.id_cliente ORDER BY fecha_reclamo DESC) ORDER BY fecha_resolucion DESC)
    ) AS tiempo_resolucion_ultimo_reclamo
FROM 
    Clientes c
LEFT JOIN 
    Prestamos p ON c.id_cliente = p.id_cliente
LEFT JOIN 
    Ahorros a ON c.id_cliente = a.id_cliente
LEFT JOIN 
    Retiros r ON c.id_cliente = r.id_cliente;
