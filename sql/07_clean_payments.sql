-- create orders_cleaned 
SELECT * FROM payments_raw;

CREATE TABLE payments_cleaned
LIKE payments_raw;

INSERT payments_cleaned
SELECT *
FROM payments_raw;

SELECT * FROM payments_cleaned;

SELECT COUNT(*) FROM payments_cleaned;

DESCRIBE payments_cleaned;

-- standardize text
SELECT
	LOWER(TRIM(payment_id)) AS payment_id,
    LOWER(TRIM(order_id)) AS order_id,
    LOWER(TRIM(payment_date)) AS payment_date,
    LOWER(TRIM(payment_method)) AS payment_method,
    LOWER(TRIM(payment_status)) AS payment_status,
    LOWER(TRIM(amount_paid)) AS amount_paid,
    LOWER(TRIM(transaction_id)) AS transaction_id
FROM payments_cleaned;

UPDATE payments_cleaned
SET	payment_id = LOWER(TRIM(payment_id)),
    order_id = LOWER(TRIM(order_id)),
    payment_date = LOWER(TRIM(payment_date)),
    payment_method = LOWER(TRIM(payment_method)),
    payment_status = LOWER(TRIM(payment_status)),
    amount_paid = LOWER(TRIM(amount_paid)),
    transaction_id = LOWER(TRIM(transaction_id));
    

-- 3. Standardize payment methods
--    - cod → cash on delivery
--    - cc → credit card
--    - standardize UPI variants
-- 4. Standardize region
--    - w → west
-- 5. Handle missing values
--    - customer_id → investigate 25
--    - shipping_date → investigate 74
--    - price → investigate 35
-- 6. Investigate duplicate order records
--    - Review the 15 duplicate
--      (order_id + product_id + quantity + price)
--    - Remove only confirmed duplicates
-- 7. Handle invalid numeric values
--    - quantity <= 0 → investigate/correct/remove
--    - discount < 0 or > 1 → investigate/correct
--    - price < 0 → none found
--    - shipping_cost < 0 → none found
-- 8. Handle date inconsistencies
--    - order_date > current date → none
--    - shipping_date > current date → none
--    - shipping_date before order_date → investigate 196
-- 9. Handle broken relationships
--    - invalid/missing customer_id → investigate 37
--    - invalid product_id → investigate 10
-- 10. Handle business-rule inconsistencies
--     - Cancelled + shipping_date → investigate 337
--     - Pending + shipping_date → investigate 307
-- 11. Handle region inconsistencies
--     - Compare order region with customer region
--     - Investigate 208 mismatches
-- 12. Re-validate orders_cleaned
