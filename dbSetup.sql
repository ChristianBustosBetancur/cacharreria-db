CREATE DATABASE CACHARRERIA;
GO

USE CACHARRERIA;
GO

--Principales
CREATE TABLE PROVEEDORES
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	empresa VARCHAR(30) NOT NULL,
	telefono VARCHAR(10)
);

CREATE TABLE COMPONENTES
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	descripcion VARCHAR(100) NOT NULL,
	tipo VARCHAR(30) NOT NULL
);

CREATE TABLE CATEGORIAS
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
    descripcion VARCHAR(100)
);

CREATE TABLE SEDES
(
    id INT IDENTITY(1,1) PRIMARY KEY,
    direccion VARCHAR(100) NOT NULL,
    enfoque VARCHAR(100) NOT NULL
);

CREATE TABLE CLIENTES
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	telefono VARCHAR(10)
);

--Secundarias
CREATE TABLE PRODUCTOS
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	stock INT NOT NULL CHECK (stock >= 0),
	precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
	relevancia INT,
	id_categoria INT NOT NULL FOREIGN KEY REFERENCES CATEGORIAS(id) 
	
);

CREATE TABLE TRABAJADORES
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	cargo VARCHAR(30) NOT NULL,
	telefono VARCHAR(10),
	sueldo DECIMAL(10,2) NOT NULL CHECK (sueldo >= 0),
	fecha_ingreso DATE NOT NULL,
	id_sede INT NOT NULL FOREIGN KEY REFERENCES SEDES(id) 
);

CREATE TABLE SUSCRIPCIONES
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	tipo VARCHAR(30) NOT NULL,
	estado VARCHAR(30) NOT NULL,
	fecha_inicio DATE NOT NULL,
	fecha_finalizacion DATE NOT NULL,
	costo DECIMAL(10,2) NOT NULL CHECK (costo >= 0),
	id_cliente INT NOT NULL FOREIGN KEY REFERENCES CLIENTES(id) 
);

CREATE TABLE VENTAS
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	monto DECIMAL(10,2) NOT NULL CHECK (monto >= 0),
	fecha DATE NOT NULL,
	metodo_pago VARCHAR(20) NOT NULL,
	id_cliente INT NOT NULL FOREIGN KEY REFERENCES CLIENTES(id), 
	id_trabajador INT NOT NULL FOREIGN KEY REFERENCES TRABAJADORES(id) 

);

CREATE TABLE PRODUCTOS_VENTAS
( 
	id INT IDENTITY(1,1) PRIMARY KEY,
	cantidad INT NOT NULL CHECK (cantidad > 0),
	id_producto INT NOT NULL FOREIGN KEY REFERENCES PRODUCTOS(id),
	id_venta INT NOT NULL FOREIGN KEY REFERENCES VENTAS(id) 
		
);

CREATE TABLE PROVEEDORES_PRODUCTOS
(	
	id INT IDENTITY(1,1) PRIMARY KEY,
	id_producto INT NOT NULL FOREIGN KEY REFERENCES PRODUCTOS(id),
	id_proveedor INT NOT NULL FOREIGN KEY REFERENCES PROVEEDORES(id)


);

CREATE TABLE COMPONENTES_PRODUCTOS
(
	id INT IDENTITY(1,1) PRIMARY KEY,
	cantidad INT NOT NULL CHECK (cantidad > 0),
	id_producto INT NOT NULL FOREIGN KEY REFERENCES PRODUCTOS(id),
	id_componente INT NOT NULL FOREIGN KEY REFERENCES COMPONENTES(id) 
);


--Inserts
INSERT INTO PROVEEDORES (nombre, empresa, telefono) VALUES
('Carlos Pérez', 'Distribuciones Andinas', '3001234567'),
('María Gómez', 'Papeles Medellín', '3012345678'),
('Juan López', 'Piñatas Felices', '3023456789'),
('Ana Torres', 'Hogar Express', '3034567890'),
('Luis Ramírez', 'Plasticos del Norte', '3045678901'),
('Sofía Herrera', 'Importadora El Sol', '3056789012'),
('Miguel Rojas', 'Decor Hogar SAS', '3067890123'),
('Laura Castro', 'Fiesta Total', '3078901234'),
('Pedro Sánchez', 'Oficina Moderna', '3089012345'),
('Valentina Díaz', 'Distribuidora Universal', '3090123456'),
('Andrés Ruiz', 'Mundo Escolar', '3101234567'),
('Natalia Ortiz', 'Cacharrería Central', '3112345678');

