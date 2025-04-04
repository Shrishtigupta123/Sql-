#SQL Assignment
# 1. Create a table called employees with the following structure?
# emp_id (integer, should not be NULL and should be a primary key).
# emp_name (text, should not be NULL).
# age (integer, should have a check constraint to ensure the age is at least 18).
# email (text, should be unique for each employee).
# salary (decimal, with a default value of 30,000).
#Write the SQL query to create the above table with all constraints.

-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS employees;

-- Use the correct database
USE employees;

-- Create the employees table
CREATE TABLE employees (
    emp_id INTEGER NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL, 
    age INTEGER CHECK (age >= 18),
    email TEXT ,
    salary DECIMAL DEFAULT 30000
);

#2.  Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
#examples of common types of constraints
#ANS: Constraints in a database are rules applied to table columns to ensure the accuracy, reliability, and integrity of the data. 
#They enforce certain conditions that the data must satisfy, preventing invalid or inconsistent data from being stored in the database. 
#These rules help maintain data quality and ensure that relationships between tables remain consistent.

#Here’s how constraints help maintain data integrity:
#Prevent Invalid Entries: Constraints restrict the type, format, or range of data values, ensuring only valid data is entered.
#Enforce Business Rules: They ensure that the database aligns with the real-world rules of the business it models (e.g., no duplicate IDs).
#Maintain Relationships: Constraints preserve the logical relationships between tables, such as ensuring foreign keys correspond to valid primary keys.

#Common Types of Constraints with Examples:
# 1) NOT NULL Constraint: It Ensures that a column cannot have null (empty) values.
#Example: In a "Users" table, the "Username" field might have a NOT NULL constraint to ensure every user has a username.

#2)UNIQUE Constraint: Guarantees that all values in a column are unique.
#Example: In a "Customers" table, the "Email" field might have a UNIQUE constraint to prevent duplicate email addresses.

#3)PRIMARY KEY Constraint:Combines NOT NULL and UNIQUE constraints to uniquely identify each record in a table.
#Example: A "Student" table might have a "StudentID" as the primary key.

#4)FOREIGN KEY Constraint:Ensures that a value in one table corresponds to a valid value in another table, maintaining referential integrity.
#Example: An "Orders" table might have a "CustomerID" column that references the "CustomerID" in the "Customers" table.

#5)CHECK Constraint:Ensures that values in a column meet specific conditions.
#Example: A "Products" table might use a CHECK constraint on the "Price" column to allow only positive values.

#6)DEFAULT Constraint:Automatically assigns a default value to a column if no value is specified.
#Example: In an "Employees" table, the "HireDate" field might have a default value of the current date.

#3. Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.
#ANS: The NOT NULL constraint is applied to a column to ensure that it always contains valid data, preventing null (empty) values. 
#This is useful when the column is essential for the functionality or logic of the database, like in cases where missing values would disrupt operations or lead to ambiguity. 
#For example, you might use a NOT NULL constraint on a "Username" column because every user in the system must have a username to be identifiable
#Can a Primary Key contain NULL values?
#No, a primary key cannot contain NULL values, and here's why:
#- Uniqueness: A primary key uniquely identifies each record in a table. 
#If a primary key were allowed to have NULL values, it would compromise its ability to distinguish between records because NULL represents an unknown or undefined value, which is not unique.
#-Integrity: Primary keys are used to enforce entity integrity in a database. 
#They ensure that every record in the table can be precisely identified. 
#NULL values would contradict this principle by introducing ambiguity.
#For example, imagine a "Student" table where the "StudentID" is the primary key. 
#If the "StudentID" column were allowed to contain NULL, it would be impossible to identify students with missing IDs, disrupting relationships with other tables that depend on the primary key for referential integrity.
#The combination of NOT NULL and UNIQUE constraints ensures the properties of a primary key are upheld. Let me know if you'd like to explore more scenarios or constraints!
    
#4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint
#ANS: Adding or removing constraints on an existing table typically requires altering the table's structure using SQL commands. 
#Below are the steps and examples for both actions:
#Steps to Add a Constraint:
-- 1) Use the ALTER TABLE command to modify the table.
-- 2) Specify the type of constraint to be added (e.g.,NOT NULL , UNIQUE , FOREGIN KEY).
-- 3) Define the constraint and specify the column it applies to.
-- Example: Add a UNIQUE Constraint:
#Suppose you want to ensure the "email" column in a "Users" table has unique values:
ALTER TABLE Users
ADD CONSTRAINT unique_email UNIQUE (email);
#This command:Alters the "Users" table. Adds a constraint named "unique_email" that ensures the "email" column contains unique values.

