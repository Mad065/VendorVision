-- Active: 1715711027341@@127.0.0.1@3306@VendorVision
	
DELIMITER $$

-- Procedimiento para insertar un nuevo Gerente
CREATE PROCEDURE Insertar_Gerente(
    IN nombre_Gerente VARCHAR(50),
    IN apellidos VARCHAR(50),
    IN curp VARCHAR(18),
    IN edad INT,
    IN fechaNac DATE,
    IN id_Tipo_Tel INT
)
BEGIN
    INSERT INTO Gerente(nombre_Gerente, apellidos, curp, edad, fechaNac, id_Tipo_Tel) 
    VALUES(nombre_Gerente, apellidos, curp, edad, fechaNac, id_Tipo_Tel);
END$$

-- Procedimiento para insertar una nueva Tienda
CREATE PROCEDURE Insertar_Tienda(
    IN nombre_Tienda VARCHAR(50)
)
BEGIN
    INSERT INTO Tienda(nombre_Tienda) 
    VALUES(nombre_Tienda);
END$$

-- Procedimiento para insertar un nuevo Proveedor
CREATE PROCEDURE Insertar_Proveedor(
    IN nombre_Proveedor VARCHAR(50),
    IN apellidos_Proveedor VARCHAR(50),
    IN nombre_Empresa VARCHAR(50),
    IN id_Tipo_Tel INT
)
BEGIN
    INSERT INTO Proveedor(nombre_Proveedor, apellidos_Proveedor, nombre_Empresa, id_Tipo_Tel) 
    VALUES(nombre_Proveedor, apellidos_Proveedor, nombre_Empresa, id_Tipo_Tel);
END$$

-- Procedimiento para insertar un nuevo Producto
CREATE PROCEDURE Insertar_Producto(
    IN clave INT,
    IN nombre_Producto VARCHAR(50),
    IN descripcion VARCHAR(50),
    IN caducidad DATE,
    IN id_Tipo_Producto INT,
    IN cantidad INT
)
BEGIN
    INSERT INTO Producto(clave, nombre_Producto, descripcion, caducidad, id_Tipo_Producto, cantidad) 
    VALUES(clave, nombre_Producto, descripcion, caducidad, id_Tipo_Producto, cantidad);
END$$

-- Procedimiento para insertar una nueva Dirección
CREATE PROCEDURE Insertar_Direccion(
    IN colonia VARCHAR(50),
    IN calle VARCHAR(50),
    IN CP INT,
    IN ciudad VARCHAR(50),
    IN num_Int INT,
    IN num_Ext INT
)
BEGIN
    INSERT INTO Direccion(colonia, calle, CP, ciudad, num_Int, num_Ext) 
    VALUES(colonia, calle, CP, ciudad, num_Int, num_Ext);
END$$

-- Procedimiento para insertar un nuevo Usuario
CREATE PROCEDURE Insertar_Usuario(
    IN nombre_Usuario VARCHAR(50),
    IN correoE VARCHAR(50),
    IN contraseña VARCHAR(20)
)
BEGIN
    INSERT INTO Usuario(nombre_Usuario, correoE, contraseña) 
    VALUES(nombre_Usuario, correoE, contraseña);
END$$

DELIMITER ;
