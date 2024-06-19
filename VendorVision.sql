/*
 Navicat Premium Data Transfer

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80300 (8.3.0)
 Source Host           : localhost:3306
 Source Schema         : VendorVision

 Target Server Type    : MySQL
 Target Server Version : 80300 (8.3.0)
 File Encoding         : 65001

 Date: 14/06/2024 23:22:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Administra
-- ----------------------------
DROP TABLE IF EXISTS `Administra`;
CREATE TABLE `Administra` (
  `id_Admin` int NOT NULL AUTO_INCREMENT,
  `id_Gerente` int DEFAULT NULL,
  `id_Producto` int DEFAULT NULL,
  `cantidad` decimal(10,2) DEFAULT NULL,
  `ganancia` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_Admin`),
  KEY `id_Gerente` (`id_Gerente`),
  KEY `id_Producto` (`id_Producto`),
  CONSTRAINT `administra_ibfk_1` FOREIGN KEY (`id_Gerente`) REFERENCES `Gerente` (`id_Gerente`),
  CONSTRAINT `administra_ibfk_2` FOREIGN KEY (`id_Producto`) REFERENCES `Producto` (`id_Producto`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Cat_Tipo_Producto
-- ----------------------------
DROP TABLE IF EXISTS `Cat_Tipo_Producto`;
CREATE TABLE `Cat_Tipo_Producto` (
  `id_Tipo_Producto` int NOT NULL AUTO_INCREMENT,
  `tipo_Producto` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_Tipo_Producto`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Cat_Tipo_Tel
-- ----------------------------
DROP TABLE IF EXISTS `Cat_Tipo_Tel`;
CREATE TABLE `Cat_Tipo_Tel` (
  `id_Tipo_Tel` int NOT NULL AUTO_INCREMENT,
  `tipo_Tel` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_Tipo_Tel`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Dinero_Producto
-- ----------------------------
DROP TABLE IF EXISTS `Dinero_Producto`;
CREATE TABLE `Dinero_Producto` (
  `id_Dinero_Producto` int NOT NULL AUTO_INCREMENT,
  `precio` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_Dinero_Producto`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Dinero_Venta
-- ----------------------------
DROP TABLE IF EXISTS `Dinero_Venta`;
CREATE TABLE `Dinero_Venta` (
  `id_Dinero_Venta` int NOT NULL,
  `cantidad_Vendida` int DEFAULT NULL,
  PRIMARY KEY (`id_Dinero_Venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Direccion
-- ----------------------------
DROP TABLE IF EXISTS `Direccion`;
CREATE TABLE `Direccion` (
  `id_Dir` int NOT NULL AUTO_INCREMENT,
  `colonia` varchar(50) DEFAULT NULL,
  `calle` varchar(50) DEFAULT NULL,
  `CP` int DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `num_Int` int DEFAULT NULL,
  `num_Ext` int DEFAULT NULL,
  PRIMARY KEY (`id_Dir`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Gerente
-- ----------------------------
DROP TABLE IF EXISTS `Gerente`;
CREATE TABLE `Gerente` (
  `id_Gerente` int NOT NULL AUTO_INCREMENT,
  `nombre_Gerente` varchar(50) DEFAULT NULL,
  `apellido_Gerente` varchar(50) DEFAULT NULL,
  `CURP` varchar(18) DEFAULT NULL,
  `fechaNac` date DEFAULT NULL,
  PRIMARY KEY (`id_Gerente`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Pedido
-- ----------------------------
DROP TABLE IF EXISTS `Pedido`;
CREATE TABLE `Pedido` (
  `id_Pedido` int NOT NULL AUTO_INCREMENT,
  `id_Producto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `confirmado` binary(1) DEFAULT NULL,
  `entregado` binary(1) DEFAULT NULL,
  PRIMARY KEY (`id_Pedido`),
  KEY `id_Producto` (`id_Producto`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_Producto`) REFERENCES `Producto` (`id_Producto`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Producto
-- ----------------------------
DROP TABLE IF EXISTS `Producto`;
CREATE TABLE `Producto` (
  `id_Producto` int NOT NULL AUTO_INCREMENT,
  `clave` int DEFAULT NULL,
  `nombre_Producto` varchar(50) DEFAULT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `caducidad` date DEFAULT NULL,
  `id_Tipo_Producto` int DEFAULT NULL,
  PRIMARY KEY (`id_Producto`),
  KEY `id_Tipo_Producto` (`id_Tipo_Producto`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`id_Tipo_Producto`) REFERENCES `Cat_Tipo_Producto` (`id_Tipo_Producto`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Proveedor
-- ----------------------------
DROP TABLE IF EXISTS `Proveedor`;
CREATE TABLE `Proveedor` (
  `id_Proveedor` int NOT NULL AUTO_INCREMENT,
  `nombre_Proveedor` varchar(50) DEFAULT NULL,
  `apellidos_Proveedor` varchar(50) DEFAULT NULL,
  `nombre_Empresa` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_Proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Rel_Gerente_Dir
-- ----------------------------
DROP TABLE IF EXISTS `Rel_Gerente_Dir`;
CREATE TABLE `Rel_Gerente_Dir` (
  `id_Rel_Gerente_Dir` int NOT NULL AUTO_INCREMENT,
  `id_Gerente` int DEFAULT NULL,
  `id_Dir` int DEFAULT NULL,
  PRIMARY KEY (`id_Rel_Gerente_Dir`),
  KEY `id_Gerente` (`id_Gerente`),
  KEY `id_Dir` (`id_Dir`),
  CONSTRAINT `rel_gerente_dir_ibfk_1` FOREIGN KEY (`id_Gerente`) REFERENCES `Gerente` (`id_Gerente`),
  CONSTRAINT `rel_gerente_dir_ibfk_2` FOREIGN KEY (`id_Dir`) REFERENCES `Direccion` (`id_Dir`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Rel_Gerente_Tel
-- ----------------------------
DROP TABLE IF EXISTS `Rel_Gerente_Tel`;
CREATE TABLE `Rel_Gerente_Tel` (
  `id_Rel_Gerente_Tel` int NOT NULL AUTO_INCREMENT,
  `id_Gerente` int DEFAULT NULL,
  `id_Tel` int DEFAULT NULL,
  `id_Tipo_Tel` int DEFAULT NULL,
  PRIMARY KEY (`id_Rel_Gerente_Tel`),
  KEY `id_Gerente` (`id_Gerente`),
  KEY `id_Tel` (`id_Tel`),
  KEY `id_Tipo_Tel` (`id_Tipo_Tel`),
  CONSTRAINT `rel_gerente_tel_ibfk_1` FOREIGN KEY (`id_Gerente`) REFERENCES `Gerente` (`id_Gerente`),
  CONSTRAINT `rel_gerente_tel_ibfk_2` FOREIGN KEY (`id_Tel`) REFERENCES `Telefono` (`id_Tel`),
  CONSTRAINT `rel_gerente_tel_ibfk_3` FOREIGN KEY (`id_Tipo_Tel`) REFERENCES `Cat_Tipo_Tel` (`id_Tipo_Tel`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Rel_Gerente_Tienda
-- ----------------------------
DROP TABLE IF EXISTS `Rel_Gerente_Tienda`;
CREATE TABLE `Rel_Gerente_Tienda` (
  `id_Rel_Gerente_Tienda` int NOT NULL AUTO_INCREMENT,
  `id_Gerente` int DEFAULT NULL,
  `id_Tienda` int DEFAULT NULL,
  PRIMARY KEY (`id_Rel_Gerente_Tienda`),
  KEY `id_Gerente` (`id_Gerente`),
  KEY `id_Tienda` (`id_Tienda`),
  CONSTRAINT `rel_gerente_tienda_ibfk_1` FOREIGN KEY (`id_Gerente`) REFERENCES `Gerente` (`id_Gerente`),
  CONSTRAINT `rel_gerente_tienda_ibfk_2` FOREIGN KEY (`id_Tienda`) REFERENCES `Tienda` (`id_Tienda`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Rel_Pedido_Gerente
-- ----------------------------
DROP TABLE IF EXISTS `Rel_Pedido_Gerente`;
CREATE TABLE `Rel_Pedido_Gerente` (
  `id_Rel_Pedido_Gerente` int NOT NULL AUTO_INCREMENT,
  `id_Pedido` int DEFAULT NULL,
  `id_Gerente` int DEFAULT NULL,
  PRIMARY KEY (`id_Rel_Pedido_Gerente`),
  KEY `id_Pedido` (`id_Pedido`),
  KEY `id_Gerente` (`id_Gerente`),
  CONSTRAINT `rel_pedido_gerente_ibfk_1` FOREIGN KEY (`id_Pedido`) REFERENCES `Pedido` (`id_Pedido`),
  CONSTRAINT `rel_pedido_gerente_ibfk_2` FOREIGN KEY (`id_Gerente`) REFERENCES `Gerente` (`id_Gerente`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Rel_Producto_Dinero
-- ----------------------------
DROP TABLE IF EXISTS `Rel_Producto_Dinero`;
CREATE TABLE `Rel_Producto_Dinero` (
  `id_Rel_Producto_Dinero` int NOT NULL AUTO_INCREMENT,
  `id_Producto` int DEFAULT NULL,
  `id_Dinero_Producto` int DEFAULT NULL,
  PRIMARY KEY (`id_Rel_Producto_Dinero`),
  KEY `id_Producto` (`id_Producto`),
  KEY `id_Dinero_Producto` (`id_Dinero_Producto`),
  CONSTRAINT `rel_producto_dinero_ibfk_1` FOREIGN KEY (`id_Producto`) REFERENCES `Producto` (`id_Producto`),
  CONSTRAINT `rel_producto_dinero_ibfk_2` FOREIGN KEY (`id_Dinero_Producto`) REFERENCES `Dinero_Producto` (`id_Dinero_Producto`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Rel_Proveedor_Dir
-- ----------------------------
DROP TABLE IF EXISTS `Rel_Proveedor_Dir`;
CREATE TABLE `Rel_Proveedor_Dir` (
  `id_Rel_Proveedor_Dir` int NOT NULL AUTO_INCREMENT,
  `id_Proveedor` int DEFAULT NULL,
  `id_Dir` int DEFAULT NULL,
  PRIMARY KEY (`id_Rel_Proveedor_Dir`),
  KEY `id_Proveedor` (`id_Proveedor`),
  KEY `id_Dir` (`id_Dir`),
  CONSTRAINT `rel_proveedor_dir_ibfk_1` FOREIGN KEY (`id_Proveedor`) REFERENCES `Proveedor` (`id_Proveedor`),
  CONSTRAINT `rel_proveedor_dir_ibfk_2` FOREIGN KEY (`id_Dir`) REFERENCES `Direccion` (`id_Dir`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Rel_Proveedor_Pedido
-- ----------------------------
DROP TABLE IF EXISTS `Rel_Proveedor_Pedido`;
CREATE TABLE `Rel_Proveedor_Pedido` (
  `id_Rel_Proveedor_Pedido` int NOT NULL AUTO_INCREMENT,
  `id_Proveedor` int DEFAULT NULL,
  `id_Pedido` int DEFAULT NULL,
  PRIMARY KEY (`id_Rel_Proveedor_Pedido`),
  KEY `id_Proveedor` (`id_Proveedor`),
  KEY `id_Pedido` (`id_Pedido`),
  CONSTRAINT `rel_proveedor_pedido_ibfk_1` FOREIGN KEY (`id_Proveedor`) REFERENCES `Proveedor` (`id_Proveedor`),
  CONSTRAINT `rel_proveedor_pedido_ibfk_2` FOREIGN KEY (`id_Pedido`) REFERENCES `Pedido` (`id_Pedido`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Rel_Proveedor_Tel
-- ----------------------------
DROP TABLE IF EXISTS `Rel_Proveedor_Tel`;
CREATE TABLE `Rel_Proveedor_Tel` (
  `id_Rel_Proveedor_Tel` int NOT NULL AUTO_INCREMENT,
  `id_Proveedor` int DEFAULT NULL,
  `id_Tel` int DEFAULT NULL,
  `id_Tipo_Tel` int DEFAULT NULL,
  PRIMARY KEY (`id_Rel_Proveedor_Tel`),
  KEY `id_Proveedor` (`id_Proveedor`),
  KEY `id_Tel` (`id_Tel`),
  KEY `id_Tipo_Tel` (`id_Tipo_Tel`),
  CONSTRAINT `rel_proveedor_tel_ibfk_1` FOREIGN KEY (`id_Proveedor`) REFERENCES `Proveedor` (`id_Proveedor`),
  CONSTRAINT `rel_proveedor_tel_ibfk_2` FOREIGN KEY (`id_Tel`) REFERENCES `Telefono` (`id_Tel`),
  CONSTRAINT `rel_proveedor_tel_ibfk_3` FOREIGN KEY (`id_Tipo_Tel`) REFERENCES `Cat_Tipo_Tel` (`id_Tipo_Tel`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Rel_Usuario_Gerente
-- ----------------------------
DROP TABLE IF EXISTS `Rel_Usuario_Gerente`;
CREATE TABLE `Rel_Usuario_Gerente` (
  `id_Rel_Usuario_Gerente` int NOT NULL AUTO_INCREMENT,
  `id_Usuario` int DEFAULT NULL,
  `id_Gerente` int DEFAULT NULL,
  PRIMARY KEY (`id_Rel_Usuario_Gerente`),
  KEY `id_Usuario` (`id_Usuario`),
  KEY `id_Gerente` (`id_Gerente`),
  CONSTRAINT `rel_usuario_gerente_ibfk_1` FOREIGN KEY (`id_Usuario`) REFERENCES `Usuario` (`id_Usuario`),
  CONSTRAINT `rel_usuario_gerente_ibfk_2` FOREIGN KEY (`id_Gerente`) REFERENCES `Gerente` (`id_Gerente`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Rel_Usuario_Proveedor
-- ----------------------------
DROP TABLE IF EXISTS `Rel_Usuario_Proveedor`;
CREATE TABLE `Rel_Usuario_Proveedor` (
  `id_Rel_Usuario_Proveedor` int NOT NULL AUTO_INCREMENT,
  `id_Usuario` int DEFAULT NULL,
  `id_Proveedor` int DEFAULT NULL,
  PRIMARY KEY (`id_Rel_Usuario_Proveedor`),
  KEY `id_Usuario` (`id_Usuario`),
  KEY `id_Proveedor` (`id_Proveedor`),
  CONSTRAINT `rel_usuario_proveedor_ibfk_1` FOREIGN KEY (`id_Usuario`) REFERENCES `Usuario` (`id_Usuario`),
  CONSTRAINT `rel_usuario_proveedor_ibfk_2` FOREIGN KEY (`id_Proveedor`) REFERENCES `Proveedor` (`id_Proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Suministro
-- ----------------------------
DROP TABLE IF EXISTS `Suministro`;
CREATE TABLE `Suministro` (
  `id_Suministro` int NOT NULL AUTO_INCREMENT,
  `id_Proveedor` int DEFAULT NULL,
  `id_Producto` int DEFAULT NULL,
  PRIMARY KEY (`id_Suministro`),
  KEY `id_Proveedor` (`id_Proveedor`),
  KEY `id_Producto` (`id_Producto`),
  CONSTRAINT `suministro_ibfk_1` FOREIGN KEY (`id_Proveedor`) REFERENCES `Proveedor` (`id_Proveedor`),
  CONSTRAINT `suministro_ibfk_2` FOREIGN KEY (`id_Producto`) REFERENCES `Producto` (`id_Producto`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Telefono
-- ----------------------------
DROP TABLE IF EXISTS `Telefono`;
CREATE TABLE `Telefono` (
  `id_Tel` int NOT NULL AUTO_INCREMENT,
  `telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_Tel`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Tienda
-- ----------------------------
DROP TABLE IF EXISTS `Tienda`;
CREATE TABLE `Tienda` (
  `id_Tienda` int NOT NULL AUTO_INCREMENT,
  `nombre_Tienda` varchar(50) DEFAULT NULL,
  `tel_Tienda` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_Tienda`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Usuario
-- ----------------------------
DROP TABLE IF EXISTS `Usuario`;
CREATE TABLE `Usuario` (
  `id_Usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_Usuario` varchar(50) DEFAULT NULL,
  `correoE` varchar(50) DEFAULT NULL,
  `contraseña` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for Venta_Producto
-- ----------------------------
DROP TABLE IF EXISTS `Venta_Producto`;
CREATE TABLE `Venta_Producto` (
  `id_Venta` int NOT NULL AUTO_INCREMENT,
  `id_Gerente` int DEFAULT NULL,
  `id_Producto` int DEFAULT NULL,
  `id_Dinero_Venta` int DEFAULT NULL,
  `fecha_Venta` date DEFAULT NULL,
  PRIMARY KEY (`id_Venta`) USING BTREE,
  KEY `id_Gerente` (`id_Gerente`),
  KEY `id_Producto` (`id_Producto`),
  KEY `venta_producto_ibfk_3` (`id_Dinero_Venta`),
  CONSTRAINT `venta_producto_ibfk_1` FOREIGN KEY (`id_Gerente`) REFERENCES `Gerente` (`id_Gerente`),
  CONSTRAINT `venta_producto_ibfk_2` FOREIGN KEY (`id_Producto`) REFERENCES `Producto` (`id_Producto`),
  CONSTRAINT `venta_producto_ibfk_3` FOREIGN KEY (`id_Dinero_Venta`) REFERENCES `Dinero_Venta` (`id_Dinero_Venta`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Procedure structure for Insertar_Gerente
-- ----------------------------
DROP PROCEDURE IF EXISTS `Insertar_Gerente`;
delimiter ;;
CREATE PROCEDURE `Insertar_Gerente`(IN p_nombre_Gerente VARCHAR(50),
    IN p_apellido_Gerente VARCHAR(50),
    IN p_CURP VARCHAR(18),
    IN p_fechaNac DATE,
    IN p_nombre_Tienda VARCHAR(50),
    IN p_tel_Tienda VARCHAR(50),
    IN p_colonia VARCHAR(50),
    IN p_calle VARCHAR(50),
    IN p_CP INT,
    IN p_ciudad VARCHAR(50),
    IN p_num_int INT,
    IN p_num_ext INT,
    IN p_correoE VARCHAR(255))
BEGIN
    DECLARE v_id_Gerente INT;
    DECLARE v_id_Tienda INT;
    DECLARE v_id_Dir INT;
    DECLARE v_id_Usuario INT;

    -- Verificar si el correo ya está registrado en la tabla de usuarios
    SELECT id_Usuario INTO v_id_Usuario FROM Usuario WHERE correoE = p_correoE LIMIT 1;
    
    -- Si el correo no está registrado, devolver un mensaje de error
    IF v_id_Usuario IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo no está registrado en la tabla de usuarios';
    END IF;

    -- Insertar datos en la tabla Gerente
    INSERT INTO Gerente(nombre_Gerente, apellido_Gerente, CURP, fechaNac) 
    VALUES(p_nombre_Gerente, p_apellido_Gerente, p_CURP, p_fechaNac);
    SET v_id_Gerente = LAST_INSERT_ID();

    -- Insertar datos en la tabla Tienda
    INSERT INTO Tienda(nombre_Tienda, tel_Tienda) 
    VALUES(p_nombre_Tienda, p_tel_Tienda);
    SET v_id_Tienda = LAST_INSERT_ID();

    -- Insertar datos en la tabla Direccion
    INSERT INTO Direccion(colonia, calle, CP, ciudad, num_int, num_ext) 
    VALUES(p_colonia, p_calle, p_CP, p_ciudad, p_num_int, p_num_ext);
    SET v_id_Dir = LAST_INSERT_ID();

    -- Insertar datos en la tabla de relación Rel_Gerente_Tienda
    INSERT INTO Rel_Gerente_Tienda(id_Gerente, id_Tienda) 
    VALUES(v_id_Gerente, v_id_Tienda);

    -- Insertar datos en la tabla de relación Rel_Gerente_Dir
    INSERT INTO Rel_Gerente_Dir(id_Gerente, id_Dir) 
    VALUES(v_id_Gerente, v_id_Dir);

    -- Insertar datos en la tabla de relación rel_usuario_gerente
    INSERT INTO Rel_Usuario_Gerente(id_Usuario, id_Gerente) 
    VALUES(v_id_Usuario, v_id_Gerente);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Insertar_Pedido
-- ----------------------------
DROP PROCEDURE IF EXISTS `Insertar_Pedido`;
delimiter ;;
CREATE PROCEDURE `Insertar_Pedido`(IN clave_producto INT,
    IN correo_usuario VARCHAR(50),
    IN cantidad_pedida INT,
    IN fecha_pedido DATE)
BEGIN
    DECLARE id_producto INT;
    DECLARE id_gerente INT;
    DECLARE id_pedido INT;
    DECLARE id_proveedor INT;

    -- Obtener el ID del producto usando la clave
    SELECT id_Producto INTO id_producto FROM Producto WHERE clave = clave_producto;

    -- Obtener el ID del gerente usando el correo
    SELECT id_Gerente INTO id_gerente FROM Gerente WHERE id_Gerente = (
        SELECT id_Gerente FROM Rel_Usuario_Gerente 
        WHERE id_Usuario = (SELECT id_Usuario FROM Usuario WHERE correoE = correo_usuario)
    );

    -- Obtener el ID del proveedor para el producto
    SELECT id_Proveedor INTO id_proveedor FROM Suministro WHERE id_Producto = id_producto;

    -- Insertar en la tabla Pedido
    INSERT INTO Pedido (id_Producto, cantidad, fecha) VALUES (id_producto, cantidad_pedida, fecha_pedido);
    
    -- Obtener el ID del pedido recién insertado
    SET id_pedido = LAST_INSERT_ID();

    -- Insertar en la tabla Rel_Pedido_Gerente
    INSERT INTO Rel_Pedido_Gerente (id_Pedido, id_Gerente) VALUES (id_pedido, id_gerente);

    -- Insertar en la tabla Rel_Proveedor_Pedido
    INSERT INTO Rel_Proveedor_Pedido (id_Proveedor, id_Pedido) VALUES (id_proveedor, id_pedido);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Insertar_Proveedor
-- ----------------------------
DROP PROCEDURE IF EXISTS `Insertar_Proveedor`;
delimiter ;;
CREATE PROCEDURE `Insertar_Proveedor`(IN p_nombre_Proveedor VARCHAR(50),
    IN p_apellidos_Proveedor VARCHAR(50),
    IN p_nombre_Empresa VARCHAR(50),
    IN p_colonia VARCHAR(50),
    IN p_calle VARCHAR(50),
    IN p_CP INT,
    IN p_ciudad VARCHAR(50),
    IN p_num_int INT,
    IN p_num_ext INT,
    IN p_correoE VARCHAR(255))
BEGIN
    DECLARE v_id_Proveedor INT;
    DECLARE v_id_Dir INT;
    DECLARE v_id_Usuario INT;

    -- Verificar si el correo ya está registrado en la tabla de usuarios
    SELECT id_Usuario INTO v_id_Usuario FROM Usuario WHERE correoE = p_correoE LIMIT 1;

    -- Si el correo no está registrado, devolver un mensaje de error
    IF v_id_Usuario IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo no está registrado en la tabla de usuarios';
    END IF;

    -- Insertar datos en la tabla Proveedor
    INSERT INTO Proveedor(nombre_Proveedor, apellidos_Proveedor, nombre_Empresa) 
    VALUES(p_nombre_Proveedor, p_apellidos_Proveedor, p_nombre_Empresa);
    SET v_id_Proveedor = LAST_INSERT_ID();

    -- Insertar datos en la tabla Direccion
    INSERT INTO Direccion(colonia, calle, CP, ciudad, num_int, num_ext) 
    VALUES(p_colonia, p_calle, p_CP, p_ciudad, p_num_int, p_num_ext);
    SET v_id_Dir = LAST_INSERT_ID();

    -- Insertar datos en la tabla de relación Rel_Proveedor_Dir
    INSERT INTO Rel_Proveedor_Dir(id_Proveedor, id_Dir) 
    VALUES(v_id_Proveedor, v_id_Dir);

    -- Insertar datos en la tabla de relación Rel_Usuario_Proveedor
    INSERT INTO Rel_Usuario_Proveedor(id_Usuario, id_Proveedor) 
    VALUES(v_id_Usuario, v_id_Proveedor);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Insertar_Usuario
-- ----------------------------
DROP PROCEDURE IF EXISTS `Insertar_Usuario`;
delimiter ;;
CREATE PROCEDURE `Insertar_Usuario`(IN nombre_Usuario VARCHAR(50),
    IN correoE VARCHAR(50),
    IN contraseña VARCHAR(20))
BEGIN
    INSERT INTO Usuario(nombre_Usuario, correoE, contraseña) VALUES(nombre_Usuario, correoE, contraseña);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Modificar_Ganancia_Producto
-- ----------------------------
DROP PROCEDURE IF EXISTS `Modificar_Ganancia_Producto`;
delimiter ;;
CREATE PROCEDURE `Modificar_Ganancia_Producto`(IN p_clave INT,
    IN p_ganancia DECIMAL(10, 2))
BEGIN
    DECLARE producto_id INT;

    -- Obtener el ID del producto
    SELECT id_Producto INTO producto_id
    FROM Producto
    WHERE clave = p_clave;

    -- Verificar si se encontró el producto
    IF producto_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Producto no encontrado';
    END IF;

    -- Actualizar la ganancia del producto
    UPDATE Dinero_Producto dp
    INNER JOIN Rel_Producto_Dinero rpd ON dp.id_Dinero_Producto = rpd.id_Dinero_Producto
    SET dp.ganancia = p_ganancia
    WHERE rpd.id_Producto = producto_id;

    -- Comprobar si se realizaron cambios
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se pudo modificar la ganancia del producto';
    END IF;

    SELECT 'Ganancia del producto modificada exitosamente' AS message;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Modificar_Producto
-- ----------------------------
DROP PROCEDURE IF EXISTS `Modificar_Producto`;
delimiter ;;
CREATE PROCEDURE `Modificar_Producto`(IN `p_clave` INT,
    IN `p_nombre_Producto` VARCHAR(255),
    IN `p_descripcion` TEXT,
    IN `p_caducidad` DATE,
    IN `p_precio` DECIMAL(10,2),
    IN `p_tipo_Producto` VARCHAR(255))
BEGIN
    DECLARE tipoProductoId INT;
    
    -- Obtener el ID del tipo de producto
    SELECT id_Tipo_Producto INTO tipoProductoId FROM Cat_Tipo_Producto WHERE tipo_Producto = p_tipo_Producto;
    
    -- Actualizar el producto
    UPDATE Producto 
    SET 
        nombre_Producto = p_nombre_Producto, 
        descripcion = p_descripcion, 
        caducidad = p_caducidad, 
        id_Tipo_Producto = tipoProductoId
    WHERE 
        clave = p_clave;
    
    -- Actualizar el precio del producto
    UPDATE Dinero_Producto dp 
    INNER JOIN Rel_Producto_Dinero rpd ON dp.id_Dinero_Producto = rpd.id_Dinero_Producto 
    INNER JOIN Producto p ON rpd.id_Producto = p.id_Producto 
    SET 
        dp.precio = p_precio 
    WHERE 
        p.clave = p_clave;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ObtenerDatosGerentes
-- ----------------------------
DROP PROCEDURE IF EXISTS `ObtenerDatosGerentes`;
delimiter ;;
CREATE PROCEDURE `ObtenerDatosGerentes`()
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ObtenerDatosProductos
-- ----------------------------
DROP PROCEDURE IF EXISTS `ObtenerDatosProductos`;
delimiter ;;
CREATE PROCEDURE `ObtenerDatosProductos`(IN clave INT)
BEGIN
    SELECT 
        Producto.nombre_Producto,
        Producto.descripcion,
        Administra.cantidad,
        Producto.caducidad,
        Cat_Tipo_Producto.tipo_Producto,
        Dinero_Producto.precio,
        Dinero_Venta.ganancia
    FROM 
        Producto
    JOIN 
        Rel_Producto_Dinero ON Producto.id_Producto = Rel_Producto_Dinero.id_Producto
    JOIN 
        Administra ON Producto.id_Producto = Administra.id_Producto 
    JOIN 
        Dinero_Producto ON Rel_Producto_Dinero.id_Dinero_Producto = Dinero_Producto.id_Dinero_Producto
    JOIN 
        Dinero_Venta ON Dinero_Producto.id_Dinero_Producto = Dinero_Venta.id_Dinero_Venta
    JOIN
        Cat_Tipo_Producto ON Producto.id_Tipo_Producto = Cat_Tipo_Producto.id_Tipo_Producto
    WHERE 
        Producto.clave = clave;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ObtenerDatosProveedores
-- ----------------------------
DROP PROCEDURE IF EXISTS `ObtenerDatosProveedores`;
delimiter ;;
CREATE PROCEDURE `ObtenerDatosProveedores`()
BEGIN
    SELECT 
        Usuario.nombre_Usuario,
        Proveedor.nombre_Proveedor,
        Proveedor.apellidos_Proveedor,
        Proveedor.nombre_Empresa,
        CONCAT(Direccion.calle, ' ', Direccion.num_Ext, ', ', Direccion.colonia, ', ', Direccion.ciudad, ', ', Direccion.CP) AS direccion,
        Usuario.correoE,
        COUNT(Pedido.id_Pedido) AS cantidad_pedidos
    FROM 
        Usuario
    INNER JOIN 
        Rel_Usuario_Proveedor ON Usuario.id_Usuario = Rel_Usuario_Proveedor.id_Usuario
    INNER JOIN 
        Proveedor ON Rel_Usuario_Proveedor.id_Proveedor = Proveedor.id_Proveedor
    LEFT JOIN 
        Rel_Proveedor_Dir ON Proveedor.id_Proveedor = Rel_Proveedor_Dir.id_Proveedor
    LEFT JOIN 
        Direccion ON Rel_Proveedor_Dir.id_Dir = Direccion.id_Dir
    LEFT JOIN 
        Rel_Proveedor_Pedido ON Proveedor.id_Proveedor = Rel_Proveedor_Pedido.id_Proveedor
    LEFT JOIN
        Pedido ON Rel_Proveedor_Pedido.id_Pedido = Pedido.id_Pedido
    GROUP BY 
        Usuario.nombre_Usuario, Proveedor.nombre_Proveedor, Proveedor.apellidos_Proveedor, Proveedor.nombre_Empresa, direccion, Usuario.correoE;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ObtenerPedidos
-- ----------------------------
DROP PROCEDURE IF EXISTS `ObtenerPedidos`;
delimiter ;;
CREATE PROCEDURE `ObtenerPedidos`(IN correoE VARCHAR(50))
BEGIN
    SELECT 
        p.id_Pedido, 
        pr.nombre_Producto, 
        p.cantidad, 
        p.fecha, 
        p.confirmado, 
        p.entregado,
        g.nombre_Gerente
    FROM 
        Pedido p
    INNER JOIN 
        Producto pr ON p.id_Producto = pr.id_Producto
    INNER JOIN 
        Rel_Proveedor_Pedido rpp ON rpp.id_Pedido = p.id_Pedido
    INNER JOIN 
        Proveedor pv ON rpp.id_Proveedor = pv.id_Proveedor
    INNER JOIN 
        Gerente g ON p.id_Gerente = g.id_Gerente
    WHERE 
        pv.id_Proveedor IN (
            SELECT 
                rp.id_Proveedor
            FROM 
                Rel_Usuario_Proveedor rup
            INNER JOIN 
                Usuario u ON rup.id_Usuario = u.id_Usuario
            INNER JOIN 
                Proveedor rp ON rup.id_Proveedor = rp.id_Proveedor
            WHERE 
                u.correoE = correoE
        )
    ORDER BY 
        p.fecha DESC;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ObtenerPedidosGerente
-- ----------------------------
DROP PROCEDURE IF EXISTS `ObtenerPedidosGerente`;
delimiter ;;
CREATE PROCEDURE `ObtenerPedidosGerente`(IN correoE VARCHAR(50))
BEGIN
    SELECT 
        p.id_Pedido, 
        pr.nombre_Producto, 
        pr.precio,
        p.cantidad, 
        p.fecha, 
        p.confirmado, 
        p.entregado,
        CONCAT(pv.nombre_Proveedor, ' ', pv.apellido_Proveedor) AS nombre_Proveedor,
        pv.nombre_Empresa AS empresa_Proveedor
    FROM 
        Pedido p
    INNER JOIN 
        Producto pr ON p.id_Producto = pr.id_Producto
    INNER JOIN 
        Rel_Proveedor_Pedido rpp ON rpp.id_Pedido = p.id_Pedido
    INNER JOIN 
        Proveedor pv ON rpp.id_Proveedor = pv.id_Proveedor
    WHERE 
        pv.id_Proveedor IN (
            SELECT 
                rp.id_Proveedor
            FROM 
                Rel_Usuario_Proveedor rup
            INNER JOIN 
                Usuario u ON rup.id_Usuario = u.id_Usuario
            INNER JOIN 
                Proveedor rp ON rup.id_Proveedor = rp.id_Proveedor
            WHERE 
                u.correoE = correoE
        )
    ORDER BY 
        p.fecha DESC;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ObtenerPedidosProveedor
-- ----------------------------
DROP PROCEDURE IF EXISTS `ObtenerPedidosProveedor`;
delimiter ;;
CREATE PROCEDURE `ObtenerPedidosProveedor`(IN correoE VARCHAR(50))
BEGIN
    SELECT 
        p.id_Pedido, 
        pr.nombre_Producto, 
        pr.precio,
        p.cantidad, 
        p.fecha, 
        p.confirmado, 
        p.entregado,
        CONCAT(g.nombre_Gerente, ' ', g.apellido_Gerente) AS nombre_Gerente
    FROM 
        Pedido p
    INNER JOIN 
        Producto pr ON p.id_Producto = pr.id_Producto
    INNER JOIN 
        Rel_Proveedor_Pedido rpp ON rpp.id_Pedido = p.id_Pedido
    INNER JOIN 
        Proveedor pv ON rpp.id_Proveedor = pv.id_Proveedor
    INNER JOIN 
        Gerente g ON p.id_Gerente = g.id_Gerente
    WHERE 
        pv.id_Proveedor IN (
            SELECT 
                rp.id_Proveedor
            FROM 
                Rel_Usuario_Proveedor rup
            INNER JOIN 
                Usuario u ON rup.id_Usuario = u.id_Usuario
            INNER JOIN 
                Proveedor rp ON rup.id_Proveedor = rp.id_Proveedor
            WHERE 
                u.correoE = correoE
        )
    ORDER BY 
        p.fecha DESC;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Obtener_Producto_Por_Clave
-- ----------------------------
DROP PROCEDURE IF EXISTS `Obtener_Producto_Por_Clave`;
delimiter ;;
CREATE PROCEDURE `Obtener_Producto_Por_Clave`(IN `p_clave` INT)
BEGIN
    SELECT 
        p.clave, 
        p.nombre_Producto, 
        p.descripcion, 
        p.caducidad, 
        ctp.tipo_Producto, 
        dp.precio 
    FROM 
        Producto p
    INNER JOIN 
        Cat_Tipo_Producto ctp ON p.id_Tipo_Producto = ctp.id_Tipo_Producto
    INNER JOIN 
        Rel_Producto_Dinero rpd ON p.id_Producto = rpd.id_Producto
    INNER JOIN 
        Dinero_Producto dp ON rpd.id_Dinero_Producto = dp.id_Dinero_Producto
    WHERE 
        p.clave = p_clave;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Obtener_Stock_Gerente
-- ----------------------------
DROP PROCEDURE IF EXISTS `Obtener_Stock_Gerente`;
delimiter ;;
CREATE PROCEDURE `Obtener_Stock_Gerente`(IN gerente_email VARCHAR(50))
BEGIN
    SELECT 
        p.clave, 
        p.nombre_Producto, 
        p.descripcion, 
        p.caducidad, 
        ctp.tipo_Producto, 
        s.cantidad, 
        dp.precio,
        (s.cantidad * dp.precio) AS ganancia
    FROM 
        Usuario usr
    INNER JOIN 
        Rel_Usuario_Proveedor rup ON usr.id_Usuario = rup.id_Usuario
    INNER JOIN 
        Proveedor prv ON rup.id_Proveedor = prv.id_Proveedor
    INNER JOIN 
        Suministro s ON prv.id_Proveedor = s.id_Proveedor
    INNER JOIN 
        Producto p ON s.id_Producto = p.id_Producto
    INNER JOIN 
        Cat_Tipo_Producto ctp ON p.id_Tipo_Producto = ctp.id_Tipo_Producto
    INNER JOIN 
        Rel_Producto_Dinero rpd ON p.id_Producto = rpd.id_Producto
    INNER JOIN 
        Dinero_Producto dp ON rpd.id_Dinero_Producto = dp.id_Dinero_Producto
    WHERE 
        usr.correoE = gerente_email;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Obtener_Stock_Proveedores
-- ----------------------------
DROP PROCEDURE IF EXISTS `Obtener_Stock_Proveedores`;
delimiter ;;
CREATE PROCEDURE `Obtener_Stock_Proveedores`(IN provider_email VARCHAR(50))
BEGIN
    SELECT 
        p.clave, 
        p.nombre_Producto, 
        p.descripcion, 
        p.caducidad, 
        ctp.tipo_Producto, 
        dp.precio
    FROM 
        Usuario usr
    INNER JOIN 
        Rel_Usuario_Proveedor rup ON usr.id_Usuario = rup.id_Usuario
    INNER JOIN 
        Proveedor prv ON rup.id_Proveedor = prv.id_Proveedor
    INNER JOIN 
        Suministro s ON prv.id_Proveedor = s.id_Proveedor
    INNER JOIN 
        Producto p ON s.id_Producto = p.id_Producto
    INNER JOIN 
        Cat_Tipo_Producto ctp ON p.id_Tipo_Producto = ctp.id_Tipo_Producto
    INNER JOIN 
        Rel_Producto_Dinero rpd ON p.id_Producto = rpd.id_Producto
    INNER JOIN 
        Dinero_Producto dp ON rpd.id_Dinero_Producto = dp.id_Dinero_Producto
    WHERE 
        usr.correoE = provider_email;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Realizar_Venta
-- ----------------------------
DROP PROCEDURE IF EXISTS `Realizar_Venta`;
delimiter ;;
CREATE PROCEDURE `Realizar_Venta`(IN correoGerente VARCHAR(255),
    IN fechaVenta DATE,
    IN productos JSON)
BEGIN
    DECLARE idGerente INT;
    DECLARE producto_id INT;
    DECLARE cantidad INT;
    DECLARE precio DECIMAL(10, 2);
    DECLARE idx INT DEFAULT 0;
    DECLARE num_products INT;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
    END;

    -- Obtener el ID del gerente a partir del correo
    SELECT r.id_Gerente INTO idGerente
    FROM Rel_Usuario_Gerente r 
    JOIN Usuario u ON r.id_Usuario = u.id_Usuario 
    WHERE u.correo = correoGerente;

    SET num_products = JSON_LENGTH(productos);

    START TRANSACTION;

    WHILE idx < num_products DO
        SET producto_id = JSON_UNQUOTE(JSON_EXTRACT(productos, CONCAT('$[', idx, '].id')));
        SET cantidad = JSON_UNQUOTE(JSON_EXTRACT(productos, CONCAT('$[', idx, '].cantidad')));

        -- Obtener el precio del producto
        SELECT dp.precio INTO precio
        FROM Rel_Producto_Dinero rpd 
        JOIN Dinero_Producto dp ON rpd.id_Dinero_Producto = dp.id_Dinero_Producto 
        WHERE rpd.id_Producto = producto_id;

        -- Insertar en Venta_Producto
        INSERT INTO Venta_Producto (id_Gerente, id_Producto, id_Dinero_Venta, fecha_Venta)
        VALUES (idGerente, producto_id, producto_id, fechaVenta);

        -- Actualizar la cantidad vendida en Dinero_Venta
        UPDATE Dinero_Venta 
        SET cantidad_Vendida = cantidad_Vendida + cantidad 
        WHERE id_Dinero_Venta = producto_id;

        -- Actualizar la cantidad de Administra
        UPDATE Administra 
        SET cantidad = cantidad - cantidad 
        WHERE id_Producto = producto_id 
        AND id_Gerente = idGerente;

        SET idx = idx + 1;
    END WHILE;

    COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for RegistrarProducto
-- ----------------------------
DROP PROCEDURE IF EXISTS `RegistrarProducto`;
delimiter ;;
CREATE PROCEDURE `RegistrarProducto`(IN p_clave INT,
    IN p_nombre_Producto VARCHAR(50),
    IN p_descripcion VARCHAR(50),
    IN p_caducidad DATE,
    IN p_tipo_Producto VARCHAR(50),
    IN p_precio DECIMAL(10,2),
    IN p_correoE VARCHAR(50))
BEGIN
    DECLARE v_id_Producto INT;
    DECLARE v_id_Dinero_Producto INT;
    DECLARE v_id_Tipo_Producto INT;
    DECLARE v_id_Proveedor INT;
    
    -- Obtener el id_Proveedor a partir del correo electrónico
    SELECT p.id_Proveedor INTO v_id_Proveedor
    FROM Proveedor p
    JOIN Rel_Usuario_Proveedor rup ON p.id_Proveedor = rup.id_Proveedor
    JOIN Usuario u ON rup.id_Usuario = u.id_Usuario
    WHERE u.correoE = p_correoE
    LIMIT 1;

    -- Verificar si se encontró el proveedor
    IF v_id_Proveedor IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Proveedor no encontrado para el correo proporcionado';
    END IF;
    
    -- Verificar si el tipo de producto ya está registrado
    SELECT id_Tipo_Producto INTO v_id_Tipo_Producto
    FROM Cat_Tipo_Producto
    WHERE tipo_Producto = p_tipo_Producto
    LIMIT 1;

    -- Si el tipo de producto no está registrado, registrarlo
    IF v_id_Tipo_Producto IS NULL THEN
        INSERT INTO Cat_Tipo_Producto (tipo_Producto)
        VALUES (p_tipo_Producto);
        SET v_id_Tipo_Producto = LAST_INSERT_ID();
    END IF;
    
    -- Insertar en la tabla Producto
    INSERT INTO Producto (clave, nombre_Producto, descripcion, caducidad, id_Tipo_Producto)
    VALUES (p_clave, p_nombre_Producto, p_descripcion, p_caducidad, v_id_Tipo_Producto);
    
    -- Obtener el id del producto recién insertado
    SET v_id_Producto = LAST_INSERT_ID();
    
    -- Insertar en la tabla Dinero_Producto
    INSERT INTO Dinero_Producto (precio)
    VALUES (p_precio);
    
    -- Obtener el id del dinero_producto recién insertado
    SET v_id_Dinero_Producto = LAST_INSERT_ID();
    
    -- Relacionar el producto con su información financiera
    INSERT INTO Rel_Producto_Dinero (id_Producto, id_Dinero_Producto)
    VALUES (v_id_Producto, v_id_Dinero_Producto);
    
    -- Insertar en la tabla Suministro
    INSERT INTO Suministro (id_Proveedor, id_Producto)
    VALUES (v_id_Proveedor, v_id_Producto);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for vender_producto
-- ----------------------------
DROP PROCEDURE IF EXISTS `vender_producto`;
delimiter ;;
CREATE PROCEDURE `vender_producto`(IN p_claveProducto VARCHAR(50),
    IN p_cantidadVendida INT,
    IN p_correoGerente VARCHAR(50))
BEGIN
    DECLARE v_idProducto INT;
    DECLARE v_cantidadActual DECIMAL(10,2);
    DECLARE v_precioProducto DECIMAL(10,2);
    DECLARE v_gananciaProducto DECIMAL(10,2);
    DECLARE v_precioFinal DECIMAL(10,2);
    DECLARE v_fechaVenta DATE;
    DECLARE v_idDineroVenta INT;
    DECLARE v_idGerente INT;
    DECLARE v_idUsuario INT;

    -- Obtener el id del usuario mediante el correo
    SELECT id_Usuario INTO v_idUsuario
    FROM Usuario
    WHERE correoE = p_correoGerente;

    -- Verificar si el usuario existe
    IF v_idUsuario IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El usuario no existe';
    ELSE
        -- Obtener el id del gerente mediante el id del usuario
        SELECT id_Gerente INTO v_idGerente
        FROM Rel_Usuario_Gerente
        WHERE id_Usuario = v_idUsuario;

        -- Verificar si el gerente existe
        IF v_idGerente IS NULL THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El gerente no existe';
        ELSE
            -- Obtener el id del producto mediante la clave
            SELECT id_Producto INTO v_idProducto
            FROM Producto
            WHERE clave = p_claveProducto;

            -- Verificar si el producto existe
            IF v_idProducto IS NULL THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'El producto no existe';
            ELSE
                -- Obtener la cantidad actual del producto administrado por el gerente
                SELECT cantidad, ganancia INTO v_cantidadActual, v_gananciaProducto
                FROM Administra
                WHERE id_Producto = v_idProducto AND id_Gerente = v_idGerente;

                -- Verificar si la cantidad es suficiente
                IF v_cantidadActual IS NULL THEN
                    SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'El gerente no administra este producto';
                ELSEIF v_cantidadActual < p_cantidadVendida THEN
                    SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Stock insuficiente';
                ELSE
                    -- Obtener el precio del producto
                    SELECT precio INTO v_precioProducto
                    FROM Producto
                    WHERE id_Producto = v_idProducto;

                    -- Calcular el precio final
                    SET v_precioFinal = v_precioProducto + v_gananciaProducto;

                    -- Actualizar la cantidad del producto en la tabla Administra
                    UPDATE Administra
                    SET cantidad = cantidad - p_cantidadVendida
                    WHERE id_Producto = v_idProducto AND id_Gerente = v_idGerente;

                    -- Registrar la venta
                    SET v_fechaVenta = CURDATE();
                    INSERT INTO Dinero_Venta (ganancia, cantidad_Vendida)
                    VALUES (v_precioFinal * p_cantidadVendida, p_cantidadVendida);
                    SET v_idDineroVenta = LAST_INSERT_ID();

                    INSERT INTO Venta_Producto (id_Gerente, id_Producto, id_Dinero_Venta, fecha_Venta)
                    VALUES (v_idGerente, v_idProducto, v_idDineroVenta, v_fechaVenta);
                END IF;
            END IF;
        END IF;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Pedido
-- ----------------------------
DROP TRIGGER IF EXISTS `Producto_Entregado`;
delimiter ;;
CREATE TRIGGER `Producto_Entregado` AFTER UPDATE ON `Pedido` FOR EACH ROW BEGIN
    DECLARE v_id_Gerente INT;
    DECLARE v_precio DECIMAL(10, 2);
    DECLARE v_ganancia DECIMAL(10, 2);
    -- Verificar si el campo "entregado" ha cambiado y está marcado como entregado
    IF NEW.entregado <> OLD.entregado AND NEW.entregado = 1 THEN
        -- Obtener el id_Gerente desde la tabla Rel_Pedido_Gerente
        SELECT id_Gerente INTO v_id_Gerente
        FROM Rel_Pedido_Gerente
        WHERE id_Pedido = NEW.id_Pedido;
        -- Obtener el precio del producto desde la tabla Producto
        SELECT precio INTO v_precio
        FROM Dinero_Producto
        JOIN Rel_Producto_Dinero ON Dinero_Producto.id_Dinero_Producto = Rel_Producto_Dinero.id_Dinero_Producto
        WHERE Rel_Producto_Dinero.id_Producto = NEW.id_Producto;
        -- Calcular la ganancia como el 30% del precio del producto
        SET v_ganancia = v_precio * 0.30;
        -- Insertar en la tabla Administra
        INSERT INTO Administra (id_Gerente, id_Producto, cantidad, ganancia)
        VALUES (v_id_Gerente, NEW.id_Producto, NEW.cantidad, v_ganancia);
    END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