-- #Steps to Remove a Constraint:
-- 1)Use the  command to modify the table.
-- 2)Use the DROP CONSTRAINT clause, specifying the name of the constraint to be removed.
-- Example: Remove a UNIQUE Constraint
-- Suppose you want to remove the "unique_email" constraint from the "Users" table:
ALTER TABLE Users
DROP CONSTRAINT unique_email;

#This command: Alters the "Users" table.Drops (removes) the constraint named "unique_email".

#5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
#Provide an example of an error message that might occur when violating a constraint
-- ANS: When inserting, updating, or deleting data in a way that violates constraints, the database prevents the operation and returns an error. 
-- This helps maintain data integrity and consistency.
-- Consequences of Violating Constraints:
-- 1)Insertion Violation:If you try to insert data that doesn't comply with a constraint, the operation will fail.
-- Example: Attempting to insert a NULL value into a column with a  NOT NULL constraint.
-- 2)Update Violation:When updating a record, if the new data violates a constraint, the update won't be allowed.
-- Example: Updating a column value to duplicate an existing value in a column with a UNIQUE constraint.
-- 3)Deletion Violation:If you try to delete a row that is referenced by a FOREIGN KEY  in another table, the DBMS will reject the deletion.
-- Example: Deleting a row from a "Customer" table that is referenced in an "Orders" table.

-- Example of Error Message:
-- Here’s an example of a SQL error message that might occur when violating a FOREIGN KEY constraint:
-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`Orders`, CONSTRAINT `fk_customer` FOREIGN KEY (`CustomerID`) REFERENCES `Customers` (`CustomerID`))
-- This error typically means you're attempting to delete a record from the "Customers" table while there are related rows in the "Orders" table

#6.  You created a products table without constraints as follows:

CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));
-- Now, you realise that?
-- : The product_id should be a primary keyQ
-- : The price should have a default value of 50.00


ALTER TABLE products 
MODIFY product_id INT NOT NULL PRIMARY KEY,   -- Make product_id a PRIMARY KEY
MODIFY price DECIMAL(10,2) DEFAULT 50.00;    -- Set default price to 50.00
INSERT INTO products (product_id, product_name) 
VALUES (1, 'Laptop');

SELECT * FROM products;


#7. You have two tables:
#Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

CREATE TABLE Students  (
student_id int, student_name varchar(30), class_id int);
INSERT INTO Students (student_id, student_name, class_id) VALUES (1, 'Alice', 101);
INSERT INTO Students (student_id, student_name, class_id) VALUES (2, 'Bob', 102);
INSERT INTO Students (student_id, student_name, class_id) VALUES (3, 'Charlie', 101);
SELECT * FROM Students;

CREATE TABLE Classes (class_id int, class_name varchar(30));
INSERT INTO Classes (class_id, class_name) VALUES (101, 'Math');
INSERT INTO Classes (class_id, class_name) VALUES (102, 'Science');
INSERT INTO Classes (class_id, class_name) VALUES (103, 'History');
SELECT * FROM Classes;

SELECT Students.student_name, Classes.class_name
FROM Students
INNER JOIN Classes ON Students.class_id = Classes.class_id;

#8.  Consider the following three tables:
-- Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
-- listed even if they are not associated with an order 

-- Hint: (use INNER JOIN and LEFT JOIN)5

CREATE TABLE Orders (order_id int, order_date date, customer_id int);
INSERT INTO Orders (order_id, order_date, customer_id) VALUES (1, '2024-01-01', 101);
INSERT INTO Orders (order_id, order_date, customer_id) VALUES (2, '2024-01-03', 102);
SELECT * FROM Orders;

CREATE TABLE Customers (customer_id int, customer_name varchar(30));
INSERT INTO Customers (customer_id, customer_name) VALUES (101, 'Alice');
INSERT INTO Customers (customer_id, customer_name) VALUES (102, 'Bob');
SELECT * FROM Customers;

DESC Products;
ALTER TABLE Products ADD COLUMN order_id INT;
UPDATE Products 
SET order_id = 1 
WHERE product_id = 1;
ALTER TABLE Products MODIFY product_id INT AUTO_INCREMENT;
DELETE FROM Products WHERE product_id = 1;
DELETE FROM Products WHERE product_id = 2;
INSERT INTO Products (product_id, product_name, order_id) VALUES (1, 'Laptop', 1);
INSERT INTO Products (product_id, product_name, order_id) VALUES (2, 'Phone', Null);
SELECT * FROM Products;

select Products.order_id,Customers.customer_name, Products.product_name
from Products
left join Orders on Products.order_id= Orders.order_id
left join Customers on Orders.customer_id = Customers.customer_id;

