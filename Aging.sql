/* This program is to show aging of purchase orders */

set linesize 300
set pagesize 2000

set heading off
set feedback off
set echo off
set verify off

column ponumber heading 'PO|Numb' format 9999
column postatus heading 'PO|Stat'
column dateopen heading 'Date|Open' format date
column productid heading 'Prod|Num'
column Productname heading 'Product|Description'
column OrderQty heading 'Order|Qty' format 999
column UnitPrice heading 'Unit|Price' format $999.99
column OrderAmount heading 'Order|Amount' format $99,999.99
column supplierid heading 'Supplier|Num'
column suppliername heading 'Supplier|Name'
column daysopen heading 'Days|Open' format 999

prompt
prompt ******* PURCHASE ORDER AGING REPORT *******
prompt

select 'Today''s Date: ', sysdate from dual;
prompt

accept vdays prompt 'Please enter number of days to query: ';

set heading on

select ponumber, postatus, to_char(dateopen, 'mm/dd/yyyy') dateopen, purchaseorders.productID, productname, orderqty,
	purchaseorders.unitprice, orderamount, purchaseorders.supplierID, 
	suppliername, trunc(sysdate)-trunc(dateopen) daysopen
	from products, suppliers, purchaseorders
	where trunc(sysdate)-trunc(dateopen) > &vdays and postatus = 'Open'
	and products.productid=purchaseorders.productid
	and suppliers.supplierid=purchaseorders.supplierid;
	
clear column