-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 14_load_customers.sql
-- Description: Load Customers from Staging
-- Author: Shobha Saxena
-- ============================================

SET search_path TO public, staging;

INSERT INTO customers
(
    customer_id,
    customer_name,
    segment
)
SELECT DISTINCT
    customer_id,
    customer_name,
    segment
FROM staging.superstore_raw
WHERE customer_id IS NOT NULL
ON CONFLICT (customer_id)
DO NOTHING;

SELECT COUNT(*) AS total_customers
FROM customers;