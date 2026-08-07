"""
Enterprise Retail Intelligence Platform

Script : utils.py

Purpose:
Reusable helper functions

Author : Shobha Saxena
"""

import os
import pandas as pd


def create_folder(path):
    """Create folder if it doesn't exist."""
    os.makedirs(path, exist_ok=True)


def save_csv(df, filepath):
    """Save dataframe to CSV."""
    create_folder(os.path.dirname(filepath))
    df.to_csv(filepath, index=False)
    print(f"Saved -> {filepath}")


def save_excel(df, filepath):
    """Save dataframe to Excel."""
    create_folder(os.path.dirname(filepath))
    df.to_excel(filepath, index=False)
    print(f"Saved -> {filepath}")


def print_title(title):
    print("\n" + "=" * 60)
    print(title)
    print("=" * 60)