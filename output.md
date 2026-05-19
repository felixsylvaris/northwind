/* Counting rows in tables. */
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

-- Output 
Customers	93
Orders	16282
OrderDetails	609283
Products	77
Employees	9
Categories	8
Suppliers	29
Shippers	3
