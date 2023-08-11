
/*1*/
DELIMITER //
drop procedure precioMayorPromedio;
CREATE PROCEDURE precioMayorPromedio(out productosPrecioMayorPromedio INT)
BEGIN
  DECLARE precioPromedio DECIMAL(10,2) default 0;
  SET precioPromedio = (SELECT AVG(buyPrice) FROM products);
  set productosPrecioMayorPromedio = (select count(*) from products where buyPrice > precioPromedio);
END//
delimiter ;
CALL precioMayorPromedio(@productosPrecioMayorPromedio);
SELECT @productosPrecioMayorPromedio;//

/*2*/
delimiter //
CREATE PROCEDURE borrarOrden(IN numeroOrden INT(11), OUT cantEliminados INT)
BEGIN
    DELETE FROM orders WHERE orderNumber = numeroOrden;
    SET cantEliminados = ROW_COUNT();
END//
delimiter ;
call borrarOrden(1,@cantEliminados);
select @cantEliminados;

/*3*/
delimiter //
create procedure borrarProductLines(IN lineaProducto varchar(50))
begin
	declare Mensaje varchar(100) default 0;
    declare cantEliminados INT;
    set cantEliminados = 0;
    DELETE FROM orders WHERE productLine = lineaProducto;
    SET cantEliminados = ROW_COUNT();
    if cantEliminados > 0 then 
		set Mensaje = "La linea de productos fue borrada";
    else 
		set Mensaje = "La línea de productos no pudo borrarse porque contiene productos asociados";
    end if;
    return Mensaje;
end//
delimiter ;

call borrarProductLines("Classic Cars",@mensaje);
select @mensaje;

/*Cursors*/
delimiter //
create procedure ceroAlNumero(IN numero INT)
begin
	declare n INT default 0;
	while numero <= n do
		select n;
		set n = n + 1;
    end while;
end
delimiter ;