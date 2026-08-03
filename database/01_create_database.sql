-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 01_create_database.sql
-- Description: Creates the project database and schemas
-- Author: Shobha Saxena
-- Version: 2.0
-- ============================================

-- ============================================
-- STEP 1
-- Create Database
-- Run ONLY once
-- ============================================

CREATE DATABASE enterprise_retail_db;

-- ============================================
-- STEP 2
-- Connect to the database
--
-- After creating the database,
-- connect to enterprise_retail_db
-- before executing the remaining commands.
-- ============================================

-- ============================================
-- STEP 3
-- Create Schemas
-- ============================================

CREATE SCHEMA IF NOT EXISTS staging;

CREATE SCHEMA IF NOT EXISTS analytics;

-- public schema is created automatically by PostgreSQL.