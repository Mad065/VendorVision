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
DELIMITER $$

CREATE PROCEDURE Insertar_Gerente(
    IN nombre_Gerente VARCHAR(50),
    IN apellido_Gerente VARCHAR(50),
    IN CURP VARCHAR(18),
    IN edad INT,
    IN fechaNac DATE,

    IN nombre_Tienda VARCHAR(50),
    IN tel_Tienda VARCHAR(50),

    IN colonia VARCHAR(50),
    IN calle VARCHAR(50),
    IN CP INT,
    IN ciudad VARCHAR(50),
    IN num_int INT,
    IN num_ext INT,

    IN correoE VARCHAR(255)
)
BEGIN
    DECLARE id_Gerente INT;
    DECLARE id_Tienda INT;
    DECLARE id_Dir INT;
    DECLARE id_Usuario INT;

    -- Obtener el id del usuario a partir del correoE
    SELECT id_Usuario INTO id_Usuario FROM Usuario WHERE correoE = correoE;

    -- Insertar datos en la tabla Gerente
    INSERT INTO Gerente(nombre_Gerente, apellido_Gerente, CURP, edad, fechaNac) 
    VALUES(nombre_Gerente, apellido_Gerente, CURP, edad, fechaNac);
    SET id_Gerente = LAST_INSERT_ID();

    -- Insertar datos en la tabla Tienda
    INSERT INTO Tienda(nombre_Tienda, tel_Tienda) 
    VALUES(nombre_Tienda, tel_Tienda);
    SET id_Tienda = LAST_INSERT_ID();

    -- Insertar datos en la tabla Direccion
    INSERT INTO Direccion(colonia, calle, CP, ciudad, num_int, num_ext) 
    VALUES(colonia, calle, CP, ciudad, num_int, num_ext);
    SET id_Dir = LAST_INSERT_ID();

    -- Insertar datos en la tabla de relación Rel_Gerente_Tienda
    INSERT INTO Rel_Gerente_Tienda(id_Gerente, id_Tienda) 
    VALUES(id_Gerente, id_Tienda);

    -- Insertar datos en la tabla de relación Rel_Gerente_Dir
    INSERT INTO Rel_Gerente_Dir(id_Gerente, id_Dir) 
    VALUES(id_Gerente, id_Dir);

    -- Insertar datos en la tabla de relación rel_usuario_gerente
    INSERT INTO rel_Usuario_Gerente(id_Usuario, id_Gerente) 
    VALUES(id_Usuario, id_Gerente);
END$$

CREATE PROCEDURE Insertar_Proveedor(
    IN nombre_Proveedor VARCHAR(50),
    IN apellido_Proveedor VARCHAR(50),
    IN nombre_Empresa VARCHAR(50),

    IN colonia VARCHAR(50),
    IN calle VARCHAR(50),
    IN CP INT,
    IN ciudad VARCHAR(50),
    IN num_int INT,
    IN num_ext INT,

    IN correoE VARCHAR(255)
)
BEGIN
    DECLARE id_Proveedor INT;
    DECLARE id_Dir INT;
    DECLARE id_Usuario INT;

    -- Obtener el id del usuario a partir del correoE
    SELECT id_Usuario INTO id_Usuario FROM Usuario WHERE correoE = correoE;

    -- Insertar datos en la tabla Proveedor
    INSERT INTO Proveedor(nombre_Proveedor, apellido_Proveedor, nombre_Empresa) 
    VALUES(nombre_Proveedor, apellido_Proveedor, nombre_Empresa);
    SET id_Proveedor = LAST_INSERT_ID();

    -- Insertar datos en la tabla Direccion
    INSERT INTO Direccion(colonia, calle, CP, ciudad, num_int, num_ext) 
    VALUES(colonia, calle, CP, ciudad, num_int, num_ext);
    SET id_Dir = LAST_INSERT_ID();

    -- Insertar datos en la tabla de relación Rel_Proveedor_Dir
    INSERT INTO Rel_Proveedor_Dir(id_Proveedor, id_Dir) 
    VALUES(id_Proveedor, id_Dir);

    -- Insertar datos en la tabla de relación rel_usuario_proveedor
    INSERT INTO Rel_Usuario_Proveedor(id_Usuario, id_Proveedor) 
    VALUES(id_Usuario, id_Proveedor);
END$$


DELIMITER ;
