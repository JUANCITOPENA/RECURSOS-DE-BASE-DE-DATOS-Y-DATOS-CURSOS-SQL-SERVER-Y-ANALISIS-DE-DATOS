--VAMOS A HABLAR DE CTE:

/*
  Las CTEs (Expresiones de Tabla Comunes, por sus siglas en inglés) son una herramienta de programación SQL 
  que permiten crear una o varias consultas y guardar los resultados en una tabla temporal para su posterior
  uso en otras consultas. Las CTEs se utilizan con frecuencia en combinación con la instrucción SELECT para 
  simplificar la escritura de consultas complejas y reducir la complejidad del código.

  Existen varios tipos de CTEs, incluyendo CTEs recursivas, que permiten realizar consultas que se repiten 
  varias veces para obtener resultados específicos. Además, es posible utilizar múltiples CTEs en una misma 
  consulta para crear tablas temporales adicionales y combinar los resultados de diferentes consultas en una
  sola salida.

  CTE (Common Table Expression): Las expresiones de tabla comunes (CTE) son una característica de SQL que te 
  permite definir una consulta con nombre dentro de una consulta más grande. Esto puede hacer que las consultas
  sean más legibles y mantenibles, especialmente cuando se utilizan subconsultas complejas o se necesita referirse
  a la misma subconsulta varias veces en una consulta.

  Using CTEs with SELECT statement: Para utilizar una CTE en una consulta SELECT, primero debes definir la CTE 
  utilizando la sintaxis WITH. Luego, dentro de la consulta SELECT, puedes hacer referencia a la CTE como si
  fuera una tabla temporal. Por ejemplo, si tienes una CTE llamada "mi_cte", puedes hacer referencia a ella en
  una consulta SELECT como "SELECT * FROM mi_cte WHERE ...".

  Recursive CTEs: Las CTE recursivas son aquellas que se definen utilizando una consulta que se refiere a sí
  misma. Esto se utiliza a menudo para consultas que implican estructuras de datos jerárquicas, como árboles. 
  Para definir una CTE recursiva, debes utilizar la sintaxis WITH RECURSIVE. En la definición de la CTE, debes 
  incluir una consulta inicial que se utilizará como punto de partida para la recursión, así como una consulta 
  recursiva que se utilizará para seguir navegando por la jerarquía.

  Multiple CTEs: Puedes definir varias CTE en la misma consulta utilizando la sintaxis WITH. Cada CTE debe
  separarse con una coma y luego se pueden hacer referencia a ellas en la consulta principal como si fueran 
  tablas temporales. Esto es útil cuando tienes varias subconsultas complejas que deseas definir con nombre
  para mejorar la legibilidad y mantenibilidad de la consulta.

*/

-- VAMOS A CREAR UNA BASE DE DATOS DE PRUEBA:
CREATE DATABASE CTE_DB_PRUEBAS_2023;
GO

--VAMOS A UTILIZAR ESTA BASE DE DATO CTE_DB_PRUEBAS_2023:

USE CTE_DB_PRUEBAS_2023;
GO

--VAMOS A CREAR UNA TABLA LLAMADA customers:

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    customer_email VARCHAR(50),
    customer_phone VARCHAR(20)
);

--VAMOS A INSERTAR ALGUNOS REGISTROS A ESA TABLA:

INSERT INTO customers VALUES 
(1, 'John Smith', 'jsmith@gmail.com', '555-1234'),
(2, 'Jane Doe', 'jdoe@gmail.com', '555-5678'),
(3, 'Bob Johnson', 'bjohnson@gmail.com', '555-9012'),
(4, 'Sally Brown', 'sbrown@gmail.com', '555-3456'),
(5, 'Mike Lee', 'mlee@gmail.com', '555-7890');


--VAMOS A CREAR UNA TABLA LLAMADA orders:

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    order_total DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

--VAMOS A INSERTAR ALGUNOS REGISTROS A ESA TABLA:

