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


USE VendorVision;

# Inserting into Cat_Tipo_Tel
INSERT INTO Cat_Tipo_Tel (tipo_tel) VALUES 
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

# Inserting into Gerente
INSERT INTO Gerente (nombre_Gerente, apellidos, curp, edad, fechaNac, id_Tipo_Tel) VALUES
('Juan', 'Perez', 'JUAP890123HDFRRN01', 34, '1989-01-23', 1),
('Maria', 'Lopez', 'MALO790512HMNLRN02', 45, '1979-05-12', 2),
('Carlos', 'Gomez', 'CAGO850712HDFLZR03', 38, '1985-07-12', 3),
('Ana', 'Martinez', 'ANAM840615MDFLRL04', 39, '1984-06-15', 4),
('Luis', 'Hernandez', 'LUHE760910HDFZMR05', 47, '1976-09-10', 5),
('Rosa', 'Ramirez', 'RORA870101MDFSRZ06', 37, '1987-01-01', 6),
('Pedro', 'Fernandez', 'PEFE750801HDFKLR07', 48, '1975-08-01', 7),
('Lucia', 'Sanchez', 'LUSA680919MDFKRZ08', 55, '1968-09-19', 8),
('Jose', 'Diaz', 'JODI700503HDFLRN09', 54, '1970-05-03', 9),
('Laura', 'Vazquez', 'LAVA900312MDFSRN10', 34, '1990-03-12', 10);

# Inserting into Tienda
INSERT INTO Tienda (nombre_Tienda) VALUES
('Tienda Centro'), ('Tienda Norte'), ('Tienda Sur'), ('Tienda Este'), ('Tienda Oeste'),
('Tienda Central'), ('Tienda Reforma'), ('Tienda Alameda'), ('Tienda Insurgentes'), ('Tienda Patriotismo');

# Inserting into Rel_Gerente_Tienda
INSERT INTO Rel_Gerente_Tienda (id_Gerente, id_Tienda) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

# Inserting into Proveedor
INSERT INTO Proveedor (nombre_Proveedor, apellidos_Proveedor, nombre_Empresa, id_Tipo_Tel) VALUES
('Carlos', 'Martinez', 'Empresa A', 1), ('Luisa', 'Fernandez', 'Empresa B', 2),
('Miguel', 'Garcia', 'Empresa C', 3), ('Sofia', 'Rios', 'Empresa D', 4),
('Roberto', 'Jimenez', 'Empresa E', 5), ('Carmen', 'Morales', 'Empresa F', 6),
('Andres', 'Torres', 'Empresa G', 7), ('Elena', 'Hidalgo', 'Empresa H', 8),
('Francisco', 'Navarro', 'Empresa I', 9), ('Alicia', 'Mendoza', 'Empresa J', 10);

# Inserting into Cat_Tipo_Producto
INSERT INTO Cat_Tipo_Producto (tipo_Producto) VALUES
('Electronics'), ('Clothing'), ('Furniture'), ('Toys'), ('Food'),
('Books'), ('Beauty'), ('Sports'), ('Automotive'), ('Garden');

# Inserting into Producto
INSERT INTO Producto (clave, nombre_Producto, descripcion, caducidad, id_Tipo_Producto, cantidad) VALUES
(101, 'Laptop', 'High performance laptop', '2025-12-31', 1, 50),
(102, 'T-Shirt', 'Cotton T-Shirt', '2024-05-20', 2, 200),
(103, 'Sofa', 'Comfortable sofa', '2026-08-15', 3, 30),
(104, 'Toy Car', 'Plastic toy car', '2024-11-05', 4, 150),
(105, 'Apple', 'Fresh apple', '2023-06-01', 5, 500),
(106, 'Novel', 'Bestselling novel', '2027-03-10', 6, 100),
(107, 'Lipstick', 'Red lipstick', '2025-09-25', 7, 80),
(108, 'Football', 'Professional football', '2024-12-12', 8, 60),
(109, 'Tire', 'Car tire', '2026-07-20', 9, 40),
(110, 'Flower Pot', 'Ceramic flower pot', '2026-05-15', 10, 70);

# Inserting into Suministro
INSERT INTO Suministro (id_Proveedor, id_Producto) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

# Inserting into Pedido
INSERT INTO Pedido (id_Producto, num_Pedidos) VALUES
(1, 20), (2, 100), (3, 10), (4, 75), (5, 200),
(6, 50), (7, 30), (8, 25), (9, 15), (10, 40);

# Inserting into Rel_Proveedor_Pedido
INSERT INTO Rel_Proveedor_Pedido (id_Proveedor, id_Pedido) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

# Inserting into Dinero_Producto
INSERT INTO Dinero_Producto (ganancia, inversion, cantidadVendida, cantidadComprad) VALUES
(5000, 3000, 25, 30), (1000, 500, 100, 120), (8000, 5000, 20, 25),
(1500, 1000, 70, 80), (3000, 2000, 180, 200), (6000, 4000, 45, 50),
(700, 400, 25, 30), (1200, 800, 20, 25), (3500, 2500, 10, 15), (2000, 1500, 35, 40);

# Inserting into Rel_Producto_Dinero
INSERT INTO Rel_Producto_Dinero (id_Producto) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

# Inserting into Administra
INSERT INTO Administra (id_Gerente, id_Producto) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

# Inserting into Venta_Producto
INSERT INTO Venta_Producto (id_Gerente, id_Producto) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

# Inserting into Direccion
INSERT INTO Direccion (colonia, calle, CP, ciudad, num_Int, num_Ext) VALUES
('Centro', 'Calle 1', 12345, 'Ciudad A', 10, 20),
('Norte', 'Calle 2', 54321, 'Ciudad B', 15, 25),
('Sur', 'Calle 3', 67890, 'Ciudad C', 12, 22),
('Este', 'Calle 4', 13579, 'Ciudad D', 8, 18),
('Oeste', 'Calle 5', 24680, 'Ciudad E', 20, 30),
('Centro', 'Calle 6', 11223, 'Ciudad F', 14, 24),
('Norte', 'Calle 7', 33211, 'Ciudad G', 16, 26),
('Sur', 'Calle 8', 44556, 'Ciudad H', 11, 21),
('Este', 'Calle 9', 55644, 'Ciudad I', 9, 19),
('Oeste', 'Calle 10', 77889, 'Ciudad J', 13, 23);

# Inserting into Rel_Gerente_Dir
INSERT INTO Rel_Gerente_Dir (id_Gerente, id_Dir) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

# Inserting into Rel_Proveedor_Dir
INSERT INTO Rel_Proveedor_Dir (id_Proveedor, id_Dir) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

# Inserting into Usuario
INSERT INTO Usuario (nombre_Usuario, correoE, contraseña) VALUES
('user1', 'user1@example.com', 'password1'), ('user2', 'user2@example.com', 'password2'),
('user3', 'user3@example.com', 'password3'), ('user4', 'user4@example.com', 'password4'),
('user5', 'user5@example.com', 'password5'), ('user6', 'user6@example.com', 'password6'),
('user7', 'user7@example.com', 'password7'), ('user8', 'user8@example.com', 'password8'),
('user9', 'user9@example.com', 'password9'), ('user10', 'user10@example.com', 'password10');

# Inserting into Rel_Usuario_Proveedor
INSERT INTO Rel_Usuario_Proveedor (id_Usuario, id_Proveedor) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

# Inserting into Rel_Usuario_Gerente
INSERT INTO Rel_Usuario_Gerente (id_Usuario, id_Gerente) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10);
