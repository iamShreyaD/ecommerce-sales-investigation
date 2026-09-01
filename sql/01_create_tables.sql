-- database created
CREATE DATABASE ecommerce_sales;

-- customers_raw table imported
SELECT * FROM customers_raw;

-- created table products_raw
CREATE TABLE products_raw (
product_id INT NOT NULL,
product_name VARCHAR(50) NOT NULL,
category VARCHAR(75) NOT NULL,
subcategory VARCHAR(75) NOT NULL,
brand VARCHAR(50) NOT NULL,
unit_cost VARCHAR(50) NOT NULL,
list_price VARCHAR(50) NOT NULL,
supplier_id VARCHAR(50) NOT NULL,
product_status VARCHAR(50) NOT NULL,
PRIMARY KEY(product_id)
);
-- products_raw table imported
SELECT * FROM products_raw;

-- orders_raw table created
CREATE TABLE orders_raw (
order_id VARCHAR(50) NOT NULL,
customer_id VARCHAR(50) NOT NULL,
product_id VARCHAR(50) NOT NULL,
order_date VARCHAR(50) NOT NULL,
shipping_date VARCHAR(50) NOT NULL,
quantity VARCHAR(50) NOT NULL,
price VARCHAR(50) NOT NULL,
discount VARCHAR(50) NOT NULL,
region VARCHAR(50) NOT NULL,
payment_method VARCHAR(50) NOT NULL,
order_status VARCHAR(50) NOT NULL,
sales_channel VARCHAR(50) NOT NULL,
shipping_cost VARCHAR(50) NOT NULL
);
-- orders_raw table imported
SELECT * FROM orders_raw;

-- payments_raw table imported
CREATE TABLE payments_raw (
payment_id VARCHAR(50) NOT NULL,
order_id VARCHAR(50) NOT NULL,
payment_date VARCHAR(50) NOT NULL,
payment_method VARCHAR(50) NOT NULL,
payment_status VARCHAR(50) NOT NULL,
amount_paid VARCHAR(50) NOT NULL,
transaction_id VARCHAR(50) NOT NULL
);
-- payments_raw table imported
SELECT * FROM payments_raw;


