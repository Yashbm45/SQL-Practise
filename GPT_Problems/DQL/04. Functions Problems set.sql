-- ************* **************** 🟢 SIMPLE (Level 1): Basic SQL Functions
-- 1. Find the length of each customer’s name.
select *, 
		length(customer_name)
from customers;


-- 2. Convert all employee names to uppercase.
select upper(employee_name)
from employees;


-- 3. Find the first 5 characters of the product name.
select *, left(product_name, 5) as top5
from products;


-- 4. Retrieve the last 3 characters of the customer’s name.
select *, right(customer_name, 3) as last3
from customers;


-- 5. Calculate the rounded total amount for each order (round to 1 decimal places).
select *, round(total_amount, 1) as rounded, ceil(total_amount) as ceil_round
from orders;


-- 6. Get the total number of products in the products table.
select count(*) as Total_products
from products;


-- 7. Calculate the square root of each product's price.
select *, sqrt(price)
from products;
-- 8. Find the absolute value of the difference between the maximum and minimum order amounts.
select abs(max(total_amount) - min(total_amount)) as abs_diff, max(total_amount), min(total_amount)
from orders;


-- 9. Concatenate the first and last names of employees.
select concat(customer_name," " ,city) as cc
from customers;


-- 10. Find the position of the letter 'e' in the product name.
SELECT product_name,
       POSITION('e' IN product_name) AS e_position
FROM products;
    
-- 11. Remove leading and trailing spaces from customer names.
select trim(customer_name) as clean
from customers;


-- 12. Replace all occurrences of 'Apple' with 'Orange' in the product names.
select *, replace(product_name,'Laptop', 'Lappy') as product_name
from products;



-- *************** *************** *************** INTERMEDIATE: Moderate SQL Functions *************** *************** ***************
-- 1. Convert the product names to lowercase.
select lower(product_name)
from products;


-- 2. Find the price after applying a 10% discount for all products.
select *, price * 0.9 as discount
from products;


-- 3. Find the average price of all products.
select avg(price) as avg_p
from products;


-- 4. Get the maximum total order amount.
select max(total_amount) as maxxx
from orders;


-- 5. Find the number of occurrences of the letter 'a' in the product names.

-- 6. Check if the product name contains the word 'phone' (case-insensitive).
SELECT *
FROM products
WHERE LOWER(product_name) LIKE '%phone%';


-- 7. Round the total amount to the nearest whole number for each order.
SELECT *, ROUND(total_amount, 0) AS rounded
FROM orders;



-- 8. Calculate the percentage of each product price compared to the total sum of all product prices.
with total as (
	select *, sum(price) over() as total_price
	from products )
select *, (price/total_price) * 100 as per
from total;


-- 9. Concatenate the customer's first and last name as a full name.
select *, concat(customer_name," ",city) as fulll
from customers;


-- 10. Find the highest and lowest product price.
select max(price) as max_price, min(price) as min_price
from products;


-- 11. Calculate the total sales for each product (price * quantity).
select *, (price * quantity) as total_amount
from order_items;


-- 12. Find the first 3 characters of the employee's name and convert them to uppercase.
select *, upper(left(employee_name,3)) as emp_u_name
from employees;



-- *************** *************** ***************   ADVANCED : Advanced SQL Functions *************** *************** *************** 
-- 1. Find the median order amount in the orders table.
SELECT AVG(total_amount) AS median_amount
FROM (
    SELECT total_amount,
           ROW_NUMBER() OVER (ORDER BY total_amount) AS rn,
           COUNT(*) OVER () AS cnt
    FROM orders
) ranked
WHERE rn IN (FLOOR((cnt + 1) / 2), CEIL((cnt + 1) / 2));

select * from orders;


-- 2. Calculate the standard deviation of product prices.
select stddev(price)
from products;


-- 3. Create a string of all employee names separated by commas.
SELECT GROUP_CONCAT(employee_name SEPARATOR ', ') AS all_employees
FROM employees;

