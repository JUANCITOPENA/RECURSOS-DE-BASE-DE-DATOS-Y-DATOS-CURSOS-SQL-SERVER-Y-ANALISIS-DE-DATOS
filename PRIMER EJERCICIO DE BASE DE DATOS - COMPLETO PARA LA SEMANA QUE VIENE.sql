--CREAR UNA BASE DE DATOS:
CREATE DATABASE BASE_DATOS_EMPLEADOS;
GO

USE BASE_DATOS_EMPLEADOS;
GO

--CREATE TABLE GENERO

CREATE TABLE GENERO(
	ID_GENERO INT primary key,
	GENERO VARCHAR(20) NOT NULL
)

--CREATE TABLE GENERO

CREATE TABLE DEPARTAMENTO(
	ID_DEPARTAMENTO INT primary key,
	DEPARTAMENTO VARCHAR(20) NOT NULL
)


--CREATE TABLE CIUDAD

CREATE TABLE CIUDAD(
	ID_CIUDAD INT primary key,
	CIUDAD VARCHAR(50) NOT NULL
)

SELECT * FROM CIUDAD


--CREAR TABLA EMPLEADOS:

CREATE TABLE EMPLEADOS(
	  ID_EMPLEADO INT PRIMARY KEY ,
	  NOMBRE VARCHAR(50) NOT NULL,
	  APELLIDO VARCHAR(50) NOT NULL,
	  TELEFONO VARCHAR(20) NOT NULL,
	  ID_DEPARTAMENTO INT,
	  ID_GENERO INT,
	  ID_CIUDAD INT
)


--Para crear las relaciones entre las tablas en SQL Server, se pueden utilizar dos códigos:

--CONSTRAINT FOREIGN KEY:

--Este código se utiliza para agregar una restricción de clave foránea a una columna en una tabla que hace referencia a otra tabla.

--Ejemplo:

--Agregar restricción de clave foránea en la tabla EMPLEADOS que hace referencia a la tabla DEPARTAMENTO

ALTER TABLE EMPLEADOS
ADD CONSTRAINT FK_EMPLEADOS_DEPARTAMENTO
FOREIGN KEY (ID_DEPARTAMENTO)
REFERENCES DEPARTAMENTO(ID_DEPARTAMENTO);

--Agregar restricción de clave foránea en la tabla EMPLEADOS que hace referencia a la tabla GENERO

ALTER TABLE EMPLEADOS
ADD CONSTRAINT FK_EMPLEADOS_GENERO
FOREIGN KEY (ID_GENERO)
REFERENCES GENERO(ID_GENERO);

--Agregar restricción de clave foránea en la tabla EMPLEADOS que hace referencia a la tabla CIUDAD

ALTER TABLE EMPLEADOS
ADD CONSTRAINT FK_EMPLEADOS_CIUDAD
FOREIGN KEY (ID_CIUDAD)
REFERENCES CIUDAD(ID_CIUDAD);


--Insertar 5 registros en la tabla GENERO

INSERT INTO GENERO(ID_GENERO, GENERO)
VALUES (1, 'Masculino'),
(2, 'Femenino'),
(3, 'No binario'),
(4, 'Prefiero no decirlo'),
(5, 'Otro');

--Insertar 5 registros en la tabla DEPARTAMENTO

INSERT INTO DEPARTAMENTO(ID_DEPARTAMENTO, DEPARTAMENTO)
VALUES (1, 'Ventas'),
(2, 'Marketing'),
(3, 'Recursos humanos'),
(4, 'Finanzas'),
(5, 'Desarrollo');

--Insertar 5 registros en la tabla CIUDAD

INSERT INTO CIUDAD(ID_CIUDAD, CIUDAD)
VALUES (1, 'Santo Domingo'),
(2, 'Azua'),
(3, 'Bani'),
(4, 'La Vega'),
(5, 'Santiago');

