-- CREAMOS LA BASE DE DATOS:
CREATE DATABASE RECLUTAMIENTO_RRHH;
GO

-- USAR LA BASE DE DATOS:
USE RECLUTAMIENTO_RRHH;
GO

-- Crear la tabla Terminal
CREATE TABLE Terminal (
    IDTerminal INT PRIMARY KEY,
    NombreTerminal NVARCHAR(100)
);

-- Insertar los registros en la tabla Terminal
INSERT INTO Terminal (IDTerminal, NombreTerminal)
VALUES
    (1, 'La Vega'),
    (2, 'Santiago'),
    (3, 'Santo Domingo'),
    (4, 'Azua'),
    (5, 'Romana');

-- Crear la tabla Reclutamiento con la relaci�n a Terminal
CREATE TABLE Reclutamiento (
    IDCandidato VARCHAR(10) PRIMARY KEY,
    Nombre NVARCHAR(100),
    Fecha_Publicacion_Vacante DATE,
    Puesto NVARCHAR(100),
    LlamadaInicial DATE,
    EvaluacionCV NVARCHAR(50),
    PruebasTecnicas NVARCHAR(50),
    PrimeraEntrevista DATE,
    SegundaEvaluacion NVARCHAR(50),
    EntrevistaRRHH DATE,
    EntrevistaFinal DATE,
    Seleccion NVARCHAR(3),
    Oferta NVARCHAR(50),
    Estado NVARCHAR(50),
    IDTerminal INT,
    FOREIGN KEY (IDTerminal) REFERENCES Terminal(IDTerminal)
);

ALTER TABLE Reclutamiento
ALTER COLUMN IDTerminal INT;

ALTER TABLE Reclutamiento
DROP CONSTRAINT FK_Reclutamiento_Terminal; -- Elimina la restricci�n existente si ya est� creada

ALTER TABLE Reclutamiento
ADD CONSTRAINT FK_Reclutamiento_Terminal FOREIGN KEY (IDTerminal)
REFERENCES Terminal(IDTerminal);


-- INSERTAR REGISTROS EN LA TABLA Reclutamiento:
INSERT INTO Reclutamiento (IDCandidato, Nombre, Fecha_Publicacion_Vacante, Puesto, LlamadaInicial, EvaluacionCV, PruebasTecnicas, PrimeraEntrevista, SegundaEvaluacion, EntrevistaRRHH, EntrevistaFinal, Seleccion, Oferta, Estado)
VALUES 
('CAND001', 'Mar�a L�pez', '2024-06-15', 'Desarrollador Frontend', '2024-07-01', 'Aprobado', '85/100', '2024-07-05', 'Aprobado', '2024-07-10', '2024-07-15', 'S�', 'Aceptada', 'Contratado'),
('CAND002', 'Juan P�rez', '2024-06-16', 'Analista de Datos', '2024-07-02', 'Aprobado', '78/100', '2024-07-06', 'Aprobado', '2024-07-11', '2024-07-16', 'No', 'N/A', 'Rechazado'),
('CAND003', 'Ana Mart�nez', '2024-06-17', 'Gerente de Proyecto', '2024-07-03', 'Aprobado', '92/100', '2024-07-07', 'Aprobado', '2024-07-12', '2024-07-17', 'S�', 'Enviada', 'En proceso'),
('CAND004', 'Carlos D�az', '2024-06-18', 'Desarrollador Backend', '2024-07-04', 'Aprobado', '80/100', '2024-07-08', 'Aprobado', '2024-07-13', '2024-07-18', 'S�', 'Aceptada', 'Contratado'),
('CAND005', 'Luisa Fern�ndez', '2024-06-19', 'Analista Financiero', '2024-07-05', 'Pendiente', 'N/A', '2024-07-09', 'Pendiente', '2024-07-14', '2024-07-19', 'No', 'N/A', 'Rechazado'),
('CAND006', 'Miguel Hern�ndez', '2024-06-20', 'Dise�ador Gr�fico', '2024-07-06', 'Aprobado', '90/100', '2024-07-10', 'Aprobado', '2024-07-15', '2024-07-20', 'S�', 'Enviada', 'En proceso'),
('CAND007', 'Sara G�mez', '2024-06-21', 'Consultor IT', '2024-07-07', 'Aprobado', '88/100', '2024-07-11', 'Aprobado', '2024-07-16', '2024-07-21', 'S�', 'Aceptada', 'Contratado'),
('CAND008', 'David Ram�rez', '2024-06-22', 'Ingeniero de Software', '2024-07-08', 'Aprobado', '95/100', '2024-07-12', 'Aprobado', '2024-07-17', '2024-07-22', 'S�', 'Aceptada', 'Contratado'),
('CAND009', 'Elena Torres', '2024-06-23', 'Tester QA', '2024-07-09', 'Pendiente', 'N/A', '2024-07-13', 'Pendiente', '2024-07-18', '2024-07-23', 'No', 'N/A', 'Rechazado'),
('CAND010', 'Pablo Morales', '2024-06-24', 'Administrador de Sistemas', '2024-07-10', 'Aprobado', '85/100', '2024-07-14', 'Aprobado', '2024-07-19', '2024-07-24', 'S�', 'Enviada', 'En proceso'),
('CAND011', 'Clara Ruiz', '2024-06-25', 'Consultor SAP', '2024-07-11', 'Aprobado', '88/100', '2024-07-15', 'Aprobado', '2024-07-20', '2024-07-25', 'S�', 'Aceptada', 'Contratado'),
('CAND012', 'Jos� Vargas', '2024-06-26', 'Administrador de Base de Datos', '2024-07-12', 'Pendiente', 'N/A', '2024-07-16', 'Pendiente', '2024-07-21', '2024-07-26', 'No', 'N/A', 'Rechazado'),
('CAND013', 'Marta R�os', '2024-06-27', 'Especialista en Redes', '2024-07-13', 'Aprobado', '90/100', '2024-07-17', 'Aprobado', '2024-07-22', '2024-07-27', 'S�', 'Enviada', 'En proceso'),
('CAND014', 'Santiago Castillo', '2024-06-28', 'Arquitecto de Software', '2024-07-14', 'Aprobado', '95/100', '2024-07-18', 'Aprobado', '2024-07-23', '2024-07-28', 'S�', 'Aceptada', 'Contratado'),
('CAND015', 'Laura Moreno', '2024-06-29', 'Gerente de Recursos Humanos', '2024-07-15', 'Aprobado', '85/100', '2024-07-19', 'Aprobado', '2024-07-24', '2024-07-29', 'S�', 'Enviada', 'En proceso'),
('CAND016', 'Adri�n Gil', '2024-06-30', 'Desarrollador Full Stack', '2024-07-16', 'Aprobado', '92/100', '2024-07-20', 'Aprobado', '2024-07-25', '2024-07-30', 'S�', 'Aceptada', 'Contratado'),
('CAND017', 'Julia Fuentes', '2024-07-01', 'Desarrollador Frontend', '2024-07-17', 'Pendiente', 'N/A', '2024-07-21', 'Pendiente', '2024-07-26', '2024-07-31', 'No', 'N/A', 'Rechazado'),
('CAND018', 'Iv�n Ortega', '2024-07-02', 'Analista de Datos', '2024-07-18', 'Aprobado', '88/100', '2024-07-22', 'Aprobado', '2024-07-27', '2024-08-01', 'S�', 'Enviada', 'En proceso'),
('CAND019', 'Nuria Silva', '2024-07-03', 'Desarrollador Backend', '2024-07-19', 'Aprobado', '90/100', '2024-07-23', 'Aprobado', '2024-07-28', '2024-08-02', 'S�', 'Aceptada', 'Contratado'),
('CAND020', 'Pedro Romero', '2024-07-04', 'Gerente de Proyecto', '2024-07-20', 'Aprobado', '95/100', '2024-07-24', 'Aprobado', '2024-07-29', '2024-08-03', 'S�', 'Aceptada', 'Contratado');