WITH RECURSIVE employee_list AS (
    SELECT 
        employee_id,
        employee_name,
        CAST(employee_name AS CHAR(10000)) AS aggregated_names
    FROM employees
    WHERE employee_id = (SELECT MIN(employee_id) FROM employees)

    UNION ALL

    SELECT 
        e.employee_id,
        e.employee_name,
        CAST(CONCAT(el.aggregated_names, ', ', e.employee_name) AS CHAR(10000))
    FROM employees e
    JOIN employee_list el ON e.employee_id = (
        SELECT MIN(employee_id)
        FROM employees
        WHERE employee_id > el.employee_id
    )
)
SELECT aggregated_names
FROM employee_list
ORDER BY employee_id DESC
LIMIT 1;




-- 4. Find the most frequent product category in the products table.            
-- solution 1
SELECT category
FROM (
    SELECT category, COUNT(*) AS countt
    FROM products
    GROUP BY category
) AS r
ORDER BY countt DESC
LIMIT 1;

-- Solution 2
WITH countt AS (
    SELECT category, COUNT(*) AS countt
    FROM products
    GROUP BY category
)
SELECT category
FROM countt
ORDER BY countt DESC
LIMIT 1;

-- Optimised Solution
SELECT category, COUNT(*) AS frequency
FROM products
GROUP BY category
ORDER BY frequency DESC
LIMIT 1;


-- 5. Count the number of unique customers who made purchases over $100.
select distinct(count(customer_id)) 
from orders
where total_amount > 100;


-- 6. Find the second highest order amount.
select max(total_amount)
from orders
where total_amount < (select max(total_amount) from orders);


-- 7. Calculate the difference between the highest and lowest product price in each category.
select category, 
		max(price) as max_p,
        min(price) as min_p,
        max(price) - min(price) as price_diff
from products
group by category;

  
-- 8. Find and concate first and last letters of each product name.
select *, concat(left(product_name, 1), right(product_name,1)) LR
from products;


-- 9. Calculate the total sales for each department (total sales of products assigned to employees in each department).
SELECT 
    e.department_id,
    SUM(oi.price * oi.quantity) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN employees e ON p.employee_id = e.employee_id
GROUP BY e.department_id;




-- 10. Find all products whose names start with a vowel.
-- Solution 1
SELECT *
FROM products
WHERE product_name LIKE 'A%'
   OR product_name LIKE 'E%'
   OR product_name LIKE 'I%'
   OR product_name LIKE 'O%'
   OR product_name LIKE 'U%'
   OR product_name LIKE 'a%'
   OR product_name LIKE 'e%'
   OR product_name LIKE 'i%'
   OR product_name LIKE 'o%'
   OR product_name LIKE 'u%';

-- Solution 2
SELECT *
FROM products
WHERE product_name REGEXP '^[aeiouAEIOUs]';



-- 11. Calculate the total price of products ordered, including a 5% tax applied to each order. 
-- Solution 1
select *, (total_amount + (total_amount * 0.05)) as tt 
from orders;

-- Solution 2
SELECT *, 
       total_amount * 1.05 AS total_with_tax
FROM orders;

