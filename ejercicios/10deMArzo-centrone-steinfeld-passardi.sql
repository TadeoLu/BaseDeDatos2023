create database autistasFC;
create table pilotos(	
dni_corredor int not null,
auto varchar(45) not null,
nombre varchar (45),
apellido varchar (45) unique,
primary key(dni_co)
);
create table Tecnicos(

dni_tecnico int not null,
dni_corredor int not null,
primary key(dni_tecnico),
index indice_dni (dni_corredor),
foreign key (dni_corredor) references pilotos(dni_corredor)
ON DELETE CASCADE
ON UPDATE CASCADE
);

