import os
import psycopg2
from dotenv import load_dotenv

# Load environment variables
load_dotenv(r"python\.env")

# Database connection
conn = psycopg2.connect(
    host=os.getenv("DB_HOST"),
    port=os.getenv("DB_PORT"),
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD")
)

cur = conn.cursor()

# Business views to validate
business_views = [
    "vw_customer_discount_summary",
    "vw_customer_sales",
    "vw_customer_summary",
    "vw_high_value_orders",
    "vw_inventory_status",
    "vw_monthly_sales",
    "vw_payment_summary",
    "vw_product_performance",
    "vw_product_performance_yearly",
    "vw_return_summary",
    "vw_sales_summary",
    "vw_sales_summary_yearly",
    "vw_ship_mode_analysis",
    "vw_supplier_performance",
    "vw_transportation_summary"
]

print("=" * 70)
print("BUSINESS VIEW DATA VALIDATION")
print("=" * 70)

for view_name in business_views:

    try:
        cur.execute(f"""
            SELECT COUNT(*)
            FROM public."{view_name}";
        """)

        row_count = cur.fetchone()[0]

        print(f"\n{view_name}")
        print(f"Rows: {row_count}")

        if row_count > 0:
            print("Status: ✅ Data available")
        else:
            print("Status: ⚠️ View is empty")

    except Exception as e:
        print(f"\n{view_name}")
        print(f"Status: ❌ Error")
        print(f"Error: {e}")

        conn.rollback()

print("\n" + "=" * 70)
print("VALIDATION COMPLETED")
print("=" * 70)

cur.close()
conn.close()