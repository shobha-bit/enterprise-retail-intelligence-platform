-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 21_load_returns.sql
-- Description: Load Returns Data
-- Author: Shobha Saxena
-- Version: 3.0
-- ============================================

SET search_path TO public;

-- ============================================
-- Clear Existing Data
-- ============================================

TRUNCATE TABLE returns RESTART IDENTITY CASCADE;

-- ============================================
-- Load Returns Data
-- Approximately 5% of Orders Returned
-- ============================================

INSERT INTO returns
(
    order_row_id,
    product_id,
    return_date,
    return_reason,
    refund_amount,
    return_status
)

SELECT

    o.row_id,

    o.product_id,

    o.order_date + ((o.row_id % 25) + 5) AS return_date,

    CASE (o.row_id % 6)

        WHEN 0 THEN 'Damaged Product'
        WHEN 1 THEN 'Wrong Item'
        WHEN 2 THEN 'Defective Product'
        WHEN 3 THEN 'Customer Changed Mind'
        WHEN 4 THEN 'Late Delivery'
        ELSE 'Other'

    END AS return_reason,

   ROUND((COALESCE(o.sales,0) * 0.90)::NUMERIC,2) AS refund_amount, 

    CASE (o.row_id % 10)

        WHEN 0 THEN 'Rejected'
        WHEN 1 THEN 'Requested'
        WHEN 2 THEN 'Approved'
        ELSE 'Completed'

    END AS return_status

FROM orders o

ORDER BY RANDOM()

LIMIT 490;

-- ============================================
-- Verification 1
-- ============================================

SELECT
COUNT(*) AS total_returns
FROM returns;

-- ============================================
-- Verification 2
-- Return Reasons
-- ============================================

SELECT
return_reason,
COUNT(*) AS total_returns
FROM returns
GROUP BY return_reason
ORDER BY total_returns DESC;

-- ============================================
-- Verification 3
-- Return Status
-- ============================================

SELECT
return_status,
COUNT(*) AS total_returns
FROM returns
GROUP BY return_status
ORDER BY total_returns DESC;

-- ============================================
-- Verification 4
-- Sample Data
-- ============================================

SELECT *
FROM returns
ORDER BY return_id
LIMIT 20;