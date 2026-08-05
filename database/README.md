# Database

## Overview

This folder contains all PostgreSQL database scripts used in the Enterprise Retail Intelligence Platform project.

The database is designed to simulate a real-world retail business environment and supports end-to-end data analysis, reporting, and dashboard creation.

---

## Database Tables

| Table | Description |
|-------|-------------|
| customers | Customer master information |
| products | Product catalog |
| orders | Sales transaction data |
| suppliers | Supplier master data |
| inventory | Inventory management records |
| transportation_logistics | Shipment and delivery tracking |
| payments | Customer payment records |
| returns | Product return records |
| customer_discounts | Customer discount information |

---

## ETL Execution Order

Execute the SQL scripts in the following order:

1. 14_load_customers.sql
2. 15_load_products.sql
3. 16_load_orders.sql
4. 17_load_suppliers.sql
5. 18_load_inventory.sql
6. 19_load_transportation.sql
7. 20_load_payments.sql
8. 21_load_returns.sql
9. 22_load_customer_discounts.sql

### Master Script

After executing all individual ETL scripts, run:

**23_run_all_etl.sql**

This script verifies that all ETL processes have completed successfully and validates the final record counts.

---

## Final Record Counts

| Table | Records |
|-------|--------:|
| Customers | 793 |
| Products | 1861 |
| Orders | 9800 |
| Suppliers | 17 |
| Inventory | 1861 |
| Transportation Logistics | 9800 |
| Payments | 9800 |
| Returns | 490 |
| Customer Discounts | 793 |

---

## Technologies Used

- PostgreSQL
- SQL
- Relational Database Design
- Primary Keys
- Foreign Keys
- Constraints
- ETL Scripts

---

## Author

**Shobha Saxena**

Enterprise Retail Intelligence Platform