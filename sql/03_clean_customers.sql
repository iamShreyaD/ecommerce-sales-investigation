
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

-- to disable safe update mode
SET SQL_SAFE_UPDATES = 0;

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

UPDATE customers_cleaned
SET customer_name = LOWER(TRIM(customer_name)),
    email = LOWER(TRIM(email)),
    city = LOWER(TRIM(city)),
    state = LOWER(TRIM(state)),
    region = LOWER(TRIM(region)),
    signup_date = (TRIM(signup_date)),
    customer_segment = LOWER(TRIM(customer_segment));

SHOW WARNINGS;

SELECT * FROM customers_cleaned;
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
SET region = 'west'
WHERE region = 'W';

SELECT COUNT(DISTINCT region) FROM customers_cleaned;

-- state
SELECT DISTINCT state FROM customers_cleaned;

UPDATE customers_cleaned
SET state = 'maharashtra'
WHERE state = 'MH';

SELECT COUNT(DISTINCT state) FROM customers_cleaned;

-- standardize city names
SELECT DISTINCT city FROM customers_cleaned;

UPDATE customers_cleaned
SET city = 'bengaluru'
WHERE city = 'bangalore';

SELECT COUNT(DISTINCT city) FROM customers_cleaned;

-- check and clean email inconsistencies
SELECT *
FROM customers_cleaned
WHERE email IS NOT NULL
AND email NOT LIKE '%@%.%';

UPDATE customers_cleaned
SET email = 'aditi.das771@outlook.com'
WHERE email = 'aditi.das771outlook.com';

UPDATE customers_cleaned
SET email = 'zoya.mehta315@outlook.com'
WHERE email = 'zoya.mehta315outlook.com';

UPDATE customers_cleaned
SET email = 'dhruv.menon149@outlook.com'
WHERE email = 'dhruv.menon149outlook.com';

UPDATE customers_cleaned
SET email = 'diya.mehta53@outlook.com'
WHERE email = 'diya.mehta53outlook.com';

UPDATE customers_cleaned
SET email = 'zoya.malhotra551@outlook.com'
WHERE email = 'zoya.malhotra551outlook.com';

-- investigate and handle duplicate customers
-- DO NOT DELETE DUPLICATES BLINDLY
-- review all records first
SELECT customer_id, COUNT(*)
FROM customers_cleaned
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT *
FROM customers_cleaned
WHERE customer_id = 654697;  -- IDENTICAL

SELECT *
FROM customers_cleaned
WHERE customer_id = 310574;  -- IDENTICAL

SELECT *
FROM customers_cleaned
WHERE customer_id = 360759;   -- IDENTICAL

SELECT *
FROM customers_cleaned
WHERE customer_id = 604773;   -- IDENTICAL

SELECT *
FROM customers_cleaned
WHERE customer_id = 255887;    -- IDENTICAL

SELECT *
FROM customers_cleaned
WHERE customer_id = 195215;   -- IDENTICAL

SELECT *
FROM customers_cleaned
WHERE customer_id = 158076;    -- IDENTICAL

CREATE TABLE customers_cleaned_deduped AS
SELECT DISTINCT * FROM customers_cleaned;

DROP TABLE customers_cleaned; 

SELECT COUNT(*) FROM customers_cleaned_deduped;

SELECT customer_id, COUNT(*)
FROM customers_cleaned_deduped
GROUP BY customer_id
HAVING COUNT(*) > 1;

RENAME TABLE customers_cleaned_deduped TO customers_cleaned;

SELECT * FROM customers_cleaned;

-- standardize signup_date to date data type
ALTER TABLE customers_cleaned
ADD COLUMN temp_date DATE;

UPDATE customers_cleaned
SET temp_date = STR_TO_DATE(signup_date, '%d/%m/%Y');

SELECT * FROM customers_cleaned;

-- validate cleaned table
-- export data to csv