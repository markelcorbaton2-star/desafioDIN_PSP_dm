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
    total DECIMAL(10,2) NOT NULL,
    id_cliente INT NOT NULL,
    CONSTRAINT FK_Factura_Cliente FOREIGN KEY (id_cliente)
        REFERENCES Clientes (id_cliente)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Empleados (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    puesto VARCHAR(50) NOT NULL
);

CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    fecha_pedido DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    CONSTRAINT FK_Pedido_Cliente FOREIGN KEY (id_cliente)
        REFERENCES Clientes (id_cliente)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Pedido_Empleado FOREIGN KEY (id_empleado)
        REFERENCES Empleados (id_empleado)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE DetallePedidos (
    id_pedido INT NOT NULL,
    id_plato INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_pedido, id_plato),
    CONSTRAINT FK_DetallePedido_Pedido FOREIGN KEY (id_pedido)
        REFERENCES Pedidos (id_pedido)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_DetallePedido_Plato FOREIGN KEY (id_plato)
        REFERENCES Platos (id_plato)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Proveedores (id_proveedor, nombre, telefono) VALUES
(1, 'Distribuciones Hosteleras S.L.', '911223344'),
(2, 'Frutas y Verduras El Huerto', '933445566'),
(3, 'Carnes Selectas del Norte', '944556677'),
(4, 'Bebidas y Licores Global', '955667788');

INSERT INTO Ingredientes (id_ingrediente, nombre, stock, id_proveedor) VALUES
(1, 'Tomate frito', 50, 1),
(2, 'Queso mozzarella', 30, 1),
(3, 'Lechuga', 40, 2),
(4, 'Pechuga de pollo', 25, 2),
(5, 'Carne de ternera picada', 40, 3),
(6, 'Pan de hamburguesa', 60, 1),
(7, 'Patatas congeladas', 100, 2),
(8, 'Refresco de cola', 150, 4);

INSERT INTO Platos (id_plato, nombre, precio) VALUES
(1, 'Pizza Margherita', 9.50),
(2, 'Ensalada César', 7.80),
(3, 'Hamburguesa Completa', 11.00),
(4, 'Patatas Fritas', 4.50);

INSERT INTO PlatoIngredientes (id_plato, id_ingrediente, cantidad_necesaria) VALUES
(1, 1, 0.20),
(1, 2, 0.15),
(2, 3, 0.30),
(2, 4, 0.20),
(3, 5, 0.20),
(3, 6, 1.00),
(4, 7, 0.30);

INSERT INTO Clientes (id_cliente, nombre, telefono, email) VALUES
(1, 'Ana Pérez', '600112233', 'ana@email.com'),
(2, 'Carlos Gómez', '699887766', 'carlos@email.com'),
(3, 'María López', '611223344', 'maria@email.com'),
(4, 'David Torres', '622334455', 'david@email.com');

INSERT INTO FACTURAS (id_factura, total, id_cliente) VALUES
(1, 17.30, 1),
(2, 15.50, 2),
(3, 22.00, 3);

INSERT INTO Empleados (id_empleado, nombre, puesto) VALUES
(1, 'Lucía Martín', 'Camarera'),
(2, 'Jorge Ruiz', 'Cocinero'),
(3, 'Sofía Castro', 'Camarera'),
(4, 'Mateo Jimeno', 'Repartidor');

INSERT INTO Pedidos (id_pedido, nombre, fecha_pedido, id_cliente, id_empleado) VALUES
(1, 'Mesa 1', '2026-06-06', 1, 1),
(2, 'Mesa 2', '2026-06-06', 2, 3),
(3, 'Para llevar 1', '2026-06-07', 3, 4);

INSERT INTO DetallePedidos (id_pedido, id_plato, cantidad) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 1),
(2, 4, 1),
(3, 3, 2);
