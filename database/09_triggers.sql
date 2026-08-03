-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 09_triggers.sql
-- Description: Business Automation Triggers
-- Author: Shobha Saxena
-- Version: 2.0
-- ============================================

SET search_path TO public;

DROP TRIGGER IF EXISTS trg_inventory_timestamp ON inventory;
DROP TRIGGER IF EXISTS trg_inventory_stock_status ON inventory;
DROP TRIGGER IF EXISTS trg_validate_discount_dates ON customer_discounts;
DROP TRIGGER IF EXISTS trg_validate_refund_amount ON returns;
DROP TRIGGER IF EXISTS trg_auto_deactivate_discount ON customer_discounts;
DROP TRIGGER IF EXISTS trg_prevent_negative_inventory ON inventory;

DROP FUNCTION IF EXISTS fn_update_inventory_timestamp() CASCADE;
DROP FUNCTION IF EXISTS fn_update_stock_status() CASCADE;
DROP FUNCTION IF EXISTS fn_validate_discount_dates() CASCADE;
DROP FUNCTION IF EXISTS fn_validate_refund_amount() CASCADE;
DROP FUNCTION IF EXISTS fn_auto_deactivate_discount() CASCADE;
DROP FUNCTION IF EXISTS fn_prevent_negative_inventory() CASCADE;

-- =====================================================
-- Trigger Function 1
-- Automatically update last_updated timestamp
-- =====================================================

CREATE OR REPLACE FUNCTION fn_update_inventory_timestamp()

RETURNS TRIGGER

LANGUAGE plpgsql

AS
$$
BEGIN

    NEW.last_updated = CURRENT_TIMESTAMP;

    RETURN NEW;

END;
$$;

-- =====================================================
-- Trigger 1
-- Inventory Timestamp Trigger
-- =====================================================

CREATE TRIGGER trg_inventory_timestamp

BEFORE UPDATE

ON inventory

FOR EACH ROW

EXECUTE FUNCTION fn_update_inventory_timestamp();

-- =====================================================
-- Trigger Function 2
-- Automatically update stock status
-- =====================================================

CREATE OR REPLACE FUNCTION fn_update_stock_status()

RETURNS TRIGGER

LANGUAGE plpgsql

AS
$$
BEGIN

    IF NEW.stock_quantity = 0 THEN
        NEW.stock_status := 'Out of Stock';

    ELSIF NEW.stock_quantity <= NEW.reorder_level THEN
        NEW.stock_status := 'Low Stock';

    ELSE
        NEW.stock_status := 'In Stock';

    END IF;

    RETURN NEW;

END;
$$;

-- =====================================================
-- Trigger 2
-- Automatic Stock Status
-- =====================================================

CREATE TRIGGER trg_inventory_stock_status

BEFORE INSERT OR UPDATE

ON inventory

FOR EACH ROW

EXECUTE FUNCTION fn_update_stock_status();

-- =====================================================
-- Trigger Function 3
-- Validate Customer Discount Dates
-- =====================================================

CREATE OR REPLACE FUNCTION fn_validate_discount_dates()

RETURNS TRIGGER

LANGUAGE plpgsql

AS
$$
BEGIN

    IF NEW.end_date < NEW.start_date THEN

        RAISE EXCEPTION
        'End date cannot be earlier than Start date';

    END IF;

    RETURN NEW;

END;
$$;

-- =====================================================
-- Trigger 3
-- Customer Discount Date Validation
-- =====================================================

CREATE TRIGGER trg_validate_discount_dates

BEFORE INSERT OR UPDATE

ON customer_discounts

FOR EACH ROW

EXECUTE FUNCTION fn_validate_discount_dates();

-- =====================================================
-- Trigger Function 4
-- Validate Refund Amount
-- =====================================================

CREATE OR REPLACE FUNCTION fn_validate_refund_amount()

RETURNS TRIGGER

LANGUAGE plpgsql

AS
$$
BEGIN

    IF NEW.refund_amount < 0 THEN

        RAISE EXCEPTION
        'Refund amount cannot be negative';

    END IF;

    RETURN NEW;

END;
$$;

-- =====================================================
-- Trigger 4
-- Refund Amount Validation
-- =====================================================

CREATE TRIGGER trg_validate_refund_amount

BEFORE INSERT OR UPDATE

ON returns

FOR EACH ROW

EXECUTE FUNCTION fn_validate_refund_amount();

-- =====================================================
-- Trigger Function 5
-- Automatically Deactivate Expired Discounts
-- =====================================================

CREATE OR REPLACE FUNCTION fn_auto_deactivate_discount()

RETURNS TRIGGER

LANGUAGE plpgsql

AS
$$
BEGIN

    IF NEW.end_date < CURRENT_DATE THEN
        NEW.is_active := FALSE;
    ELSE
        NEW.is_active := TRUE;
    END IF;

    RETURN NEW;

END;
$$;

-- =====================================================
-- Trigger 5
-- Auto Deactivate Customer Discounts
-- =====================================================

CREATE TRIGGER trg_auto_deactivate_discount

BEFORE INSERT OR UPDATE

ON customer_discounts

FOR EACH ROW

EXECUTE FUNCTION fn_auto_deactivate_discount();

-- =====================================================
-- Trigger Function 6
-- Prevent Negative Inventory
-- =====================================================

CREATE OR REPLACE FUNCTION fn_prevent_negative_inventory()

RETURNS TRIGGER

LANGUAGE plpgsql

AS
$$
BEGIN

    IF NEW.stock_quantity < 0 THEN

        RAISE EXCEPTION
        'Stock quantity cannot be negative';

    END IF;

    RETURN NEW;

END;
$$;

-- =====================================================
-- Trigger 6
-- Prevent Negative Inventory
-- =====================================================

CREATE TRIGGER trg_prevent_negative_inventory

BEFORE INSERT OR UPDATE

ON inventory

FOR EACH ROW

EXECUTE FUNCTION fn_prevent_negative_inventory();

