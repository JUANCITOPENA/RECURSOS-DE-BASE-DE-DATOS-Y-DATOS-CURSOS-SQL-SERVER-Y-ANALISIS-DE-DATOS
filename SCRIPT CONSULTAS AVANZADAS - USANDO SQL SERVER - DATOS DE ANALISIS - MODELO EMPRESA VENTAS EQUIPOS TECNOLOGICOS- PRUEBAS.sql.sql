
--USAMOS LA BASE DE DATOS MODELODATOS_VENTAS:

--USAMOS LA BASE DE DATOS DCD02:
use  EJEMPLO_DCD_1050_ENERO_ABRIL_2023_V1;
go

--Mostrar Todos los Objetos de una base de datos de SQL Server:

SELECT CAST(table_name as varchar)  FROM INFORMATION_SCHEMA.TABLES

--Mostrar todas las tablas de una base de datos de SQL Ser

Select name from sysobjects where type='U' 


--VER IDIOMA DE MI SQL SERVER:
SELECT @@LANGUAGE AS IDIOMA
--CAMBIAMOS IDIOMA DEPENDIENDO:
SET LANGUAGE SPANISH
SET LANGUAGE ENGLISH

--VER LOS FORMATOS DE FECHA Y HORAS Y FECHA NORMAL EN MI SQL:4

select SYSDATETIME() as fecha, SYSUTCDATETIME() as fecha, CAST(getdate() as date) as Fecha_Normal

--Todas las Tablas creadas y sus Registros"

select * from departamento
select * from empleados
select * from genero
select * from Cliente
select * from vendedor
select * from supervisor
select * from Productos
select * from categoria_producto
select * from region
select * from sucursal
select * from ciudad
select * from condicion_factura
select * from Ventas_Hechos
select * from Estatus_Facturas
select * from Dias_factura
select * from Fotos_supervisor
select * from Fotos_productos
select * from Fotos_vendedor

--En este caso concedemos permisos al usuario sa.

ALTER AUTHORIZATION ON DATABASE::EJEMPLO_DCD_1050_ENERO_ABRIL_2023_V1 TO JUANCITO

EXEC dbo.sp_changedbowner @loginame = N'JUANCITO', @map = false

--VAMOS A RESPONDER LAS PREGUNTAS QUE NOS HACEN DE ANALISIS DE DATOS EN NUESTRA BASE DATOS.

---RRHH 

--MOSTRAR LOS DEPARTAMENTOS:

select * from departamento

--MOSTRAR EL DEPARTAMENTO 1003:

select * from departamento where id_departamento=1003

--MOSTRAR E; DEPARTAMENTO DE TECNOLOGIA:

select * from departamento where nombre_departamento='ventas'

--MOSTRARME EL TOTAL DE DEPARTAMENTOS

select count(*) as 'Total Departamentos 1' from departamento

--MOSTRARME LOS EMPLEADOS:

SELECT * FROM empleados

--MOSTRAR LA CANTIDAD DE EMPLEADOS Y EL TOTAL DE SUELDOS PAGADOS:

select count(*) as 'Total de Empleados',  sum(sueldo) as 'Total Sueldos', avg(sueldo) as 'Sueldo Promerio' from empleados

--MOSTRAR LA CANTIDAD DE EMPLEADOS DEL DEPARTAMENTO DE VENTAS Y EL TOTAL DE SUELDOS PAGADOS:

select count(*) as 'Total de Empleados',  sum(sueldo) as 'Total Sueldos' from empleados where id_departamento='1003'

--MOSTRAR LA CANTIDAD DE EMPLEADOS DEL DEPARTAMENTO DE VENTAS QUE SEAN FEMENINOS Y EL TOTAL DE SUELDOS PAGADOS:

select * from genero

select count(*) as 'Total de Empleados Femeninos en Ventas',  sum(sueldo) as 'Total Sueldos' from empleados where id_departamento='1003' and id_genero='1'

--MOSTRAR LA CANTIDAD DE EMPLEADOS DEL DEPARTAMENTO DE VENTAS QUE SEAN MASCULONOS Y EL TOTAL DE SUELDOS PAGADOS:

select count(*) as 'Total de Empleados Masculinos en Ventas',  sum(sueldo) as 'Total Sueldos' from empleados where id_departamento='1003' and id_genero='2'

--MOSTRAR LA CANTIDAD DE EMPLEADOS DEL DEPARTAMENTO  QUE SEAN MASCULONOS Y EL TOTAL DE SUELDOS PAGADOS:

select count(*) as 'Total de Empleados Femenino',  sum(sueldo) as 'Total Sueldos' from empleados where id_genero='1'

--MOSTRAR LA CANTIDAD DE EMPLEADOS DEL DEPARTAMENTO  QUE SEAN MASCULONOS Y EL TOTAL DE SUELDOS PAGADOS:

select count(*) as 'Total de Empleados Masculino',  sum(sueldo) as 'Total Sueldos' from empleados where id_genero='2'

--POR MEDIO DE UNA SUB-CONSULTA -MOSTRAR EL NOMBRE, LA POSICION Y  
--SUELDO MAXIMO Y MINIMO DE LOS EMEPLEADOS:

SELECT nombre, posicion, sueldo 
FROM   EMPLEADOS 
WHERE  sueldo IN(SELECT Max(sueldo)  
                 FROM   EMPLEADOS 
                 UNION ALL 
                 SELECT Min(sueldo) 
                 FROM   EMPLEADOS) 
				
--POR MEDIO DE UN JOIN --MOSTRAR EL NOMBRE, LA POSICION Y  SUELDO MAXIMO Y MINIMO DE LOS EMEPLEADOS:

 SELECT nombre, posicion, sueldo  
FROM   EMPLEADOS E 
       INNER JOIN (SELECT Max(sueldo) AS max_min_sal 
                   FROM   EMPLEADOS 
                   UNION 
                   SELECT Min(sueldo) 
                   FROM   EMPLEADOS) A 
               ON A.max_min_sal = E.sueldo 


--# MOSTRAR EL TOP 10 DE MAYORES SUELDO MOSTRANDO EL NOMBRE DEL DEL DEPARTAMENTO,
--NOMBRE DEL EMPLEADO Y
-- EL SUELDO QUE COBRA- --HAGA USO DE JOIN EN LAS DOS TABLAS.

select TOP 5  D.nombre_departamento, E.nombre, e.sueldo
from empleados e
inner JOIN departamento d
on d.id_departamento = e.id_departamento 
join genero g
on g.id_genero = e.id_genero
GROUP BY D.nombre_departamento, E.Nombre ,e.sueldo
ORDER BY sueldo DESC


--MOSTRAR LOS EMPLEADOS CONTRATADOS DEL PRIMERO DE ENERO 2018 AL 31 DE DICIEMBRE DEL 2022: 
-- HAGA USO DE LA FUNCION WHERE Y BETWEEN:

SELECT * FROM empleados WHERE fecha_entrada BETWEEN '01/01/2018' AND '31/12/2018'; 

--MOSTRAR LOS EMPLEADOS CUYA CONTRATACION SE REALIZO ENTRE LOS AÑOS 2018 AL 2022:
--MOSTRAR CODIGO, NOMBRE, NIVEL ACADEMICO, SUELDO, POSICION, FECHA DE ENTRADA, DEPARTAMENTO
--Y EL ESTATUS DEL EMPLEADO ,HACIENDO USO DE JOIN Y DE LA FUNCION WHERE Y AND Y DE LOS OPERADORES (>= Y <)

SELECT e.id_empleados as 'Codigo', e.nombre as 'Empleado', e.nivel_academico as 'Nivel Acamico',
e.sueldo as 'Sueldo', e.posicion as 'Posicion', e.fecha_entrada as 'Fecha de Contratacion',
e.id_Departamento as 'Codigo Departamento', 
d.nombre_departamento as 'Nombre Departamento', st.Status_empleado
FROM empleados e
INNER JOIN departamento d ON
e.id_Departamento = d.id_Departamento
INNER JOIN status_empleado st
on e.id_status_empleado = st.id_status_empleado
WHERE fecha_entrada>='01/01/2018' AND fecha_entrada<'31/12/2022'; 


--# MOSTRAR EL CODIGO DEL DEPARTALOS DEPARTAMENTOS, NOMBRE DEL DEPARTAMENTO Y NOMBRE DEL EMPLEADOS
--HAGO USO DEL JOIN ENTRE AMBAS TABLAS, MOSTRAR LOS RESULTADOS EN ORDEN ASCENDENTE:

SELECT e.id_Departamento as 'Codigo Departamento', 
d.nombre_departamento as 'Nombre Departamento', 
e.Nombre as 'Nombre Empleado'
FROM empleados e
INNER JOIN departamento d ON
e.id_Departamento = d.id_Departamento
--GROUP BY e.nombre_departamento, e.Nombre 
Order by d.id_Departamento  asc

--# MOSTRAR EL NOMBRE DEL DEL DEPARTAMENTO, NOMBRE DEL EMPLEADO Y EL SUELDO QUE COBRA-
--HAGA USO DE JOIN EN LAS DOS TABLAS.

select D.nombre_departamento, E.nombre, e.sueldo
from empleados e
JOIN departamento d
on d.id_departamento = e.id_departamento 
join genero g
on g.id_genero = e.id_genero
ORDER BY sueldo DESC

--# MOSTRAR EL CODIGO DEL DEPARTAMENTOS, NOMBRE DEPARTAMETO, EMPLEADOS, POSICION , SUELDO Y GENERO.
--HAGA USO DE JOIN.

select d.id_departamento, nombre_departamento, 
e.nombre, e.posicion, e.sueldo, g.genero
from empleados e
JOIN departamento d
on d.id_departamento = e.id_departamento 
join genero g
on g.id_genero = e.id_genero


--#-MOSTRAR EL CODIGO, DEPARTAMENTO, EMPLEADOS Y SUS SUELDOS CON ALIAS

SELECT e.id_Departamento as 'Codigo Departamento', 
d.nombre_departamento as 'Nombre Departamento', 
e.Nombre as 'Nombre Empleado', e.sueldo
FROM empleados e
INNER JOIN departamento d ON
e.id_Departamento = d.id_Departamento
GROUP BY e.id_departamento, d.nombre_departamento, e.Nombre, e.sueldo
order by sueldo desc

--# -MOSTRAR LOS DEPARTAMENTOS Y LOS EMPLEADOS Y SUS SUELDOS DONDE EL DEPARTAMENTO SEA ADMINISTRACION Y SU POSICION.

SELECT e.id_Departamento as 'Codigo Departamento', id_empleados,
d.nombre_departamento as 'Nombre Departamento', 
e.Nombre as 'Nombre Empleado', e.sueldo as 'Sueldo RD$', e.posicion as 'Posicion Actual'
FROM empleados e
INNER JOIN departamento d ON
e.id_Departamento = d.id_Departamento
where d.nombre_departamento='VENTAS'
GROUP BY e.id_departamento, d.nombre_departamento,id_empleados, e.Nombre, e.sueldo, e.posicion
order by sueldo desc

SELECT * FROM vendedor

