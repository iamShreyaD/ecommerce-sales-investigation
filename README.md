
# E-commerce Sales Investigation

## 📌 Project Overview

This project simulates an e-commerce company's sales database and uses SQL to investigate business performance, customer behavior, product performance, and sales trends.

The project is intentionally built from **messy raw data**. Before performing the analysis, the data is inspected, validated, cleaned, and checked for consistency.

---

## 🎯 Business Problem

The e-commerce company wants to understand:

* How revenue is changing over time
* Which products and categories drive sales
* Which customers generate the most revenue
* Which regions and channels perform well or poorly
* Which products are declining in sales
* Which customers have become inactive
* Whether the underlying data is reliable enough for decision-making

---

## 🗂️ Dataset

The database contains four tables:

### `customers`
### `products`
### `orders`
### `payments`
---

## 🧹 Data Quality & Cleaning

The raw dataset intentionally contains realistic data-quality issues, including:

* Missing values
* Duplicate records
* Inconsistent capitalization
* Inconsistent category and region names
* Mixed date formats
* Invalid dates
* Invalid quantities
* Invalid product/customer references
* Inconsistent payment methods
* Formatting problems in numeric columns
* Potentially inconsistent order and shipping dates
* Potential inconsistencies between related tables

The first stage of the project is therefore **data validation**, not analysis.

---

## 🔍 Data Validation

Validation checks include:

* Duplicate primary keys
* Missing required fields
* Invalid numeric values
* Invalid dates
* Shipping dates occurring before order dates
* Invalid customer references
* Invalid product references
* Unexpected categorical values
* Duplicate payment transactions
* Inconsistent payment and order statuses
* Inconsistencies between customer and order attributes

---

## 📊 Business Questions

### Sales Performance

1. What is total revenue?
2. What is monthly revenue?
3. What is the average order value?
4. Which products generate the most revenue?
5. Which categories generate the most revenue?
6. Which regions perform best and worst?
7. Which sales channel generates the most revenue?

### Customer Analysis

8. Which customers spend the most?
9. Who are the top 10 customers by revenue?
10. Which customers place the most orders?
11. Which customers haven't ordered recently?
12. Which customer segment generates the most revenue?
13. What percentage of revenue comes from the top 10 customers?

### Product Analysis

14. Which products have declining sales?
15. Which products have increasing sales?
16. Which products have the highest profit margin?
17. Which products have never been sold?
18. Which categories have the highest average order value?

### Time-Based Analysis

19. Which month had the highest revenue?
20. Which month had the lowest revenue?
21. What is month-over-month revenue growth?
22. What is cumulative revenue over time?
23. What is the 3-month rolling revenue?
24. Which products experienced the largest month-over-month decline?

