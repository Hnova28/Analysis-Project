# 🍔 Food Delivery Operations Analysis (SQL Project)

## 🎯 Objective
The goal of this project is to analyze **food delivery operations** using SQL.  
Starting from a raw CSV dataset, the data is cleaned, transformed, and analyzed to uncover insights about:  
- Customer behavior  
- Restaurant performance  
- Delivery efficiency  
- Revenue trends  

This project highlights how SQL can be used for **ETL (Extract, Transform, Load)** and **EDA (Exploratory Data Analysis)**.

---

## 📂 Project Workflow
1. **Raw Data Import**  
   - Dataset loaded from CSV into `raw_food_delivery` table.  

2. **Staging & Cleaning**  
   - `stage1`: Trimmed blanks, handled NULLs.  
   - `stage2`: Cleaned and validated `quantity`.  
   - `stage3`: Cleaned and validated `price`.  
   - `food_delivery_clean_stage`: Final normalized dataset with:  
     - Standardized `payment_method` (Cash, Card, Mobile Payment).  
     - Standardized `order_status` (Delivered, Pending, Cancelled).  

3. **Exploratory Data Analysis (EDA)**  
   Conducted queries to explore:  
   - Basic overview (orders, customers, restaurants, timeline).  
   - Popular food items, restaurants, and customers.  
   - Payment method distribution and order statuses.  
   - Monthly order trends.  
   - Delivery performance.  
   - Revenue analysis.  

---

## 🔑 Key Insights
### 📊 Basic Overview
- Total number of orders placed.  
- Unique customers and restaurants served.  
- Date range of the dataset.  

### 🍕 Popularity Analysis
- **Top 10 food items** by order volume.  
- **Top 10 restaurants** by number of orders.  
- **Top 10 customers** by order frequency.  

### 💳 Payments & Order Status
- Distribution of **payment methods** (Cash, Card, Mobile Payment).  
- Distribution of **order statuses** (Delivered, Pending, Cancelled).  

### 📅 Monthly Trend
- Orders aggregated by month to see growth/decline trends.  

### 🚚 Delivery Performance
- Average delivery time across all orders.  
- Top 10 fastest vs. slowest deliveries.  

### 💰 Revenue Insights
- Total revenue generated.  
- Average order value (AOV).  
- **Top 10 restaurants** by revenue contribution.  
- **Top 10 customers** by total spending.  

---

## 💡 Business Impact
- **Customer Behavior:** Identifies loyal, high-spending, and frequent customers.  
- **Restaurant Insights:** Helps find best-performing restaurants and those underperforming.  
- **Operational Efficiency:** Delivery speed analysis supports logistics improvements.  
- **Revenue Growth:** Highlights key revenue drivers and potential areas for expansion.  

---

## ⚙️ Tools & Technologies
- **SQL (MySQL)**  
- **ETL Techniques** – staging tables, data cleaning, normalization  
- **EDA with SQL** – aggregations, grouping, ranking, trend analysis  

---
