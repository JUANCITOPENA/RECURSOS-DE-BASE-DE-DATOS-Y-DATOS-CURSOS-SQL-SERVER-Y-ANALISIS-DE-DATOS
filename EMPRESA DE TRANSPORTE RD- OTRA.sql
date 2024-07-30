-- Creación de la base de datos
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'TransporteCargaRD')
BEGIN
    CREATE DATABASE TransporteCargaRD;
END
GO

USE TransporteCargaRD;
GO

-- Creación de la tabla Regiones
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Regiones')
BEGIN
    CREATE TABLE Regiones (
        RegionID INT PRIMARY KEY IDENTITY(1,1),
        Nombre VARCHAR(50) NOT NULL
    );
END

-- Inserción de datos en Regiones
IF NOT EXISTS (SELECT * FROM Regiones)
BEGIN
    INSERT INTO Regiones (Nombre) VALUES
    ('Sur'), ('Este'), ('Norte'), ('Cibao');
END

-- Creación de la tabla Ciudades
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Ciudades')
BEGIN
    CREATE TABLE Ciudades (
        CiudadID INT PRIMARY KEY IDENTITY(1,1),
        Nombre VARCHAR(100) NOT NULL,
        RegionID INT NOT NULL,
        Latitud DECIMAL(9,6) NOT NULL,
        Longitud DECIMAL(9,6) NOT NULL,
        CONSTRAINT FK_Ciudades_Regiones FOREIGN KEY (RegionID) REFERENCES Regiones(RegionID)
    );
END

-- Inserción de datos en Ciudades
IF NOT EXISTS (SELECT * FROM Ciudades)
BEGIN
    INSERT INTO Ciudades (Nombre, RegionID, Latitud, Longitud) VALUES
    ('Santo Domingo', 3, 18.486057, -69.931211),
    ('Santiago de los Caballeros', 4, 19.4517, -70.6970),
    ('La Romana', 2, 18.4333, -68.9667),
    ('San Pedro de Macorís', 2, 18.4500, -69.3000),
    ('La Vega', 4, 19.2221, -70.5296),
    ('San Cristóbal', 1, 18.4167, -70.1061),
    ('Puerto Plata', 3, 19.7934, -70.6884),
    ('San Francisco de Macorís', 4, 19.3000, -70.2500),
    ('Higüey', 2, 18.6167, -68.7167),
    ('Moca', 4, 19.3900, -70.5256),
    ('Bonao', 4, 18.9333, -70.4167),
    ('Baní', 1, 18.2800, -70.3300),
    ('Barahona', 1, 18.2000, -71.1000),
    ('Monte Cristi', 3, 19.8461, -71.6458),
    ('Azua', 1, 18.4500, -70.7333),
    ('Nagua', 3, 19.3833, -69.8500),
    ('Samaná', 2, 19.2050, -69.3368),
    ('Neiba', 1, 18.4833, -71.4167),
    ('Dajabón', 3, 19.5500, -71.7000),
    ('Cotuí', 4, 19.0500, -70.1500),
    ('Salcedo', 4, 19.3833, -70.4167),
    ('Jimaní', 1, 18.4961, -71.8494),
    ('Pedernales', 1, 18.0333, -71.7500),
    ('El Seibo', 2, 18.7667, -69.1167),
    ('Hato Mayor', 2, 18.7658, -69.2561),
    ('Monte Plata', 4, 18.8094, -69.7833),
    ('Sabaneta', 3, 19.4500, -71.3500),
    ('Mao', 3, 19.5511, -71.0783),
    ('Bávaro', 2, 18.7172, -68.4481),
    ('Villa Altagracia', 1, 18.6700, -70.1700);
END

-- Creación de la tabla Clientes
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Clientes')
BEGIN
    CREATE TABLE Clientes (
        ClienteID INT PRIMARY KEY IDENTITY(1,1),
        Nombre VARCHAR(100) NOT NULL,
        RNC VARCHAR(11) UNIQUE NOT NULL,
        Telefono VARCHAR(15) NOT NULL,
        Direccion VARCHAR(200) NOT NULL,
        Latitud DECIMAL(9,6) NOT NULL,
        Longitud DECIMAL(9,6) NOT NULL
    );
