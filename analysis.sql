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

-- Question 2: Which product categories generate the most revenue?

SELECT
    c.categoryname AS category,
    ROUND(
        SUM(od.unitprice * od.quantity * (1 - od.discount))::numeric,
        2
    ) AS total_revenue
FROM categories c
JOIN products p
    ON c.categoryid = p.categoryid
JOIN "Order Details" od
    ON p.productid = od.productid
GROUP BY c.categoryname
ORDER BY total_revenue DESC;

/*
 * Beverages	92163184.18
Confections	66337803.06
Meat/Poultry	64881147.97
Dairy Products	58018116.78
Condiments	55795126.78
Seafood	49921604.17
Produce	32701119.88
Grains/Cereals	28568530.34
*/

SELECT
    RANK() OVER (
        ORDER BY SUM(
            od.unitprice * od.quantity * (1 - od.discount)
        ) DESC
    ) AS revenue_rank,
    
    c.categoryname AS category,

    ROUND(
        SUM(
            od.unitprice * od.quantity * (1 - od.discount)
        )::numeric,
        2
    ) AS total_revenue

FROM categories c
JOIN products p
    ON c.categoryid = p.categoryid
JOIN "Order Details" od
    ON p.productid = od.productid

GROUP BY c.categoryname
ORDER BY total_revenue DESC;
/*
 * 1	Beverages	92163184.18
2	Confections	66337803.06
3	Meat/Poultry	64881147.97
4	Dairy Products	58018116.78
5	Condiments	55795126.78
6	Seafood	49921604.17
7	Produce	32701119.88
8	Grains/Cereals	28568530.34
*/

-- Question 3: How does revenue change over time?

SELECT
    DATE_TRUNC('month', o.orderdate_ts) AS month,

    ROUND(
        SUM(
            od.unitprice * od.quantity * (1 - od.discount)
        )::numeric,
        2
    ) AS monthly_revenue

FROM orders o
JOIN "Order Details" od
    ON o.orderid = od.orderid

GROUP BY month
ORDER BY month;

-- 3.1 Sales by Year

SELECT
    DATE_TRUNC('year', o.orderdate_ts) AS year,

    ROUND(
        SUM(
            od.unitprice * od.quantity * (1 - od.discount)
        )::numeric,
        2
    ) AS total_revenue

FROM orders o
JOIN "Order Details" od
    ON o.orderid = od.orderid

GROUP BY year
ORDER BY year;

/*
 * 2012-01-01 00:00:00.000	18823201.72
2013-01-01 00:00:00.000	38633120.01
2014-01-01 00:00:00.000	38870148.13
2015-01-01 00:00:00.000	41423456.72
2016-01-01 00:00:00.000	40568672.36
2017-01-01 00:00:00.000	40209904.23
2018-01-01 00:00:00.000	38326623.43
2019-01-01 00:00:00.000	38516963.86
2020-01-01 00:00:00.000	38862436.79
2021-01-01 00:00:00.000	41355549.74
2022-01-01 00:00:00.000	39742066.18
2023-01-01 00:00:00.000	33054490.00
 */

-- 3.2 Average Revenue per Month (Across Years)

SELECT
    EXTRACT(MONTH FROM o.orderdate_ts) AS month_number,

    ROUND(
        AVG(
            SUM(od.unitprice * od.quantity * (1 - od.discount))
        ) OVER (
            PARTITION BY EXTRACT(MONTH FROM o.orderdate_ts)
        )::numeric,
        2
    ) AS avg_monthly_revenue

FROM orders o
JOIN "Order Details" od
    ON o.orderid = od.orderid

GROUP BY month_number
ORDER BY month_number;
/*
1	37176302.88
2	32071687.16
3	37439136.97
4	34485299.34
5	38958391.86
6	35235690.75
7	40045570.20
8	41515922.35
9	37975923.48
10	39038003.50
11	35050459.40
12	39394245.25
*/

-- 4.1 Average shipping time (order → shipped)

SELECT
    
        AVG(shippeddate_ts - orderdate_ts)
        
  AS avg_shipping_days,

    MIN(shippeddate_ts - orderdate_ts) AS fastest_shipping_days,
    MAX(shippeddate_ts - orderdate_ts) AS slowest_shipping_days
