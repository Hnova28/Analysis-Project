# 🛒 Retail Management System (SQL Project)

## 🎯 Objective
This project demonstrates how SQL can be used for **retail management and analytics** across multiple domains:  
- Employee management and HR insights  
- Customer orders and behavior analysis  
- Product performance and sales insights  

It is built on a **Retail_Management_System** database with several interconnected tables. The project highlights how SQL queries can drive **data-driven decision making**.

---

## 📂 Database Structure
The project includes the following tables:

- **Departments** – department information (HR, IT, Sales, Analyst).  
- **Employees** – employee details with salary, hire date, manager, and department.  
- **Customers** – customer details with email and location.  
- **Products** – product catalog with price details.  
- **Orders** – customer orders with total value and date.  
- **OrderDetails** – breakdown of each order with products and quantities.  
- **Sales** – transactional sales data for revenue analysis.  
- **Returns_Product** – records of returned orders by customers.  

---

## 🔑 Key Insights & Queries
This project covers **47 SQL queries**, categorized into three main sections:

### 👩‍💼 Employee Insights
- Find highest, second highest, and nth highest salary.  
- Employees without departments or managers.  
- Employees earning above department or company average.  
- Department-wise employee counts and average salaries.  
- Top earners per department and top 10% salaries.  
- Recently hired employees and those hired in 2023.  
- Employees earning same as their manager.  

### 👥 Customer & Order Insights
- Customers who purchased but never returned.  
- Orders count, average spend, and lifetime spending.  
- Customers with no orders or multiple same-day orders.  
- Customers active in both 2022 and 2023.  
- Customers who purchased all available products.  
- Highest order value per customer.  

### 📦 Sales & Product Insights
- Total revenue per product and overall sales.  
- Top 5 selling products.  
- Duplicate customer emails detection.  
- Orders by month, and products sold each month of 2023.  
- Products never sold or sold more than 3 times.  
- Orders with more than 1 item.  
- Products purchased by at least 2 distinct customers.  
- Orders containing both specific products (e.g., Laptop + Phone).  

---

## 💡 Business Impact
- **HR / Employee Analytics:** Optimize hiring, salary planning, and department structure.  
- **Customer Analytics:** Identify loyal customers, purchasing behavior, and revenue drivers.  
- **Sales & Product Analytics:** Track revenue trends, top products, and detect gaps (unsold items, high return rates).  
- **Decision Support:** Helps management improve productivity, reduce churn, and maximize profit.  

---

## ⚙️ Tools & Technologies
- **SQL (MySQL)**  
- **RDBMS Concepts:** Joins, Subqueries, CTEs, Window Functions, Aggregates  
- **Retail Dataset:** Custom dataset with employees, customers, products, and sales  

---

## 🚀 How to Use
1. Run the SQL script to create the database and all tables.  
2. Insert the sample data provided in the script.  
3. Execute queries (`1–47`) to generate insights.  
4. Extend with your own queries to explore deeper business questions.  

