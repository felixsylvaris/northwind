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

USE northwind;

select * from "Order Details" od 
SELECT 'OrderDetails', COUNT(*) FROM OrderDetails
SELECT COUNT(*) FROM "Order Details";
SELECT COUNT(*) FROM Orders;

SELECT COUNT(*) 
FROM "Order Details" od
LEFT JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderID IS NULL;
select * from "Order Details" od 
limit 10

SELECT
  SUM(CASE WHEN OrderID IS NULL THEN 1 ELSE 0 END) AS null_orderid,
  SUM(CASE WHEN ProductID IS NULL THEN 1 ELSE 0 END) AS null_productid,
  SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS null_unitprice,
  SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
  SUM(CASE WHEN Discount IS NULL THEN 1 ELSE 0 END) AS null_discount
FROM "Order Details";