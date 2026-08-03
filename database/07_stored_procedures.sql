-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 07_stored_procedures.sql
-- Description: Business Stored Procedures
-- Author: Shobha Saxena
-- Version: 2.0
-- ============================================

SET search_path TO public;

-- =====================================================
-- Procedure 1
-- Add New Supplier
-- =====================================================

CREATE OR REPLACE PROCEDURE add_supplier(

    p_supplier_name   VARCHAR,
    p_contact_person  VARCHAR,
    p_phone           VARCHAR,
    p_email           VARCHAR,
    p_city            VARCHAR,
    p_country         VARCHAR,
    p_supplier_rating DECIMAL(3,2)
)

LANGUAGE plpgsql

AS
$$

BEGIN
    
    INSERT INTO suppliers
    (
        supplier_name,
        contact_person,
        phone,
        email,
        city,
        country,
        supplier_rating

    )

    VALUES
    (
        p_supplier_name,
        p_contact_person,
        p_phone,
        p_email,
        p_city,
        p_country,
        p_supplier_rating
    );

END;
$$;

-- =====================================================
-- Procedure 2
-- Add Inventory
-- =====================================================

CREATE OR REPLACE PROCEDURE add_inventory(

    p_product_id         VARCHAR,
    p_supplier_id        INT,
    p_warehouse_name     VARCHAR,
    p_warehouse_location VARCHAR,
    p_stock_quantity     INT,
    p_reorder_level      INT,
    p_stock_status       VARCHAR,
    p_last_restock_date  DATE
)

LANGUAGE plpgsql
AS
$$

BEGIN

    INSERT INTO inventory
    (
        product_id,
        supplier_id,
        warehouse_name,
        warehouse_location,
        stock_quantity,
        reorder_level,
        stock_status,
        last_restock_date
    )

    VALUES
    (
        p_product_id,
        p_supplier_id,
        p_warehouse_name,
        p_warehouse_location,
        p_stock_quantity,
        p_reorder_level,
        p_stock_status,
        p_last_restock_date
    );

END;
$$;

-- =====================================================
-- Procedure 3
-- Restock Inventory
-- Description: Increase stock after new inventory arrives
-- =====================================================

CREATE OR REPLACE PROCEDURE restock_inventory(

    p_inventory_id   INT,
    p_added_stock    INT
)

LANGUAGE plpgsql

AS
$$

BEGIN
    
    IF p_added_stock <= 0 THEN
        RAISE EXCEPTION 'Added stock must be greater than zero.';
    END IF;

    UPDATE inventory

    SET 
       stock_quantity = stock_quantity + p_added_stock,
       last_restock_date = CURRENT_DATE,
       last_updated =   CURRENT_TIMESTAMP
       
    WHERE inventory_id = p_inventory_id;

END;
$$;

-- =====================================================
-- Procedure 4
-- Update Shipment Status
-- Description: Update logistics shipment status
-- =====================================================

CREATE OR REPLACE PROCEDURE update_shipment_status(

    p_transport_id    INT,
    p_new_status      VARCHAR
)

LANGUAGE plpgsql
AS
$$
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM transportation_logistics
        WHERE transport_id = p_transport_id
    ) THEN
        RAISE EXCEPTION 'Transport ID not found.';
    END IF;

    UPDATE transportation_logistics
    SET shipment_status = p_new_status
    WHERE transport_id = p_transport_id;

END;
$$;

-- =====================================================
-- Procedure 5
-- Register Payment
-- Description: Save customer payment information
-- =====================================================

CREATE OR REPLACE PROCEDURE register_payment(

    p_order_row_id           INT,
    p_payment_method         VARCHAR,
    p_payment_status         VARCHAR,
    p_payment_date           DATE,
    p_transaction_reference  VARCHAR,
    p_payment_amount         DECIMAL(12,2)

)

LANGUAGE plpgsql

AS
$$

BEGIN
     
     IF p_payment_amount <= 0 THEN
    RAISE EXCEPTION 'Payment amount must be greater than zero.';
END IF;

    INSERT INTO payments
    (
        order_row_id,
        payment_method,
        payment_status,
        payment_date,
        transaction_reference,
        payment_amount
    )

    VALUES
    (
        p_order_row_id,
        p_payment_method,
        p_payment_status,
        p_payment_date,
        p_transaction_reference,
        p_payment_amount
    );

END;
$$;

-- =====================================================
-- Procedure 6
-- Register Return
-- Description: Register customer product return
-- =====================================================

CREATE OR REPLACE PROCEDURE register_return(

    p_order_row_id     INT,
    p_product_id       VARCHAR,
    p_return_date      DATE,
    p_return_reason    VARCHAR,
    p_refund_amount    DECIMAL(12,2),
    p_return_status    VARCHAR

)

LANGUAGE plpgsql

AS
$$

BEGIN

   IF p_refund_amount < 0 THEN
    RAISE EXCEPTION 'Refund amount cannot be negative.';
END IF;

    INSERT INTO returns
    (
        order_row_id,
        product_id,
        return_date,
        return_reason,
        refund_amount,
        return_status
    )

    VALUES
    (
        p_order_row_id,
        p_product_id,
        p_return_date,
        p_return_reason,
        p_refund_amount,
        p_return_status
    );

END;
$$;

-- =====================================================
-- Procedure 7
-- Add Customer Discount
-- Description: Assign a discount program to a customer
-- =====================================================

CREATE OR REPLACE PROCEDURE add_customer_discount(

    p_customer_id          VARCHAR,
    p_discount_type        VARCHAR,
    p_discount_percentage  DECIMAL(5,2),
    p_start_date           DATE,
    p_end_date             DATE

)

LANGUAGE plpgsql

AS
$$

BEGIN

    IF p_discount_percentage < 0
       OR p_discount_percentage > 100 THEN
        RAISE EXCEPTION 'Discount percentage must be between 0 and 100.';
    END IF;

    INSERT INTO customer_discounts
    (
        customer_id,
        discount_type,
        discount_percentage,
        start_date,
        end_date
    )

    VALUES
    (
        p_customer_id,
        p_discount_type,
        p_discount_percentage,
        p_start_date,
        p_end_date
    );

END;
$$;