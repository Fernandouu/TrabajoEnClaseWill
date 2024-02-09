USE `coffeeshop`;
-- Mostrar las Tablas--
 
 SHOW Tables;
 
SELECT * FROM cliente; 
SELECT * FROM producto; 
SELECT * FROM pedido; 
SELECT * FROM detalle_pedido; 


-- Vista sobre los pedidos
-- Info del pedido (nombre, categoria, etc)
-- Info del producto
-- Info del cliente

SELECT nombre_cliente, direccion_pedido, estado_pedido, nombre_producto, dp.precio_producto, nombre_categoria, dp.id_Detalle
FROM cliente c INNER JOIN pedido p
ON c.id_cliente = p.id_cliente
INNER JOIN detalle_pedido dp ON
dp.id_pedido = p.id_pedido 
INNER JOIN producto pp ON
pp.id_producto = dp.id_producto 
INNER JOIN categoria cc ON
cc.id_categoria = pp.id_categoria; 

-- Vista de producto y su catagoria
SELECT * FROM categoria; 
SELECT * FROM producto; 

SELECT nombre_categoria, nombre_producto, p.id_producto, c.id_categoria FROM categoria c RIGHT JOIN producto p ON c.id_categoria = p.id_categoria;
SELECT nombre_categoria, nombre_producto, p.id_producto, c.id_categoria FROM categoria c LEFT JOIN producto p ON c.id_categoria = p.id_categoria;
SELECT nombre_categoria, nombre_producto, p.id_producto, c.id_categoria FROM categoria c INNER JOIN producto p ON c.id_categoria = p.id_categoria;

USE `ejemplos_db`;

SHOW TABLES;

SELECT * FROM detalle_pedido WHERE total = (
SELECT MAX(total) FROM detalle_pedido);

SELECT *FROM detalle_pedido WHERE total <= (
SELECT AVG(total) FROM detalle_pedido);

SELECT * FROM detalle_pedido WHERE id_producto  NOT
IN  (SELECT id_producto FROM producto 
WHERE nombre_producto IN ('Camisa', 'Pantalón', 'Zapatos'));

SELECT * FROM detalle_pedido WHERE id_producto  
IN  (SELECT id_producto FROM producto 
WHERE nombre_producto IN ('Camisa', 'Pantalón', 'Zapatos'));

SELECT id_pedido FROM detalle_pedido dp WHERE EXISTS (
    SELECT * FROM producto p
    WHERE dp.id_producto = p.id_producto AND p.existencia > 30
);

SELECT MAX(precio_producto) AS Max_Precio, MIN(precio_producto) AS Min_Precio
FROM producto;

SELECT pc.nombre_producto AS Producto_Mas_Caro, pc.precio_producto AS Precio_Mas_Caro, pc.descripcion_producto AS Descripcion_Mas_Caro,
       pn.nombre_producto AS Producto_Menor_Precio, pn.precio_producto AS Precio_Menor_Precio, pn.descripcion_producto AS Descripcion_Menor_Precio
FROM producto pc, producto pn
WHERE pc.precio_producto = (SELECT MAX(precio_producto) FROM producto)
AND pn.precio_producto = (SELECT MIN(precio_producto) FROM producto);