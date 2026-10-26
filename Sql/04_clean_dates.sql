USE olist_ecommerce;
SET SQL_SAFE_UPDATES = 0;

-- Backup first, in case something goes wrong
CREATE TABLE orders_backup AS SELECT * FROM orders;

-- Turn blank text into real NULLs
UPDATE orders
SET order_purchase_timestamp      = NULLIF(order_purchase_timestamp, ''),
    order_approved_at             = NULLIF(order_approved_at, ''),
    order_delivered_carrier_date  = NULLIF(order_delivered_carrier_date, ''),
    order_delivered_customer_date = NULLIF(order_delivered_customer_date, ''),
    order_estimated_delivery_date = NULLIF(order_estimated_delivery_date, '');

-- Change the text columns into real date-times
ALTER TABLE orders
  MODIFY order_purchase_timestamp      DATETIME,
  MODIFY order_approved_at             DATETIME,
  MODIFY order_delivered_carrier_date  DATETIME,
  MODIFY order_delivered_customer_date DATETIME,
  MODIFY order_estimated_delivery_date DATETIME;

ALTER TABLE order_items
  MODIFY shipping_limit_date DATETIME;
  
  
  SELECT COUNT(*) AS total,
       SUM(order_approved_at IS NULL) AS approved_null,
       SUM(order_delivered_customer_date IS NULL) AS delivered_null,
       MIN(order_purchase_timestamp) AS first_order,
       MAX(order_purchase_timestamp) AS last_order
FROM orders;