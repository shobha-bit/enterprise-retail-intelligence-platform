-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 03_constraints.sql
-- Description: Add Foreign Keys and Constraints
-- Author: Shobha Saxena
-- ============================================

SET search_path TO public;

-- =====================================================
-- Orders → Customers
-- =====================================================

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- =====================================================
-- Orders → Products
-- =====================================================

ALTER TABLE orders
ADD CONSTRAINT fk_orders_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);

-- =====================================================
-- Inventory → Products
-- =====================================================

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);


-- =====================================================
-- Inventory → Suppliers
-- =====================================================

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_suppliers
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id);

-- =====================================================
-- Transportation → Orders
-- =====================================================

ALTER TABLE transportation_logistics
ADD CONSTRAINT fk_transport_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);


-- =====================================================
-- Payments → Orders
-- =====================================================

ALTER TABLE payments
ADD CONSTRAINT fk_payments_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);

-- =====================================================
-- Returns → Orders
-- =====================================================

ALTER TABLE returns
ADD CONSTRAINT fk_returns_orders
FOREIGN KEY (order_id)
REFERENCES orders(order_id);


-- =====================================================
-- Returns → Products
-- =====================================================

ALTER TABLE returns
ADD CONSTRAINT fk_returns_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);


-- =====================================================
-- Customer Discounts → Customers
-- =====================================================

ALTER TABLE customer_discounts
ADD CONSTRAINT fk_customer_discounts_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);