-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 19_load_transportation.sql
-- Description: Load Transportation Logistics Data
-- Author: Shobha Saxena
-- Version: 3.0
-- ============================================

SET search_path TO public;

-- ============================================
-- Clear Existing Data (Optional)
-- ============================================

TRUNCATE TABLE transportation_logistics RESTART IDENTITY;

-- ============================================
-- Prepare Transportation Data
-- ============================================

WITH logistics_base AS
(
    SELECT

        o.row_id,

        (
            ARRAY[
                'FedEx',
                'UPS',
                'DHL',
                'Blue Dart',
                'Delhivery',
                'XpressBees'
            ]
        )[FLOOR(RANDOM()*6+1)] AS carrier_name,

        'TRK-' || LPAD(o.row_id::TEXT,8,'0') AS tracking_number,

        CASE
            WHEN RANDOM() < 0.90 THEN 'Delivered'
            WHEN RANDOM() < 0.95 THEN 'In Transit'
            WHEN RANDOM() < 0.98 THEN 'Shipped'
            WHEN RANDOM() < 0.995 THEN 'Pending'
            ELSE 'Cancelled'
        END AS shipment_status,

        (o.order_date + FLOOR(RANDOM()*3)::INT) AS dispatch_date,

        ROUND((RANDOM()*40+10)::NUMERIC,2) AS delivery_cost

    FROM orders o
),

estimated_dates AS
(
    SELECT

        row_id,
        carrier_name,
        tracking_number,
        shipment_status,
        dispatch_date,

        (
            dispatch_date +
            (FLOOR(RANDOM()*3)+3)::INT
        ) AS estimated_delivery_date,

        delivery_cost

    FROM logistics_base
)

INSERT INTO transportation_logistics
(
    order_row_id,
    carrier_name,
    tracking_number,
    shipment_status,
    dispatch_date,
    estimated_delivery_date,
    actual_delivery_date,
    delivery_cost
)

SELECT

    row_id,

    carrier_name,

    tracking_number,

    shipment_status,

    dispatch_date,

    estimated_delivery_date,

    CASE

        WHEN shipment_status = 'Delivered'
        THEN estimated_delivery_date
             + CASE
                    WHEN RANDOM() < 0.90 THEN 0
                    WHEN RANDOM() < 0.98 THEN 1
                    ELSE 2
               END

        WHEN shipment_status = 'In Transit'
        THEN NULL

        WHEN shipment_status = 'Shipped'
        THEN NULL

        WHEN shipment_status = 'Pending'
        THEN NULL

        ELSE NULL

    END AS actual_delivery_date,

    delivery_cost

FROM estimated_dates;

-- ============================================
-- Verification 1
-- ============================================

SELECT COUNT(*) AS total_transport_records
FROM transportation_logistics;

-- ============================================
-- Verification 2
-- Carrier Distribution
-- ============================================

SELECT
carrier_name,
COUNT(*) AS total_shipments
FROM transportation_logistics
GROUP BY carrier_name
ORDER BY total_shipments DESC;

-- ============================================
-- Verification 3
-- Shipment Status Distribution
-- ============================================

SELECT
shipment_status,
COUNT(*) AS total_shipments
FROM transportation_logistics
GROUP BY shipment_status
ORDER BY total_shipments DESC;

-- ============================================
-- Verification 4
-- Validate Dates
-- Should return ZERO rows
-- ============================================

SELECT *
FROM transportation_logistics
WHERE actual_delivery_date < estimated_delivery_date;

-- ============================================
-- Verification 5
-- Preview
-- ============================================

SELECT *
FROM transportation_logistics
ORDER BY transport_id
LIMIT 20;