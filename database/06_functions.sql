-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 06_functions.sql
-- Description: Business Functions
-- Author: Shobha Saxena
-- ============================================

SET search_path TO public;

-- =====================================================
-- Function: get_customer_total_sales
-- Description: Returns total sales for a customer
-- =====================================================

CREATE OR REPLACE FUNCTION get_customer_total_sales(
    p_customer_id VARCHAR
)
RETURNS NUMERIC
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
-- Function: get_customer_total_profit
-- Description: Returns total profit for a customer
-- =====================================================

CREATE OR REPLACE FUNCTION get_customer_total_profit(
    p_customer_id VARCHAR
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
DECLARE
      total_profit NUMERIC;
BEGIN
   
    SELECT COALESCE(SUM(profit),0)
    INTO total_profit
    FROM orders
    WHERE customer_id = p_customer_id;

    RETURN total_profit;

END;
$$;

-- =====================================================
-- Function: get_product_total_sales
-- Description: Returns total sales of a product
-- =====================================================

CREATE OR REPLACE FUNCTION get_product_total_sales(
    p_product_id VARCHAR 
)
RETURNS NUMERIC
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
-- Function: get_product_total_profit
-- Description: Returns total profit of a product
-- =====================================================

CREATE OR REPLACE FUNCTION get_product_total_profit(
    p_product_id VARCHAR
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
DECLARE
    total_profit NUMERIC;
BEGIN

    SELECT COALESCE(SUM(profit),0)
    INTO total_profit
    FROM orders
    WHERE product_id = p_product_id;

    RETURN total_profit;

END;
$$;

-- =====================================================
-- Function: get_inventory_stock
-- Description: Returns inventory details for a product
-- =====================================================

CREATE OR REPLACE FUNCTION get_inventory_stock(
    p_product_id VARCHAR
)
RETURNS TABLE
(
    inventory_id INT,
    product_id VARCHAR,
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
         i.product_id,
         i.stock_quantity,
         i.reorder_level,
         i.stock_status

    FROM inventory i 

    WHERE i.product_id = p_product_id;

END;
$$;

-- =====================================================
-- Function: get_customer_order_count
-- Description: Returns total orders placed by a customer
-- =====================================================

CREATE OR REPLACE FUNCTION get_customer_order_count(
    p_customer_id VARCHAR
)
RETURNS INT
LANGUAGE plpgsql
AS
$$
DECLARE
     total_orders INT;
BEGIN

    SELECT COUNT(order_id)
    INTO total_orders
    FROM orders
    WHERE customer_id = p_customer_id;

    RETURN total_orders;

END;
$$;

-- =====================================================
-- Function: calculate_profit_margin
-- Description: Returns profit margin percentage for an order
-- =====================================================

CREATE OR REPLACE FUNCTION calculate_profit_margin(
    p_order_id VARCHAR
)
RETURNS NUMERIC
LANGUAGE plpgsql
AS
$$
DECLARE
    profit_margin NUMERIC;
BEGIN

    SELECT
        CASE
            WHEN sales = 0 THEN 0
            ELSE ROUND((profit / sales) * 100, 2)
        END
    INTO profit_margin
    FROM orders
    WHERE order_id = p_order_id;

    RETURN COALESCE(profit_margin,0);

END;
$$;

-- =====================================================
-- Function: get_supplier_stock
-- Description: Returns stock summary for a supplier
-- =====================================================

CREATE OR REPLACE FUNCTION get_supplier_stock(
    p_supplier_id INt
)
RETURNS TABLE 
(
    supplier_name VARCHAR,
    product_id VARCHAR,
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
        i.product_id,
        i.warehouse_name,
        i.stock_quantity,
        i.stock_status

    FROM suppliers s
    JOIN inventory i
    ON s.supplier_id = i.supplier_id

    WHERE s.supplier_id = p_supplier_id;

END;
$$;