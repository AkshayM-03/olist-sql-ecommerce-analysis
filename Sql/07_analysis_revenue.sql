USE olist_ecommerce;

-- Q1: Headline numbers (delivered orders only)
SELECT COUNT(DISTINCT o.order_id)                          AS delivered_orders,
       ROUND(SUM(oi.price), 2)                             AS revenue,
       ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';

-- Q2: Revenue and orders by month
SELECT DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
       COUNT(DISTINCT o.order_id)                       AS orders,
       ROUND(SUM(oi.price), 2)                          AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY month;