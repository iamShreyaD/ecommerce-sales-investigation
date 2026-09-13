
-- create table
SELECT * FROM products_raw;

CREATE TABLE products_cleaned LIKE products_raw;
INSERT products_cleaned
SELECT * FROM products_raw;

SELECT * FROM products_cleaned;

SELECT COUNT(*) FROM products_cleaned;