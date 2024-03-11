USE TechSupplies;

-- Chequeo de claves duplicadas
SELECT ID, COUNT(*) FROM clientes GROUP BY ID HAVING COUNT(*) > 1;
SELECT ID, COUNT(*) FROM sucursales GROUP BY ID HAVING COUNT(*) > 1;
SELECT ID_empleado, COUNT(*) FROM empleados GROUP BY ID_empleado HAVING COUNT(*) > 1;
SELECT IdProveedor, COUNT(*) FROM proveedores GROUP BY IdProveedor HAVING COUNT(*) > 1;
SELECT ID_PRODUCTO, COUNT(*) FROM productos GROUP BY ID_PRODUCTO HAVING COUNT(*) > 1;

-- Cambio de nombres los ID
ALTER TABLE `clientes` CHANGE `ID` `IdCliente` INT NOT NULL;
ALTER TABLE clientes CHANGE Nombre_y_Apellido Nombre_apellido varchar (150) not null;
ALTER TABLE `empleados` CHANGE `ID_empleado` `IdEmpleado` INT NULL DEFAULT NULL;
ALTER TABLE `proveedores` CHANGE `IDProveedor` `IdProveedor` INT NULL DEFAULT NULL;
ALTER TABLE proveedores CHANGE Address Domicilio varchar(100);
ALTER TABLE proveedores CHANGE City Ciudad varchar(70); 
ALTER TABLE proveedores CHANGE State Provincia varchar(50);
ALTER TABLE proveedores CHANGE Country Pais varchar(50); 
ALTER TABLE proveedores CHANGE departamen Departamento varchar(50);
ALTER TABLE `sucursales` CHANGE `ID` `IdSucursal` INT NULL DEFAULT NULL;
ALTER TABLE `sucursales` CHANGE Direccion Domicilio varchar(150);
ALTER TABLE `tipodegastos` CHANGE `Descripcion` `Tipo_Gasto` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8mb3_spanish_ci NOT NULL;
ALTER TABLE `productos` CHANGE `ID_PRODUCTO` `IdProducto` INT NULL DEFAULT NULL;
ALTER TABLE `productos` CHANGE `Concepto` `Producto` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NULL DEFAULT NULL;

-- Tipos de datos
SELECT * FROM clientes limit10;
  
ALTER TABLE `clientes` 	ADD `Latitud` DECIMAL(13,10) NOT NULL DEFAULT '0' AFTER `Y`, 
						ADD `Longitud` DECIMAL(13,10) NOT NULL DEFAULT '0' AFTER `Latitud`;
UPDATE clientes SET Y = '0' WHERE Y = '';
UPDATE clientes SET X = '0' WHERE X = '';
UPDATE clientes SET Latitud = REPLACE(Y,',','.');
UPDATE clientes SET Longitud = REPLACE(X,',','.');

ALTER TABLE `clientes` DROP `Y`;
ALTER TABLE `clientes` DROP `X`;

SELECT * FROM empleados;

ALTER TABLE `empleados` ADD `Salario1` DECIMAL(10,2) NOT NULL DEFAULT '0' AFTER `Salario`;
UPDATE `empleados` SET Salario1 = Salario;
ALTER TABLE `empleados` DROP `Salario`;
ALTER TABLE `empleados` CHANGE `Salario1` `Salario`DECIMAL(10,2) NOT NULL DEFAULT '0';

SELECT * FROM productos;

ALTER TABLE `productos` ADD `Precio1` DECIMAL(15,3) NOT NULL DEFAULT '0' AFTER `Precio`;
UPDATE `productos` SET Precio1 = REPLACE(Precio,',','.');
ALTER TABLE `productos` DROP `Precio`;
ALTER TABLE `productos` CHANGE `Precio1` `Precio`DECIMAL(15,3) NOT NULL DEFAULT '0';

SELECT * FROM sucursales;

ALTER TABLE `sucursales` ADD `Latitud1` DECIMAL(13,10) NOT NULL DEFAULT '0' AFTER `Longitud`, 
						 ADD `Longitud1` DECIMAL(13,10) NOT NULL DEFAULT '0' AFTER `Latitud`;
