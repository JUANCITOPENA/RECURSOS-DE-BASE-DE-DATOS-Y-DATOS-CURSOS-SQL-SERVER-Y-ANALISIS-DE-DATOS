/*
  1- CREAR UNA BASE DE DATOS.
  2-USAR LA BASE DE DATOS.
  3-CREAR LAS TABLAS (EMPLEADOS Y SUS CAMPOS COMUNES).
  4-INSERTAR POR LO MENOS 20 REGISTROS.
  5-RESOLVER LOS EJERCICIOS DE CONSULTAS.

*/


--CREAR UNA BASE DE DATOS: PRUEBA_TECNICA:
CREATE DATABASE PRUEBA_TECNICA;
GO

--USAR LA BASE DE DATOS:
USE PRUEBA_TECNICA;
GO

--CREAR UNA TABLA LLAMADA EMPLEADOS:

CREATE TABLE empleados (
    d INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    email VARCHAR(50),
    salario INT,
    fecha_inicio DATE,
    departamento VARCHAR(50),
    experiencia VARCHAR(50),
    titulo_trabajo VARCHAR(50),
    supervisor INT
);


-- insertar los datos en la Tabla:

INSERT INTO empleados (d, nombre, apellido, email, salario, fecha_inicio, departamento, experiencia, titulo_trabajo, supervisor)
VALUES
    (1, 'Juan', 'Perez', 'juan.perez@company.com', 6000, '2020-01-01', 'Ventas', '2 años', 'Gerente de Ventas', NULL),
    (2, 'Maria', 'Rodriguez', 'maria.rodriguez@company.com', 4000, '2021-03-15', 'Marketing', '1 año', 'Especialista en SEO', 1),
    (3, 'Luis', 'Martinez', 'luis.martinez@company.com', 3500, '2019-05-01', 'Finanzas', '3 años', 'Analista de Finanzas', 1),
    (4, 'Ana', 'Sanchez', 'ana.sanchez@company.com', 4500, '2022-01-10', 'Recursos Humanos', '2 años', 'Coordinadora de RH', 3),
    (5, 'Carlos', 'Gomez', 'carlos.gomez@company.com', 3000, '2021-08-20', 'Ventas', '6 meses', 'Vendedor', 1),
    (6, 'Sofia', 'Herrera', 'sofia.herrera@company.com', 5500, '2018-06-01', 'Marketing', '4 años', 'Jefe de Marketing', 2),
    (7, 'Oscar', 'Castro', 'oscar.castro@company.com', 3800, '2019-11-01', 'Finanzas', '2 años', 'Analista de Presupuestos', 3),
    (8, 'Laura', 'Flores', 'laura.flores@company.com', 5200, '2020-09-01', 'Recursos Humanos', '1 año', 'Especialista de Capacitación', 4),
    (9, 'Sofia', 'Fernandez', 'sofia.fernandez@company.com', 6000, '2019-01-01', 'Ventas', '3 años', 'Gerente de Ventas', NULL),
    (10, 'Miguel', 'Gomez', 'miguel.gomez@company.com', 4000, '2020-03-15', 'Marketing', '1 año', 'Especialista en Redes Sociales', 1),
    (11, 'Carolina', 'Perez', 'carolina.perez@company.com', 3500, '2018-05-01', 'Finanzas', '5 años', 'Analista de Inversiones', 1),
    (12, 'Ana', 'Romero', 'ana.romero@company.com', 4500, '2021-01-10', 'Recursos Humanos', '2 años', 'Coordinadora de Selección', 3),
    (13, 'Juan', 'Torres', 'juan.torres@company.com', 3000, '2020-08-20', 'Ventas', '1 año', 'Vendedor', 1),
    (14, 'Daniel', 'Morales', 'daniel.morales@company.com', 5500, '2017-06-01', 'Marketing', '6 años', 'Jefe de Publicidad', 2),
    (15, 'Laura', 'Rodriguez', 'laura.rodriguez@company.com', 3800, '2019-11-01', 'Finanzas', '3 años', 'Analista de Costos', 3),
    (16, 'Carlos', 'Sanchez', 'carlos.sanchez@company.com', 5200, '2022-09-01', 'Recursos Humanos', '1 año', 'Especialista de Compensaciones', 4),
    (17, 'Andrea', 'Martinez', 'andrea.martinez@company.com', 6000, '2022-01-01', 'Ventas', '2 años', 'Gerente de Cuentas', NULL),
    (18, 'Roberto', 'Gonzalez', 'roberto.gonzalez@company.com', 4000, '2018-03-15', 'Marketing', '3 años', 'Especialista en Publicidad Online', 2),
    (19, 'Maria', 'Diaz', 'maria.diaz@company.com', 3500, '2020-05-01', 'Finanzas', '4 años', 'Analista de Riesgos', 1),
    (20, 'Jose', 'Fernandez', 'jose.fernandez@company.com', 4500, '2017-10-01', 'Recursos Humanos', '3 años', 'Coordinador de Beneficios', 4);

