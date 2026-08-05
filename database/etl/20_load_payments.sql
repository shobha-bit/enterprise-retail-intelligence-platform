-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 20_load_payments.sql
-- Description: Load Payment Data
-- Author: Shobha Saxena
-- Version: 3.0
-- ============================================

SET search_path TO public;

-- ============================================
-- Clear Existing Data
-- ============================================

TRUNCATE TABLE payments RESTART IDENTITY CASCADE;

-- ============================================
-- Generate Payment Data
-- ============================================

WITH payment_data AS
(
    SELECT

        o.row_id AS order_row_id,

        (
            ARRAY[
                'Credit Card',
                'Debit Card',
                'UPI',
                'Net Banking',
                'Cash',
                'Wallet'
            ]
        )[FLOOR(RANDOM()*6+1)] AS payment_method,

        CASE
            WHEN RANDOM() < 0.95 THEN 'Completed'
            WHEN RANDOM() < 0.98 THEN 'Pending'
            WHEN RANDOM() < 0.995 THEN 'Refunded'
            ELSE 'Failed'
        END AS payment_status,

        o.order_date +
        (FLOOR(RANDOM()*5))::INT
        AS payment_date,

        'TXN-' || LPAD(o.row_id::TEXT,8,'0')
        AS transaction_reference,

        ROUND(o.sales::NUMERIC,2)
        AS payment_amount

    FROM orders o
)

-- ============================================
-- Insert Payment Records
-- ============================================

INSERT INTO payments
(
    order_row_id,
    payment_method,
    payment_status,
    payment_date,
    transaction_reference,
    payment_amount
)

SELECT

    order_row_id,
    payment_method,
    payment_status,
    payment_date,
    transaction_reference,
    payment_amount

FROM payment_data;

-- ============================================
-- Verification 1
-- ============================================

SELECT
COUNT(*) AS total_payments
FROM payments;

-- ============================================
-- Verification 2
-- Payment Method Distribution
-- ============================================

SELECT

payment_method,

COUNT(*) AS total_transactions

FROM payments

GROUP BY payment_method

ORDER BY total_transactions DESC;

-- ============================================
-- Verification 3
-- Payment Status Distribution
-- ============================================

SELECT

payment_status,

COUNT(*) AS total_transactions

FROM payments

GROUP BY payment_status

ORDER BY total_transactions DESC;

-- ============================================
-- Verification 4
-- Sample Data
-- ============================================

SELECT *

FROM payments

ORDER BY payment_id

LIMIT 20;