-- INSERTAR REGISTROS EN LA TABLA Reclutamiento:
INSERT INTO Reclutamiento (IDCandidato, Nombre, Fecha_Publicacion_Vacante, Puesto, LlamadaInicial, EvaluacionCV, PruebasTecnicas, PrimeraEntrevista, SegundaEvaluacion, EntrevistaRRHH, EntrevistaFinal, Seleccion, Oferta, Estado, IDTerminal)
VALUES 
('CAND001', 'Mar�a L�pez', '2024-06-15', 'Desarrollador Frontend', '2024-07-01', 'Aprobado', '85/100', '2024-07-05', 'Aprobado', '2024-07-10', '2024-07-15', 'S�', 'Aceptada', 'Contratado', 1),
('CAND002', 'Juan P�rez', '2024-06-16', 'Analista de Datos', '2024-07-02', 'Aprobado', '78/100', '2024-07-06', 'Aprobado', '2024-07-11', '2024-07-16', 'No', 'N/A', 'Rechazado', 2),
('CAND003', 'Ana Mart�nez', '2024-06-17', 'Gerente de Proyecto', '2024-07-03', 'Aprobado', '92/100', '2024-07-07', 'Aprobado', '2024-07-12', '2024-07-17', 'S�', 'Enviada', 'En proceso', 3),
('CAND004', 'Carlos D�az', '2024-06-18', 'Desarrollador Backend', '2024-07-04', 'Aprobado', '80/100', '2024-07-08', 'Aprobado', '2024-07-13', '2024-07-18', 'S�', 'Aceptada', 'Contratado', 4),
('CAND005', 'Luisa Fern�ndez', '2024-06-19', 'Analista Financiero', '2024-07-05', 'Pendiente', 'N/A', '2024-07-09', 'Pendiente', '2024-07-14', '2024-07-19', 'No', 'N/A', 'Rechazado', 5),
('CAND006', 'Miguel Hern�ndez', '2024-06-20', 'Dise�ador Gr�fico', '2024-07-06', 'Aprobado', '90/100', '2024-07-10', 'Aprobado', '2024-07-15', '2024-07-20', 'S�', 'Enviada', 'En proceso', 1),
('CAND007', 'Sara G�mez', '2024-06-21', 'Consultor IT', '2024-07-07', 'Aprobado', '88/100', '2024-07-11', 'Aprobado', '2024-07-16', '2024-07-21', 'S�', 'Aceptada', 'Contratado', 2),
('CAND008', 'David Ram�rez', '2024-06-22', 'Ingeniero de Software', '2024-07-08', 'Aprobado', '95/100', '2024-07-12', 'Aprobado', '2024-07-17', '2024-07-22', 'S�', 'Aceptada', 'Contratado', 3),
('CAND009', 'Elena Torres', '2024-06-23', 'Tester QA', '2024-07-09', 'Pendiente', 'N/A', '2024-07-13', 'Pendiente', '2024-07-18', '2024-07-23', 'No', 'N/A', 'Rechazado', 4),
('CAND010', 'Pablo Morales', '2024-06-24', 'Administrador de Sistemas', '2024-07-10', 'Aprobado', '85/100', '2024-07-14', 'Aprobado', '2024-07-19', '2024-07-24', 'S�', 'Enviada', 'En proceso', 5),
('CAND011', 'Clara Ruiz', '2024-06-25', 'Consultor SAP', '2024-07-11', 'Aprobado', '88/100', '2024-07-15', 'Aprobado', '2024-07-20', '2024-07-25', 'S�', 'Aceptada', 'Contratado', 1),
('CAND012', 'Jos� Vargas', '2024-06-26', 'Administrador de Base de Datos', '2024-07-12', 'Pendiente', 'N/A', '2024-07-16', 'Pendiente', '2024-07-21', '2024-07-26', 'No', 'N/A', 'Rechazado', 2),
('CAND013', 'Marta R�os', '2024-06-27', 'Especialista en Redes', '2024-07-13', 'Aprobado', '90/100', '2024-07-17', 'Aprobado', '2024-07-22', '2024-07-27', 'S�', 'Enviada', 'En proceso', 3),
('CAND014', 'Santiago Castillo', '2024-06-28', 'Arquitecto de Software', '2024-07-14', 'Aprobado', '95/100', '2024-07-18', 'Aprobado', '2024-07-23', '2024-07-28', 'S�', 'Aceptada', 'Contratado', 4),
('CAND015', 'Laura Moreno', '2024-06-29', 'Gerente de Recursos Humanos', '2024-07-15', 'Aprobado', '85/100', '2024-07-19', 'Aprobado', '2024-07-24', '2024-07-29', 'S�', 'Enviada', 'En proceso', 5),
('CAND016', 'Adri�n Gil', '2024-06-30', 'Desarrollador Full Stack', '2024-07-16', 'Aprobado', '92/100', '2024-07-20', 'Aprobado', '2024-07-25', '2024-07-30', 'S�', 'Aceptada', 'Contratado', 1),
('CAND017', 'Julia Fuentes', '2024-07-01', 'Desarrollador Frontend', '2024-07-17', 'Pendiente', 'N/A', '2024-07-21', 'Pendiente', '2024-07-26', '2024-07-31', 'No', 'N/A', 'Rechazado', 2),
('CAND018', 'Iv�n Ortega', '2024-07-02', 'Analista de Datos', '2024-07-18', 'Aprobado', '88/100', '2024-07-22', 'Aprobado', '2024-07-27', '2024-08-01', 'S�', 'Enviada', 'En proceso', 3),
('CAND019', 'Nuria Silva', '2024-07-03', 'Desarrollador Backend', '2024-07-19', 'Aprobado', '90/100', '2024-07-23', 'Aprobado', '2024-07-28', '2024-08-02', 'S�', 'Aceptada', 'Contratado', 4),
('CAND020', 'Pedro Romero', '2024-07-04', 'Gerente de Proyecto', '2024-07-20', 'Aprobado', '95/100', '2024-07-24', 'Aprobado', '2024-07-29', '2024-08-03', 'S�', 'Aceptada', 'Contratado', 5);




