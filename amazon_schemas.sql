--creating data base
CREATE DATABASE amazone_project_p6;
--dropping tables if such exist
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS sellers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS order_item;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS shipping;

--creating tables
--category
CREATE TABLE category
	(category_id INT PRIMARY KEY,
	category_name VARCHAR(50));

--customers
CREATE TABLE customers
	(customer_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	state VARCHAR(50),
	address VARCHAR(10) DEFAULT 'xxxx');
--sellers
CREATE TABLE sellers
	(seller_id INT PRIMARY KEY,
	seller_name VARCHAR(50),
	origin VARCHAR(100));

--products
CREATE TABLE products
	(product_id INT PRIMARY KEY,
	product_name VARCHAR(200),
	price FLOAT,
	cogs FLOAT,
	category_id INT,
	CONSTRAINT products_fk_category
	FOREIGN KEY (category_id) REFERENCES category(category_id))-- comes from category, FK);

--inventory
CREATE TABLE inventory
	(inventory_id INT PRIMARY KEY,
	product_id INT,
	CONSTRAINT inventory_fk_product
	FOREIGN KEY (product_id) REFERENCES products(product_id),--comes from products, FK
	stock INT,
	warehouse_id INT,
	last_stock_date DATE);
--orders
CREATE TABLE orders
	(order_id INT PRIMARY KEY,
	order_date DATE,
	customer_id INT,
	CONSTRAINT orders_fk_customers
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id), --comes from customers, FK
	seller_id INT,
	CONSTRAINT orders_fk_sellers 
	FOREIGN KEY (seller_id)  REFERENCES sellers(seller_id ),-- comes from sellers, FK
	order_status VARCHAR(50));

--order_item
CREATE TABLE order_item
	(order_item_id INT PRIMARY KEY,
	order_id INT,
	CONSTRAINT oitems_fk_orders 
	FOREIGN KEY (order_id) REFERENCES orders(order_id), --comes from orders, FK
	product_id INT,
	CONSTRAINT oitem_fk_products
	FOREIGN KEY (product_id) REFERENCES products(product_id), -- comes from products, FK
	quantity INT,
	price_per_unit FLOAT)

--payments
CREATE TABLE payments
	(payment_id INT PRIMARY KEY,
	order_id INT, 
	CONSTRAINT payments_fk_orders
	FOREIGN KEY (order_id) REFERENCES orders(order_id),  -- comes from orders, FK
	payment_date DATE,
	payment_status VARCHAR(100));

--shipping
CREATE TABLE shipping
	(shipping_id INT PRIMARY KEY,
	order_id INT,
	CONSTRAINT shipping_fk_orders
	FOREIGN KEY (order_id) REFERENCES orders(order_id), -- comes from orders, FK
	shipping_date DATE,
	return_date DATE,
	shipping_providers VARCHAR(50),
	delivery_status VARCHAR(50));

--End of schemas--