FROM orders
WHERE shippeddate_ts IS NOT NULL;

-- 4.2 Late shipments vs required delivery date

SELECT
    COUNT(*) AS total_orders,

    COUNT(*) FILTER (
        WHERE shippeddate_ts > requireddate_ts
    ) AS late_orders,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE shippeddate_ts > requireddate_ts
        ) / COUNT(*),
        2
    ) AS late_percentage

FROM orders
WHERE shippeddate_ts IS NOT NULL;

-- 4.3 Shipper performance comparison

SELECT
    s.companyname AS shipper,

    COUNT(o.orderid) AS total_orders,

    
        AVG(o.shippeddate_ts - o.orderdate_ts)
        
     AS avg_shipping_days,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE o.shippeddate_ts > o.requireddate_ts
        ) / COUNT(*),
        2
    ) AS late_percentage

FROM orders o
JOIN shippers s
    ON o.shipvia = s.shipperid

WHERE o.shippeddate_ts IS NOT NULL

GROUP BY s.companyname
ORDER BY avg_shipping_days DESC;
/*
 * Speedy Express	5331	7 days 22:04:34.42131	23.34
Federal Shipping	5455	7 days 19:47:38.340238	23.01
United Package	5475	7 days 18:50:15.754886	22.94
*/

-- Products never ordered

SELECT
    p.productid,
    p.productname
FROM products p
LEFT JOIN "Order Details" od
    ON p.productid = od.productid
WHERE od.productid IS NULL;
-- 0 


-- Low frequency products (rarely ordered)

SELECT
    p.productname,
    COUNT(od.orderid) AS times_ordered
FROM products p
LEFT JOIN "Order Details" od
    ON p.productid = od.productid
GROUP BY p.productname
ORDER BY times_ordered ASC
LIMIT 20;

-- Slow-moving inventory (by quantity sold)

SELECT
    p.productname,

    COALESCE(SUM(od.quantity), 0) AS total_units_sold

FROM products p
LEFT JOIN "Order Details" od
    ON p.productid = od.productid

GROUP BY p.productname
ORDER BY total_units_sold ASC
LIMIT 20;

-- Question 5: Which employees handle highest sales?
SELECT
    e.employeeid,
    e.firstname || ' ' || e.lastname AS employee,
    
    ROUND(
        SUM(od.unitprice * od.quantity * (1 - od.discount))::numeric,
        2
    ) AS total_sales,

    RANK() OVER (
        ORDER BY SUM(od.unitprice * od.quantity * (1 - od.discount)) DESC
    ) AS sales_rank

FROM employees e

JOIN orders o
    ON e.employeeid = o.employeeid

JOIN "Order Details" od
    ON o.orderid = od.orderid

GROUP BY
    e.employeeid,
    e.firstname,
    e.lastname

ORDER BY sales_rank;
/*
4	Margaret Peacock	51488395.20	1
5	Steven Buchanan	51386459.10	2
3	Janet Leverling	50445573.76	3
1	Nancy Davolio	49659423.23	4
7	Robert King	49651899.30	5
8	Laura Callahan	49281136.81	6
6	Michael Suyama	49139966.56	7
9	Anne Dodsworth	49019678.44	8
2	Andrew Fuller	48314100.76	9
*/
-- Question 6 Are workloads uneven? Orders per employee
SELECT
    e.employeeid,
    e.firstname || ' ' || e.lastname AS employee,

    COUNT(o.orderid) AS total_orders,

    RANK() OVER (
        ORDER BY COUNT(o.orderid) DESC
    ) AS workload_rank,

    ROUND(
        COUNT(o.orderid)::numeric
        / AVG(COUNT(o.orderid)) OVER (),
        2
    ) AS workload_vs_avg

FROM employees e

JOIN orders o
    ON e.employeeid = o.employeeid

GROUP BY
    e.employeeid,
    e.firstname,
    e.lastname

ORDER BY total_orders DESC;

-- Question 7 Which products are bought together
SELECT
    p1.productname AS product_a,
    p2.productname AS product_b,
    COUNT(*) AS times_bought_together