-- CONSULTAR REGISTROS DE LA TABLA Reclutamiento:
SELECT * FROM Reclutamiento;

-- INSERTAR REGISTROS EN LA TABLA Reclutamiento:
INSERT INTO Reclutamiento (IDCandidato, Nombre, Fecha_Publicacion_Vacante, Puesto, LlamadaInicial, EvaluacionCV, PruebasTecnicas, PrimeraEntrevista, SegundaEvaluacion, EntrevistaRRHH, EntrevistaFinal, Seleccion, Oferta, Estado)
VALUES 
('CAND021', 'Ra�l Garc�a', '2024-07-01', 'Desarrollador Mobile', '2024-07-10', 'Aprobado', '88/100', '2024-07-15', 'Aprobado', '2024-07-20', '2024-07-25', 'S�', 'Aceptada', 'Contratado'),
('CAND022', 'Luc�a M�ndez', '2024-07-02', 'Analista de Marketing', '2024-07-11', 'Aprobado', '85/100', '2024-07-16', 'Aprobado', '2024-07-21', '2024-07-26', 'No', 'N/A', 'Rechazado'),
('CAND023', 'Sof�a Pe�a', '2024-07-03', 'Especialista en Seguridad', '2024-07-12', 'Pendiente', 'N/A', '2024-07-17', 'Pendiente', '2024-07-22', '2024-07-27', 'No', 'N/A', 'Rechazado'),
('CAND024', 'Rodrigo Cruz', '2024-07-04', 'Ingeniero de DevOps', '2024-07-13', 'Aprobado', '92/100', '2024-07-18', 'Aprobado', '2024-07-23', '2024-07-28', 'S�', 'Enviada', 'En proceso'),
('CAND025', 'Beatriz Ortega', '2024-07-05', 'Gerente de Producto', '2024-07-14', 'Aprobado', '90/100', '2024-07-19', 'Aprobado', '2024-07-24', '2024-07-29', 'S�', 'Aceptada', 'Contratado'),
('CAND026', 'Tom�s V�zquez', '2024-07-06', 'Especialista en Big Data', '2024-07-15', 'Aprobado', '95/100', '2024-07-20', 'Aprobado', '2024-07-25', '2024-07-30', 'S�', 'Enviada', 'En proceso'),
('CAND027', 'Isabel Navarro', '2024-07-07', 'Analista de Negocios', '2024-07-16', 'Pendiente', 'N/A', '2024-07-21', 'Pendiente', '2024-07-26', '2024-07-31', 'No', 'N/A', 'Rechazado'),
('CAND028', 'Mart�n Fern�ndez', '2024-07-08', 'Consultor en Transformaci�n Digital', '2024-07-17', 'Aprobado', '88/100', '2024-07-22', 'Aprobado', '2024-07-27', '2024-08-01', 'S�', 'Aceptada', 'Contratado'),
('CAND029', 'Patricia Herrera', '2024-07-09', 'Especialista en IA', '2024-07-18', 'Aprobado', '90/100', '2024-07-23', 'Aprobado', '2024-07-28', '2024-08-02', 'S�', 'Enviada', 'En proceso'),
('CAND030', 'Jorge Castillo', '2024-07-10', 'Consultor de CRM', '2024-07-19', 'Aprobado', '85/100', '2024-07-24', 'Aprobado', '2024-07-29', '2024-08-03', 'S�', 'Aceptada', 'Contratado'),
('CAND031', 'Natalia Ruiz', '2024-07-11', 'Desarrollador de Juegos', '2024-07-20', 'Pendiente', 'N/A', '2024-07-25', 'Pendiente', '2024-07-30', '2024-08-04', 'No', 'N/A', 'Rechazado'),
('CAND032', 'Hugo D�az', '2024-07-12', 'Analista de Seguridad', '2024-07-21', 'Aprobado', '88/100', '2024-07-26', 'Aprobado', '2024-07-31', '2024-08-05', 'S�', 'Aceptada', 'Contratado'),
('CAND033', 'Paula Vargas', '2024-07-13', 'Especialista en UX/UI', '2024-07-22', 'Aprobado', '90/100', '2024-07-27', 'Aprobado', '2024-08-01', '2024-08-06', 'S�', 'Enviada', 'En proceso'),
('CAND034', 'Luis Garc�a', '2024-07-14', 'Ingeniero de Machine Learning', '2024-07-23', 'Aprobado', '95/100', '2024-07-28', 'Aprobado', '2024-08-02', '2024-08-07', 'S�', 'Aceptada', 'Contratado'),
('CAND035', 'Andrea Mart�nez', '2024-07-15', 'Consultor de BI', '2024-07-24', 'Pendiente', 'N/A', '2024-07-29', 'Pendiente', '2024-08-03', '2024-08-08', 'No', 'N/A', 'Rechazado'),
('CAND036', 'Fernando Ramos', '2024-07-16', 'Ingeniero de Datos', '2024-07-25', 'Aprobado', '92/100', '2024-07-30', 'Aprobado', '2024-08-04', '2024-08-09', 'S�', 'Enviada', 'En proceso'),
('CAND037', 'Alicia Medina', '2024-07-17', 'Especialista en Cloud', '2024-07-26', 'Aprobado', '88/100', '2024-07-31', 'Aprobado', '2024-08-05', '2024-08-10', 'S�', 'Aceptada', 'Contratado'),
('CAND038', 'Javier Mu�oz', '2024-07-18', 'Gerente de TI', '2024-07-27', 'Pendiente', 'N/A', '2024-08-01', 'Pendiente', '2024-08-06', '2024-08-11', 'No', 'N/A', 'Rechazado'),
('CAND039', 'Teresa L�pez', '2024-07-19', 'Analista de Negocios', '2024-07-28', 'Aprobado', '85/100', '2024-08-02', 'Aprobado', '2024-08-07', '2024-08-12', 'S�', 'Aceptada', 'Contratado'),
('CAND040', 'Alejandro Torres', '2024-07-20', 'Ingeniero de Redes', '2024-07-29', 'Aprobado', '90/100', '2024-08-03', 'Aprobado', '2024-08-08', '2024-08-13', 'S�', 'Enviada', 'En proceso');



