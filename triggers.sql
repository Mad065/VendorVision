	-- Active: 1715711027341@@127.0.0.1@3306@VendorVision
	DELIMITER $$

	# Procedimiento para insertar un nuevo Gerente
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

	# Procedimiento para insertar una nueva Tienda
	CREATE PROCEDURE Insertar_Tienda(
		IN nombre_Tienda VARCHAR(50)
	)
	BEGIN
		INSERT INTO Tienda(nombre_Tienda) 
		VALUES(nombre_Tienda);
	END$$

	# Procedimiento para insertar un nuevo Proveedor
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

	# Procedimiento para insertar un nuevo Producto
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

	# Procedimiento para insertar una nueva Dirección
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

	# Procedimiento para insertar un nuevo Usuario
	CREATE PROCEDURE Insertar_Usuario(
		IN nombre_Usuario VARCHAR(50),
		IN correoE VARCHAR(50),
		IN contraseña VARCHAR(20)
	)
	BEGIN
		INSERT INTO Usuario(nombre_Usuario, correoE, contraseña) 
		VALUES(nombre_Usuario, correoE, contraseña);
	END$$

	# Procedimiento para modificar los datos de un Gerente
	CREATE PROCEDURE Modificar_Gerente(
		IN id_Gerente INT,
		IN nuevo_nombre_Gerente VARCHAR(50),
		IN nuevos_apellidos VARCHAR(50),
		IN nueva_curp VARCHAR(18),
		IN nueva_edad INT,
		IN nueva_fechaNac DATE,
		IN nuevo_id_Tipo_Tel INT
	)
	BEGIN
		UPDATE Gerente
		SET nombre_Gerente = nuevo_nombre_Gerente,
			apellidos = nuevos_apellidos,
			curp = nueva_curp,
			edad = nueva_edad,
			fechaNac = nueva_fechaNac,
			id_Tipo_Tel = nuevo_id_Tipo_Tel
		WHERE id_Gerente = id_Gerente;
	END$$

	# Procedimiento para modificar los datos de una Tienda
	CREATE PROCEDURE Modificar_Tienda(
		IN id_Tienda INT,
		IN nuevo_nombre_Tienda VARCHAR(50)
	)
	BEGIN
		UPDATE Tienda
		SET nombre_Tienda = nuevo_nombre_Tienda
		WHERE id_Tienda = id_Tienda;
	END$$

	# Procedimiento para modificar los datos de un Proveedor
	CREATE PROCEDURE Modificar_Proveedor(
		IN id_Proveedor INT,
		IN nuevo_nombre_Proveedor VARCHAR(50),
		IN nuevos_apellidos_Proveedor VARCHAR(50),
		IN nuevo_nombre_Empresa VARCHAR(50),
		IN nuevo_id_Tipo_Tel INT
	)
	BEGIN
		UPDATE Proveedor
		SET nombre_Proveedor = nuevo_nombre_Proveedor,
			apellidos_Proveedor = nuevos_apellidos_Proveedor,
			nombre_Empresa = nuevo_nombre_Empresa,
			id_Tipo_Tel = nuevo_id_Tipo_Tel
		WHERE id_Proveedor = id_Proveedor;
	END$$

	# Procedimiento para modificar los datos de un Producto
	CREATE PROCEDURE Modificar_Producto(
		IN id_Producto INT,
		IN nueva_clave INT,
		IN nuevo_nombre_Producto VARCHAR(50),
		IN nueva_descripcion VARCHAR(50),
		IN nueva_caducidad DATE,
		IN nuevo_id_Tipo_Producto INT,
		IN nueva_cantidad INT
	)
	BEGIN
		UPDATE Producto
		SET clave = nueva_clave,
			nombre_Producto = nuevo_nombre_Producto,
			descripcion = nueva_descripcion,
			caducidad = nueva_caducidad,
			id_Tipo_Producto = nuevo_id_Tipo_Producto,
			cantidad = nueva_cantidad
		WHERE id_Producto = id_Producto;
	END$$

	# Procedimiento para modificar los datos de una Dirección
	CREATE PROCEDURE Modificar_Direccion(
		IN id_Dir INT,
		IN nueva_colonia VARCHAR(50),
		IN nueva_calle VARCHAR(50),
		IN nuevo_CP INT,
		IN nueva_ciudad VARCHAR(50),
		IN nuevo_num_Int INT,
		IN nuevo_num_Ext INT
	)
	BEGIN
		UPDATE Direccion
		SET colonia = nueva_colonia,
			calle = nueva_calle,
			CP = nuevo_CP,
			ciudad = nueva_ciudad,
			num_Int = nuevo_num_Int,
			num_Ext = nuevo_num_Ext
		WHERE id_Dir = id_Dir;
	END$$

	## Procedimiento para modificar los datos de un Usuario
	CREATE PROCEDURE Modificar_Usuario(
		IN id_Usuario INT,
		IN nuevo_nombre_Usuario VARCHAR(50),
		IN nuevo_correoE VARCHAR(50),
		IN nueva_contraseña VARCHAR(20)
	)
	BEGIN
		UPDATE Usuario
		SET nombre_Usuario = nuevo_nombre_Usuario,
			correoE = nuevo_correoE,
			contraseña = nueva_contraseña
		WHERE id_Usuario = id_Usuario;
	END$$

	# Procedimiento para eliminar un Gerente
	CREATE PROCEDURE Eliminar_Gerente(
		IN id_Gerente INT
	)
	BEGIN
		DELETE FROM Gerente WHERE id_Gerente = id_Gerente;
	END$$

	# Procedimiento para eliminar una Tienda
	CREATE PROCEDURE Eliminar_Tienda(
		IN id_Tienda INT
	)
	BEGIN
		DELETE FROM Tienda WHERE id_Tienda = id_Tienda;
	END$$

	DELIMITER $$

	# Procedimiento para eliminar un Proveedor
	CREATE PROCEDURE Eliminar_Proveedor(
		IN id_Proveedor INT
	)
	BEGIN
		DELETE FROM Proveedor WHERE id_Proveedor = id_Proveedor;
	END$$
	DELIMITER ;

	DELIMITER $$

	# Procedimiento para eliminar un Producto
	CREATE PROCEDURE Eliminar_Producto(
		IN id_Producto INT
	)
	BEGIN
		DELETE FROM Producto WHERE id_Producto = id_Producto;
	END$$

	DELIMITER ;

