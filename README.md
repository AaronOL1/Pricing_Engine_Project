# 🏎️ Automotive Pricing Engine & Profitability Simulator

### 📂 Repository Structure
This project is organized into two main branches to reflect the dual nature of Business Intelligence (Strategy + Technology):

* `01_Pricing_Engine_Tool/`: Contains the SQL database architecture, ETL processes, the interactive Power BI Dashboard, and the Business Glossary.
* `02_Strategic_Business_Case/`: Contains the financial analysis (Excel) and the executive presentation outlining the commercial strategy.

### 📋 Project Overview
This project is an end-to-end **Business Intelligence & Pricing Strategy** solution for an Automotive Spare Parts distributor. It tackles the entire data lifecycle: from managing chaotic supplier data and calculating complex landed costs in SQL, to detecting margin leakage and simulating pricing strategies in a highly interactive Power BI dashboard.

Instead of analyzing a flat, static dataset, this project builds a complete **Data Engineering & Analytics pipeline** from scratch
### 💼 The Business Problem
The company faced three critical bottlenecks:
1. **Supplier Chaos:** Multiple vendors (Local & International) provided price lists in different formats, currencies, and naming conventions.
2. **Pricing Complexity:** Difficulty in determining the "Floor Price" (Minimum acceptable price) due to fluctuating import taxes and freight costs.
3. **Margin Leakage (The Silent Killer):** B2B Sales teams were granting excessive, unauthorized discounts to close deals, severely eroding the company's profitability without management visibility.

### 💡 The Solution & Dashboard Features
To solve this, I developed a 3-stage Power BI Dashboard driven by a robust SQL backend:

* **📊 Phase 1: Executive Overview** * Tracks high-level financial KPIs: Target Revenue, Actual Revenue, and Gross Margin distribution across B2B and B2C segments.
* **🕵️‍♂️ Phase 2: Margin Leakage Diagnostic**
  * **Price Walk (Waterfall Chart):** Mathematically isolates justified corporate discounts from unauthorized margin leakage (money given away by sales reps).
  * **Wall of Shame:** A Top 10 breakdown of the worst-performing clients where the company is losing the most margin.
* **🎛️ Phase 3: Strategic Pricing Simulator (What-If Analysis)**
  * **Interactive Calculator:** Allows management to simulate global price changes (-20% to +20%) and instantly see the dollar impact on the Gross Margin per SKU.
  * **Strategy Matrix (Scatter Plot):** Classifies the 750+ parts catalog into 4 quadrants (Volume vs. Profitability) to identify which SKUs can absorb a price hike and which require aggressive liquidation promotions.

### 🛠️ Tech Stack & Architecture
* **SQL Server (T-SQL):** Data ingestion, normalization (fuzzy logic for SKUs), and ETL processes to calculate `Landed_Cost` (FOB + Freight + Tariffs).
* **Power BI:** Data Modeling (Star Schema).
* **Advanced DAX:** Complex measure creation (Dynamic Pricing, Margin Leakage isolation, What-If parameters).
* **Data Strategy:** Hybrid Pricing Model (Competitor-based for High Rotation SKUs + Cost-Plus for Long Tail parts).

### 📊 Entity-Relationship Diagram
![Pricing Engine ERD](assets/ERD_Schema.png)

### 💼 PART 1: Strategic Business Case (Consulting & Financial Analysis)
*Location: `02_Strategic_Business_Case/`*

#### The Business Problem
The company needed an immediate pricing strategy for a catalog of 800 SKUs. The goal was to align prices with competitors (applying a strict -2% rule) while establishing viable discount tiers (20%, 30%, 40%) without sacrificing the corporate gross margin target of 45%. Furthermore, the inventory suffered from severe stagnation across different rotation categories (X: High, Y: Medium, Z: Low).

#### The Strategic Solution
Instead of applying flat discounts that would dilute the margin, a tactical financial model was developed:
* **Margin Protection via Bundling:** For high-rotation items (X), I proposed a cross-selling strategy ("Venta Atada") where deep discounts are only unlocked if combined with lower-rotation items, effectively protecting the blended margin.
* **Intelligent Liquidation for Obsolete Inventory (Z):** Modeled the financial carrying cost of dead stock to justify strategic liquidation. Accepting a lower margin on dead stock frees up critical working capital for profitable SKUs.
* *Note: The final executive presentation (PDF) was delivered in Spanish to align with the LATAM board of directors' native business environment.*

---

### 💻 PART 2: Pricing Engine & Profitability Simulator (Technical Architecture)
*Location: `01_Pricing_Engine_Tool/`*

#### The Data Engineering Problem
The company faced critical bottlenecks:
1. **Supplier Chaos:** Multiple vendors provided price lists in different formats and currencies.
2. **Pricing Complexity:** Difficulty in determining the "Floor Price" due to fluctuating import taxes and freight costs.
3. **Margin Leakage (The Silent Killer):** B2B Sales teams were granting excessive, unauthorized discounts to close deals, severely eroding profitability.

#### The Technical Solution
I developed a 3-stage Power BI Dashboard driven by a robust SQL backend:

* **📊 Phase 1: Executive Overview**
  Tracks high-level financial KPIs: Target Revenue, Actual Revenue, and Gross Margin distribution across B2B and B2C segments.
* **🕵️‍♂️ Phase 2: Margin Leakage Diagnostic**
  * **Price Walk (Waterfall Chart):** Mathematically isolates justified corporate discounts from unauthorized margin leakage (money given away by sales reps).
  * **Wall of Shame:** A Top 10 breakdown of the worst-performing clients where the company is losing the most margin.
* **🎛️ Phase 3: Strategic Pricing Simulator (What-If Analysis)**
  * **Interactive Calculator:** Allows management to simulate global price changes (-20% to +20%) and instantly see the dollar impact on the Gross Margin per SKU.
  * **Strategy Matrix (Scatter Plot):** Classifies the catalog into 4 quadrants (Volume vs. Profitability) to identify which SKUs can absorb a price hike and which require liquidation.

---

### 🛠️ Tech Stack & Architecture
* **SQL Server (T-SQL):** Data ingestion, normalization (fuzzy logic for SKUs), and ETL processes to calculate `Landed_Cost` (FOB + Freight + Tariffs).
* **Power BI & Advanced DAX:** Star Schema data modeling and complex measure creation (Dynamic Pricing, Margin Leakage isolation, What-If parameters).
* **Advanced Excel:** Financial modeling and scenario simulation for the business case.

---
*Author: Aaron Olmedo*
*Role: Data Analyst / BI Developer*