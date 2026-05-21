# northwind
SQL project with Northwind DB

# Objectivies

---
# Dataset

### Local databse or sample
---
# Fields/Tables

---
## Limitacion

---

# Research questions

---
# Query list
Question 1: Top customers by revenue  
Question 2: Which product categories generate the most revenue?  
Question 3: How does revenue evolve over time?  
Question 4: Average shipping time? And sipping delays?

---
# Skill Used

---
# Results

### Question 1: Top customers by revenue 
This query aggregates total revenue per customer by joining customers, orders, and order details.  
Revenue is calculated as: unitprice × quantity × (1 − discount)  

Result   (Top 10 customers)
+ IT – 9,745,371.29
+  B's Beverages – 6,154,115.34
+  Hungry Coyote Import Store – 5,698,023.67
+  Rancho grande – 5,559,110.08
+  Gourmet Lanchonetes – 5,552,309.80
+  Ana Trujillo Emparedados y helados – 5,534,356.65
+  Ricardo Adocicados – 5,524,517.31
+  Folies gourmandes – 5,505,502.85
+   Let's Stop N Shop – 5,462,198.02
+   LILA-Supermercado – 5,437,438.34

  Interpretation Revenue is highly concentrated among a small number of customers, with the top customer significantly ahead of others. The distribution suggests that a few high-volume clients drive a large share of total sales, while the rest of the customer base is relatively evenly distributed within the top tier.

### Question 2: Which product categories generate the most revenue?

This query analyzes total revenue by product category using order transaction data from the Northwind database. Revenue was calculated using the formula:

`unitprice × quantity × (1 - discount)`

The analysis shows that revenue distribution across categories is uneven.  
`Beverages` generated the highest total revenue, followed by `Confections` and `Meat/Poultry`. Lower-performing categories included `Produce` and `Grains/Cereals`.

| Rank | Category | Revenue |
|---|---|---:|
| 1 | Beverages | 92,163,184.18 |
| 2 | Confections | 66,337,803.06 |
| 3 | Meat/Poultry | 64,881,147.97 |
| 4 | Dairy Products | 58,018,116.78 |
| 5 | Condiments | 55,795,126.78 |
| 6 | Seafood | 49,921,604.17 |
| 7 | Produce | 32,701,119.88 |
| 8 | Grains/Cereals | 28,568,530.34 |

This may suggest that a relatively small number of categories contribute disproportionately to total sales revenue. However, revenue alone does not reflect profitability, operational cost, or inventory efficiency, so additional business context would be required before making strategic conclusions.

### Question 3: How does revenue evolve over time?

This analysis examines monthly revenue trends across the dataset to evaluate whether sales remain stable or show long-term growth or decline patterns.

Revenue was aggregated on a monthly basis using transaction-level order data.

The results show that monthly revenue fluctuates over time but remains broadly within a consistent range throughout the observed period. There is no strong indication of sustained long-term growth or decline across the dataset.

However, repeated peaks and dips suggest the presence of cyclical or seasonal effects, particularly with stronger performance in certain months and weaker performance in others.

Because the dataset spans multiple years but does not include external context (such as marketing campaigns, pricing changes, or macroeconomic factors), these fluctuations should be interpreted as descriptive patterns rather than causal conclusions.
This query aggregates total revenue by year to evaluate long-term sales trends.

The results show relatively stable annual revenue across the observed period, with fluctuations between years but no clear sustained upward or downward trend.

This suggests that overall sales volume remains consistent over time, with variation likely driven by shorter-term seasonal or cyclical effects rather than structural growth or decline.
### 3.2 Sales by Month (Average Seasonal Pattern)

This analysis evaluates average monthly revenue across all years in the dataset to identify potential seasonal patterns.

Instead of examining individual months in isolation, this approach aggregates revenue by month-of-year and computes the average performance for each month across the full time period.

The results help smooth out short-term fluctuations and highlight whether certain months consistently perform better or worse than others.

This type of analysis is commonly used in business intelligence to detect seasonality in sales cycles.

Because the dataset is synthetic, any observed patterns should be interpreted as descriptive rather than predictive.

### 4.1 Shipping Time Distribution

This analysis evaluates the time required to process and ship orders by measuring the difference between order date and shipment date.

The average shipping time is approximately 8 days, indicating a relatively consistent fulfillment process across the dataset.

However, the distribution shows significant variation. While some orders are shipped almost immediately, others take over a month to be fulfilled.

This suggests that although the typical shipping process is stable, there are occasional extreme delays or outlier cases that significantly extend fulfillment time.

These outliers may reflect backlog situations, operational inefficiencies, or synthetic data variability within the dataset.

### 4.2 Shipment Delays (Required Delivery Date Analysis)

This analysis compares actual shipment dates against required delivery dates to evaluate fulfillment timeliness.

Out of 16,261 total orders, 3,755 were shipped after their required delivery date, representing approximately 23.09% of all orders.

This indicates that nearly one in four orders did not meet the expected delivery timeframe.

While this suggests a meaningful level of delay within the dataset, the analysis does not include contractual delivery definitions, customer priority levels, or logistics constraints. Therefore, results should be interpreted as indicative rather than definitive operational performance.

---
# Summary