END

-- Inserción de datos en Clientes
IF NOT EXISTS (SELECT * FROM Clientes)
BEGIN
    INSERT INTO Clientes (Nombre, RNC, Telefono, Direccion, Latitud, Longitud) VALUES
    ('Juan Pérez', '00112345678', '809-555-1234', 'Calle Principal #123', 18.486057, -69.931211),
    ('María Gómez', '00123456789', '829-444-5678', 'Avenida Duarte #456', 18.4500, -69.3000),
    ('Pedro Martínez', '00134567890', '809-777-8901', 'Calle Central #789', 18.4333, -68.9667),
    ('Ana Ramírez', '00145678901', '809-888-2345', 'Calle Principal #456', 19.4517, -70.6970),
    ('Carlos Santos', '00156789012', '809-222-5678', 'Avenida Bolívar #123', 19.2221, -70.5296),
    ('Laura Méndez', '00167890123', '809-333-8901', 'Calle Libertad #456', 18.4167, -70.1061),
    ('Andrés Suero', '00178901234', '809-444-2345', 'Calle Principal #789', 19.7934, -70.6884),
    ('Luisa Reyes', '00189012345', '829-555-6789', 'Avenida Bolívar #123', 19.3000, -70.2500),
    ('José Nova', '00290123456', '809-777-1234', 'Calle Libertad #456', 18.6167, -68.7167),
    ('Elena García', '00201234567', '809-888-4567', 'Avenida Duarte #789', 19.3900, -70.5256),
    ('Rafael Jiménez', '00212345678', '829-333-7890', 'Calle Principal #123', 18.9333, -70.4167),
    ('Sofía Pérez', '00223456789', '809-555-2345', 'Avenida Bolívar #456', 18.2800, -70.3300),
    ('Martín Brito', '00234567890', '829-444-5678', 'Calle Libertad #789', 18.2000, -71.1000),
    ('Margarita Soto', '00245678901', '809-777-8901', 'Calle Duarte #123', 19.8461, -71.6458),
    ('Fernando Acosta', '00256789012', '809-888-1234', 'Avenida Bolívar #456', 18.4500, -70.7333),
    ('Carolina Peña', '00267890123', '829-555-4567', 'Calle Principal #789', 19.3833, -69.8500),
    ('Gabriel López', '00278901234', '809-777-7890', 'Avenida Duarte #123', 19.2050, -69.3368),
    ('Alejandra Torres', '00289012345', '809-888-2345', 'Calle Libertad #456', 18.4833, -71.4167),
    ('David Vargas', '00390123456', '829-333-5678', 'Avenida Bolívar #789', 19.5500, -71.7000),
    ('Carmen Cruz', '00301234567', '809-555-6789', 'Calle Principal #123', 19.0500, -70.1500),
    ('Roberto Mora', '00312345678', '809-777-2345', 'Avenida Libertad #456', 19.3833, -70.4167),
    ('Natalia Reyes', '00323456789', '829-444-5678', 'Calle Duarte #789', 18.4961, -71.8494),
    ('Francisco Medina', '00334567890', '809-888-1234', 'Avenida Bolívar #123', 18.0333, -71.7500),
    ('Isabel Santos', '00345678901', '829-333-4567', 'Calle Principal #456', 18.7667, -69.1167),
    ('Pedro Brito', '00356789012', '809-555-7890', 'Avenida Duarte #123', 18.7658, -69.2561),
    ('Luis Ramírez', '00367890123', '809-777-5678', 'Calle Libertad #456', 18.8094, -69.7833),
    ('Ana María Nova', '00378901234', '829-444-8901', 'Calle Principal #789', 19.4500, -71.3500),
    ('Jorge Suero', '00389012345', '809-888-2345', 'Avenida Bolívar #123', 19.5511, -71.0783),
    ('Raquel García', '00490123456', '829-333-6789', 'Calle Duarte #456', 18.7172, -68.4481),
    ('Juanita Pérez', '00401234567', '809-555-1234', 'Calle Libertad #789', 18.6700, -70.1700);
