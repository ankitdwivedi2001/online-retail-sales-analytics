-- Online Retail Sales Analysis
-- Database: online_retail | Table: sales
-- Columns: InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country

-- ============================================
-- 1. Total Revenue (excluding cancellations)
-- Cancellations are identified by InvoiceNo starting with "C"
-- ============================================
SELECT
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue
FROM sales
WHERE InvoiceNo NOT LIKE 'C%';


-- ============================================
-- 2. Revenue by Month
-- ============================================
SELECT
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS monthly_revenue
FROM sales
WHERE InvoiceNo NOT LIKE 'C%'
GROUP BY month
ORDER BY month;


-- ============================================
-- 3. Top-Selling Products
-- Excludes non-product codes (postage, bank charges, etc.)
-- ============================================
SELECT
    StockCode,
    Description,
    SUM(Quantity) AS total_units_sold,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue
FROM sales
WHERE InvoiceNo NOT LIKE 'C%'
  AND StockCode NOT IN ('POST', 'DOT', 'M', 'BANK CHARGES', 'PADS', 'CRUK')
GROUP BY StockCode, Description
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================
-- 4. Top Countries by Revenue
-- ============================================
SELECT
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    ROUND(SUM(Quantity * UnitPrice) / COUNT(DISTINCT InvoiceNo), 2) AS avg_order_value
FROM sales
WHERE InvoiceNo NOT LIKE 'C%'
GROUP BY Country
ORDER BY total_revenue DESC;


-- ============================================
-- 5. Top Customers by Revenue
-- Excludes blank/guest CustomerID (NULL or 0)
-- ============================================
SELECT
    CustomerID,
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue
FROM sales
WHERE InvoiceNo NOT LIKE 'C%'
  AND CustomerID IS NOT NULL
  AND CustomerID != 0
GROUP BY CustomerID, Country
ORDER BY total_revenue DESC
LIMIT 10;
