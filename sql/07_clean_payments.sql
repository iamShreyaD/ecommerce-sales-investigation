1. Create orders_cleaned using LIKE
2. Standardize text
   - TRIM categorical/text columns
   - Convert categorical values to lowercase
3. Standardize payment methods
   - cod → cash on delivery
   - cc → credit card
   - standardize UPI variants
4. Standardize region
   - w → west
5. Handle missing values
   - customer_id → investigate 25
   - shipping_date → investigate 74
   - price → investigate 35
6. Investigate duplicate order records
   - Review the 15 duplicate
     (order_id + product_id + quantity + price)
   - Remove only confirmed duplicates
7. Handle invalid numeric values
   - quantity <= 0 → investigate/correct/remove
   - discount < 0 or > 1 → investigate/correct
   - price < 0 → none found
   - shipping_cost < 0 → none found
8. Handle date inconsistencies
   - order_date > current date → none
   - shipping_date > current date → none
   - shipping_date before order_date → investigate 196
9. Handle broken relationships
   - invalid/missing customer_id → investigate 37
   - invalid product_id → investigate 10
10. Handle business-rule inconsistencies
    - Cancelled + shipping_date → investigate 337
    - Pending + shipping_date → investigate 307
11. Handle region inconsistencies
    - Compare order region with customer region
    - Investigate 208 mismatches
12. Re-validate orders_cleaned