END

-- Creación de la tabla Conductores
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Conductores')
BEGIN
    CREATE TABLE Conductores (
        ConductorID INT PRIMARY KEY IDENTITY(1,1),
        Nombre VARCHAR(100) NOT NULL,
        Cedula VARCHAR(11) UNIQUE NOT NULL,
        Telefono VARCHAR(15) NOT NULL,
        Direccion VARCHAR(200) NOT NULL
    );
END

-- Inserción de datos en Conductores
IF NOT EXISTS (SELECT * FROM Conductores)
BEGIN
    INSERT INTO Conductores (Nombre, Cedula, Telefono, Direccion) VALUES
    ('Carlos Méndez', '00123456789', '809-222-5678', 'Calle Libertad #123'),
    ('Luisa Sánchez', '01234567890', '829-333-8901', 'Avenida Bolívar #456'),
    ('José Rodríguez', '02345678901', '809-444-2345', 'Calle Principal #789'),
    ('María Fernández', '03456789012', '809-555-6789', 'Avenida Duarte #123'),
    ('Pedro Pérez', '04567890123', '829-666-1234', 'Calle Libertad #456'),
    ('Ana Martínez', '05678901234', '809-777-4567', 'Avenida Bolívar #789'),
    ('Juan Gómez', '06789012345', '829-888-7890', 'Calle Principal #123'),
    ('Laura Ramírez', '07890123456', '809-999-1234', 'Avenida Duarte #456'),
    ('Carlos García', '08901234567', '829-111-4567', 'Calle Libertad #789'),
    ('María Pérez', '09012345678', '809-222-7890', 'Avenida Bolívar #123'),
    ('José Sánchez', '10123456789', '829-333-2345', 'Calle Principal #456'),
    ('Luis Martínez', '11234567890', '809-444-5678', 'Avenida Duarte #789'),
    ('Ana Rodríguez', '12345678901', '829-555-8901', 'Calle Libertad #123'),
    ('Pedro Gómez', '23456789012', '809-666-2345', 'Avenida Bolívar #456'),
    ('Laura Fernández', '34567890123', '829-777-5678', 'Calle Principal #789'),
    ('Juan Pérez', '45678901234', '809-888-1234', 'Avenida Duarte #123'),
    ('Carlos Martínez', '56789012345', '829-999-4567', 'Calle Libertad #456'),
    ('María Gómez', '67890123456', '809-111-7890', 'Avenida Bolívar #789'),
    ('José Ramírez', '78901234567', '829-222-2345', 'Calle Principal #123'),
    ('Luis García', '89012345678', '809-333-5678', 'Avenida Duarte #456'),
    ('Ana Pérez', '90123456789', '829-444-8901', 'Calle Libertad #789'),
    ('Pedro Sánchez', '01234567891', '809-555-1234', 'Avenida Bolívar #123'),
    ('Laura Martínez', '12345678902', '829-666-4567', 'Calle Principal #456'),
    ('Carlos Rodríguez', '23456789013', '809-777-7890', 'Avenida Duarte #789'),
    ('María Gómez', '34567890124', '829-888-1234', 'Calle Libertad #123'),
    ('José Martínez', '45678901235', '809-999-4567', 'Avenida Bolívar #456'),
    ('Luis Rodríguez', '56789012346', '829-111-7890', 'Calle Principal #789'),
    ('Ana Pérez', '67890123457', '809-222-2345', 'Avenida Duarte #123'),
    ('Pedro Gómez', '78901234568', '829-333-5678', 'Calle Libertad #456'),
    ('Laura Fernández', '89012345679', '809-444-8901', 'Avenida Bolívar #789');
END

