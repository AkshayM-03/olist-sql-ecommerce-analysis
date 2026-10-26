USE olist_ecommerce;

-- 1. Missing values in the orders date columns
SELECT
  COUNT(*) AS total_orders,
  SUM(order_approved_at IS NULL) AS approved_null,
  SUM(order_approved_at = '') AS approved_blank,
  SUM(order_delivered_customer_date IS NULL) AS delivered_null,
  SUM(order_delivered_customer_date = '') AS delivered_blank
FROM orders;

-- 2. Order statuses
SELECT order_status, COUNT(*) AS orders
FROM orders
GROUP BY order_status
ORDER BY orders DESC;

-- 3. Missing values in products
SELECT
  COUNT(*) AS total_products,
  SUM(product_category_name IS NULL OR product_category_name = '') AS no_category,
  SUM(product_weight_g IS NULL OR product_weight_g = '') AS no_weight
FROM products;