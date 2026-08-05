-- ============================================
-- Enterprise Retail Intelligence Platform
-- File: 17_load_suppliers.sql
-- Description: Load Supplier Master Data
-- Author: Shobha Saxena
-- Version: 2.0
-- ============================================

SET search_path TO public;

-- ============================================
-- Clear Existing Data
-- ============================================

TRUNCATE TABLE suppliers RESTART IDENTITY CASCADE;

-- ============================================
-- Load Supplier Master Data
-- ============================================

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
'Elite Furniture Suppliers',
'Michael Johnson',
'+1-212-555-1001',
'michael.johnson@elitefurniture.com',
'New York',
'USA',
4.8
),

(
'Comfort Seating Pvt Ltd',
'Sarah Williams',
'+1-312-555-1002',
'sarah.williams@comfortseating.com',
'Chicago',
'USA',
4.7
),

(
'Home Decor Industries',
'David Anderson',
'+1-213-555-1003',
'david.anderson@homedecor.com',
'Los Angeles',
'USA',
4.6
),

(
'Modern Office Furniture',
'Emily Brown',
'+1-214-555-1004',
'emily.brown@modernoffice.com',
'Dallas',
'USA',
4.9
),

(
'Smart Appliance Distributors',
'Daniel Miller',
'+1-408-555-1005',
'daniel.miller@smartappliances.com',
'San Jose',
'USA',
4.8
),

(
'Creative Art Supplies',
'Jessica Wilson',
'+1-617-555-1006',
'jessica.wilson@creativeart.com',
'Boston',
'USA',
4.5
),

(
'Office Filing Solutions',
'Matthew Davis',
'+1-313-555-1007',
'matthew.davis@officefiling.com',
'Detroit',
'USA',
4.6
),

(
'Premium Paper Products',
'Ashley Moore',
'+1-404-555-1008',
'ashley.moore@premiumpaper.com',
'Atlanta',
'USA',
4.7
),

(
'Industrial Fasteners Co.',
'Christopher Taylor',
'+1-713-555-1009',
'chris.taylor@fastenersco.com',
'Houston',
'USA',
4.4
),

(
'LabelTech India',
'Priya Sharma',
'+91-9810010010',
'priya.sharma@labeltech.com',
'Delhi',
'India',
4.8
),

(
'National Paper Mills',
'Rajesh Gupta',
'+91-9810010011',
'rajesh.gupta@papermills.com',
'Mumbai',
'India',
4.9
),

(
'Secure Storage Systems',
'Amit Verma',
'+91-9810010012',
'amit.verma@securestorage.com',
'Bengaluru',
'India',
4.7
),

(
'Office Essentials Ltd',
'Neha Kapoor',
'+91-9810010013',
'neha.kapoor@officeessentials.com',
'Pune',
'India',
4.6
),

(
'Tech Accessories Hub',
'Kevin White',
'+1-206-555-1014',
'kevin.white@techhub.com',
'Seattle',
'USA',
4.8
),

(
'Global Copier Solutions',
'Brian Scott',
'+1-602-555-1015',
'brian.scott@globalcopier.com',
'Phoenix',
'USA',
4.7
),

(
'Business Machine Corp',
'Olivia Harris',
'+1-305-555-1016',
'olivia.harris@businessmachine.com',
'Miami',
'USA',
4.9
),

(
'Mobile Tech Distributors',
'Ryan Clark',
'+1-415-555-1017',
'ryan.clark@mobiletech.com',
'San Francisco',
'USA',
4.9
);

-- ============================================
-- Verification 1
-- ============================================

SELECT COUNT(*) AS total_suppliers
FROM suppliers;

-- ============================================
-- Verification 2
-- ============================================

SELECT
country,
COUNT(*) AS total_suppliers
FROM suppliers
GROUP BY country
ORDER BY total_suppliers DESC;

-- ============================================
-- Verification 3
-- ============================================

SELECT
ROUND(AVG(supplier_rating),2) AS average_supplier_rating
FROM suppliers;

-- ============================================
-- Verification 4
-- ============================================

SELECT *
FROM suppliers
ORDER BY supplier_id;