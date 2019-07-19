/* This program is to query a purchase order */

spool e:querypo.txt

set heading off
set feedback off
set echo off
set verify off

column OrderQty format 999
column UnitPrice format $999.99
column OrderAmount format $99,999.99
column ReceiveAmount format $99,999.99

prompt
prompt ******* Q U E R Y  O R D E R *******
prompt

select 'Today''s Date: ', sysdate from dual;
prompt

accept vponum prompt 'Please enter the Purchase Order Number: ';

select 'Purchase Order Number: ', ltrim(ponumber) 
	from purchaseorders
	where ponumber='&vponum';

select 'Item Number: ', ltrim(productid) 
	from purchaseorders
	where ponumber='&vponum';

select 'Item Description: ', ltrim(productname) 
	from products, purchaseorders
	where ponumber='&vponum'
	and products.productID=purchaseorders.productID;

select 'Current Inventory Level: ', ltrim(ProductQty) 
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

select 'Quantity Ordered: ', ltrim(orderQty) 
	from purchaseorders
	where ponumber='&vponum';

select 'Date Received: ', ltrim(dateclosed) 
	from purchaseorders
	where ponumber='&vponum';

select 'Quantity Received: ', ltrim(receiveQty) 
	from purchaseorders
	where ponumber='&vponum';

select 'Unit Price: ', ltrim(to_char(UnitPrice, '$99,999.99'))
	from purchaseorders
	where ponumber='&vponum';

select 'Amount Ordered: ', ltrim(to_char(orderamount, '$99,999.99')) 
	from purchaseorders
	where ponumber='&vponum';

select 'Amount Due: ', ltrim(to_char(receiveAmount, '$99,999.99')) 
	from purchaseorders
	where ponumber='&vponum';

prompt

select 'Order Status: ', initcap(poStatus) 
	from purchaseorders
	where ponumber='&vponum';

clear columns

spool off