-- Creación de la tabla Vehiculos
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Vehiculos')
BEGIN
    CREATE TABLE Vehiculos (
        VehiculoID INT PRIMARY KEY IDENTITY(1,1),
        Matricula VARCHAR(20) UNIQUE NOT NULL,
        Marca VARCHAR(50) NOT NULL,
        Modelo VARCHAR(50) NOT NULL,
        Ano INT NOT NULL,
        CapacidadCarga DECIMAL(10,2) NOT NULL);
END

-- Inserción de datos en Vehiculos
IF NOT EXISTS (SELECT * FROM Vehiculos)
BEGIN
    INSERT INTO Vehiculos (Matricula, Marca, Modelo, Ano, CapacidadCarga) VALUES
    ('123ABC', 'Toyota', 'Hilux', 2020, 2500.00),
    ('456DEF', 'Nissan', 'Frontier', 2019, 2000.00),
    ('789GHI', 'Ford', 'Ranger', 2018, 2200.00),
    ('012JKL', 'Chevrolet', 'Colorado', 2021, 2400.00),
    ('345MNO', 'Isuzu', 'D-Max', 2017, 2100.00),
    ('678PQR', 'Mitsubishi', 'L200', 2019, 2300.00),
    ('901STU', 'Mercedes-Benz', 'X-Class', 2018, 2600.00),
    ('234VWX', 'Volkswagen', 'Amarok', 2020, 2500.00),
    ('567YZA', 'Renault', 'Alaskan', 2019, 2200.00),
    ('890BCD', 'GMC', 'Canyon', 2018, 2400.00),
    ('123EFG', 'Chevrolet', 'Silverado', 2021, 2600.00),
    ('456HIJ', 'Toyota', 'Tacoma', 2019, 2100.00),
    ('789KLM', 'Ford', 'F-150', 2018, 2300.00),
    ('012NOP', 'Nissan', 'Titan', 2020, 2400.00),
    ('345QRS', 'Isuzu', 'MUX', 2017, 2500.00),
    ('678TUV', 'Mitsubishi', 'Outlander', 2019, 2200.00),
    ('901WXY', 'Mercedes-Benz', 'GLB', 2018, 2400.00),
    ('234ZAB', 'Volkswagen', 'Tiguan', 2020, 2600.00),
    ('567CDE', 'Renault', 'Koleos', 2019, 2100.00),
    ('890FGH', 'GMC', 'Terrain', 2018, 2300.00),
    ('123IJK', 'Chevrolet', 'Traverse', 2021, 2500.00),
    ('456LMN', 'Toyota', 'Highlander', 2019, 2200.00),
    ('789OPQ', 'Ford', 'Explorer', 2018, 2400.00),
    ('012RST', 'Nissan', 'Pathfinder', 2020, 2600.00),
    ('345UVW', 'Isuzu', 'Trooper', 2017, 2100.00),
    ('678XYZ', 'Mitsubishi', 'Pajero', 2019, 2300.00),
    ('901ABC', 'Mercedes-Benz', 'GLC', 2018, 2500.00),
    ('234DEF', 'Volkswagen', 'Atlas', 2020, 2200.00),
    ('567GHI', 'Renault', 'Captur', 2019, 2400.00),
    ('890JKL', 'GMC', 'Acadia', 2018, 2600.00);
END

-- Creación de la tabla Viajes
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Viajes')
BEGIN
    CREATE TABLE Viajes (
        ViajeID INT PRIMARY KEY IDENTITY(1,1),
        ClienteID INT NOT NULL,
        ConductorID INT NOT NULL,
        VehiculoID INT NOT NULL,
        FechaSalida DATETIME NOT NULL,
        FechaLlegada DATETIME NOT NULL,
        Destino VARCHAR(200) NOT NULL,
        CiudadID INT NOT NULL,
        CONSTRAINT FK_Viajes_Clientes FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
        CONSTRAINT FK_Viajes_Conductores FOREIGN KEY (ConductorID) REFERENCES Conductores(ConductorID),
        CONSTRAINT FK_Viajes_Vehiculos FOREIGN KEY (VehiculoID) REFERENCES Vehiculos(VehiculoID),
        CONSTRAINT FK_Viajes_Ciudades FOREIGN KEY (CiudadID) REFERENCES Ciudades(CiudadID)
    );