INSERT INTO COMPONENTES (nombre, descripcion, tipo) VALUES
('Plástico PP', 'Polipropileno resistente', 'Estructural'),
('Cartón', 'Cartón prensado para cajas y soportes', 'Empaque'),
('Tela de moños', 'Tela flexible para elaborar moños', 'Decorativo'),
('Madera', 'Madera liviana para estructuras', 'Estructural'),
('Metal', 'Acero inoxidable para soportes', 'Estructural'),
('Silicona', 'Silicona flexible para unión de piezas', 'Accesorio'),
('Tela', 'Tela poliéster para decoración', 'Decorativo'),
('Pintura', 'Pintura no tóxica para acabados', 'Decorativo'),
('Pegamento', 'Adhesivo industrial para ensamblaje', 'Accesorio'),
('Espuma', 'Espuma de alta densidad para relleno', 'Estructural'),
('Chaquiras', 'Chaquiras utilizadas en bisutería', 'Decorativo'),
('Caucho', 'Caucho antideslizante para bases', 'Accesorio');

INSERT INTO CATEGORIAS (nombre, descripcion) VALUES
('Papelería', 'Útiles escolares y de oficina'),
('Piñatería', 'Artículos para fiestas y celebraciones'),
('Hogar', 'Productos de uso doméstico'),
('Aseo', 'Implementos y productos de limpieza'),
('Cocina', 'Utensilios y accesorios de cocina'),
('Juguetería', 'Juguetes para niños'),
('Decoración', 'Artículos decorativos para el hogar'),
('Plásticos', 'Productos elaborados en plástico'),
('Ferretería Básica', 'Herramientas y accesorios básicos'),
('Organización', 'Productos para almacenar y organizar'),
('Escolar', 'Material para estudiantes'),
('Temporada', 'Productos de temporadas especiales');

-- 
INSERT INTO SEDES (direccion, enfoque) VALUES
('Cra. 45 #50-20, Medellín', 'Papelería, bisutería y maquillaje'),
('Cl. 10 #32-15, Medellín', 'Hogar, decoración y juguetería'),
('Cra. 80 #30-40, Medellín', 'Piñatería y celebraciones'),
('Cl. 50 #70-25, Bello', 'Papelería y oficina'),
('Cra. 52 #48-18, Envigado', 'Hogar y cocina'),
('Cl. 65 #45-10, Itagüí', 'Bisutería y accesorios'),
('Cra. 43A #15-60, Medellín', 'Maquillaje y cuidado personal'),
('Cl. 30 #75-20, Sabaneta', 'Plásticos y organización'),
('Cra. 65 #80-15, Medellín', 'Decoración y temporada'),
('Cl. 85 #48-22, Bello', 'Cocina y utensilios'),
('Cra. 38 #52-11, Medellín', 'Aseo y limpieza'),
('Cl. 44 #68-33, Envigado', 'Juguetería y entretenimiento'),
('Cra. 60 #40-12, Itagüí', 'Regalos y detalles'),
('Cl. 25 #55-30, Sabaneta', 'Variedades y promociones');

INSERT INTO CLIENTES (nombre, telefono) VALUES
('Laura Gómez', '3001234567'),
('Juan Pérez', '3012345678'),
('María Rodríguez', '3023456789'),
('Carlos Martínez', '3034567890'),
('Ana Ramírez', '3045678901'),
('David Herrera', '3056789012'),
('Valentina Castro', '3067890123'),
('Santiago López', '3078901234'),
('Camila Torres', '3089012345'),
('Miguel Sánchez', '3090123456'),
('Sara Ortiz', '3101234567'),
('Andrés Morales', '3112345678');

