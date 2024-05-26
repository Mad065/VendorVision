-- Active: 1715711027341@@127.0.0.1@3306@VendorVision


DELIMITER $$

-- Procedimiento para eliminar un Gerente
CREATE PROCEDURE Eliminar_Gerente(
    IN id_Gerente INT
)
BEGIN
    DELETE FROM Gerente WHERE id_Gerente = id_Gerente;
END$$

-- Procedimiento para eliminar una Tienda
CREATE PROCEDURE Eliminar_Tienda(
    IN id_Tienda INT
)
BEGIN
    DELETE FROM Tienda WHERE id_Tienda = id_Tienda;
END$$

-- Procedimiento para eliminar un Proveedor
CREATE PROCEDURE Eliminar_Proveedor(
    IN id_Proveedor INT
)
BEGIN
    DELETE FROM Proveedor WHERE id_Proveedor = id_Proveedor;
END$$

-- Procedimiento para eliminar un Producto
CREATE PROCEDURE Eliminar_Producto(
    IN id_Producto INT
)
BEGIN
    DELETE FROM Producto WHERE id_Producto = id_Producto;
END$$

DELIMITER ;
