-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 05_views.sql
-- Description: Create Business Analytics Views
-- Author: Shobha Saxena
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
-- View: vw_sales_summary
-- Description: Sales performance summary
-- =====================================================

CREATE OR REPLACE VIEW vw_sales_summary AS

SELECT
    order_id,
    order_date,
    customer_id,
    product_id,
    region,

    sales,
    quantity,
    discount,
    profit,

    (sales - profit) AS estimated_cost

FROM orders;

-- =====================================================
-- View: vw_customer_summary
-- Description: Customer purchase summary
-- =====================================================

CREATE OR REPLACE VIEW vw_customer_summary AS

SELECT
    c.customer_id,
    c.customer_name,
    c.segment,

    COUNT(o.order_id) AS total_orders,
    SUM(o.sales) AS total_sales,
    SUM(o.profit) AS total_profit,
    AVG(o.sales) AS average_order_value

FROM customers c
JOIN orders o 
ON c.customer_id = o.customer_id

GROUP BY
    c.customer_id,
    c.customer_name,
    c.segment;

-- =====================================================
-- View: vw_product_performance
-- Description: Product Performance Summary
-- =====================================================

CREATE OR REPLACE VIEW vw_product_performance AS 

SELECT 
    
    p.product_id,
    p.product_name,
    p.category,
    p.sub_category,

    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS total_quantity_sold,
    SUM(o.sales) AS total_sales,
    sum(o.profit) AS total_profit,
    AVG(o.discount) AS average_discount

FROM products p
JOIN orders o
ON p.product_id = o.product_id

GROUP BY
    p.product_id,
    p.product_name,
    p.category,
    p.sub_category;

-- =====================================================
-- View: vw_inventory_status
-- Description: Inventory Status Summary
-- =====================================================

CREATE OR REPLACE VIEW vw_inventory_status AS

SELECT

    i.inventory_id,
    p.product_id,
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
-- View: vw_supplier_performance
-- Description: Supplier Performance Summary
-- =====================================================

CREATE OR REPLACE VIEW vw_supplier_performance AS

SELECT

    s.supplier_id,
    s.supplier_name,
    s.contact_person,
    s.city,
    s.country,
    s.supplier_rating,

    COUNT(i.product_id) AS total_products,
    COALESCE(SUM(i.stock_quantity), 0) AS total_stock,
    COUNT(DISTINCT i.warehouse_name) AS warehouses_served

FROM suppliers s
LEFT JOIN inventory i
ON s.supplier_id = i.supplier_id

GROUP BY 
    
    s.supplier_id,
    s.supplier_name,
    s.contact_person,
    s.city,
    s.country,
    s.supplier_rating;

-- =====================================================
-- View: vw_transportation_summary
-- Description: Transportation Performance Summary
-- =====================================================

CREATE OR REPLACE VIEW vw_transportation_summary AS

SELECT

    t.transport_id,
    t.order_id,
    c.customer_name,

    t.carrier_name,
    t.tracking_number,

    t.dispatch_date,
    t.estimated_delivery_date,
    t.actual_delivery_date,

    t.delivery_cost,

    o.region,
    o.state,
    o.city

FROM transportation_logistics t
JOIN orders o
ON t.order_id = o.order_id

JOIN customers c
ON o.customer_id = c.customer_id;

-- =====================================================
-- View: vw_payment_summary
-- Description: Payment Summary
-- =====================================================

CREATE OR REPLACE VIEW vw_payment_summary AS

SELECT 
   
    p.payment_id,
    p.order_id,

    c.customer_name,

    p.payment_method,
    p.payment_status,
    p.payment_date,
    p.transaction_reference,
    p.payment_amount,

    o.region,
    o.sales

FROM payments p

JOIN orders o
ON p.order_id = o.order_id

JOIN customers c
ON o.customer_id = c.customer_id;

-- =====================================================
-- View: vw_return_summary
-- Description: Return Analysis Summary
-- =====================================================

CREATE OR REPLACE VIEW vw_return_summary AS

SELECT

    r.return_id,
    r.order_id,

    c.customer_name,

    p.product_name,
    p.category,
    p.sub_category,

    r.return_date,
    r.return_reason,
    r.refund_amount,
    r.return_status,

    o.region,
    o.sales

FROM returns r

JOIN orders o
ON r.order_id = o.order_id

JOIN customers c
ON o.customer_id = c.customer_id

JOIN products p 
ON r.product_id = p.product_id;

-- =====================================================
-- View: vw_customer_discount_summary
-- Description: Customer Discount Summary
-- =====================================================

CREATE OR REPLACE VIEW vw_customer_discount_summary AS

SELECT

    cd.discount_id,

    c.customer_id,
    c.customer_name,
    c.segment,

    cd.discount_type,
    cd.discount_percentage,

    cd.start_date,
    cd.end_date,
    cd.is_active,

    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.sales),0) AS total_sales,
    COALESCE(SUM(o.profit),0) AS total_profit

FROM customer_discounts cd

JOIN customers c
ON cd.customer_id = c.customer_id

LEFT Join orders o
ON c.customer_id = o.customer_id

GROUP BY

    cd.discount_id,
    c.customer_id,
    c.customer_name,
    c.segment,
    cd.discount_type,
    cd.discount_percentage,
    cd.start_date,
    cd.end_date,
    cd.is_active;