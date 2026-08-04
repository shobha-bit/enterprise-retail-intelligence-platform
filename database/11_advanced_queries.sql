-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 11_advanced_queries.sql
-- Description: Advanced SQL Analytics
-- Author: Shobha Saxena
-- Version: 2.0
-- ============================================

SET search_path TO public;

-- ============================================
-- Advanced Query 1
-- Rank Orders by Sales
-- ============================================

SELECT
    order_id,
    customer_id,
    sales,
    RANK() OVER (ORDER BY sales DESC) AS sales_rank
FROM orders;

-- ============================================
-- Advanced Query 2
-- Dense Rank Orders
-- ============================================

SELECT
    order_id,
    sales,
    DENSE_RANK() OVER (ORDER BY sales DESC) AS sales_rank
FROM orders;

-- ============================================
-- Advanced Query 3
-- Row Number by Customer
-- ============================================

SELECT
    customer_id,
    order_id,
    sales,
    ROW_NUMBER() OVER
    (
        PARTITION BY customer_id
        ORDER BY sales DESC
    ) AS order_number
FROM orders;

-- ============================================
-- Advanced Query 4
-- Running Sales Total
-- ============================================

SELECT
    order_date,
    sales,
    SUM(sales)
    OVER
    (
    ORDER BY order_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )
AS running_total
FROM orders;

-- ============================================
-- Advanced Query 5
-- Monthly Running Sales
-- ============================================

SELECT

DATE_TRUNC('month',order_date) AS month,

SUM(sales) AS monthly_sales,

ROUND(
SUM(SUM(sales))
OVER
(
ORDER BY DATE_TRUNC('month', order_date)
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
),
2
) AS cumulative_sales

FROM orders

GROUP BY DATE_TRUNC('month',order_date)

ORDER BY month;

-- ============================================
-- Advanced Query 6
-- Top Customer in Each Region
-- ============================================

WITH customer_sales AS
(
    SELECT
        o.region,
        c.customer_name,
        ROUND(SUM(o.sales), 2) AS total_sales
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY
        o.region,
        c.customer_name
)

SELECT
    region,
    customer_name,
    total_sales
FROM
(
    SELECT
        region,
        customer_name,
        total_sales,
        ROW_NUMBER() OVER
        (
            PARTITION BY region
            ORDER BY total_sales DESC
        ) AS rn
    FROM customer_sales
) ranked_customers
WHERE rn = 1
ORDER BY total_sales DESC;

-- ============================================
-- Advanced Query 7
-- Category Sales Percentage
-- ============================================

SELECT

p.category,

ROUND(SUM(o.sales),2) AS total_sales,

ROUND
(
100 * SUM(o.sales)
/ SUM(SUM(o.sales)) OVER(),
2
)
AS percentage_sales

FROM orders o

JOIN products p

ON o.product_id=p.product_id

GROUP BY p.category

ORDER BY total_sales DESC;

-- ============================================
-- Advanced Query 8
-- Highest Sale by State
-- ============================================

SELECT

state,

MAX(sales) AS highest_sale

FROM orders

GROUP BY state

ORDER BY highest_sale DESC;

-- ============================================
-- Advanced Query 9
-- Top 3 Products by Sales
-- ============================================

SELECT
    product_name,
    total_sales,
    sales_rank
FROM
(
    SELECT
        p.product_name,
        ROUND(SUM(o.sales), 2) AS total_sales,
        RANK() OVER
        (
            ORDER BY SUM(o.sales) DESC
        ) AS sales_rank
    FROM orders o
    JOIN products p
        ON o.product_id = p.product_id
    GROUP BY
        p.product_name
) ranked_products
WHERE sales_rank <= 3
ORDER BY sales_rank, total_sales DESC;

-- ============================================
-- Advanced Query 10
-- Compare Product Sales with Overall Average
-- ============================================

SELECT
    product_id,
    ROUND(AVG(sales), 2) AS avg_sales,
    ROUND(
        (
            SELECT AVG(sales)
            FROM orders
        ),
        2
    ) AS overall_average
FROM orders
GROUP BY product_id;

-- ============================================
-- Advanced Query 11
-- Customers Spending Above Average
-- ============================================

WITH customer_sales AS
(
SELECT

customer_id,

SUM(sales)  AS total_sales

FROM orders

GROUP BY customer_id
)

SELECT
    customer_id,
    total_sales
FROM customer_sales
WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM customer_sales
)
ORDER BY total_sales DESC;

-- ============================================
-- Advanced Query 12
-- Monthly Sales Growth
-- ============================================

WITH monthly_sales AS
(
SELECT

DATE_TRUNC('month',order_date) AS month,

SUM(sales) AS total_sales

FROM orders

GROUP BY month
)

SELECT

month,

total_sales,

LAG(total_sales)
OVER
(
ORDER BY month
)
AS previous_month,

ROUND
(
(
    total_sales -
    LAG(total_sales) OVER (ORDER BY month)
)
/
NULLIF
(
    LAG(total_sales) OVER (ORDER BY month),
    0
)
* 100,
2
) AS growth_percentage
FROM monthly_sales;