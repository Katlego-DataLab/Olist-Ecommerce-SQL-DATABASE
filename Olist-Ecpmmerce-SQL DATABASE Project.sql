/*E-COMMERCE ANALYTICAL DATABASE PROJECT-> Olist-Ecommerce 
   Author: Katlego Mathebula 
   Description: End-to-end SQL data modeling, validation,
   cleaning, and business intelligence analytics.*/


 ---1. DATABASE SCHEMA DESIGN---
  

-- 1.1 CUSTOMERS TABLE
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR(100),
    customer_state CHAR(2)
);

-- 1.2 SELLERS TABLE
CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INTEGER,
    seller_city VARCHAR(100),
    seller_state CHAR(2)
);

-- 1.3 PRODUCTS TABLE
CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length INTEGER,
    product_description_length INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);

-- 1.4 ORDERS TABLE
CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 1.5 ORDER ITEMS TABLE
CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INTEGER,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

-- 1.6 PAYMENTS TABLE
CREATE TABLE payments (
    order_id VARCHAR(50),
    payment_sequential INTEGER,
    payment_type VARCHAR(20),
    payment_installments INTEGER,
    payment_value DECIMAL(10,2),
    PRIMARY KEY (order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 1.7 REVIEWS TABLE
CREATE TABLE reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    PRIMARY KEY (review_id, order_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 1.8 GEOLOCATION TABLE
CREATE TABLE geolocation (
    geolocation_id SERIAL PRIMARY KEY,
    geolocation_zip_code_prefix INTEGER,
    geolocation_lat DECIMAL(10,8),
    geolocation_lng DECIMAL(11,8),
    geolocation_city VARCHAR(100),
    geolocation_state CHAR(2)
);

-- 1.9 PRODUCT CATEGORY TRANSLATION
CREATE TABLE product_category_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);


---2. PERFORMANCE OPTIMIZATION (INDEXING)---
  

CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_date ON orders(order_purchase_timestamp);
CREATE INDEX idx_order_items_product ON order_items(product_id);
CREATE INDEX idx_order_items_seller ON order_items(seller_id);
CREATE INDEX idx_payments_order ON payments(order_id);
CREATE INDEX idx_reviews_order ON reviews(order_id);

---3. IMPORTING ALL THE REQUIRED TABLES, USED SELECT STATEMENT TO VERIFY THE TABLES --
-- 3.1 CUSTOMERS
COPY customers 
FROM 'C:/Users/User/Downloads/olist_project\olist_customers_dataset.csv' 
DELIMITER ',' 
CSV HEADER;
SELECT * FROM customers;

-- 3.2. SELLERS
COPY sellers 
FROM 'C:/Users/User/Downloads/olist_project\olist_customers_dataset.csv'
DELIMITER ',' 
CSV HEADER;
SELECT *FROM sellers;


-- 3.3 PRODUCTS
COPY products 
FROM 'C:/Users/User/Downloads/olist_project\olist_products_dataset.csv' 
DELIMITER ',' 
CSV HEADER;
SELECT *FROM products;

-- 3.4 ORDERS (requires the customers table to exist first)
COPY orders 
FROM 'C:/Users/User/Downloads/olist_project\olist_orders_dataset.csv' 
DELIMITER ',' 
CSV HEADER;
SELECT *FROM orders;

-- 3.5 ORDER ITEMS
COPY order_items 
FROM 'C:/Users/User/Downloads/olist_project\olist_order_items_dataset.csv' 
DELIMITER ',' 
CSV HEADER;
SELECT *FROM order_items;

-- 3.6 PAYMENTS
COPY payments 
FROM 'C:/Users/User/Downloads/olist_project\olist_order_payments_dataset.csv' 
DELIMITER ',' 
CSV HEADER;
SELECT *FROM payments;

-- 3.7 REVIEWS
COPY reviews 
FROM 'C:/Users/User/Downloads/olist_project\olist_order_reviews_dataset.csv' 
DELIMITER ',' 
CSV HEADER;
SELECT *FROM reviews;

-- 3.8 GEOLOCATION
COPY geolocation 
FROM 'C:/Users/User/Downloads/olist_project\olist_geolocation_dataset.csv' 
DELIMITER ',' 
CSV HEADER;
SELECT *FROM geolocation;

-- 3.9 PRODUCT CATEGORY TRANSLATION
COPY product_category_translation 
FROM 'C:/Users/User/Downloads/olist_project\product_category_name_translation.csv' 
DELIMITER ',' 
CSV HEADER;
SELECT *FROM product_category_translation;



  --- 4. DATA VALIDATION & QUALITY CHECKS---
   
-- Row counts
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM sellers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_items;
SELECT COUNT(*) FROM payments;
SELECT COUNT(*) FROM reviews;
SELECT COUNT(*) FROM geolocation;
SELECT COUNT(*) FROM product_category_translation;


  --- 5. DATA CLEANING & CONSTRAINT ENFORCEMENT---
  
-- 5.1 NOT NULL ENFORCEMENT
ALTER TABLE customers
ALTER COLUMN customer_id SET NOT NULL,
ALTER COLUMN customer_city SET NOT NULL,
ALTER COLUMN customer_state SET NOT NULL;

ALTER TABLE orders
ALTER COLUMN order_id SET NOT NULL,
ALTER COLUMN customer_id SET NOT NULL,
ALTER COLUMN order_status SET NOT NULL,
ALTER COLUMN order_purchase_timestamp SET NOT NULL;

ALTER TABLE order_items
ALTER COLUMN order_id SET NOT NULL,
ALTER COLUMN product_id SET NOT NULL,
ALTER COLUMN seller_id SET NOT NULL,
ALTER COLUMN price SET NOT NULL;


-- 5.2 CHECK CONSTRAINTS

ALTER TABLE reviews
ADD CONSTRAINT check_review_score
CHECK (review_score BETWEEN 1 AND 5);

ALTER TABLE order_items
ADD CONSTRAINT check_price_positive
CHECK (price >= 0);

ALTER TABLE order_items
ADD CONSTRAINT check_freight_positive
CHECK (freight_value >= 0);

ALTER TABLE payments
ADD CONSTRAINT check_payment_positive
CHECK (payment_value >= 0);

ALTER TABLE orders
ADD CONSTRAINT check_order_status
CHECK (order_status IN 
('delivered' ,'shipped',' canceled', 'approved', 'invoiced',' processing'));


-- 5.3 HANDLING NULL PRODUCT DIMENSIONS 
UPDATE products
SET product_weight_g = 0
WHERE product_weight_g IS NULL;



  --- 6. BUSINESS METRICS---
  

-- 6.1 Total Revenue
SELECT ROUND(SUM(payment_value),2) AS total_revenue
FROM payments;

-- 6.2 Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- 6.3 Average Order Value
SELECT ROUND(SUM(payment_value) / COUNT(DISTINCT order_id),2)
FROM payments;

-- 6.4 Monthly Revenue Trend
SELECT 
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    ROUND(SUM(p.payment_value),2) AS monthly_revenue
FROM payments p
JOIN orders o ON p.order_id = o.order_id
GROUP BY month
ORDER BY month;


  --- 7. ADVANCED ANALYTICS---
   

-- 7.1 Customer Lifetime Value
SELECT 
    c.customer_id,
    ROUND(SUM(p.payment_value),2) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id
ORDER BY lifetime_value DESC
LIMIT 10;


-- 7.2 Top Customers Using RANK()
SELECT *
FROM (
    SELECT 
        c.customer_id,
        ROUND(SUM(p.payment_value),2) AS total_spent,
        RANK() OVER (ORDER BY SUM(p.payment_value) DESC) AS spending_rank
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY c.customer_id
) ranked_customers
WHERE spending_rank <= 10;


-- 7.3 Repeat Purchase Rate
SELECT 
    COUNT(*) FILTER (WHERE order_count > 1) * 100.0 / COUNT(*) 
    AS repeat_customer_percentage
FROM (
    SELECT 
        customer_id,
        COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) customer_orders;


-- 7.4 Cumulative Revenue (Running Total)
SELECT 
    month,
    SUM(monthly_revenue) OVER (ORDER BY month) AS cumulative_revenue
FROM (
    SELECT 
        DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
        SUM(p.payment_value) AS monthly_revenue
    FROM orders of
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY month
) monthly_data
ORDER BY month;


-- 7.5 Customer Retention Analysis
WITH first_purchase AS (
    SELECT 
        customer_id,
        MIN(DATE_TRUNC('month', order_purchase_timestamp)) AS first_month
    FROM orders
    GROUP BY customer_id
),
monthly_activity AS (
    SELECT 
        customer_id,
        DATE_TRUNC('month', order_purchase_timestamp) AS active_month
    FROM orders
)
SELECT 
    f.first_month,
    m.active_month,
    COUNT(DISTINCT m.customer_id) AS active_customers
FROM first_purchase f
JOIN monthly_activity m
    ON f.customer_id = m.customer_id
GROUP BY f.first_month, m.active_month
ORDER BY f.first_month, m.active_month;