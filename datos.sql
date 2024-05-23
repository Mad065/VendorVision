-- Active: 1715711027341@@127.0.0.1@3306@VendorVision

USE VendorVision;

# Llenar Cat_Tipo_Tel
INSERT INTO Cat_Tipo_Tel (tipo_tel) VALUES ('Móvil'), ('Fijo'), ('Fax');

# Llenar Cat_Tipo_Producto
INSERT INTO Cat_Tipo_Producto (tipo_Producto) VALUES ('Alimentos'), ('Bebidas'), ('Electrónica'), ('Ropa'), ('Hogar');

# Insertar Gerentes
CALL Insertar_Gerente('Juan', 'Pérez López', 'JPLG910203HDFRNS09', 33, '1991-02-03', 1);
CALL Insertar_Gerente('Ana', 'Martínez Díaz', 'AMD890712MDFRND06', 34, '1989-07-12', 2);
CALL Insertar_Gerente('Pedro', 'García Méndez', 'PGMM800101HDFRND08', 44, '1980-01-01', 1);
CALL Insertar_Gerente('María', 'Sánchez Gómez', 'MSGF950315HDFRND05', 29, '1995-03-15', 2);

# Insertar Tiendas
CALL Insertar_Tienda('Tienda A');
CALL Insertar_Tienda('Tienda B');
CALL Insertar_Tienda('Tienda C');
CALL Insertar_Tienda('Tienda D');

# Insertar Proveedores
CALL Insertar_Proveedor('Carlos', 'Ramírez Gómez', 'Proveedora S.A.', 3);
CALL Insertar_Proveedor('Luisa', 'Fernández Ruiz', 'Distribuidora L.F.', 1);
CALL Insertar_Proveedor('Marta', 'López Hernández', 'Comercial M.L.', 2);
CALL Insertar_Proveedor('Jorge', 'Hernández Pérez', 'Suministros J.H.', 3);

# Relacionar Gerentes con Tiendas
INSERT INTO Rel_Gerente_Tienda (id_Gerente, id_Tienda) VALUES (1, 1), (2, 2), (3, 3), (4, 4);

# Insertar Productos
CALL Insertar_Producto(1001, 'Producto 1', 'Descripción 1', '2025-12-31', 1, 100);
CALL Insertar_Producto(1002, 'Producto 2', 'Descripción 2', '2024-11-30', 2, 200);
CALL Insertar_Producto(1003, 'Producto 3', 'Descripción 3', '2023-10-31', 3, 150);
CALL Insertar_Producto(1004, 'Producto 4', 'Descripción 4', '2026-09-30', 4, 300);

# Realizar Pedidos
INSERT INTO Pedido (id_Producto, num_Pedidos) VALUES (1, 50), (2, 75), (3, 100), (4, 150);

# Relacionar Proveedores con Pedidos
INSERT INTO Rel_Proveedor_Pedido (id_Proveedor, id_Pedido) VALUES (1, 1), (2, 2), (3, 3), (4, 4);

# Insertar Direcciones
CALL Insertar_Direccion('Colonia A', 'Calle 1', 12345, 'Ciudad X', 101, 202);
CALL Insertar_Direccion('Colonia B', 'Calle 2', 67890, 'Ciudad Y', 103, 204);
CALL Insertar_Direccion('Colonia C', 'Calle 3', 54321, 'Ciudad Z', 105, 206);
CALL Insertar_Direccion('Colonia D', 'Calle 4', 98765, 'Ciudad W', 107, 208);

# Relacionar Gerentes con Direcciones
INSERT INTO Rel_Gerente_Dir (id_Gerente, id_Dir) VALUES (1, 1), (2, 2), (3, 3), (4, 4);

# Relacionar Proveedores con Direcciones
INSERT INTO Rel_Proveedor_Dir (id_Proveedor, id_Dir) VALUES (1, 1), (2, 2), (3, 3), (4, 4);

# Insertar Usuarios
CALL Insertar_Usuario('usuario1', 'usuario1@example.com', 'password1');
CALL Insertar_Usuario('usuario2', 'usuario2@example.com', 'password2');
CALL Insertar_Usuario('usuario3', 'usuario3@example.com', 'password3');
CALL Insertar_Usuario('usuario4', 'usuario4@example.com', 'password4');

# Relacionar Usuarios con Proveedores
INSERT INTO Rel_Usuario_Proveedor (id_Usuario, id_Proveedor) VALUES (1, 1), (2, 2), (3, 3), (4, 4);

# Relacionar Usuarios con Gerentes
INSERT INTO Rel_Usuario_Gerente (id_Usuario, id_Gerente) VALUES (1, 1), (2, 2), (3, 3), (4, 4);

# Insertar Dinero_Producto
INSERT INTO Dinero_Producto (ganancia, inversion, cantidadVendida, cantidadComprad) VALUES (5000, 3000, 100, 200), (8000, 4000, 150, 300), (6000, 3500, 120, 250), (7000, 3800, 140, 280);

# Relacionar Producto con Dinero_Producto
INSERT INTO Rel_Producto_Dinero (id_Producto, id_Dinero_Producto) VALUES (1, 1), (2, 2), (3, 3), (4, 4);

# Registrar Ventas
INSERT INTO Venta_Producto (id_Gerente, id_Producto) VALUES (1, 1), (2, 2), (3, 3), (4, 4);

# Insertar Suministros
INSERT INTO Suministro (id_Proveedor, id_Producto) VALUES (1, 1), (2, 2), (3, 3), (4, 4);
