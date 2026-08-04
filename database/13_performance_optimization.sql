-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 13_performance_optimization.sql
-- Description: Performance Optimization
-- Author: Shobha Saxena
-- Version: 2.0
-- ============================================

SET search_path TO public;

-- ============================================
-- Performance Optimization 1
-- Update Table Statistics
-- ============================================

ANALYZE customers;
ANALYZE products;
ANALYZE orders;
ANALYZE suppliers;
ANALYZE inventory;
ANALYZE transportation;
ANALYZE payments;
ANALYZE returns;
ANALYZE customer_discounts;

-- ============================================
-- Performance Optimization 2
-- Vacuum Tables
-- ============================================

VACUUM ANALYZE customers;
VACUUM ANALYZE products;
VACUUM ANALYZE orders;
VACUUM ANALYZE suppliers;
VACUUM ANALYZE inventory;
VACUUM ANALYZE transportation;
VACUUM ANALYZE payments;
VACUUM ANALYZE returns;
VACUUM ANALYZE customer_discounts;

-- ============================================
-- Performance Optimization 3
-- Check Query Execution Plan
-- ============================================

EXPLAIN ANALYZE
SELECT
    customer_id,
    SUM(sales) AS total_sales
FROM orders
GROUP BY customer_id;

-- ============================================
-- Performance Optimization 4
-- Execution Plan for Product Sales
-- ============================================

EXPLAIN ANALYZE
SELECT
    p.product_name,
    SUM(o.sales) AS total_sales
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_name;

-- ============================================
-- Performance Optimization 5
-- Execution Plan for Dashboard Query
-- ============================================

EXPLAIN ANALYZE
SELECT
    region,
    SUM(sales) AS total_sales
FROM orders
GROUP BY region;

-- ============================================
-- Performance Optimization 6
-- Table Size
-- ============================================

SELECT
    relname AS table_name,
    pg_size_pretty(pg_total_relation_size(relid)) AS table_size
FROM pg_catalog.pg_statio_user_tables
ORDER BY pg_total_relation_size(relid) DESC;

-- ============================================
-- Performance Optimization 7
-- Index Usage
-- ============================================

SELECT
    relname AS table_name,
    indexrelname AS index_name,
    idx_scan AS index_scans
FROM pg_stat_user_indexes
ORDER BY idx_scan DESC;

-- ============================================
-- Performance Optimization 8
-- Database Size
-- ============================================

SELECT
    pg_database.datname AS database_name,
    pg_size_pretty(pg_database_size(pg_database.datname)) AS database_size
FROM pg_database
WHERE datname = current_database();

-- ============================================
-- Performance Optimization 9
-- Current Connections
-- ============================================

SELECT
    pid,
    usename,
    application_name,
    state
FROM pg_stat_activity
WHERE datname = current_database();

-- ============================================
-- Performance Optimization 10
-- Verify Indexes
-- ============================================

SELECT
    tablename,
    indexname
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename;