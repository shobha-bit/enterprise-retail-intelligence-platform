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

# Get all views from public schema
cur.execute("""
    SELECT table_name
    FROM information_schema.views
    WHERE table_schema = 'public'
    ORDER BY table_name;
""")

views = cur.fetchall()

print("=" * 60)
print("BUSINESS VIEW VERIFICATION")
print("=" * 60)

if views:
    print("\nViews found:\n")

    for view in views:
        print("✅", view[0])

else:
    print("\n❌ No views found.")

print("\n" + "=" * 60)

cur.close()
conn.close()