INSERT INTO orders VALUES 
(1, '2022-01-01', 1, 100.00),
(2, '2022-01-02', 2, 200.00),
(3, '2022-01-03', 3, 300.00),
(4, '2022-01-04', 4, 400.00),
(5, '2022-01-05', 5, 500.00);


--VAMOS A CREAR UNA TABLA LLAMADA suppliers:

CREATE TABLE suppliers (
supplier_id INT PRIMARY KEY,
supplier_name VARCHAR(50),
contact_name VARCHAR(50),
address VARCHAR(100),
city VARCHAR(50),
country VARCHAR(50),
phone VARCHAR(15)
);

--VAMOS A INSERTAR ALGUNOS REGISTROS A ESA TABLA:

INSERT INTO suppliers VALUES
(1, 'ABC Suppliers', 'John Doe', '123 Main St', 'Anytown', 'USA', '555-1234'),
(2, 'XYZ Inc.', 'Jane Smith', '456 Oak St', 'Othertown', 'USA', '555-5678'),
(3, 'Acme Corp.', 'Mike Johnson', '789 Maple St', 'Someville', 'USA', '555-9012');



--VAMOS A CREAR UNA TABLA LLAMADA products:

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    product_description VARCHAR(255),
    product_price DECIMAL(10,2),
	supplier_id INT,
	FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

--VAMOS A INSERTAR ALGUNOS REGISTROS A ESA TABLA:

INSERT INTO products VALUES 
(1, 'Agua Purificada', 'De los Mejores Rios Tratada 100% Comfliable', 35.00,1),
(2, 'Leche Natural', 'Producto lácteo natural, sin aditivos ni conservantes, fresca y pasteurizada', 75.00,2),
(3, 'Yogur Natural', 'Yogur de leche fresca natural, sin saborizantes ni conservantes.', 60.00,3),
(4, 'Helado de Chocolate', ' Helado suave y cremoso con sabor a chocolate, elaborado con ingredientes de alta calidad y sin conservantes artificiales', 80.00,1),
(5, 'Galletas de Avena y Pasas', 'Hecho con ingredientes naturales y saludables como avena, pasas, harina integral, aceite de coco y miel.', 50.00,2);

--SELECCIONAMOS LA TABLA PARA VER LOS REGISTROS:

SELECT * FROM products;
SELECT * FROM suppliers;

--VAMOS A CREAR UNA TABLA LLAMADA order_items:

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

--VAMOS A INSERTAR ALGUNOS REGISTROS A ESA TABLA:

INSERT INTO order_items VALUES 
(1, 1, 2),
(1, 2, 1),
(2, 3, 3),
(3, 4, 2),
(4, 5, 1);


CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    employee_email VARCHAR(50),
    employee_phone VARCHAR(20),
    hire_date DATE
);

INSERT INTO employees VALUES 
(1, 'Sarah Johnson', 'sjohnson@gmail.com', '555-1234', '2020-01-01'),
(2, 'Mark Lee', 'mlee@gmail.com', '555-5678', '2020-01-02'),
(3, 'Emily Smith', 'esmith@gmail.com', '555-9012', '2020-01-03'),
(4, 'Mike Brown', 'mbrown@gmail.com', '555-3456', '2020-01-04'),
(5, 'Lisa Doe', 'ldoe@gmail.com', '555-7890', '2020-01-05');

--VAMOS A CREAR VARIAS CONSULTAS BASICAS Y AVANZADAS:

--Seleccionar todos los clientes de la tabla 'customers':

SELECT * FROM customers;

--Seleccionar el nombre y correo electrónico de los clientes que tengan un ID mayor que 2:

SELECT customer_name, customer_email FROM customers WHERE customer_id > 2;

--Seleccionar todos los pedidos y su fecha de la tabla 'orders':

SELECT * FROM orders;

--Seleccionar los detalles de los pedidos (número de pedido, fecha y total) junto con el nombre y correo electrónico del cliente correspondiente:

SELECT o.order_id, o.order_date, o.order_total, c.customer_name, c.customer_email
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