-- INSERTAR REGISTROS EN LA TABLA Reclutamiento:
INSERT INTO Reclutamiento (IDCandidato, Nombre, Fecha_Publicacion_Vacante, Puesto, LlamadaInicial, EvaluacionCV, PruebasTecnicas, PrimeraEntrevista, SegundaEvaluacion, EntrevistaRRHH, EntrevistaFinal, Seleccion, Oferta, Estado, IDTerminal)
VALUES 
('CAND021', 'Ra�l Garc�a', '2024-07-01', 'Desarrollador Mobile', '2024-07-10', 'Aprobado', '88/100', '2024-07-15', 'Aprobado', '2024-07-20', '2024-07-25', 'S�', 'Aceptada', 'Contratado', 1),
('CAND022', 'Luc�a M�ndez', '2024-07-02', 'Analista de Marketing', '2024-07-11', 'Aprobado', '85/100', '2024-07-16', 'Aprobado', '2024-07-21', '2024-07-26', 'No', 'N/A', 'Rechazado', 2),
('CAND023', 'Sof�a Pe�a', '2024-07-03', 'Especialista en Seguridad', '2024-07-12', 'Pendiente', 'N/A', '2024-07-17', 'Pendiente', '2024-07-22', '2024-07-27', 'No', 'N/A', 'Rechazado', 3),
('CAND024', 'Rodrigo Cruz', '2024-07-04', 'Ingeniero de DevOps', '2024-07-13', 'Aprobado', '92/100', '2024-07-18', 'Aprobado', '2024-07-23', '2024-07-28', 'S�', 'Enviada', 'En proceso', 4),
('CAND025', 'Beatriz Ortega', '2024-07-05', 'Gerente de Producto', '2024-07-14', 'Aprobado', '90/100', '2024-07-19', 'Aprobado', '2024-07-24', '2024-07-29', 'S�', 'Aceptada', 'Contratado', 5),
('CAND026', 'Tom�s V�zquez', '2024-07-06', 'Especialista en Big Data', '2024-07-15', 'Aprobado', '95/100', '2024-07-20', 'Aprobado', '2024-07-25', '2024-07-30', 'S�', 'Enviada', 'En proceso', 1),
('CAND027', 'Isabel Navarro', '2024-07-07', 'Analista de Negocios', '2024-07-16', 'Pendiente', 'N/A', '2024-07-21', 'Pendiente', '2024-07-26', '2024-07-31', 'No', 'N/A', 'Rechazado', 2),
('CAND028', 'Mart�n Fern�ndez', '2024-07-08', 'Consultor en Transformaci�n Digital', '2024-07-17', 'Aprobado', '88/100', '2024-07-22', 'Aprobado', '2024-07-27', '2024-08-01', 'S�', 'Aceptada', 'Contratado', 3),
('CAND029', 'Patricia Herrera', '2024-07-09', 'Especialista en IA', '2024-07-18', 'Aprobado', '90/100', '2024-07-23', 'Aprobado', '2024-07-28', '2024-08-02', 'S�', 'Enviada', 'En proceso', 4),
('CAND030', 'Jorge Castillo', '2024-07-10', 'Consultor de CRM', '2024-07-19', 'Aprobado', '85/100', '2024-07-24', 'Aprobado', '2024-07-29', '2024-08-03', 'S�', 'Aceptada', 'Contratado', 5),
('CAND031', 'Natalia Ruiz', '2024-07-11', 'Desarrollador de Juegos', '2024-07-20', 'Pendiente', 'N/A', '2024-07-25', 'Pendiente', '2024-07-30', '2024-08-04', 'No', 'N/A', 'Rechazado', 1),
('CAND032', 'Hugo D�az', '2024-07-12', 'Analista de Seguridad', '2024-07-21', 'Aprobado', '88/100', '2024-07-26', 'Aprobado', '2024-07-31', '2024-08-05', 'S�', 'Aceptada', 'Contratado', 2),
('CAND033', 'Paula Vargas', '2024-07-13', 'Especialista en UX/UI', '2024-07-22', 'Aprobado', '90/100', '2024-07-27', 'Aprobado', '2024-08-01', '2024-08-06', 'S�', 'Enviada', 'En proceso', 3),
('CAND034', 'Luis Garc�a', '2024-07-14', 'Ingeniero de Machine Learning', '2024-07-23', 'Aprobado', '95/100', '2024-07-28', 'Aprobado', '2024-08-02', '2024-08-07', 'S�', 'Aceptada', 'Contratado', 4),
('CAND035', 'Andrea Mart�nez', '2024-07-15', 'Consultor de BI', '2024-07-24', 'Pendiente', 'N/A', '2024-07-29', 'Pendiente', '2024-08-03', '2024-08-08', 'No', 'N/A', 'Rechazado', 5),
('CAND036', 'Fernando Ramos', '2024-07-16', 'Ingeniero de Datos', '2024-07-25', 'Aprobado', '92/100', '2024-07-30', 'Aprobado', '2024-08-04', '2024-08-09', 'S�', 'Enviada', 'En proceso', 1),
('CAND037', 'Alicia Medina', '2024-07-17', 'Especialista en Cloud', '2024-07-26', 'Aprobado', '88/100', '2024-07-31', 'Aprobado', '2024-08-05', '2024-08-10', 'S�', 'Aceptada', 'Contratado', 2),
('CAND038', 'Javier Mu�oz', '2024-07-18', 'Gerente de TI', '2024-07-27', 'Pendiente', 'N/A', '2024-08-01', 'Pendiente', '2024-08-06', '2024-08-11', 'No', 'N/A', 'Rechazado', 3),
('CAND039', 'Teresa L�pez', '2024-07-19', 'Analista de Negocios', '2024-07-28', 'Aprobado', '85/100', '2024-08-02', 'Aprobado', '2024-08-07', '2024-08-12', 'S�', 'Aceptada', 'Contratado', 4),
('CAND040', 'Alejandro Torres', '2024-07-20', 'Ingeniero de Redes', '2024-07-29', 'Aprobado', '90/100', '2024-08-03', 'Aprobado', '2024-08-08', '2024-08-13', 'S�', 'Enviada', 'En proceso', 5);



