-- ============================================
-- 👨‍💻 TASK 2: Advanced SQL Analysis - Bike Company
-- ============================================

-- 🏁 Use the BIKE database
USE BIKE;

-- ============================================
-- 🚲 TABLE 1: Bikes
-- ============================================
DROP TABLE IF EXISTS bikes;

CREATE TABLE bikes (
    bike_id INT PRIMARY KEY,
    model_name VARCHAR(50),
    brand VARCHAR(50),
    price DECIMAL(10,2),
    type VARCHAR(20)
);

-- 🔻 Insert bike models and details
INSERT INTO bikes (bike_id, model_name, brand, price, type) VALUES
(1, 'Royal Enfield Hunter', 'Royal Enfield', 150000, 'Cruiser'),
(2, 'Yamaha MT-15', 'Yamaha', 160000, 'Sport'),
(3, 'Suzuki Gixxer', 'Suzuki', 145000, 'Sport'),
(4, 'Bajaj Pulsar', 'Bajaj', 135000, 'Commuter'),
(5, 'Hero Splendor', 'Hero', 90000, 'Commuter');

-- ============================================
-- 🧾 TABLE 2: Orders
-- ============================================
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    bike_model VARCHAR(50)
);

-- 🔻 Sample orders placed by customers
INSERT INTO orders (order_id, customer_id, bike_model) VALUES
(105, 3, 'TVS Apache'),
(106, 5, 'Hero Splendor'),
(107, 2, 'KTM Duke'),
(108, 7, 'Suzuki Gixxer'),
(109, 8, 'Yamaha MT-15'),
(110, 10, 'Bajaj Pulsar'),
(111, 1, 'Royal Enfield Hunter'),
(114, 2, 'Yamaha MT-15');

-- ============================================
-- 📦 TABLE 3: Order Details
-- ============================================
DROP TABLE IF EXISTS order_details;

CREATE TABLE order_details (
    order_id INT,
    bike_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (bike_id) REFERENCES bikes(bike_id)
);

-- 🔻 Quantities of each bike ordered
INSERT INTO order_details (order_id, bike_id, quantity) VALUES
(105, 5, 2),
(106, 5, 1),
(107, 2, 1),
(108, 3, 1),
(109, 2, 1),
(110, 4, 2),
(111, 1, 1),
(114, 2, 1);

-- ============================================
-- 💰 TABLE 4: Payments
-- ============================================
DROP TABLE IF EXISTS payments;

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    method VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- 🔻 Payment details for each order
INSERT INTO payments (payment_id, order_id, amount, payment_date, method) VALUES
(1, 105, 180000.00, '2025-07-01', 'UPI'),
(2, 106, 90000.00, '2025-07-03', 'Card'),
(3, 107, 160000.00, '2025-07-03', 'UPI'),
(4, 108, 145000.00, '2025-07-05', 'Cash'),
(5, 109, 160000.00, '2025-07-08', 'UPI'),
(6, 110, 270000.00, '2025-07-10', 'Card'),
(7, 111, 150000.00, '2025-07-12', 'Cash'),
(8, 114, 160000.00, '2025-07-15', 'UPI');

-- ============================================
-- 📊 QUERY 1: Total Quantity Sold per Bike
-- ============================================
SELECT 
    b.model_name,
    SUM(od.quantity) AS order_quantity
FROM 
    order_details od
JOIN 
    bikes b ON od.bike_id = b.bike_id
GROUP BY 
    b.model_name
ORDER BY 
    order_quantity DESC;

-- ============================================
-- 💸 QUERY 2: Top 3 Bikes by Total Revenue
-- ============================================
SELECT * FROM (
    SELECT 
        b.model_name,
        SUM(b.price * od.quantity) AS total_revenue
    FROM order_details od
    JOIN bikes b ON od.bike_id = b.bike_id
    GROUP BY b.model_name
) AS bike_sales
ORDER BY total_revenue DESC
LIMIT 3;

-- ============================================
-- 🏆 QUERY 3: Rank Bikes by Revenue (Window Function)
-- ============================================
SELECT 
    b.model_name,
    SUM(b.price * od.quantity) AS total_revenue,
    RANK() OVER (ORDER BY SUM(b.price * od.quantity) DESC) AS revenue_rank
FROM 
    order_details od
JOIN bikes b ON od.bike_id = b.bike_id
GROUP BY 
    b.model_name;

-- ============================================
-- 💳 QUERY 4: Total Payment Amount by Method (Using CTE)
-- ============================================
WITH payment_totals AS (
    SELECT method, SUM(amount) AS total_paid
    FROM payments
    GROUP BY method
)
SELECT * FROM payment_totals
ORDER BY total_paid DESC;
