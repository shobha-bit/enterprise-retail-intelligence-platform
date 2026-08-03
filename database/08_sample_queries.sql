-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 08_sample_queries.sql
-- Description: SQL Practice & Business Queries
-- Author: Shobha Saxena
-- Version: 2.0
-- ============================================

SET search_path TO public;

-- ============================================
-- Query 1
-- Display all customers
-- ============================================

SELECT *
FROM customers;

-- ============================================
-- Query 2
-- Display all products
-- ============================================

SELECT *
FROM products;

-- ============================================
-- Query 3
-- Display all orders
-- ============================================

SELECT *
FROM orders;

-- ============================================
-- Query 4
-- Display all suppliers
-- ============================================

SELECT *
FROM suppliers;

-- ============================================
-- Query 5
-- Display inventory
-- ============================================

SELECT *
FROM inventory;

-- ============================================
-- Query 6
-- Orders from West Region
-- ============================================

SELECT *
FROM orders
WHERE region = 'West';

-- ============================================
-- Query 7
-- Orders from California
-- ============================================

SELECT *
FROM orders
WHERE state = 'California';

-- ============================================
-- Query 8
-- Sales Greater Than 1000
-- ============================================

SELECT *
FROM orders
WHERE sales > 1000;

-- ============================================
-- Query 9
-- Technology Products
-- ============================================

SELECT *
FROM products
WHERE category = 'Technology';

-- ============================================
-- Query 10
-- Low Stock Products
-- ============================================

SELECT *
FROM inventory
WHERE stock_quantity <= reorder_level;

-- ============================================
-- Query 11
-- Highest Sales First
-- ============================================

SELECT *
FROM orders
ORDER BY sales DESC;

-- ============================================
-- Query 12
-- Lowest Sales First
-- ============================================

SELECT *
FROM orders
ORDER BY sales ASC;

-- ============================================
-- Query 13
-- Customers Alphabetically
-- ============================================

SELECT *
FROM customers
ORDER BY customer_name ASC;

-- ============================================
-- Query 14
-- Latest Orders
-- ============================================

SELECT *
FROM orders
ORDER BY order_date DESC;

-- ============================================
-- Query 15
-- Highest Available Stock
-- ============================================

SELECT *
FROM inventory
ORDER BY stock_quantity DESC;

-- ============================================
-- Query 16
-- Total Sales
-- ============================================

SELECT
    SUM(sales) AS total_sales
FROM orders;

-- ============================================
-- Query 17
-- Average Sales
-- ============================================

SELECT
    AVG(sales) AS average_sales
FROM orders;

-- ============================================
-- Query 18
-- Highest Sale
-- ============================================

SELECT
    MAX(sales) AS highest_sale
FROM orders;

-- ============================================
-- Query 19
-- Lowest Sale
-- ============================================

SELECT
    MIN(sales) AS lowest_sale
FROM orders;

-- ============================================
-- Query 20
-- Total Customers
-- ============================================

SELECT
    COUNT(*) AS total_customers
FROM customers;

-- ============================================
-- Query 21
-- Total Products
-- ============================================

SELECT
    COUNT(*) AS total_products
FROM products;

-- ============================================
-- Query 22
-- Total Order Lines
-- ============================================

SELECT
    COUNT(*) AS total_order_lines
FROM orders;

-- ============================================
-- Query 23
-- Total Unique Orders
-- ============================================

SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- ============================================
-- Query 24
-- Total Sales by Region
-- ============================================

SELECT
    region,
    SUM(sales) AS total_sales
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

-- ============================================
-- Query 25
-- Total Sales by State
-- ============================================

SELECT
    state,
    SUM(sales) AS total_sales
FROM orders
GROUP BY state
ORDER BY total_sales DESC;

-- ============================================
-- Query 26
-- Customer-wise Sales
-- ============================================

SELECT
    c.customer_name,
    SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_sales DESC;

-- ============================================
-- Query 27
-- Product-wise Sales
-- ============================================

 SELECT
    p.product_name,
    SUM(o.sales) AS total_sales
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC;

-- ============================================
-- Query 28
-- Sales by Ship Mode
-- ============================================

SELECT
ship_mode,
SUM(sales) AS total_sales
FROM orders
GROUP BY ship_mode;

-- ============================================
-- Query 29
-- Orders by Region
-- ============================================

SELECT 
    region,
    COUNT(*) AS total_orders
    FROM orders
    GROUP BY region
    ORDER BY total_orders DESC;

-- ============================================
-- Query 30
-- Average Sales by Region
-- ============================================

SELECT 
   region,
   AVG(sales) AS average_sales
   FROM orders
   GROUP BY region;

-- ============================================
-- Query 31
-- Regions with Sales > 100000
-- ============================================

SELECT
    region,
    SUM(sales) AS total_sales
FROM orders
GROUP BY region
HAVING SUM(sales) > 100000;

-- ============================================
-- Query 32
-- Customers Spending More Than 5000
-- ============================================

SELECT
    c.customer_name,
    SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING SUM(o.sales) > 5000
ORDER BY total_sales DESC;

-- ============================================
-- Query 33
-- Products Sold More Than 10 Times
-- ============================================

SELECT
    p.product_name,
    COUNT(*) AS total_sales_count
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_name
HAVING COUNT(*) > 10
ORDER BY total_sales_count DESC;

-- ============================================
-- Query 34
-- States with More Than 20 Orders
-- ============================================

SELECT
    state,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY state
HAVING COUNT(DISTINCT order_id) > 20;

-- ============================================
-- Query 35
-- Ship Modes with Average Sales > 300
-- ============================================

SELECT
    ship_mode,
    AVG(sales) AS average_sales
FROM orders
GROUP BY ship_mode
HAVING AVG(sales) > 300;

-- ============================================
-- Query 36
-- Cities with Sales Greater Than 20000
-- ============================================

SELECT
    city,
    SUM(sales) AS total_sales
FROM orders
GROUP BY city
HAVING SUM(sales) > 20000
ORDER BY total_sales DESC;

-- ============================================
-- Query 37
-- Top 10 Customers by Sales
-- ============================================

SELECT
    c.customer_name,
    SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- ============================================
-- Query 38
-- Monthly Sales Trend
-- ============================================

SELECT
    DATE_TRUNC('month', order_date) AS sales_month,
    SUM(sales) AS total_sales
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;

-- ============================================
-- Query 39
-- Sales by Category
-- ============================================

SELECT
    p.category,
    SUM(o.sales) AS total_sales
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- ============================================
-- Query 40
-- Sales Ranking
-- ============================================

SELECT
    order_id,
    customer_id,
    sales,
    RANK() OVER (ORDER BY sales DESC) AS sales_rank
FROM orders;