/*

 10 ejercicios para una prueba técnica para programador SQL:

Escribir una consulta SQL para mostrar los nombres de los empleados cuyo salario es superior a 5000 dólares.
Escribir una consulta SQL para mostrar los nombres y las fechas de inicio de los empleados que fueron contratados en el año actual.
Escribir una consulta SQL para mostrar la suma total de los salarios de todos los empleados.
Escribir una consulta SQL para mostrar el número total de empleados en cada departamento.
Escribir una consulta SQL para mostrar los nombres y apellidos de los empleados que tienen una dirección de correo electrónico que termina en "@company.com".
Escribir una consulta SQL para mostrar los nombres de los empleados que tienen más de 5 años de experiencia en la empresa.
Escribir una consulta SQL para mostrar los nombres de los empleados que tienen un salario entre 3000 y 5000 dólares.
Escribir una consulta SQL para mostrar el número total de empleados que tienen un título de trabajo específico.
Escribir una consulta SQL para mostrar los nombres y apellidos de los empleados que tienen un supervisor específico.
Escribir una consulta SQL para mostrar los nombres de los empleados que han trabajado en la empresa durante más de 10 años y que tienen una calificación de rendimiento superior al 90%.



*/

--Aquí te presento las soluciones a los 10 ejercicios en SQL Server:
select * from empleados

--1-Mostrar los nombres de los empleados cuyo salario es superior a 5000 dólares:

SELECT nombre
FROM empleados 
WHERE salario > 5000;

--2-Mostrar los nombres y las fechas de inicio de los empleados que fueron contratados en el año actual:

SELECT nombre, fecha_inicio 
FROM empleados 
WHERE YEAR(fecha_inicio) = YEAR(GETDATE());


--3-Mostrar la suma total de los salarios de todos los empleados:

SELECT SUM(salario) 
FROM empleados;


--4-Mostrar el número total de empleados en cada departamento:

SELECT departamento, COUNT(*) as num_empleados 
FROM empleados 
GROUP BY departamento;

--5-Mostrar los nombres y apellidos de los empleados que tienen una dirección de correo electrónico que termina en "@company.com":

SELECT nombre, apellido
FROM empleados 
WHERE email LIKE '%@company.com';

--6-Mostrar losempleados que tienen más de 5 años de experiencia en la empresa:


SELECT nombre, apellido, fecha_inicio, experiencia
FROM empleados 
WHERE DATEDIFF(YEAR, fecha_inicio, GETDATE()) >= 5;

--7-Mostrar los nombres de los empleados que tienen un salario entre 3000 y 5000 dólares:


SELECT nombre
FROM empleados 
WHERE salario BETWEEN 3000 AND 5000;

--8-Mostrar el número total de empleados que tienen un título de trabajo específico:


SELECT COUNT(*) as num_empleados 
FROM empleados 
WHERE titulo_trabajo = 'Vendedor';

--9-Mostrar los nombres y apellidos de los empleados que tienen un supervisor específico:


SELECT nombre, apellido
FROM empleados 
WHERE supervisor = '1';

--10-Mostrar  el nombre, apellido, sueldo, titulo_trabajo, depatamento, fecha de inicio, fecha actual y tiempo en la empresa


SELECT nombre, apellido, salario, titulo_trabajo, departamento, fecha_inicio, GETDATE() AS fecha_actual, 
DATEDIFF(YEAR, fecha_inicio, GETDATE()) AS años_trabajados
FROM empleados


--11-Seleccionar el nombre, apellido y salario de todos los empleados cuyo salario es mayor a 4000.


SELECT nombre, apellido, salario
FROM empleados
WHERE salario > 4000;


--12-Seleccionar el nombre, apellido, título de trabajo y supervisor de todos los empleados cuyo departamento es "Marketing".

SELECT nombre, apellido, titulo_trabajo, supervisor
FROM empleados
WHERE departamento = 'Marketing';

--13-Seleccionar el nombre, apellido y fecha de inicio de los empleados que fueron contratados después del 1/1/2020 y que trabajan en el departamento de "Recursos Humanos".

SELECT nombre, apellido, fecha_inicio
FROM empleados
WHERE departamento = 'Recursos Humanos'
AND fecha_inicio > '2020-01-01';

--14-Seleccionar el nombre, apellido y experiencia de los empleados que tienen más de 2 años de experiencia.

SELECT nombre, apellido, experiencia
FROM empleados
WHERE experiencia > '2 años';

--15-Seleccionar el nombre, apellido y salario de los empleados que ganan entre 3500 y 5000.

SELECT nombre, apellido, salario
FROM empleados
WHERE salario BETWEEN 3500 AND 5000;

--16-Seleccionar el nombre, apellido y departamento de los empleados que no tienen un supervisor asignado.

SELECT nombre, apellido, departamento
FROM empleados
WHERE supervisor IS NULL;

--17-Seleccionar el nombre, apellido y título de trabajo de los empleados cuyo supervisor es el empleado número 2.

SELECT nombre, apellido, titulo_trabajo
FROM empleados
WHERE supervisor = 2;

--18-Seleccionar el nombre, apellido y departamento de los empleados que trabajan en el departamento de "Ventas" o "Marketing".

SELECT nombre, apellido, departamento
FROM empleados
WHERE departamento IN ('Ventas', 'Marketing');

--19-Seleccionar el nombre, apellido y salario de los empleados que ganan más que su supervisor.

SELECT e.nombre, e.apellido, e.salario
FROM empleados AS e
INNER JOIN empleados AS s
ON e.supervisor = s.d
WHERE e.salario > s.salario;

--20-Seleccionar el nombre, apellido y fecha de inicio de los empleados que tienen más de 3 años de experiencia y trabajan en el departamento de "Finanzas".

SELECT nombre, apellido, fecha_inicio
FROM empleados
WHERE departamento = 'Finanzas'
AND experiencia > '3 años';

--21-Mostrar los nombres y apellidos de los empleados que no tienen un supervisor

SELECT nombre, apellido
FROM empleados 
WHERE supervisor is null;


--VAMOS A CREAR UNA TABLA LLAMADA SUPERVISOR;

CREATE TABLE supervisor (
    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    email VARCHAR(100)
);

--VAMOS A INSERTAR REGISTROS EN LA TABLA:

INSERT INTO supervisor (id, nombre, apellido, email) VALUES (1, 'Juan', 'García', 'juan.garcia@company.com');
INSERT INTO supervisor (id, nombre, apellido, email) VALUES (2, 'Maria', 'Fernández', 'maria.fernandez@company.com');
INSERT INTO supervisor (id, nombre, apellido, email) VALUES (3, 'Pedro', 'Martínez', 'pedro.martinez@company.com');
INSERT INTO supervisor (id, nombre, apellido, email) VALUES (4, 'Laura', 'Pérez', 'laura.perez@company.com');


-- CREAR UNA RELACION ENTRE LAS DOS TABLAS: 

ALTER TABLE empleados
ADD FOREIGN KEY (supervisor) REFERENCES supervisor(id);


--verificar la existencia de la tabla utilizando la siguiente consulta:

SELECT * FROM sys.objects WHERE name = 'empleadoS' AND type = 'U'