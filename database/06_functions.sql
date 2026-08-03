-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 06_functions.sql
-- Description: Business Functions
-- Author: Shobha Saxena
-- Version: 2.0
-- ============================================

SET search_path TO public;

-- =====================================================
-- Function 1
-- Customer Total Sales
-- =====================================================

CREATE OR REPLACE FUNCTION get_customer_total_sales(
    p_customer_id VARCHAR
)
RETURNS DECIMAL(12,2)
LANGUAGE plpgsql
AS
$$
DECLARE
    total_sales NUMERIC;
BEGIN

    SELECT COALESCE(SUM(sales),0)
    INTO total_sales
    FROM orders
    WHERE customer_id = p_customer_id;

    RETURN total_sales;

END;
$$;

-- =====================================================
-- Function 2
-- Product Total Sales
-- =====================================================

CREATE OR REPLACE FUNCTION get_product_total_sales(
    p_product_id VARCHAR
)
RETURNS DECIMAL(12,2)
LANGUAGE plpgsql
AS
$$
DECLARE
    total_sales NUMERIC;
BEGIN

    SELECT COALESCE(SUM(sales),0)
    INTO total_sales
    FROM orders
    WHERE product_id = p_product_id;

    RETURN total_sales;

END;
$$;

-- =====================================================
-- Function 3
-- Customer Order Count
-- =====================================================

CREATE OR REPLACE FUNCTION get_customer_order_count(
    p_customer_id VARCHAR
)
RETURNS INTEGER
LANGUAGE plpgsql
AS
$$
DECLARE
    total_orders INTEGER;
BEGIN

    SELECT COUNT(DISTINCT order_id)
    INTO total_orders
    FROM orders
    WHERE customer_id = p_customer_id;

    RETURN total_orders;

END;
$$;

-- =====================================================
-- Function 4
-- Region Total Sales
-- =====================================================

CREATE OR REPLACE FUNCTION get_region_total_sales(
    p_region VARCHAR
)
RETURNS DECIMAL(12,2)
LANGUAGE plpgsql
AS
$$
DECLARE
    total_sales NUMERIC;
BEGIN

    SELECT COALESCE(SUM(sales),0)
    INTO total_sales
    FROM orders
    WHERE region = p_region;

    RETURN total_sales;

END;
$$;

-- =====================================================
-- Function 5
-- State Total Sales
-- =====================================================

CREATE OR REPLACE FUNCTION get_state_total_sales(
    p_state VARCHAR
)
RETURNS DECIMAL(12,2)
LANGUAGE plpgsql
AS
$$
DECLARE
    total_sales NUMERIC;
BEGIN

    SELECT COALESCE(SUM(sales),0)
    INTO total_sales
    FROM orders
    WHERE state = p_state;

    RETURN total_sales;

END;
$$;

-- =====================================================
-- Function 6
-- Inventory Details
-- =====================================================

CREATE OR REPLACE FUNCTION get_inventory_stock(
    p_product_id VARCHAR
)
RETURNS TABLE
(
    inventory_id INT,
    warehouse_name VARCHAR,
    stock_quantity INT,
    reorder_level INT,
    stock_status VARCHAR
)
LANGUAGE plpgsql
AS
$$
BEGIN

RETURN QUERY

SELECT
    i.inventory_id,
    i.warehouse_name,
    i.stock_quantity,
    i.reorder_level,
    i.stock_status

FROM inventory i

WHERE i.product_id = p_product_id;

END;
$$;

-- =====================================================
-- Function 7
-- Low Stock Products
-- =====================================================

CREATE OR REPLACE FUNCTION get_low_stock_products()
RETURNS TABLE
(
    product_name VARCHAR,
    warehouse_name VARCHAR,
    stock_quantity INT,
    reorder_level INT
)
LANGUAGE plpgsql
AS
$$
BEGIN

RETURN QUERY

SELECT

    p.product_name,
    i.warehouse_name,
    i.stock_quantity,
    i.reorder_level

FROM inventory i

JOIN products p
ON i.product_id = p.product_id

WHERE i.stock_quantity <= i.reorder_level;

END;
$$;

-- =====================================================
-- Function 8
-- Supplier Stock Summary
-- =====================================================

CREATE OR REPLACE FUNCTION get_supplier_stock(
    p_supplier_id INT
)
RETURNS TABLE
(
    supplier_name VARCHAR,
    product_name VARCHAR,
    warehouse_name VARCHAR,
    stock_quantity INT,
    stock_status VARCHAR
)
LANGUAGE plpgsql
AS
$$
BEGIN

RETURN QUERY

SELECT

    s.supplier_name,
    p.product_name,
    i.warehouse_name,
    i.stock_quantity,
    i.stock_status

FROM suppliers s

JOIN inventory i
ON s.supplier_id = i.supplier_id

JOIN products p
ON i.product_id = p.product_id

WHERE s.supplier_id = p_supplier_id;

END;
$$;