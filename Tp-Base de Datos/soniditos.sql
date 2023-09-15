drop database soniditos;
create database soniditos;
use soniditos;

create table sonidos(
	id INT auto_increment not null primary key,
    src Varchar(100),
    nombre VARCHAR(100),
    duracion VARCHAR(100),
    tipo varchar(100),
    autores varchar(100),
    cantReproducciones int
);

insert into sonidos(nombre,src,duracion,tipo,autores,cantReproducciones) values ("Trueno","Sonidos/trueno.mp3","20seg","Sonido","Desconocido",0),
("Alarma de Iphone","Sonidos/alarmaIphone.mp3","30seg","Alarma","Desconocido",0),
("Despertador de Gallo","Sonidos/gallo.mp3","19seg","Despertador","Desconocido",0),
("Grillos","Sonidos/grillos.mp3","15seg","Sonido","Desconocido",0),
("Cancion Mario","Sonidos/mario.mp3","29seg","Cancion","Kōji Kondō",0),
("Nextel","Sonidos/nextel.mp3","1seg","RingTone","Desconocido",0),
("Notificacion Iphone","Sonidos/notifIphone.mp3","1seg","Notificacion","Desconocido",0),
("Pato Donald","Sonidos/patoDonald.mp3","2seg","Audio","Desconocido",0),
("Silbido Whatsapp","Sonidos/wharap.mp3","1seg","Sonido","Desconocido",0); 

create view masElegido as
select id,nombre,cantReproducciones from sonidos order by cantReproducciones desc limit 1;
select * from masElegido;

create view menosElegido as
select id,nombre,cantReproducciones from sonidos order by cantReproducciones asc limit 1;
select * from menosElegido;

delimiter //

drop procedure if exists subirReproducciones//
create procedure subirReproducciones(IN idP INT)
begin
	declare cant INT;
    select cantReproducciones into cant from sonidos where id = idP;
	update sonidos set cantReproducciones = cant + 1 where id = idP; 
end//

delimiter ;

call subirReproducciones(1);
select * from sonidos;