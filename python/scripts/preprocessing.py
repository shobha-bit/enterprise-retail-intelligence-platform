"""
=========================================================
Enterprise Retail Intelligence Platform

Script : preprocessing.py

Purpose:
Reusable data preprocessing functions

Author : Shobha Saxena
=========================================================
"""

import pandas as pd


# =========================================================
# Convert Date Columns
# =========================================================

def convert_date_columns(df, date_columns):
    """
    Convert specified columns to datetime.
    """

    for col in date_columns:
        if col in df.columns:
            df[col] = pd.to_datetime(df[col], errors="coerce")

    return df


# =========================================================
# Check Missing Values
# =========================================================

def check_missing_values(df):
   """
    Return missing values count for each column.
    """ 
   return df.isnull().sum()


# =========================================================
# Remove Duplicate Rows
# =========================================================

def remove_duplicates(df):
    """
    Remove duplicate rows.
    """

    return df.drop_duplicates().reset_index(drop=True)


# =========================================================
# Dataset Summary
# =========================================================

def dataset_summary(df):
    """
    Return dataset summary.
    """

    summary = pd.DataFrame({
        "Metric": [
            "Rows",
            "Columns",
            "Missing Values",
            "Duplicate Rows"
        ],
        "Value": [
            len(df),
            len(df.columns),
            df.isnull().sum().sum(),
            df.duplicated().sum()
        ]
    })

    return summary


# =========================================================
# Standardize Text Columns
# =========================================================

def standardize_text(df, columns):
    """
    Standardize text columns.
    """

    for col in columns:

        if col in df.columns:

            df[col] = (
                df[col]
                .fillna("")
                .astype(str)
                .str.strip()
                .str.title()
            )

    return df


# =========================================================
# Test
# =========================================================

if __name__ == "__main__":

    from extract_data import load_orders

    orders_df = load_orders()

    orders_df = convert_date_columns(
        orders_df,
        ["order_date", "ship_date", "created_at"]
    )

    print(dataset_summary(orders_df))



