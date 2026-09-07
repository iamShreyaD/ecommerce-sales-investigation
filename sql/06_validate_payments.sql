
-- row count
SELECT COUNT(*)
FROM payments_raw;

-- preview of data
SELECT *
FROM payments_raw
LIMIT 10;

-- description of data
DESCRIBE payments_raw;

-- NULL/blank data
SELECT
	SUM(payment_id IS NULL OR TRIM(payment_id) = '') AS missing_payment_id,
    SUM(order_id IS NULL OR TRIM(order_id) = '') AS missing_order_id,
    SUM(payment_date IS NULL OR TRIM(payment_date) = '') AS missing_payment_date,
    SUM(payment_method IS NULL OR TRIM(payment_method) = '') AS missing_payment_method,
    SUM(payment_status IS NULL OR TRIM(payment_status) = '') AS missing_payment_status,
    SUM(amount_paid IS NULL OR TRIM(amount_paid) = '') AS missing_amount_paid,
    SUM(transaction_id IS NULL OR TRIM(transaction_id) = '') AS missing_transaction_id
FROM payments_raw;
    
-- duplication of payments: payment_id (which is not primary key), transaction_id
SELECT payment_id, transaction_id, COUNT(*)
FROM payments_raw
GROUP BY payment_id, transaction_id
HAVING COUNT(*) > 1;

-- distinct values for categorical records like
-- payment_id
SELECT DISTINCT payment_id, COUNT(*)
FROM payments_raw
GROUP BY payment_id
ORDER BY COUNT(*) DESC;

-- order_id
SELECT DISTINCT order_id, COUNT(*)
FROM payments_raw
GROUP BY order_id
ORDER BY COUNT(*) DESC;

-- payment_method
SELECT DISTINCT payment_method, COUNT(*)
FROM payments_raw
GROUP BY payment_method
ORDER BY COUNT(*) DESC;

-- payment_status
SELECT DISTINCT payment_status, COUNT(*)
FROM payments_raw
GROUP BY payment_status
ORDER BY COUNT(*) DESC;

-- transaction_id
SELECT DISTINCT transaction_id, COUNT(*)
FROM payments_raw
GROUP BY transaction_id
ORDER BY COUNT(*) DESC;

-- numeric validity: 
-- if amount_paid < 0 and payment_status <> 'Refunded'
SELECT COUNT(*)
FROM payments_raw
WHERE amount_paid < 0 AND payment_status <> 'Refunded';

-- if amount_paid == 0 and payment_status <> 'Failed'
SELECT COUNT(*)
FROM payments_raw
WHERE amount_paid = 0 AND PAYMENT_STATUS <> 'Failed';

-- if amount_paid > 0 and payment_status IS 'Refunded'
SELECT COUNT(*)
FROM payments_raw
WHERE amount_paid > 0 AND payment_status = 'Refunded';

-- if amount_paid > 0 and payment_status <> 'Failed'
SELECT COUNT(*)
FROM payments_raw
WHERE amount_paid > 0 AND payment_status = 'Failed';

-- if payment_method IS NOT 'Credit Card' and payment_status <> 'Pending'
SELECT COUNT(*)
FROM payments_raw
WHERE payment_method <> 'Credit Card' AND payment_status = 'Pending';

-- date validation: payment_date < current_date()
SELECT COUNT(*)
FROM payments_raw
WHERE payment_date > CURRENT_DATE(); 

-- referential integrity: if order_id in payments_raw exists in orders_raw
SELECT COUNT(*) AS invalid_order_ids
FROM payments_raw AS p
LEFT JOIN orders_raw AS o ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

-- white space issues for categorical columns
SELECT COUNT(*)
FROM payments_raw
WHERE payment_id <> TRIM(payment_id) OR
	  order_id <> TRIM(order_id) OR
      payment_method <> TRIM(payment_method) OR
      payment_status <> TRIM(payment_status) OR
      transaction_id <> TRIM(transaction_id);
      
