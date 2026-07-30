-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 04_indexes.sql
-- Description: Create Performance Indexes
-- Author: Shobha Saxena
-- ============================================

SET search_path TO public;

-- =====================================================
-- Customers
-- =====================================================

CREATE INDEX idx_customers_name
ON customers(customer_name);

CREATE INDEX idx_customers_segment
ON customers(segment);

-- =====================================================
-- Products
-- =====================================================

CREATE INDEX idx_products_category
ON products(category);

CREATE INDEX idx_products_sub_category
ON products(sub_category);

-- =====================================================
-- Orders
-- =====================================================

CREATE INDEX idx_orders_order_date
ON orders(order_date);

CREATE INDEX idx_orders_customer
ON orders(customer_id);

CREATE INDEX idx_orders_product
ON orders(product_id);

CREATE INDEX idx_orders_region
ON orders(region);

CREATE INDEX idx_orders_state
ON orders(state);

-- =====================================================
-- Inventory
-- =====================================================

CREATE INDEX idx_inventory_product
ON inventory(product_id);

CREATE INDEX idx_inventory_supplier
ON inventory(supplier_id);

CREATE INDEX idx_inventory_stock_status
ON inventory(stock_status);

-- =====================================================
-- Suppliers
-- =====================================================

CREATE INDEX idx_suppliers_name
ON suppliers(supplier_name);

CREATE INDEX idx_suppliers_country
ON suppliers(country);

-- =====================================================
-- Transportation & Logistics
-- =====================================================

CREATE INDEX idx_transport_order
ON transportation_logistics(order_id);

CREATE INDEX idx_transport_status
ON transportation_logistics(shipment_status);

CREATE INDEX idx_transport_tracking
ON transportation_logistics(tracking_number);


-- =====================================================
-- Payments
-- =====================================================

CREATE INDEX idx_payments_order
ON payments(order_id);

CREATE INDEX idx_payments_status
ON payments(payment_status);

CREATE INDEX idx_payments_method
ON payments(payment_method);

-- =====================================================
-- Returns
-- =====================================================

CREATE INDEX idx_returns_order
ON returns(order_id);

CREATE INDEX idx_returns_product
ON returns(product_id);

CREATE INDEX idx_returns_status
ON returns(return_status);

-- =====================================================
-- Customer Discounts
-- =====================================================

CREATE INDEX idx_customer_discounts_customer
ON customer_discounts(customer_id);

CREATE INDEX idx_customer_discounts_active
ON customer_discounts(is_active);
