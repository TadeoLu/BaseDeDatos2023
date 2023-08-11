create database administracion;
use administracion;

create table escuela(
	id_escuela int,
    nombre varchar(100) UNIQUE,
    direccion varchar(100) UNIQUE,
    barrio varchar(100),
    orientacion varchar(100),
    primary key (id_escuela)
);

create table alumno(
	nro_legajo int check (nro_legajo between 100 and 1000),
    id_escuela int,
    nombre varchar(100) not null,
    apellido varchar(100) not null,
    edad int check (edad < 18),
    primary key (nro_legajo),
    INDEX legajo_index(nro_legajo),
    foreign key (id_escuela)
    references escuela(id_escuela)
    on update restrict
    on delete cascade
);

#4.1 escuela
#4.2 alumno
#4.3 Cascade, Set null y Restrict afectan como cambian las tablas hijas cuando se modifica la tabla padre. Cascade hace que los datos de la tabla hija se modifiquen igual que en la tabla padre, Set null pone en null los valores que se modificaron en la tabla padre y Restrict no te permite modificar valores de la tabla padre

drop view cantAlumnosporOrientacion;
CREATE VIEW cantAlumnosporOrientacion as 
select count(nro_legajo) as cantLegajos,orientacion from alumno join escuela using(id_escuela) group by orientacion; 
select * from cantAlumnosporOrientacion;

select * from cantAlumnosporOrientacion group by orientacion having cantLegajos > 300;

drop view mayorEdadpromArte;
create view mayorEdadpromArte as
select nro_legajo from alumno where edad >= (select avg(edad) from alumno join escuela using(id_escuela) where lower(orientacion) = "arte");

select * from alumno where nro_legajo in (select * from mayorEdadpromArte); 
