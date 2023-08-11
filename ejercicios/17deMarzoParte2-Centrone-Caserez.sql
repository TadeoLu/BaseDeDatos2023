/*1*/
create view poemaEquis as
select nombre from escritores join poemas using (id_escritor) where id_poema = 1300 and lower(titulo) = "equis";
select * from poemaEquis;
/*2*/
create view cantPoemassinEscritor as
select count(id_poemas) from poemas where id_escritor is NULL;
select * from cantPoemassinEscritor;
/*3*/
create view direcciones as
select direccion from Escritores join Poemas using (id_escritores) where id_poema between 9 and 100;
select * from direcciones;
/*4*/
drop view cantPoemas;
create view cantPoemas as
select nombre, apellido, count(id_poemas) as cantPoema from escritores join poemas using (id_escritores) group by nombre,apellido;
select * from cantPoemas;
/*5*/
create view cantPoemasporTipo as
select lower(tipo), count(id_poemas) as cantPoemas from poemas group by lower(tipo);
select * from cantPoemasporTipo;
/*6*/
create view edadProm as
select avg(edad) from escritores join poemas using (id_escritores) where tipo ="Lirico";
select * from edadProm;
/*7*/
create view descripcionPoemas as 
select descripcion from poemas join escritores using(id_escritores) where lower(apellido) like "%a" or lower(apellido) like "%e" or lower(apellido) like "%i" or lower(apellido) like "%o" or lower(apellido) like "%u";
select * from descripcionPoemas;
/*8*/
create view pabloNerudaJoin as
select titulo, descripcion, tipo from poemas join escritores using (id_escritores) where nombre = "Pablo" and apellido = "Neruda";
select * from pabloNerudaJoin;
create view pabloNerudaSub as
select titulo, descripcion from poemas where id_escritores in (select id_escritores from escritores where nombre = "Pablo" and apellido = "Neruda");
select * from pabloNerudaSub;
/*9*/
create view edadJoin as
select count(id_poemas) from poemas join escritores using(id_escritores) where edad > 60;
select * from edadJoin;
create view edadSub as
select count(id_poemas) from poemas where id_escritores in (select id_escritores from escritores where edad > 60);
select * from edadSub;
/*10*/
create view edadProm as
select avg(edad) from escritores join poemas using(id_escritores) where titulo like "% %";
select *from edadProm;