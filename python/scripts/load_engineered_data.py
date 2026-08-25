"""
Enterprise Retail Intelligence Platform

Script : load_engineered_data.py

Purpose:
Load engineered dataset into PostgreSQL

Author : Shobha Saxena
"""

import pandas as pd
from sqlalchemy import create_engine, text
from dotenv import load_dotenv
import os

# =========================================================
# Load Environment Variables
# =========================================================

load_dotenv("python/.env")

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

DATABASE_URL = (
    f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@"
    f"{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

engine = create_engine(DATABASE_URL)

# =========================================================
# Read Engineered Dataset
# =========================================================

orders_df = pd.read_csv(
    "data/engineered/orders_engineered.csv"
)

# =========================================================
# Load Data Without Dropping Dependent Views
# =========================================================

with engine.begin() as conn:

    print("=" * 60)
    print("LOADING ENGINEERED DATA")
    print("=" * 60)

    # Remove existing rows but keep the table structure
    conn.execute(
        text("TRUNCATE TABLE orders_engineered;")
    )

    print("Existing engineered data cleared.")

    # Insert fresh engineered dataset
    orders_df.to_sql(
        "orders_engineered",
        conn,
        if_exists="append",
        index=False
    )

print("=" * 60)
print("Orders Engineered Table Loaded Successfully")
print("=" * 60)

print(f"Rows Loaded : {len(orders_df)}")
print(f"Columns     : {len(orders_df.columns)}")

print("=" * 60)