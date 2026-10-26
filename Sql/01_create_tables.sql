
use olist_ecommerce;

CREATE TABLE customers (
  customer_id VARCHAR(50) PRIMARY KEY,
  customer_unique_id VARCHAR(50),
  customer_zip_code_prefix VARCHAR(10),
  customer_city VARCHAR(100),
  customer_state CHAR(2)
);

CREATE TABLE orders (
  order_id VARCHAR(50) PRIMARY KEY,
  customer_id VARCHAR(50),
  order_status VARCHAR(20),
  order_purchase_timestamp VARCHAR(30),
  order_approved_at VARCHAR(30),
  order_delivered_carrier_date VARCHAR(30),
  order_delivered_customer_date VARCHAR(30),
  order_estimated_delivery_date VARCHAR(30)
);

CREATE TABLE order_items (
  order_id VARCHAR(50),
  order_item_id INT,
  product_id VARCHAR(50),
  seller_id VARCHAR(50),
  shipping_limit_date VARCHAR(30),
  price DECIMAL(10,2),
  freight_value DECIMAL(10,2),
  PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE products (
  product_id VARCHAR(50) PRIMARY KEY,
  product_category_name VARCHAR(100),
  product_name_lenght VARCHAR(20),
  product_description_lenght VARCHAR(20),
  product_photos_qty VARCHAR(20),
  product_weight_g VARCHAR(20),
  product_length_cm VARCHAR(20),
  product_height_cm VARCHAR(20),
  product_width_cm VARCHAR(20)
);

CREATE TABLE order_payments (
  order_id VARCHAR(50),
  payment_sequential INT,
  payment_type VARCHAR(30),
  payment_installments INT,
  payment_value DECIMAL(10,2),
  PRIMARY KEY (order_id, payment_sequential)
);

CREATE TABLE category_translation (
  product_category_name VARCHAR(100) PRIMARY KEY,
  product_category_name_english VARCHAR(100)
);


show tables;



