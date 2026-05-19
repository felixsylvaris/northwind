SELECT 
    c.companyname,
    ROUND(SUM(od.unitprice * od.quantity * (1 - od.discount))::numeric, 2) AS TotalSpent
FROM customers c
JOIN orders o ON c.customerid = o.customerid
JOIN "Order Details" od ON o.orderid = od.orderid
GROUP BY c.companyname
ORDER BY TotalSpent DESC
LIMIT 10;

SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM "Order Details";

SELECT 
    e.firstname || ' ' || e.lastname AS employee,
    ROUND(SUM(od.unitprice * od.quantity * (1 - od.discount))::numeric, 2) AS salestotal
FROM employees e
JOIN orders o ON e.employeeid = o.employeeid
JOIN "Order Details" od ON o.orderid = od.orderid
GROUP BY e.firstname, e.lastname
ORDER BY salestotal DESC;

select *
from products p
limit 10

select min(orderdate), max(orderdate)
from orders 

SELECT 
    left(orderdate, 4) AS year,
    COUNT(*) AS orders
FROM orders
GROUP BY year
ORDER BY year;