-- CONSULTAR REGISTROS DE LA TABLA Reclutamiento:
SELECT * FROM Reclutamiento;

-- INSERTAR REGISTROS EN LA TABLA Reclutamiento:
INSERT INTO Reclutamiento (IDCandidato, Nombre, Fecha_Publicacion_Vacante, Puesto, LlamadaInicial, EvaluacionCV, PruebasTecnicas, PrimeraEntrevista, SegundaEvaluacion, EntrevistaRRHH, EntrevistaFinal, Seleccion, Oferta, Estado)
VALUES 
('CAND041', 'Carlos Mendoza', '2024-07-01', 'Chofer de Cami�n', '2024-07-10', 'Aprobado', '75/100', '2024-07-15', 'Aprobado', '2024-07-20', '2024-07-25', 'S�', 'Aceptada', 'Contratado'),
('CAND042', 'Laura S�nchez', '2024-07-02', 'Vendedor', '2024-07-11', 'Aprobado', '80/100', '2024-07-16', 'Aprobado', '2024-07-21', '2024-07-26', 'S�', 'Aceptada', 'Contratado'),
('CAND043', 'Pedro Ram�rez', '2024-07-03', 'Ayudante de Cami�n', '2024-07-12', 'Pendiente', 'N/A', '2024-07-17', 'Pendiente', '2024-07-22', '2024-07-27', 'No', 'N/A', 'Rechazado'),
('CAND044', 'Ana Torres', '2024-07-04', 'Ayudante de Almac�n', '2024-07-13', 'Aprobado', '70/100', '2024-07-18', 'Aprobado', '2024-07-23', '2024-07-28', 'S�', 'Aceptada', 'Contratado'),
('CAND045', 'Miguel Vargas', '2024-07-05', 'Chofer de Cami�n', '2024-07-14', 'Aprobado', '85/100', '2024-07-19', 'Aprobado', '2024-07-24', '2024-07-29', 'S�', 'Aceptada', 'Contratado'),
('CAND046', 'Sof�a Morales', '2024-07-06', 'Vendedor', '2024-07-15', 'Aprobado', '82/100', '2024-07-20', 'Aprobado', '2024-07-25', '2024-07-30', 'S�', 'Aceptada', 'Contratado'),
('CAND047', 'Juan Castillo', '2024-07-07', 'Ayudante de Cami�n', '2024-07-16', 'Pendiente', 'N/A', '2024-07-21', 'Pendiente', '2024-07-26', '2024-07-31', 'No', 'N/A', 'Rechazado'),
('CAND048', 'Paula Reyes', '2024-07-08', 'Ayudante de Almac�n', '2024-07-17', 'Aprobado', '75/100', '2024-07-22', 'Aprobado', '2024-07-27', '2024-08-01', 'S�', 'Aceptada', 'Contratado'),
('CAND049', 'Luis Herrera', '2024-07-09', 'Chofer de Cami�n', '2024-07-18', 'Aprobado', '88/100', '2024-07-23', 'Aprobado', '2024-07-28', '2024-08-02', 'S�', 'Aceptada', 'Contratado'),
('CAND050', 'Gabriela P�rez', '2024-07-10', 'Vendedor', '2024-07-19', 'Aprobado', '77/100', '2024-07-24', 'Aprobado', '2024-07-29', '2024-08-03', 'S�', 'Aceptada', 'Contratado'),
('CAND051', 'Fernando G�mez', '2024-07-11', 'Ayudante de Cami�n', '2024-07-20', 'Pendiente', 'N/A', '2024-07-25', 'Pendiente', '2024-07-30', '2024-08-04', 'No', 'N/A', 'Rechazado'),
('CAND052', 'Marta L�pez', '2024-07-12', 'Ayudante de Almac�n', '2024-07-21', 'Aprobado', '70/100', '2024-07-26', 'Aprobado', '2024-07-31', '2024-08-05', 'S�', 'Aceptada', 'Contratado'),
('CAND053', 'Alberto Ram�rez', '2024-07-13', 'Chofer de Cami�n', '2024-07-22', 'Aprobado', '85/100', '2024-07-27', 'Aprobado', '2024-08-01', '2024-08-06', 'S�', 'Aceptada', 'Contratado'),
('CAND054', 'Luc�a Fern�ndez', '2024-07-14', 'Vendedor', '2024-07-23', 'Aprobado', '82/100', '2024-07-28', 'Aprobado', '2024-08-02', '2024-08-07', 'S�', 'Aceptada', 'Contratado'),
('CAND055', 'Andr�s G�mez', '2024-07-15', 'Ayudante de Cami�n', '2024-07-24', 'Pendiente', 'N/A', '2024-07-29', 'Pendiente', '2024-08-03', '2024-08-08', 'No', 'N/A', 'Rechazado'),
('CAND056', 'Elena D�az', '2024-07-16', 'Ayudante de Almac�n', '2024-07-25', 'Aprobado', '75/100', '2024-07-30', 'Aprobado', '2024-08-04', '2024-08-09', 'S�', 'Aceptada', 'Contratado'),
('CAND057', 'Roberto S�nchez', '2024-07-17', 'Chofer de Cami�n', '2024-07-26', 'Aprobado', '88/100', '2024-07-31', 'Aprobado', '2024-08-05', '2024-08-10', 'S�', 'Aceptada', 'Contratado'),
('CAND058', 'Valeria Jim�nez', '2024-07-18', 'Vendedor', '2024-07-27', 'Aprobado', '77/100', '2024-08-01', 'Aprobado', '2024-08-06', '2024-08-11', 'S�', 'Aceptada', 'Contratado'),
('CAND059', 'Diego Torres', '2024-07-19', 'Ayudante de Cami�n', '2024-07-28', 'Pendiente', 'N/A', '2024-08-02', 'Pendiente', '2024-08-07', '2024-08-12', 'No', 'N/A', 'Rechazado'),
('CAND060', 'Natalia Ruiz', '2024-07-20', 'Ayudante de Almac�n', '2024-07-29', 'Aprobado', '70/100', '2024-08-03', 'Aprobado', '2024-08-08', '2024-08-13', 'S�', 'Aceptada', 'Contratado');