UPDATE `sucursales` SET Latitud1 = REPLACE(Latitud,',','.');
UPDATE `sucursales` SET Longitud1 = REPLACE(Longitud,',','.');
ALTER TABLE `sucursales` DROP `Latitud`;
ALTER TABLE `sucursales` DROP `Longitud`;
ALTER TABLE `sucursales` CHANGE `Latitud1` `Latitud`  DECIMAL(13,10) NOT NULL DEFAULT '0';
ALTER TABLE `sucursales` CHANGE `Longitud1` `Longitud` DECIMAL(13,10) NOT NULL DEFAULT '0';
SET SQL_SAFE_UPDATES = 0;

SELECT * FROM ventas;
UPDATE `ventas` set `Precio` = '0' WHERE `Precio` = '';
ALTER TABLE `ventas` CHANGE `Precio` `Precio` DECIMAL(15,3) NOT NULL DEFAULT '0';

-- Columnas sin usar
ALTER TABLE `clientes` DROP `col10`;

-- Imputar Valores Faltantes
UPDATE `clientes` SET Domicilio = 'Sin Dato' WHERE TRIM(Domicilio) = "" OR ISNULL(Domicilio);
UPDATE `clientes` SET Localidad = 'Sin Dato' WHERE TRIM(Localidad) = "" OR ISNULL(Localidad);
UPDATE `clientes` SET Nombre_apellido = 'Sin Dato' WHERE TRIM(Nombre_apellido) = "" OR ISNULL(Nombre_apellido);
UPDATE `clientes` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);

UPDATE `empleados` SET Apellido = 'Sin Dato' WHERE TRIM(Apellido) = "" OR ISNULL(Apellido);
UPDATE `empleados` SET Nombre = 'Sin Dato' WHERE TRIM(Nombre) = "" OR ISNULL(Nombre);
UPDATE `empleados` SET Sucursal = 'Sin Dato' WHERE TRIM(Sucursal) = "" OR ISNULL(Sucursal);
UPDATE `empleados` SET Sector = 'Sin Dato' WHERE TRIM(Sector) = "" OR ISNULL(Sector);
UPDATE `empleados` SET Cargo = 'Sin Dato' WHERE TRIM(Cargo) = "" OR ISNULL(Cargo);

UPDATE `productos` SET Producto = 'Sin Dato' WHERE TRIM(Producto) = "" OR ISNULL(Producto);
UPDATE `productos` SET Tipo = 'Sin Dato' WHERE TRIM(Tipo) = "" OR ISNULL(Tipo);

UPDATE `proveedores` SET Nombre = 'Sin Dato' WHERE TRIM(Nombre) = "" OR ISNULL(Nombre);
UPDATE `proveedores` SET Domicilio = 'Sin Dato' WHERE TRIM(Domicilio) = "" OR ISNULL(Domicilio);
UPDATE `proveedores` SET Ciudad = 'Sin Dato' WHERE TRIM(Ciudad) = "" OR ISNULL(Ciudad);
UPDATE `proveedores` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);
UPDATE `proveedores` SET Pais = 'Sin Dato' WHERE TRIM(Pais) = "" OR ISNULL(Pais);
UPDATE `proveedores` SET Departamento = 'Sin Dato' WHERE TRIM(Departamento) = "" OR ISNULL(Departamento);

UPDATE `sucursales` SET Domicilio = 'Sin Dato' WHERE TRIM(Domicilio) = "" OR ISNULL(Domicilio);
UPDATE `sucursales` SET Sucursal = 'Sin Dato' WHERE TRIM(Sucursal) = "" OR ISNULL(Sucursal);
UPDATE `sucursales` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);
UPDATE `sucursales` SET Localidad = 'Sin Dato' WHERE TRIM(Localidad) = "" OR ISNULL(Localidad);

/*Normalizacion a Letra Capital*/
/*Función y Procedimiento provistos*/

SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS `UC_Words`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `UC_Words`( str VARCHAR(255) ) RETURNS varchar(255) CHARSET utf8
BEGIN  
  DECLARE c CHAR(1);  
  DECLARE s VARCHAR(255);  
  DECLARE i INT DEFAULT 1;  
  DECLARE bool INT DEFAULT 1;  
  DECLARE punct CHAR(17) DEFAULT ' ()[]{},.-_!@;:?/';  
  SET s = LCASE( str );  
  WHILE i < LENGTH( str ) DO  
     BEGIN  
       SET c = SUBSTRING( s, i, 1 );  
       IF LOCATE( c, punct ) > 0 THEN  
        SET bool = 1;  
      ELSEIF bool=1 THEN  
        BEGIN  
          IF c >= 'a' AND c <= 'z' THEN  
             BEGIN  
               SET s = CONCAT(LEFT(s,i-1),UCASE(c),SUBSTRING(s,i+1));  
               SET bool = 0;  
             END;  
           ELSEIF c >= '0' AND c <= '9' THEN  
            SET bool = 0;  
          END IF;  
        END;  
      END IF;  
      SET i = i+1;  
    END;  
  END WHILE;  
  RETURN s;  
END$$
DELIMITER ;

UPDATE clientes SET  Domicilio = UC_Words(TRIM(Domicilio)),
                    Nombre_apellido= UC_Words(TRIM(Nombre_apellido));
UPDATE sucursales SET Domicilio = UC_Words(TRIM(Domicilio)),
                    Sucursal = UC_Words(TRIM(Sucursal));
UPDATE proveedores SET Nombre = UC_Words(TRIM(Nombre)),
                    Domicilio = UC_Words(TRIM(Domicilio));
UPDATE productos SET Producto = UC_Words(TRIM(Producto));
UPDATE empleados SET Nombre = UC_Words(TRIM(Nombre)),
                    Apellido = UC_Words(TRIM(Apellido));
                    

/*Tabla ventas limpieza y normalizacion*/
-- Solucion al precio=0
select * from ventas where Precio = '' or Cantidad = ''; # 1800 registros
select count(*) from ventas; #46645 registros 

SET SQL_SAFE_UPDATES = 0; 

UPDATE ventas v JOIN productos p ON (v.IdProducto = p.IdProducto) 
SET v.Precio = p.Precio
WHERE v.Precio = 0;

SELECT * FROM ventas;
/*Tabla auxiliar donde se guardarán registros con problemas:*/
-- Solucion a Cantidad en Cero

DROP TABLE IF EXISTS `aux_venta`;
CREATE TABLE IF NOT EXISTS `aux_venta` (
  `IdVenta`	INTEGER,
  `Fecha` DATE NOT NULL,
  `Fecha_Entrega` DATE NOT NULL,
  `IdCliente`			INTEGER, 
  `IdSucursal`			INTEGER,
  `IdEmpleado`			INTEGER,
  `IdProducto`			INTEGER,
  `Precio`				FLOAT,
  `Cantidad`			INTEGER,
  `Motivo`				INTEGER)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

UPDATE ventas SET Cantidad = REPLACE(Cantidad, '\r', '');  #Saco posibles caracteres extraños

INSERT INTO aux_venta (IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad, Motivo)
SELECT IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, 0, 1
FROM ventas WHERE Cantidad = '' or Cantidad is null;

UPDATE ventas SET Cantidad = '1' WHERE Cantidad = '' or Cantidad is null; #Ahora si puedo solucionar la cantidad=0 y poner al menos 1

ALTER TABLE `ventas` CHANGE `Cantidad` `Cantidad` INTEGER NOT NULL DEFAULT '0'; #Recien ahora puedo cambiar el tipo de dato, despues de las modificaciones de recien

/*Chequeo de claves duplicadas*/

SELECT IdCliente, COUNT(*) FROM cliente GROUP BY IdCliente HAVING COUNT(*) > 1;
SELECT IdSucursal, COUNT(*) FROM sucursal GROUP BY IdSucursal HAVING COUNT(*) > 1;
SELECT IdEmpleado, COUNT(*) FROM empleado GROUP BY IdEmpleado HAVING COUNT(*) > 1; #Aca tengo ID duplicados
SELECT IdProveedor, COUNT(*) FROM proveedor GROUP BY IdProveedor HAVING COUNT(*) > 1;
SELECT IdProducto, COUNT(*) FROM producto GROUP BY IdProducto HAVING COUNT(*) > 1;

-- Solucion a los ID duplicados
-- select count(*) from empleados; #267
SELECT e.*, s.IdSucursal
COLLATE utf8mb4_spanish_ci
FROM empleados e 
JOIN sucursales s 
	ON (e.sucursal = s.sucursal);