--Seleccionar los detalles de los productos (nombre y precio) de la tabla 'products', junto con el nombre y la ciudad del proveedor correspondiente:

SELECT p.product_name, p.product_price, s.supplier_name, s.city
FROM products p
INNER JOIN suppliers s ON p.supplier_id = s.supplier_id;

--Seleccionar los detalles de los pedidos (número de pedido, fecha y total) junto con los detalles de los productos (nombre y precio) y la cantidad pedida de cada producto:

SELECT o.order_id, o.order_date, o.order_total, p.product_name, p.product_price, oi.quantity
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id;

--Seleccionar los detalles de los empleados (nombre, correo electrónico y número de teléfono) que fueron contratados después del 1 de enero de 2022:

SELECT employee_name, employee_email, employee_phone
FROM employees
WHERE hire_date > '2020-01-01';


--VAMOS A REALIZAR ALGUNOS EJEMPLOS BASICO CON CTE:

--Ejemplo 1: Obtener los nombres de los clientes y la cantidad total de dinero que han gastado en pedidos:

WITH customer_total AS (
SELECT
customer_id,
SUM(order_total) AS total_amount
FROM
orders
GROUP BY
customer_id
)
SELECT
customers.customer_name,
customer_total.total_amount
FROM
customers
JOIN
customer_total ON customers.customer_id = customer_total.customer_id;

/*Este CTE (common table expression) calcula la cantidad total de dinero que cada cliente ha gastado en pedidos
y los une a la tabla de clientes. Luego, selecciona los nombres de los clientes y la cantidad total de dinero que han gastado.
*/


--Ejemplo 2: Obtener una lista de los productos junto con su nombre de proveedor y su precio:

WITH product_supplier AS (
SELECT
products.product_name,
suppliers.supplier_name,
products.product_price
FROM
products
JOIN
suppliers ON products.supplier_id = suppliers.supplier_id
)
SELECT
*
FROM
product_supplier;

/*
Este CTE obtiene los nombres de los productos, los nombres de los proveedores y los precios de los productos, 
y los une a la tabla de productos y proveedores. Luego, selecciona todo de la CTE para obtener una lista de
los productos junto con su nombre de proveedor y su precio.
*/


--Ejemplo 3: Obtener una lista de los clientes que han realizado pedidos de más de $200:

WITH big_spenders AS (
SELECT
customer_id
FROM
orders
WHERE
order_total > 200.00
GROUP BY
customer_id
)
SELECT
*
FROM
customers
WHERE
customer_id IN (
SELECT
customer_id
FROM
big_spenders
);

/*
Este CTE obtiene los ID de los clientes que han gastado más de $200 en pedidos y los une a la tabla de clientes. 
Luego, selecciona todo de la tabla de clientes donde los ID de los clientes coinciden con los ID de los clientes 
que se encuentran en la CTE.
*/

-- Ejemplo 4:-Consulta para mostrar la información de los clientes y sus órdenes:

WITH cte_customer_orders AS (
SELECT c.customer_name, o.order_id, o.order_date, o.order_total
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
)
SELECT *
FROM cte_customer_orders;

-- Ejemplo 5:-Consulta para mostrar los productos y sus proveedores correspondientes:

WITH cte_product_suppliers AS (
SELECT p.product_name, p.product_description, p.product_price, s.supplier_name, s.contact_name, s.phone
FROM products p
INNER JOIN suppliers s
ON p.supplier_id = s.supplier_id
)
SELECT *
FROM cte_product_suppliers;

-- Ejemplo 6:-Consulta para mostrar el total de ventas por cliente:

WITH cte_customer_sales AS (
SELECT c.customer_name, SUM(o.order_total) AS total_sales
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
)
SELECT *
FROM cte_customer_sales;

-- Ejemplo 7:-Consulta para mostrar los productos y la cantidad de cada uno vendido en cada orden:

WITH cte_order_products AS (
SELECT o.order_id, p.product_name, oi.quantity
FROM orders o
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id
)
SELECT *
FROM cte_order_products;