/*Create employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    manager_id INT,
    hire_date DATE,
    salary DECIMAL(10, 2)
);

-- Insert records
INSERT INTO employees (employee_id, employee_name, department_id, manager_id, hire_date, salary) VALUES
(1, 'John Doe', 1, NULL, '2022-01-01', 50000),
(2, 'Jane Smith', 2, 1, '2021-06-15', 60000),
(3, 'Michael Brown', 3, 2, '2020-03-20', 55000),
(4, 'Sarah Davis', 2, 1, '2021-08-10', 62000),
(5, 'David Lee', 1, NULL, '2019-12-01', 51000),
(6, 'Evelyn Clark', 2, 3, '2020-11-22', 53000),
(7, 'Sophia Wilson', 3, 2, '2018-07-14', 58000),
(8, 'James Miller', 1, 5, '2021-01-12', 49000),
(9, 'Olivia Lewis', 2, 1, '2022-03-05', 47000),
(10, 'Liam Martinez', 3, 2, '2020-06-18', 60000),
(11, 'Emma Taylor', 2, 1, '2019-10-25', 65000),
(12, 'Lucas Anderson', 3, 2, '2021-09-07', 54000);
2. Create departments Table
sql
Copy
Edit
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

-- Insert records
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Sales');
3. Create customers Table
sql
Copy
Edit
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    contact_email VARCHAR(100),
    registration_date DATE
);

-- Insert records
INSERT INTO customers (customer_id, customer_name, contact_email, registration_date) VALUES
(1, 'Alice Cooper', 'alice@example.com', '2023-01-01'),
(2, 'Bob Marley', 'bob@example.com', '2022-07-22'),
(3, 'Charlie Walker', 'charlie@example.com', '2021-05-15'),
(4, 'David John', 'david@example.com', '2022-03-10'),
(5, 'Eve Robinson', 'eve@example.com', '2021-11-25'),
(6, 'Frank Harris', 'frank@example.com', '2022-06-20'),
(7, 'Grace Lee', 'grace@example.com', '2020-07-30'),
(8, 'Hannah Adams', 'hannah@example.com', '2021-08-10'),
(9, 'Isla Clark', 'isla@example.com', '2020-12-01'),
(10, 'Jack Turner', 'jack@example.com', '2023-02-15'),
(11, 'Kathy Scott', 'kathy@example.com', '2022-09-25'),
(12, 'Leo Young', 'leo@example.com', '2022-05-05');
4. Create orders Table
sql
Copy
Edit
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert records
INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2023-01-10', 100.00),
(2, 2, '2022-08-01', 200.00),
(3, 3, '2021-06-15', 300.00),
(4, 4, '2022-03-25', 400.00),
(5, 5, '2021-11-05', 250.00),
(6, 6, '2022-06-10', 150.00),
(7, 7, '2020-08-25', 500.00),
(8, 8, '2021-09-05', 350.00),
(9, 9, '2020-12-15', 450.00),
(10, 10, '2023-02-20', 200.00),
(11, 11, '2022-07-12', 150.00),
(12, 12, '2022-05-15', 400.00);
5. Create products Table
sql
Copy
Edit
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10, 2)
);

-- Insert records
INSERT INTO products (product_id, product_name, category_id, price) VALUES
(1, 'Laptop', 1, 1000.00),
(2, 'Smartphone', 1, 500.00),
(3, 'Headphones', 2, 100.00),
(4, 'Monitor', 1, 300.00),
(5, 'Keyboard', 3, 50.00),
(6, 'Mouse', 3, 25.00),
(7, 'Tablet', 1, 600.00),
(8, 'Charger', 3, 15.00),
(9, 'Camera', 2, 400.00),
(10, 'Smartwatch', 1, 150.00),
(11, 'Speakers', 2, 80.00),
(12, 'Smart TV', 2, 800.00);
6. Create categories Table
sql
Copy
Edit
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- Insert records
INSERT INTO categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Accessories'),
(3, 'Peripherals');
7. Create order_items Table
sql
Copy
Edit
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert records
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1, 1000.00),
(2, 2, 2, 2, 500.00),
(3, 3, 3, 1, 100.00),
(4, 4, 4, 1, 300.00),
(5, 5, 5, 3, 150.00),
(6, 6, 6, 2, 50.00),
(7, 7, 7, 1, 600.00),
(8, 8, 8, 1, 15.00),
(9, 9, 9, 1, 400.00),
(10, 10, 10, 2, 300.00),
(11, 11, 11, 1, 80.00),
(12, 12, 12, 1, 800.00);



Sample Dataset Structure
Employees: Contains employees with departments and managers.

Departments: Contains department information.

Customers: Contains customer information.

Orders: Contains customer orders with a total amount.

Products: Contains products with categories and prices.

Categories: Contains product categories.

Order Items: Contains products in each order.

*/