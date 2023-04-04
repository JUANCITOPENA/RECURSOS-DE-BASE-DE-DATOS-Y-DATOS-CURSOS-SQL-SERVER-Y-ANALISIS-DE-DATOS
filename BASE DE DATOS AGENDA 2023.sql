--CREAR UNA BASE DE DATOS:
CREATE DATABASE AGENDA_CONTACTOS_V4_2023;
GO

--USAR LA BASE DE DATOS CREADA:
USE AGENDA_CONTACTOS_V4_2023;
go

--CREAR UNA TABLA CATEGORIA_CONTACTOS:

CREATE TABLE CATEGORIA_CONTACTOS(
id_categoria int primary key identity(1,1),
nombre_categoria varchar(100)
)

--HACEMOS EL SELECT
select * from CATEGORIA_CONTACTOS

--CREAR UNA TABLA GENERO

CREATE TABLE GENERO(
id_genero int primary key identity(1,1),
nombre varchar(20) not null
)

--HACEMOS EL SELECT
select * from GENERO

--CREAR UNA TABLA contactos

CREATE TABLE CONTACTOS(
id_contacto  int primary key identity(1,1),
nombre_contacto varchar(30) not null,
apellido_contacto varchar(30) not null,
fecha_nacimiento date not null,
id_genero int not null,
telefono varchar(15) not null, 
email varchar(30) not null,
direccion varchar(100) not null,
id_categoria int not null, 
FOREIGN KEY (id_categoria) REFERENCES CATEGORIA_CONTACTOS (id_categoria),
FOREIGN KEY (id_genero) REFERENCES genero (id_genero),
);

--HACEMOS EL SELECT
select * from CONTACTOS

--HACEMOS EL SELECT
select * from CATEGORIA_CONTACTOS

--HACEMOS INSERCION DE LOS DATOS EN LA TABLA CATEGORIA_CONTACTOS:

insert into CATEGORIA_CONTACTOS values('Mis mejores Amigos');
insert into CATEGORIA_CONTACTOS values('MI Familia');
insert into CATEGORIA_CONTACTOS values('Compañeros de Estudio');
insert into CATEGORIA_CONTACTOS values('Compañeros de Trabajo');


--HACEMOS UN SELECT PARA LOS GENEROS:

SELECT * FROM CATEGORIA_CONTACTOS

--insertateremos datos en la tabla genero

insert into genero values ('Femenino');
insert into genero  values ('Masculino');

--HACEMOS UN SELECT PARA LOS GENEROS:

SELECT * FROM GENERO

--HACEMOS INSERCION DE LOS DATOS EN LA TABLA CONTACTOS:

INSERT INTO CONTACTOS(nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email,direccion, id_categoria)
VALUES ('JUANCITO','PEÑA','1985-06-24','2','809-111-0001','JUANCITO@EMIAL.COM','C/SIEMPRE FELIZ, # 2021','1'); 
INSERT INTO CONTACTOS(nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email,direccion, id_categoria)
VALUES ('DARIEL','VAZQUEZ','2021-09-11','2','809-000-00000','DARIEL@EMIAL.COM','C/VIVO BIEN # 2021', '1'); 
INSERT INTO CONTACTOS(nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email,direccion, id_categoria)
VALUES ('DANIELA','HICHEZ','2016-08-24','1','849-222-0000','DANIELA@EMIAL.COM','C/PRINCESA # 2022', '1'); 
INSERT INTO CONTACTOS(nombre_contacto, apellido_contacto, fecha_nacimiento,  id_genero,telefono,email,direccion, id_categoria)
VALUES ('MARIA','VIZCAINO','1956-10-05','1','809-0101-0101','MARIA@EMIAL.COM','C/MADRE Y SEÑORA # 2021', '1'); 
INSERT INTO CONTACTOS(nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero,  telefono, email, direccion, id_categoria)
VALUES ('ELIESER','G. P','2005-02-04','2','809-551-1001','BRAYAN@EMIAL.COM','C/JUEGOS Y MAS JUEGOS # 2021', '3'); 
INSERT INTO CONTACTOS(nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email,direccion, id_categoria)
VALUES ('VICENTE','MIGUEL','1985-05-20','2','849-558-8977','JUPITER@EMIAL.COM','C/UNIVERSO, Y GALAXIA # 2021', '4'); 
INSERT INTO CONTACTOS(nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email,direccion, id_categoria)
VALUES ('MARLENYS','PANIAGUA','1998-09-04','1','829-789-7894','MARLENYS@EMIAL.COM','C/NETFLIX TEMPORADA # 2', '3'); 
INSERT INTO CONTACTOS(nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email,direccion, id_categoria)
VALUES ('NOMBRE ACTUALIZAR','ACTUALIZAR','1995-05-13','2','809-895-5214','ACTUALIZAR@EMIAL.COM','AV. LA VIDA ES BELLA # 2021', '3'); 
INSERT INTO CONTACTOS(nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email,direccion, id_categoria)
VALUES ('NOMBRE A BORRAR','BORRAR','1999-01-14','1','829-789-7894','BORRAR@EMIAL.COM','C/BORRAR # 2', '4');
INSERT INTO CONTACTOS(nombre_contacto, apellido_contacto, fecha_nacimiento, id_genero, telefono, email,direccion, id_categoria)
VALUES ('NOMBRE A BORRAR','BORRAR','1999-01-14','1','829-789-7894','BORRAR@EMIAL.COM','C/BORRAR # 2', '2');

