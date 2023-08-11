delimiter //
drop procedure if exists getCiudadesOffices;
create procedure getCiudadesOffices(out lista varchar(4000))
begin
	DECLARE done INT DEFAULT FALSE;
	declare ciudad varchar(100);
	declare cur CURSOR for select city from offices; 
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    open cur;
    
    recorrer:loop
		fetch cur into ciudad;
        set lista = concat(lista, ciudad, ", ");
        if done = true then
			leave recorrer;
		end if;
	end loop;
    
    close cur;
end//

delimiter ;

call getCiudadesOffices(@lista);
select @lista;

#2

create table cancelledOrders(
	cancelledOrderNumber INT,
    orderDate datetime,
    requireDate datetime,
    comments TEXT,
    customerNumber INT,
    primary key(cancelledOrderNumber),
    index customerNumber_index (customerNumber),
    foreign key (customerNumber)
    references customers(customerNumber)
);

delimiter //

create procedure insertCancelledOrders(OUT cantCancelledOrders INT)
begin
    declare done INT default false;
    declare numero int;
    declare dateOrder datetime;
    declare requerida datetime;
    declare comentarios text;
    declare cusNum int;
    declare cur cursor for select orderNumber,orderDate,requiredDate,comments,customerNumber from orders where lower(status) = "cancelled";
    declare continue handler for not found set done = true;
    select count(*) into cantCancelledOrders from orders where lower(status) = "cancelled";
    open cur;
    inserts: LOOP
		fetch cur into numero, dateOrder, requerida, comentarios, cusNum;
        insert into cancelledOrders values ( numero, dateOrder, requerida, comentarios, cusNum);
        if done = true then
			leave inserts;
		end if;
	end LOOP;
    close cur;
end//

delimiter ;

#3

delimiter //

create procedure alterCommentOrder(IN numero INT)
begin
	declare comentario varchar(100);
    declare numeroOrden int;
    declare total decimal(100,2);
    select comments into comentario from orders where customerNumber = numero;
    if commentes = "" then
		select orderNumber into numeroOrden from orders where customerNumber = numero;
        select sum(priceEach * quantityOrdered) into total from orderdetails where orderNumber = numeroOrden;
        update orders set comments = concat("El total de la orden es: ", total) where orderNumber = numeroOrden;
        end if;
end//

delimiter ;