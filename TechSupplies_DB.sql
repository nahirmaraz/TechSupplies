
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile=1;

-- Crear base de datos
CREATE DATABASE TechSupplies;

USE TechSupplies;

-- Crear tabla 'gasto'
CREATE TABLE IF NOT EXISTS gasto(
	idGasto INT,
	idSucursal INT,
	idTipoGasto INT,
	fecha DATE,
	monto DECIMAL(10,2));

LOAD DATA LOCAL INFILE 'D:/Documentos/Downloads//Gasto.csv'
INTO TABLE gasto
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY ''
LINES TERMINATED BY '\n' IGNORE 1 LINES
(idGasto, idSucursal, idTipoGasto, fecha, monto);

SELECT* FROM gasto
limit 10000;

-- Crear tabla 'canalDeVenta'
CREATE TABLE IF NOT EXISTS canalDeVenta (idCanalVenta int , 
                                         CanalDeVenta varchar(50)
                                         )ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
                                         
LOAD DATA LOCAL INFILE 'D:/Documentos/Downloads/CanalDeVenta.csv'
INTO TABLE canalDeVenta
FIELDS TERMINATED BY ','
ENCLOSED BY '\"'
ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 lines
(idCanalVenta, CanalDeVenta);

SELECT* FROM canalDeVenta;

-- Crear tabla 'compra'
CREATE TABLE IF NOT EXISTS compra (IdCompra int,
                                    Fecha date,
                                    IdProducto int,
                                    Cantidad int,
                                    Precio decimal (10,2),
                                    IdProveedor int);
                                    
LOAD DATA LOCAL INFILE 'D:/Documentos/Downloads/Compra.csv'
INTO TABLE compra
FIELDS TERMINATED BY ','
ENCLOSED BY '\"'
ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 lines
(IdCompra ,Fecha,IdProducto,Cantidad,Precio ,IdProveedor);

SELECT* FROM compra
LIMIT 10;

-- Crear tabla 'tipoDeGastos'
CREATE TABLE IF NOT EXISTS tipoDeGastos (IdTipoGasto int,Descripcion varchar(100),Monto_Aproximado decimal (10,2));
LOAD DATA LOCAL INFILE 'D:/Documentos/Downloads/TiposDeGasto.csv'
INTO TABLE tipoDeGastos
FIELDS TERMINATED BY ','
ENCLOSED BY '\"'
ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 lines
(IdTipoGasto,Descripcion,Monto_Aproximado);
SELECT * FROM tipoDeGastos LIMIT 10;

-- Crear tabla 'sucursales'
CREATE TABLE IF NOT EXISTS sucursales(ID int,
                                     Sucursal varchar(30),
                                     Direccion varchar(150),
                                     Localidad varchar(80),
                                     Provincia varchar(50),
                                     Latitud varchar(30),
                                     Longitud varchar(30))
                                     ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

LOAD DATA LOCAL INFILE 'D:/Documentos/Downloads/Sucursales.csv'
INTO TABLE sucursales
FIELDS TERMINATED BY ';'
ENCLOSED BY '\"'
ESCAPED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 lines
(ID, Sucursal, Direccion, Localidad, Provincia, Latitud, Longitud);

SELECT * FROM sucursales LIMIT 10;

-- Crear tabla 'ventas'
CREATE TABLE IF NOT EXISTS ventas(idVenta int,
                           Fecha date,
                           Fecha_Entrega date,
                           IdCanal int,
                           IdCliente int,
                           IdSucursal int,
                           IdEmpleado int,
                           IdProducto int,
                           Precio decimal(10,2),
                           Cantidad int);
                           
LOAD DATA LOCAL INFILE 'D:/Documentos/Downloads/Venta.csv'
INTO TABLE ventas
FIELDS TERMINATED BY ','
ENCLOSED BY '\"'
ESCAPED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 lines
(IdVenta,Fecha,Fecha_Entrega,IdCanal,IdCliente,IdSucursal,IdEmpleado,IdProducto,Precio,Cantidad);   

SELECT * FROM ventas;

-- Crear tabla 'empleados'
 CREATE TABLE IF NOT EXISTS empleados(ID_empleado int,
                                        Apellido varchar(100),
                                        Nombre varchar(100),
                                        Sucursal varchar(80),
                                        Sector varchar(50),
                                        Cargo varchar(50),
                                        Salario varchar (30))
                                        ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

LOAD DATA LOCAL INFILE 'D:/Documentos/Downloads/Empleados.csv' INTO TABLE empleados
FIELDS TERMINATED BY ','
ENCLOSED BY ''
ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 lines
(ID_empleado,Apellido,Nombre,Sucursal,Sector,Cargo,Salario);

SELECT * FROM empleados;

-- Crear tabla 'productos'
CREATE TABLE IF NOT EXISTS productos(ID_PRODUCTO int,
                                     Concepto varchar(100),
                                     Tipo varchar(80),
                                     Precio varchar(50))
                                     ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
LOAD DATA LOCAL INFILE 'D:/Documentos/Downloads/Productos.csv' INTO TABLE productos
FIELDS TERMINATED BY ','
ENCLOSED BY ''
ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 lines
(ID_PRODUCTO,Concepto,Tipo,Precio);

SELECT * FROM productos;

-- Crear tabla 'proveedores'
CREATE TABLE IF NOT EXISTS proveedores(IDProveedor int,
                                       Nombre varchar(100),
                                       Address varchar(100),
                                       City varchar(70),
                                       State varchar(50),
                                       Country varchar(50),
                                       departamen varchar(50));
LOAD DATA LOCAL INFILE 'D:/Documentos/Downloads/Proveedores.csv' INTO TABLE proveedores
FIELDS TERMINATED BY ','
ENCLOSED BY ''
ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 lines
(IDProveedor,Nombre,Address,City,State,Country,departamen);

SELECT * FROM proveedores;

-- Crear tabla 'clientes'
CREATE TABLE IF NOT EXISTS clientes(ID int,
                                   Provincia varchar(50),
                                   Nombre_y_Apellido varchar(100),
                                   Domicilio varchar(150),
                                   Telefono varchar(30),
                                   Edad varchar(5),
                                   Localidad varchar(80),
                                   X varchar(30),
                                   Y varchar(30),
                                   Fecha_Alta date,
                                   Usuario_Alta varchar(30),
                                   Fecha_Ultima_Modificacion date ,
                                   Usuario_Ultima_Modificacion varchar(30),
                                   Marca_Baja tinyint,
                                   col10 varchar(1))
                                   ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

LOAD DATA LOCAL INFILE 'D:/Documentos/Downloads/Clientes.csv' 
INTO TABLE clientes
FIELDS TERMINATED BY ';'
ENCLOSED BY '\"'
ESCAPED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 lines
(ID,Provincia,Nombre_y_Apellido,Domicilio,Telefono,Edad,Localidad,X,Y,Fecha_Alta,Usuario_Alta,Fecha_Ultima_Modificacion,Usuario_Ultima_Modificacion,Marca_Baja,col10);