# Project Roadmap

## Project Objective

The objective of the Enterprise Retail Intelligence Platform is to build an end-to-end retail analytics solution that transforms raw retail data into actionable business insights.

## Phase 1 — Project Requirements

**Status: Completed**

- Defined the project objective
- Identified key business problems
- Defined analytical requirements
- Planned the technology stack
- Defined the expected Power BI dashboards

## Phase 2 — Data Collection

**Status: Completed**

- Organized the raw retail dataset
- Stored the original dataset in the `data/raw/` directory
- Reviewed the available business attributes

## Phase 3 — Data Cleaning and Validation

**Status: Completed**

- Performed initial data inspection
- Checked missing values
- Checked duplicate records
- Standardized text values
- Reviewed data types and formatting
- Performed data validation
- Created the cleaned Excel dataset

## Phase 4 — PostgreSQL Database Design

**Status: Completed**

- Created the PostgreSQL database structure
- Designed relational tables
- Defined primary keys and foreign keys
- Added constraints
- Added indexes
- Designed analytical views
- Added functions and stored procedures
- Added triggers
- Prepared dashboard-oriented SQL queries

## Phase 5 — ETL and Data Processing

**Status: Completed**

- Created SQL ETL scripts
- Loaded business entities into PostgreSQL
- Extracted analytical datasets using Python
- Organized extracted and processed datasets

## Phase 6 — Python Processing and EDA

**Status: Completed**

- Connected Python to PostgreSQL
- Extracted database data
- Performed preprocessing
- Performed exploratory data analysis
- Created engineered datasets
- Generated business-oriented analytical outputs

## Phase 7 — Power BI Development

**Status: Completed**

Created six interactive dashboards:

1. Executive Dashboard
2. Sales Analysis
3. Customer Analysis
4. Product Analysis
5. Inventory Analysis
6. Return Analysis

The dashboards include KPIs, filters, slicers, charts and analytical views for retail decision-making.

## Phase 8 — Dashboard Validation

**Status: Completed**

- Compared Power BI values with analytical results
- Validated KPI values
- Checked slicers and filters
- Reviewed dashboard visuals
- Verified year-based analysis
- Checked dashboard consistency

## Phase 9 — Documentation

**Status: Completed**

- Created project README
- Documented database design
- Defined KPIs
- Documented project roadmap
- Added dashboard screenshots
- Organized project structure

## Phase 10 — GitHub Portfolio

**Status: Completed**

- Organized the repository
- Added project documentation
- Added Power BI dashboard screenshots
- Added the Power BI `.pbix` file
- Added SQL scripts
- Protected environment variables using `.gitignore`
- Published the project to GitHub

## Future Improvements

Potential future enhancements include:

- Automated data refresh
- Additional customer segmentation
- Advanced inventory forecasting
- Automated dashboard refresh pipelines
- Additional machine learning use cases
- Deployment of the analytics solution in a cloud environment