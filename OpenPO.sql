/* This program is to open a new purchase order */

spool e:openpo.txt

set heading off
set feedback off
set echo off
set verify off

column OrderQty format 999
column UnitPrice format $999.99
column OrderAmount format $99,999.99
column ReceiveAmount format $99,999.99

prompt
prompt ******* O P E N  O R D E R *******
prompt

select 'Today''s Date: ', sysdate from dual;
prompt

set heading on
select * from products;
prompt
set heading off
accept vPid prompt 'Enter the Item Number: ';

select 'Item Description: ', ProductName 
	from products
	where upper(ProductID)=upper('&vPid');

select 'Current Inventory Level: ', ltrim(ProductQty) 
	from products
	where upper(ProductID)=upper('&vPid');
prompt
prompt Please select from one of the following Authorized Suppliers:

set heading on

select suppliers.SupplierID, SupplierName, City, State, UnitPrice
	from suppliers, productDetails
	where upper(ProductID)=upper('&vPid')
	and productDetails.SupplierID=suppliers.SupplierID;

set heading off
prompt

accept vSup prompt 'Enter the Supplier Number: ';

select 'Supplier Name: ', SupplierName 
	from suppliers
	where upper(SupplierID)=upper('&vSup');

select 'Address: ', Street 
	from suppliers
	where upper(SupplierID)=upper('&vSup');

select 'City, State Zip: ', City, State, Zip 
	from suppliers
	where upper(SupplierID)=upper('&vSup');

select 'Phone: '||'('||substr(PhoneNumber,1,3)||')'||substr(PhoneNumber,4,3)||'-'||substr(PhoneNumber,-4)
	from suppliers
	where upper(SupplierID)=upper('&vSup');

prompt
accept vQty prompt 'Enter Order Quantity: ';

select 'Unit Price: ', ltrim(to_char(UnitPrice, '$99,999.99'))
	from productDetails
	where upper(ProductID)=upper('&vPid') and upper(SupplierID)=upper('&vSup');

select 'Amount Ordered: ', ltrim(to_char(unitprice*&vQty, '$99,999.99')) 
	from productDetails
	where upper(ProductID)=upper('&vPid') and upper(SupplierID)=upper('&vSup');

insert into purchaseorders (PONumber, postatus, dateopen, productid, orderqty, UnitPrice, orderamount, SupplierID)
	select maxnum, 'Open', sysdate, upper('&vPid'), &vQty, UnitPrice, UnitPrice*&vQty, upper('&vSup')
	from counter, productDetails
	where upper(ProductID)=upper('&vPid') and upper(SupplierID)=upper('&vSup');

prompt
prompt ***** Order Status: Open
prompt
select '***** Purchase Order number is -----> ', maxnum from counter;

update counter set maxnum=maxnum+1;

commit;

clear columns

spool off



