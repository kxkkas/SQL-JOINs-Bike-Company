🚴 Bike Company - SQL JOIN Practice

This project is part of my virtual internship at ELiteTech Intern.

📌 Task Objective:

Practice and demonstrate the use of SQL JOINs on two related tables:

customer

orders

🔍 Tables Used:

🧑 Customer Table

Contains customer details like ID, name, and age.

🛒 Orders Table

Contains order information like order ID, customer ID, and bike model.

🔗 JOINs Practiced

JOIN Type

Purpose

INNER JOIN

Show customers who have placed orders

LEFT JOIN

Show all customers, even if they have no orders

RIGHT JOIN

Show all orders, even if the customer is missing

FULL JOIN

Show all customers and all orders (matched or not)

🗄️ Queries Used

INNER JOIN:

SELECT c.id, c.name, c.age, o.bike_model
FROM customer c
INNER JOIN orders o ON c.id = o.customer_id;

LEFT JOIN:

SELECT c.id, c.name, c.age, o.bike_model
FROM customer c
LEFT JOIN orders o ON c.id = o.customer_id;

RIGHT JOIN:

SELECT c.id, c.name, c.age, o.bike_model
FROM customer c
RIGHT JOIN orders o ON c.id = o.customer_id;

FULL JOIN (using UNION in MySQL):

SELECT c.id, c.name, c.age, o.bike_model
FROM customer c
LEFT JOIN orders o ON c.id = o.customer_id

UNION

SELECT c.id, c.name, c.age, o.bike_model
FROM customer c
RIGHT JOIN orders o ON c.id = o.customer_id;

🖼️ Screenshots

Output results of each JOIN query are saved and included in the screenshots/ folder.

✅ Tools Used

MySQL Workbench

GitHub

Markdown for README

Made with ❤️ by Kashif KhanAspiring Data Scientist | SQL Enthusiast