--# -MOSTRAR LOS DEPARTAMENTOS Y LOS EMPLEADOS Y SUS SUELDOS DONDE EL DEPARTAMENTO SEA VENTAS Y SU POSICION.

SELECT e.id_Departamento as 'Codigo Departamento', 
d.nombre_departamento as 'Departamento', 
e.Nombre as 'Empleado', e.sueldo as 'Sueldo RD$', e.posicion as 'Posicion Actual'
FROM empleados e
INNER JOIN departamento d ON
e.id_Departamento = d.id_Departamento
where nombre_departamento = 'ventas'
GROUP BY e.id_departamento, d.nombre_departamento, e.Nombre, e.sueldo, e.posicion
Order by SUM(sueldo) desc

--# -CUANTOS EMPLEADOS SON HOMBRES Y CUALES SON SUS SUELDOS

SELECT e.id_Departamento as 'Codigo Departamento', 
d.nombre_departamento as 'Departamento', 
e.id_empleados,
e.Nombre as 'Empleado', e.sueldo, g.genero, e.posicion
FROM empleados e
INNER JOIN departamento d ON
e.id_Departamento = d.id_Departamento
join genero g on g.id_genero = e.id_genero
where g.genero = 'masculino'
GROUP BY e.id_departamento, d.nombre_departamento,e.id_empleados, e.Nombre, e.sueldo, g.genero , e.posicion
Order by SUM(e.sueldo) desc

--# -CUANTOS EMPLEADOS SON MUJERES, A QUE DEPARTAMENTO PERTENECEN Y CUALES SON SUS SUELDOS

SELECT d.nombre_departamento as 'Departamento', e.id_empleados,
e.Nombre as 'Empleado', e.sueldo, g.genero, e.posicion
FROM empleados e
INNER JOIN departamento d ON
e.id_Departamento = d.id_Departamento
join genero g on g.id_genero = e.id_genero
where g.genero = 'femenino'
and d.id_departamento='1003'
GROUP BY e.id_departamento, d.nombre_departamento,
e.id_empleados,e.Nombre, e.sueldo, g.genero , e.posicion
Order by SUM(e.sueldo) desc

--#-CUANTOS EMPLEADOS SON MUJERES, Y PERTENEZCAN AL DEPARTAMENTO DE VENTAS Y CUAL ES SU SUELDO

SELECT e.id_departamento,d.nombre_departamento as 'Departamento',  e.id_empleados, 
e.Nombre as 'Empleado', e.sueldo, g.genero ,e.posicion
FROM empleados e
INNER JOIN departamento d ON
e.id_Departamento = d.id_Departamento
join genero g on g.id_genero = e.id_genero
where g.genero = 'femenino'
and d.nombre_departamento='ventas'
GROUP BY e.id_departamento, d.nombre_departamento,e.id_empleados, e.Nombre, e.sueldo, g.genero ,e.posicion
Order by SUM(E.id_empleados) desc

SELECT * FROM vendedor


--#-CUANTOS EMPLEADOS SON HOMBRES, Y PERTENEZCAN AL DEPARTAMENTO DE VENTAS Y CUAL ES SU SUELDO

SELECT e.id_departamento,d.nombre_departamento as 'Departamento',  e.id_empleados,
e.Nombre as 'Empleado', e.sueldo, g.genero, e.posicion
FROM empleados e
INNER JOIN departamento d ON
e.id_Departamento = d.id_Departamento
join genero g on g.id_genero = e.id_genero
where g.genero = 'masculino'
and d.nombre_departamento='ventas'
and e.posicion ='vendedor'
GROUP BY e.id_departamento, d.nombre_departamento,e.id_empleados, e.Nombre, e.sueldo, g.genero ,e.posicion
Order by SUM(e.sueldo) desc

select * from empleados
select * from genero

--#-CUANTO TIEMPO TINENEN LOS EMPLEADOS EN LA EMPRESA: 
--HAGA USO DE LA FUNCIONES DE FECHA DATEDIFF, GETDATE.

select * from empleados

select nombre as [Empleado], posicion, sueldo,
DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) as [Años de Edad]
from
empleados
--where nombre='YENNIFER LOMBAR'
order by [Años de Edad] desc


--REALIZAR UNA CONSULTA QUE MUESTRE NOMBRE, POSICION, SUELDO, FECHA DE NACIMIENTO, FECHA DE ENTRADA,
--AÑOS DE EDAD Y ÑOS EN LA EMPRES DE LOS EMPLEADOS: HAGA USO DE LA FUNCIONES DE FECHA DATEDIFF, GETDATE.

select nombre as [Empleado], posicion, sueldo, fecha_nacimiento,fecha_entrada,
DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) as 'Años de Edad',
DATEDIFF(YEAR, fecha_entrada, GETDATE()) as [Años en la Empresa]
from empleados
order by fecha_nacimiento asc

--#-CUALES EMPLEADOS TIENEN MAS DE 45 AÑOS DE EDAD"
--HAGA USO DE LA FUNCIONES DE FECHA DATEDIFF, GETDATE.

select nombre as [Empleado], posicion, sueldo,fecha_nacimiento,fecha_entrada,
DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) as [Años de Edad]
from empleados 
where DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) >45
ORDER by [Años de Edad] desc

--#-CUALES EMPLEADOS TIENEN MENOS DE 45 AÑOS DE EDAD"
--HAGA USO DE LA FUNCIONES DE FECHA DATEDIFF, GETDATE.

select nombre as [Empleado], posicion, sueldo,fecha_nacimiento,fecha_entrada,
DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) as [Años de Edad]
from empleados 
where DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) <45
--and  nombre='ULTIMO FERNADEZ'
ORDER by [Años de Edad] desc


--#-CUALES EMPLEADOS TIENEN MENOS DE 30 AÑOS DE EDAD"

select nombre as [Empleado], posicion, sueldo,fecha_nacimiento,fecha_entrada,
DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) as [Años de Edad]
from empleados 
where DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) <30
ORDER by [Años de Edad] desc


/*
TAREA PARA RESOLVER EN SQL SERVER :

1-Muestra los empleados que no tiene departamento.
2-Mostrar las personas contratadas el día de la semana que se introduce por pantalla.
3-Muestra los empleados con su salario incrementado según la comisión.
4-Muestra los empleados que tengan un salario mayor al que se introduce por 
  pantalla en el momento de ejecución. Ordena el resultado por el salario.

*/

SELECT * FROM departamento CROSS JOIN empleados

SELECT * FROM departamento
SELECT * FROM empleados

---22 * 48 = 1056

--# --AHORA VAMOS A PASAR A LA PARTE COMERCIAL, REALIZANDO CONSULTAS PARA LA EMPRESA REALICIONADA A LAS VENTAS

--#-CUALES SON LOS VENDEDORES

select nombre_vendedor from vendedor


--AQUI COMENZAMOS CON LOS ANALISIS DE DATOS ORIENTADOS AL NEGOCIO CON LAS VENTAS, Y TODO LOS PROCESOS.

--#-DAME LAS VENTAS-TOP 10 POR VENDEDOR, CLIENTE, PRODUCTO, CANTIDAD Y MONTO DE LA VENTAS: EN ODERN ASCENDENTE:
--HAGA USO DE LOS JOIN, Y LA FUNCION SUM, CON AGRUPAMIENTOS.

SELECT distinct TOP 10 vd.nombre_vendedor as Vendedores, C.nombre_Negocio AS 'Cliente', p.descripcion as 'Productos'
,vh.cantidad as 'Cantidad', SUM(monto) AS 'Monto de las Ventas'
FROM ventas_hechos vh join vendedor vd
on vh.id_vendedor= vd.id_vendedor
join Productos p
on p.id_producto = vh.id_producto
join cliente c
on c.id_cliente= vh.id_cliente
GROUP BY vd.nombre_vendedor,C.nombre_Negocio, C.nombre_Negocio, p.descripcion,vh.cantidad,(monto) 
Order by SUM(monto) desc

--#-DAME LAS VENTAS-TOP 10 POR VENDEDOR, CLIENTE, PRODUCTO, CANTIDAD Y MONTO DE LA VENTAS:

SELECT distinct TOP 10 vd.nombre_vendedor as Vendedores,c.nombre_Negocio as Clientes ,p.descripcion as Producto, 
    vh.cantidad as Cantidad
   ,SUM(monto) AS Ingresos
FROM ventas_hechos vh join vendedor vd
on vh.id_vendedor= vd.id_vendedor
join Productos p
on p.id_producto = vh.id_producto
join cliente c
on c.id_cliente= vh.id_cliente
GROUP BY vd.nombre_vendedor, c.nombre_Negocio,p.descripcion, vh.cantidad
Order by SUM(monto) desc

select * from Ventas_Hechos

--# - QUE CLIENTES NO ME HAN COMPRADO EN LOS ULTIMOS 20 MESES POR TOP 10?

SELECT  distinct c.nombre_Negocio as Cliente, 
    max(vh.fecha_venta) as 'Fecha Factura',
	max(ef.fecha_pago) as 'Fecha Pago', ef.estatus_Cobrado AS [Status de Cobro],
	DATEDIFF(MONTH, max(vh.fecha_venta), GETDATE()) as [Meses Desde la ultima Factura],
	DATEDIFF(MONTH, max(ef.fecha_pago), GETDATE()) as [Meses Desde el Ultimo Pago]
FROM Ventas_Hechos vh join cliente c
on vh.id_cliente=c.id_cliente
join Estatus_Facturas EF
on vh.No_facturas =ef.No_facturas
GROUP BY c.nombre_Negocio, vh.fecha_venta, ef.estatus_Cobrado
having DATEDIFF(month, max(vh.fecha_venta),GETDATE()) <=18
Order by [Meses Desde la ultima Factura] asc


--#- QMUESTRAME LOS DIAS TRANSCURRIDOS DESDE LA ULTIMA FACTURA HASTA EL ULTIMO PAGO?


-- CUALES CLIENTE NO ME HAN REALIZADO NINGUNA COMPRA :

SELECT * FROM cliente WHERE NOT EXISTS
( SELECT * FROM Ventas_Hechos WHERE Ventas_Hechos.id_cliente = cliente.id_cliente )

-- CUALES CLIENTE NO ME HAN REALIZADO NINGUNA DEUDA :

SELECT * FROM cliente WHERE NOT EXISTS 
( SELECT * FROM Estatus_Facturas WHERE Estatus_Facturas.id_cliente = cliente.id_cliente )


--# - CUANTAS FACTURAS TIENE LOS CLIENTES:

select C.id_cliente, c.nombre_negocio as 'Nombre Cliente',
     (select count(id_cliente) from [Ventas_Hechos] vh
	 where c.id_cliente = vh.id_cliente) as 'Cantidad Facturas'
from [cliente] c
order by [Cantidad Facturas] desc


--MOSTRARME LA CANTIDAd DE FACTURAS, MONTO Y CATIDAD DE PRODUCTOS DEL CLIENTE X = SOLUCONESJPV

