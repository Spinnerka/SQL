/* This program is to show supplier monthly data of purchase orders */

set linesize 300
set pagesize 2000

set heading off
set feedback off
set echo off
set verify off

column supplierid heading 'Supplier|Number'
column suppliername heading 'Supplier|Name'
column ordermonth heading 'Order|Month' format date
column numberorders heading 'No of|Orders' format 999
column totalunits heading 'Total|Units' format 9,999
column totalAmount heading 'Total|Amount' format $99,999.99

prompt
prompt ******* SUPPLIER MONTHLY REPORT *******
prompt

set heading on

select purchaseorders.supplierID, suppliername, to_char(dateopen, 'mm/yyyy') ordermonth, 
	count(ponumber) numberorders, sum(orderqty) totalunits, sum(orderamount) totalamount
	from purchaseorders, suppliers
	where purchaseOrders.SupplierID=suppliers.SupplierID
	group by purchaseorders.supplierID, suppliername, to_char(dateopen, 'mm/yyyy')
	order by purchaseOrders.supplierid, to_char(dateopen, 'mm/yyyy');
	
clear column