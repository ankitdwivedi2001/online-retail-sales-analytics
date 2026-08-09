# Online Retail Sales & Customer Analytics

## Overview

An end-to-end analytics project analysing transaction data from a UK-based online gift retailer - cleaning the raw data, loading it into a relational database, writing SQL analysis, and building an interactive Power BI dashboard connected live to the database.

## Dataset

- **Online Retail Dataset** (Kaggle, by Ulrik Thyge Pedersen) - real transaction data from a UK online retailer
- ~541,909 rows before cleaning
- Columns: InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country

## Data Cleaning (Excel)

- Found 135,080 rows with blank CustomerID - kept them, but filtered out for any customer-level analysis
- Found 10,624 cancellation rows (InvoiceNo starting with "C", representing returns/negative quantity) - kept for return-analysis purposes but excluded from total sales figures
- Removed 5,268 exact duplicate rows
- Fixed InvoiceDate, which was stored as text, into a proper date format

## Database & SQL

- Loaded the cleaned data (536,641 rows) into MySQL using `LOAD DATA LOCAL INFILE`, after the Table Data Import Wizard proved too slow for a dataset this size
- Fixed a hidden BOM character in the InvoiceNo column name, and converted InvoiceDate into a proper DATETIME column
- Wrote SQL queries to analyse:
  - Total revenue (excluding cancellations)
  - Revenue by month
  - Top-selling products (excluding non-product codes like POST, DOT, BANK CHARGES)
  - Top countries by revenue
  - Top customers by revenue (excluding guest/unidentified purchases)

Full queries are in [`online_retail_analysis.sql`](online_retail_analysis.sql).

## Dashboard (Power BI)

Built an interactive Power BI dashboard connected live to the MySQL database, with KPI cards, Top-N filtering, and cross-filtering across all visuals - so clicking one chart filters the rest automatically.

## Key Findings

- Total revenue (excluding cancellations): **£9,726,006.95**
- The UK dominates both revenue and order volume overall
- Customers from the Netherlands and Ireland show much higher average order values than customers from Germany or France
- A customer-concentration risk: a single customer in the Netherlands accounted for roughly **£280,000** in revenue - over half of that country's total sales - meaning a large chunk of one country's revenue depends on one buyer

## Tools & Technologies

- Excel - data cleaning
- MySQL - database, data loading, SQL analysis
- Power BI - live-connected interactive dashboard
