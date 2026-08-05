-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 22_load_customer_discounts.sql
-- Description: Load Customer Discounts
-- Author: Shobha Saxena
-- Version: 3.1
-- ============================================

SET search_path TO public;

-- ============================================
-- Clear Existing Data
-- ============================================

TRUNCATE TABLE customer_discounts RESTART IDENTITY CASCADE;

-- ============================================
-- Load Customer Discounts
-- ============================================

WITH customer_summary AS
(
    SELECT

        customer_id,

        SUM(COALESCE(sales,0)) AS total_sales

    FROM orders

    GROUP BY customer_id
)

INSERT INTO customer_discounts
(
    customer_id,
    discount_type,
    discount_percentage,
    start_date,
    end_date,
    is_active
)

SELECT

    customer_id,

    CASE (ABS(HASHTEXT(customer_id)) % 5)

        WHEN 0 THEN 'Loyalty'
        WHEN 1 THEN 'Seasonal'
        WHEN 2 THEN 'Festival'
        WHEN 3 THEN 'Promotional'
        ELSE 'Coupon'

    END AS discount_type,

    CASE

        WHEN total_sales >= 10000 THEN 20
        WHEN total_sales >= 7000 THEN 15
        WHEN total_sales >= 4000 THEN 10
        ELSE 5

    END AS discount_percentage,

    DATE '2019-01-01' AS start_date,

    DATE '2019-12-31' AS end_date,

    TRUE AS is_active

FROM customer_summary;

-- ============================================
-- Verification 1
-- ============================================

SELECT
COUNT(*) AS total_customers
FROM customer_discounts;

-- ============================================
-- Verification 2
-- ============================================

SELECT

discount_type,

COUNT(*) AS total_customers

FROM customer_discounts

GROUP BY discount_type

ORDER BY total_customers DESC;

-- ============================================
-- Verification 3
-- ============================================

SELECT

discount_percentage,

COUNT(*) AS total_customers

FROM customer_discounts

GROUP BY discount_percentage

ORDER BY discount_percentage DESC;

-- ============================================
-- Verification 4
-- ============================================

SELECT *

FROM customer_discounts

ORDER BY discount_id

LIMIT 20;