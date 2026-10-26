# Olist E-commerce Sales Analysis (SQL)

End-to-end SQL project in MySQL: I imported 6 tables of a Brazilian marketplace (99,441 orders, 2016-2018), cleaned the data, checked its integrity and answered business questions on revenue, categories, regions, customers and delivery.

## Dataset
[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) from Kaggle. Tables used: customers, orders, order_items, products, order_payments, category_translation.

## Tools and SQL skills
MySQL 8, MySQL Workbench. Joins (inner, left, anti-join), GROUP BY, CTEs, window functions (RANK, SUM OVER), COALESCE, NULLIF, CASE, date functions, data type conversion.

## Definitions
Revenue = product price of delivered orders only (freight excluded; canceled and unfinished orders excluded). Customers are counted by customer_unique_id, because customer_id changes with every order.

## Project steps
1. 01_create_tables.sql and 02_row_counts.sql: created 6 tables, imported the CSVs, verified every row count.
2. 03_data_profiling.sql: found 160 blank approval dates, 2,965 blank delivery dates and 610 products with no category.
3. 04_clean_dates.sql and 05_clean_products.sql: turned blank text into NULLs, converted text columns to DATETIME and INT, fixed a misspelled column name.
4. 06_integrity_checks.sql: found no orphan records and no orders delivered before they were purchased.
5. 07 to 09 analysis scripts: revenue trend, categories, states, customers, delivery.

## Key findings
- Revenue: 13.2M across 96,478 delivered orders, average order value 137.
- Growth: Jan-Aug 2018 revenue was 7.22M against 2.99M in Jan-Aug 2017 (+141%).
- Peak: November 2017 had 7,289 orders and 987,765 in revenue, 52% above October (likely Black Friday), then fell 26% in December. Monthly revenue stayed flat at about 826K to 978K through 2018.
- Categories: health_beauty (9.3% of revenue), watches_gifts (8.8%) and bed_bath_table (7.7%) lead. The top 10 categories make up about 62% of revenue. bed_bath_table has the most orders, but watches_gifts earns more per order (about 212 against 110).
- Regions: Sao Paulo alone is 38% of revenue and 42% of orders. SP, RJ and MG together make up 63%. SP has the lowest average order value of the top 10 states (125).
- Customers: only 3.0% of customers (2,801 of 93,358) ever ordered again, and they bring 5.5% of revenue. 9 of the top 10 spenders ordered only once, so revenue does not depend on a few big buyers.
- Delivery: 12.5 days on average from purchase to delivery, and 8.1% of orders arrive after the estimated date.

## Data quality notes
- Blank dates were stored as empty text on import and were converted to NULL.
- 775 orders have no items (mostly canceled or unavailable), so revenue is always calculated from order_items.
- 1 order has no payment record, 610 products have no category and 1 product has a weight of 0 g.
- 8 delivered orders have no delivery date and are left out of the delivery metrics.
- Late 2016 has very few orders and the data ends in August 2018 for delivered orders, so those months are left out of trend claims.
- Revenue is by customer state, not seller state.

## Results
![Monthly revenue](results/monthly_revenue.png)
![Top categories](results/top_categories.png)

## How to reproduce
Download the dataset from Kaggle, create a database called olist_ecommerce, run the scripts in the sql folder in numeric order, and import each CSV with the Table Data Import Wizard after running 01_create_tables.sql.
