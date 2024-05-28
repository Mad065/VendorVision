-- Active: 1715711027341@@127.0.0.1@3306@VendorVision

CREATE DATABASE VendorVision;

USE VendorVision;

# Catalogo de tipos de teléfono
CREATE TABLE Cat_Tipo_Tel (
    id_Tipo_Tel INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    tipo_Tel VARCHAR(50)
);

# Gerentes
CREATE TABLE Gerente (
    id_Gerente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre_Gerente VARCHAR(50),
    apellido_Gerente VARCHAR(50),
    CURP VARCHAR(18),
    edad INT,
    fechaNac DATE
);

# Tiendas
CREATE TABLE Tienda (
    id_Tienda INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre_Tienda VARCHAR(50),
    tel_Tienda VARCHAR(50)
);

# Relacion entre Gerentes y Tiendas
CREATE TABLE Rel_Gerente_Tienda (
    id_Rel_Gerente_Tienda INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_Gerente INT,
    id_Tienda INT,
    FOREIGN KEY (id_Gerente) REFERENCES Gerente(id_Gerente),
    FOREIGN KEY (id_Tienda) REFERENCES Tienda(id_Tienda)
);

# Proveedores
CREATE TABLE Proveedor (
    id_Proveedor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre_Proveedor VARCHAR(50),
    apellidos_Proveedor VARCHAR(50),
    nombre_Empresa VARCHAR(50)
);

# Catalogo de Tipos de Producto
CREATE TABLE Cat_Tipo_Producto (
    id_Tipo_Producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    tipo_Producto VARCHAR(50)
);

# Pedidos
CREATE TABLE Pedido (
    id_Pedido INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    numPedidos INT
);

# Relacion entre Proveedores y Pedidos
CREATE TABLE Rel_Proveedor_Pedido (
    id_Rel_Proveedor_Pedido INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_Proveedor INT,
    id_Pedido INT,
    FOREIGN KEY (id_Proveedor) REFERENCES Proveedor(id_Proveedor),
    FOREIGN KEY (id_Pedido) REFERENCES Pedido(id_Pedido)
);

# Productos
CREATE TABLE Producto (
    id_Producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    clave INT,
    nombre_Producto VARCHAR(50),
    descripcion VARCHAR(50),
    caducidad DATE,
    id_Tipo_Producto INT,
    cantidad INT,
    FOREIGN KEY (id_Tipo_Producto) REFERENCES Cat_Tipo_Producto(id_Tipo_Producto)
);

# Suministro
CREATE TABLE Suministro (
    id_Suministro INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_Proveedor INT,
    id_Producto INT,
    FOREIGN KEY (id_Proveedor) REFERENCES Proveedor(id_Proveedor),
    FOREIGN KEY (id_Producto) REFERENCES Producto(id_Producto)
);

# Dinero productos
CREATE TABLE Dinero_Producto (
    id_Dinero_Producto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    ganancia INT,
    inversion INT,
    cantidad_Vendida INT,
    cantidad_Comprada INT
);

# Relacion entre Productos-Dinero
CREATE TABLE Rel_Producto_Dinero (
    id_Rel_Producto_Dinero INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_Producto INT,
    id_Dinero_Producto INT,
    FOREIGN KEY (id_Producto) REFERENCES Producto(id_Producto),
    FOREIGN KEY (id_Dinero_Producto) REFERENCES Dinero_Producto(id_Dinero_Producto)
);

# Gerentes administrando Productos
CREATE TABLE Administra (
    id_Admin INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_Gerente INT,
    id_Producto INT,
    FOREIGN KEY (id_Gerente) REFERENCES Gerente(id_Gerente),
    FOREIGN KEY (id_Producto) REFERENCES Producto(id_Producto)
);

# Registros de Ventas
CREATE TABLE Venta_Producto (
    id_Venta INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_Gerente INT,
    id_Producto INT,
    FOREIGN KEY (id_Gerente) REFERENCES Gerente(id_Gerente),
    FOREIGN KEY (id_Producto) REFERENCES Producto(id_Producto)
);

# Direcciones
CREATE TABLE Direccion (
    id_Dir INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    colonia VARCHAR(50),
    calle VARCHAR(50),
    CP INT,
    ciudad VARCHAR(50),
    num_Int INT,
    num_Ext INT
);

# Relacion entre Gerentes y Direcciones
CREATE TABLE Rel_Gerente_Dir (
    id_Rel_Gerente_Dir INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_Gerente INT,
    id_Dir INT,
    FOREIGN KEY (id_Gerente) REFERENCES Gerente(id_Gerente),
    FOREIGN KEY (id_Dir) REFERENCES Direccion(id_Dir)
);

# Relacion entre Proveedores y Direcciones
CREATE TABLE Rel_Proveedor_Dir (
    id_Rel_Proveedor_Dir INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_Proveedor INT,
    id_Dir INT,
    FOREIGN KEY (id_Proveedor) REFERENCES Proveedor(id_Proveedor),
    FOREIGN KEY (id_Dir) REFERENCES Direccion(id_Dir)
);

# Usuarios
CREATE TABLE Usuario (
    id_Usuario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre_Usuario VARCHAR(50),
    correoE VARCHAR(50),
    contraseña VARCHAR(20)
);

# Relacion entre Usuarios y Proveedores
CREATE TABLE Rel_Usuario_Proveedor (
    id_Rel_Usuario_Proveedor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_Usuario INT,
    id_Proveedor INT,
    FOREIGN KEY (id_Usuario) REFERENCES Usuario(id_Usuario),
    FOREIGN KEY (id_Proveedor) REFERENCES Proveedor(id_Proveedor)
);

# Relacion entre Usuarios y Gerentes
CREATE TABLE Rel_Usuario_Gerente (
    id_Rel_Usuario_Gerente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_Usuario INT,
    id_Gerente INT,
    FOREIGN KEY (id_Usuario) REFERENCES Usuario(id_Usuario),
    FOREIGN KEY (id_Gerente) REFERENCES Gerente(id_Gerente)
);

# Teléfonos
CREATE TABLE Telefono (
    id_Tel INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    telefono VARCHAR(20)
);

# Relacion entre Gerentes y Teléfonos
CREATE TABLE Rel_Gerente_Tel (
    id_Rel_Gerente_Tel INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_Gerente INT,
    id_Tel INT,
    id_Tipo_Tel INT,
    FOREIGN KEY (id_Gerente) REFERENCES Gerente(id_Gerente),
    FOREIGN KEY (id_Tel) REFERENCES Telefono(id_Tel),
    FOREIGN KEY (id_Tipo_Tel) REFERENCES Cat_Tipo_Tel(id_Tipo_Tel)
);

# Relacion entre Proveedores y Teléfonos
CREATE TABLE Rel_Proveedor_Tel (
    id_Rel_Proveedor_Tel INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_Proveedor INT,
    id_Tel INT,
    id_Tipo_Tel INT,
    FOREIGN KEY (id_Proveedor) REFERENCES Proveedor(id_Proveedor),
    FOREIGN KEY (id_Tel) REFERENCES Telefono(id_Tel),
    FOREIGN KEY (id_Tipo_Tel) REFERENCES Cat_Tipo_Tel(id_Tipo_Tel)
);
