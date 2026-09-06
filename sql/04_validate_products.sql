
-- row count
SELECT COUNT(*)
FROM products_raw;

-- preview of data
SELECT *
FROM products_raw
LIMIT 10;

-- description of data
DESCRIBE products_raw;

-- retrieve NULL/blank values
SELECT
	SUM(product_id IS NULL OR TRIM(product_id) = '') AS missing_product_id,
    SUM(product_name IS NULL OR TRIM(product_name) = '') AS missing_product_name,
    SUM(category IS NULL OR TRIM(category) = '') AS missing_cat,
    SUM(subcategory IS NULL OR TRIM(subcategory) = '') AS missing_subcat,
    SUM(brand IS NULL OR TRIM(brand) = '') AS missing_brand,
    SUM(unit_cost IS NULL OR TRIM(unit_cost) = '') AS missing_unit_cost,
    SUM(list_price IS NULL OR TRIM(list_price) = '') AS missing_list_price,
    SUM(supplier_id IS NULL OR TRIM(supplier_id) = '') AS missing_supplier_id
FROM products_raw;

-- duplicate primary key records
SELECT product_id, COUNT(*)
FROM products_raw
GROUP BY product_id
HAVING COUNT(*) > 1;

-- duplicate product records (product_name, brand)
SELECT product_name, brand, COUNT(*)
FROM products_raw
GROUP BY product_name, brand
HAVING COUNT(*) > 1;

-- distinct values/categorical validation
-- for product_name
SELECT DISTINCT product_name, COUNT(*)
FROM products_raw
GROUP BY product_name
ORDER BY COUNT(*) DESC; 

-- for category
SELECT DISTINCT category, COUNT(*)
FROM products_raw
GROUP BY category
ORDER BY COUNT(*) DESC;

-- for subcategory
SELECT DISTINCT subcategory, COUNT(*)
FROM products_raw
GROUP BY subcategory
ORDER BY COUNT(*) DESC;

-- for brand
SELECT brand, COUNT(*)
FROM products_raw
GROUP BY brand
ORDER BY COUNT(*) DESC;

-- for product_status
SELECT product_status, COUNT(*)
FROM products_raw
GROUP BY product_status
ORDER BY COUNT(*) DESC;

-- white space issues
SELECT COUNT(*)
FROM products_raw
WHERE product_name <> TRIM(product_name) OR
	  category <> TRIM(category) OR
      subcategory <> TRIM(subcategory) OR
      brand <> TRIM(brand) OR
	  product_status <>TRIM(product_status);

-- numeric validity
-- unit_cost < 0
SELECT COUNT(*)
FROM products_raw
WHERE unit_cost < 0;

-- list_price < 0
SELECT COUNT(*)
FROM products_raw
WHERE list_price < 0;

-- unit_cost > list_price
SELECT COUNT(*)
FROM products_raw
WHERE unit_cost > list_price;