--Insertar 5 registros en la tabla EMPLEADOS

INSERT INTO EMPLEADOS(ID_EMPLEADO, NOMBRE, APELLIDO, TELEFONO, ID_DEPARTAMENTO, ID_GENERO, ID_CIUDAD)
VALUES (1, 'Juancito', 'Peña', '809-555-1234', 1, 1, 1),
(2, 'María', 'García', '809-223-5678', 2, 2, 2),
(3, 'Pedro', 'Rodríguez', '809-444-9012', 3, 1, 3),
(4, 'Laura', 'Hernández', '809-111-3456', 4, 2, 4),
(5, 'Carlos', 'González', '809-100-7890', 5, 1, 5),
(6, 'Juan', 'Pérez', '809-105-1234', 1, 1, 1),
(7, 'Martha', 'García', '809-123-5678', 2, 2, 2),
(8, 'Jose', 'Rodríguez', '809-456-9012', 3, 1, 3),
(9, 'Guillermo', 'Hernández', '809-789-3456', 4, 2, 4),
(10, 'Katherin', 'González', '809-987-7890', 5, 1, 5),
(11, 'Ana maria', 'Marquez', '809-654-2345', 1, 2, 2),
(12, 'Alenjandro', 'Santana', '809-321-6789', 2, 1, 3),
(13, 'Dahina', 'de Morla', '809-353-0123', 3, 2, 4),
(14, 'George', 'Gutierrez', '809-500-4567', 4, 1, 5),
(15, 'Marcos', 'Noel', '809-499-8901', 5, 2, 1);

 --ALGUNAS CONSULTAS BASICAS;

 SELECT * FROM EMPLEADOS;
 SELECT * FROM CIUDAD;
 SELECT * FROM GENERO;
 SELECT * FROM DEPARTAMENTO;  

--Seleccionar los nombres y apellidos de los empleados que trabajan en el departamento de Finanzas:

SELECT NOMBRE, APELLIDO FROM EMPLEADOS WHERE ID_DEPARTAMENTO = 4;

--Seleccionar el número total de empleados por departamento:

SELECT DEPARTAMENTO, COUNT(*) AS NUMERO_DE_EMPLEADOS
FROM EMPLEADOS JOIN DEPARTAMENTO ON EMPLEADOS.ID_DEPARTAMENTO = DEPARTAMENTO.ID_DEPARTAMENTO 
GROUP BY DEPARTAMENTO;

--Seleccionar los nombres de los empleados que son de la ciudad de Madrid:

SELECT NOMBRE, APELLIDO, TELEFONO 
FROM EMPLEADOS 
JOIN CIUDAD ON EMPLEADOS.ID_CIUDAD = CIUDAD.ID_CIUDAD 
WHERE CIUDAD = 'La Vega';

--Seleccionar el número de empleados por género:

SELECT GENERO, COUNT(*) AS NUMERO_DE_EMPLEADOS 
FROM EMPLEADOS JOIN GENERO ON EMPLEADOS.ID_GENERO = GENERO.ID_GENERO 
GROUP BY GENERO;

--Seleccionar los nombres de los empleados que tienen un número de teléfono que comienza con "555":

SELECT NOMBRE, APELLIDO FROM EMPLEADOS WHERE TELEFONO LIKE '809-5%';

--Seleccionar el nombre y apellido del empleado más reciente contratado:

SELECT NOMBRE, APELLIDO FROM EMPLEADOS ORDER BY ID_EMPLEADO DESC;

--Seleccionar el número total de empleados en la tabla EMPLEADOS:

SELECT COUNT(*) AS NUMERO_DE_EMPLEADOS FROM EMPLEADOS;

--APRENDIENDO A UTILIZAR LOS JOIN:

