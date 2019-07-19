/* This program is to receive a purchase order */

set heading off
set feedback off
set echo off
set verify off

column OrderQty format 999
column UnitPrice format $999.99
column OrderAmount format $99,999.99
column ReceiveAmount format $99,999.99

prompt
prompt ******* R E C E I V E  O R D E R *******
prompt

select 'Today''s Date: ', sysdate from dual;
prompt

accept vponum prompt 'Please enter the Purchase Order Number: ';

select 'Order Number: ', ltrim(ponumber) 
	from purchaseorders
	where ponumber='&vponum';

select 'Item Number: ', ltrim(productid) 
	from purchaseorders
	where ponumber='&vponum';

select 'Item Description: ', ltrim(productname) 
	from products, purchaseorders
	where ponumber='&vponum'
	and products.productID=purchaseorders.productID;

select 'Supplier Number: ', ltrim(supplierid) 
	from purchaseorders
	where ponumber='&vponum';

select 'Supplier Name: ', ltrim(suppliername) 
	from suppliers, purchaseorders
	where ponumber='&vponum'
	and suppliers.supplierID=purchaseorders.supplierID;

select 'Date Ordered: ', ltrim(dateopen) 
	from purchaseorders
	where ponumber='&vponum';

select 'Today''s Date: ', sysdate from dual;

select 'Quantity Ordered: ', ltrim(orderQty) 
	from purchaseorders
	where ponumber='&vponum';

select 'Unit Price: ', ltrim(to_char(UnitPrice, '$99,999.99'))
	from purchaseorders
	where ponumber='&vponum';

select 'Amount Ordered: ', ltrim(to_char(OrderAmount, '$99,999.99')) 
	from purchaseorders
	where ponumber='&vponum';

prompt
select 'Current Inventory Level: ', ltrim(ProductQty) 
	from products, purchaseorders
	where ponumber='&vponum'
	and products.productID=purchaseorders.productID;
prompt

accept vqtyrec prompt 'Enter quantity received: ';

update products
	set productQty = productQty + &vqtyrec
	where productID= 
	(select productID
	from purchaseorders
	where ponumber='&vponum');

update purchaseorders
	set receiveQty = &vqtyrec
	where ponumber='&vponum';

update purchaseorders
	set receiveamount = &vqtyrec*unitprice
	where ponumber='&vponum';

update purchaseorders
	set postatus = 'Closed'
	where ponumber='&vponum';

update purchaseorders
	set dateclosed = sysdate
	where ponumber='&vponum';
	
select 'Amount Due: ', ltrim(to_char(receiveamount, '$99,999.99'))
	from purchaseorders
	where ponumber='&vponum';

select 'Updated Inventory Level: ', ltrim(ProductQty) 
	from products, purchaseorders
	where ponumber='&vponum'
	and products.productID=purchaseorders.productID;

prompt
prompt *********************************************
prompt

prompt Order is now ---> Closed

select 'Date Closed: ', sysdate from dual;

commit;

clear columns
