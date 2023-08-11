#1
delimiter //

create procedure pedidosAnio(IN anio YEAR)
begin
	select idPedido, Fecha, codCliente from pedidos where year(fecha) = anio;
end//

delimiter ;

#5

delimiter //

create procedure cambiarDescuento(IN codigo INT, IN descuento varchar(100))
begin
	if descuento = "Descuento Amigo" then
		update Cliente set porcDescuento = 20 where codCliente = codigo;
	elseif descuento = "Descuento Familiar" then
		update Cliente set porcDescuento = 50 where codCliente = codigo;
    elseif descuento = "Descuento de Compromiso" then
		update Cliente set porcDescuento = 5 where codCliente = codigo;
    end if;
end// 

delimiter ;

call cambiarDescuento(10,"Descuento Amigo");
select * from Cliente;