
-- create cleaned table
SELECT *
FROM customers_raw; 

CREATE TABLE customers_cleaned 
LIKE customers_raw;

INSERT customers_cleaned
SELECT *
FROM customers_raw;

SELECT *
FROM customers_cleaned;

SELECT COUNT(*)
FROM customers_cleaned;

-- standardize text formatting
-- TRIM whitespace
-- convert categorical/text fields to lowercase
SELECT
	customer_id,
    LOWER(TRIM(customer_name)) AS customer_name,
    LOWER(TRIM(email)) AS email,
    LOWER(TRIM(city)) AS city,
    LOWER(TRIM(state)) AS state,
    LOWER(TRIM(region)) AS region,
    LOWER(TRIM(signup_date)) AS signup_date,
    LOWER(TRIM(customer_segment)) AS customer_segment
FROM customers_cleaned;

-- handle blank values
-- find blank value columns and count
SELECT
	SUM(customer_id = '') AS blank_customer_id,
	SUM(customer_name = '') AS blank_customer_name,
    SUM(email = '') AS blank_email,
    SUM(city = '') AS blank_city,
    SUM(state = '') AS blank_state,
    SUM(region = '') AS blank_region,
    SUM(signup_date = '') AS blank_signup_date,
    SUM(customer_segment = '') AS blank_customer_segment,
    SUM(customer_name = '') AS blank_customer_name
FROM customers_cleaned;

SELECT email, city, state, region
FROM customers_cleaned
WHERE email = '' OR
	  city = '' OR
      state = '' OR
      region = '';
      
-- to disable safe update mode
SET SQL_SAFE_UPDATES = 0;

-- convert empty strings to NULL
UPDATE customers_cleaned
SET email = NULL
WHERE email = '';

UPDATE customers_cleaned
SET city = NULL
WHERE city = '';

UPDATE customers_cleaned
SET state = NULL 
WHERE state = '';

UPDATE customers_cleaned
SET region = NULL
WHERE region = '';   

-- standardize known categorical inconsistencies
-- region
SELECT DISTINCT region FROM customers_cleaned;

UPDATE customers_cleaned
SET region = 'West'
WHERE region = 'W';

SELECT COUNT(DISTINCT region) FROM customers_cleaned;

-- state
SELECT DISTINCT state FROM customers_cleaned;

UPDATE customers_cleaned
SET state = 'Maharashtra'
WHERE state = 'MH';

SELECT COUNT(DISTINCT state) FROM customers_cleaned;

-- standardize city names
SELECT DISTINCT region FROM customers_cleaned;

-- check and clean email inconsistencies
-- standardize signup_date to date data type
-- investigate and handle duplicate customers
-- DO NOT DELETE DUPLICATES BLINDLY
-- review all records first
-- validate cleaned table
-- export data to csv