-- INSERTAR REGISTROS EN LA TABLA Reclutamiento:
INSERT INTO Reclutamiento (IDCandidato, Nombre, Fecha_Publicacion_Vacante, Puesto, LlamadaInicial, EvaluacionCV, PruebasTecnicas, PrimeraEntrevista, SegundaEvaluacion, EntrevistaRRHH, EntrevistaFinal, Seleccion, Oferta, Estado, IDTerminal)
VALUES 
('CAND041', 'Carlos Guti�rrez', '2024-07-21', 'Chofer de Cami�n', '2024-07-30', 'Aprobado', '75/100', '2024-08-04', 'Aprobado', '2024-08-09', '2024-08-14', 'S�', 'Aceptada', 'Contratado', 1),
('CAND042', 'Laura Rodr�guez', '2024-07-22', 'Vendedor', '2024-07-31', 'Aprobado', '80/100', '2024-08-05', 'Aprobado', '2024-08-10', '2024-08-15', 'S�', 'Aceptada', 'Contratado', 2),
('CAND043', 'Pedro Hern�ndez', '2024-07-23', 'Ayudante de Cami�n', '2024-08-01', 'Pendiente', 'N/A', '2024-08-06', 'Pendiente', '2024-08-11', '2024-08-16', 'No', 'N/A', 'Rechazado', 3),
('CAND044', 'Ana Mart�nez', '2024-07-24', 'Ayudante de Almac�n', '2024-08-02', 'Aprobado', '70/100', '2024-08-07', 'Aprobado', '2024-08-12', '2024-08-17', 'S�', 'Aceptada', 'Contratado', 4),
('CAND045', 'Miguel L�pez', '2024-07-25', 'Chofer de Cami�n', '2024-08-03', 'Aprobado', '85/100', '2024-08-08', 'Aprobado', '2024-08-13', '2024-08-18', 'S�', 'Aceptada', 'Contratado', 5),
('CAND046', 'Sof�a Gonz�lez', '2024-07-26', 'Vendedor', '2024-08-04', 'Aprobado', '82/100', '2024-08-09', 'Aprobado', '2024-08-14', '2024-08-19', 'S�', 'Aceptada', 'Contratado', 1),
('CAND047', 'Juan P�rez', '2024-07-27', 'Ayudante de Cami�n', '2024-08-05', 'Pendiente', 'N/A', '2024-08-10', 'Pendiente', '2024-08-15', '2024-08-20', 'No', 'N/A', 'Rechazado', 2),
('CAND048', 'Paula Romero', '2024-07-28', 'Ayudante de Almac�n', '2024-08-06', 'Aprobado', '75/100', '2024-08-11', 'Aprobado', '2024-08-16', '2024-08-21', 'S�', 'Aceptada', 'Contratado', 3),
('CAND049', 'Luis Serrano', '2024-07-29', 'Chofer de Cami�n', '2024-08-07', 'Aprobado', '88/100', '2024-08-12', 'Aprobado', '2024-08-17', '2024-08-22', 'S�', 'Aceptada', 'Contratado', 4),
('CAND050', 'Gabriela Mu�oz', '2024-07-30', 'Vendedor', '2024-08-08', 'Aprobado', '77/100', '2024-08-13', 'Aprobado', '2024-08-18', '2024-08-23', 'S�', 'Aceptada', 'Contratado', 5),
('CAND051', 'Fernando D�az', '2024-07-31', 'Ayudante de Cami�n', '2024-08-09', 'Pendiente', 'N/A', '2024-08-14', 'Pendiente', '2024-08-19', '2024-08-24', 'No', 'N/A', 'Rechazado', 1),
('CAND052', 'Marta Ruiz', '2024-08-01', 'Ayudante de Almac�n', '2024-08-10', 'Aprobado', '70/100', '2024-08-15', 'Aprobado', '2024-08-20', '2024-08-25', 'S�', 'Aceptada', 'Contratado', 2),
('CAND053', 'Alberto Jim�nez', '2024-08-02', 'Chofer de Cami�n', '2024-08-11', 'Aprobado', '85/100', '2024-08-16', 'Aprobado', '2024-08-21', '2024-08-26', 'S�', 'Aceptada', 'Contratado', 3),
('CAND054', 'Luc�a Ram�rez', '2024-08-03', 'Vendedor', '2024-08-12', 'Aprobado', '82/100', '2024-08-17', 'Aprobado', '2024-08-22', '2024-08-27', 'S�', 'Aceptada', 'Contratado', 4),
('CAND055', 'Andr�s Garc�a', '2024-08-04', 'Ayudante de Cami�n', '2024-08-13', 'Pendiente', 'N/A', '2024-08-18', 'Pendiente', '2024-08-23', '2024-08-28', 'No', 'N/A', 'Rechazado', 5),
('CAND056', 'Elena Mart�n', '2024-08-05', 'Ayudante de Almac�n', '2024-08-14', 'Aprobado', '75/100', '2024-08-19', 'Aprobado', '2024-08-24', '2024-08-29', 'S�', 'Aceptada', 'Contratado', 1),
('CAND057', 'Roberto P�rez', '2024-08-06', 'Chofer de Cami�n', '2024-08-15', 'Aprobado', '88/100', '2024-08-20', 'Aprobado', '2024-08-25', '2024-08-30', 'S�', 'Aceptada', 'Contratado', 2),
('CAND058', 'Valeria Mart�nez', '2024-08-07', 'Vendedor', '2024-08-16', 'Aprobado', '77/100', '2024-08-21', 'Aprobado', '2024-08-26', '2024-08-31', 'S�', 'Aceptada', 'Contratado', 3),
('CAND059', 'Diego L�pez', '2024-08-08', 'Ayudante de Cami�n', '2024-08-17', 'Pendiente', 'N/A', '2024-08-22', 'Pendiente', '2024-08-27', '2024-09-01', 'No', 'N/A', 'Rechazado', 4),
('CAND050', 'Natalia Fern�ndez', '2024-08-09', 'Ayudante de Almac�n', '2024-08-18', 'Aprobado', '70/100', '2024-08-23', 'Aprobado', '2024-08-28', '2024-09-02', 'S�', 'Aceptada', 'Contratado', 5);