SELECT e.NOMBRE, e.APELLIDO, e.TELEFONO, d.DEPARTAMENTO AS NOMBRE_DEPARTAMENTO, g.GENERO AS NOMBRE_GENERO, c.CIUDAD AS NOMBRE_CIUDAD
FROM EMPLEADOS e
JOIN DEPARTAMENTO d ON e.ID_DEPARTAMENTO = d.ID_DEPARTAMENTO
JOIN GENERO g ON e.ID_GENERO = g.ID_GENERO
JOIN CIUDAD c ON e.ID_CIUDAD = c.ID_CIUDAD;

--Seleccionar los nombres y apellidos de los empleados que son del género "Femenino" y trabajan en el departamento de "Ventas":

SELECT NOMBRE, APELLIDO 
FROM EMPLEADOS 
JOIN GENERO ON EMPLEADOS.ID_GENERO = GENERO.ID_GENERO
JOIN DEPARTAMENTO ON EMPLEADOS.ID_DEPARTAMENTO = DEPARTAMENTO.ID_DEPARTAMENTO 
WHERE GENERO = 'Femenino' AND DEPARTAMENTO = 'Ventas';
  
--CONSULTAS AVANZADAS:

--Consulta para obtener los datos de los empleados y su departamento

SELECT EMPLEADOS.NOMBRE, EMPLEADOS.APELLIDO, DEPARTAMENTO.DEPARTAMENTO
FROM EMPLEADOS
JOIN DEPARTAMENTO ON EMPLEADOS.ID_DEPARTAMENTO = DEPARTAMENTO.ID_DEPARTAMENTO;

--Consulta para obtener los datos de los empleados y su ciudad

SELECT EMPLEADOS.NOMBRE, EMPLEADOS.APELLIDO, CIUDAD.CIUDAD
FROM EMPLEADOS
JOIN CIUDAD ON EMPLEADOS.ID_CIUDAD = CIUDAD.ID_CIUDAD;

--Consulta para obtener los datos de los empleados y su género

SELECT EMPLEADOS.NOMBRE, EMPLEADOS.APELLIDO, GENERO.GENERO
FROM EMPLEADOS
JOIN GENERO ON EMPLEADOS.ID_GENERO = GENERO.ID_GENERO;

-- VAMOS A CREAR UNA VISTA:

CREATE VIEW vista_empleados_ventas AS
SELECT NOMBRE, APELLIDO, DEPARTAMENTO
FROM EMPLEADOS
JOIN DEPARTAMENTO ON EMPLEADOS.ID_DEPARTAMENTO = DEPARTAMENTO.ID_DEPARTAMENTO
WHERE DEPARTAMENTO = 'Ventas';


--VAMOS A EJECUTAR LA VISTA:

SELECT * FROM  vista_empleados_ventas

-- VAMOS HACER UNA VISTA CON TODOS LOS DATOS:

CREATE VIEW vista_empleados_detalle AS
SELECT e.NOMBRE, e.APELLIDO, e.TELEFONO, d.DEPARTAMENTO AS NOMBRE_DEPARTAMENTO, g.GENERO AS NOMBRE_GENERO, c.CIUDAD AS NOMBRE_CIUDAD
FROM EMPLEADOS e
JOIN DEPARTAMENTO d ON e.ID_DEPARTAMENTO = d.ID_DEPARTAMENTO
JOIN GENERO g ON e.ID_GENERO = g.ID_GENERO
JOIN CIUDAD c ON e.ID_CIUDAD = c.ID_CIUDAD;

--VAMOS A EJECUTAR LA VISTA:
SELECT * FROM vista_empleados_detalle;


--IMAGINEMOS QUE NOS DAN UNOS NUEVOS PARA LA TABLA EMAIL Y SUELDOS:

ALTER TABLE EMPLEADOS
ADD EMAIL VARCHAR(50) NULL,
    SUELDO DECIMAL(10,2) NULL;

--VEAMOS LA TABLA AHORA:

SELECT * FROM EMPLEADOS

