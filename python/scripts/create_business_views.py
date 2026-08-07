"""
Enterprise Retail Intelligence Platform

Script: create_business_views.py

Purpose:
Create business views in PostgreSQL

Author: Shobha Saxena
"""

from sqlalchemy import text
from database_connection import engine


# ==========================================================
# Business Views
# ==========================================================

views = {

    "vw_sales_summary": """
        CREATE VIEW vw_sales_summary AS
        SELECT
            region,
            COUNT(order_id) AS total_orders,
            SUM(sales) AS total_sales,
            ROUND(AVG(sales)::numeric, 2) AS average_sales
        FROM orders_engineered
        GROUP BY region;
    """,

    "vw_monthly_sales": """
        CREATE VIEW vw_monthly_sales AS
        SELECT
            order_year,
            order_month,
            SUM(sales) AS total_sales
        FROM orders_engineered
        GROUP BY order_year, order_month
        ORDER BY order_year, order_month;
    """,

    "vw_customer_sales": """
        CREATE VIEW vw_customer_sales AS
        SELECT
            customer_id,
            customer_total_sales,
            order_frequency
        FROM orders_engineered
        ORDER BY customer_total_sales DESC;
    """,

    "vw_ship_mode_analysis": """
        CREATE VIEW vw_ship_mode_analysis AS
        SELECT
            ship_mode,
            COUNT(*) AS total_orders,
            ROUND(AVG(delivery_days)::numeric,2) AS avg_delivery_days
        FROM orders_engineered
        GROUP BY ship_mode;
    """,

    "vw_high_value_orders": """
        CREATE VIEW vw_high_value_orders AS
        SELECT
            order_id,
            customer_id,
            sales,
            sales_category,
            high_value_order
        FROM orders_engineered
        WHERE high_value_order = TRUE;
    """
}


# ==========================================================
# Create Views
# ==========================================================

with engine.begin() as conn:

    print("=" * 60)
    print("CREATING BUSINESS VIEWS")
    print("=" * 60)

    for view_name, query in views.items():

        print(f"\nCreating {view_name}...")

        conn.execute(text(f"DROP VIEW IF EXISTS {view_name} CASCADE;"))

        conn.execute(text(query))

        print(f"✅ {view_name} created successfully")

print("\n" + "=" * 60)
print("ALL BUSINESS VIEWS CREATED SUCCESSFULLY")
print("=" * 60)