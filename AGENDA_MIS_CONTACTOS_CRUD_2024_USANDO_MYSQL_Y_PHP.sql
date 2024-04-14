-- Crear la base de datos AGENDA_MIS_CONTACTOS_v2024
CREATE DATABASE IF NOT EXISTS AGENDA_MIS_CONTACTOS_v2024;

-- Usar la base de datos AGENDA_MIS_CONTACTOS_v2024
USE AGENDA_MIS_CONTACTOS_v2024;

-- Crear la tabla CATEGORIA_CONTACTOS
CREATE TABLE IF NOT EXISTS CATEGORIA_CONTACTOS (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre_Categoria VARCHAR(120)
);

-- Crear la tabla GENERO
CREATE TABLE IF NOT EXISTS GENERO (
    id_genero INT PRIMARY KEY,
    genero VARCHAR(15)
);

-- Crear la tabla CONTACTOS
CREATE TABLE IF NOT EXISTS CONTACTOS (
    id_contacto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_contacto VARCHAR(30) NOT NULL,
    apellido_contacto VARCHAR(30) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    id_genero INT NOT NULL,
    telefono VARCHAR(15) NOT NULL, 
    email VARCHAR(30) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL, 
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA_CONTACTOS (id_categoria),
    FOREIGN KEY (id_genero) REFERENCES GENERO (id_genero)
);

-- Mostrar los registros de la tabla CONTACTOS
SELECT * FROM CONTACTOS;

-- Mostrar los registros de la tabla CATEGORIA_CONTACTOS
SELECT * FROM CATEGORIA_CONTACTOS;

-- Mostrar los registros de la tabla GENERO
SELECT * FROM GENERO;


-- HACEMOS INSERCIÓN DE LOS DATOS EN LA TABLA CATEGORIA_CONTACTOS:

INSERT INTO CATEGORIA_CONTACTOS (nombre_categoria) VALUES ('Mis mejores Amigos');
INSERT INTO CATEGORIA_CONTACTOS (nombre_categoria) VALUES ('Mi Familia');
INSERT INTO CATEGORIA_CONTACTOS (nombre_categoria) VALUES ('Compañeros de Estudio');
INSERT INTO CATEGORIA_CONTACTOS (nombre_categoria) VALUES ('Compañeros de Trabajo');
INSERT INTO CATEGORIA_CONTACTOS (nombre_categoria) VALUES ('Mis Estudiantes');
INSERT INTO CATEGORIA_CONTACTOS (nombre_categoria) VALUES ('Amigos de Redes Sociales');

-- HACEMOS UN SELECT PARA LOS GÉNEROS:

SELECT * FROM CATEGORIA_CONTACTOS;

-- Insertaremos datos en la tabla genero

INSERT INTO genero (id_genero, genero) VALUES (1,'Femenino');
INSERT INTO genero (id_genero, genero) VALUES (2,'Masculino');
INSERT INTO genero (id_genero, genero) VALUES (3,'Binario');
INSERT INTO genero (id_genero, genero) VALUES (4,'No definido');

-- HACEMOS UN SELECT PARA LOS GÉNEROS:

SELECT * FROM GENERO;

-- HACEMOS INSERCIÓN DE LOS DATOS EN LA TABLA CONTACTOS:

INSERT INTO CONTACTOS (nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email, direccion, id_categoria)
VALUES ('JUANCITO', 'PEÑA', '1988-09-14', 2, '809-111-0001', 'JUANCITO@EMAIL.COM', 'C/SIEMPRE FELIZ, # 2021', 1); 

INSERT INTO CONTACTOS (nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email, direccion, id_categoria)
VALUES ('DARIEL', 'VAZQUEZ', '2021-09-11', 2, '809-000-00000', 'DARIEL@EMAIL.COM', 'C/VIVO BIEN # 2021', 1); 

INSERT INTO CONTACTOS (nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email, direccion, id_categoria)
VALUES ('DANIELA', 'HICHES', '2016-08-24', 1, '849-222-0000', 'DANIELA@EMAIL.COM', 'C/PRINCESA # 2022', 1); 

INSERT INTO CONTACTOS (nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email, direccion, id_categoria)
VALUES ('MARIA', 'VIZCAINO', '1956-10-05', 1, '809-0101-0101', 'MARIA@EMAIL.COM', 'C/MADRE Y SEÑORA # 2021', 1); 

INSERT INTO CONTACTOS (nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email, direccion, id_categoria)
VALUES ('ELIESER', 'G. P', '2005-02-04', 2, '809-551-1001', 'BRAYAN@EMAIL.COM', 'C/JUEGOS Y MAS JUEGOS # 2021', 3); 

INSERT INTO CONTACTOS (nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email, direccion, id_categoria)
VALUES ('VICENTE', 'MIGUEL', '1985-05-20', 2, '849-558-8977', 'JUPITER@EMAIL.COM', 'C/UNIVERSO, Y GALAXIA # 2021', 4); 

INSERT INTO CONTACTOS (nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email, direccion, id_categoria)
VALUES ('MARLENYS', 'PANIAGUA', '1998-09-04', 1, '829-789-7894', 'MARLENYS@EMAIL.COM', 'C/NETFLIX TEMPORADA # 2', 3); 

INSERT INTO CONTACTOS (nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email, direccion, id_categoria)
VALUES ('NOMBRE ACTUALIZAR', 'ACTUALIZAR', '1995-05-13', 2, '809-895-5214', 'ACTUALIZAR@EMAIL.COM', 'AV. LA VIDA ES BELLA # 2021', 3); 

INSERT INTO CONTACTOS (nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email, direccion, id_categoria)
VALUES ('NOMBRE A BORRAR', 'BORRAR', '1999-01-14', 1, '829-789-7894', 'BORRAR@EMAIL.COM', 'C/BORRAR # 2', 4);

-- Agregar 5 registros más:

INSERT INTO CONTACTOS (nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email, direccion, id_categoria)
VALUES ('LORENA', 'HICHES', '1990-03-20', 2, '809-123-4567', 'lorena.hiches@email.com', 'C/ALAMEDA #123', 1);

INSERT INTO CONTACTOS (nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email, direccion, id_categoria)
VALUES ('CARLOS', 'PEREZ', '1980-07-15', 1, '809-987-6543', 'carlos.perez@email.com', 'C/PRINCIPAL #456', 2);

INSERT INTO CONTACTOS (nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email, direccion, id_categoria)
VALUES ('ANA', 'GARCIA', '1975-11-25', 2, '809-456-7890', 'ana.garcia@email.com', 'C/OLIMPO #789', 3);

INSERT INTO CONTACTOS (nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email, direccion, id_categoria)
VALUES ('PEDRO', 'RODRIGUEZ', '1988-04-30', 1, '809-333-5555', 'pedro.rodriguez@email.com', 'C/CASTILLO #101', 4);

INSERT INTO CONTACTOS (nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email, direccion, id_categoria)
VALUES ('FERNANDA', 'SANCHEZ', '1995-12-10', 2, '809-876-5432', 'fernanda.sanchez@email.com', 'C/ROBLE #202', 1);