--HACEMOS USO DE LA SIGUIENTE SENTENCIA DEL CRUD, EN ESTE CASO DEL READ -> QUE ES UN SELECT EL CUAL PUEDE ESTAR COMDICIONADO O NO.

select * from CONTACTOS
select * from CATEGORIA_CONTACTOS
SELECT * FROM GENERO

--PODEMOS HACER SELECT CON FILTRO POR EJEMPLO EL QUE TRAIGA EL CONTACTO CODIGO # 4

select * from CONTACTOS where id_contacto='4'

--PODEMOS HACER SELECT CON FILTRO POR EJEMPLO EL QUE TRAIGA EL CONTACTO CUYO NOMBRE SEA IGUAL MARLENYS

select * from CONTACTOS where nombre_contacto='MARLENYS'

--MUESTRAME SOLO EL NOMBRE Y LOS APELLIDO DE LOS CONTACTOS:

select nombre_contacto, apellido_contacto from CONTACTOS 

-- CUENTAME CUANTOS REGISTROS TENGO EN MI TABLA DE CONTACTOS;

select count(*) as [Total Contactos] from CONTACTOS

--CUANTOS CONTACTOS SON FEMENINOS - MUJER:

select count(*) as 'Total Contactos Femeninos' from CONTACTOS where id_genero='1'

select * from CONTACTOS

--CUANTOS CONTACTOS SON MASCULINO - HOMBRE:

select count(*) as 'Total Contactos Masculino' from CONTACTOS where id_genero='2'

--MOSTRAR LOS CONTACTOS CUYO NOMBRE CONTENGA LA LETRA N

select * from CONTACTOS where nombre_contacto like 'N%'

--#-MOSTRAR EL NOMBRE, APELLIDO  TELEFONO, EMAIL, CUANTO AÑOS DE EDAD TINENEN LOS CONTACTOS

SELECT nombre_contacto, apellido_contacto, fecha_nacimiento, telefono, email,
DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) AS 'Edad'
FROM CONTACTOS

--VAMOS AHORA HACER USO DEL UPDATE, ES DECIR ACTUALIZAR UN CAMPO O REGISTRO DE UNA TABLA: COMO EJEMPLO EL ID 2
UPDATE CONTACTOS SET fecha_nacimiento ='2001-09-11'  WHERE id_contacto='2'

UPDATE CONTACTOS SET fecha_nacimiento ='2001-09-11'  WHERE id_contacto='2'

UPDATE CONTACTOS SET fecha_nacimiento ='1993-2-04'  WHERE id_contacto='5'

--PODEMOS ACTUALIZAR TODOS SUS DATOS AGREGANDO ENTRE CADA DATO UNA COMA:

UPDATE CONTACTOS SET nombre_contacto ='LORENA', apellido_contacto='HERNANDEZ', email='LORENA@GMAIL.COM'  WHERE id_contacto='8'

--AHORA VAMOS A UTILIZAR POR ULTIMO EL ULTIMO COMANDO DELETE, EL CUAL BORRA EL REGISTRO INDICADO O TODOS LOS REGISTROS SINO ESPECIFICAMOS.

delete from CONTACTOS WHERE id_contacto='9'

select * from  CONTACTOS

--HACER UNA CONSULTA QUE ME TRAIGA EL CODIGO, NOMBRE, TELEFONO, CATEGORIA DE AMIGO CON EL NOMBRE, POR MEDIO DE UN JOIN.

select id_contacto, nombre_contacto, apellido_contacto, G.nombre AS Genero, telefono, fecha_nacimiento, email, CC.nombre_categoria as 'Categoria de Contacto',
DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) as [Años de Edad]
from CONTACTOS CT join CATEGORIA_CONTACTOS CC 
ON CT.id_categoria = CC.id_categoria
JOIN GENERO G
ON G.id_genero=CT.id_genero


--MOSTRAR EL NOMBRE, APELLIDO, TELEGONO, EMAIL, Y DE LOS CONTACTOS QUE SEAN MAYORES DE 30 AÑO.
select nombre_contacto, apellido_contacto, telefono, email,
DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) as [Años de Edad]
from CONTACTOS C
join CATEGORIA_CONTACTOS CT
on C.id_categoria = CT.id_categoria
where DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) <=30
order by [Años de Edad] desc

--VAMOS A CREAR UNA VISTA CON LOS DATOS EXTRAIDOS:
create or alter view vista_contactos
as
select id_contacto, nombre_contacto, apellido_contacto, G.nombre AS Genero, telefono, fecha_nacimiento, email, CC.nombre_categoria as 'Categoria de Contacto',
DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) as [Años de Edad]
from CONTACTOS CT join CATEGORIA_CONTACTOS CC 
ON CT.id_categoria = CC.id_categoria
JOIN GENERO G
ON G.id_genero=CT.id_genero
go

--LLAMAMOS NUESTRA VISTA CREAD:

select * from vista_contactos