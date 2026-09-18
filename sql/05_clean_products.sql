
-- create table
SELECT * FROM products_raw;

CREATE TABLE products_cleaned LIKE products_raw;
INSERT products_cleaned
SELECT * FROM products_raw;

SELECT * FROM products_cleaned;
SELECT COUNT(*) FROM products_cleaned;
DESCRIBE products_cleaned;

-- standardize text
SET SQL_SAFE_UPDATES = 0;
UPDATE products_cleaned
SET 
    product_name = LOWER(TRIM(product_name)),
    category = LOWER(TRIM(category)),
    subcategory = LOWER(TRIM(subcategory)),
    brand = LOWER(TRIM(brand)),
    unit_cost = LOWER(TRIM(unit_cost)),
    list_price = LOWER(TRIM(list_price)),
    supplier_id = LOWER(TRIM(supplier_id)),
    product_status = LOWER(TRIM(product_status));

SELECT * FROM products_cleaned;

-- change the data type of unit_cost 
SELECT COUNT(*) FROM products_cleaned WHERE unit_cost = '';

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE products_cleaned
MODIFY COLUMN unit_cost VARCHAR(50) NULL;

UPDATE products_cleaned
SET unit_cost = NULL 
WHERE TRIM(unit_cost) = '';

SELECT unit_cost, unit_cost IS NULL AS is_null
FROM products_cleaned
WHERE unit_cost IS NULL;

ALTER TABLE products_cleaned
MODIFY COLUMN unit_cost DECIMAL(10,2);

-- change the data type of list_price
SELECT COUNT(*) FROM products_cleaned WHERE list_price = '';

SET SQL_SAFE_UPDATES = 0;

SELECT list_price
FROM products_cleaned
WHERE list_price LIKE '%,%';

UPDATE products_cleaned
SET list_price = REPLACE(list_price, ',', '')
WHERE list_price LIKE '%,%';

ALTER TABLE products_cleaned
MODIFY COLUMN list_price DECIMAL(10,2);

DESCRIBE products_cleaned;

-- investigate unit_cost > list_price
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE products_cleaned
ADD COLUMN price_flag VARCHAR(100);

UPDATE products_cleaned
SET price_flag = 'unit_cost > list_price'
WHERE unit_cost > list_price;

SELECT * FROM products_cleaned WHERE unit_cost > list_price;

-- category and subcategory consistency
SELECT 
	subcategory, 
    COUNT(DISTINCT category) AS category_count
FROM products_cleaned
WHERE subcategory IS NOT NULL OR subcategory <> ''
GROUP BY subcategory
HAVING COUNT(DISTINCT category) > 1;

SELECT * FROM products_cleaned 
WHERE subcategory = 'audio' OR 
	  subcategory = 'computer accessories' OR
      subcategory = 'mobile accessories' OR
      subcategory = 'stationery';
      
ALTER TABLE products_cleaned
ADD COLUMN category_flag VARCHAR(100);

UPDATE products_cleaned
SET category_flag = 'category mismatch'
WHERE product_id IN (28208, 83401, 83876);

SELECT * FROM products_cleaned;

-- check NULL/blank values
SELECT
	SUM(product_id = '') AS blank_product_id,
    SUM(product_name = '') AS blank_product_name,
    SUM(category = '') AS blank_category,
    SUM(subcategory = '') AS blank_subcategory,
    SUM(brand = '') AS blank_brand,
    SUM(unit_cost = '') AS blank_unit_cost,
    SUM(list_price = '') AS blank_list_price,
    SUM(supplier_id = '') AS blank_supplier_id,
    SUM(product_status = '') AS blank_product_status,
    SUM(price_flag = '') AS blank_price_flag,
    SUM(category_flag = '') AS blank_category_flag
FROM products_cleaned;

SELECT subcategory, brand, supplier_id
FROM products_cleaned
WHERE subcategory = '' OR brand = '' OR supplier_id = '';
    


