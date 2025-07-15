-- Create database and use it
CREATE DATABASE IF NOT EXISTS BIKE;
USE BIKE;

-- Drop tables if they already exist (avoids errors)
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS orders;

-- Create 'customer' table
CREATE TABLE customer (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age VARCHAR(10)
);

-- Insert records into 'customer'
INSERT INTO customer (id, name, age) VALUES
(1, 'Kashif', '21'),
(2, 'Saud', '24'),
(3, 'Lavanya', '25'),
(4, 'Khan', '26'),
(5, 'Afraz', '30'),
(6, 'Deepak', '23'),
(7, 'Nikhil', '28'),
(8, 'Farah', '26'),
(9, 'Afan', '29'),
(10, 'Esa', '32'),
(11, 'Ishaan', '23');

-- Create 'orders' table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    bike_model VARCHAR(50)
);

-- Insert records into 'orders'
INSERT INTO orders (order_id, customer_id, bike_model) VALUES
(105, 3, 'TVS Apache'),
(106, 5, 'Hero Splendor'),
(107, 6, 'KTM Duke'),
(108, 7, 'Suzuki Gixxer'),
(109, 8, 'Yamaha MT-15'),
(110, 10, 'Bajaj Pulsar'),
(111, 1, 'Royal Enfield Hunter'),
(112, 14, 'Jawa 42'),           -- Invalid customer (not in customer table)
(113, 16, 'Bajaj Avenger'),     -- Invalid customer
(114, 9, 'Yamaha R15');

-- 🔸 INNER JOIN: Only matching records
SELECT c.id, c.name, c.age, o.bike_model
FROM customer c
INNER JOIN orders o ON c.id = o.customer_id;

-- 🔸 LEFT JOIN: All customers + matching orders
SELECT c.id, c.name, c.age, o.bike_model
FROM customer c
LEFT JOIN orders o ON c.id = o.customer_id;

-- 🔸 RIGHT JOIN: All orders + matching customers
SELECT c.id, c.name, c.age, o.bike_model
FROM customer c
RIGHT JOIN orders o ON c.id = o.customer_id;

-- 🔸 FULL JOIN: Simulated using UNION
SELECT c.id, c.name, c.age, o.bike_model
FROM customer c
LEFT JOIN orders o ON c.id = o.customer_id

UNION

SELECT c.id, c.name, c.age, o.bike_model
FROM customer c
RIGHT JOIN orders o ON c.id = o.customer_id;