END

-- Inserción de datos en Viajes
IF NOT EXISTS (SELECT * FROM Viajes)
BEGIN
    INSERT INTO Viajes (ClienteID, ConductorID, VehiculoID, FechaSalida, FechaLlegada, Destino, CiudadID) VALUES
    (1, 1, 1, '2023-01-01 08:00:00', '2023-01-01 14:00:00', 'Santiago', 2),
    (2, 2, 2, '2023-01-02 10:00:00', '2023-01-02 16:00:00', 'La Vega', 5),
    (3, 3, 3, '2023-01-03 12:00:00', '2023-01-03 18:00:00', 'Puerto Plata', 7),
    (4, 4, 4, '2023-01-04 14:00:00', '2023-01-04 20:00:00', 'San Pedro de Macorís', 4),
    (5, 5, 5, '2023-01-05 16:00:00', '2023-01-05 22:00:00', 'Higüey', 9),
    (6, 6, 6, '2023-01-06 18:00:00', '2023-01-07 00:00:00', 'La Romana', 3),
    (7, 7, 7, '2023-01-07 20:00:00', '2023-01-08 02:00:00', 'Bonao', 11),
    (8, 8, 8, '2023-01-08 22:00:00', '2023-01-09 04:00:00', 'Moca', 10),
    (9, 9, 9, '2023-01-09 00:00:00', '2023-01-09 06:00:00', 'San Francisco de Macorís', 8),
    (10, 10, 10, '2023-01-10 02:00:00', '2023-01-10 08:00:00', 'Santo Domingo Este', 1),
    (11, 11, 11, '2023-01-11 04:00:00', '2023-01-11 10:00:00', 'San Cristóbal', 6),
    (12, 12, 12, '2023-01-12 06:00:00', '2023-01-12 12:00:00', 'Santo Domingo Oeste', 1),
    (13, 13, 13, '2023-01-13 08:00:00', '2023-01-13 14:00:00', 'Boca Chica', 1),
    (14, 14, 14, '2023-01-14 10:00:00', '2023-01-14 16:00:00', 'Concepción de La Vega', 5),
    (15, 15, 15, '2023-01-15 12:00:00', '2023-01-15 18:00:00', 'Dajabón', 19),
    (16, 16, 16, '2023-01-16 14:00:00', '2023-01-16 20:00:00', 'El Seibo', 24),
    (17, 17, 17, '2023-01-17 16:00:00', '2023-01-17 22:00:00', 'Elías Piña', 22),
    (18, 18, 18, '2023-01-18 18:00:00', '2023-01-19 00:00:00', 'Espaillat', 10),
    (19, 19, 19, '2023-01-19 20:00:00', '2023-01-20 02:00:00', 'Hato Mayor', 25),
    (20, 20, 20, '2023-01-20 22:00:00', '2023-01-21 04:00:00', 'Independencia', 22),
    (21, 21, 21, '2023-01-21 00:00:00', '2023-01-21 06:00:00', 'La Altagracia', 9),
    (22, 22, 22, '2023-01-22 02:00:00', '2023-01-22 08:00:00', 'La Estrelleta', 22),
    (23, 23, 23, '2023-01-23 04:00:00', '2023-01-23 10:00:00', 'La Vega', 5),
    (24, 24, 24, '2023-01-24 06:00:00', '2023-01-24 12:00:00', 'La Romana', 3),
    (25, 25, 25, '2023-01-25 08:00:00', '2023-01-25 14:00:00', 'La Vega', 5),
    (26, 26, 26, '2023-01-26 10:00:00', '2023-01-26 16:00:00', 'María Trinidad Sánchez', 16),
    (27, 27, 27, '2023-01-27 12:00:00', '2023-01-27 18:00:00', 'Monseñor Nouel', 11),
    (28, 28, 28, '2023-01-28 14:00:00', '2023-01-28 20:00:00', 'Monte Cristi', 14),
    (29, 29, 29, '2023-01-29 16:00:00', '2023-01-29 22:00:00', 'Pedernales', 23),
    (30, 30, 30, '2023-01-30 18:00:00', '2023-01-31 00:00:00', 'Peravia', 12);