FROM "Order Details" od1

JOIN "Order Details" od2
    ON od1.orderid = od2.orderid
    AND od1.productid < od2.productid

JOIN products p1
    ON od1.productid = p1.productid

JOIN products p2
    ON od2.productid = p2.productid

GROUP BY
    p1.productname,
    p2.productname

ORDER BY times_bought_together DESC
LIMIT 20;
/*
Sir Rodney's Marmalade	Louisiana Hot Spiced Okra	5445
Gustaf's Knäckebröd	Louisiana Hot Spiced Okra	5442
Genen Shouyu	Louisiana Hot Spiced Okra	5430
Teatime Chocolate Biscuits	Louisiana Hot Spiced Okra	5417
Sir Rodney's Marmalade	Tunnbröd	5414
Tunnbröd	Inlagd Sill	5413
Ravioli Angelo	Louisiana Hot Spiced Okra	5410
Camembert Pierrot	Louisiana Hot Spiced Okra	5409
Teatime Chocolate Biscuits	Outback Lager	5409
Sir Rodney's Marmalade	Gorgonzola Telino	5407
Konbu	Outback Lager	5406
Tunnbröd	Louisiana Hot Spiced Okra	5406
Sir Rodney's Marmalade	Gumbär Gummibärchen	5405
Queso Manchego La Pastora	Louisiana Hot Spiced Okra	5404
Inlagd Sill	Louisiana Hot Spiced Okra	5403
Ikura	Louisiana Hot Spiced Okra	5401
Louisiana Hot Spiced Okra	Gudbrandsdalsost	5401
Aniseed Syrup	Louisiana Hot Spiced Okra	5400
Teatime Chocolate Biscuits	Ravioli Angelo	5400
Louisiana Hot Spiced Okra	Outback Lager	5396
*/

--  8.1: Who is our best customer?
SELECT
    c.customerid,
    c.companyname,

    ROUND(
        SUM(od.unitprice * od.quantity * (1 - od.discount))::numeric,
        2
    ) AS total_revenue,

    RANK() OVER (
        ORDER BY SUM(od.unitprice * od.quantity * (1 - od.discount)) DESC
    ) AS customer_rank

FROM customers c

JOIN orders o
    ON c.customerid = o.customerid

JOIN "Order Details" od
    ON o.orderid = od.orderid

GROUP BY
    c.customerid,
    c.companyname

ORDER BY customer_rank
LIMIT 10;
/*
BSBEV	B's Beverages	6154115.34	1
HUNGC	Hungry Coyote Import Store	5698023.67	2
RANCH	Rancho grande	5559110.08	3
GOURL	Gourmet Lanchonetes	5552309.80	4
ANATR	Ana Trujillo Emparedados y helados	5534356.65	5
RICAR	Ricardo Adocicados	5524517.31	6
FOLIG	Folies gourmandes	5505502.85	7
LETSS	Let's Stop N Shop	5462198.02	8
LILAS	LILA-Supermercado	5437438.34	9
PRINI	Princesa Isabel Vinhos	5436770.55	10
*/

-- 
SELECT
    c.customerid,
    c.companyname

FROM customers c

LEFT JOIN orders o
    ON c.customerid = o.customerid

WHERE o.orderid IS NULL

ORDER BY c.companyname;

SELECT
    c.customerid,
    c.companyname

FROM customers c

LEFT JOIN orders o
    ON c.customerid = o.customerid

WHERE o.orderid IS NULL

ORDER BY c.companyname;

SELECT
    c.customerid,
    c.companyname,
    MAX(o.orderdate_ts) AS last_order_date
FROM customers c
JOIN orders o
    ON c.customerid = o.customerid
GROUP BY c.customerid, c.companyname;

SELECT
    EXTRACT(YEAR FROM orderdate_ts) AS order_year,
    COUNT(*) AS total_orders
FROM orders
GROUP BY EXTRACT(YEAR FROM orderdate_ts)
ORDER BY order_year;

/*
2012	654
2013	1351
2014	1351
2015	1449
2016	1506
2017	1780
2018	1549
2019	1362
2020	1376
2021	1420
2022	1352
2023	1132
*/