INSERT INTO PRODUCTOS (nombre, stock, precio, relevancia, id_categoria) VALUES
('Cuaderno 100 hojas', 120, 8500.00, 9, 1),
('Caja de Colores', 80, 12000.00, 8, 1),
('Piñata Unicornio', 15, 45000.00, 10, 2),
('Globo Metalizado', 200, 3500.00, 9, 2),
('Balde de almacenamiento', 40, 18000.00, 8, 3),
('Escoba Suave', 35, 22000.00, 8, 4),
('Lonchera', 20, 65000.00, 9, 5),
('Oso de peluche', 30, 28000.00, 7, 6),
('Florero Decorativo', 18, 35000.00, 7, 7),
('Caja Organizadora', 25, 27000.00, 8, 10),
('Cartulina Escolar', 150, 1800.00, 9, 11),
('Luces Navideñas LED', 40, 42000.00, 10, 12);

INSERT INTO TRABAJADORES (nombre, cargo, telefono, sueldo, fecha_ingreso, id_sede) VALUES
('Juan Pérez', 'Administrador', '3001111111', 3200000.00, '2023-01-15', 1),
('María Gómez', 'Cajera', '3002222222', 1800000.00, '2023-02-10', 2),
('Carlos Ramírez', 'Vendedor', '3003333333', 1900000.00, '2022-11-05', 1),
('Laura Sánchez', 'Supervisor', '3004444444', 2800000.00, '2022-09-18', 2),
('Andrés López', 'Bodeguero', '3005555555', 1700000.00, '2024-01-08', 1),
('Valentina Torres', 'Cajera', '3006666666', 1800000.00, '2023-05-12', 2),
('Miguel Herrera', 'Vendedor', '3007777777', 1950000.00, '2023-03-20', 1),
('Sofía Castro', 'Administrador', '3008888888', 3300000.00, '2021-08-30', 2),
('David Morales', 'Auxiliar', '3009999999', 1650000.00, '2024-02-14', 1),
('Camila Ortiz', 'Supervisor', '3011111111', 2900000.00, '2022-06-11', 2),
('Sebastián Ruiz', 'Vendedor', '3012222222', 2000000.00, '2023-07-25', 1),
('Natalia Díaz', 'Cajera', '3013333333', 1850000.00, '2024-03-01', 2),
('Daniel Rojas', 'Auxiliar', '3014444444', 1700000.00, '2024-04-10', 3),
('Paula Martínez', 'Vendedora', '3015555555', 1950000.00, '2023-09-18', 4);

INSERT INTO SUSCRIPCIONES (tipo, estado, fecha_inicio, fecha_finalizacion, costo, id_cliente) VALUES
('Mensual', 'Activa', '2026-01-01', '2026-01-31', 15000.00, 1),
('Trimestral', 'Activa', '2026-01-15', '2026-04-15', 40000.00, 2),
('Semestral', 'Activa', '2026-02-01', '2026-08-01', 70000.00, 3),
('Anual', 'Activa', '2026-01-10', '2027-01-10', 120000.00, 4),
('Mensual', 'Expirada', '2025-12-01', '2025-12-31', 15000.00, 5),
('Mensual', 'Activa', '2026-03-01', '2026-03-31', 15000.00, 6),
('Trimestral', 'Activa', '2026-02-15', '2026-05-15', 40000.00, 7),
('Semestral', 'Activa', '2026-01-20', '2026-07-20', 70000.00, 8),
('Anual', 'Activa', '2026-01-05', '2027-01-05', 120000.00, 9),
('Mensual', 'Cancelada', '2025-11-01', '2025-11-30', 15000.00, 10),
('Trimestral', 'Activa', '2026-03-10', '2026-06-10', 40000.00, 11),
('Mensual', 'Activa', '2026-04-01', '2026-04-30', 15000.00, 12);

INSERT INTO VENTAS (monto, fecha, metodo_pago, id_cliente, id_trabajador) VALUES
(17000.00, '2026-05-02', 'Efectivo', 1, 1),
(45000.00, '2026-05-03', 'Nequi', 2, 2),
(9000.00, '2026-05-04', 'Tarjeta', 3, 3),
(65000.00, '2026-05-05', 'Transferencia', 4, 4),
(44000.00, '2026-05-06', 'Efectivo', 5, 5),
(10500.00, '2026-05-07', 'Daviplata', 6, 6),
(18000.00, '2026-05-08', 'Tarjeta', 7, 7),
(54000.00, '2026-05-09', 'Transferencia', 8, 8),
(48000.00, '2026-05-10', 'Nequi', 9, 9),
(35000.00, '2026-05-11', 'Efectivo', 10, 10),
(56000.00, '2026-05-12', 'Tarjeta', 11, 11),
(126000.00, '2026-05-13', 'Transferencia', 12, 12);

