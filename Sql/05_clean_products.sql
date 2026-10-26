USE olist_ecommerce;
SET SQL_SAFE_UPDATES = 0;

-- Backup first
CREATE TABLE products_backup AS SELECT * FROM products;

-- Turn blank text into real NULLs
UPDATE products
SET product_category_name       = NULLIF(product_category_name, ''),
    product_name_lenght         = NULLIF(product_name_lenght, ''),
    product_description_lenght  = NULLIF(product_description_lenght, ''),
    product_photos_qty          = NULLIF(product_photos_qty, ''),
    product_weight_g            = NULLIF(product_weight_g, ''),
    product_length_cm           = NULLIF(product_length_cm, ''),
    product_height_cm           = NULLIF(product_height_cm, ''),
    product_width_cm            = NULLIF(product_width_cm, '');

-- Change the text number columns into real integers
ALTER TABLE products
  MODIFY product_name_lenght        INT,
  MODIFY product_description_lenght INT,
  MODIFY product_photos_qty         INT,
  MODIFY product_weight_g           INT,
  MODIFY product_length_cm          INT,
  MODIFY product_height_cm          INT,
  MODIFY product_width_cm           INT;

-- Fix the "lenght" spelling from the original file
ALTER TABLE products
  RENAME COLUMN product_name_lenght TO product_name_length,
  RENAME COLUMN product_description_lenght TO product_description_length;
  
  
  SELECT COUNT(*) AS total,
       SUM(product_category_name IS NULL) AS no_category,
       SUM(product_weight_g IS NULL) AS no_weight,
       MIN(product_weight_g) AS lightest_g,
       MAX(product_weight_g) AS heaviest_g
FROM products;