-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 15_load_products.sql
-- Description: Load Products from Staging
-- Author: Shobha Saxena
-- ============================================

SET search_path TO public, staging;

INSERT INTO products
(
    product_id,
    product_name,
    category,
    sub_category
)
SELECT DISTINCT
    product_id,
    product_name,
    category,
    sub_category
FROM staging.superstore_raw
WHERE product_id IS NOT NULL
ON CONFLICT (product_id)
DO NOTHING;

SELECT COUNT(*) AS total_products
FROM products;