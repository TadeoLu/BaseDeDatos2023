drop database if exists TPSpSf;
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TPSpSf
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema TPSpSf
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TPSpSf
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TPSpSf` DEFAULT CHARACTER SET utf8mb3 ;
USE `TPSpSf` ;

-- -----------------------------------------------------
-- Table `TPSpSf`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPSpSf`.`Categoria` (
  `idCategoria` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPSpSf`.`Provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPSpSf`.`Provincia` (
  `idProvincia` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idProvincia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPSpSf`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPSpSf`.`Cliente` (
  `CodCliente` VARCHAR(20) NOT NULL,
  `RazonCliente` VARCHAR(45) NULL DEFAULT NULL,
  `contacto` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `codigoPostal` VARCHAR(10) NULL DEFAULT NULL,
  `porcDescuento` DECIMAL(10,2) NULL DEFAULT NULL,
  `Provincia_idProvincia` INT NOT NULL,
  PRIMARY KEY (`CodCliente`),
  INDEX `fk_Cliente_Provincia1_idx` (`Provincia_idProvincia` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Provincia1`
    FOREIGN KEY (`Provincia_idProvincia`)
    REFERENCES `TPSpSf`.`Provincia` (`idProvincia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPSpSf`.`Estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPSpSf`.`Estado` (
  `idEstado` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idEstado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPSpSf`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPSpSf`.`Pedido` (
  `idPedido` INT NOT NULL,
  `fecha` DATETIME NULL DEFAULT NULL,
  `Estado_idEstado` INT NOT NULL,
  `Cliente_CodCliente` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `fk_Pedido_Estado_idx` (`Estado_idEstado` ASC) VISIBLE,
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_CodCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_CodCliente`)
    REFERENCES `TPSpSf`.`Cliente` (`CodCliente`),
  CONSTRAINT `fk_Pedido_Estado`
    FOREIGN KEY (`Estado_idEstado`)
    REFERENCES `TPSpSf`.`Estado` (`idEstado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPSpSf`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPSpSf`.`Producto` (
  `codProducto` VARCHAR(20) NOT NULL,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  `precio` DECIMAL(10,2) NULL DEFAULT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  PRIMARY KEY (`codProducto`),
  INDEX `fk_Producto_Categoria1_idx` (`Categoria_idCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `TPSpSf`.`Categoria` (`idCategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPSpSf`.`Pedido_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPSpSf`.`Pedido_Producto` (
  `item` INT NOT NULL,
  `cantidad` INT NULL DEFAULT NULL,
  `precioUnitario` DECIMAL(10,2) NULL DEFAULT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Producto_codProducto` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`item`),
  INDEX `fk_Pedido_Producto_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Pedido_Producto_Producto1_idx` (`Producto_codProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Producto_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `TPSpSf`.`Pedido` (`idPedido`),
  CONSTRAINT `fk_Pedido_Producto_Producto1`
    FOREIGN KEY (`Producto_codProducto`)
    REFERENCES `TPSpSf`.`Producto` (`codProducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPSpSf`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPSpSf`.`Proveedor` (
  `idProveedor` INT NOT NULL,
  `razonSocial` VARCHAR(45) NULL DEFAULT NULL,
  `contacto` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `codPostal` VARCHAR(10) NULL DEFAULT NULL,
  `Provincia_idProvincia` INT NOT NULL,
  PRIMARY KEY (`idProveedor`),
  INDEX `fk_Proveedor_Provincia1_idx` (`Provincia_idProvincia` ASC) VISIBLE,
  CONSTRAINT `fk_Proveedor_Provincia1`
    FOREIGN KEY (`Provincia_idProvincia`)
    REFERENCES `TPSpSf`.`Provincia` (`idProvincia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPSpSf`.`Producto_Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPSpSf`.`Producto_Proveedor` (
  `Producto_codProducto` VARCHAR(20) NOT NULL,
  `Proveedor_idProveedor` INT NOT NULL,
  `precio` DECIMAL(10,2) NULL DEFAULT NULL,
  `demoraEntrega` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Producto_codProducto`, `Proveedor_idProveedor`),
  INDEX `fk_Producto_Proveedor_Proveedor1_idx` (`Proveedor_idProveedor` ASC) VISIBLE,
  INDEX `fk_Producto_Proveedor_Producto1_idx` (`Producto_codProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Proveedor_Producto1`
    FOREIGN KEY (`Producto_codProducto`)
    REFERENCES `TPSpSf`.`Producto` (`codProducto`),
  CONSTRAINT `fk_Producto_Proveedor_Proveedor1`
    FOREIGN KEY (`Proveedor_idProveedor`)
    REFERENCES `TPSpSf`.`Proveedor` (`idProveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPSpSf`.`Producto_Ubicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPSpSf`.`Producto_Ubicacion` (
  `idProductoUbicacion` INT NOT NULL,
  `cantidad` INT NULL DEFAULT NULL,
  `estanteria` VARCHAR(45) NULL DEFAULT NULL,
  `Producto_codProducto` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idProductoUbicacion`),
  INDEX `fk_Producto_Ubicacion_Producto1_idx` (`Producto_codProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Ubicacion_Producto1`
    FOREIGN KEY (`Producto_codProducto`)
    REFERENCES `TPSpSf`.`Producto` (`codProducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `TPSpSf`.`IngresoStock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPSpSf`.`IngresoStock` (
  `idIngreso` INT NOT NULL,
  `fecha` DATETIME NULL,
  `remitoNro` VARCHAR(45) NULL,
  `Proveedor_idProveedor` INT NOT NULL,
  PRIMARY KEY (`idIngreso`),
  INDEX `fk_IngresoStock_Proveedor1_idx` (`Proveedor_idProveedor` ASC) VISIBLE,
  CONSTRAINT `fk_IngresoStock_Proveedor1`
    FOREIGN KEY (`Proveedor_idProveedor`)
    REFERENCES `TPSpSf`.`Proveedor` (`idProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TPSpSf`.`IngresoStock_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TPSpSf`.`IngresoStock_Producto` (
  `IngresoStock_idIngreso` INT NOT NULL,
  `Producto_codProducto` VARCHAR(20) NOT NULL,
  `item` INT NULL,
  `cantidad` INT NULL,
  PRIMARY KEY (`IngresoStock_idIngreso`, `Producto_codProducto`),
  INDEX `fk_IngresoStock_has_Producto_Producto1_idx` (`Producto_codProducto` ASC) VISIBLE,
  INDEX `fk_IngresoStock_has_Producto_IngresoStock1_idx` (`IngresoStock_idIngreso` ASC) VISIBLE,
  CONSTRAINT `fk_IngresoStock_has_Producto_IngresoStock1`
    FOREIGN KEY (`IngresoStock_idIngreso`)
    REFERENCES `TPSpSf`.`IngresoStock` (`idIngreso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IngresoStock_has_Producto_Producto1`
    FOREIGN KEY (`Producto_codProducto`)
    REFERENCES `TPSpSf`.`Producto` (`codProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `TPSpSf` ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Inserting data into the Provincia table
INSERT INTO `TPSpSf`.`Provincia` (`idProvincia`, `nombre`) VALUES
(1, 'Buenos Aires'),
(2, 'Cordoba'),
(3, 'Santa Fe');

-- Inserting data into the Cliente table
INSERT INTO `TPSpSf`.`Cliente` (`CodCliente`, `RazonCliente`, `contacto`, `direccion`, `telefono`, `codigoPostal`, `porcDescuento`, `Provincia_idProvincia`) VALUES
('C001', 'Cliente 1', 'Contacto 1', 'Direccion 1', '123456789', '12345', 10.00, 1),
('C002', 'Cliente 2', 'Contacto 2', 'Direccion 2', '987654321', '54321', 15.00, 2),
('C003', 'Cliente 3', 'Contacto 3', 'Direccion 3', '111222333', '67890', 5.00, 3);

-- Inserting data into the Estado table
INSERT INTO `TPSpSf`.`Estado` (`idEstado`, `nombre`) VALUES
(1, 'Pendiente'),
(2, 'En proceso'),
(3, 'Finalizado'),
(4, 'Cancelado');

-- Inserting data into the Pedido table
INSERT INTO `TPSpSf`.`Pedido` (`idPedido`, `fecha`, `Estado_idEstado`, `Cliente_CodCliente`) VALUES
(1, '2023-09-20 10:00:00', 1, 'C001'),
(2, '2023-09-21 11:00:00', 2, 'C002'),
(3, '2023-09-22 12:00:00', 3, 'C003'),
(4, '2023-09-23 13:00:00', 4, 'C001'),
(5, '2023-09-24 14:00:00', 3, 'C002');

-- Inserting data into the Proveedor table
INSERT INTO `TPSpSf`.`Proveedor` (`idProveedor`, `razonSocial`, `contacto`, `direccion`, `telefono`, `codPostal`, `Provincia_idProvincia`) VALUES
(1, 'Proveedor 1', 'Contacto 1', 'Direccion 1', '123456789', '54321', 1),
(2, 'Proveedor 2', 'Contacto 2', 'Direccion 2', '987654321', '12345', 2),
(3, 'Proveedor 3', 'Contacto 3', 'Direccion 3', '111222333', '67890', 3);

-- Inserting data into the Categoria table
INSERT INTO `TPSpSf`.`Categoria` (`idCategoria`, `nombre`) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Home Appliances');

-- Inserting data into the Producto table
INSERT INTO `TPSpSf`.`Producto` (`codProducto`, `descripcion`, `precio`, `Categoria_idCategoria`) VALUES
('P001', 'Product 1', 100.00, 1),
('P002', 'Product 2', 50.00, 2),
('P003', 'Product 3', 200.00, 1),
('P004', 'Product 4', 75.00, 3),
('P005', 'Product 5', 120.00, 2);

-- Inserting data into the Producto_Proveedor table
INSERT INTO `TPSpSf`.`Producto_Proveedor` (`Producto_codProducto`, `Proveedor_idProveedor`, `precio`, `demoraEntrega`) VALUES
('P001', 1, 95.00, 2),
('P001', 2, 98.00, 3),
('P002', 1, 45.00, 1),
('P002', 3, 48.00, 2),
('P003', 2, 190.00, 3),
('P003', 3, 195.00, 4),
('P004', 1, 70.00, 2),
('P004', 2, 72.00, 3),
('P005', 2, 115.00, 2),
('P005', 3, 118.00, 3);

-- Inserting data into the Producto_Ubicacion table
INSERT INTO `TPSpSf`.`Producto_Ubicacion` (`idProductoUbicacion`, `cantidad`, `estanteria`, `Producto_codProducto`) VALUES
(1, 100, 'Shelf A', 'P001'),
(2, 50, 'Shelf B', 'P002'),
(3, 75, 'Shelf C', 'P003'),
(4, 30, 'Shelf D', 'P004'),
(5, 60, 'Shelf E', 'P005');

-- Inserting data into the Pedido_Producto table
INSERT INTO `TPSpSf`.`Pedido_Producto` (`item`, `cantidad`, `precioUnitario`, `Pedido_idPedido`, `Producto_codProducto`) VALUES
(1, 5, 100.00, 1, 'P001'),
(2, 3, 50.00, 1, 'P002'),
(3, 2, 200.00, 2, 'P003'),
(4, 4, 75.00, 3, 'P004'),
(5, 6, 120.00, 4, 'P005'),
(6, 1, 100.00, 5, 'P001'),
(7, 2, 50.00, 5, 'P002'),
(8, 3, 200.00, 5, 'P003'),
(9, 4, 75.00, 5, 'P004'),
(10, 5, 120.00, 5, 'P005');

-- Insert into IngresoStock
INSERT INTO `TPSpSf`.`IngresoStock` (`idIngreso`, `fecha`, `remitoNro`, `Proveedor_idProveedor`) 
VALUES (1, '2023-09-22 10:00:00', 'RS001', 1),
       (2, '2023-09-23 11:30:00', 'RS002', 2),
       (3, '2023-09-24 14:45:00', 'RS003', 3);

-- Insert into IngresoStock_Producto
INSERT INTO `TPSpSf`.`IngresoStock_Producto` (`IngresoStock_idIngreso`, `Producto_codProducto`, `item`, `cantidad`)
VALUES (1, 'P001', 1, 100),
       (1, 'P003', 2, 75),
       (2, 'P001', 3, 50),
       (2, 'P002', 4, 120),
       (3, 'P003', 5, 80),
       (3, 'P005', 6, 60);


delimiter //

#1
drop procedure if exists pedidosPorAño//
create procedure pedidosPorAño(IN año year)
begin
	select idPedido,fecha,Cliente_CodCliente from Pedido where year(fecha) = año and Estado_idEstado = 
    (select idEstado from Estado where nombre = "finalizado");
end//

-- Call pedidosPorAño procedure for the year 2023
CALL pedidosPorAño(2023)//


#2
drop procedure if exists eliminarPedido//
create procedure eliminarPedido(IN id INT, OUT cantItemsBorrados int)
begin
	declare done int default 0;
    declare itemCur int;
    declare cur cursor for select item from Pedido_Producto where Pedido_idPedido = id;
    declare continue handler for not found set done = 1;
	set cantItemsBorrados = 0;
    open cur;
    borrar : loop
		if done then
			leave borrar;
        end if;
		fetch cur into itemCur;
        delete from Pedido_Producto where item = itemCur;
        set cantItemsBorrados = cantItemsBorrados + 1;
    end loop;
    close cur;
    delete from Pedido where idPedido = id;
end//

-- Call eliminarPedido procedure for deleting a specific order (e.g., order with id 1)
CALL eliminarPedido(1, @cantItemsBorrados)//
-- You can then retrieve the output variable @cantItemsBorrados using a SELECT statement
SELECT @cantItemsBorrados//


#3
drop procedure if exists pedidosPorAño//
create procedure pedidosPorAño(IN año year, IN mes int, IN codigoCliente varchar(20))
begin
	select idPedido, fecha from Pedido where year(fecha) = año and month(fecha) = mes and Cliente_codCliente = codigoCliente;
end//

-- Call pedidosPorAño procedure for the year 2023, month 9, and a specific customer (e.g., customer with code "C001")
CALL pedidosPorAño(2023, 9, 'C001')//


#4
drop procedure if exists agregarProducto//
create procedure agregarProducto(IN codigoI varchar(20), IN descripcionI varchar(100), IN precioI decimal(10,2), IN nombreCategoria varchar(45))
begin
	declare nCategoria INT;
    select idCategoria into nCategoria from Categoria where nombre = nombreCategoria;
    if (select codProducto from Producto where codProducto = codigoI) is null then
		insert into Producto values(codigoI, descripcionI, precioI, nCategoria);
	else
		select "El codigo de producto ya existe";
    end if;
end//

-- Call agregarProducto procedure to add a new product
CALL agregarProducto('P006', 'New Product', 150.00, 'Electronics')//


#5
drop procedure if exists eliminarPedido//
create procedure eliminarPedido(IN id INT, OUT cantItemsBorrados int)
begin
	declare done int default 0;
    declare itemCur int;
    declare estado varchar(45);
    declare cur cursor for select item from Pedido_Producto where Pedido_idPedido = id;
    declare continue handler for not found set done = 1;
    set cantItemsBorrados = 0;
    select nombre into estado from Estado where id in (select Estado_idEstado from Pedido where idPedido = id) limit 1;
    open cur;
    if estado != "pendiente" then
		borrar : loop
			fetch cur into itemCur;
			delete from Pedido_idPedido where item = itemCur;
			set cantItemsBorrados = cantItemsBorrados + 1;
			if done then
				leave borrar;
			end if;
		end loop;
		delete from Pedido where idPedido = id;
	else
		select "El pedido esta pendiente";
	end if;
    close cur;
end//

-- Call eliminarPedido procedure for deleting a specific order (e.g., order with id 2)
CALL eliminarPedido(2, @cantItemsBorrados)//
-- You can then retrieve the output variable @cantItemsBorrados using a SELECT statement
SELECT @cantItemsBorrados//


#6
drop procedure if exists cambiarDescuento//
create procedure cambiarDescuento(IN codigo varchar(20), IN descuento varchar(100))
begin
	if descuento = "Descuento Amigo" then
		update Cliente set porcDescuento = 20 where codCliente = codigo;
	elseif descuento = "Descuento Familiar" then
		update Cliente set porcDescuento = 50 where codCliente = codigo;
    elseif descuento = "Descuento de Compromiso" then
		update Cliente set porcDescuento = 5 where codCliente = codigo;
    end if;
end// 

-- Call cambiarDescuento procedure to change the discount for a specific customer (e.g., customer with code "C002")
CALL cambiarDescuento('C002', 'Descuento Amigo')//


#funcions
#1
drop function if exists stockProducto//
create function stockProducto(codigo varchar(20))
RETURNS INT
DETERMINISTIC
begin
	declare stock INT;
	select sum(cantidad) into stock from IngresoStock_Producto where Producto_codProducto = codigo;
    return stock;
end//

-- Select the stock of a specific product (e.g., product with code "P001")
SELECT stockProducto('P001')//


#2
drop function if exists precioMasEconomico//
create function precioMasEconomico(codigo varchar(20))
RETURNS DECIMAL(10,2)
DETERMINISTIC
begin
	declare economico DECIMAL(10,2);
	select min(precio) into economico from Producto_Proveedor where Producto_codProducto = codigo;
    return economico;
end//

-- Select the cheapest price for a specific product (e.g., product with code "P001")
SELECT precioMasEconomico('P001')//

#3
drop function if exists provinciaCliente//
create function provinciaCliente(codigo varchar(20))
RETURNS varchar(45)
DETERMINISTIC
begin
	declare provincia varchar(45);
	select nombre into provincia from Provincia where idProvincia in (select Provincia_idProvincia from Cliente where codCliente = codigo);
    return provincia;
end//

-- Select the province of a specific customer (e.g., customer with code "C001")
SELECT provinciaCliente('C001')//


#4
drop function if exists pedidosPorProv//
create function pedidosPorProv(nombreProv varchar(45))
RETURNS INT
DETERMINISTIC
begin
	declare cantPedidos INT;
	select Provincia.nombre, sum(count(Pedido.idPedido)) into cantPedidos 
    from Pedido join Cliente on Cliente_CodCliente = CodCliente
    join Provincia on Provincia_idProvincia = idProvincia 
    where Provincia.nombre = nombreProv group by Provincia.nombre; 
    return cantPedidos;
end//

-- Select the number of orders for customers in a specific province (e.g., province "Buenos Aires")
SELECT pedidosPorProv('Buenos Aires')//


#5
drop function if exists productosPorCategoria//
create function productosPorCategoria(nombreCateg varchar(45))
RETURNS INT
DETERMINISTIC
begin
	declare cantProds INT;
	select count(codProducto) into cantProds from Producto where Categoria_idCategoria = 
    (select idCategoria from Categoria where nombre = nombreCateg);
    return cantProds;
end//

-- Select the number of products in a specific category (e.g., category "Electronics")
SELECT productosPorCategoria('Electronics')//


#6
drop function if exists precioVenta//
create function precioVenta(codigoProd varchar(20), codigoCliente varchar(20))
RETURNS INT
DETERMINISTIC
begin
	declare precioVenta INT;
	select precio into precioVenta from Producto_Proveedor where Producto_codProducto = codigoProd limit 1;
    set precioVenta = (precioVenta * (select porcDescuento from Cliente where codCliente = codigoCliente)) / 100;
    return precioVenta;
end//

-- Select the sale price of a specific product (e.g., product with code "P001") for a specific customer (e.g., customer with code "C001")
SELECT precioVenta('P001', 'C001');


#7
drop function if exists tiempoMinimoEnvio//
create function tiempoMinimoEnvio(codigo varchar(20))
RETURNS INT
DETERMINISTIC
begin
	declare tiempoMinimo INT;
	select min(demoraEntrega) into tiempoMinimo from Producto_Proveedor where Producto_codProducto = codigo;
    return tiempoMinimo;
end//

-- Select the minimum delivery time for a specific product (e.g., product with code "P001")
SELECT tiempoMinimoEnvio('P001')//


#8
drop function if exists isCancelado//
create function isCancelado(id INT)
RETURNS INT
DETERMINISTIC
begin
	declare sino INT default 0;
	if (select nombre from Estado where idEstado = (select Estado_idEstado from Pedido where idPedido = id)) = "Cancelado" then
		set sino = -1;
    end if;
    return sino;
end//

-- Select whether a specific order is canceled or not (e.g., order with id 4)
SELECT isCancelado(4)//


#9
drop function if exists fechaPrimerPedido//
create function fechaPrimerPedido(codigo varchar(20))
RETURNS DATETIME
DETERMINISTIC
begin
	declare fechaMinima DATETIME;
	select min(fecha) into fechaMinima from Pedido where Cliente_codCliente = codigo;
    return fechaMinima;
end//

-- Select the date of the first order for a specific customer (e.g., customer with code "C001")
SELECT fechaPrimerPedido('C001')//


#10
drop function if exists fechaUltimoPedido//
create function fechaUltimoPedido(codigo varchar(20))
RETURNS DATETIME
DETERMINISTIC
begin
	declare fechaMinima DATETIME;
	select max(fecha) into fechaMinima from Pedido where Cliente_codCliente = codigo;
    return fechaMinima;
end//

-- Select the date of the latest order for a specific customer (e.g., customer with code "C001")
SELECT fechaUltimoPedido('C001')//


#11
drop function if exists maxPorcDescuento//
create function maxPorcDescuento()
RETURNS DECIMAL(10,2)
DETERMINISTIC
begin
	declare maxDecuento DECIMAL(10,2);
	select max(porcDescuento) into maxDecuento from Cliente;
    return maxDecuento;
end//

-- Select the maximum discount percentage among all customers
SELECT maxPorcDescuento()//


delimiter ;