#9. Given the following tables:
-- Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
CREATE TABLE Sales (sale_id int, product_id int, amount int);
INSERT INTO Sales (sale_id, product_id, amount) VALUES (1, 101, 500);
INSERT INTO Sales (sale_id, product_id, amount) VALUES (2, 102, 300);
INSERT INTO Sales (sale_id, product_id, amount) VALUES (3, 101, 700);
SELECT * FROM Sales;

select Products.product_name, sum(Sales.amount) as total_sales
from sales 
inner join Products on Sales.product_id = Products.product_id
group by Products.product_name;

#10. You are given three tables
-- Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between all three tables
CREATE TABLE Orders_Details (order_id int, product_id int, quantity int);
INSERT INTO Orders_Details (order_id, product_id, quantity) VALUES (1, 101, 2);
INSERT INTO Orders_Details (order_id, product_id, quantity) VALUES (1, 102, 1);
INSERT INTO Orders_Details (order_id, product_id, quantity) VALUES (2, 101, 3);
SELECT * FROM Orders_Details;

select Orders_Details.order_id, Customers.customer_name, sum(Orders_Details.quantity) as total_quantity
from Orders_Details
inner join Orders on Orders_Details.order_id = Orders.order_id
inner join Customers on Orders.customer_id = Customers.customer_id
group by Orders_Details.order_id, Customers.customer_name;



# SQL Commands
#1.Identify the primary keys and foreign keys in maven movies db. Discuss the differences
#ANS: 
create database Mavenmovies;
use Mavenmovies;
-- The Maven Movies database contains several tables, each with primary and foreign keys to maintain data integrity and relationships.
-- Primary Keys:Customer Table: customer_id is the primary key.
-- Film Table: film_id is the primary key.
-- Actor Table: actore_id  is the primary key.

-- Foreign Keys: A foreign key establishes a relationship between two tables by referencing the primary key of another table.
-- Rental Table: customer_id is a foreign key referencing the customer_id in the Customer table.
-- Inventory Table: film_id is a foreign key referencing the film_id in the Film table.

-- Differences in SQL Commands
 -- Creating a Table with a Primary Key
 -- A Primary Key (PK) is declared using PRIMARY KEY when creating a table.
 
 CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

-- This command creates a Customers table with customer_id  as the primary key.

-- Creating a Table with a Foreign Key
-- A Foreign Key (FK) is declared using FOREIGN KEY and references another table.
ALTER TABLE Customers ADD UNIQUE (customer_id);
SHOW CREATE TABLE Customers;

Create table Movies(movie_id int, movie_name varchar(30));

DESC Movies;
ALTER TABLE Movies ADD PRIMARY KEY (movie_id);
ALTER TABLE Movies ADD UNIQUE (movie_id);
ALTER TABLE Movies ENGINE = InnoDB;
select * from movies;

CREATE TABLE Rentals (
    rental_id INT PRIMARY KEY,
    customer_id INT,
    movie_id INT,
    rental_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);
-- Key Differences Between Primary Keys and Foreign Keys
-- Primary Key (PK): Uniquely identifies each record, Must be unique and NOT NULL, Ensures uniqueness in the table
-- Foreign Key (FK): Links to a Primary Key in another table, Can have duplicates or NULL (if optional), Ensures relationships between tables

