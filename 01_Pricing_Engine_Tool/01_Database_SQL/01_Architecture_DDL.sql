/*
   PROJECT: AUTOMOTIVE PRICING ENGINE
   SCRIPT: 01_Database_Architecture_DDL.sql
   BUSINESS CONTEXT (Marketing & Pricing Department Perspective): 

   This model is designed specifically for Pricing Analysis and Profitability. 
   Data populating these tables will be sourced and integrated from other 
   departments (e.g., Purchasing for Landed Costs, Sales for Transactions, 
   Finance for Customer Credit Tiers).

   PRICING STRATEGY NOTE (Discount Stacking Control):
   This architecture handles two distinct, stackable types of discounts to 
   protect the company's Gross Margin:
   1. Customer Quality Discount: Tier-based loyalty discount.
   2. Volume Discount: Transaction-based discount for large quantity orders.
   =============================================================================
*/

CREATE DATABASE Pricing_Engine_Project;
GO

USE Pricing_Engine_Project;
GO

-- 1. DIMENSION TABLES (The "Edges" of the Star)
-- 1.1 Products Dimension

CREATE TABLE Dim_Products (
    product_id NVARCHAR(50) NOT NULL PRIMARY KEY,
    sku_code NVARCHAR(50) NOT NULL,
    product_name NVARCHAR(150) NOT NULL,
    category_rotation NVARCHAR(50),         --  'High Rotation', 'Low Rotation'
    landed_cost DECIMAL(10, 2),             -- The final cost including taxes/freight
    competitor_market_price DECIMAL(10, 2), -- For B2C traffic light logic
    days_in_stock INT,
    quality_tier NVARCHAR(50)
);

-- 1.2 Customers Dimension
/* NOTE: Target discounts and tiers (Gold/Silver/Bronze) are determined by the 
   Finance Department based on credit history and B2B/B2C status (Company vs Individual). 
   Pricing department relies on these static tiers but does not manage them.
*/
CREATE TABLE Dim_Customers (
    customer_id NVARCHAR(50) NOT NULL PRIMARY KEY,
    customer_name NVARCHAR(100),
    customer_segment NVARCHAR(20),            -- 'B2B' or 'B2C'
    discount_tier NVARCHAR(20),               -- 'Gold', 'Silver', 'Bronze', 'New'
    target_discount_pct DECIMAL(5, 4),        -- e.g., 0.0500 for 5%
    max_authorized_discount_pct DECIMAL(5, 4) -- e.g., 0.1200 for 12%
);

-- 1.3 Suppliers Dimension
CREATE TABLE Dim_Suppliers (
    supplier_id NVARCHAR(50) NOT NULL PRIMARY KEY,
    supplier_name NVARCHAR(100) NOT NULL,
    origin_country NVARCHAR(50),
    currency NVARCHAR(10)                     -- e.g., 'USD', 'CNY', 'EUR'
);

-- 1.4 Discount Volume Brackets Dimension (Rules for volume)
/* NOTE: Strictly managed by the Pricing/Marketing team. We set these thresholds 
   because we monitor the Landed Costs and must cap the Volume Discount (e.g., at 8%) 
   to ensure that when stacked with the Customer Tier discount, the overall Gross 
   Margin remains profitable.
*/
CREATE TABLE Dim_Volume_Discount_Brackets (
    bracket_id INT NOT NULL PRIMARY KEY,
    min_quantity INT NOT NULL,
    max_quantity INT NOT NULL,
    granted_discount_pct DECIMAL(5, 4)
);

-- 1.5 Calendar Dimension
-- Note: Usually created in Power BI with DAX, but good to have the structure if needed in SQL.
CREATE TABLE Dim_Calendar (
    date_id DATE NOT NULL PRIMARY KEY,
    year_num INT,
    month_num INT,
    month_name NVARCHAR(20),
    quarter_name NVARCHAR(10)
);

-- =======================================================
-- 2. FACT TABLE (The "Center" of the Star)
-- 2.1 Sales Fact Table
/*
   NOTE: This table centralizes the transaction. It links the Customer (who brings 
   their Tier discount) with the Volume Bracket (which applies the quantity discount), 
   allowing the BI layer to calculate the final 'Pocket Price' and 'Margin Leakage'.
*/
CREATE TABLE Fact_Sales (
    order_id NVARCHAR(50) NOT NULL,
    date_id DATE NOT NULL,
    customer_id NVARCHAR(50) NOT NULL,
    product_id NVARCHAR(50) NOT NULL,
    supplier_id NVARCHAR(50) NOT NULL,
    bracket_id INT NOT NULL,
    quantity_sold INT NOT NULL,
    unit_price_sold DECIMAL(10, 2) NOT NULL, -- The final price given to the customer
    
-- Composite Primary Key 
PRIMARY KEY (order_id, product_id),

-- Foreign Keys connecting to Dimensions natively
CONSTRAINT FK_Sales_Calendar FOREIGN KEY (date_id) REFERENCES Dim_Calendar(date_id),
CONSTRAINT FK_Sales_Customers FOREIGN KEY (customer_id) REFERENCES Dim_Customers(customer_id),
CONSTRAINT FK_Sales_Products FOREIGN KEY (product_id) REFERENCES Dim_Products(product_id),
CONSTRAINT FK_Sales_Suppliers FOREIGN KEY (supplier_id) REFERENCES Dim_Suppliers(supplier_id),
CONSTRAINT FK_Sales_VolumeBrackets FOREIGN KEY (bracket_id) REFERENCES Dim_Volume_Discount_Brackets(bracket_id)
);
