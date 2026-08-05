-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 12_dashboard_queries.sql
-- Description: Power BI Dashboard Queries
-- Author: Shobha Saxena
-- Version: 2.0
-- ============================================

SET search_path TO public;

-- ============================================
-- Dashboard Query 1
-- KPI Summary
-- ============================================

SELECT
    ROUND(SUM(sales), 2) AS total_sales,

    COUNT(DISTINCT order_id) AS total_orders,

    COUNT(DISTINCT customer_id) AS total_customers,

    ROUND(
    SUM(sales) /
    NULLIF(COUNT(DISTINCT order_id), 0),
    2
    ) AS average_order_value
FROM orders;

-- ============================================
-- Dashboard Query 2
-- Monthly Sales Trend
-- ============================================

SELECT

DATE_TRUNC('month', order_date) AS month,

ROUND(SUM(sales),2) AS total_sales

FROM orders

GROUP BY DATE_TRUNC('month', order_date)

ORDER BY month;

-- ============================================
-- Dashboard Query 3
-- Sales by Region
-- ============================================

SELECT

region,

ROUND(SUM(sales),2) AS total_sales

FROM orders

GROUP BY region

ORDER BY total_sales DESC;

-- ============================================
-- Dashboard Query 4
-- Sales by Category
-- ============================================

SELECT

p.category,

ROUND(SUM(o.sales),2) AS total_sales

FROM orders o

JOIN products p
ON o.product_id = p.product_id

GROUP BY p.category

ORDER BY total_sales DESC;

-- ============================================
-- Dashboard Query 5
-- Top 10 Customers
-- ============================================

SELECT

c.customer_name,

ROUND(SUM(o.sales),2) AS total_sales

FROM orders o

JOIN customers c
ON o.customer_id = c.customer_id

GROUP BY c.customer_name

ORDER BY total_sales DESC

LIMIT 10;

-- ============================================
-- Dashboard Query 6
-- Top 10 Products
-- ============================================

SELECT

p.product_name,

ROUND(SUM(o.sales),2) AS total_sales

FROM orders o

JOIN products p
ON o.product_id = p.product_id

GROUP BY p.product_name

ORDER BY total_sales DESC

LIMIT 10;

-- ============================================
-- Dashboard Query 7
-- Sales by Customer Segment
-- ============================================

SELECT

c.segment,

ROUND(SUM(o.sales),2) AS total_sales

FROM orders o

JOIN customers c
ON o.customer_id = c.customer_id

GROUP BY c.segment

ORDER BY total_sales DESC; 

-- ============================================
-- Dashboard Query 8
-- Sales by Ship Mode
-- ============================================

SELECT

ship_mode,

ROUND(SUM(sales),2) AS total_sales

FROM orders

GROUP BY ship_mode

ORDER BY total_sales DESC;

-- ============================================
-- Dashboard Query 9
-- Sales by State
-- ============================================

SELECT

state,

ROUND(SUM(sales),2) AS total_sales

FROM orders

GROUP BY state

ORDER BY total_sales DESC;

-- ============================================
-- Dashboard Query 10
-- Monthly Growth
-- ============================================

WITH monthly_sales AS
(
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        ROUND(SUM(sales), 2) AS total_sales
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    month,
    total_sales,

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