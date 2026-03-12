# 📊 DAX Measures Dictionary: Automotive Pricing Engine

This document contains all the core Data Analysis Expressions (DAX) measures developed for the Pricing Strategy & Margin Leakage Dashboard. The measures are organized by their business function within the analytical model.

---

## 1. Core Financial Metrics
These are the foundational measures used to calculate the actual performance of the business based on the `Fact_Sales` table.

### Total Units Sold
Calculates the total volume of spare parts sold throughout the selected period.
```dax
Total Units Sold = 
SUM('Fact_Sales'[quantity_sold])
```

### Total Revenue
Calculates the total actual income generated from sales, multiplying the quantity by the actual price paid.
```dax
Total Revenue = 
SUMX(
    'Fact_Sales',
    'Fact_Sales'[quantity_sold] * 'Fact_Sales'[actual_unit_price]
)
```

### Total COGS (Cost of Goods Sold)
Calculates the total landed cost of the items sold (includes base cost, freight, and taxes).
```dax
Total COGS = 
SUMX(
    'Fact_Sales',
    'Fact_Sales'[quantity_sold] * 'Fact_Sales'[unit_cost]
)
```

### Gross Margin ($)
Calculates the absolute gross profit in dollars.
```dax
Gross Margin = 
[Total Revenue] - [Total COGS]
```

### Margin %
Calculates the profitability percentage. It uses the DIVIDE function to safely handle any potential division by zero errors in the dataset.
```dax
Margin % = 
DIVIDE([Gross Margin], [Total Revenue], 0)
```

---

## 2. Margin Leakage & Price Walk Diagnostic
These measures are designed to isolate unauthorized discounts (Margin Leakage) from the company's standard and approved pricing policy.

### Target Revenue (Ideal Revenue)
Calculates the revenue that should have been collected if every single item was sold exactly at its listed target market price (0% discount).
```dax
Target Revenue = 
SUMX(
    'Fact_Sales',
    'Fact_Sales'[quantity_sold] * RELATED('Dim_Products'[target_market_price])
)
```

### Authorized Discounts
Calculates the monetary value of discounts that were officially approved by marketing and management (e.g., standard B2B volume discounts).
```dax
Authorized Discounts = 
SUMX(
    'Fact_Sales',
    'Fact_Sales'[quantity_sold] * 'Fact_Sales'[authorized_discount_amount]
)
```

### Margin Leakage
The core metric of the diagnostic dashboard. It isolates the exact dollar amount lost due to unapproved, ad-hoc discounts given by the sales team to close deals.
```dax
Margin Leakage = 
[Target Revenue] - [Authorized Discounts] - [Total Revenue]
```

---

## 3. Strategic Pricing Simulator (What-If Analysis)
These measures interact with the "Price Modifier" parameter (a slider ranging from -20% to +20%) to forecast how potential price changes will impact the overall gross margin.

### Price Modifier Value
Retrieves the current percentage selected by the user on the dashboard's interactive slider.
```dax
Price Modifier Value = 
SELECTEDVALUE('Price_Modifier'[Price_Modifier], 0)
```

### Simulated Unit Price
Applies the selected percentage change to the base target price of the product to create a new hypothetical price point.
```dax
Simulated Unit Price = 
AVERAGE('Dim_Products'[target_market_price]) * (1 + [Price Modifier Value])
```

### Simulated Target Revenue
Calculates the new total projected revenue if the simulated pricing strategy is applied to the historical sales volume.
```dax
Simulated Target Revenue = 
SUMX(
    'Fact_Sales',
    'Fact_Sales'[quantity_sold] * [Simulated Unit Price]
)
```

### Simulated Gross Margin
Calculates the new projected gross profit, assuming the original COGS remains static while the simulated revenue changes.
```dax
Simulated Gross Margin = 
[Simulated Target Revenue] - [Total COGS]
```