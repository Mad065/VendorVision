-- Active: 1715711027341@@127.0.0.1@3306@VendorVision

DELIMITER $$

-- Procedimiento para obtener datos de gerentes
CREATE PROCEDURE ObtenerDatosGerentes()
BEGIN
    SELECT 
        Usuario.nombre_Usuario,
        Gerente.nombre_Gerente,
        Gerente.apellido_Gerente,
        Tienda.nombre_Tienda,
        CONCAT(Direccion.calle, ' ', Direccion.num_Ext, ', ', Direccion.colonia, ', ', Direccion.ciudad, ', ', Direccion.CP) AS direccion,
        Usuario.correoE,
        COUNT(Pedido.id_Pedido) AS cantidad_pedidos
    FROM 
        Usuario
    INNER JOIN 
        Rel_Usuario_Gerente ON Usuario.id_Usuario = Rel_Usuario_Gerente.id_Usuario
    INNER JOIN 
        Gerente ON Rel_Usuario_Gerente.id_Gerente = Gerente.id_Gerente
    INNER JOIN 
        Rel_Gerente_Tienda ON Gerente.id_Gerente = Rel_Gerente_Tienda.id_Gerente
    INNER JOIN 
        Tienda ON Rel_Gerente_Tienda.id_Tienda = Tienda.id_Tienda
    LEFT JOIN 
        Rel_Gerente_Dir ON Gerente.id_Gerente = Rel_Gerente_Dir.id_Gerente
    LEFT JOIN 
        Direccion ON Rel_Gerente_Dir.id_Dir = Direccion.id_Dir
    LEFT JOIN 
        Rel_Pedido_Gerente ON Gerente.id_Gerente = Rel_Pedido_Gerente.id_Gerente
    LEFT JOIN
        Pedido ON Rel_Pedido_Gerente.id_Pedido = Pedido.id_Pedido
    GROUP BY 
        Usuario.nombre_Usuario, Gerente.nombre_Gerente, Gerente.apellido_Gerente, Tienda.nombre_Tienda, direccion, Usuario.correoE;
END$$

DELIMITER $$

-- Procedimiento para obtener datos de pedidos
CREATE PROCEDURE ObtenerDatosPedidos()
BEGIN
    SELECT 
        Gerente.id_Gerente,
        Producto.nombre_Producto,
        Producto.cantidad,
        Dinero_Producto.inversion,
        (Producto.cantidad * Dinero_Producto.inversion) AS importe_Total
    FROM 
        Gerente
    JOIN 
        Rel_Pedido_Gerente ON Gerente.id_Gerente = Rel_Pedido_Gerente.id_Gerente
    JOIN 
        Pedido ON Rel_Pedido_Gerente.id_Pedido = Pedido.id_Pedido
    JOIN 
        Producto ON Pedido.id_Producto = Producto.id_Producto
    JOIN 
        Rel_Producto_Dinero ON Producto.id_Producto = Rel_Producto_Dinero.id_Producto
    JOIN 
        Dinero_Producto ON Rel_Producto_Dinero.id_Dinero_Producto = Dinero_Producto.id_Dinero_Producto;
END$$

DELIMITER ;

