-- Active: 1715711027341@@127.0.0.1@3306@VendorVision

USE VendorVision;

# Inserting into Cat_Tipo_Tel
INSERT INTO Cat_Tipo_Tel (tipo_tel) VALUES (1), (2), (3);

# Inserting into Gerente
INSERT INTO Gerente (nombre_Gerente, apellidos, curp, edad, fechaNac, id_Tipo_Tel) VALUES
('Juan', 'Perez', 'JUAP890123HDFRRN01', 34, '1989-01-23', 1),
('Maria', 'Lopez', 'MALO790512HMNLRN02', 45, '1979-05-12', 2);

# Inserting into Tienda
INSERT INTO Tienda (nombre_Tienda) VALUES
('Tienda Centro'),
('Tienda Norte');

# Inserting into Rel_Gerente_Tienda
INSERT INTO Rel_Gerente_Tienda (id_Gerente, id_Tienda) VALUES
(1, 1),
(2, 2);

# Inserting into Proveedor
INSERT INTO Proveedor (nombre_Proveedor, apellidos_Proveedor, nombre_Empresa, id_Tipo_Tel) VALUES
('Carlos', 'Martinez', 'Empresa A', 1),
('Luisa', 'Fernandez', 'Empresa B', 2);

# Inserting into Cat_Tipo_Producto
INSERT INTO Cat_Tipo_Producto (tipo_Producto) VALUES
('Electronics'),
('Clothing');

# Inserting into Producto
INSERT INTO Producto (clave, nombre_Producto, descripcion, caducidad, id_Tipo_Producto, cantidad) VALUES
(101, 'Laptop', 'High performance laptop', '2025-12-31', 1, 50),
(102, 'T-Shirt', 'Cotton T-Shirt', '2024-05-20', 2, 200);

# Inserting into Suministro
INSERT INTO Suministro (id_Proveedor, id_Producto) VALUES
(1, 1),
(2, 2);

# Inserting into Pedido
INSERT INTO Pedido (id_Producto, num_Pedidos) VALUES
(1, 20),
(2, 100);

# Inserting into Rel_Proveedor_Pedido
INSERT INTO Rel_Proveedor_Pedido (id_Proveedor, id_Pedido) VALUES
(1, 1),
(2, 2);

# Inserting into Dinero_Producto
INSERT INTO Dinero_Producto (ganancia, inversion, cantidadVendida, cantidadComprad) VALUES
(5000, 3000, 25, 30),
(1000, 500, 100, 120);

# Inserting into Rel_Producto_Dinero
INSERT INTO Rel_Producto_Dinero (id_Producto) VALUES
(1),
(2);

# Inserting into Administra
INSERT INTO Administra (id_Gerente, id_Producto) VALUES
(1, 1),
(2, 2);

# Inserting into Venta_Producto
INSERT INTO Venta_Producto (id_Gerente, id_Producto) VALUES
(1, 1),
(2, 2);

# Inserting into Direccion
INSERT INTO Direccion (colonia, calle, CP, ciudad, num_Int, num_Ext) VALUES
('Centro', 'Calle 1', 12345, 'Ciudad A', 10, 20),
('Norte', 'Calle 2', 54321, 'Ciudad B', 15, 25);

# Inserting into Rel_Gerente_Dir
INSERT INTO Rel_Gerente_Dir (id_Gerente, id_Dir) VALUES
(1, 1),
(2, 2);

# Inserting into Rel_Proveedor_Dir
INSERT INTO Rel_Proveedor_Dir (id_Proveedor, id_Dir) VALUES
(1, 1),
(2, 2);

# Inserting into Usuario
INSERT INTO Usuario (nombre_Usuario, correoE, contraseña) VALUES
('user1', 'user1@example.com', 'password1'),
('user2', 'user2@example.com', 'password2');

# Inserting into Rel_Usuario_Proveedor
INSERT INTO Rel_Usuario_Proveedor (id_Usuario, id_Proveedor) VALUES
(1, 1),
(2, 2);

# Inserting into Rel_Usuario_Gerente
INSERT INTO Rel_Usuario_Gerente (id_Usuario, id_Gerente) VALUES
(1, 1),
(2, 2);
