--crear una base de datos SECCION-PDM:
create database LOGIN_CRUD_2023
GO

--USAR ESA BASE DE DATOS:
USE LOGIN_CRUD_2023
GO

/*
Para crear una tabla de usuarios en SQL Server con una relación a una tabla de roles
, y agregar registros a ambas tablas, puedes usar los siguientes comandos SQL:

*/

-- Creación de tabla de roles
CREATE TABLE roles (
    id_rol INT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL
);

select * from roles

-- Creación de tabla de usuarios
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    id_rol INT NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

select * from usuarios

-- Insertando registros en tabla de roles
INSERT INTO roles (id_rol, nombre_rol) VALUES (1, 'administrador');
INSERT INTO roles (id_rol, nombre_rol) VALUES (2, 'supervisor');
INSERT INTO roles (id_rol, nombre_rol) VALUES (3, 'vendedor');

-- Insertando registros en tabla de usuarios
INSERT INTO usuarios (id_usuario, nombre_usuario, password, id_rol) VALUES (1, 'JUANCITO', 'ADMIN@123', 1);
INSERT INTO usuarios (id_usuario, nombre_usuario, password, id_rol) VALUES (2, 'DARIEL', 'DARIEL@123', 2);
INSERT INTO usuarios (id_usuario, nombre_usuario, password, id_rol) VALUES (3, 'DANIELA', 'DANIELA@123', 3);
INSERT INTO usuarios (id_usuario, nombre_usuario, password, id_rol) VALUES (4, 'MARIA', 'MARIA@123', 1);
INSERT INTO usuarios (id_usuario, nombre_usuario, password, id_rol) VALUES (5, 'YENNEFER ', 'YENNEFER@123', 2);

-- Consultas básicas

-- Seleccionar todos los registros de la tabla de roles
SELECT * FROM roles;

-- Seleccionar todos los registros de la tabla de usuarios
SELECT * FROM usuarios;


--CREAMOS UNA TABLA
create table Estudiantes(
id_estudiante int not null,
nombre_user varchar(20) not null,
apellido varchar(20) not null,
telefono varchar(30) not null,
email varchar(30)not null
);
go

--insertamos los datos en la tabla:

insert into Estudiantes values (1,'JUANCITO','PEÑA','809-767-9290','JUANCITO@GMAIL.COM');

--consultamos los datos en la tabla:

select * from Estudiantes;


-- Seleccionar un registro específico de la tabla de roles
SELECT * FROM roles WHERE id_rol = 2;

-- Seleccionar un registro específico de la tabla de usuarios
SELECT * FROM usuarios WHERE id_usuario = 4;

-- Consultas avanzadas

-- Seleccionar todos los usuarios y sus roles
SELECT usuarios.*, roles.nombre_rol
FROM usuarios
INNER JOIN roles ON usuarios.id_rol = roles.id_rol;

-- Seleccionar los usuarios que tengan un rol específico
SELECT * FROM usuarios WHERE id_rol = 3;

-- Contar la cantidad de usuarios por cada rol
SELECT roles.nombre_rol, COUNT(usuarios.id_usuario) AS cantidad_usuarios
FROM usuarios
INNER JOIN roles ON usuarios.id_rol = roles.id_rol
GROUP BY roles.nombre_rol;

-- Actualizar un registro en la tabla de roles
UPDATE roles SET nombre_rol = 'administrador principal' WHERE id_rol = 1;

-- Eliminar un registro en la tabla de usuarios
DELETE FROM usuarios WHERE id_usuario = 4;

SELECT * FROM usuarios;
SELECT * FROM roles;