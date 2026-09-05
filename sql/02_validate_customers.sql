-- row count : 507
SELECT COUNT(*) FROM customers_raw;

-- preview of data
SELECT * FROM customers_raw LIMIT 10;

-- column names and data types
DESCRIBE customers_raw;

-- NULL/blank values
SELECT
    SUM(customer_id IS NULL OR TRIM(customer_id) = '') AS missing_customer_id,
    SUM(customer_name IS NULL OR TRIM(customer_name) = '') AS missing_name,
    SUM(email IS NULL OR TRIM(email) = '') AS missing_email,
    SUM(city IS NULL OR TRIM(city) = '') AS missing_city,
    SUM(state IS NULL OR TRIM(state) = '') AS missing_state,
    SUM(region IS NULL OR TRIM(region) = '') AS missing_region,
    SUM(signup_date IS NULL) AS missing_signup_date,
    SUM(customer_segment IS NULL OR TRIM(customer_segment) = '') AS missing_segment
FROM customers_raw;
     
-- duplicate primary key records : 7
SELECT customer_id, COUNT(*) AS total_rows
FROM customers_raw
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- duplicate customer records : 7
SELECT customer_name, email, COUNT(*)
FROM customers_raw
GROUP BY customer_name, email
HAVING COUNT(*) > 1;

-- distinct values / categorical validation
SELECT DISTINCT region FROM customers_raw; 
-- North, East, West, Central, South, West, blank, w 
SELECT DISTINCT city FROM customers_raw; 
-- Delhi, Bhubaneswar, Nagpur, Indore, Ahmedabad, Lucknow, Pune, Noida, Patna, Jaipur, Bhopal
-- Kolkata, Chennai, Kochi, Gurugram, blank, Surat, Hyderabad, Mumbai, Pune, Bangalore, Bengaluru, New Delhi
SELECT DISTINCT state FROM customers_raw; 
-- Delhi, Odisha, Maharashtra, Madhya Pradesh, Gujarat, Uttar Pradesh, Bihar, Rajasthan
-- West Bengal, Tamil Nadu, Kerala, Haryana, MH, Telangana, Karnataka, blank
SELECT DISTINCT customer_segment FROM customers_raw;
-- Consumer, Small Business, Corporate

-- value frequency
-- for region
SELECT region, COUNT(*)
FROM customers_raw
GROUP BY region
ORDER BY COUNT(*) DESC;

-- for city
SELECT city, COUNT(*)
FROM customers_raw
GROUP BY city
ORDER BY COUNT(*) DESC;

-- for state
SELECT state, COUNT(*)
FROM customers_raw
GROUP BY state
ORDER BY COUNT(*) DESC;

-- for customer_segment
SELECT customer_segment, COUNT(*)
FROM customers_raw
GROUP BY customer_segment
ORDER BY COUNT(*) DESC;

-- white spaces : 7
SELECT COUNT(*)
FROM customers_raw
WHERE customer_name <> TRIM(customer_name) OR
	  email <> TRIM(email) OR
      city <> TRIM(city) OR
      state <> TRIM(state) OR
      region <> TRIM(region);

-- validate email format
SELECT COUNT(*)
FROM customers_raw
WHERE email IS NOT NULL
AND email NOT LIKE '%@%.%';

-- validate signup dates
SELECT COUNT(*)
FROM customers_raw
WHERE signup_date > CURRENT_DATE();