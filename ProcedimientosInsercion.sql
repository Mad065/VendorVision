-- Active: 1715711027341@@127.0.0.1@3306@VendorVision
	
DELIMITER $$

-- Procedimiento para insertar un nuevo usuario
CREATE PROCEDURE Insertar_Usuario(
    IN nombre_Usuario VARCHAR(50),
    IN correoE VARCHAR(50),
    IN contraseña VARCHAR(20)
)
BEGIN
    INSERT INTO Usuario(nombre_Usuario, correoE, contraseña) VALUES(nombre_Usuario, correoE, contraseña);
END$$
