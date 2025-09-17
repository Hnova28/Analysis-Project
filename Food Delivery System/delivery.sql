CREATE DATABASE IF NOT EXISTS food_ops;
USE food_ops;

DROP TABLE IF EXISTS raw_food_delivery;
CREATE TABLE raw_food_delivery (
  order_id               TEXT,
  customer_id            TEXT,
  restaurant_id          TEXT,
  food_item              TEXT,
  quantity               TEXT,
  price                  TEXT,
  order_date             TEXT,
  delivery_time_minutes  TEXT,
  payment_method         TEXT,
  order_status           TEXT,
  extra_note             TEXT
);
-- taken data from csv file
-- copy from raw food delivery ( dont't want to mess with raw data)
DROP TABLE IF EXISTS stage1;
CREATE TABLE stage1 AS
SELECT
  `order_id`,
  `customer_id`,
  `restaurant_id`,
  `food_item`,
  `quantity`,
  `price`,
  `order_date`,
  `delivery_time_minutes`,
  `payment_method`,
  `order_status`,
  `extra_note`
FROM `raw_food_delivery`;
-- avoid error for safe update
SET SQL_SAFE_UPDATES = 0;
-- Trim text & turn blanks into NULL
UPDATE stage1
SET
  order_id      = NULLIF(TRIM(order_id), ''),
  customer_id   = NULLIF(TRIM(customer_id), ''),
  food_item     = NULLIF(TRIM(food_item), ''),
  payment_method= NULLIF(TRIM(payment_method), ''),
  order_status  = NULLIF(TRIM(order_status), ''),
  extra_note    = NULLIF(TRIM(extra_note), ''),
  order_date    = NULLIF(TRIM(order_date), ''),
  delivery_time_minutes  = NULLIF(TRIM(delivery_time_minutes), '');
-- check
SELECT * FROM food_ops.stage1;
-- clean quantity
DROP TABLE IF EXISTS stage2;
CREATE TABLE stage2 AS
SELECT
  s1.*,
  CASE
    WHEN quantity REGEXP '^[0-9]+$' THEN CAST(quantity AS UNSIGNED)
    ELSE NULL
  END AS clean_quantity
FROM stage1 s1;

-- clean price
DROP TABLE IF EXISTS stage3;
CREATE TABLE stage3 AS
SELECT
    s2.*,
    CASE
        WHEN price REGEXP '^[0-9]+(\.[0-9]+)?$' THEN CAST(price AS DECIMAL(10,2))
        ELSE 0.00
    END AS clean_price
FROM stage2 s2;

-- Normalize payment & order status
DROP TABLE IF EXISTS food_delivery_clean_stage;
CREATE TABLE food_delivery_clean_stage AS
SELECT
  order_id,
  customer_id,
  restaurant_id,
  food_item,
  order_date,
  delivery_time_minutes,
  clean_quantity AS quantity,
  clean_price AS price,

  CASE
    WHEN LOWER(payment_method) IN ('cash','cod','cash on delivery') THEN 'Cash'
    WHEN LOWER(payment_method) IN ('card','credit card','debit card') THEN 'Card'
    WHEN lower(payment_method) in ('MobilePayment') then 'Mobile Payment'
    -- WHEN LOWER(payment_method) LIKE '%bkash%' THEN 'bKash'
    -- WHEN LOWER(payment_method) = 'nagad' THEN 'Nagad'
    ELSE NULLIF(TRIM(payment_method),'')
  END AS payment_method,

  CASE
    WHEN LOWER(order_status) IN ('delivered','complete','completed') THEN 'Delivered'
    WHEN LOWER(order_status) IN ('pending','processing') THEN 'Pending'
    WHEN LOWER(order_status) IN ('cancelled','canceled') THEN 'Cancelled'
    ELSE NULLIF(TRIM(order_status),'')
  END AS order_status
FROM stage3;