select  c.nombre_negocio as 'Nombre Cliente',
     (select count(id_cliente) from [Ventas_Hechos] vh
	 where c.id_cliente = vh.id_cliente) as 'Cantidad Facturas',
	 (select SUM(VH.monto) from [Ventas_Hechos] vh
	 where c.id_cliente = vh.id_cliente) as 'Monto RD$', 
	 (select count(id_producto) from [Ventas_Hechos] vh
	 where c.id_cliente = vh.id_cliente) as 'Cantidad Producto'
from [cliente] c

order by [Cantidad Facturas] desc



select distinct C.nombre_Negocio, VH.cantidad, VH.monto
from Ventas_Hechos VH JOIN cliente C
ON VH.id_cliente= C.id_cliente
group by C.nombre_Negocio, VH.cantidad, VH.monto
HAVING COUNT(c.id_cliente) > 1
order by vh.monto desc



SELECT distinct c.nombre_Negocio, p.descripcion, vh.cantidad, vh.monto
FROM Ventas_Hechos vh
join cliente c on c.id_cliente = vh.id_cliente
join Productos p on p.id_producto = vh.id_producto
WHERE (vh.monto>=1873 OR vh.cantidad>=1 )-- OR vh .monto<=1000.00


SELECT distinct VH.id_cliente, c.nombre_Negocio, p.descripcion, vh.cantidad, vh.monto
FROM cliente C INNER JOIN Ventas_Hechos VH
ON c.id_cliente= vh.id_cliente
inner join Productos p 
on p.id_producto= vh.id_producto
--Where vh.cantidad is null
GROUP BY vh.id_cliente,c.nombre_Negocio, p.descripcion, vh.cantidad, vh.monto
order by VH.id_cliente desc



select id_cliente, count( No_facturas) as RecuentoFacturas, 
sum(Monto) as SumMonto, 
max(fecha_venta) as UltimaFecha 
from Ventas_Hechos
group by id_cliente 
order by id_cliente

select
id_cliente, count(No_facturas) as RecuentoFacturas, sum(Monto) as SumMonto,
datediff(MONTH, max(fecha_venta), '31-12-2021') as UltimaFecha,
NTILE(5) over (order by datediff(MONTH, max(fecha_venta), '31-12-2022') desc) as Calificacion_Fresencia,
NTILE(5) over (order by count( No_facturas)) as Calificacion_Frecuencia,
NTILE(5) over (order by sum (monto)) as Calificacion_Monto
from Ventas_Hechos
group by id_cliente
order by id_cliente



SELECT c.nombre_Negocio, p.descripcion, vh.cantidad, vh.monto
FROM Ventas_Hechos vh
join cliente c on c.id_cliente = vh.id_cliente
join Productos p on p.id_producto = vh.id_producto
WHERE (vh.cantidad <0 ) or (vh.cantidad >=1 ) 

SELECT c.nombre_Negocio, p.descripcion, vh.cantidad, vh.monto
FROM Ventas_Hechos vh
join cliente c on c.id_cliente = vh.id_cliente
join Productos p on p.id_producto = vh.id_producto
WHERE (vh.cantidad <=0 ) and (vh.cantidad >=1 ) 


--MUESTRAME LAS VENTAS POR AÑO Y MONTOS:

SELECT distinct top 166 c.nombre_Negocio as 'Cliente' ,
 CONCAT(YEAR(vh.fecha_venta),'-', MONTH(vh.fecha_venta)) AS AÑO
  ,SUM(vh.monto) AS Ingresos
FROM cliente c join Ventas_Hechos vh
on c.id_cliente= vh.id_cliente
GROUP BY c.nombre_Negocio,vh.monto, vh.fecha_venta
Order by SUM(vh.monto) desc

select * from Ventas_Hechos

SELECT distinct top 20  v.nombre_vendedor, c.nombre_Negocio
  ,SUM(vh.monto) AS Ingresos
FROM cliente c join Ventas_Hechos vh
on c.id_cliente= vh.id_cliente
join vendedor v on v.id_vendedor=vh.id_vendedor
GROUP BY c.nombre_Negocio,v.nombre_vendedor,vh.monto
Order by SUM(vh.monto) desc


--# - DIFERENCIA DE DIAS ENTRE FACTURAS

select b.id_ventas, a.id_cliente, c.nombre_Negocio as 'Cliente', b.fecha_venta as 'Fecha de Ventas',
a.fecha_venta as 'Fecha de Pago', a.monto,
DATEDIFF(day, b.fecha_venta, a.fecha_venta) as [Dias Transcurrido entre Facturas]
from Ventas_Hechos a
inner join Ventas_Hechos b on b.id_ventas = a.id_ventas -1
join cliente c
on c.id_cliente = a.id_cliente
order by b.id_ventas desc


--#- CLASIFICACION DE CLIENTES DE ACUERDO A, B, C, DONDE A >= 300000, B >=200000 Y <300000, C ES < 200000

SELECT distinct  c.nombre_Negocio as Cliente, cantidad
	 ,SUM(monto) AS [Total RD$],
CASE
   WHEN (SUM(vh.cantidad * vh.precio_ventas) >=500000) THEN 'A' 
   WHEN (SUM(vh.cantidad * vh.precio_ventas) < 500000  AND SUM(vh.cantidad * vh.precio_ventas) >= 200000) THEN 'B'
   WHEN (SUM(vh.cantidad * vh.precio_ventas) <200000) THEN 'C'
   END AS 'CATEGORIA A-B-C'
FROM Ventas_Hechos vh join cliente c
on vh.id_cliente=c.id_cliente
join Productos p
on p.id_producto = vh.id_producto
GROUP BY c.nombre_Negocio, cantidad
Order by SUM(monto) desc

--#- CLASIFICACION DE PRODUCTOS DE ACUERDO A, B, C, DONDE A >= 300000, B >=200000 Y <300000, C ES < 200000

SELECT distinct  P.descripcion as Productos, cantidad
	 ,SUM(monto) AS [Total RD$],
CASE
   WHEN (SUM(vh.cantidad * vh.precio_ventas) >=500000) THEN 'A' 
   WHEN (SUM(vh.cantidad * vh.precio_ventas) < 500000  AND SUM(vh.cantidad * vh.precio_ventas) >= 200000) THEN 'B'
   WHEN (SUM(vh.cantidad * vh.precio_ventas) <200000) THEN 'C'
   END AS 'CATEGORIA A-B-C'
FROM Ventas_Hechos vh join cliente c
on vh.id_cliente=c.id_cliente
join Productos p
on p.id_producto = vh.id_producto
GROUP BY P.descripcion , cantidad
Order by SUM(monto) desc


/*
quero de la tabla ventas_hechos, cuales de la tabla cliente no estan esa ella?, es decir no me han comprano nunca:
*/

SELECT c.*
FROM cliente c
LEFT JOIN ventas_hechos vh
ON c.id_cliente = vh.id_cliente
WHERE vh.id_cliente IS NULL

select * from Ventas_Hechos

select * from cliente


SELECT *
FROM sys.tables;

/*
Puedes utilizar una consulta de agrupación y conteo para determinar la cantidad de veces que cada cliente ha comprado. 
*/
SELECT id_cliente, COUNT(id_cliente) AS compras_repetidas
FROM Ventas_Hechos
GROUP BY id_cliente
HAVING COUNT(id_cliente) > 1;


SELECT VH.id_cliente, COUNT(VH.id_cliente) AS compras_repetidas, p.descripcion
FROM Ventas_Hechos VH
INNER JOIN Productos P ON VH.id_producto = P.id_producto
GROUP BY VH.id_cliente, P.descripcion
HAVING COUNT(VH.id_cliente) > 1;

select * from productos
/*
Para determinar cuántas veces los clientes han comprado de manera repetida en SQL Server
*/

SELECT cliente.id_cliente, nombre_Cliente, apellido_Cliente, COUNT(*) AS compras_repetidas
FROM cliente
JOIN Ventas_Hechos ON cliente.id_cliente = Ventas_Hechos.id_cliente
GROUP BY cliente.id_cliente,nombre_Cliente, apellido_Cliente
HAVING COUNT(*) > 1
ORDER BY compras_repetidas DESC;

/*
la tabla cliente tiene  30 clientes y la tabla ventas_Hechos tiene 166 transacciones, dame 
un script que me diga cuales clientes no me han comprado, listado el codigo del cliente, 
nombre, y un campo que diga no ha realizado ninguna compra
*/

SELECT c.id_cliente, c.nombre_Cliente, c.apellido_Cliente, 'No ha realizado ninguna compra' as Compras
FROM cliente c
WHERE c.id_cliente NOT IN (SELECT id_cliente FROM Ventas_Hechos);

/*
 Lista con todos los productos y una columna adicional que indicará si el producto ha sido vendido o no.
*/

SELECT 
  Productos.id_producto, 
  Productos.descripcion, 
  Productos.existencia, 
  Productos.precio_compra, 
  Productos.precio_ventas, 
  Productos.fecha_entrada, 
  Productos.id_categoria, 
  Ventas_Hechos.id_ventas
FROM 
  Productos 
LEFT JOIN 
  Ventas_Hechos 
ON 
  Productos.id_producto = Ventas_Hechos.id_producto
WHERE 
  Ventas_Hechos.id_ventas IS NULL;

SELECT id_producto, descripcion, existencia, fecha_entrada, 'No se ha vendido ni una unidad' AS Mensaje
FROM Productos
WHERE id_producto NOT IN (SELECT id_producto FROM Ventas_Hechos);


--obtener una lista de las categorías de productos y la cantidad de tipos de productos en cada una de ella
SELECT cp.descripcion as Categoia,  COUNT(p.descripcion) as 'Tipos de Productos'
FROM Productos p join categoria_producto cp
on p.id_categoria = cp.id_categoria
--where cp.id_categoria ='1106'
GROUP BY cp.descripcion
ORDER BY COUNT(p.descripcion) DESC;

/*
--muestra la información de cada producto vendido, incluyendo su identificador único "id_producto",
nombre "Nombre_Producto", cantidad total vendida "Cantidad_Vendida", fecha de la venta "fecha_venta"
y el monto total de ventas "Total_Ventas".
*/
SELECT 
  p.id_producto, 
  p.descripcion as Nombre_Producto, 
  sum(vh.cantidad) as Cantidad_Vendida, 
  vh.fecha_venta,
  sum(vh.monto) as Total_Ventas
FROM 
  Productos p
  JOIN Ventas_Hechos vh ON p.id_producto = vh.id_producto
GROUP BY 
  p.id_producto, 
  p.descripcion, 
  vh.fecha_venta


  SELECT
p.id_producto,
p.descripcion as Nombre_Producto,
sum(vh.cantidad) as Cantidad_Vendida,
sum(vh.monto) as Total_Ventas
FROM
Productos p
JOIN Ventas_Hechos vh ON p.id_producto = vh.id_producto
GROUP BY
p.id_producto,
p.descripcion

/*
ealiza una consulta a una base de datos que contiene información de ventas. La consulta tiene como objetivo obtener
la cantidad de productos vendidos, el monto total de ventas y el nombre de la región en la que se realizaron las ventas,
agrupando la información por región
*/

