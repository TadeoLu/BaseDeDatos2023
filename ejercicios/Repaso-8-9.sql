create database repaso;
use repaso;

delimiter //
drop function if exists cantRepeticiones//
create function cantRepeticiones(palabra varchar(45), letra varchar(1))
RETURNS INT
DETERMINISTIC
begin
	declare resultado INT default 0;
    declare pos INT default 1;
    recorrer : loop
    	if pos > length(palabra) then
			leave recorrer;
        end if;
		if substring(palabra, pos, 1) = letra then
			set resultado = resultado + 1;
		end if;
        set pos = pos + 1;
	end loop;
    return resultado;
end//

drop function if exists borrarLetra//
create function borrarLetra(palabra varchar(45), indice INT)
RETURNS varchar(45)
DETERMINISTIC
begin
	declare resultado VARCHAR(45) default "";
    declare pos INT default 1;
    recorrer : loop
    	if pos > length(palabra) then
			leave recorrer;
        end if;
		if indice != pos then
			set resultado = concat(resultado , substring(palabra, pos, 1));
		end if;
        set pos = pos + 1;
	end loop;
    return resultado;
end//

drop function if exists tieneVocales//
create function tieneVocales(palabra varchar(45))
RETURNS varchar(45)
DETERMINISTIC
begin
	declare resultado VARCHAR(45) default "No tiene vocales";
    declare pos INT default 1;
    recorrer : loop
    	if pos > length(palabra) then
			leave recorrer;
        end if;
		if upper(substring(palabra, pos, 1))= "A" 
        or upper(substring(palabra, pos, 1))= "E" 
        or upper(substring(palabra, pos, 1))= "I" 
        or upper(substring(palabra, pos, 1))= "O" 
        or upper(substring(palabra, pos, 1))= "U" then
			set resultado = "Tiene vocales";
		end if;
        set pos = pos + 1;
	end loop;
    return resultado;
end//

delimiter ;

select cantRepeticiones("hola","a");
select borrarLetra("hola",3);
select tieneVocales("plklklklklklklk");