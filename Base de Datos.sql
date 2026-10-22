CREATE DATABASE IF NOT EXISTS RESTAURANTE;

USE RESTAURANTE;

CREATE TABLE Proveedores (
    id_proveedor INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE Ingredientes (
    id_ingrediente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    stock INT NOT NULL,
    id_proveedor INT NOT NULL,
    CONSTRAINT FK_Ingrediente_Proveedor FOREIGN KEY (id_proveedor) 
        REFERENCES Proveedores(id_proveedor) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Platos (
    id_plato INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE PlatoIngredientes (
    id_plato INT NOT NULL,
    id_ingrediente INT NOT NULL,
    cantidad_necesaria DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_plato, id_ingrediente),
    CONSTRAINT FK_Detalle_Plato FOREIGN KEY (id_plato) 
        REFERENCES Platos(id_plato) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Detalle_Ingrediente FOREIGN KEY (id_ingrediente) 
        REFERENCES Ingredientes(id_ingrediente) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE FACTURAS (
	id_factura INT PRIMARY KEY,
    total INT NOT NULL,
    CONSTRAINT FK_Cliente FOREIGN KEY (id_cliente)
    REFERENCES Clientes (id_cliente)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Empleados (
    id_empleado INT PRIMARY KEY auto_increment,
    nombre VARCHAR(100) NOT NULL,
    puesto VARCHAR(50) NOT NULL,
    CONSTRAINT FK_Plato FOREIGN KEY (id_plato)
    REFERENCES Platos (id_plato)
);

CREATE TABLE Pedidos (
	id_pedido INT PRIMARY KEY auto_increment,
    nombre VARCHAR(100) NOT NULL,
    fecha_pedido date NOT NULL,
    CONSTRAINT FK_Cliente FOREIGN KEY(id_cliente)
    REFERENCES Clientes (id_cliente),
    CONSTRAINT FK_Plato FOREIGN KEY(id_plato)
    REFERENCES Platos (id_plato)
);