--VAMOS HACER UN PROCEDIMIENTO ALMACENADO PARA INSERTAR LOS SUELDOS Y CORREOS ALEARORIOS:

CREATE OR ALTER PROCEDURE INSERTAR_SUELDOS_Y_EMAILS
AS
BEGIN
    DECLARE @max_id INT;
    DECLARE @id INT = 1;
    DECLARE @email VARCHAR(50);
    DECLARE @sueldo DECIMAL(10,2);

    SELECT @max_id = MAX(ID_EMPLEADO) FROM EMPLEADOS;

    WHILE @id <= @max_id
    BEGIN
        SET @email = CONCAT('empleado', @id, '@example.com');
        SET @sueldo = ROUND(RAND() * (25000-10000) + 100000, 2);

        UPDATE EMPLEADOS
        SET EMAIL = @email,
            SUELDO = @sueldo
        WHERE ID_EMPLEADO = @id;

        SET @id = @id + 1;
    END;
END;


--EJECUTEMOS EL PROCEDIMIENTO:

EXEC INSERTAR_SUELDOS_Y_EMAILS;


 --ALGUNAS CONSULTAS BASICAS;

 SELECT * FROM EMPLEADOS;



 --AHORA SI HUBIERAMOS REALIZADO CORRECTAMENTE LA TABLA SERIA ASI:

 CREATE TABLE EMPLEADOS_TEMP (
    ID_EMPLEADO INT PRIMARY KEY,
    NOMBRE VARCHAR(50) NOT NULL,
    APELLIDO VARCHAR(50) NOT NULL,
    TELEFONO VARCHAR(20) NOT NULL,
    EMAIL VARCHAR(50) NULL,
    SUELDO DECIMAL(10,2) NULL,
    ID_DEPARTAMENTO INT,
    ID_GENERO INT,
    ID_CIUDAD INT,
    FOREIGN KEY (ID_DEPARTAMENTO) REFERENCES DEPARTAMENTO (ID_DEPARTAMENTO),
    FOREIGN KEY (ID_GENERO) REFERENCES GENERO (ID_GENERO),
    FOREIGN KEY (ID_CIUDAD) REFERENCES CIUDAD (ID_CIUDAD)
);

 DROP TABLE EMPLEADOS;

EXEC sp_rename 'dbo.EMPLEADOS_TEMP', 'EMPLEADOS';


INSERT INTO EMPLEADOS (ID_EMPLEADO,NOMBRE, APELLIDO, TELEFONO, ID_DEPARTAMENTO, ID_GENERO, ID_CIUDAD, EMAIL, SUELDO)
VALUES
  (1,'Juan', 'Pérez', '555-1234', 1, 1, 1, 'juan.perez@gmail.com', 2500),
  (2,'Ana', 'García', '555-2345', 2, 2, 2, 'ana.garcia@hotmail.com', 3000),
  (3,'Pedro', 'López', '555-3456', 3, 1, 1, 'pedro.lopez@yahoo.com', 3500),
  (4,'María', 'Fernández', '555-4567', 1, 2, 2, 'maria.fernandez@gmail.com', 4000),
  (5,'Luis', 'Martínez', '555-5678', 2, 1, 1, 'luis.martinez@hotmail.com', 4500),
  (6,'Laura', 'Hernández', '555-6789', 3, 2, 2, 'laura.hernandez@yahoo.com', 5000),
  (7,'Carlos', 'Gómez', '555-7890', 1, 1, 1, 'carlos.gomez@gmail.com', 5500),
  (8,'Sofía', 'Sánchez', '555-8901', 2, 2, 2, 'sofia.sanchez@hotmail.com', 6000),
  (9,'David', 'Rodríguez', '555-9012', 3, 1, 1, 'david.rodriguez@yahoo.com', 6500),
  (10,'Julia', 'Gutiérrez', '555-0123', 1, 2, 2, 'julia.gutierrez@gmail.com', 7000);