END

-- Creación de la tabla DetallesViaje
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DetallesViaje')
BEGIN
    CREATE TABLE DetallesViaje (
        DetalleID INT PRIMARY KEY IDENTITY(1,1),
        ViajeID INT NOT NULL,
        ClienteID INT NOT NULL,
        Mercancia VARCHAR(100) NOT NULL,
        Monto DECIMAL(10,2) NOT NULL,
        Cuota DECIMAL(10,2) NOT NULL,
        Tarifa DECIMAL(10,2) NOT NULL,
        EstatusEntrega VARCHAR(50) NOT NULL,
        CONSTRAINT FK_DetallesViaje_Viajes FOREIGN KEY (ViajeID) REFERENCES Viajes(ViajeID),
        CONSTRAINT FK_DetallesViaje_Clientes FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
    );
END

-- Inserción de datos en DetallesViaje
IF NOT EXISTS (SELECT * FROM DetallesViaje)
BEGIN
    INSERT INTO DetallesViaje (ViajeID, ClienteID, Mercancia, Monto, Cuota, Tarifa, EstatusEntrega) VALUES
    (1, 1, 'Electrodomésticos', 5000.00, 200.00, 5200.00, 'Asignado'),
    (2, 2, 'Alimentos', 3000.00, 150.00, 3150.00, 'En Proceso'),
    (3, 3, 'Ropa', 2500.00, 100.00, 2600.00, 'Entregado'),
    (4, 4, 'Herramientas', 4000.00, 180.00, 4180.00, 'Cancelado'),
    (5, 5, 'Productos Farmacéuticos', 3500.00, 160.00, 3660.00, 'Con Devolución Parcial'),
    (6, 6, 'Electrónicos', 6000.00, 250.00, 6250.00, 'Asignado'),
    (7, 7, 'Muebles', 4500.00, 200.00, 4700.00, 'En Proceso'),
    (8, 8, 'Juguetes', 2800.00, 120.00, 2920.00, 'Entregado'),
    (9, 9, 'Material de Construcción', 5200.00, 220.00, 5420.00, 'Cancelado'),
    (10, 10, 'Artículos de Belleza', 3200.00, 140.00, 3360.00, 'Con Devolución Parcial'),
    (11, 11, 'Productos de Oficina', 4200.00, 180.00, 4380.00, 'Asignado'),
    (12, 12, 'Accesorios para Autos', 3800.00, 160.00, 3960.00, 'En Proceso'),
    (13, 13, 'Artículos para el Hogar', 4700.00, 200.00, 4900.00, 'Entregado'),
    (14, 14, 'Instrumentos Musicales', 2900.00, 130.00, 3030.00, 'Cancelado'),
    (15, 15, 'Material Educativo', 3400.00, 150.00, 3550.00, 'Con Devolución Parcial'),
    (16, 16, 'Equipos Deportivos', 3800.00, 180.00, 3980.00, 'Asignado'),
    (17, 17, 'Ropa Deportiva', 3200.00, 150.00, 3350.00, 'En Proceso'),
    (18, 18, 'Electrodomésticos', 4900.00, 220.00, 5120.00, 'Entregado'),
    (19, 19, 'Alimentos', 3100.00, 140.00, 3240.00, 'Cancelado'),
    (20, 20, 'Herramientas', 4300.00, 200.00, 4500.00, 'Con Devolución Parcial'),
    (21, 21, 'Productos Farmacéuticos', 3700.00, 180.00, 3880.00, 'Asignado'),
    (22, 22, 'Electrónicos', 6500.00, 280.00, 6780.00, 'En Proceso'),
    (23, 23, 'Muebles', 4800.00, 230.00, 5030.00, 'Entregado'),
    (24, 24, 'Juguetes', 3000.00