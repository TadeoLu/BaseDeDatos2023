create database grilla;
use grilla;
set @grilla1 = "";

delimiter //
drop procedure if exists generarGrilla//
create procedure generarGrilla(IN tamaño INT, INOUT grilla1 varchar(3000))
begin
	declare contadorFila INT default 0;
    declare contadorColumna INT default 0;
	generarFila : loop
		set contadorColumna = 0;
		generarColumna : loop
			set grilla1 = concat(grilla1,"|_");
			set contadorColumna = contadorColumna + 1;
			if contadorColumna = tamaño then
				set grilla1 = concat(grilla1, "|\n");
				leave generarColumna;
			end if;
        end loop;
		set contadorFila = contadorFila + 1;
		if contadorFila = tamaño then
			leave generarFila;
		end if;
	end loop;
end//

drop procedure if Exists agregarPunto//
create procedure agregarPunto(IN fila INT, IN columna INT, INOUT grilla1 varchar(3000))
begin
	declare contadorFila INT default 0;
    declare contadorColumna INT default 0;
	declare tamaño INT;
    declare pos INT;
    set tamaño = (position("\n" in grilla1)-2)/2;
    set pos = (position("\n" in grilla1)) * (fila -1) + (columna * 2);
    /*set grilla1 = insert(grilla1, pos, pos+1, ".");*/
    set grilla1 = "";
    generarFila : loop
		set contadorColumna = 0;
		generarColumna : loop
			if char_length(grilla1) != pos -2 then
				set grilla1 = concat(grilla1,"|_");
            else
				set grilla1 = concat(grilla1,"|. ");
			end if;
            set contadorColumna = contadorColumna + 1;
			if contadorColumna = tamaño then
				set grilla1 = concat(grilla1, "|\n");
				leave generarColumna;
			end if;
        end loop;
		set contadorFila = contadorFila + 1;
		if contadorFila = tamaño then
			leave generarFila;
		end if;
	end loop;
end//

drop procedure if Exists moveRight//
create procedure moveRight(INOUT grilla1 varchar(3000))
begin
	declare contadorFila INT default 0;
    declare contadorColumna INT default 0;
	declare tamaño INT;
    declare pos INT;
    set tamaño = (position("\n" in grilla1)-2)/2;
    set pos = locate(".", grilla1);
    /*set grilla1 = insert(grilla1, pos, pos+1, ".");*/
    set grilla1 = "";
    generarFila : loop
		set contadorColumna = 0;
		generarColumna : loop
			if char_length(grilla1) != pos then
				set grilla1 = concat(grilla1,"|_");
            else
				set grilla1 = concat(grilla1,"|. ");
			end if;
            set contadorColumna = contadorColumna + 1;
			if contadorColumna = tamaño then
				set grilla1 = concat(grilla1, "|\n");
				leave generarColumna;
			end if;
        end loop;
		set contadorFila = contadorFila + 1;
		if contadorFila = tamaño then
			leave generarFila;
		end if;
	end loop;
end//

drop procedure if Exists moveLeft//
create procedure moveLeft(INOUT grilla1 varchar(3000))
begin
	declare contadorFila INT default 0;
    declare contadorColumna INT default 0;
	declare tamaño INT;
    declare pos INT;
    set tamaño = (position("\n" in grilla1)-2)/2;
    set pos = locate(".", grilla1)-4;
    /*set grilla1 = insert(grilla1, pos, pos+1, ".");*/
    set grilla1 = "";
    generarFila : loop
		set contadorColumna = 0;
		generarColumna : loop
			if char_length(grilla1) != pos then
				set grilla1 = concat(grilla1,"|_");
            else
				set grilla1 = concat(grilla1,"|. ");
			end if;
            set contadorColumna = contadorColumna + 1;
			if contadorColumna = tamaño then
				set grilla1 = concat(grilla1, "|\n");
				leave generarColumna;
			end if;
        end loop;
		set contadorFila = contadorFila + 1;
		if contadorFila = tamaño then
			leave generarFila;
		end if;
	end loop;
end//

drop procedure if Exists moveUp//
create procedure moveUp(INOUT grilla1 varchar(3000))
begin
	declare contadorFila INT default 0;
    declare contadorColumna INT default 0;
	declare tamaño INT;
    declare pos INT;
    set tamaño = (position("\n" in grilla1)-2)/2;
    set pos = locate(".", grilla1)-tamaño*2-4;
    /*set grilla1 = insert(grilla1, pos, pos+1, ".");*/
    set grilla1 = "";
    generarFila : loop
		set contadorColumna = 0;
		generarColumna : loop
			if char_length(grilla1) != pos then
				set grilla1 = concat(grilla1,"|_");
            else
				set grilla1 = concat(grilla1,"|. ");
			end if;
            set contadorColumna = contadorColumna + 1;
			if contadorColumna = tamaño then
				set grilla1 = concat(grilla1, "|\n");
				leave generarColumna;
			end if;
        end loop;
		set contadorFila = contadorFila + 1;
		if contadorFila = tamaño then
			leave generarFila;
		end if;
	end loop;
end//

drop procedure if Exists moveDown//
create procedure moveDown(INOUT grilla1 varchar(3000))
begin
	declare contadorFila INT default 0;
    declare contadorColumna INT default 0;
	declare tamaño INT;
    declare pos INT;
    set tamaño = (position("\n" in grilla1)-2)/2;
    set pos = locate(".", grilla1)+tamaño*2;
    /*set grilla1 = insert(grilla1, pos, pos+1, ".");*/
    set grilla1 = "";
    generarFila : loop
		set contadorColumna = 0;
		generarColumna : loop
			if char_length(grilla1) != pos then
				set grilla1 = concat(grilla1,"|_");
            else
				set grilla1 = concat(grilla1,"|. ");
			end if;
            set contadorColumna = contadorColumna + 1;
			if contadorColumna = tamaño then
				set grilla1 = concat(grilla1, "|\n");
				leave generarColumna;
			end if;
        end loop;
		set contadorFila = contadorFila + 1;
		if contadorFila = tamaño then
			leave generarFila;
		end if;
	end loop;
end//

delimiter ;

call generarGrilla (10, @grilla1);
call agregarPunto(5,1,@grilla1);
select @grilla1;
call moveRight(@grilla1);
select @grilla1;
call moveLeft(@grilla1);
select @grilla1;
call moveUp(@grilla1);
select @grilla1;
call moveDown(@grilla1);
select @grilla1;