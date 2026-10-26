USE olist_ecommerce;

-- Orphan and logic checks (0 = healthy, unless noted)
SELECT 'orders without customer' AS check_name, COUNT(*) AS problem_rows
FROM orders o LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL
UNION ALL SELECT 'order_items without order', COUNT(*)
FROM order_items oi LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL
UNION ALL SELECT 'order_items without product', COUNT(*)
FROM order_items oi LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL
UNION ALL SELECT 'payments without order', COUNT(*)
FROM order_payments op LEFT JOIN orders o ON op.order_id = o.order_id
WHERE o.order_id IS NULL
UNION ALL SELECT 'orders without items', COUNT(*)
FROM orders o LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL
UNION ALL SELECT 'orders without payment', COUNT(*)
FROM orders o LEFT JOIN order_payments op ON o.order_id = op.order_id
WHERE op.order_id IS NULL
UNION ALL SELECT 'delivered before purchased', COUNT(*)
FROM orders
WHERE order_delivered_customer_date < order_purchase_timestamp;

-- Repeat customers
SELECT COUNT(*) AS customer_ids,
       COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM customers;