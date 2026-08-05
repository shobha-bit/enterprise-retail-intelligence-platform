-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 18_load_inventory.sql
-- Description: Load Inventory Data
-- Author: Shobha Saxena
-- Version: 3.0
-- ============================================

SET search_path TO public;

-- ============================================
-- Clear Existing Data
-- ============================================

TRUNCATE TABLE inventory RESTART IDENTITY CASCADE;

-- ============================================
-- Generate Inventory Data
-- ============================================

WITH inventory_data AS
(
    SELECT

        p.product_id,

        ((ROW_NUMBER() OVER (ORDER BY p.product_id)-1)%17)+1
        AS supplier_id,

        CASE
            WHEN p.category = 'Furniture'
                THEN 'Furniture Warehouse'

            WHEN p.category = 'Office Supplies'
                THEN 'Office Supply Warehouse'

            ELSE 'Technology Warehouse'
        END
        AS warehouse_name,

        CASE
            WHEN p.category = 'Furniture'
                THEN 'New York'

            WHEN p.category = 'Office Supplies'
                THEN 'Chicago'

            ELSE 'San Francisco'
        END
        AS warehouse_location,

        (FLOOR(RANDOM()*451)+50)::INT
        AS stock_quantity,

        (FLOOR(RANDOM()*61)+20)::INT
        AS reorder_level,

        CURRENT_DATE -
        (FLOOR(RANDOM()*60))::INT
        AS last_restock_date

    FROM products p
)

-- ============================================
-- Insert Inventory Records
-- ============================================

INSERT INTO inventory
(
    product_id,
    supplier_id,
    warehouse_name,
    warehouse_location,
    stock_quantity,
    reorder_level,
    stock_status,
    last_restock_date
)

SELECT

    product_id,

    supplier_id,

    warehouse_name,

    warehouse_location,

    stock_quantity,

    reorder_level,

    CASE
        WHEN stock_quantity >= 100
            THEN 'In Stock'

        WHEN stock_quantity >= 50
            THEN 'Low Stock'

        ELSE 'Reorder'
    END
    AS stock_status,

    last_restock_date

FROM inventory_data;

-- ============================================
-- Verification 1
-- ============================================

SELECT
COUNT(*) AS total_inventory_records
FROM inventory;

-- ============================================
-- Verification 2
-- ============================================

SELECT

stock_status,

COUNT(*) AS total_products

FROM inventory

GROUP BY stock_status

ORDER BY total_products DESC;

-- ============================================
-- Verification 3
-- ============================================

SELECT *

FROM inventory

ORDER BY inventory_id

LIMIT 20;