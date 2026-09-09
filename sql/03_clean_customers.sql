
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
-- convert empty strings to NULL
-- standardize known categorical inconsistencies
-- region
-- state
-- standardize city names
-- check and clean email inconsistencies
-- standardize signup_date to date data type
-- investigate and handle duplicate customers
-- DO NOT DELETE DUPLICATES BLINDLY
-- review all records first
-- validate cleaned table
-- export data to csv