-- #2.  List all details of actors
-- ANS: 
CREATE TABLE actor (
  actor_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (actor_id),
  KEY idx_actor_last_name (last_name)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

select count(*) from actor; 
select count(*) from actor_award; 


-- #3. List all customer information from DB.
-- ANS: 
select * from customers;
SELECT * FROM customer
ORDER BY last_name;

-- #4.List different countries
CREATE TABLE country (
  country_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  country VARCHAR(50) NOT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (country_id)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

SELECT * from country;

SELECT DISTINCT country 
FROM customers
ORDER BY country;

-- #5. Display all active customers
CREATE TABLE customer (
  customer_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  store_id TINYINT UNSIGNED NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  email VARCHAR(50) DEFAULT NULL,
  address_id SMALLINT UNSIGNED NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  create_date DATETIME NOT NULL,
  last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (customer_id),
  KEY idx_fk_store_id (store_id),
  KEY idx_fk_address_id (address_id),
  KEY idx_last_name (last_name),
  CONSTRAINT fk_customer_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_customer_store FOREIGN KEY (store_id) REFERENCES store (store_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

DESCRIBE customers;
SELECT *
FROM customers
WHERE customer_name = 'Active';
SELECT * 
FROM customers
WHERE customer_name = TRUE;  

select * from customer;

-- #6. List of all rental IDs for customer with ID 1.

SELECT rental_id 
FROM rental
WHERE customer_id = 1;

SELECT rental_id, rental_date 
FROM rentals
WHERE customer_id = 1
ORDER BY rental_date DESC;

select * from rental;

-- #7. Display all the films whose rental duration is greater than 5 .
SELECT * 
FROM film
WHERE rental_duration > 5;

SELECT film_id, title, rental_duration 
FROM film
WHERE rental_duration > 5;

-- #8.  List the total number of films whose replacement cost is greater than $15 and less than $20.
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

-- #9. Display the count of unique first names of actors
SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM actor;

-- #10. Display the first 10 records from the customer table .
SELECT * FROM customer
LIMIT 10;

-- #11.  Display the first 3 records from the customer table whose first name starts with ‘b'
SELECT *  
FROM customer  
WHERE first_name LIKE 'B%'  
LIMIT 3;

-- #12. Display the names of the first 5 movies which are rated as ‘G’.
SELECT title  
FROM film  
WHERE rating = 'G'  
LIMIT 5;

-- #13. Find all customers whose first name starts with "a".
SELECT *  
FROM customer  
WHERE first_name LIKE 'A%';

-- #14. Find all customers whose first name ends with "a".
SELECT *  
FROM customer  
WHERE first_name LIKE '%a';

-- #15. Display the list of first 4 cities which start and end with ‘a’ 
SELECT city  
FROM city  
WHERE city LIKE 'A%A'  
LIMIT 4;

-- #16. Find all customers whose first name have "NI" in any position.
SELECT *  
FROM customer  
WHERE first_name LIKE '%NI%';

-- #17. Find all customers whose first name have "r" in the second position .
SELECT *  
FROM customer  
WHERE first_name LIKE '_r%';

-- #18. Find all customers whose first name starts with "a" and are at least 5 characters in length.
SELECT *  
FROM customer  
WHERE first_name LIKE 'A%'  
AND LENGTH(first_name) >= 5;

-- #19. Find all customers whose first name starts with "a" and ends with "o".
SELECT *  
FROM customer  
WHERE first_name LIKE 'A%o';

-- #20. Get the films with pg and pg-13 rating using IN operator
SELECT *  
FROM film  
WHERE rating IN ('PG', 'PG-13');

-- #21.  Get the films with length between 50 to 100 using between operator.
SELECT *  
FROM film  
WHERE length BETWEEN 50 AND 100;

-- #22.  Get the top 50 actors using limit operator
SELECT *  
FROM actor  
LIMIT 50;

-- #23. Get the distinct film ids from inventory table.
SELECT DISTINCT film_id  
FROM inventory;



-- #Functions
-- #Basic Aggregate Functions:

-- Question 1:
-- Retrieve the total number of rentals made in the Sakila database.
-- Hint: Use the COUNT() function.
use sakila;

SELECT COUNT(*) AS total_rentals  
FROM rental;

-- Question 2:
-- Find the average rental duration (in days) of movies rented from the Sakila database.
-- Hint: Utilize the AVG() function.

SELECT AVG(rental_duration) AS avg_rental_duration  
FROM film;

-- String Functions:

-- Question 3:
-- Display the first name and last name of customers in uppercase.
-- Hint: Use the UPPER () function.

SELECT UPPER(first_name) AS first_name_upper,  
       UPPER(last_name) AS last_name_upper  
FROM customer;

-- Question 4:
-- Extract the month from the rental date and display it alongside the rental ID.
-- Hint: Employ the MONTH() function.

SELECT rental_id,  
       MONTH(rental_date) AS rental_month  
FROM rental;

-- GROUP BY:
-- Question 5:
-- Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
-- Hint: Use COUNT () in conjunction with GROUP BY.

SELECT customer_id,  
       COUNT(rental_id) AS rental_count  
FROM rental  
GROUP BY customer_id  
ORDER BY rental_count DESC;

-- #Question 6:
-- Find the total revenue generated by each store.
-- Hint: Combine SUM() and GROUP BY.
SELECT s.store_id,  
       SUM(p.amount) AS total_revenue  
FROM payment p  
JOIN staff st ON p.staff_id = st.staff_id  
JOIN store s ON st.store_id = s.store_id  
GROUP BY s.store_id  
ORDER BY total_revenue DESC;

-- Question 7:
-- Determine the total number of rentals for each category of movies.
-- Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY

SELECT c.name AS category_name,  
       COUNT(r.rental_id) AS total_rentals  
FROM rental r  
JOIN inventory i ON r.inventory_id = i.inventory_id  
JOIN film f ON i.film_id = f.film_id  
JOIN film_category fc ON f.film_id = fc.film_id  
JOIN category c ON fc.category_id = c.category_id  
GROUP BY c.name  
ORDER BY total_rentals DESC;

-- Question 8:
-- Find the average rental rate of movies in each language.
-- Hint: JOIN film and language tables, then use AVG () and GROUP BY.

SELECT l.name AS language_name,  
       AVG(f.rental_rate) AS avg_rental_rate  
FROM film f  
JOIN language l ON f.language_id = l.language_id  
GROUP BY l.name  
ORDER BY avg_rental_rate DESC;

-- Joins
-- Questions 9 -
-- Display the title of the movie, customer s first name, and last name who rented it.
-- Hint: Use JOIN between the film, inventory, rental, and customer tables.

SELECT f.title AS movie_title,  
       c.first_name,  
       c.last_name  
FROM rental r  
JOIN inventory i ON r.inventory_id = i.inventory_id  
JOIN film f ON i.film_id = f.film_id  
JOIN customer c ON r.customer_id = c.customer_id  
ORDER BY f.title, c.last_name;

-- Question 10:
-- Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
-- Hint: Use JOIN between the film actor, film, and actor tables

SELECT a.first_name, a.last_name  
FROM actor a  
JOIN film_actor fa ON a.actor_id = fa.actor_id  
JOIN film f ON fa.film_id = f.film_id  
WHERE f.title = 'Gone with the Wind';

-- Question 11:
-- Retrieve the customer names along with the total amount they've spent on rentals.
-- Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY

SELECT c.first_name,  
       c.last_name,  
       SUM(p.amount) AS total_spent  
FROM customer c  
JOIN payment p ON c.customer_id = p.customer_id  
GROUP BY c.customer_id  
ORDER BY total_spent DESC;

-- Question 12:
-- List the titles of movies rented by each customer in a particular city (e.g., 'London').
-- Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY

SELECT c.first_name,  
       c.last_name,  
       ci.city,  
       f.title AS movie_title  
FROM rental r  
JOIN customer c ON r.customer_id = c.customer_id  
JOIN address a ON c.address_id = a.address_id  
JOIN city ci ON a.city_id = ci.city_id  
JOIN inventory i ON r.inventory_id = i.inventory_id  
JOIN film f ON i.film_id = f.film_id  
WHERE ci.city = 'London'  
ORDER BY c.last_name, f.title;

-- Advanced Joins and GROUP BY:
-- Question 13:
-- Display the top 5 rented movies along with the number of times they've been rented.
-- Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.

SELECT f.title AS movie_title,  
       COUNT(r.rental_id) AS rental_count  
FROM rental r  
JOIN inventory i ON r.inventory_id = i.inventory_id  
JOIN film f ON i.film_id = f.film_id  
GROUP BY f.title  
ORDER BY rental_count DESC  
LIMIT 5;

-- Question 14:
-- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
-- Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.

SELECT c.customer_id,  
       c.first_name,  
       c.last_name  
FROM rental r  
JOIN inventory i ON r.inventory_id = i.inventory_id  
JOIN store s ON i.store_id = s.store_id  
JOIN customer c ON r.customer_id = c.customer_id  
GROUP BY c.customer_id, c.first_name, c.last_name  
HAVING COUNT(DISTINCT s.store_id) = 2  
ORDER BY c.last_name;



#Windows Function:

-- 1. Rank the customers based on the total amount they've spent on rentals 
SELECT c.customer_id,  
       c.first_name,  
       c.last_name,  
       SUM(p.amount) AS total_spent,  
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS customer_rank  
FROM customer c  
JOIN payment p ON c.customer_id = p.customer_id  
GROUP BY c.customer_id, c.first_name, c.last_name  
ORDER BY total_spent DESC;

-- 2.. Calculate the cumulative revenue generated by each film over time.
SELECT f.title AS movie_title,  
       p.payment_date,  
       SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue  
FROM payment p  
JOIN rental r ON p.rental_id = r.rental_id  
JOIN inventory i ON r.inventory_id = i.inventory_id  
JOIN film f ON i.film_id = f.film_id  
ORDER BY f.title, p.payment_date;

-- 3.Determine the average rental duration for each film, considering films with similar lengths
SELECT f.title AS movie_title,  
       f.length AS film_length,  
       ROUND(AVG(DATEDIFF(r.return_date, r.rental_date)), 2) AS avg_rental_duration  
FROM rental r  
JOIN inventory i ON r.inventory_id = i.inventory_id  
JOIN film f ON i.film_id = f.film_id  
GROUP BY f.length, f.title  
ORDER BY f.length, avg_rental_duration DESC;

-- 4.Identify the top 3 films in each category based on their rental counts.

   SELECT category_name,  
       movie_title,  
       rental_count  
FROM (  
    SELECT c.name AS category_name,  
           f.title AS movie_title,  
           COUNT(r.rental_id) AS rental_count,  
           RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS film_rank  
    FROM rental r  
    JOIN inventory i ON r.inventory_id = i.inventory_id  
    JOIN film f ON i.film_id = f.film_id  
    JOIN film_category fc ON f.film_id = fc.film_id  
    JOIN category c ON fc.category_id = c.category_id  
    GROUP BY c.category_id, c.name, f.title  
) ranked_films  
WHERE film_rank <= 3  
ORDER BY category_name, film_rank;

-- 5.Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
SELECT c.customer_id,  
       c.first_name,  
       c.last_name,  
       COUNT(r.rental_id) AS total_rentals,  
       ROUND(AVG(COUNT(r.rental_id)) OVER (), 2) AS avg_rentals,  
       (COUNT(r.rental_id) - AVG(COUNT(r.rental_id)) OVER ()) AS rental_diff  
FROM rental r  
JOIN customer c ON r.customer_id = c.customer_id  
GROUP BY c.customer_id, c.first_name, c.last_name  
ORDER BY rental_diff DESC;

-- 6. Find the monthly revenue trend for the entire rental store over time.
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,  
       SUM(amount) AS total_revenue  
FROM payment  
GROUP BY month  
ORDER BY month;

-- 7.Identify the customers whose total spending on rentals falls within the top 20% of all customers.
WITH customer_spending AS (
    SELECT c.customer_id,  
           c.first_name,  
           c.last_name,  
           SUM(p.amount) AS total_spent,  
           PERCENT_RANK() OVER (ORDER BY SUM(p.amount) DESC) AS spending_rank  
    FROM customer c  
    JOIN payment p ON c.customer_id = p.customer_id  
    GROUP BY c.customer_id, c.first_name, c.last_name  
)
SELECT customer_id, first_name, last_name, total_spent  
FROM customer_spending  
WHERE spending_rank <= 0.2  
ORDER BY total_spent DESC;

-- 8. Calculate the running total of rentals per category, ordered by rental count.
SELECT c.name AS category_name,  
       COUNT(r.rental_id) AS rental_count,  
       SUM(COUNT(r.rental_id)) OVER (ORDER BY COUNT(r.rental_id) DESC) AS running_total  
FROM rental r  
JOIN inventory i ON r.inventory_id = i.inventory_id  
JOIN film f ON i.film_id = f.film_id  
JOIN film_category fc ON f.film_id = fc.film_id  
JOIN category c ON fc.category_id = c.category_id  
GROUP BY c.category_id, c.name  
ORDER BY rental_count DESC;

-- 9. Find the films that have been rented less than the average rental count for their respective categories
WITH category_avg AS (
    SELECT fc.category_id, 
           f.film_id, 
           f.title, 
           COUNT(r.rental_id) AS rental_count,
           AVG(COUNT(r.rental_id)) OVER (PARTITION BY fc.category_id) AS avg_rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    GROUP BY fc.category_id, f.film_id, f.title
)
SELECT film_id, title, rental_count, avg_rental_count
FROM category_avg
WHERE rental_count < avg_rental_count
ORDER BY category_id, rental_count;

-- 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,  
       SUM(amount) AS total_revenue  
FROM payment  
GROUP BY month  
ORDER BY total_revenue DESC  
LIMIT 5;



-- Normalisation & CTE
-- 1. First Normal Form (1NF):
--  a. Identify a table in the Sakila database that violates 1NF. Explain how you
--  would normalize it to achieve 1NF

-- --ANS:  To address First Normal Form (1NF), let's first recall its requirements: a table satisfies 1NF if each column contains atomic (indivisible) values and there are no repeating groups or arrays.
-- -- Normalization to Achieve 1NF
-- -- To normalize the table and achieve 1NF:
-- -- Split Non-Atomic Values into Rows: Create a new row for each movie rented by a customer. This removes the repeating group in the rentals column.
-- -- Create a Proper Relational Structure: Instead of storing multiple values in a single column, split the data into two related tables:
-- -- A  customer table to store customer details. A rental table to store details of each rental.
-- -- Benefits of 1NF
-- -- Eliminates redundancy in the data.
-- -- Simplifies querying and ensures consistency.

SHOW CREATE TABLE film;
CREATE TABLE film_special_feature (
    film_id SMALLINT UNSIGNED,  -- Must match exactly with film.film_id
    special_feature VARCHAR(50),
    PRIMARY KEY (film_id, special_feature),
    FOREIGN KEY (film_id) REFERENCES film(film_id) ON DELETE CASCADE
);

ALTER TABLE film DROP COLUMN special_features;

-- Example Query (After Normalization)
SELECT f.title  
FROM film f  
JOIN film_special_feature fsf ON f.film_id = fsf.film_id  
WHERE fsf.special_feature = 'Behind the Scenes';

-- 2. Second Normal Form (2NF):
--  a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
--  If it violates 2NF, explain the steps to normalize it.

-- ANS: A table is in Second Normal Form (2NF) if:
-- a)It is already in First Normal Form (1NF)
-- b)It has no partial dependencies—i.e., every non-key attribute must depend on the entire primary key, not just part of it.

-- Choosing a Table:
-- The film_actor table in the Sakila database could violate 2NF because it has a composite primary key consisting of: actor_id (identifies the actor), film_id (identifies the film).

CREATE TABLE film_actor (
    actor_id SMALLINT UNSIGNED NOT NULL,
    film_id SMALLINT UNSIGNED NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (actor_id, film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

-- Does film_actor Violate 2NF?
-- Yes!

-- The last_update column only depends on film_id, not on both film_id and actor_id.

-- This means last_update is partially dependent on the composite key {actor_id, film_id}—a clear 2NF violation.

-- Steps to Normalize film_actor to 2NF

-- Step 1: Create a Separate Table for last_update

CREATE TABLE film_last_update (
    film_id SMALLINT UNSIGNED PRIMARY KEY,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

-- Step 2: Remove last_update from film_actor
ALTER TABLE film_actor DROP COLUMN last_update;


-- Final Normalized Schema
-- Before Normalization (film_actor in 1NF but violating 2NF):
-- actor_id	film_id	last_update
-- 1	101	2024-03-01 12:00:00
-- 2	101	2024-03-01 12:00:00

-- After Normalization (film_actor in 2NF)
-- film_actor Table (Now 2NF-compliant)
-- actor_id	film_id
-- 1	101
-- 2	101
-- 1	202
-- film_last_update Table
-- film_id	last_update
-- 101	2024-03-01 12:00:00
-- 202	2024-03-05 15:30:00

-- 3. Third Normal Form (3NF):
--  a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
--  present and outline the steps to normalize the table to 3NF.

-- ANS:Third Normal Form (3NF) addresses tables with transitive dependencies, ensuring that every non-key column depends only on the primary key.
-- A table is in 3NF if:a)It satisfies 2NF (no partial dependency on composite keys). b)No transitive dependencies exist (a non-key column shouldn't depend on another non-key column).

-- Steps to Normalize the Table to 3NF:
-- a) Step 1: Remove Transitive Dependencies
-- Move city and country into their respective tables (city and country tables already exist in Sakila).

-- The address table should store city_id, and the city table should store country_id.

-- Step 2: Create Relationships
-- customer → address (customer lives at an address).

-- address → city (each address belongs to a city).

-- city → country (each city belongs to a country).

-- Final Normalized Schema
-- Updated customer Table (3NF)
CREATE TABLE customer (
    customer_id SMALLINT UNSIGNED PRIMARY KEY,
    store_id TINYINT UNSIGNED,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    email VARCHAR(50),
    address_id SMALLINT UNSIGNED,  -- Keeps reference to address
    active BOOLEAN,
    create_date DATETIME,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- address Table (No Changes, Already Exists)

CREATE TABLE address (
    address_id SMALLINT UNSIGNED PRIMARY KEY,
    address VARCHAR(50),
    address2 VARCHAR(50),
    district VARCHAR(50),
    city_id SMALLINT UNSIGNED,  -- Now references city_id instead of storing city name
    postal_code VARCHAR(10),
    phone VARCHAR(20),
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

-- city Table (No Changes, Already Exists)

CREATE TABLE city (
    city_id SMALLINT UNSIGNED PRIMARY KEY,
    city VARCHAR(50),
    country_id SMALLINT UNSIGNED,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);


-- 4. Normalization Process:
--  a. Take a specific table in Sakila and guide through the process of normalizing it from the initial 
--  unnormalized form up to at least 2NF.
-- ANS: Table Chosen: payment
-- Unnormalized Form (UNF)
-- Let’s imagine the original unnormalized payment table looks like this:

-- payment_id	customer_name	customer_email	amount	staff_name	store_address	payment_date
-- 1	Mary Smith	mary@example.com	5.99	Mike Johnson	123 Main St, NY	2024-04-01 14:32:00
-- 2	John Doe	john@example.com	3.99	Sarah Lee	456 Oak Ave, LA
-- Step 1: First Normal Form (1NF)
-- Rule:  Eliminate repeating groups and multivalued fields. Ensure all attributes contain atomic values (single values).
-- Problem in UNF: customer_name and customer_email are repeating. store_address and staff_name repeat for the same store/staff.

-- Normalize to 1NF:
-- Split into separate tables:

-- 🧩 customer table
-- customer_id	name	email
-- 1	Mary Smith	mary@example.com
-- 2	John Doe	john@example.com

-- store table
-- store_id	address
-- 1	123 Main St, NY
-- 2	456 Oak Ave, LA-- 

-- payment table (1NF)
-- payment_id	customer_id	staff_id	store_id	amount	payment_date
-- 1	1	1	1	5.99	2024-04-01 14:32:00
-- 2	2	2	2	3.99	2024-04-02 16:45:00
-- 3	1	1	1	7.99	2024-04-03 11:20:00
-- ✅ All values are now atomic, and we've reduced duplication.

-- Step 2: Second Normal Form (2NF)
-- Rule: Must be in 1NF. Remove partial dependencies (attributes depending on part of a composite key).
-- In the current payment table, payment_id is the primary key (not a composite key), so: There are no partial dependencies (since no composite key exists).
-- amount and payment_date depend only on payment_id.
-- Therefore, the table is already in 2NF.

-- Final Tables After 2NF

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE store (
    store_id INT PRIMARY KEY,
    address VARCHAR(100)
);

CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    staff_id INT,
    store_id INT,
    amount DECIMAL(5,2),
    payment_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (store_id) REFERENCES store(store_id)
);

-- 5. CTE Basics:
--  a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 
--  have acted in from the actor and film_actor tables
use sakila;
WITH actor_film_count AS (
    SELECT 
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
)

SELECT * 
FROM actor_film_count
ORDER BY film_count DESC;

-- 6. CTE with Joins:
--  a. Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate.

WITH film_language_info AS (
    SELECT 
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)

SELECT * 
FROM film_language_info
ORDER BY film_title;

-- 7. CTE for Aggregation:
--  a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
--  from the customer and payment tables. 

WITH customer_revenue AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)

SELECT * 
FROM customer_revenue
ORDER BY total_revenue DESC;

-- 8. CTE with Window Functions: 
-- a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.

WITH film_ranks AS (
    SELECT 
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_rank
    FROM film
)

SELECT * 
FROM film_ranks
ORDER BY rental_rank;

-- 9. CTE and Filtering:
--  a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details. 

WITH frequent_customers AS (
    SELECT 
        customer_id,
        COUNT(rental_id) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) > 2
)

SELECT 
    fc.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    fc.rental_count
FROM frequent_customers fc
JOIN customer c ON fc.customer_id = c.customer_id
ORDER BY fc.rental_count DESC;

-- 10.  CTE for Date Calculations:
-- a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table.

WITH monthly_rentals AS (
    SELECT 
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY rental_month
)

SELECT * 
FROM monthly_rentals
ORDER BY rental_month;

-- 11. CTE and Self-Join:
-- a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.

WITH actor_pairs AS (
    SELECT 
        fa1.film_id,
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id
    FROM film_actor fa1
    JOIN film_actor fa2 
        ON fa1.film_id = fa2.film_id 
        AND fa1.actor_id < fa2.actor_id  -- avoids duplicate and self-pairing
)

SELECT 
    ap.film_id,
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor1_name,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor2_name
FROM actor_pairs ap
JOIN actor a1 ON ap.actor1_id = a1.actor_id
JOIN actor a2 ON ap.actor2_id = a2.actor_id
ORDER BY ap.film_id, actor1_name, actor2_name;

-- 12. CTE for Recursive Search: 
-- a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column

CREATE TABLE employee (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    reports_to INT NULL
);

insert into employee (staff_id, first_name, last_name, reports_to)
values (1, 'Alice', 'Smith', Null),
(2, 'Bob', 'Johnson', 1),
(3, 'Charlie', 'Brown', 1),
(4, 'David', 'Lee', 2),
(5, 'Eve', 'White', 2),
(6, 'Frank', 'Taylor', 3);

WITH RECURSIVE employee_hierarchy AS (
    -- Base case: Find employees who report directly to manager with staff_id = 1
    SELECT 
        staff_id,
        first_name,
        last_name,
        reports_to AS manager_id
    FROM employee
    WHERE reports_to = 1  

    UNION ALL

    -- Recursive case: Find employees who report to someone already found
    SELECT 
        e.staff_id,
        e.first_name,
        e.last_name,
        e.reports_to
    FROM employee e
    JOIN employee_hierarchy eh ON e.reports_to = eh.staff_id
)

SELECT * FROM employee_hierarchy;