INSERT INTO PRODUCTOS_VENTAS (cantidad, id_producto, id_venta) VALUES
(2, 1, 1),
(1, 3, 2),
(5, 11, 3),
(1, 7, 4),
(2, 6, 5),
(3, 4, 6),
(1, 5, 7),
(2, 10, 8),
(4, 2, 9),
(1, 9, 10),
(2, 8, 11),
(3, 12, 12);

INSERT INTO PROVEEDORES_PRODUCTOS (id_producto, id_proveedor) VALUES
(1, 2),
(2, 9),
(3, 3),
(4, 8),
(5, 5),
(6, 12),
(7, 4),
(8, 10),
(9, 7),
(10, 6),
(11, 11),
(12, 1);

INSERT INTO COMPONENTES_PRODUCTOS (cantidad, id_producto, id_componente) VALUES
(20, 1, 2), 
(12, 2, 1),
(5, 3, 3), 
(50, 4, 1), 
(15, 5, 1), 
(10, 6, 12),  
(8, 7, 7),  
(6, 8, 10),  
(4, 9, 11),  
(10, 10, 1),   
(100, 11, 2),  
(20, 12, 8);   


--Updates


-- Update: proveedores
UPDATE PROVEEDORES
SET telefono = '3001112222'
WHERE id = 1;

UPDATE PROVEEDORES
SET empresa = 'Papeles del Valle'
WHERE id = 2;

-- Update: componentes
UPDATE COMPONENTES
SET descripcion = 'Polipropileno de alta resistencia'
WHERE id = 1;

UPDATE COMPONENTES
SET tipo = 'Estructural'
WHERE id = 2;

-- Update: categorias
UPDATE CATEGORIAS
SET descripcion = 'Útiles escolares, de oficina y material didáctico'
WHERE id = 1;

UPDATE CATEGORIAS
SET nombre = 'Fiestas y Piñatería'
WHERE id = 2;

-- Update: sedes
UPDATE SEDES
SET enfoque = 'Papelería y Escolar'
WHERE id = 1;

UPDATE SEDES
SET direccion = 'Cl. 10 #32-18, Medellín'
WHERE id = 2;

-- Update: clientes
UPDATE CLIENTES
SET telefono = '3009998888'
WHERE id = 1;

UPDATE CLIENTES
SET nombre = 'Juan Carlos Pérez'
WHERE id = 2;

UPDATE CLIENTES
SET telefono = '3021234567'
WHERE id = 3;

-- Update: productos
UPDATE PRODUCTOS
SET precio = 9000.00
WHERE id = 1;

UPDATE PRODUCTOS
SET stock = 95
WHERE id = 2;

--ajuste de precio
UPDATE PRODUCTOS
SET precio = 47000.00, relevancia = 9
WHERE id = 3;

-- Update: trabajadores
UPDATE TRABAJADORES
SET sueldo = 3350000.00
WHERE id = 1;

UPDATE TRABAJADORES
SET cargo = 'Cajera Principal'
WHERE id = 2;

-- tuvo un ascenso a supervisor
UPDATE TRABAJADORES
SET cargo = 'Supervisor', sueldo = 2500000.00
WHERE id = 3;

-- Update: suscripciones
UPDATE SUSCRIPCIONES
SET estado = 'Renovada'
WHERE id = 1;

UPDATE SUSCRIPCIONES
SET costo = 42000.00
WHERE id = 2;

-- Update: ventas
UPDATE VENTAS
SET metodo_pago = 'Tarjeta'
WHERE id = 1;

UPDATE VENTAS
SET monto = 47500.00
WHERE id = 2;

UPDATE VENTAS
SET metodo_pago = 'Nequi'
WHERE id = 3;

-- Update: productos_ventas
UPDATE PRODUCTOS_VENTAS
SET cantidad = 3
WHERE id = 1;

UPDATE PRODUCTOS_VENTAS
SET cantidad = 2
WHERE id = 2;

-- Update: proveedores_productos
UPDATE PROVEEDORES_PRODUCTOS
SET id_proveedor = 6
WHERE id = 1;

UPDATE PROVEEDORES_PRODUCTOS
SET id_proveedor = 1
WHERE id = 2;

