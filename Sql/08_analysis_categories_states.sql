USE olist_ecommerce;

-- Q3: Top 10 categories by revenue (delivered orders)
SELECT COALESCE(t.product_category_name_english,
                p.product_category_name, 'unknown')   AS category,
       COUNT(DISTINCT o.order_id)                     AS orders,
       ROUND(SUM(oi.price), 2)                        AS revenue,
       ROUND(100 * SUM(oi.price) / SUM(SUM(oi.price)) OVER (), 1) AS pct_of_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN category_translation t ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;

-- Q4: Top 10 states by revenue
SELECT c.customer_state,
       COUNT(DISTINCT o.order_id)                          AS orders,
       ROUND(SUM(oi.price), 2)                             AS revenue,
       ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY revenue DESC
LIMIT 10;