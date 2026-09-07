
-- row count
SELECT COUNT(*)
FROM orders_raw;

-- preview of data 
SELECT *
FROM orders_raw
LIMIT 10;

-- description of data
DESCRIBE orders_raw;

-- NULL/blank records
SELECT
	SUM(order_id IS NULL OR TRIM(order_id) = '') AS missing_order_id,
    SUM(customer_id IS NULL OR TRIM(customer_id) = '') AS missing_customer_id,
    SUM(product_id IS NULL OR TRIM(product_id) = '') AS missing_product_id,
    SUM(order_date IS NULL OR TRIM(order_date) = '') AS missing_order_date,
    SUM(shipping_date IS NULL OR TRIM(shipping_date) = '') AS missing_shipping_date,
    SUM(quantity IS NULL OR TRIM(quantity) = '') AS missing_quantity,
    SUM(price IS NULL OR TRIM(price) = '') AS missing_price,
    SUM(discount IS NULL OR TRIM(discount) = '') AS missing_discount,
    SUM(region IS NULL OR TRIM(region) = '') AS missing_region,
    SUM(payment_method IS NULL OR TRIM(payment_method) = '') AS missing_payment_method,
    SUM(order_status IS NULL OR TRIM(order_status) = '') AS missing_order_status,
    SUM(sales_channel IS NULL OR TRIM(sales_channel) = '') AS missing_sales_channel,
    SUM(shipping_cost IS NULL OR TRIM(shipping_cost) = '') AS missing_shipping_cost
FROM orders_raw;
    
-- duplication of orders: order_id (not primary key), product_id, quantity, price
SELECT order_id, product_id, quantity, price, COUNT(*)
FROM orders_raw
GROUP BY order_id, product_id, quantity, price
HAVING COUNT(*) > 1;

-- distinct values for categorical columns
-- order_id
SELECT order_id, COUNT(*)
FROM orders_raw
GROUP BY order_id
ORDER BY COUNT(*) DESC;

-- region
SELECT region, COUNT(*)
FROM orders_raw
GROUP BY region
ORDER BY COUNT(*) DESC;

-- payment_method
SELECT payment_method, COUNT(*)
FROM orders_raw
GROUP BY payment_method
ORDER BY COUNT(*) DESC;

-- order_status
SELECT order_status, COUNT(*)
FROM orders_raw
GROUP BY order_status
ORDER BY COUNT(*) DESC;

-- sales_channel
SELECT sales_channel, COUNT(*)
FROM orders_raw
GROUP BY sales_channel
ORDER BY COUNT(*) DESC;

-- numeric validation:
-- quantity <= 0
-- price < 0
-- discount < 0 or discount > 1
-- shipping_cost < 0
-- date validation
-- if order_date < current_date()
-- if shipping_date < current_date()
-- if order_date < shipping_date
-- referential integrity
-- customer_id exists in customers_raw
-- product_id exists in products_raw
-- business rule
-- order_status = 'Cancelled' AND shipping_date IS NOT NULL
-- order_status = 'Returned' and check combination
-- order_status = 'Pending' and shipping_date is not null
-- region consistency
-- compare orders_raw.region with customers_raw.region for the same customer
-- white space inconsistencies for categorical columns
SELECT COUNT(*)
FROM orders_raw
WHERE order_id <> TRIM(order_id) OR
	  customer_id <> TRIM(customer_id) OR
      product_id <> TRIM(product_id) OR
      order_date<> TRIM(order_date) OR
      shipping_date <> TRIM(shipping_date) OR
      quantity <> TRIM(quantity) OR
      price <> TRIM(price) OR
      discount <> TRIM(discount) OR
      region <> TRIM(region) OR
      payment_method <> TRIM(payment_method) OR
      order_status <> TRIM(order_status) OR
      sales_channel <> TRIM(sales_channel) OR
      shipping_cost <> TRIM(shipping_cost);
      

