--crear una base de datos SECCION-PDM:
create database LOGIN_2023
GO

--USAR ESA BASE DE DATOS:
USE LOGIN_2023
GO

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


--CREAMOS UNA TABLA
create table usuario(
id_usuario int not null,
nombre_user varchar(20) not null,
telefono varchar(30) not null,
email varchar(30)not null
);
go

--insertamos los datos en la tabla:

insert into usuario values (1,'JUAN','809-777-7777','JUAN@EMAIL.COM');

--consultamos los datos en la tabla:

select * from usuarios;
select * from roles;
select * from usuario;



SELECT id_usuario, id_rol FROM usuarios WHERE nombre_usuario='JUANCITO'