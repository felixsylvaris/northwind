SELECT 'Customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'Orders', COUNT(*) FROM orders
UNION ALL
SELECT 'OrderDetails', COUNT(*) FROM "Order Details"
UNION ALL
SELECT 'Products', COUNT(*) FROM products
UNION ALL
SELECT 'Employees', COUNT(*) FROM employees
UNION ALL
SELECT 'Categories', COUNT(*) FROM categories
UNION ALL
SELECT 'Suppliers', COUNT(*) FROM suppliers
UNION ALL
SELECT 'Shippers', COUNT(*) FROM shippers;

-- Check for nulls.
SELECT
  SUM(CASE WHEN OrderID IS NULL THEN 1 ELSE 0 END) AS null_orderid,
  SUM(CASE WHEN ProductID IS NULL THEN 1 ELSE 0 END) AS null_productid,
  SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS null_unitprice,
  SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
  SUM(CASE WHEN Discount IS NULL THEN 1 ELSE 0 END) AS null_discount
FROM "Order Details";

--Order Details
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'Order Details'
ORDER BY ordinal_position;

/*
 * orderid	integer	NO
productid	integer	NO
unitprice	numeric	NO
quantity	integer	NO
discount	real	NO
 */
-- categories
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'categories'
ORDER BY ordinal_position;

/*
categoryid	integer	YES
categoryname	text	YES
description	text	YES
picture	bytea	yes
*/

select *
from customercustomerdemo;
/* empty 
customerid
customertypeid
*/

select *
from customerdemographics
/* empty
 * customertypeid
customerdesc
 */
 
-- customers 
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'customers'
ORDER BY ordinal_position;
/*
 * customerid	text	YES
companyname	text	YES
contactname	text	YES
contacttitle	text	YES
address	text	YES
city	text	YES
region	text	YES
postalcode	text	YES
country	text	YES
phone	text	YES
fax	text	YES
 */
-- employees
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'employees'
ORDER BY ordinal_position;
/*
 * employeeid	integer	YES
lastname	text	YES
firstname	text	YES
title	text	YES
titleofcourtesy	text	YES
birthdate	text	YES
hiredate	text	YES
address	text	YES
city	text	YES
region	text	YES
postalcode	text	YES
country	text	YES
homephone	text	YES
Extension	text	YES
photo	bytea	YES
notes	text	YES
reportsto	integer	YES
photopath	text	YES
 */
select *
from employees e ;
/*
 * 1	Davolio	Nancy	Sales Representative
2	Fuller	Andrew	Vice President, Sales
3	Leverling	Janet	Sales Representative
4	Peacock	Margaret	Sales Representative
5	Buchanan	Steven	Sales Manager
6	Suyama	Michael	Sales Representative
7	King	Robert	Sales Representative
8	Callahan	Laura	Inside Sales Coordinator
9	Dodsworth	Anne	Sales Representative
 */
-- employeeterritories
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'employeeterritories'
ORDER BY ordinal_position;
/*
 * employeeid	integer	NO
territoryid	text	NO
 */
-- orders
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'orders'
ORDER BY ordinal_position;
/*
 * orderid	integer	NO
customerid	text	YES
employeeid	integer	YES
orderdate	text	YES
requireddate	text	YES
shippeddate	text	YES
shipvia	integer	YES
freight	numeric	YES
shipname	text	YES
shipaddress	text	YES
shipcity	text	YES
shipregion	text	YES
shippostalcode	text	YES
shipcountry	text	YES
 */
-- products
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'products'
ORDER BY ordinal_position;
/*
 * productid	integer	NO
productname	text	NO
supplierid	integer	YES
categoryid	integer	YES
quantityperunit	text	YES
unitprice	numeric	YES
unitsinstock	integer	YES
unitsonorder	integer	YES
reorderlevel	integer	YES
discontinued	text	NO
 */

--regions
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'regions'
ORDER BY ordinal_position;
/*
 * regionid	integer	NO
regiondescription	text	NO
 */
-- shippers 
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'shippers'
ORDER BY ordinal_position;
/*
 * shipperid	integer	NO
companyname	text	NO
phone	text	YES
 */

-- suppliers
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'suppliers';
/*
 * supplierid	integer	NO
companyname	text	NO
contactname	text	YES
contacttitle	text	YES
address	text	YES
city	text	YES
region	text	YES
postalcode	text	YES
country	text	YES
phone	text	YES
fax	text	YES
homepage	text	YES
 */
-- territories
SELECT
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns
WHERE table_name = 'territories'
/*
 * regionid	integer	NO
territoryid	text	NO
territorydescription	text	NO
 */
-- creating new timestamp
ALTER TABLE orders
ADD COLUMN orderdate_ts timestamp;
UPDATE orders
SET orderdate_ts = orderdate::timestamp;

select orderdate_ts
from orders
limit 20;

-- hunting times
SELECT 
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE  column_name ILIKE '%date%'
and table_schema = 'northwind'
ORDER BY table_name;

-- more text-> date orders

ALTER TABLE orders ADD COLUMN requireddate_ts timestamp;
ALTER TABLE orders ADD COLUMN shippeddate_ts timestamp;
ALTER TABLE employees ADD COLUMN birthdate_ts timestamp;
ALTER TABLE employees ADD COLUMN hiredate_ts timestamp;


UPDATE orders
SET requireddate_ts = requireddate::timestamp;

UPDATE orders
SET shippeddate_ts = shippeddate::timestamp;
UPDATE employees
SET birthdate_ts = birthdate::timestamp;
UPDATE employees
SET hiredate_ts = hiredate::timestamp;


