"""
=========================================================
Enterprise Retail Intelligence Platform

Script : feature_engineering.py

Purpose:
Create business features for analytics and dashboards

Author : Shobha Saxena
=========================================================
"""

import pandas as pd
from utils import save_csv, print_title

from extract_data import (
    load_orders,
    load_products,
    load_returns,
    load_transportation,
    load_customer_discounts
)

# =========================================================
# Load Data
# =========================================================

orders_df = load_orders()

products_df = load_products()

returns_df = load_returns()

transportation_df = load_transportation()

discount_df = load_customer_discounts()

from preprocessing import convert_date_columns

# =========================================================
# Convert Date Columns
# =========================================================

orders_df = convert_date_columns(
    orders_df,
    ["order_date", "ship_date", "created_at"]
)

returns_df = convert_date_columns(
    returns_df,
    ["return_date", "created_at"]
)

transportation_df = convert_date_columns(
    transportation_df,
    [
        "dispatch_date",
        "actual_delivery_date",
        "created_at"
    ]
)

# =========================================================
# Feature 1 : Delivery Days
# =========================================================

orders_df["delivery_days"] = (
    orders_df["ship_date"] -
    orders_df["order_date"]
).dt.days

# =========================================================
# Feature 2 : Order Month
# =========================================================

orders_df["order_month"] = (
    orders_df["order_date"]
    .dt.month_name()
)

# =========================================================
# Feature 3 : Order Quarter
# =========================================================

orders_df["order_quarter"] = (
    "Q" +
    orders_df["order_date"]
    .dt.quarter
    .astype(str)
)

# =========================================================
# Feature 4 : Order Year
# =========================================================

orders_df["order_year"] = (
    orders_df["order_date"]
    .dt.year
)

print(
    orders_df[
        [
            "order_date",
            "ship_date",
            "delivery_days",
            "order_month",
            "order_quarter",
            "order_year"
        ]
    ].head()
)

# =========================================================
# Feature 5 : Weekend Order
# =========================================================

orders_df["weekend_order"] = (
    orders_df["order_date"]
    .dt.dayofweek
    .isin([5, 6])
)

# =========================================================
# Feature 6 : High Value Order
# =========================================================

orders_df["high_value_order"] = (
    orders_df["sales"] >= 500
)

# =========================================================
# Feature 7 : Sales Category
# =========================================================

orders_df["sales_category"] = pd.cut(
    orders_df["sales"],
    bins=[0, 100, 500, float("inf")],
    labels=["Low", "Medium", "High"]
)

# =========================================================
# Feature 8 : Order Frequency
# =========================================================

orders_df["order_frequency"] = (
    orders_df
    .groupby("customer_id")["order_id"]
    .transform("count")
)

print(
    orders_df[
        [
            "sales",
            "weekend_order",
            "high_value_order",
            "sales_category",
            "order_frequency"
        ]
    ].head()
)

# =========================================================
# Feature 9 : Customer Total Sales
# =========================================================

orders_df["customer_total_sales"] = (
    orders_df
    .groupby("customer_id")["sales"]
    .transform("sum")
)

# =========================================================
# Feature 9 : Customer Total Sales
# =========================================================

orders_df["customer_total_sales"] = (
    orders_df
    .groupby("customer_id")["sales"]
    .transform("sum")
)

# =========================================================
# Feature 11 : Return Flag
# =========================================================

returned_orders = returns_df["order_row_id"].unique()

orders_df["return_flag"] = (
    orders_df["row_id"]
    .isin(returned_orders)
)

# =========================================================
# Feature 12 : Transportation Efficiency
# =========================================================

transportation_df["delivery_days"] = (
    transportation_df["actual_delivery_date"] -
    transportation_df["dispatch_date"]
).dt.days

transportation_df["late_delivery"] = (
    transportation_df["delivery_days"] > 5
)

print("\nOrders Features\n")

print(
    orders_df[
        [
            "delivery_days",
            "order_month",
            "order_quarter",
            "order_year",
            "weekend_order",
            "high_value_order",
            "sales_category",
            "order_frequency",
            "customer_total_sales",
            "return_flag"
        ]
    ].head()
)

print("\nTransportation Features\n")

print(
    transportation_df[
        [
            "delivery_days",
            "late_delivery"
        ]
    ].head()
)

print(orders_df.columns.tolist())

# ============================================================
# Save Engineered Dataset
# ============================================================

print_title("Saving Engineered Dataset")

save_csv(
    orders_df,
    "data/engineered/orders_engineered.csv"
)

print_title("Feature Engineering Completed Successfully!")

print("\nAll columns in orders_df:")
print(orders_df.columns.tolist())

import inspect

print("\nRunning file:")
print(inspect.getfile(inspect.currentframe()))