SELECT COUNT(DISTINCT id_producto) as cantidad_productos, SUM(monto) as monto_total, region.nombre
FROM ventas_hechos
JOIN cliente ON ventas_hechos.id_cliente = cliente.id_cliente
JOIN region ON cliente.id_region = region.id_region
GROUP BY region.nombre;


--#- CLASIFICACION DE VENDEDORES DE ACUERDO A, B, C, DONDE A >= 300000, B >=200000 Y <300000, C ES < 200000

SELECT distinct  v.nombre_vendedor as Vendedor
	 ,SUM(monto) AS [Total RD$],
CASE
   WHEN (SUM(vh.cantidad * vh.precio_ventas) >=400000) THEN 'A' 
   WHEN (SUM(vh.cantidad * vh.precio_ventas) < 400000  AND SUM(vh.cantidad * vh.precio_ventas) >= 200000) THEN 'B'
   WHEN (SUM(vh.cantidad * vh.precio_ventas) <200000) THEN 'C'
   END AS 'CATEGORIA A-B-C'
FROM Ventas_Hechos vh join vendedor v
on vh.id_vendedor= v.id_vendedor
join Productos p
on p.id_producto = vh.id_producto
GROUP BY v.nombre_vendedor
Order by SUM(monto) desc

--#-Mostrar los vendedor con porcentajes 25% 50% 75% y 100%
select top 100 percent * from vendedor

--#- DAME LAS VENTAS TOP 10 -POR REGION, VENDEDOR, PRODUCTO, CANTIDAD Y MONTO:

SELECT r.nombre as Region, vd.nombre_vendedor as Vendedor, p.descripcion as Producto, vh.cantidad
   ,SUM(vh.monto) AS 'Total RD$'
FROM ventas_hechos vh join vendedor vd
on vh.id_vendedor= vd.id_vendedor
join Productos p
on p.id_producto = vh.id_producto
join region r
on r.id_region = vh.id_region
--where vd.nombre_vendedor='SATURNINO BRAVO'
--where p.descripcion='Huawei MateBook X Pro'
--and p.descripcion='Nintendo Switch'
--and r.nombre='Region Cibao'
GROUP BY r.nombre,vd.nombre_vendedor, p.descripcion, vh.cantidad
Order by SUM(vh.monto) desc


--#--DAME LA SUMA DE LAS VENTAS DE LA REGION 1, POR VENDEDOR, REGION Y MONTO.

SELECT distinct vd.nombre_vendedor as Vendedor, r.nombre as Region
   ,SUM(monto) AS Ingresos
FROM ventas_hechos vh join vendedor vd
on vh.id_vendedor= vd.id_vendedor
join region r
on r.id_region = vh.id_region
--Where vh.id_region='3'
GROUP BY vd.nombre_vendedor, r.nombre
Order by SUM(monto) desc

select * from productos


--#-DAME LA SUMA EXISTENCIA, LA VENTAS Y EXISTENCIA ACTUAL, DE LAS VENTAS POR REGION , POR VENDEDOR, REGION Y MONTO.

SELECT distinct TOP 166 vh.id_ventas, r.nombre as Region, vd.nombre_vendedor as Vendedor, cli.nombre_Negocio,
 p.descripcion as Producto, P.precio_ventas, p.existencia as 'Inventario', vh.cantidad as 'Cant. Vendida',
(p.existencia - vh.cantidad) as 'Existencia Actual'
   ,SUM(monto) AS 'Total RD$'
FROM ventas_hechos vh inner join vendedor vd
on vh.id_vendedor= vd.id_vendedor
inner join  Productos p
on p.id_producto = vh.id_producto
inner join  region r
on r.id_region = vh.id_region
inner join  cliente cli on vh.id_cliente= cli.id_cliente
GROUP BY vh.id_ventas,r.nombre,vd.nombre_vendedor,cli.nombre_Negocio, p.descripcion, P.precio_ventas,vh.cantidad, Existencia
Order by SUM(vh.monto) desc



--#-VERIFICAMOS LAS TRANSACCIONES Y MONTOS POR REGION:

select distinct * from Ventas_Hechos where id_region='1' order by id_ventas asc
select distinct * from Ventas_Hechos where id_region='2' order by id_ventas asc
select distinct * from Ventas_Hechos where id_region='3' order by id_ventas asc

--#2-VALIDAMOS QUE LAS TRANSACCIONES Y LAS VENTAS SEAN EL MISMO NUMERO Y SUMATORIA	


select sum(monto) as 'Ventas Total', count(*) as 'Total de Transacciones'  from Ventas_Hechos

select distinct SUM(monto) AS 'VENTAS CIBAO 2016 ', count(*) as 'Total de Transacciones', avg(monto) as'Promedio' 
from Ventas_Hechos where id_region='1' and YEAR(fecha_venta) = '2016'

select distinct SUM(monto) AS 'VENTAS CIBAO 2017 ', count(*) as 'Total de Transacciones', avg(monto) as'Promedio' 
from Ventas_Hechos where id_region='1' and YEAR(fecha_venta) = '2017'


select distinct SUM(monto) AS 'VENTAS CIBAO 2018 ', count(*) as 'Total de Transacciones', avg(monto) as'Promedio' 
from Ventas_Hechos where id_region='1' and YEAR(fecha_venta) = '2018'

select distinct SUM(monto) AS 'VENTAS CIBAO 2019 ', count(*) as 'Total de Transacciones', avg(monto) as'Promedio' 
from Ventas_Hechos where id_region='1' and YEAR(fecha_venta) = '2019'


select distinct SUM(monto) AS 'VENTAS CIBAO 2020', count(*) as 'Total de Transacciones', avg(monto) as'Promedio' 
from Ventas_Hechos where id_region='1' and YEAR(fecha_venta) = '2020'


select distinct SUM(monto) AS 'VENTAS CIBAO 2021', count(*) as 'Total de Transacciones', avg(monto) as'Promedio' 
from Ventas_Hechos where id_region='1' and YEAR(fecha_venta) = '2021'

select distinct SUM(monto) AS 'VENTAS CIBAO 2022', count(*) as 'Total de Transacciones', avg(monto) as'Promedio' 
from Ventas_Hechos where id_region='1' and YEAR(fecha_venta) = '2022'

select distinct SUM(monto) AS 'VENTAS ESTE' , count(*) as 'Total de Transacciones', avg(monto) as'Promedio'
from Ventas_Hechos where id_region='2'
select distinct SUM(monto) AS 'VENTAS SUR', count(*) as 'Total de Transacciones' , avg(monto) as'Promedio'
from Ventas_Hechos where id_region='3'


select sum(monto) as 'Ventas Total', count(*) as 'Total de Transacciones'  from Ventas_Hechos  where id_region not in ('1','2')--que nos sean
select sum(monto) as 'Ventas Total', count(*) as 'Total de Transacciones'  from Ventas_Hechos  where id_region not in ('2','3')--que nos sean
select sum(monto) as 'Ventas Total', count(*) as 'Total de Transacciones'  from Ventas_Hechos  where id_region not in ('3','1')--que nos sean

--#- VENTAS TOTAL Y TRANSACCIONES:

select sum(monto) as 'Ingresos Totales', count(*) as 'Total de Transacciones'  from Ventas_Hechos

select sum(monto) as 'Total Monto de Ventas' from Ventas_Hechos

select sum(precio_ventas) as 'Total Precio Ventas' from Ventas_Hechos

select sum(precio_compra) as 'Total Precio Compra' from Productos

select sum(monto-precio_ventas)as 'Ganancia Total' from Ventas_Hechos

select sum((vh.precio_ventas) - (vh.monto- vh.precio_ventas)) as 'Costo Total' 
from Productos p join Ventas_Hechos vh
on p.id_producto= vh.id_producto

--#--DAME LA SUMA DE LAS VENTAS DE LA REGIONES, POR VENDEDOR, REGION Y MONTO DONDE EL MONTO SEA MAYOR O IGUAL A 250000

SELECT distinct TOP 166 vd.nombre_vendedor as Vendedor, r.nombre as Region
   ,SUM(monto) AS Ingresos
FROM ventas_hechos vh join vendedor vd
on vh.id_vendedor= vd.id_vendedor
join region r
on r.id_region = vh.id_region
Where vh.id_region in('1','2','3')
GROUP BY vd.nombre_vendedor, r.nombre
HAVING SUM(monto) >=500000
Order by SUM(monto) desc


--#--DAME LA SUMA DE LAS VENTAS DE LA REGIONES, POR FGECHA, VENDEDOR, REGION Y MONTO DONDE
-- EL MONTO SEA MAYOR O IGUAL A 250000 Y QUE EL AÑO SEA 2016.

SELECT distinct TOP 160 vh.fecha_venta, vd.nombre_vendedor as Vendedor, r.nombre as Region
   ,SUM(monto) AS Ingresos
FROM ventas_hechos vh join vendedor vd
on vh.id_vendedor= vd.id_vendedor
join region r
on r.id_region = vh.id_region
GROUP BY VH.fecha_venta, vd.nombre_vendedor, r.nombre
HAVING SUM(monto) >=250000
and YEAR(vh.fecha_venta) = '2016'
Order by SUM(monto) desc

--#---DAME LAS VENTAS POR SUPERVISOR, REGION Y MONTO.

SELECT distinct  SP.id_supervisor,sp.supervisor as Supervidor, r.nombre As Region
   ,SUM(monto) AS Ingresos
FROM ventas_hechos vh join vendedor vd
on vh.id_vendedor= vd.id_vendedor
join supervisor sp
ON sp.id_region =vh.id_region
join region r
on r.id_region = vd.id_region
GROUP BY SP.id_supervisor, sp.supervisor, r.nombre
Order by SUM(monto) desc

--#--CUALES ES EL GENERO DE CADA SUPERVISOR, SU NOMBRE, REGION Y MONTO DE LAS VENTAS

SELECT distinct TOP 3 sp.supervisor as Supervidor, g.genero as 'Genero', r.nombre As Region
   ,SUM(monto) AS 'Total Ventas'
FROM ventas_hechos vh join vendedor vd
on vh.id_vendedor= vd.id_vendedor
join supervisor sp
ON sp.id_region =vh.id_region
join region r
on r.id_region = vd.id_region
join genero g on g.id_genero = sp.id_genero
GROUP BY sp.supervisor,g.genero, r.nombre
Order by SUM(monto) desc

--#--DAME LAS CATERIA DE PRODUCTOS POR ABC DONDE A SEA >=500000, B SEA < 500000 O >= 275000 Y C MENOR QUE 2750000

SELECT distinct TOP 166 p.descripcion as Productos,  p.precio_compra, p.precio_ventas
		  , sum(vh.cantidad) as Cantidad,SUM(monto) AS Ingresos,
CASE
   WHEN (SUM(vh.cantidad * vh.precio_ventas) >=500000) THEN 'A'
   WHEN (SUM(vh.cantidad * vh.precio_ventas) < 500000  AND SUM(vh.cantidad * vh.precio_ventas) >= 200000) THEN 'B'
   ELSE 'C'
   END AS 'CATEGORIA A-B-C'

