-- Question 1: Which customers generate the most revenue?
SELECT
    c.companyname,
    ROUND(
        SUM(od.unitprice * od.quantity * (1 - od.discount))::numeric,
        2
    ) AS revenue
FROM customers c
JOIN orders o
    ON c.customerid = o.customerid
JOIN "Order Details" od
    ON o.orderid = od.orderid
GROUP BY c.companyname
ORDER BY revenue DESC
LIMIT 10;

/*
IT	9745371.29
B's Beverages	6154115.34
Hungry Coyote Import Store	5698023.67
Rancho grande	5559110.08
Gourmet Lanchonetes	5552309.80
Ana Trujillo Emparedados y helados	5534356.65
Ricardo Adocicados	5524517.31
Folies gourmandes	5505502.85
Let's Stop N Shop	5462198.02
LILA-Supermercado	5437438.34
*/