-- Ejemplo 8:-Consulta para mostrar la cantidad total de cada producto vendido:

WITH cte_product_sales AS (
SELECT p.product_name, SUM(oi.quantity) AS total_sales
FROM products p
INNER JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
)
SELECT *
FROM cte_product_sales;


/*

VAMOS HACER ALGUNOS EJEMPLOS AHORA CON:	(CTE (Common Table Expression):Creating CTEs, Using CTEs with SELECT statement, Recursive CTEs, Multiple CTEs.)

*/


--Ejemplo 1: Obtener el nombre del cliente, la fecha del pedido y la cantidad total para cada pedido

/*
En este ejemplo, vamos a crear una CTE que obtendrá el nombre del cliente, la fecha del pedido y la cantidad total
para cada pedido. Usaremos una JOIN para combinar la información de las tablas "customers", "orders" y "order_items".

*/

WITH order_summary AS (
SELECT c.customer_name, o.order_date, SUM(oi.quantity * p.product_price) AS order_total
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_name, o.order_date
)
SELECT * FROM order_summary;

/*
Explicación: En la CTE "order_summary", se une la tabla "customers" con "orders" y "order_items" 
para obtener el nombre del cliente, la fecha del pedido y la cantidad total para cada pedido. 
La tabla "products" se une a través de la tabla "order_items" para obtener el precio de cada producto 
y se utiliza para calcular el costo total de cada pedido. Luego, se utiliza una función de agregación 
SUM para sumar la cantidad total de cada pedido y agrupar por el nombre del cliente y la fecha del 
pedido. En la consulta final, se seleccionan todas las columnas de la CTE "order_summary".


*/

--Ejemplo 2: Obtener el nombre de los proveedores que no han vendido ningún producto

/*

En este ejemplo, vamos a crear una CTE que obtendrá el nombre de los proveedores que no han vendido ningún producto. 
Usaremos una LEFT JOIN para incluir todos los proveedores y una subconsulta para excluir a los proveedores que han
vendido productos.

*/

WITH suppliers_summary AS (
SELECT s.supplier_name, COUNT(p.product_id) AS num_products
FROM suppliers s
LEFT JOIN products p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_name
)
SELECT supplier_name FROM suppliers_summary
WHERE num_products = 0;


/*
Explicación: En la CTE "suppliers_summary", se realiza una LEFT JOIN entre las tablas "suppliers" y "products" 
para obtener el número de productos que cada proveedor ha vendido. La función COUNT se utiliza para contar
el número de registros en la tabla "products" para cada proveedor. Luego, se utiliza una subconsulta en la 
consulta final para seleccionar solo los proveedores que no tienen productos vendidos.

*/



--Ejemplo 3: Obtener los nombres de los productos que han sido ordenados más de una vez

/*

En este ejemplo, vamos a crear una CTE que obtendrá los nombres de los productos que han sido ordenados 
más de una vez. Usaremos una subconsulta y una función de ventana para realizar esta consulta.

*/

WITH product_orders AS (
SELECT p.product_name, COUNT(oi.order_id) AS num_orders,
ROW_NUMBER() OVER (PARTITION BY p.product_id ORDER BY COUNT(oi.order_id) DESC) AS row_num
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
)
SELECT product_name, num_orders FROM product_orders
WHERE row_num <= 1 AND num_orders >= 1;


/*
Explicación: En la CTE "product_orders", se unen las tablas "products" y "order_items" Entonces,
en la CTE "product_orders", se están uniendo las tablas "products" y "order_items". Es probable 
que la tabla "products" contenga información sobre los productos que la empresa vende, como su 
nombre, precio y descripción, mientras que la tabla "order_items" probablemente contenga información
sobre los pedidos de los clientes, como el número de pedido, la fecha y la cantidad de productos 
que se han ordenado.

Al unir estas dos tablas, la CTE "product_orders" probablemente esté creando una lista de todos los
productos que se han ordenado y los detalles de esas órdenes, como la cantidad y el precio. Esto
podría ser útil para la empresa para rastrear la popularidad de los productos y para ayudar en
la planificación de la producción y el inventario.

*/




