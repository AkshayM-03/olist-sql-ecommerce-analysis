USE olist_ecommerce;

-- Q5: How many customers come back? (real people, delivered orders only)
WITH cust AS (
  SELECT c.customer_unique_id,
         COUNT(DISTINCT o.order_id) AS orders,
         SUM(oi.price)              AS spend
  FROM orders o
  JOIN customers c   ON o.customer_id = c.customer_id
  JOIN order_items oi ON o.order_id = oi.order_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
)
SELECT COUNT(*)                                                   AS customers,
       SUM(orders > 1)                                            AS repeat_customers,
       ROUND(100 * SUM(orders > 1) / COUNT(*), 1)                 AS repeat_pct,
       ROUND(100 * SUM(CASE WHEN orders > 1 THEN spend ELSE 0 END)
                 / SUM(spend), 1)                                 AS repeat_revenue_pct
FROM cust;

-- Q6: Top 10 customers by total spend
SELECT RANK() OVER (ORDER BY SUM(oi.price) DESC) AS spend_rank,
       c.customer_unique_id,
       COUNT(DISTINCT o.order_id)                AS orders,
       ROUND(SUM(oi.price), 2)                   AS spend
FROM orders o
JOIN customers c    ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
ORDER BY spend DESC
LIMIT 10;

-- Q7: Delivery performance
SELECT COUNT(*) AS delivered_orders,
       ROUND(AVG(DATEDIFF(order_delivered_customer_date,
                          order_purchase_timestamp)), 1)          AS avg_delivery_days,
       ROUND(100 * SUM(order_delivered_customer_date >
                       order_estimated_delivery_date) / COUNT(*), 1) AS late_pct
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;