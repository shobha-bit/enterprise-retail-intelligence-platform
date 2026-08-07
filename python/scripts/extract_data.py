"""
=========================================================
Enterprise Retail Intelligence Platform

Script : extract_data.py

Purpose:
Load processed datasets into pandas DataFrames.

Author : Shobha Saxena
=========================================================
"""

from pathlib import Path
import pandas as pd


# =========================================================
# Project Paths
# =========================================================

PROJECT_ROOT = Path(__file__).resolve().parents[1]

DATA_PATH = PROJECT_ROOT / "data" / "processed"


# =========================================================
# Load Functions
# =========================================================

def load_customers():
    return pd.read_csv(DATA_PATH / "customers.csv")


def load_products():
    return pd.read_csv(DATA_PATH / "products.csv")


def load_orders():
    return pd.read_csv(DATA_PATH / "orders.csv")


def load_suppliers():
    return pd.read_csv(DATA_PATH / "suppliers.csv")


def load_inventory():
    return pd.read_csv(DATA_PATH / "inventory.csv")


def load_transportation():
    return pd.read_csv(DATA_PATH / "transportation.csv")


def load_payments():
    return pd.read_csv(DATA_PATH / "payments.csv")


def load_returns():
    return pd.read_csv(DATA_PATH / "returns.csv")


def load_customer_discounts():
    return pd.read_csv(DATA_PATH / "customer_discounts.csv")


# =========================================================
# Test
# =========================================================

if __name__ == "__main__":

    orders = load_orders()

    print("=" * 50)
    print("Orders Loaded Successfully")
    print("=" * 50)

    print(orders.head())