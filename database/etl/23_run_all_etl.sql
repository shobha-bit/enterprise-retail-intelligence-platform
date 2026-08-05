-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 23_run_all_etl.sql
-- Description : Master ETL Execution Script
-- Author      : Shobha Saxena
-- Version     : 1.0
-- ============================================

SET search_path TO public;

-- ==========================================================
-- MASTER ETL EXECUTION ORDER
-- ==========================================================
--
-- This project is developed using pgAdmin.
--
-- Execute the following ETL files ONE BY ONE
-- in the exact order shown below.
--
-- ==========================================================

-- Step 01
-- Load Customers
-- File : 14_load_customers.sql

-- Step 02
-- Load Products
-- File : 15_load_products.sql

-- Step 03
-- Load Orders
-- File : 16_load_orders.sql

-- Step 04
-- Load Suppliers
-- File : 17_load_suppliers.sql

-- Step 05
-- Load Inventory
-- File : 18_load_inventory.sql

-- Step 06
-- Load Transportation Logistics
-- File : 19_load_transportation.sql

-- Step 07
-- Load Payments
-- File : 20_load_payments.sql

-- Step 08
-- Load Returns
-- File : 21_load_returns.sql

-- Step 09
-- Load Customer Discounts
-- File : 22_load_customer_discounts.sql

-- ==========================================================
-- ETL EXECUTION COMPLETED
-- ==========================================================
--
-- After executing all ETL files, verify the data:
--
-- Customers                 : 793
-- Products                  : 1861
-- Orders                    : 9800
-- Suppliers                 : 17
-- Inventory                 : 1861
-- Payments                  : 9800
-- Transportation Logistics  : 9800
-- Returns                   : 490
-- Customer Discounts        : 793
--
-- ==========================================================
-- Next Phase
--
-- Python + Pandas
-- PostgreSQL Connection
-- Exploratory Data Analysis
-- Feature Engineering
-- Power BI Dashboard
-- ==========================================================