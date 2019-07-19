/* This program is to show short ship of purchase orders */

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
column ReceiveQty heading 'Receive|Qty' format 999
column ShortQty heading 'Short|Qty' format 999
column supplierid heading 'Supplier|Num'
column suppliername heading 'Supplier|Name'

prompt
prompt ******* SHORT SHIP REPORT *******
prompt

select 'Today''s Date: ', sysdate from dual;
prompt

set heading on

select ponumber, postatus, to_char(dateopen, 'mm/dd/yyyy') dateopen, purchaseorders.productID, productname, orderqty,
	receiveqty, orderqty-receiveqty shortqty, purchaseorders.supplierID, suppliername
	from products, suppliers, purchaseorders
	where postatus = 'Closed' and orderqty-receiveqty > 0 
	and products.productid=purchaseorders.productid
	and suppliers.supplierid=purchaseorders.supplierid
	order by ponumber;
	
clear column