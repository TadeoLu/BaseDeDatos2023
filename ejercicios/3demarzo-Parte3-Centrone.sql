#1
select p.lugar, a.nombre_alojamiento, p.cant_dias, p.cant_noches, p.costo from paquete_de_viaje as p join alojamiento as a on p.idalojamiento = a.idalojamiento where costo in (select max(costo) from paquete_de_viaje);
#2
update paquete_de_viaje set cant_excursiones = 2 where costo = (select min(costo) from paquete_de_viaje);
#3
select idcliente, idpago, monto from pago where monto > (select avg(monto) from pago);
#4
select idpaquete, lugar from paquete_de_viaje where idpaquete not in (select idpaquete from reservas);
#5
select p.idpaquete, p.lugar from paquete_de_viaje as p left join reservas as r on p.idpaquete = r.idpaquete where idreservas is NULL;
#6
delete from cliente where idcliente not in (select idcliente from reservas);
#7
select Apellido_nombre from cliente where idcliente in (select idcliente from reservas);
#8
select c.Apellido_nombre from cliente as c left join reservas as r on c.idcliente = r.idcliente where idreservas is NULL;
  