-- Update: componentes_productos
UPDATE COMPONENTES_PRODUCTOS
SET cantidad = 25
WHERE id = 1;

UPDATE COMPONENTES_PRODUCTOS
SET cantidad = 15
WHERE id = 2;

--DELETE en orden de dependencias
-- Delete: componentes_productos
DELETE FROM COMPONENTES_PRODUCTOS 
WHERE id = 3;

DELETE FROM COMPONENTES_PRODUCTOS 
WHERE id = 9;

-- Delete: proveedores_productos
DELETE FROM PROVEEDORES_PRODUCTOS 
WHERE id = 3;

DELETE FROM PROVEEDORES_PRODUCTOS 
WHERE id = 9;

-- Delete: productos_ventas
DELETE FROM PRODUCTOS_VENTAS
WHERE id = 2;

DELETE FROM PRODUCTOS_VENTAS
WHERE id = 10;

-- Delete: ventas
DELETE FROM VENTAS
WHERE id = 2;

DELETE FROM VENTAS
WHERE id = 10;

-- Delete: suscripciones
DELETE FROM SUSCRIPCIONES
WHERE id = 2;

DELETE FROM SUSCRIPCIONES
WHERE id = 10;

-- Delete: trabajadores
DELETE FROM TRABAJADORES
WHERE id = 2;

DELETE FROM TRABAJADORES
WHERE id = 10;

-- Delete: productos
DELETE FROM PRODUCTOS
WHERE id = 3;

DELETE FROM PRODUCTOS
WHERE id = 9;

-- Delete: proveedores
DELETE FROM PROVEEDORES 
WHERE id = 3;

DELETE FROM PROVEEDORES 
WHERE id = 7;

-- Delete: componentes
DELETE FROM COMPONENTES
WHERE id = 4;

DELETE FROM COMPONENTES
WHERE id = 11;

-- Delete: categorías
DELETE FROM CATEGORIAS
WHERE id = 7;

DELETE FROM CATEGORIAS
WHERE id = 8;

-- Delete: sedes
DELETE FROM SEDES
WHERE id = 10;

DELETE FROM SEDES
WHERE id = 13;

-- Delete: clientes
DELETE FROM CLIENTES
WHERE id = 2;

DELETE FROM CLIENTES
WHERE id = 10;

-- CONSULTAS 
-- Consulta 1
SELECT nombre, cargo, telefono, sueldo
FROM TRABAJADORES
WHERE id_sede = 2;

-- Consulta 2
SELECT c.nombre, c.telefono
FROM CLIENTES AS c
JOIN SUSCRIPCIONES AS s
ON c.id = s.id_cliente
WHERE s.estado = 'Expirada';

-- Consulta 3
SELECT nombre, precio, stock
FROM PRODUCTOS
WHERE stock > 100;

-- Consulta 4
SELECT p.nombre AS producto,c.nombre AS categoria
FROM PRODUCTOS AS p
JOIN CATEGORIAS AS c 
ON p.id_categoria = c.id;

-- Consulta 5
SELECT p.nombre AS producto, pr.nombre AS proveedor, pr.empresa
FROM PRODUCTOS AS p
JOIN PROVEEDORES_PRODUCTOS AS pp
ON p.id = pp.id_producto
JOIN PROVEEDORES AS pr
ON pp.id_proveedor = pr.id;

-- Consulta 6
SELECT p.nombre AS producto, c.nombre AS componente, cp.cantidad
FROM PRODUCTOS AS p
JOIN COMPONENTES_PRODUCTOS AS cp
ON p.id = cp.id_producto
JOIN COMPONENTES AS c
ON cp.id_componente = c.id;

-- Consulta 7
SELECT nombre, descripcion, tipo
FROM COMPONENTES
WHERE tipo = 'Decorativo';

-- Consulta 8
SELECT c.nombre, c.telefono
FROM CLIENTES AS c
WHERE NOT EXISTS
(
    SELECT 1
    FROM SUSCRIPCIONES AS s
    WHERE s.id_cliente = c.id
);

-- Consulta 9
SELECT p.nombre AS producto, c.nombre AS categoria
FROM PRODUCTOS AS p
CROSS JOIN CATEGORIAS AS c;

-- Consulta 10
SELECT nombre, cargo, sueldo
FROM TRABAJADORES
WHERE sueldo > 1500000;