FROM Ventas_Hechos vh join Productos p
on vh.id_producto = p.id_producto
GROUP BY p.descripcion, p.precio_compra, p.precio_ventas
--having sum(vh.monto) >=675000 and sum(vh.monto) <=2772525 --A
--having sum(vh.monto) >=201600 and sum(vh.monto) <=467200 --B
--having sum(vh.monto) >=0 and sum(vh.monto) <=192714 
Order by SUM(monto) desc



/*
  "Por favor, proporcione una consulta SQL que devuelva la descripción del producto, 
  la cantidad total de ventas, el porcentaje de utilidad y la cantidad acumulada de ventas 
  ordenadas por la cantidad total de ventas en orden descendente. La consulta debe limitar 
  las ventas a un rango de fechas específico."
*/

WITH CTE_VENTAS1
AS(
SELECT  p.descripcion,Sum(vh.cantidad * vh.precio_ventas) AS Total_Lineas
FROM Ventas_Hechos vh inner join Productos p
on vh.id_producto = p.id_producto
where vh.fecha_venta between '2016-01-01' and '2022-12-31'
GROUP BY ROLLUP (p.descripcion)
),
CTE_VENTAS2
AS
(SELECT cv.Total_Lineas AS TOTAL_VENTAS FROM CTE_VENTAS1 cv WHERE CV.descripcion IS NULL),
CTE_VENTAS3
AS
(SELECT * FROM CTE_VENTAS1 cv CROSS APPLY CTE_VENTAS2 cv2)
 SELECT * , SUM(cv.Total_Lineas) OVER(ORDER BY cv.descripcion) as Acumulado,
           FORMAT((cv.Total_Lineas / CAST(NULLIF(cv.TOTAL_VENTAS, 0) AS DECIMAL(18,2))) * 100, 'N2') AS Porcentaje_Utilidad
FROM CTE_VENTAS3 CV
where cv.descripcion IS NOT NULL
Order by Total_Lineas desc


--OTRA OPCION.

WITH CTE_VENTAS1 AS (
  SELECT p.descripcion, SUM(vh.cantidad * vh.precio_ventas) AS Total_Lineas
  FROM Ventas_Hechos vh INNER JOIN Productos p
  ON vh.id_producto = p.id_producto
  WHERE vh.fecha_venta BETWEEN '2016-01-01' and '2022-12-31'
  GROUP BY ROLLUP (p.descripcion)
),
CTE_VENTAS2 AS (
  SELECT cv.Total_Lineas AS TOTAL_VENTAS
  FROM CTE_VENTAS1 cv
  WHERE CV.descripcion IS NULL
),
CTE_VENTAS3 AS (
  SELECT *, SUM(cv.Total_Lineas) OVER (ORDER BY cv.descripcion) AS Acumulado
  FROM CTE_VENTAS1 cv
  CROSS APPLY CTE_VENTAS2 cv2
  WHERE cv.descripcion IS NOT NULL
)
SELECT *,
       FORMAT((cv.Total_Lineas / CAST(NULLIF(cv.TOTAL_VENTAS, 0) AS DECIMAL(18,2))) * 100, 'N2') AS Porcentaje_Utilidad

FROM CTE_VENTAS3 cv
ORDER BY cv.Total_Lineas DESC






--#--DAME LAS VENTAS TOP DE PRODUCTOS,CANTIDAD Y PROMEDIO.

select distinct p.descripcion AS 'Productos',
  sum(cantidad) as 'Cantidad',
   SUM(monto) AS 'Ventas de Productos',
   avg(monto) as'Promedio',
  CASE
   WHEN (SUM(vh.cantidad * vh.precio_ventas) >=500000) THEN 'A'
   WHEN (SUM(vh.cantidad * vh.precio_ventas) < 500000  AND SUM(vh.cantidad * vh.precio_ventas) >= 200000) THEN 'B'
   ELSE 'C'
   END AS 'CATEGORIA A-B-C'
  from Ventas_Hechos vh
join Productos p on p.id_producto = vh.id_producto 
GROUP BY p.descripcion
Order by SUM(monto) desc


--#-DAME LA SUMA EXISTENCIA, LA VENTAS Y EXISTENCIA ACTUAL, DE LAS VENTAS POR REGION , POR VENDEDOR, REGION Y MONTO.

SELECT distinct TOP 166 vh.id_ventas, r.nombre as Region, vd.nombre_vendedor as Vendedor, cli.nombre_Negocio,
 p.descripcion as Producto,p.fecha_entrada,   p.existencia as 'Inventario Inicial', vh.cantidad as 'Cant. Vendida',
(p.existencia - vh.cantidad) as 'Existencia Actual'
   ,SUM(monto) AS 'Total RD$'
FROM ventas_hechos vh join vendedor vd
on vh.id_vendedor= vd.id_vendedor
join Productos p
on p.id_producto = vh.id_producto
join region r
on r.id_region = vh.id_region
join cliente cli on vh.id_cliente= cli.id_cliente
GROUP BY vh.id_ventas,r.nombre,vd.nombre_vendedor,cli.nombre_Negocio, p.descripcion, vh.cantidad, Existencia, p.fecha_entrada
Order by SUM(vh.monto) desc


--ESTRUCTURA DE CONTROL- INVENTARIO CON NOTAS:
SELECT vh.id_producto, 
       p.descripcion, 
       p.existencia,
       vh.cantidad as 'Stock  Actual',
       CASE
         WHEN (p.existencia - vh.cantidad)  = 0 THEN 'Sin Existencias'
         WHEN (p.existencia - vh.cantidad)  > 0 AND (p.existencia - vh.cantidad)  <= 3 THEN 'Hacer un Pedido'
         WHEN (p.existencia - vh.cantidad)  > 3 AND (p.existencia - vh.cantidad)  <= 5 THEN 'Pocas Existencias'
         WHEN (p.existencia - vh.cantidad)  > 10 THEN 'Con Mucha Existencias'
         ELSE 'No se Puede Determinar la Existencia'
       END AS [Status]
FROM ventas_hechos vh 
JOIN vendedor vd ON vh.id_vendedor = vd.id_vendedor
JOIN Productos p ON p.id_producto = vh.id_producto
GROUP BY vh.id_producto, 
         p.descripcion, 
         p.existencia, 
         vh.cantidad
ORDER BY vh.id_producto ASC;



SELECT distinct vh.id_producto, p.descripcion, p.existencia,vh.cantidad as 'Stock  Actual',
   CASE
      WHEN (p.existencia - vh.cantidad)  = 0 THEN 'Sin Existencias'
	  WHEN (p.existencia - vh.cantidad)  > 0 AND (p.existencia - vh.cantidad)  <= 3 THEN 'Hacer un Pedido'
	  WHEN (p.existencia - vh.cantidad)  > 3 AND (p.existencia - vh.cantidad)  <= 5 THEN 'Pocas Existencias'
	  WHEN (p.existencia - vh.cantidad)  > 10 THEN 'Con Mucha Existencias'
	  ELSE 'No se Puede Determinar la Existencia'
   END [Status]
FROM ventas_hechos vh join vendedor vd
on vh.id_vendedor= vd.id_vendedor
join Productos p
on p.id_producto = vh.id_producto





--#-27-DAME LAS VENTAS TOP POR CATEGORIAS PRODUCTOS Y MONTO

SELECT catpro.descripcion as 'Categoria de Productos'
,SUM(monto) AS Monto
FROM Ventas_Hechos vh join Productos p
on vh.id_producto = p.id_producto
join categoria_producto catpro
on catpro.id_categoria= p.id_categoria
GROUP BY catpro.descripcion
Order by SUM(monto) desc

select * from categoria_producto
select * from productos

--#- DAME LAS VENTAS DEL AÑO DEL 2020 AL 2021, PERO SOLO LOS MESES ENERO A MARZO
--# Y MUESTRAME LA FECHA, EL PRODUCTO, LA CANTIDAD Y EL MONTO.

select v.fecha_venta as Fecha, p.descripcion as Productos, v.cantidad AS Cantidad, v.monto as 'Monto RD$'
  from Ventas_Hechos v join Productos p
  on p.id_producto = v.id_producto
 where year(v.fecha_venta) between 2020 and 2021
   and month(v.fecha_venta) between 1 and 3 /* enero a marzo */


--#- MOSTRAR CUANTAS FACTURAS POR PRODUCTOS :

select   p.descripcion as 'Nombre Producto',
     (select sum(cantidad) from [Ventas_Hechos] vh	
	 where p.id_producto = vh.id_producto) as 'Cantidad Productos'
from Productos p
order by [Cantidad Productos] desc

--DAME LA CANTIDAD TOTAL DE LAS VENTAS DONDE EL ARTICULO SEA LAPTOPS

select p.descripcion, 
sum(vh.cantidad) as Cantidad, ct.descripcion
from Ventas_Hechos vh join Productos p
on p.id_producto = vh.id_producto
join categoria_producto ct on p.id_categoria = ct.id_categoria
where ct.descripcion='LAPTOPS'
GROUP BY p.descripcion, vh.cantidad,  ct.descripcion
ORDER BY COUNT(vh.cantidad) DESC

--DAME LA CANTIDAD TOTAL EXISTENCIA + CANTIDAD VENDIDA + STOCK ACTUAL + MONTO TOTAL DONDE EL ARTICULO SEA LAPTOPS

select p.descripcion, 
COUNT(p.existencia) as Existencia,
COUNT(vh.cantidad) as'Cantidad Vendidad',
COUNT(P.existencia - vh.cantidad) as [Stock Actual],
ct.descripcion as Categoria,
sum(vh.monto) as 'Ingresos Totales'
from Ventas_Hechos vh join Productos p
on p.id_producto = vh.id_producto
join categoria_producto ct on p.id_categoria = ct.id_categoria
where ct.descripcion='LAPTOPS'
GROUP BY p.descripcion, (vh.cantidad -P.existencia),  ct.descripcion , vh.monto
ORDER BY COUNT(vh.cantidad) DESC

SELECT * FROM Productos

--#--DAME LAS VENTAS POR CATEGORIA,  CANTIDAD Y EL MONTO.

SELECT p.id_categoria, cp.descripcion as 'Categoia de Productos',
	sum(cantidad) as 'Cantidad Vendida',
	sum(vh.monto)as 'Monto',
	COUNT(P.existencia-VH.cantidad) AS [Stock]
FROM Productos p join categoria_producto cp
on p.id_categoria = cp.id_categoria
join Ventas_Hechos vh
on vh.id_producto =p.id_producto
GROUP BY cp.descripcion, p.id_categoria
ORDER BY sum(monto) DESC

select * from categoria_producto
select * from Productos

--#-- DAME LAS VENTAS DE CANTEGORIAS MAYORES A X CANTIDAD:

SELECT  cp.descripcion as Categoia, sum(vh.cantidad) as Cantidad, sum(vh.monto)as Monto
FROM Productos p join categoria_producto cp
on p.id_categoria = cp.id_categoria
join Ventas_Hechos vh
on vh.id_producto =p.id_producto
GROUP BY cp.descripcion
HAVING COUNT(vh.cantidad) >= 5
ORDER BY COUNT(cp.descripcion) DESC;
	
--#--TOP VENTAS POR REGIONES:

--DAME EL MONTO VENDIDO POR REGION, PRODUCTO, MONTO Y CUANTAS 
--TRANSACCIONES SE HAN REALIZADO DONDE LA CANTIDAD SEA >= 10

SELECT distinct TOP 166 r.nombre as Region, p.descripcion as 'Producto'
	,SUM(monto) AS Monto, COUNT(vh.cantidad) as 'Cantidas Vendidas'
FROM Ventas_Hechos vh join region r
on vh.id_region = r.id_region
JOIN Productos p
on p.id_producto = vh.id_producto
join categoria_producto ctp
on ctp.id_categoria = p.id_categoria
GROUP BY r.nombre, p.descripcion
--HAVING SUM(vh.cantidad) >=154
Order by SUM(monto) desc



--#-TOP 10 DE VENTAS POR REGION, PRODUCTOS, CANTIDAD Y MONTOS 

 select distinct TOP 20  id_ventas, R.nombre as 'Nombre de la Region',  p.descripcion as 'Descripcion del Producto',
 ctp.descripcion as 'Categoria Producto',  vh.cantidad, Vh.monto
from Ventas_Hechos Vh join region R
on Vh.id_region = R.id_region
join Productos p
on p.id_producto= vh.id_producto
join categoria_producto ctp
on ctp.id_categoria = p.id_categoria
--where vh.id_region='3'
order by vh.monto  desc


select * from categoria_producto

--VENTAS POR CIUDAD, PRODUCTO, CANITDAD Y MONTO

SELECT distinct TOP 10 ci.nombre_ciudad as Ciudad, P.descripcion, vh.cantidad 
	,SUM(monto) AS Monto
FROM Ventas_Hechos vh join ciudad ci
on vh.id_ciudad = ci.id_ciudad
join Productos p
on p.id_producto = vh.id_producto
GROUP BY ci.nombre_ciudad, p.descripcion, VH.cantidad
Order by SUM(monto) desc


--#- TOP 10 DE VENTAS X POR VENDEDOR, CLIENTE, CONDICION, DIAS, PRODUCTO, CANTIDAD, MONTO Y CIUDAD:

select distinct TOP 30  vh.fecha_venta,vh.No_facturas,cf.condicion as 'Condicion de Pago',
    df.dias_creditos as 'Dias de Creditos', 
	Ci.nombre_ciudad as Ciudad,
    vd.nombre_vendedor as Vendedor, cli.nombre_Negocio as Cliente, 
	p.descripcion as Producto, Vh.cantidad, Vh.monto
from Ventas_Hechos as Vh inner join ciudad as Ci
on vh.id_ciudad = ci.id_ciudad
join vendedor vd
on vh.id_vendedor=vd.id_vendedor
join cliente cli
on vh.id_cliente=cli.id_cliente
join Productos p
on p.id_producto = vh.id_producto
join condicion_factura cf
on cf.id_condicion = vh.id_condicion
join dias_factura df
on df.id_dias_factura = vh.id_dias_factura
order by monto  desc


--Vamos a visualizar todas las Ciudades de la Region 1 que han tenido ventas:

SELECT distinct VH.No_facturas, id_ventas, vh.fecha_venta, r.nombre as Region, ciu.nombre_ciudad as Ciudad, v.id_vendedor, v.nombre_vendedor as Vendedor, 
cli.id_cliente,cli.nombre_Negocio as Cliente, CF.condicion, DF.dias_creditos, p.descripcion as Producto, cantidad,monto
FROM vendedor V
JOIN region R
ON V.id_region = R.id_region
join Ventas_Hechos vh
ON vh.id_vendedor = V.id_vendedor
join cliente cli
on cli.id_cliente=vh.id_cliente
join Productos p
on p.id_producto = vh.id_producto
join ciudad ciu
on ciu.id_ciudad=vh.id_ciudad
join condicion_factura cf
on cf.id_condicion = vh.id_condicion
join dias_factura df
on df.id_dias_factura = vh.id_dias_factura
and nombre='Region Cibao'
and YEAR(vh.fecha_venta) = '2016'
order by fecha_venta asc
--order by monto DESC  

SELECT * FROM Ventas_Hechos WHERE id_region='1'
SELECT * FROM region

--Vamos a visualizar todas las Ciudades de la Region 2  que han tenido ventas:

SELECT distinct VH.No_facturas, id_ventas, r.nombre as Region, ciu.nombre_ciudad as Ciudad, v.id_vendedor, v.nombre_vendedor as Vendedor, 
cli.id_cliente,cli.nombre_Negocio as Cliente, CF.condicion, DF.dias_creditos, p.descripcion as Producto, cantidad,monto
FROM vendedor V
JOIN region R
ON V.id_region = R.id_region
join Ventas_Hechos vh
ON vh.id_vendedor = V.id_vendedor
join cliente cli
on cli.id_cliente=vh.id_cliente
join Productos p
on p.id_producto = vh.id_producto
join ciudad ciu
on ciu.id_ciudad=vh.id_ciudad
join condicion_factura cf
on cf.id_condicion = vh.id_condicion
join dias_factura df
on df.id_dias_factura = vh.id_dias_factura
and nombre='Region Sur'
order by monto DESC 

select * from region


--Vamos a visualizar todas las Ciudades de la Region 3  que han tenido ventas:

SELECT distinct vh.id_producto,vh.No_facturas, r.nombre as Region, ciu.nombre_ciudad as Ciudad,
ciu.latitud, ciu.longitud, v.nombre_vendedor as Vendedor, cli.nombre_Negocio as Cliente,
CF.condicion AS 'Forma de Pago',DF.dias_creditos as 'Dias en Creditos', p.descripcion as Producto, 
sum(p.precio_compra * vh.cantidad) as 'Precio Compra Total',
sum(vh.precio_ventas * vh.cantidad) as 'Precio de Ventas Total',vh.cantidad,vh.monto 
FROM vendedor V
JOIN region R
ON V.id_region = R.id_region
join Ventas_Hechos vh
ON vh.id_vendedor = V.id_vendedor
join cliente cli
on cli.id_cliente=vh.id_cliente
join Productos p
on p.id_producto = vh.id_producto
join ciudad ciu
on ciu.id_ciudad=vh.id_ciudad
join condicion_factura cf
on cf.id_condicion = vh.id_condicion
join dias_factura df
on df.id_dias_factura = vh.id_dias_factura
--and nombre='Region Este'
GROUP BY vh.id_producto,vh.No_facturas, p.descripcion,r.nombre,ciu.nombre_ciudad,
ciu.latitud, ciu.longitud,v.nombre_vendedor,vh.cantidad,
cli.nombre_Negocio,CF.condicion, DF.dias_creditos, vh.monto
order by vh.monto asc


select *  from cliente
select * from vendedor



--#-MOSTRAR LAS FACTURAS Y SUS CONDICIONES DE PAGOS:

select distinct vh.fecha_venta, vh.No_facturas,c.nombre_Negocio as Cliente, cf.condicion, df.dias_creditos,vh.monto
from Ventas_Hechos vh join condicion_factura cf
on vh.id_condicion = cf.id_condicion
join cliente c
on c.id_cliente = vh.id_cliente
join dias_factura df
on df.id_dias_factura = vh.id_dias_factura
--where  df.dias_creditos='15'
--where vh.id_condicion='2'
ORDER BY fecha_venta desc;


--CONSULTAR LAS FACTURAS PAGADAS O NO:

select distinct vh.fecha_venta, vh.No_facturas,c.nombre_Negocio as Cliente,
cf.condicion, df.dias_creditos,vh.monto, ef.estatus_Cobrado
from Ventas_Hechos vh join condicion_factura cf
on vh.id_condicion = cf.id_condicion
join cliente c
on c.id_cliente = vh.id_cliente
join dias_factura df
on df.id_dias_factura = vh.id_dias_factura
join Estatus_Facturas ef
on ef.id_ventas = vh.id_ventas
--where  df.dias_creditos='15'
--where vh.id_condicion='2'
ORDER BY fecha_venta desc;

select * from Ventas_Hechos
select * from condicion_factura
select * from dias_factura


--PODEMOS CREAR UNA VARIANTE MAS COMPLEJA, CON TODOS LOS DATROS NECESARIOS PARA UN REPORTE MAS COMPLEJO:

SELECT TOP 166  vh.No_facturas, vh.id_ventas, vh.fecha_venta as 'Fecha de Venta', cf.Condicion, 
df.dias_creditos, R.nombre as Region, ciu.nombre_ciudad as Ciudad,c.id_cliente,
c.nombre_Negocio, vd.nombre_vendedor,p.descripcion as Producto, vh.cantidad, vh.precio_ventas, vh.monto,
--,vh.monto-p.precio_compra as Gastos, vh.monto-p.precio_compra as Utilidad
ef.fecha_pago as 'Fecha de Pago', 
DATEDIFF(DAY, vh.fecha_venta, ef.fecha_pago) as 'Dias Transcurridos',
ef.estatus_Cobrado as 'Estatus de Pago',
ef.monto_pagado as 'Monto Pago',
vh.monto - ef.monto_pagado as 'Balance Pendiete'
FROM vendedor vd join region R
ON vd.id_region = R.id_region
join Ventas_Hechos vh
ON vh.id_vendedor = vd.id_vendedor
join cliente c
ON c.id_cliente = vh.id_cliente
join Productos p
ON p.id_producto = vh.id_producto
join ciudad ciu
ON ciu.id_ciudad = vh.id_ciudad
join Condicion_factura cf
on cf.id_condicion=vh.id_condicion
join dias_factura df
on df.id_dias_factura =vh.id_dias_factura
join Estatus_Facturas ef
on vh.id_ventas = ef.id_ventas
--where vh.id_ciudad='28'
--and R.nombre='Regiin Norte o Cibao'
--and vh.id_region='2'
--and vh.No_facturas='25047'
--and vH.id_vendedor='2'
--and c.id_cliente='100015'
--where vh.fecha_venta >= '2021-01-01' and vh.fecha_venta <= '2021-08-17'
where YEAR(vh.fecha_venta) in('2016','2017','2018','2019','2020','2021','2022')
order by id_ventas asc


select * from Ventas_Hechos  where fecha_venta >= '2016-01-01' and fecha_venta <= '2022-12-31' order by fecha_venta asc


--#-VEAMOS LAS VENTAS POR RANGO DE FECHAS:

select * from Ventas_Hechos where fecha_venta >= '2016-01-01' and fecha_venta <= '2020-09-30' order by fecha_venta asc

	
--#-VEAMOS LAS VENTAS POR RANGO DE FECHAS Y POR VENDEDOR:

select * from Ventas_Hechos where fecha_venta >= '2016-01-01' and fecha_venta <= '2020-09-30' 
AND id_vendedor='1'
order by fecha_venta asc

		
--#-VEAMOS LAS VENTAS POR RANGO DE FECHAS Y POR VENDEDOR:

select * from Ventas_Hechos where fecha_venta >= '2016-01-01' and fecha_venta <= '2020-09-30' 
AND id_region='3'
order by fecha_venta asc

---VEAMOS LAS VENTAS POR RANGO DE FECHAS Y POR CLIENTE:

select * from Ventas_Hechos where fecha_venta >= '2016-01-01' and fecha_venta <= '2020-09-30' 
AND id_cliente='100004'
order by fecha_venta asc



--
--EN ESTA SECCION VAMOS A CREAR AHORA UNOS STORED PROCEDURE PARA HACER REPORTE PARAMENTRIZADOS CON CRYSTAL REPORT:

create OR ALTER procedure SP_ReporteCrystal  
(
@fecha_Inicio date,
@fecha_Final date
)
as
select * from Ventas_Hechos where fecha_venta >= @fecha_Inicio and fecha_venta <= @fecha_Final
go

--Veamos una consultas con paramentros Reales:
select * from Ventas_Hechos where fecha_venta >= '2019-03-10' and fecha_venta <= '2020-03-23' order by id_ventas asc
go

	sp_helptext PA_ReporteCrystal

	--Ejecutamos el store:
DECLARE	@return_value int
EXEC	@return_value = [dbo].SP_ReporteCrystal
		@fecha_Inicio = '2019-03-10',
		@fecha_Final = '2020-03-23'
	

--Aqui vamos a crer un Procedimiento Almacenado para Parametros de un Reporte:

Create Procedure PA_GetVentasByFechas1
(@fecha_Inicio date,
@fecha_Final date
)
AS
select * from  Ventas_Hechos where fecha_venta>=@fecha_Inicio And fecha_venta<=@fecha_Final
GO

--Veamos una consultas con paramentros Reales:
select * from Ventas_Hechos where fecha_venta >= '2016-01-01' and fecha_venta <= '2020-12-31' order by id_ventas asc
go

--Ejemplo con paramentros Reales
select * from Ventas_Hechos where id_vendedor='15'order by fecha_venta desc


--Ejecutamos el store:
DECLARE	@return_value int
EXEC	@return_value = [dbo].PA_ReporteCrystal_Ventas
		@fecha_Inicio = '2016-01-01',
		@fecha_Final = '2016-12-31'
	

--Aqui vamos a crer un Procedimiento Almacenado para Parametros de un Reporte:
	create or alter procedure PA_ReporteCrystal_Ventas
	(@fecha_Inicio date,
	@fecha_Final date
	)AS	
	SELECT distinct vh.No_facturas,vh.fecha_venta, r.nombre as Region, ciu.nombre_ciudad as Ciudad,
	c.nombre_Negocio, v.nombre_vendedor,p.descripcion as Producto,p.precio_compra, 
	vh.precio_ventas,	vh.cantidad,vh.monto,
	Costo=(p.precio_compra * vh.cantidad),
	Ganancia= (vh.precio_ventas * vh.cantidad)-(p.precio_compra * vh.cantidad)

	FROM vendedor V	join region R
	ON V.id_region = R.id_region
	join Ventas_Hechos vh
	ON vh.id_vendedor = V.id_vendedor
	join cliente c
	ON c.id_cliente = vh.id_cliente
	join Productos p
	ON p.id_producto = vh.id_producto
	join ciudad ciu
	ON ciu.id_ciudad = vh.id_ciudad
    where fecha_venta>=@fecha_Inicio And fecha_venta<=@fecha_Final
	go

--Veamos una consultas con paramentros Reales
select * from Ventas_Hechos where fecha_venta >= '2019-03-10' and fecha_venta <= '2020-03-23' order by id_ventas asc
go


sp_helptext PA_ReporteCrystal_Ventas

--Ejecutamos el store:
DECLARE	@return_value int
EXEC	@return_value = [dbo].[PA_ReporteCrystal_Ventas]
		@fecha_Inicio = '2016-01-01',
		@fecha_Final = '2022-12-31'
	
	
--Ejemplo con parámetros Reales
select * from Ventas_Hechos where fecha_venta >= '2019-03-10' and fecha_venta <= '2020-03-23'
go

--Aqui vamos a Modificar el Procedimiento Almacenado para Parametros de un Reporte:

create or alter procedure PA_ReporteCrystal_Ventas_Enero_Mayo_2022
(
@fecha_Inicio date,
@fecha_Final date
)
AS
SELECT distinct vh.No_facturas, vh.fecha_venta as 'Fecha de Ventas', r.nombre as Region, ciu.nombre_ciudad as Ciudad,c.id_cliente as 'Codigo de Cliente',
	c.nombre_Negocio as 'Nombre de Cliente', v.nombre_vendedor as 'Nombre del Vendedor', p.descripcion as Producto,
	vh.cantidad as 'Cantidad', vh.precio_ventas as 'Precio de Ventas', vh.monto as 'Monto RD$'
FROM vendedor V	join region R
	ON V.id_region = R.id_region
	join Ventas_Hechos vh
	ON vh.id_vendedor = V.id_vendedor
	join cliente c
	ON c.id_cliente = vh.id_cliente
	join Productos p
	ON p.id_producto = vh.id_producto
	join ciudad ciu
	ON ciu.id_ciudad = vh.id_ciudad
	--where vh.id_cuidad='4'
	--and vh.id_region='3'
	--and vh.No_facturas='25022'
	--and v.id_vendedor='11'
	--and c.id_cliente='100007'
 where fecha_venta>=@fecha_Inicio And fecha_venta<=@fecha_Final
go

--Veamos una consultas con paramentros Reales
select * from Ventas_Hechos where fecha_venta >= '01-01-2016' and fecha_venta <= '21-07-2016' order by id_ventas asc
go

sp_helptext PA_ReporteCrystal_Ventas


--Ejecutamos el store:
DECLARE	@return_value int
EXEC	@return_value = [dbo].PA_ReporteCrystal_Ventas_Enero_Mayo_2022
		@fecha_Inicio = '01-01-2016',
		@fecha_Final = '21-07-2016'
		--1/1/2016 y 21/01/2016

--Ejemplo con parámetros Reales		

create or alter procedure PA_ReporteCrystal_Ventas_Enero_Mayo_2022
(
@fecha_Inicio date,
@fecha_Final date
)
AS

SELECT vh.No_facturas, vh.id_ventas, vh.fecha_venta as 'Fecha de Venta', cf.Condicion, df.dias_creditos,
 ciu.latitud, ciu.longitud, R.nombre as Region, ciu.nombre_ciudad as Ciudad,c.id_cliente,
   c.nombre_Negocio, catpro.descripcion as 'Categoria de Productos',p.descripcion as Producto, p.precio_compra as 'Precio de Compra', 
	vh.precio_ventas as 'Precio de Ventas',vh.cantidad as 'Cantidad',	vh.monto as 'Monto RD$',
	Costo=(p.precio_compra * vh.cantidad),
	Ganancia= (vh.precio_ventas * vh.cantidad)-(p.precio_compra * vh.cantidad),
ef.fecha_pago as 'Fecha de Pago', 
--CON ESTA FUNCION OPTENGO LA DIFERECIAS EN DIAS, PUEDE SER AÑOS, MESES, SEMANAS, ETC.
DATEDIFF(DAY, vh.fecha_venta, ef.fecha_pago) as 'Dias Transcurridos',
ef.estatus_Cobrado as 'Estatus de Pago',
ef.monto_pagado as 'Monto Pago',
vh.monto - ef.monto_pagado as 'Balance Pendiete'
FROM vendedor vd join region R
--UTILIZANDO LOS JOIN, PUEDO CREAR UNA RELACION ENTRE TODAS LAS TABLAS DE MI MODELO Y TRAER DATOS QUE 
--MUESTRAN UNA RELEVANCIA CORRECTA Y QUE PARA EL INFORME O EL REPORTE LA DA ENTENDIMIENTO A QUIEN LO LEE.
ON vd.id_region = R.id_region
join Ventas_Hechos vh
ON vh.id_vendedor = vd.id_vendedor
join cliente c
ON c.id_cliente = vh.id_cliente
join Productos p
ON p.id_producto = vh.id_producto
join ciudad ciu
ON ciu.id_ciudad = vh.id_ciudad
	join categoria_producto catpro
on catpro.id_categoria = p.id_categoria
join Condicion_factura cf
on cf.id_condicion=vh.id_condicion
join dias_factura df
on df.id_dias_factura =vh.id_dias_factura
join Estatus_Facturas ef
on vh.id_ventas = ef.id_ventas
 where fecha_venta>=@fecha_Inicio And fecha_venta<=@fecha_Final
GROUP BY vh.No_facturas,vh.id_ventas, vh.fecha_venta, p.descripcion,r.nombre,ciu.nombre_ciudad,ciu.latitud, ciu.longitud,vd.nombre_vendedor, catpro.descripcion,
	    vh.cantidad,c.id_cliente,c.nombre_Negocio,CF.condicion, DF.dias_creditos,  p.precio_compra, 
	  vh.precio_ventas,vh.monto, ef.fecha_pago , ef.estatus_Cobrado, ef.monto_pagado

select * from Ventas_Hechos where fecha_venta >= '01-01-2019' and fecha_venta <= '21-07-2021' order by id_ventas asc
go

--Ejecutamos el store:
DECLARE	@return_value int
EXEC	@return_value = [dbo].[PA_ReporteCrystal_Ventas_Enero_Mayo_2022]
		@fecha_Inicio = '2016-01-01',
		@fecha_Final = '2022-12-31'

/*
Sentencia SQL CREATE VIEW

En SQL, una vista es una tabla virtual basada en el conjunto de resultados de una declaración SQL.

Una vista contiene filas y columnas, como una tabla real. Los campos de una vista son campos de una o más tablas reales de la base de datos.

Puede agregar funciones SQL, WHERE y declaraciones JOIN a una vista y presentar los datos como si vinieran de una sola tabla.
	
*/

---crearemos una vista llama Informe_ventas_Hechos:

create view Informe_ventas_Hechos_v
as 
SELECT vh.No_facturas, VH.id_ventas, vh.fecha_venta, r.nombre, c.nombre_Negocio, v.nombre_vendedor,
	p.descripcion as Producto, vh.cantidad, vh.precio_ventas, vh.monto
FROM vendedor V	join region R
ON V.id_region = R.id_region
join Ventas_Hechos vh
ON vh.id_vendedor = V.id_vendedor
join cliente c
ON c.id_cliente = vh.id_cliente
join Productos p
ON p.id_producto = vh.id_producto
	
--VAMOS A VER COMO SE MUESTRAN LOS DATOS DE LA VISTA	:

select * from Informe_ventas_Hechos_v 

--VERIFICACION DE CIFRADO:

sp_helptext Informe_ventas_Hechos_v

	
--Alteramos la vista llama Informe_ventas_Hechos para encripptar los datos:

create or alter view Informe_ventas_Hechos_v with encryption
as 
SELECT VH.id_ventas as 'No.Ventas',  vh.No_facturas, vh.fecha_venta, cf.Condicion as 'Condificion Fact.' ,df.dias_creditos,
	cd.nombre_ciudad as Ciudad, cd.latitud, cd.longitud  ,r.nombre as 'Region',c.id_cliente ,c.nombre_Negocio as 'Negocio',  v.id_vendedor,v.nombre_vendedor as Vendedor,
	catpro.descripcion as 'Categoria Prod.',p.id_producto ,p.descripcion as Producto, vh.cantidad, vh.precio_ventas as Precio_Ventas, vh.monto as 'Monto RD$',
	costo=(p.precio_compra * vh.cantidad),
	ganancia= (vh.precio_ventas * vh.cantidad)-(p.precio_compra * vh.cantidad)