ALTER TABLE Reclutamiento
ADD DiasTranscurridos INT;

UPDATE Reclutamiento
SET DiasTranscurridos = DATEDIFF(DAY, Fecha_Publicacion_Vacante, EntrevistaFinal);

CREATE VIEW Vista_Reclutamiento AS
SELECT 
    IDCandidato,
    Nombre,
    Fecha_Publicacion_Vacante,
    Puesto,
    LlamadaInicial,
    EvaluacionCV,
    PruebasTecnicas,
    PrimeraEntrevista,
    SegundaEvaluacion,
    EntrevistaRRHH,
    EntrevistaFinal,
    Seleccion,
    Oferta,
    Estado,
    DiasTranscurridos
FROM 
    Reclutamiento;


select * from Vista_Reclutamiento



PruebasTecnicas
85/100
78/100
92/100
80/100
90/100
88/100
95/100
N/A
85/100
88/100
N/A
90/100
95/100
85/100
92/100
N/A
88/100
90/100
95/100
88/100
85/100
N/A
92/100
90/100
95/100
N/A
88/100
90/100
85/100
N/A
88/100
90/100
95/100
N/A
92/100
88/100
N/A
85/100
90/100
75/100
80/100
N/A
70/100
85/100
82/100
N/A
75/100
88/100
77/100
N/A
70/100
85/100
82/100
N/A
75/100


