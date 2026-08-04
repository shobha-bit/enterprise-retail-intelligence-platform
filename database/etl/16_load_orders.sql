-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 16_load_orders.sql
-- Description: Load Orders from Staging
-- Author: Shobha Saxena
-- ============================================

SET search_path TO public, staging;

INSERT INTO orders
(
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    product_id,
    country,
    city,
    state,
    postal_code,
    region,
    sales
)

SELECT
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    product_id,
    country,
    city,
    state,
    postal_code,
    region,
    sales

FROM staging.superstore_raw

WHERE row_id IS NOT NULL
AND order_id IS NOT NULL
AND customer_id IS NOT NULL
AND product_id IS NOT NULL

ON CONFLICT (row_id)
DO NOTHING;

SELECT COUNT(*) AS total_orders
FROM orders;