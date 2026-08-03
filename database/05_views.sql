-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 05_views.sql
-- Description: Business Analytics Views
-- Author: Shobha Saxena
-- Version: 2.0
-- ============================================

SET search_path TO public;

-- ============================================
-- Drop Existing Views (Safe to Re-run)
-- ============================================

DROP VIEW IF EXISTS vw_customer_discount_summary CASCADE;
DROP VIEW IF EXISTS vw_return_summary CASCADE;
DROP VIEW IF EXISTS vw_payment_summary CASCADE;
DROP VIEW IF EXISTS vw_transportation_summary CASCADE;
DROP VIEW IF EXISTS vw_supplier_performance CASCADE;
DROP VIEW IF EXISTS vw_inventory_status CASCADE;
DROP VIEW IF EXISTS vw_product_performance CASCADE;
DROP VIEW IF EXISTS vw_customer_summary CASCADE;
DROP VIEW IF EXISTS vw_sales_summary CASCADE;

-- =====================================================
-- View: Sales Summary
-- =====================================================

CREATE VIEW vw_sales_summary AS

SELECT

    o.row_id,
    o.order_id,
    o.order_date,
    o.ship_date,
    o.ship_mode,

    c.customer_name,
    c.segment,

    p.product_name,
    p.category,
    p.sub_category,

    o.country,
    o.city,
    o.state,
    o.region,

    o.sales

FROM orders o

JOIN customers c
ON o.customer_id = c.customer_id

JOIN products p
ON o.product_id = p.product_id;

-- =====================================================
-- View: Customer Summary
-- =====================================================

CREATE VIEW vw_customer_summary AS

SELECT

    c.customer_id,
    c.customer_name,
    c.segment,

    COUNT(o.row_id) AS total_order_lines,
    COUNT(DISTINCT o.order_id) AS total_orders,

    COALESCE(SUM(o.sales),0) AS total_sales,
    COALESCE(AVG(o.sales),0) AS average_order_value

FROM customers c

LEFT JOIN orders o
ON c.customer_id = o.customer_id

GROUP BY

    c.customer_id,
    c.customer_name,
    c.segment;

-- =====================================================
-- View: Product Performance
-- =====================================================

CREATE VIEW vw_product_performance AS

SELECT

    p.product_id,
    p.product_name,
    p.category,
    p.sub_category,

    COUNT(o.row_id) AS times_sold,
    COALESCE(SUM(o.sales), 0) AS total_sales,
    COALESCE(AVG(o.sales), 0) AS average_sales
FROM products p

LEFT JOIN orders o
ON p.product_id = o.product_id

GROUP BY

    p.product_id,
    p.product_name,
    p.category,
    p.sub_category;

-- =====================================================
-- View: Inventory Status
-- =====================================================

CREATE VIEW vw_inventory_status AS

SELECT

    i.inventory_id,

    p.product_name,

    s.supplier_name,

    i.warehouse_name,
    i.warehouse_location,

    i.stock_quantity,
    i.reorder_level,
    i.stock_status,

    i.last_restock_date

FROM inventory i

JOIN products p
ON i.product_id = p.product_id

LEFT JOIN suppliers s
ON i.supplier_id = s.supplier_id;

-- =====================================================
-- View: Supplier Performance
-- =====================================================

CREATE VIEW vw_supplier_performance AS

SELECT

    s.supplier_id,
    s.supplier_name,

    s.city,
    s.country,

    s.supplier_rating,

    COUNT(i.inventory_id) AS inventory_records,

    COALESCE(SUM(i.stock_quantity),0) AS total_stock

FROM suppliers s

LEFT JOIN inventory i
ON s.supplier_id = i.supplier_id

GROUP BY

    s.supplier_id,
    s.supplier_name,
    s.city,
    s.country,
    s.supplier_rating;

-- =====================================================
-- View: Transportation Summary
-- =====================================================

CREATE VIEW vw_transportation_summary AS

SELECT

    t.transport_id,

    o.order_id,

    c.customer_name,

    t.carrier_name,
    t.tracking_number,

    t.shipment_status,

    t.dispatch_date,
    t.estimated_delivery_date,
    t.actual_delivery_date,

    t.delivery_cost,

    o.region,
    o.state,
    o.city

FROM transportation_logistics t

JOIN orders o
ON t.order_row_id = o.row_id

JOIN customers c
ON o.customer_id = c.customer_id;

-- =====================================================
-- View: Payment Summary
-- =====================================================

CREATE VIEW vw_payment_summary AS

SELECT

    p.payment_id,

    o.order_id,

    c.customer_name,

    p.payment_method,
    p.payment_status,
    p.payment_date,

    p.transaction_reference,

    p.payment_amount,

    o.sales,
    o.region

FROM payments p

JOIN orders o
ON p.order_row_id = o.row_id

JOIN customers c
ON o.customer_id = c.customer_id;

-- =====================================================
-- View: Return Summary
-- =====================================================

CREATE VIEW vw_return_summary AS

SELECT

    r.return_id,

    o.order_id,

    c.customer_name,

    p.product_name,
    p.category,
    p.sub_category,

    r.return_reason,
    r.return_status,

    r.return_date,

    r.refund_amount,

    o.sales,
    o.region

FROM returns r

JOIN orders o
ON r.order_row_id = o.row_id

JOIN customers c
ON o.customer_id = c.customer_id

JOIN products p
ON r.product_id = p.product_id;

-- =====================================================
-- View: Customer Discount Summary
-- =====================================================

CREATE VIEW vw_customer_discount_summary AS

SELECT

    cd.discount_id,

    c.customer_name,

    cd.discount_type,

    cd.discount_percentage,

    cd.start_date,
    cd.end_date,

    cd.is_active,

    COUNT(DISTINCT o.order_id) AS total_orders,

    COALESCE(SUM(o.sales),0) AS total_sales

FROM customer_discounts cd

JOIN customers c
ON cd.customer_id = c.customer_id

LEFT JOIN orders o
ON c.customer_id = o.customer_id

GROUP BY

    cd.discount_id,

    c.customer_name,

    cd.discount_type,

    cd.discount_percentage,

    cd.start_date,
    cd.end_date,

    cd.is_active;