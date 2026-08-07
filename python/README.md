# Python ETL & Analytics Pipeline

This directory contains the Python modules, scripts, and notebooks responsible for extracting, transforming, analyzing, and preparing retail data for reporting within the **Enterprise Retail Intelligence Platform**.

---

## 📖 Overview

The Python pipeline automates the complete data preparation process, converting raw retail datasets into structured, analysis-ready data that powers PostgreSQL reporting and Power BI dashboards.

The workflow includes:

- Data extraction
- Data cleaning and preprocessing
- Exploratory Data Analysis (EDA)
- Feature engineering
- Business insight generation
- PostgreSQL integration
- Business reporting views
- Reusable scripts and notebooks

---

# 📁 Directory Structure

```text
python/
│
├── data/
│   ├── extracted/
│   │   ├── customers.csv
│   │   ├── customer_discounts.csv
│   │   ├── inventory.csv
│   │   ├── orders.csv
│   │   ├── payments.csv
│   │   ├── products.csv
│   │   ├── returns.csv
│   │   ├── suppliers.csv
│   │   └── transportation_logistics.csv
│   │
│   ├── processed/
│   │   ├── customers.csv
│   │   ├── customer_discounts.csv
│   │   ├── inventory.csv
│   │   ├── orders.csv
│   │   ├── orders_engineered.csv
│   │   ├── payments.csv
│   │   ├── products.csv
│   │   ├── returns.csv
│   │   ├── suppliers.csv
│   │   ├── superstore_cleaned.csv
│   │   ├── transportation.csv
│   │   └── transportation_engineered.csv
│   │
│   └── engineered/
│       ├── orders_engineered.csv
│       └── transportation_engineered.csv
│
├── notebooks/
│   ├── 01_database_connection.ipynb
│   ├── 02_data_extraction.ipynb
│   ├── 03_data_cleaning.ipynb
│   ├── 04_exploratory_data_analysis.ipynb
│   ├── 05_feature_engineering.ipynb
│   └── 06_business_insights.ipynb
│
└── scripts/
    ├── create_business_views.py
    ├── database_connection.py
    ├── extract_data.py
    ├── feature_engineering.py
    ├── load_engineered_data.py
    ├── preprocessing.py
    └── utils.py
```

---

# 🔄 Data Processing Workflow

```text
Raw Data
   │
   ▼
Data Extraction
   │
   ▼
Data Cleaning & Validation
   │
   ▼
Processed Dataset
   │
   ▼
Feature Engineering
   │
   ▼
Engineered Dataset
   │
   ▼
Exploratory Data Analysis
   │
   ▼
Business Insights
   │
   ▼
PostgreSQL Business Views
   │
   ▼
Power BI Dashboard
```

---

# 📚 Jupyter Notebooks

| Notebook | Description |
|----------|-------------|
| `01_database_connection.ipynb` | Tests and validates PostgreSQL database connectivity |
| `02_data_extraction.ipynb` | Extracts retail datasets from PostgreSQL |
| `03_data_cleaning.ipynb` | Cleans and preprocesses raw datasets |
| `04_exploratory_data_analysis.ipynb` | Performs statistical analysis and visualization |
| `05_feature_engineering.ipynb` | Creates derived features for advanced analytics |
| `06_business_insights.ipynb` | Generates business-focused insights and findings |

---

# ⚙️ Python Scripts

### `database_connection.py`

Creates and manages database connections using SQLAlchemy.

### `extract_data.py`

Exports required business tables from PostgreSQL into CSV format.

### `preprocessing.py`

Performs reusable cleaning, transformation, and preprocessing operations.

### `feature_engineering.py`

Builds additional analytical features from processed datasets.

### `load_engineered_data.py`

Loads engineered datasets back into PostgreSQL.

### `create_business_views.py`

Creates SQL views optimized for reporting and dashboard visualization.

### `utils.py`

Contains common utility functions shared across the project.

---

# 🛠️ Technology Stack

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- SQLAlchemy
- PostgreSQL
- Jupyter Notebook

---

# 🔐 Environment Variables

Database credentials are stored securely in a local `.env` file and should never be committed to version control.

Example configuration:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=enterprise_retail_db
DB_USER=postgres
DB_PASSWORD=your_password
```

---

# ▶️ Running the Pipeline

### Test database connection

```bash
python python/scripts/database_connection.py
```

### Extract datasets

```bash
python python/scripts/extract_data.py
```

### Run preprocessing

```bash
python python/scripts/preprocessing.py
```

### Generate engineered features

```bash
python python/scripts/feature_engineering.py
```

### Load engineered datasets

```bash
python python/scripts/load_engineered_data.py
```

### Create reporting views

```bash
python python/scripts/create_business_views.py
```

---

# 📈 Pipeline Outputs

The pipeline generates:

- Extracted datasets
- Cleaned datasets
- Processed datasets
- Engineered datasets
- Exploratory analysis reports
- Business insights
- PostgreSQL reporting views

These outputs provide the foundation for interactive Power BI dashboards and business reporting.

---

# 🎯 Project Contribution

The Python layer serves as the ETL and analytics engine of the **Enterprise Retail Intelligence Platform**, transforming raw retail data into meaningful insights and preparing optimized datasets for PostgreSQL reporting and Power BI visualization.