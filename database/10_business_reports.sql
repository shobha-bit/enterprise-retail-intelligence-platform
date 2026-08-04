-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 10_business_reports.sql
-- Description: Business Reports
-- Author: Shobha Saxena
-- Version: 2.0
-- ============================================

SET search_path TO public;

-- ============================================
-- Business Report 1
-- Top 10 Customers by Sales
-- ============================================

SELECT
    c.customer_name,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- ============================================
-- Business Report 2
-- Monthly Sales Trend
-- ============================================

SELECT
    DATE_TRUNC('month', order_date) AS sales_month,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY sales_month
ORDER BY sales_month;

-- ============================================
-- Business Report 3
-- Sales by Category
-- ============================================

SELECT
    p.category,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- ============================================
-- Business Report 4
-- Top 10 Products by Sales
-- ============================================

SELECT
    p.product_name,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 10;

-- ============================================
-- Business Report 5
-- Sales by Region
-- ============================================

SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

-- ============================================
-- Business Report 6
-- Sales by State
-- ============================================

SELECT
    state,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY state
ORDER BY total_sales DESC;

-- ============================================
-- Business Report 7
-- Sales by Customer Segment
-- ============================================

SELECT
    c.segment,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.segment
ORDER BY total_sales DESC;

-- ============================================
-- Business Report 8
-- Sales by Ship Mode
-- ============================================

SELECT
    ship_mode,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY ship_mode
ORDER BY total_sales DESC;

-- ============================================
-- Business Report 9
-- Average Sales by Category
-- ============================================

SELECT
    p.category,
    ROUND(AVG(o.sales),2) AS average_sales
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY average_sales DESC;

-- ============================================
-- Business Report 10
-- Top Cities by Sales
-- ============================================

SELECT
    city,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY city
ORDER BY total_sales DESC
LIMIT 10;