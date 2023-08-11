/*1*/
create view detalleOrden as
select productCode,productName,productDescription,quantityOrdered,priceEach,(quantityOrdered*priceEach) as monto
from products join orderdetails using (productCode);
select * from detalleOrden;
/*2*/
create view totalPorOrden as 
select (priceEach * quantityOrdered) from orderdetails;
select * from totalPorOrden;
/*3*/
create view promMas as
select productName from products where buyPrice > (select avg(buyPrice) from products);
/*4*/
create view promMenos as
select productName from products where buyPrice < (select avg(buyPrice) from products);
/*5*/
create view oficinas as
select officeCode,city,employeeNumber,lastName,firstName from offices join employees using (officeCode) order by officeCode,employeeNumber;
select * from oficinas;
/*6*/
create view clientesSinPagos as
select customerNumber,customerName from customers where customerNumber not in (select customerNumber from payments);
select * from clientesSinPagos;
/*7*/
create view ordenesClientes as
select customerNumber,customerName,orderNumber from customers join orders using (customerNumber);
select * from ordenesClientes;
/*8*/
create view clienteOrden as
select customerNumber,customerName,phone,orderDate,p.productCode,quantityOrdered,priceEach,productName 
from customers left join orders using (customerNumber) 
left join orderdetails as o using (orderNumber) 
join products as p on p.productCode = o.productCode;
select * from clienteOrden;
/*9*/
create view cantProductos as
select productLine,quantityInStock from products join productlines using (productLine);
select * from cantProductos;
/*10*/
create view todo as
select officeCode,o.city,employeeNumber,lastName,firstName,customerNumber,customerName from offices as o
left join employees as e using (officeCode)
left join customers as c on e.employeeNumber = c.salesRepEmployeeNumber
order by officeCode,employeeNumber;
select * from todo;