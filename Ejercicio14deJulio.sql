#1
create view datosPublicacion as
select publicacion.id, producto.nombre, 
usuario.nick,categoria.nombre,
estado.nombre,publicacion.precio from 
usuario join publicacion 
on usuario.id = publicacion.vendedor join producto
on publicacion.producto = producto.id join estado
on publicacion.estado = estado.id join categoria
on publicacion.categoria = categoria.id;

#2
create view datosVentas as
select venta.id, pago.nombre, envio.nombre, 
usuario.nick from ventas join pago
on ventas.pago = pago.id join envio
on ventas.envio = envio.id join usuario
on ventas.comprador = usuario.id;

#3
delimiter //

drop procedure if exists buscarPublicacion//
create procedure buscarPublicacion
(IN nombreProducto VARCHAR(100))
begin
	select datosPublicacion where producto.nombre = 
    nombreProducto;
end//

delimiter ;

#4

delimiter //

drop procedure if exists estadoPublicaciones//
create procedure estadoPublicaciones(
IN id_usuario INT,OUT activas INT,
OUT pausadas INT, OUT finalizadas INT)
begin
	select count(publicacion.vendedor) into activas 
    from publicacion join estado 
    on publicacion.estado = estado.id
    where estado.nombre = "activo";
    select count(publicacion.vendedor) into pausadas
    from publicacion join estado 
    on publicacion.estado = estado.id
    where estado.nombre = "pausado";
    select count(publicacion.vendedor) into finalizadas
    from publicacion join estado 
    on publicacion.estado = estado.id
    where estado.nombre = "finalizado";
end//
delimiter ;

#5

delimiter //

drop procedure if exists borrarProducto//
create procedure borrarProducto(IN id_producto INT
,OUT borro varchar(100))
begin
	declare done INT default false;
	declare estado1 varchar(100);
    declare todosFinalizados bool default true;
    declare cur CURSOR FOR select estado.nombre from 
    publicacion join estado on publicacion.estado = estado.id
    where publicacion.producto = id_producto;
    declare continue handler for not found set done = true;
    open cur;
    recorrer : loop
		fetch cur into estado1;
        if done = true then
			leave recorrer;
        end if;
        if estado1 != "finalizado" then
			set todosFinalizados = false;
		end if;
    end loop;
    close cur;
    if todosFinalizados = true then
		delete from producto where id = id_producto;
        set borro = "El producto fue borrado";
	else
		set borro = "El producto no pudo borrarse porque 
        figura en publicaciones activas";
	end if;
end//

delimiter ;

#6 Realice un procedimiento que reciba un id_publicacion y devuelva la velocidad 
#medida en días de respuesta del vendedor obteniendo el promedio de días
#transcurridos desde la fecha de pregunta hasta la fecha de respuesta.
#Usar la función DATEDIFF

delimiter //

drop procedure if exists promedioTiempoRespuesta;
create procedure promedioTiempoRespuesta(IN id_publicacion INT,
OUT promedio DECIMAL(10,2))
begin
	declare done INT dafault false;
    declare id_vendedor int;
    declare suma decimal(10,2) default 0;
    declare fPregunta date;
    declare fRespuesta date;
    declare cantidad int;
    select vendedor into id_vendedor from publicacion where id = id_publicacion;
    select count(pregunta.id) into cantidad from publicacion join pregunta on 
    pregunta.publicacion = publicacion.id where vendedor = id_vendedor;
    declare cur CURSOR FOR SELECT fecha_pregunta, fecha_repuesta from publicacion join pregunta on 
    pregunta.publicacion = publicacion.id where vendedor = id_vendedor;
    declare continue handler for not found set DONE = true;
    open cur;
    recorrer: loop
		fetch cur into fPregunta, fRespuesta;
        set suma = suma + datediff(day, fPregunta, fRespuesta);
        if done = true then
			leave recorrer;
		end if;
	end loop;
    set promedio = suma / cantidad;
	close cur;
end//

delimiter ;