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

-- Question 1: Which customers generate the most revenue? SELECT c.companyname, ROUND( SUM(od.unitprice * od.quantity * (1 - od.discount))::numeric, 2 ) AS revenue FROM customers c JOIN orders o ON c.customerid = o.customerid JOIN "Order Details" od ON o.orderid = od.orderid GROUP BY c.companyname ORDER BY revenue DESC LIMIT 10; IT 9745371.29 B's Beverages 6154115.34 Hungry Coyote Import Store 5698023.67 Rancho grande 5559110.08 Gourmet Lanchonetes 5552309.80 Ana Trujillo Emparedados y helados 5534356.65 Ricardo Adocicados 5524517.31 Folies gourmandes 5505502.85 Let's Stop N Shop 5462198.02 LILA-Supermercado 5437438.34
