-- Basic Overview
-- Total number of orders
SELECT COUNT(*) AS total_orders FROM food_delivery_clean_stage;

-- Number of unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM food_delivery_clean_stage;

-- Number of unique restaurants
SELECT COUNT(DISTINCT restaurant_id) AS unique_restaurants FROM food_delivery_clean_stage;

-- Date range of orders
SELECT MIN(order_date) AS first_order, MAX(order_date) AS last_order
FROM food_delivery_clean_stage;

-- Popularity Analysis
-- Top 10 most ordered food items
SELECT food_item, COUNT(*) AS order_count
FROM food_delivery_clean_stage
GROUP BY food_item
ORDER BY order_count DESC
LIMIT 10;

-- Top 10 most active restaurants
SELECT restaurant_id, COUNT(*) AS total_orders
FROM food_delivery_clean_stage
GROUP BY restaurant_id
ORDER BY total_orders DESC
LIMIT 10;

-- Top 10 most frequent customers
SELECT customer_id, COUNT(*) AS total_orders
FROM food_delivery_clean_stage
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;

-- Payment & Status
-- Distribution of payment methods
SELECT payment_method, COUNT(*) AS count
FROM food_delivery_clean_stage
GROUP BY payment_method;


-- Distribution of order status
SELECT order_status, COUNT(*) AS count
FROM food_delivery_clean_stage
GROUP BY order_status;

-- Monthly order trend
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, COUNT(*) AS orders
FROM food_delivery_clean_stage
GROUP BY month
ORDER BY month;

-- Delivery Performance
-- Average delivery time
SELECT AVG(delivery_time_minutes) AS avg_delivery_time
FROM food_delivery_clean_stage;

-- Top 10 fastest deliveries (with valid delivery times)
SELECT order_id, restaurant_id, delivery_time_minutes
FROM food_delivery_clean_stage
WHERE delivery_time_minutes IS NOT NULL
ORDER BY delivery_time_minutes ASC
LIMIT 10;

-- Top 10 slowest deliveries
SELECT order_id, restaurant_id, delivery_time_minutes
FROM food_delivery_clean_stage
WHERE delivery_time_minutes IS NOT NULL
ORDER BY delivery_time_minutes DESC
LIMIT 10;

-- Revenue Insights

-- Total revenue
SELECT SUM(quantity * price) AS total_revenue FROM food_delivery_clean_stage;

-- Average order value
SELECT AVG(quantity * price) AS avg_order_value FROM food_delivery_clean_stage;

-- Top 10 restaurants by revenue
SELECT restaurant_id, SUM(quantity * price) AS revenue
FROM food_delivery_clean_stage
GROUP BY restaurant_id
ORDER BY revenue DESC
LIMIT 10;

-- Top 10 customers by spending
SELECT customer_id, SUM(quantity * price) AS total_spent
FROM food_delivery_clean_stage
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;





