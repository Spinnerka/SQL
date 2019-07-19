/* This program is for setup for final project */

set echo on

spool e:setup.txt

set linesize 120
set pagesize 2000

drop table purchaseOrders;
drop table productDetails;
drop table suppliers;
drop table products;
drop table counter;

create table products (
	ProductID varchar2(10) primary key,
	ProductName varchar2(15),
	ProductQty number(4));

insert into products values ('P1','Pencil',15);
insert into products values ('P2','Pen',18);
insert into products values ('P3','Paper',12);
insert into products values ('P4','Ink',11);
insert into products values ('P5','USB',10);

create table suppliers (
	SupplierID varchar2(10) primary key,
	SupplierName varchar2(15),
	Street varchar2(25),
	City varchar2(15),
	State varchar2(5),
	Zip varchar2(5),
	PhoneNumber varchar2(15));

insert into suppliers values ('S1','Office Depot','2300 Harbor Blvd','Costa Mesa','CA','92626','9496462162');
insert into suppliers values ('S2','Staples','4343 MacArthur Blvd','Newport Beach','CA','92660','9497529186');
insert into suppliers values ('S3','FedEx Office','1000 Bristol St N','Newport Beach','CA','92660','9492615290');
insert into suppliers values ('S4','Walmart','3600 W Mcfadden Ave','Santa Ana','CA','92704','7147751804');
insert into suppliers values ('S5','Target','3030 Harbor Blvd Ste A','Costa Mesa','CA','92626','7149790372');


create table productDetails (
	ProductID varchar2(10),
	SupplierID varchar2(10),
	UnitPrice number(6,2),
	primary key (ProductID, SupplierID),
	constraint fk_productdetails_ProductID foreign key (ProductID) references products(ProductID),
	constraint fk_productdetails_SupplierID foreign key (SupplierID) references suppliers(SupplierID));

insert into productDetails values ('P1','S1',2.00);
insert into productDetails values ('P1','S3',2.50);
insert into productDetails values ('P1','S5',2.25);
insert into productDetails values ('P2','S2',1.25);
insert into productDetails values ('P2','S4',1.50);
insert into productDetails values ('P2','S5',1.75);
insert into productDetails values ('P3','S1',4.75);
insert into productDetails values ('P3','S2',4.00);
insert into productDetails values ('P3','S3',4.25);
insert into productDetails values ('P4','S4',6.25);
insert into productDetails values ('P4','S5',6.75);
insert into productDetails values ('P4','S2',6.50);
insert into productDetails values ('P5','S4',9.50);
insert into productDetails values ('P5','S1',9.90);
insert into productDetails values ('P5','S3',9.22);

column UnitPrice format $999.99

create table purchaseOrders (
	PONumber number(6) primary key,
	POStatus varchar2(9),
	DateOpen date,
	dateClosed date,
	ProductID varchar2(10),
	OrderQty number(3),
	ReceiveQty number(3),
	UnitPrice number(6,2),
	OrderAmount number(12,2),
	ReceiveAmount number(12,2),
	SupplierID varchar2(10),
	constraint fk_purchaseorders_productID foreign key (productID) references products(productID),
	constraint fk_purchaseorders_supplierID foreign key (supplierID) references suppliers(supplierID));

create table counter (
	MaxNum number(6));

insert into counter values ('1000');

column OrderQty format 999
column UnitPrice format $999.99
column OrderAmount format $99,999.99
column ReceiveAmount format $99,999.99

select * from products;
select * from suppliers;
select * from productDetails;
select * from purchaseOrders;
select * from counter;

spool off