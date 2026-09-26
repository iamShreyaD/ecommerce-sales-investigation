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
    
SELECT * FROM payments_cleaned;

-- standardize payment methods
SELECT DISTINCT payment_method, COUNT(*)
FROM payments_cleaned
GROUP BY payment_method;

-- cod → cash on delivery
UPDATE payments_cleaned
SET payment_method = 'cash on delivery'
WHERE payment_method = 'cod';

SELECT COUNT(*) FROM payments_cleaned WHERE payment_method = 'cod';

--    - cc → credit card
UPDATE payments_cleaned
SET payment_method = 'credit card'
WHERE payment_method = 'cc';

SELECT COUNT(*) FROM payments_cleaned WHERE payment_method = 'cc';

-- handle missing values
SELECT
	SUM(TRIM(payment_id) = '') AS blank_payment_id,
    SUM(TRIM(order_id) = '') AS blank_order_id,
    SUM(TRIM(payment_date) = '') AS blank_payment_date,
    SUM(TRIM(payment_method) = '') AS blank_payment_method,
    SUM(TRIM(payment_status) = '') AS blank_payment_status,
    SUM(TRIM(amount_paid) = '') AS blank_amount_paid,
    SUM(TRIM(transaction_id) = '') AS blank_transaction_id
FROM payments_cleaned;

-- payment_date → investigate/handle 30
SELECT * 
FROM payments_cleaned 
WHERE TRIM(payment_date) = '';

ALTER TABLE payments_cleaned
ADD COLUMN payment_date_flag VARCHAR(50);

UPDATE payments_cleaned
SET payment_date_flag = 'missing_payment_date'
WHERE TRIM(payment_date) = '' AND payment_status IN ('paid', 'refunded');

ALTER TABLE payments_cleaned
MODIFY COLUMN payment_date VARCHAR(50) NULL;

UPDATE payments_cleaned
SET payment_date = NULL
WHERE TRIM(payment_date) = '' AND payment_status IN ('failed', 'pending');

SELECT *
FROM payments_cleaned
WHERE payment_date IS NULL;

-- amount_paid → investigate/handle 18
SELECT * 
FROM payments_cleaned 
WHERE TRIM(amount_paid) = '';

ALTER TABLE payments_cleaned
ADD COLUMN amount_paid_flag VARCHAR(50);

UPDATE payments_cleaned
SET amount_paid_flag = 'missing_amount_paid'
WHERE TRIM(amount_paid) = '' AND payment_status = 'paid';

SELECT * FROM payments_cleaned
WHERE TRIM(amount_paid) = '' AND payment_status = 'paid';

DESCRIBE payments_cleaned;

ALTER TABLE payments_cleaned
MODIFY COLUMN amount_paid VARCHAR(50) NULL;

UPDATE payments_cleaned
SET amount_paid = NULL
WHERE TRIM(amount_paid) = '' AND payment_status IN ('failed', 'pending');

SELECT * FROM payments_cleaned WHERE amount_paid IS NULL;

-- transaction_id → investigate/handle 25
SELECT * 
FROM payments_cleaned 
WHERE TRIM(transaction_id) = '';

SELECT * FROM payments_cleaned;

-- investigate duplicate payment_id / transaction_id
-- review the 5 duplicated records
-- don't automatically delete them

-- investigate invalid order_ids
-- review the 12 records that don't match orders_raw
-- decide whether to remove, correct, or flag them

-- investigate payment amount/status inconsistencies
-- negative amount + non-refunded
-- zero amount + non-failed
-- positive amount + refunded
-- positive amount + failed

-- re-validate payments_cleaned

-- export payments_cleaned to csv
