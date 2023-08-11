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
    cantReproducciones varchar(100)
);

insert into sonidos(nombre,src,duracion,tipo,autores,cantReproducciones) values ("trueno","Sonidos/trueno.mp3","20seg","Sonido","ni idea",0); 

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