-- Ejemplo 3: Multiple CTEs

/*
En este ejemplo, vamos a mostrar cómo se pueden utilizar múltiples CTEs en una sola consulta. Para ello,
vamos a utilizar la base de datos que hemos creado en los ejemplos anteriores.

Supongamos que queremos obtener una lista de todos los pedidos realizados por los clientes, junto con
la información del cliente y el total de ventas por cliente. Para hacerlo, necesitaremos unir las tablas
customers, orders y order_items y agruparlas por cliente. También necesitamos calcular la cantidad total 
vendida por cliente.

Podemos hacer esto utilizando múltiples CTEs. Primero, crearemos una CTE para unir las tablas customers,
orders y order_items. Luego, crearemos otra CTE para calcular el total de ventas por cliente. Finalmente, 
uniremos estas dos CTEs para obtener la lista de pedidos junto con la información del cliente y el total 
de ventas por cliente.


*/
WITH orders_by_customer AS (
    SELECT c.customer_name, o.order_id, o.order_date, oi.product_id, oi.quantity
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
),
sales_by_customer AS (
    SELECT customer_name, SUM(product_price * quantity) AS total_sales
    FROM orders_by_customer obc
    JOIN products p ON obc.product_id = p.product_id
    GROUP BY customer_name
)
SELECT obc.customer_name, obc.order_id, obc.order_date, p.product_name, obc.quantity, sbc.total_sales
FROM orders_by_customer obc
JOIN sales_by_customer sbc ON obc.customer_name = sbc.customer_name
JOIN products p ON obc.product_id = p.product_id
ORDER BY obc.customer_name, obc.order_id;

/*
En la primera CTE, orders_by_customer, unimos las tablas customers, orders y order_items y 
seleccionamos las columnas que necesitamos para calcular el total de ventas por cliente.

En la segunda CTE, sales_by_customer, calculamos el total de ventas por cliente a partir de la primera CTE.

Finalmente, unimos las dos CTEs en la consulta principal y seleccionamos las columnas 
que queremos mostrar en el resultado final.

Este es solo un ejemplo de cómo se pueden utilizar múltiples CTEs en una consulta. Las 
posibilidades son prácticamente infinitas, y solo están limitadas por la creatividad y 
la lógica de quien las escribe.

*/




/*
Queremos calcular la participación de cada producto en las ventas totales de cada cliente.
Para ello, primero necesitamos calcular el total de ventas de cada cliente. Luego, podemos 
unir esta información con la tabla order_items para obtener el precio total de cada producto
vendido por cada cliente. Finalmente, podemos calcular la participación de cada producto 
dividiendo su precio total por el total de ventas del cliente.
*/


WITH orders_by_customer AS (
    SELECT c.customer_name, o.order_id, o.order_date, oi.product_id, oi.quantity
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
),
sales_by_customer AS (
    SELECT customer_name, SUM(product_price * quantity) AS total_sales
    FROM orders_by_customer obc
    JOIN products p ON obc.product_id = p.product_id
    GROUP BY customer_name
),
total_sales AS (
    SELECT SUM(total_sales) AS sum_total_sales
    FROM sales_by_customer
)
SELECT obc.customer_name, obc.order_id, obc.order_date, p.product_name, obc.quantity, sbc.total_sales, 
       ROUND(sbc.total_sales / ts.sum_total_sales * 100, 2) AS participacion_porcentaje,
       ROUND(sbc.total_sales / ts.sum_total_sales, 2) AS participacion_venta_promedio
FROM orders_by_customer obc
JOIN sales_by_customer sbc ON obc.customer_name = sbc.customer_name
JOIN products p ON obc.product_id = p.product_id
CROSS JOIN total_sales ts
ORDER BY obc.customer_name, obc.order_id;