WITH RandomOrder AS (
    SELECT 
        IDCandidato,
        ROW_NUMBER() OVER (ORDER BY NEWID()) AS RowNum
    FROM Reclutamiento
)
UPDATE r
SET r.IDTerminal = ((ro.RowNum - 1) % 5) + 1
FROM Reclutamiento r
JOIN RandomOrder ro ON r.IDCandidato = ro.IDCandidato;
SELECT * FROM Reclutamiento


SELECT IDTerminal, COUNT(*) AS Cantidad
FROM Reclutamiento
GROUP BY IDTerminal
ORDER BY IDTerminal;

UPDATE Reclutamiento
SET IDTerminal = 
    CASE 
        WHEN RAND() < 0.7 THEN 3  -- 70% de las veces ser� 3 (Santo Domingo)
        ELSE (ABS(CHECKSUM(NEWID())) % 4) + 1  -- 30% restante distribuido entre 1, 2, 4 y 5
    END;

-- Ajustar los valores 4 para que sean 5
UPDATE Reclutamiento
SET IDTerminal = 5
WHERE IDTerminal = 4 AND ABS(CHECKSUM(NEWID())) % 2 = 0;


SELECT 
    IDTerminal, 
    COUNT(*) AS Cantidad,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Reclutamiento) AS DECIMAL(5,2)) AS Porcentaje
FROM Reclutamiento
GROUP BY IDTerminal
ORDER BY IDTerminal;



-- N�mero total de vacantes o puestos �nicos
SELECT COUNT(DISTINCT Puesto) AS TotalVacantes FROM Reclutamiento;

-- N�mero de candidatos aprobados en Pruebas T�cnicas (>= 70)
SELECT COUNT(*) AS TotalAprobados 
FROM Reclutamiento 
WHERE 
    (CASE 
        WHEN PruebasTecnicas = 'N/A' THEN 70
        ELSE CAST(SUBSTRING(PruebasTecnicas, 1, CHARINDEX('/', PruebasTecnicas) - 1) AS INT)
    END) >= 70;

-- N�mero de candidatos pendientes en Pruebas T�cnicas (N/A)
SELECT COUNT(*) AS TotalPendientes 
FROM Reclutamiento 
WHERE PruebasTecnicas = 'N/A';

-- N�mero de candidatos seleccionados (S�)
SELECT COUNT(*) AS TotalSeleccionadosSi 
FROM Reclutamiento 
WHERE Seleccion = 'S�';

-- N�mero de candidatos no seleccionados (No)
SELECT COUNT(*) AS TotalSeleccionadosNo 
FROM Reclutamiento 
WHERE Seleccion = 'No';

-- N�mero de ofertas aceptadas
SELECT COUNT(*) AS TotalOfertasAceptadas 
FROM Reclutamiento 
WHERE Oferta = 'Aceptada';

-- N�mero de ofertas N/A
SELECT COUNT(*) AS TotalOfertasNA 
FROM Reclutamiento 
WHERE Oferta = 'N/A';

-- N�mero de ofertas enviadas
SELECT COUNT(*) AS TotalOfertasEnviadas 
FROM Reclutamiento 
WHERE Oferta = 'Enviada';

-- N�mero de ofertas rechazadas
SELECT COUNT(*) AS TotalOfertasRechazadas 
FROM Reclutamiento 
WHERE Oferta = 'Rechazada';

-- N�mero de candidatos por estado
SELECT Estado, COUNT(*) AS TotalCandidatos 
FROM Reclutamiento 
GROUP BY Estado;

-- N�mero de vacantes o puestos por terminal
SELECT t.NombreTerminal, COUNT(DISTINCT r.Puesto) AS TotalVacantes
FROM Reclutamiento r
JOIN Terminal t ON r.IDTerminal = t.IDTerminal
GROUP BY t.NombreTerminal;

-- Promedio de d�as desde la publicaci�n de la vacante hasta la llamada inicial
SELECT AVG(DATEDIFF(day, Fecha_Publicacion_Vacante, LlamadaInicial)) AS PromedioDiasHastaLlamadaInicial
FROM Reclutamiento
WHERE Fecha_Publicacion_Vacante IS NOT NULL AND LlamadaInicial IS NOT NULL;

-- Promedio de d�as desde la publicaci�n de la vacante hasta la primera entrevista
SELECT AVG(DATEDIFF(day, Fecha_Publicacion_Vacante, PrimeraEntrevista)) AS PromedioDiasHastaPrimeraEntrevista
FROM Reclutamiento
WHERE Fecha_Publicacion_Vacante IS NOT NULL AND PrimeraEntrevista IS NOT NULL;

-- Promedio de d�as desde la publicaci�n de la vacante hasta la entrevista con RRHH
SELECT AVG(DATEDIFF(day, Fecha_Publicacion_Vacante, EntrevistaRRHH)) AS PromedioDiasHastaEntrevistaRRHH
FROM Reclutamiento
WHERE Fecha_Publicacion_Vacante IS NOT NULL AND EntrevistaRRHH IS NOT NULL;

-- Promedio de d�as desde la publicaci�n de la vacante hasta la entrevista final
SELECT AVG(DATEDIFF(day, Fecha_Publicacion_Vacante, EntrevistaFinal)) AS PromedioDiasHastaEntrevistaFinal
FROM Reclutamiento
WHERE Fecha_Publicacion_Vacante IS NOT NULL AND EntrevistaFinal IS NOT NULL;
