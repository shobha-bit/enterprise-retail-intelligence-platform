# Database Design

## Overview

The Enterprise Retail Intelligence Platform uses PostgreSQL as the central relational database for storing and analyzing retail business data.

The database is designed to support:

- Sales analysis
- Customer analysis
- Product performance
- Inventory management
- Supplier analysis
- Transportation and logistics
- Payment analysis
- Return analysis
- Customer discount analysis

## Database Architecture

The database follows a relational structure where business entities are separated into logical tables and connected using primary and foreign key relationships.

The main analytical entities include:

- Customers
- Products
- Orders
- Inventory
- Suppliers
- Transportation
- Payments
- Returns
- Customer Discounts

## Core Tables

| Table | Purpose |
|---|---|
| `customers` | Stores customer information and customer-level attributes |
| `products` | Stores product, category and sub-category information |
| `orders` | Stores transaction and order-level information |
| `inventory` | Stores stock quantity, reorder levels and warehouse information |
| `suppliers` | Stores supplier information |
| `transportation` | Stores transportation and logistics information |
| `payments` | Stores payment-related transaction information |
| `returns` | Stores returned products and return reasons |
| `customer_discounts` | Stores customer discount information |

## Primary Keys

Each major business entity uses a unique identifier as its primary key.

Examples include:

- `customer_id`
- `product_id`
- `supplier_id`
- `order_id`
- `return_id`
- `payment_id`

Primary keys help uniquely identify records and maintain data integrity.

## Foreign Keys

Foreign keys connect related business entities.

Examples include:

- Orders → Customers
- Orders → Products
- Inventory → Products
- Inventory → Suppliers
- Returns → Orders
- Payments → Orders
- Customer Discounts → Customers

These relationships allow data from different business areas to be combined for analytical reporting.

## Database Development

The database was developed through a sequence of SQL scripts:

1. Database creation
2. Table creation
3. Constraints
4. Indexes
5. Views
6. Functions
7. Stored procedures
8. Sample queries
9. Triggers
10. Business reports
11. Advanced queries
12. Dashboard queries
13. Performance optimization

The ETL layer contains separate scripts for loading customers, products, orders, suppliers, inventory, transportation, payments, returns and customer discount data.

## Views

SQL views were created to simplify analytical reporting and provide reusable business-level datasets.

Examples include product performance and other dashboard-oriented analytical views.

The views are used to transform relational data into datasets that can be consumed by analytical tools such as Power BI.

## Indexing

Indexes were included to improve query performance on frequently accessed columns and relationships.

Indexes are particularly useful for:

- Primary and foreign key lookups
- Product-related queries
- Customer-related queries
- Order analysis
- Date-based analysis
- Dashboard queries

## Data Integrity

The database uses constraints and relational relationships to improve data quality and consistency.

These include:

- Primary key constraints
- Foreign key constraints
- Uniqueness constraints where required
- Appropriate data types
- Referential integrity

## Database and Power BI

PostgreSQL acts as the analytical data source for the project.

Power BI consumes prepared datasets and analytical structures from the database to create interactive dashboards for:

- Executive reporting
- Sales analysis
- Customer analysis
- Product analysis
- Inventory analysis
- Return analysis

## Design Objective

The database design aims to provide a structured, reusable and scalable foundation for retail analytics while keeping data organized across different business entities.