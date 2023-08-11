use 5Marzo;
/*
#1
delimiter //
drop procedure uno;
create procedure uno(OUT cantOdontologos INT)
begin
	declare curOdontologos CURSOR FOR select count(dni) from turnos where lower(especialidad) = "odontologia";
    open curOdontologos;
	FETCH curOdontologos INTO cantOdontologos;
    close curOdontologos;
end//

delimiter ;

CALL uno(@cantOdontologos); 
SELECT @cantOdontologos;

#2

delimiter //

drop procedure dos;
create procedure dos()
begin
	declare fecha date;
    declare nombre varchar(100);
	declare cur1 CURSOR FOR select fecha,nombre from personas join turnos on (turnos.dni) where turnos.dni = 48999120;
    open cur1;
	fetch cur1 into fecha,nombre;
    select fecha,nombre;
    close cur1;
end//

delimiter ;

call dos();
*/
#3

delimiter //

create procedure tres()
begin
	declare done INT DEFAULT FALSE;
	declare nombre varchar(50);
    declare dni INT;
    declare especialidad Varchar(100);
	declare cur CURSOR FOR select nombre,turnos.dni,especialidad from turnos left join personas on (turnos.dni) where month(fecha) = 11;
    declare continue handler FOR NOT FOUND SET done = false;
    open cur;
    getPersonas: loop
		fetch cur into nombre,dni,especialidad;
        select nombre,dni,especialidad;
        if done then
			leave getPersonas;
        end if;
        select nombre,dni,especialidad;
	end loop;
    close cur;
end//

delimiter ; 

call tres();
/*
#4

delimiter //

create procedure cuatro()
begin
	declare cur 
end//

delimiter ;
*/