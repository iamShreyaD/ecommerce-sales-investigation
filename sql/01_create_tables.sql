CREATE DATABASE ecommerce_sales;

SELECT * FROM customers_raw;
SELECT COUNT(*) FROM customers_raw;

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
DESCRIBE products_raw;
SELECT * FROM products_raw;
SELECT COUNT(*) FROM products_raw;

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
DESCRIBE orders_raw;
SELECT * FROM orders_raw;
SELECT COUNT(*) FROM orders_raw;

CREATE TABLE payments_raw (
payment_id VARCHAR(50) NOT NULL,
order_id VARCHAR(50) NOT NULL,
payment_date VARCHAR(50) NOT NULL,
payment_method VARCHAR(50) NOT NULL,
payment_status VARCHAR(50) NOT NULL,
amount_paid VARCHAR(50) NOT NULL,
transaction_id VARCHAR(50) NOT NULL
);
DESCRIBE payments_raw;
SELECT * FROM payments_raw;
SELECT COUNT(*) FROM payments_raw;


