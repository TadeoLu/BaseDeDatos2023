#256⁰
DELIMITER //

CREATE FUNCTION ordenesSegunEstado(fechaInicio DATE, fechaFin DATE, estado VARCHAR(45))
RETURNS INT
BEGIN
	DECLARE cantOrdenes int DEFAULT 0;
	SELECT COUNT(*) INTO cantOrdenes FROM orders WHERE status = estado AND orderDate BETWEEN fechaInicio AND fechaFin;
RETURN cantOrdenes;
END//

DELIMITER ;

#2

delimiter //

create function ordenerEntrefechas(fechaInicio DATE, fechaFin DATE)
returns INT
begin
	declare cantOrdenes INT;
	select count(*) into cantOrders where shippedDate between fechaInicio and fechaFin;
return cantOrdenes;
end//

delimiter ;

#³√27

delimiter // 

create function cuidadDelCliente(nroCliente INT)
returns VARCHAR(100)
begin
	declare ciudad VARCHAR(100);
    select city into ciudad where customerNumber = nroCliente;
return ciudad;
end//

delimiter ;

#log2(16)

delimiter //

create function cantProduct(lineaProducto Varchar(50))
returns INT
begin
	declare cantProductos INT;
    select count(*) into cantProductos from productlines where productLine = lineaProducto; 
end//

delimiter ;

#5

delimiter //

create function cantClientes(codigo INT)
returns INT
begin
	declare cantCliente INT;
    select COUNT(customerNumber) into cantCliente from offices left join employees using(officeCode) left join customers using(salesRepEmployeeNumber) where officeCode = codigo;
return cantCliente; 
end//

delimiter ;

#6

delimiter //

create function cantOrdenes(codigo INT)
returns INT
begin
	declare cantOrdenes INT;
    select COUNT(customerNumber) into cantOrdenes from offices
    left join employees using(officeCode)
    left join customers using(salesRepEmployeeNumber)
    left join orders using(customerNumber) where officeCode = codigo;
return cantOrdenes;
end//

delimiter ;

#7

delimiter //

create function beneficio(nroOrden INT, codigo INT)
returns DOUBLE
begin
	declare benef DOUBLE;
    select (priceEach - buyPrice) into benef 
    from orderdetails inner join products using(productCode) 
    where orderNumber = nroOrden and productCode = codigo;
return benef;
end//

delimiter ;

#8¹

delimiter //

create function state(esto INT)
returns INT
begin
	declare devolver INT default -1;
    declare estado varchar(15);
    select status into estado from orders where orderNumber = esto;
    if estado = "Shipped" then
		set devolver = 0;
	end if;
return devolver;
end//

delimiter ;

#3²

delimiter //

create function primerOrden(numero INT)
returns date
begin
	declare fecha date;
	select requiredDate into fecha 
    from orders where customerNumber = numero and 
    requiredDate = (select min(requiredDate) 
    from orders where customerNumber = numero);
return fecha;
end//

delimiter ;

#10 

delimiter //

drop function if exists porcentajeDebajoMSRP//
create function porcentajeDebajoMSRP(codigo varchar(15))
returns int
NOT DETERMINISTIC
begin
	DECLARE done INT DEFAULT FALSE;
	declare cont int default 0;
	declare porcentaje int;
    declare precio double;
    declare msrpdeclarado double;
    declare cur CURSOR FOR SELECT buyPrice from products where productCode = codigo;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done =TRUE;
	select MSRP into msrpdeclarado from products where productCode = codigo; 
    open cur;
	FETCH cur INTO precio;
    read_loop: LOOP 
		if precio < msrpdeclarado then
			set cont = cont + 1;
		end if;
		FETCH cur INTO precio;
		IF done THEN 
			LEAVE read_loop;
		END IF;
    END LOOP;
	close cur;
    set porcentaje = (cont * 100) / (select count(*) from products where productCode = codigo);
return porcentaje;
end//

delimiter ;

#11