SELECT DISTINCT Sucursal  FROM empleados 
WHERE Sucursal NOT IN (SELECT Sucursal FROM sucursales); 

/*Generacion de clave única tabla empleado mediante creacion de clave subrogada*/

UPDATE empleados SET Sucursal = 'Mendoza1' WHERE Sucursal = 'Mendoza 1';
UPDATE empleados SET Sucursal = 'Mendoza2' WHERE Sucursal = 'Mendoza 2';
UPDATE empleados SET Sucursal = 'Cordoba Quiroz' WHERE Sucursal = 'C';

ALTER TABLE `empleados` ADD `IdSucursal` INT NULL DEFAULT '0' AFTER `Sucursal`;

UPDATE empleados e JOIN sucursales s
	ON (e.Sucursal = s.Sucursal)
SET e.IdSucursal = s.IdSucursal;

ALTER TABLE `empleados` DROP `Sucursal`;
ALTER TABLE `empleados` ADD `CodigoEmpleado` INT NULL DEFAULT '0' AFTER `IdEmpleado`;

UPDATE empleados SET CodigoEmpleado = IdEmpleado;
UPDATE empleados SET IdEmpleado = (IdSucursal * 1000000) + IdEmpleado;

/*Chequeo de claves duplicadas*/

SELECT * FROM `empleados`;
SELECT IdEmpleado, COUNT(*) FROM empleados GROUP BY IdEmpleado HAVING COUNT(*) > 1;

/*Modificacion de la clave foranea de empleado en venta*/

UPDATE ventas SET IdEmpleado = (IdSucursal * 1000000) + IdEmpleado;

/*Normalizacion tabla empleado*/

DROP TABLE IF EXISTS `cargo`;

CREATE TABLE IF NOT EXISTS `cargo` (
  `IdCargo` integer NOT NULL AUTO_INCREMENT,
  `Cargo` varchar(50) NOT NULL,
  PRIMARY KEY (`IdCargo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


DROP TABLE IF EXISTS `sector`;

CREATE TABLE IF NOT EXISTS `sector` (
  `IdSector` integer NOT NULL AUTO_INCREMENT,
  `Sector` varchar(50) NOT NULL,
  PRIMARY KEY (`IdSector`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO cargo (Cargo) SELECT DISTINCT Cargo FROM empleados ORDER BY 1;
INSERT INTO sector (Sector) SELECT DISTINCT Sector FROM empleados ORDER BY 1;
				
SELECT * FROM cargo;
SELECT * FROM sector;

ALTER TABLE `empleados` 	ADD `IdSector` INT NOT NULL DEFAULT '0' AFTER `IdSucursal`, 
						ADD `IdCargo` INT NOT NULL DEFAULT '0' AFTER `IdSector`;

UPDATE empleados e JOIN cargo c ON (c.Cargo = e.Cargo) SET e.IdCargo = c.IdCargo;
UPDATE empleados e JOIN sector s ON (s.Sector = e.Sector) SET e.IdSector = s.IdSector;


ALTER TABLE `empleados` DROP `Cargo`;
ALTER TABLE `empleados` DROP `Sector`;

SELECT * FROM `empleados`;

/*Normalización tabla producto*/

ALTER TABLE `productos` ADD `IdTipoProducto` INT NOT NULL DEFAULT '0' AFTER `Precio`;

DROP TABLE IF EXISTS `tipo_producto`;

CREATE TABLE IF NOT EXISTS `tipo_producto` (
  `IdTipoProducto` int(11) NOT NULL AUTO_INCREMENT,
  `TipoProducto` varchar(50) NOT NULL,
  PRIMARY KEY (`IdTipoProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tipo_producto (TipoProducto) SELECT DISTINCT Tipo FROM productos ORDER BY 1;

UPDATE productos p JOIN tipo_producto t ON (p.Tipo = t.TipoProducto) SET p.IdTipoProducto = t.IdTipoProducto;
UPDATE tipo_producto SET TipoProducto = UC_Words(TRIM(TipoProducto));

SELECT * FROM `productos`;
ALTER TABLE `productos`
DROP `Tipo`;