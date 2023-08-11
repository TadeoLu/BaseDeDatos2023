/*1*/
create view poemaEquis as
select nombre from escritores join poemas using (id_escritores) where id_poemas = 1300 and lower(titulo) = "equis";
select * from poemaEquis;
select apellido, direccion from escritores where nombre in (select * from poemaEquis); 
/*2*/
create view cantPoemassinEscritor as
select count(id_poemas) as cantPoemas from poemas where id_escritores is NULL;
select * from cantPoemassinEscritor;
SELECT IF(cantPoemas%2=0, "YES", "NO") from cantPoemassinEscritor;  
/*3*/
create view direcciones as
select direccion from escritores join poemas using (id_escritores) where id_poemas between 9 and 100;
select * from direcciones;
select substring(direccion, 1, 1) from direcciones;
/*4*/
create view cantPoemas as
select nombre, apellido, count(id_poemas) as cantPoema from escritores join poemas using (id_escritores) group by nombre,apellido;
select * from cantPoemas;
select nombre,apellido from escritores where id_escritores in (select min(cantPoema) from cantPoemas);
/*5*/
create view cantPoemasporTipo as
select lower(tipo), count(id_poemas) as cantPoemas from poemas group by lower(tipo);
select * from cantPoemasporTipo;
select * from cantPoemasporTipo order by cantPoemas asc;
/*6*/
create view edadProm as
select avg(edad) from escritores join poemas using (id_escritores) where tipo ="Lirico";
select * from edadProm;
select * from escritores where edad > (select * from edadProm);
/*7*/
create view descripcionPoemas as 
select descripcion from poemas join escritores using(id_escritores) where lower(apellido) like "%a" or lower(apellido) like "%e" or lower(apellido) like "%i" or lower(apellido) like "%o" or lower(apellido) like "%u";
select * from descripcionPoemas;
select * from descripcionPoemas where lower(descripcion) like "%a" or lower(descripcion) like "%o";
/*8*/
create view pabloNerudaJoin as
select titulo, descripcion, tipo from poemas join escritores using (id_escritores) where nombre = "Pablo" and apellido = "Neruda";
select * from pabloNerudaJoin;
create view pabloNerudaSub as
select titulo, descripcion,tipo from poemas where id_escritores in (select id_escritores from escritores where nombre = "Pablo" and apellido = "Neruda");
select * from pabloNerudaSub;
select count(id_poemas) from poemas where tipo in (select tipo from pabloNerudaJoin);
select concat(titulo,"-",descripcion) from pabloNerudaSub;
/*9*/
create view edadJoin as
select id_escritores,edad,count(id_poemas) from poemas join escritores using(id_escritores) where edad > 60 group by id_escritores;
select * from edadJoin;
create view edadSub as
select count(id_poemas) from poemas where id_escritores in (select id_escritores from escritores where edad > 60);
select * from edadSub;
select nombre, apellido, direccion from escritores where id_escritores in (select id_escritores from edadJoin);
/*10*/
create view edadProm as
select avg(edad) from escritores join poemas using(id_escritores) where titulo like "% %";
select *from edadProm;
select direccion from escritores where edad = (select * from edadProm);