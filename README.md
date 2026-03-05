# 🏎️ Automotive Pricing Engine & Profitability Simulator

### 📋 Project Overview
This project simulates a real-world **Pricing Strategy Architecture** for an Automotive Spare Parts distributor. It addresses the common industry challenge of managing chaotic supplier data, calculating landed costs with taxes/freight, and optimizing margins for both **B2B (Wholesale)** and **B2C (Retail)** channels.

Instead of analyzing a static dataset, this project builds a complete **Data Engineering & BI pipeline** from scratch.

### 💼 Business Problem
The company faces three critical issues:
1.  **Supplier Chaos:** Multiple vendors (Local & International) provide price lists in different formats, currencies, and naming conventions.
2.  **Pricing Complexity:** Difficulty in determining the "Floor Price" (Minimum acceptable price) due to fluctuating import taxes and freight costs.
3.  **Margin Leakage:** B2B Sales teams often grant excessive discounts without visibility into the real impact on profitability.

### 🛠️ Tech Stack
* **SQL Server (T-SQL):** For ETL processes, data normalization, supplier consolidation, and complex logic injection (Tax/Freight calculations).
* **Power BI:** For Data Modeling (Star Schema), DAX Measures, and "What-If" parameter simulations.
* **Data Strategy:** Hybrid Pricing Model (Competitor-based for High Rotation SKUs + Cost-Plus for Long Tail parts).

### 🏗️ Architecture & Logic
The solution is built upon a robust **Star Schema**:

* **ETL Layer (SQL):**
    * Ingests raw files from `Supplier_A` (Local) and `Supplier_B` (International).
    * Normalizes SKUs using fuzzy logic principles.
    * Calculates `Landed_Cost` = *FOB Price + Freight + Import Tariffs*.
* **Analytical Layer (Power BI):**
    * **B2C Logic:** Dynamic "Traffic Light" system comparing internal prices vs. Competitor Market Prices.
    * **B2B Logic:** Volume-based discount simulator to prevent margin erosion on bulk orders.

### 📂 Key Files
* `01_Market_Simulation_DDL.sql`: Script to generate the synthetic database, creating the "Supplier Chaos" scenario and the Master Catalog.
* `02_Pricing_Logic_ETL.sql`: Stored procedures to clean data and calculate Landed Costs.
* *(More files to be added as the project progresses)*

### 🚀 How to Run
1.  Execute `01_Market_Simulation_DDL.sql` in SQL Server Management Studio (SSMS) to build the database schema and populate mock data.
2.  (Upcoming) Connect Power BI to the `Pricing_Engine_Project` database.

---
*Author: Aaron Olmedo*
*Status: Active Development*