FROM vendedor V	join region R
	ON V.id_region = R.id_region
	join Ventas_Hechos vh
	ON vh.id_vendedor = V.id_vendedor
	join cliente c
	ON c.id_cliente = vh.id_cliente
	join Productos p
	ON p.id_producto = vh.id_producto
	join categoria_producto catpro
	on catpro.id_categoria = p.id_categoria
	JOIN condicion_factura cf
	on cf.id_condicion = vh.id_condicion
	join dias_factura df
	on df.id_dias_factura= vh.id_dias_factura
	JOIN ciudad cd
	on cd.id_ciudad = vh.id_ciudad

		USE EJEMPLO_DCD_1050_ENERO_ABRIL_2023_V1
--SELECCIONAMOS LA VISTA PARA COMO HA QUEDADO LA CONSULTA.

select * from Informe_ventas_Hechos_v

--VERIFICACION DE CIFRADO:

sp_helptext Informe_ventas_Hechos_v
go


--Alteramos la vista llama Informe_ventas_Hechos para encripptar los datos CON LOS GASTOS, GANANCIAS, ETC:

create or alter view Informe_ventas_Hechos_v with encryption
as 
	SELECT vh.No_facturas, VH.id_ventas as 'No.Ventas', vh.fecha_venta, cf.Condicion as 'Condicion Fact.' ,
	cd.nombre_ciudad as Ciudad, cd.latitud, cd.longitud  ,r.nombre as 'Region',c.id_cliente ,c.nombre_Negocio as 'Negocio',  v.id_vendedor,v.nombre_vendedor as Vendedor,
	catpro.descripcion as 'Categoria',p.id_producto ,p.descripcion as Producto, vh.cantidad, vh.precio_ventas as Precio, vh.monto as 'Monto RD$',
	costo=(p.precio_compra * vh.cantidad),
	ganancia= (vh.precio_ventas * vh.cantidad)-(p.precio_compra * vh.cantidad), EF.estatus_Cobrado
	
FROM vendedor V	join region R
	ON V.id_region = R.id_region
	join Ventas_Hechos vh
	ON vh.id_vendedor = V.id_vendedor
	join cliente c
	ON c.id_cliente = vh.id_cliente
	join Productos p
	ON p.id_producto = vh.id_producto
	JOIN condicion_factura cf
	on cf.id_condicion = vh.id_condicion
	join dias_factura df
	on df.id_dias_factura= vh.id_dias_factura
	JOIN ciudad cd
	on cd.id_ciudad = vh.id_ciudad
	join categoria_producto catpro
	on catpro.id_categoria = p.id_categoria
	join Estatus_Facturas EF
	ON vh.id_ventas = EF.id_ventas 
	

--SELECCIONAMOS LA VISTA MODIFICADA PARA VER SUS DATOS:

select * from Informe_ventas_Hechos_v
	

--MODIFICAMOS LA VISTA PARA USAR EN UN EXCEL Y EN EL MAPA DE GOOGLE MAPS.:

create or alter view Informe_ventas_Hechos_v with encryption
as
	SELECT vh.No_facturas, vh.fecha_venta as 'Fecha de Venta', cf.Condicion as 'Condificion Pago.' ,df.dias_creditos as'Dias en Creditos',
	cd.nombre_ciudad as Ciudad, cd.latitud, cd.longitud  ,r.nombre as 'Region',c.nombre_Negocio as 'Negocio',v.nombre_vendedor as Vendedor,
	catpro.descripcion as 'Categoria de Productos',p.descripcion as Producto, p.precio_compra as 'Precio de Compra', 
	vh.precio_ventas as 'Precio de Ventas',vh.cantidad as 'Cantidad',	vh.monto as 'Monto RD$',
	Costo=(p.precio_compra * vh.cantidad),
	Ganancia= (vh.precio_ventas * vh.cantidad)-(p.precio_compra * vh.cantidad),
	count(vh.No_facturas) as 'Cantidad Facturas'
FROM vendedor V	join region R
ON V.id_region = R.id_region
	join Ventas_Hechos vh
ON vh.id_vendedor = V.id_vendedor
	join cliente c
ON c.id_cliente = vh.id_cliente
	join Productos p
ON p.id_producto = vh.id_producto
	join categoria_producto catpro
on catpro.id_categoria = p.id_categoria
	JOIN condicion_factura cf
on cf.id_condicion = vh.id_condicion
	join dias_factura df
on df.id_dias_factura= vh.id_dias_factura
	JOIN ciudad cd
on cd.id_ciudad = vh.id_ciudad
	
GROUP BY vh.No_facturas,vh.fecha_venta, p.descripcion,r.nombre,cd.nombre_ciudad,cd.latitud, cd.longitud,v.nombre_vendedor, catpro.descripcion,
	    vh.cantidad,c.nombre_Negocio,CF.condicion, DF.dias_creditos,  p.precio_compra, 
	  vh.precio_ventas,vh.monto
 
 select * from Ventas_Hechos

--SELECCIONAMOS LA VISTA MODIFICADA PARA VER SUS DATOS:

select * from Informe_ventas_Hechos_v
select * from Ventas_Hechos


create or alter view Informe_ventas_Hechos_v_2022 with encryption
as
SELECT vh.No_facturas, vh.id_ventas, vh.fecha_venta as 'Fecha de Venta',cf.id_condicion, cf.Condicion, df.dias_creditos,
    R.nombre as Region,ciu.nombre_ciudad as Ciudad, ciu.latitud, ciu.longitud, vd.id_vendedor, 
	vd.nombre_vendedor as Vendedor,fv.foto_Vendedor_url, sup.supervisor, fs.foto_Supervisor_url,  C.id_cliente,
    c.nombre_Negocio as Cliente, catpro.descripcion as 'Categoria de Productos', P.id_producto,
	p.descripcion as Producto,  fp.foto_Productos_url, p.existencia as 'Inventario', p.precio_compra as 'Precio de Compra', 
	
	vh.precio_ventas as 'Precio de Ventas',
    vh.cantidad as 'Cant. Vendida',
	vh.monto as 'Monto RD$',
	Costo=(p.precio_compra * vh.cantidad),
	Ganancia= (vh.precio_ventas * vh.cantidad)-(p.precio_compra * vh.cantidad),
	 (p.existencia - vh.cantidad) as 'Existencia Actual',
 ef.fecha_pago as 'Fecha de Pago', 
--CON ESTA FUNCION OPTENGO LA DIFERECIAS EN DIAS, PUEDE SER AÑOS, MESES, SEMANAS, ETC.
DATEDIFF(DAY, vh.fecha_venta, ef.fecha_pago) as [Dias Transcurridos],
ef.estatus_Cobrado as 'Estatus de Pago',
ef.monto_pagado as 'Monto Pago',
vh.monto - ef.monto_pagado as 'Balance Pendiete'
FROM vendedor vd join region R
--UTILIZANDO LOS JOIN, PUEDO CREAR UNA RELACION ENTRE TODAS LAS TABLAS DE MI MODELO Y TRAER DATOS QUE 
--MUESTRAN UNA RELEVANCIA CORRECTA Y QUE PARA EL INFORME O EL REPORTE LA DA ENTENDIMIENTO A QUIEN LO LEE.
ON vd.id_region = R.id_region
join Ventas_Hechos vh
ON vh.id_vendedor = vd.id_vendedor
join cliente c
ON c.id_cliente = vh.id_cliente
join Productos p
ON p.id_producto = vh.id_producto
join ciudad ciu
ON ciu.id_ciudad = vh.id_ciudad
	join categoria_producto catpro
on catpro.id_categoria = p.id_categoria
join Condicion_factura cf
on cf.id_condicion=vh.id_condicion
join dias_factura df
on df.id_dias_factura =vh.id_dias_factura
join Estatus_Facturas ef
on vh.id_ventas = ef.id_ventas

join supervisor sup 
on sup.id_supervisor = vd.id_supervisor
join Fotos_supervisor FS 
on sup.id_supervisor=FS.id_supervisor
join Fotos_vendedor FV 
ON fv.id_vendedor=vd.id_vendedor
join Fotos_productos FP 
on fp.id_producto = p.id_producto

GROUP BY vh.No_facturas,vh.id_ventas, vh.fecha_venta,cf.id_condicion, p.descripcion,r.nombre,
         ciu.nombre_ciudad,ciu.latitud,ciu.longitud,vd.id_vendedor, vd.nombre_vendedor, fv.foto_Vendedor_url,
		 sup.supervisor, fs.foto_Supervisor_url,catpro.descripcion,P.descripcion, P.id_producto,
		 fp.Foto_productos_url, p.existencia,vh.cantidad,c.id_cliente,c.nombre_Negocio,CF.condicion, 
		 DF.dias_creditos,  p.precio_compra, vh.precio_ventas,vh.monto, ef.fecha_pago ,
		 ef.estatus_Cobrado, ef.monto_pagado

--SELECCIONAMOS LA VISTA MODIFICADA PARA VER SUS DATOS:

select * from Informe_ventas_Hechos_v_2022
where [Dias Transcurridos]='60'
order by id_ventas asc	

--CON LA SENTENCIA WHERE PUEDO APLICAR UN FILTRO NO IMPORTA EL QUE SEA COMO FECHA Y MOSTRAR EN ORDEN X.

select * from Informe_ventas_Hechos_v

select * from supervisor
select * from Fotos_supervisor
select * from vendedor
select * from cliente


--# -MOSTRAR LOS DEPARTAMENTOS Y LOS EMPLEADOS Y SUS SUELDOS DONDE EL DEPARTAMENTO SEA ADMINISTRACION Y SU POSICION.
create view vista_empleados 
as
SELECT e.id_Departamento as 'Codigo Departamento', id_empleados,
d.nombre_departamento as 'Nombre Departamento', 
e.Nombre as 'Nombre y Apellido Empleado', c.nombre_ciudad as 'Ciudad',  fecha_nacimiento,e.sueldo as 'Sueldo RD$', e.posicion as 'Posicion Actual', st.tipo_contrato as 'Tipo de Contrato',
fecha_entrada, 
DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) as 'Edad en Años',
DATEDIFF(YEAR, fecha_entrada, GETDATE()) as [Años en la Empresa], r.nombre as 'Region', st.Status_empleado
FROM empleados e
join departamento d 
ON e.id_Departamento = d.id_Departamento
join ciudad c 
on c.id_ciudad=e.id_ciudad
join region r 
on r.id_region=e.id_region
join status_empleado st on e.id_status_empleado = st.id_status_empleado
GROUP BY e.id_departamento, d.nombre_departamento,id_empleados, e.Nombre, e.sueldo, e.posicion,st.tipo_contrato,fecha_nacimiento,fecha_entrada, c.nombre_ciudad, r.nombre, st.Status_empleado
--order by sueldo desc

select * from vista_empleados

