-- Active: 1715711027341@@127.0.0.1@3306@VendorVision

DELIMITER $$

-- Procedimiento para eliminar un usuario y todas sus referencias en la base de datos
CREATE PROCEDURE Eliminar_Usuario(
    IN e_id_Usuario INT

BEGIN
    -- Eliminar relaciones entre Usuarios y Proveedores
    DELETE FROM Rel_Usuario_Proveedor WHERE id_Usuario = e_id_Usuario;

    -- Eliminar relaciones entre Usuarios y Gerentes
    DELETE FROM Rel_Usuario_Gerente WHERE id_Usuario = e_id_Usuario;

    -- Finalmente, eliminar el usuario de la tabla Usuario
    DELETE FROM Usuario WHERE id_Usuario = e_id_Usuario;
END$$

DELIMITER ;
