-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 02_create_tables.sql
-- Description: Create Core Database Tables
-- Author: Shobha Saxena
-- ============================================

SET search_path TO public;

-- =====================================================
-- Table: customers
-- Description: Stores unique customer information
-- =====================================================

CREATE TABLE customers(
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    segment VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

   -- =====================================================
-- Table: products
-- Description: Stores unique product information
-- =====================================================

CREATE TABLE products(
    product_id VARCHAR(30) PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(50) NOT NULL,
    sub_category VARCHAR(50) NOT NULL,
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- Table: orders
-- Description: Stores order transactions
-- =====================================================

CREATE TABLE orders(
    row_id INT  PRIMARY KEY,
    order_id VARCHAR(30) NOT NULL UNIQUE,
    order_date DATE NOT NULL,
    ship_date DATE NOT NULL,
    ship_mode VARCHAR(50) NOT NULL,

    customer_id VARCHAR(20) NOT NULL,
    product_id VARCHAR(30) NOT NULL,

    country VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20),
    region VARCHAR(50) NOT NULL,

    sales DECIMAL(12,2) NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    discount DECIMAL(5,2) NOT NULL CHECK (discount >= 0 AND discount <= 1),
    profit DECIMAL(12,2) NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- Table: inventory
-- Description: Stores inventory information
-- =====================================================

CREATE TABLE inventory(
    inventory_id SERIAL PRIMARY KEY,
    product_id VARCHAR(30) NOT NULL,
    supplier_id INT,
    warehouse_name VARCHAR(100) NOT NULL,
    warehouse_location VARCHAR(100) NOT NULL,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    reorder_level INT NOT NULL CHECK (reorder_level >= 0),
    stock_status VARCHAR(30) NOT NULL CHECK (stock_status IN ('In Stock','Low Stock','Out of Stock')),
    last_restock_date DATE,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- Table: suppliers
-- Description: Stores supplier information
-- =====================================================

CREATE TABLE suppliers(
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    supplier_rating DECIMAL(3,2) NOT NULL CHECK (supplier_rating >= 0 AND supplier_rating <= 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- Table: transportation_logistics
-- Description: Stores shipment and delivery information
-- =====================================================

CREATE TABLE transportation_logistics(
    transport_id SERIAL PRIMARY KEY,
    order_id VARCHAR(30) NOT NULL,
    carrier_name VARCHAR(100) NOT NULL,
    tracking_number VARCHAR(100) UNIQUE,
    shipment_status VARCHAR(50) NOT NULL CHECK (shipment_status IN ('Pending','Shipped','In Transit','Delivered','Cancelled')),
    dispatch_date DATE,
    estimated_delivery_date DATE,
    actual_delivery_date DATE,
    delivery_cost DECIMAL(10,2) CHECK (delivery_cost >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- Table: payments
-- Description: Stores payment information
-- =====================================================

CREATE TABLE payments(
    payment_id SERIAL PRIMARY KEY,
    order_id VARCHAR(30) NOT NULL,
    payment_method VARCHAR(50) NOT NULL CHECK (payment_method IN ('Credit Card','Debit Card','UPI','Net Banking','Cash','Wallet')),
    payment_status VARCHAR(30) NOT NULL CHECK (payment_status IN ('Pending','Completed','Failed','Refunded')),
    payment_date DATE,
    transaction_reference VARCHAR(100) UNIQUE,
    payment_amount DECIMAL(12,2) NOT NULL CHECK (payment_amount >=0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- Table: returns
-- Description: Stores returned order information
-- =====================================================

CREATE TABLE returns(
    return_id SERIAL PRIMARY KEY,
    order_id VARCHAR(30) NOT NULL,
    product_id VARCHAR(30) NOT NULL,
    return_date DATE NOT NULL,
    return_reason VARCHAR(50) NOT NULL CHECK (return_reason IN ('Damaged Product','Wrong Item','Defective Product','Customer Changed Mind','Late Delivery','Other')),
    refund_amount DECIMAL(12,2) NOT NULL CHECK (refund_amount >=0),
    return_status VARCHAR(30) NOT NULL CHECK (return_status IN ('Requested','Approved','Rejected','Completed')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- Table: customer_discounts
-- Description: Stores customer discount programs
-- =====================================================

CREATE TABLE customer_discounts(
    discount_id SERIAL PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    discount_type VARCHAR(50) NOT NULL CHECK (discount_type IN ('Loyalty','Seasonal','Festival','Promotional','Coupon')),
    discount_percentage DECIMAL(5,2) NOT NULL CHECK (discount_percentage >=0 AND discount_percentage <=100),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL CHECK (end_date >= start_date),
    
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);