-- ==========================================================
-- PRE-ENTREGA 5: Consultas con JOINs para el proyecto
-- Archivo: m5_consultas_joins.sql
-- Base de datos: Ventas_Tech_DB
-- ==========================================================

USE Ventas_Tech_DB;

-- ----------------------------------------------------------
-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Propósito: Consolidar una tabla maestra uniendo ventas, clientes, productos y categorías para alimentar el dashboard de Power BI.
SELECT 
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad AS region_cliente,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria;

-- Hallazgo: La consulta unifica de forma exitosa todas las transacciones con sus respectivas dimensiones geográficas y de categoría, 
-- generando una base de datos analítica lista para segmentar ventas en Power BI.


-- ----------------------------------------------------------
-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Propósito: detectar clientes registrados que nunca compraron, para que CRM los contacte.
SELECT 
    c.id_cliente,
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Hallazgo: 0 de los 5 clientes registrados carecen de compras; esto indica al equipo de CRM que la base de usuarios actual tiene un 100% de 
-- conversión inicial y no requiere campañas de activación por inactividad.


-- ----------------------------------------------------------
-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Propósito: identificar artículos del catálogo que no tienen ninguna venta registrada para que producto evalúe acciones (descuentos, 
-- discontinuar, etc.).
SELECT 
    p.nombre_producto,
    c.nombre_categoria,
    p.precio
FROM productos p
INNER JOIN categorias c ON p.id_categoria = c.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- Hallazgo: 0 de los 6 productos del catálogo carecen de movimiento; esto confirma al área de producto que todo el inventario activo tiene 
-- salida comercial y ningún artículo requiere liquidación urgente.


-- ----------------------------------------------------------
-- Consulta 4: Consolidado por canal (UNION ALL)
-- Propósito: unificar ventas de distintos orígenes o períodos y calcular el total facturado por cada canal de forma consolidada.
SELECT 
    canal, 
    SUM(total) AS total_canal 
FROM ( 
    SELECT 
        fecha_venta, 
        (cantidad * precio_unitario) AS total, 
        'Online' AS canal 
    FROM ventas 
    WHERE id_venta <= 5 
    
    UNION ALL 
    
    SELECT 
        fecha_venta, 
        (cantidad * precio_unitario) AS total, 
        'Presencial' AS canal 
    FROM ventas 
    WHERE id_venta > 5 
) AS consolidado 
GROUP BY canal;

-- Hallazgo: El canal Online concentra $7,210.00 en sus transacciones iniciales frente a los $5,940.00 generados por el canal Presencial, 
-- aportando una métrica clara de distribución de ingresos para el negocio.