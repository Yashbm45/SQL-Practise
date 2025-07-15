 -- 🟢 SIMPLE (Level 1): Basic JOINs

-- 1. Retrieve all orders along with the customer’s name who placed them.
select o.*, c.customer_name
from orders o
join customers c
on o.customer_id = c.customer_id;

-- 2. List all employees and their department names, including employees with no department.
select e.*, d.department_name
from employees e
left join departments d
on e.department_id = d.department_id;


-- 3. Find customers who have made at least one purchase, including the purchase information.
select c.*, oi.*
from customers c
join orders o	on o.customer_id = c.customer_id
join order_items oi on o.order_id = oi.order_id;


-- 4. Show all products and how many times they’ve been ordered, even products that have never been ordered.
SELECT p.*, COUNT(oi.product_id) AS order_count
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id;
							-- MySQL allows you to SELECT columns not in the GROUP BY as long as:
                            -- Those columns are functionally dependent on the GROUP BY column (i.e., the product_id uniquely determines all other columns in products)
                            -- Or the server is configured with ONLY_FULL_GROUP_BY disabled (which is the default in some versions).
						-- So in MySQL:
							-- p.product_id is usually the primary key of the products table.
                            -- Therefore, it uniquely identifies every row.
                            -- So selecting all of p.* is safe — there's no ambiguity.



-- 5. Find all categories and the total amount of sales for products in each category, including categories with no sales.
SELECT p.category, 
       COALESCE(SUM(oi.price * oi.quantity), 0) AS total_sale
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category;



-- 🟡 INTERMEDIATE (Level 2): Complex JOINs

-- 1. Retrieve all employees and the managers who supervise them, including managers without employees.
SELECT e.*, m.employee_name AS manager_name
FROM employees e
LEFT JOIN employees m
  ON e.manager_id = m.employee_id;
  
  
-- 2. Get all customers with their most recent order date.
SELECT c.*, MAX(o.order_date) AS recent_order
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;


-- 3. Show all products and the orders they are included in, even if no orders exist for some products.
select p.*, oi.*
from products p
left join order_items oi on p.product_id = oi.product_id;


-- 4. Find customers who ordered products from more than one category.
SELECT c.customer_id, c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT p.category) > 1;


-- Retrieve all products and the total number of orders they appear in.
select p.*, count(oi.order_id) as order_count
from products p
join order_items oi on p.product_id = oi.product_id
group by product_id;

-- Another Approach 
select p.*, count(oi.order_id) as order_count
from products p
join order_items oi on p.product_id = oi.product_id
group by product_id;


-- List all employees along with their department, even if they do not belong to a department.
select e.*, d.department_name
from employees e
left join departments d on e.department_id = d.department_id;



-- 🔴 ADVANCED (Level 3): Self Joins, Nested Joins, and Advanced JOINs
-- 1. Retrieve all employees and their direct reports using a self join.
select e.*, m.employee_name as Manager_name
from employees e
join employees m  on m.employee_id = e.manager_id;


-- 2. Show products that have been ordered more than the average number of orders.


-- 3. Find all employees who report to the same manager as 'Jais'.
SELECT e.*
FROM employees e
JOIN employees jais ON e.manager_id = jais.manager_id
WHERE jais.employee_name = 'Jais'
  AND e.employee_name != 'Jais';


-- 4. List all customers who have made at least one purchase but have never returned any product.
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE NOT EXISTS (
    SELECT 1
    FROM returns r
    WHERE r.order_id = o.order_id
);

                        
-- Get all orders and products, including the total number of products per order, even if some orders have no products.
SELECT o.order_id,
       COUNT(oi.product_id) AS product_count
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id;


-- Retrieve the second most recent order for each customer.
SELECT o1.*
FROM orders o1
LEFT JOIN orders o2
  ON o1.customer_id = o2.customer_id
  AND (o2.order_date > o1.order_date
       OR (o2.order_date = o1.order_date AND o2.order_id > o1.order_id))
GROUP BY o1.order_id, o1.customer_id, o1.order_date
HAVING COUNT(o2.order_id) = 1;

-- Another Approach
WITH ranked_orders AS (
  SELECT
    o.*,
    ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date DESC) AS rn
  FROM orders o
)
SELECT *
FROM ranked_orders
WHERE rn = 2;


/*
1. Create employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    manager_id INT,
    hire_date DATE,
    salary DECIMAL(10, 2)
);
2. Create departments Table
sql
Copy
Edit
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
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
6. Create categories Table
sql
Copy
Edit
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);
7. Create suppliers Table
sql
Copy
Edit
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100)
);
8. Create order_items Table
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
9. Create project_assignments Table
sql
Copy
Edit
CREATE TABLE project_assignments (
    project_assignment_id INT PRIMARY KEY,
    employee_id INT,
    project_id INT,
    assignment_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
Sample Data Insertion
To help with testing the join queries, here’s some sample data you can use for the tables:

Insert Data into departments Table
sql
Copy
Edit
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Sales');
Insert Data into employees Table
sql
Copy
Edit
INSERT INTO employees (employee_id, employee_name, department_id, manager_id, hire_date, salary) VALUES
(1, 'John Doe', 1, NULL, '2022-01-01', 50000),
(2, 'Jane Smith', 2, 1, '2021-06-15', 60000),
(3, 'Michael Brown', 3, 2, '2020-03-20', 55000),
(4, 'Sarah Davis', 2, 1, '2021-08-10', 62000);
Insert Data into customers Table
sql
Copy
Edit
INSERT INTO customers (customer_id, customer_name, contact_email, registration_date) VALUES
(1, 'Alice Cooper', 'alice@example.com', '2023-01-01'),
(2, 'Bob Marley', 'bob@example.com', '2022-07-22'),
(3, 'Charlie Walker', 'charlie@example.com', '2021-05-15');
Insert Data into orders Table
sql
Copy
Edit
INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2023-01-10', 100.00),
(2, 2, '2022-08-01', 200.00),
(3, 3, '2021-06-15', 300.00);
Insert Data into products Table
sql
Copy
Edit
INSERT INTO products (product_id, product_name, category_id, price) VALUES
(1, 'Laptop', 1, 1000.00),
(2, 'Smartphone', 1, 500.00),
(3, 'Headphones', 2, 100.00);
Insert Data into categories Table
sql
Copy
Edit
INSERT INTO categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Accessories');
Insert Data into suppliers Table
sql
Copy
Edit
INSERT INTO suppliers (supplier_id, supplier_name) VALUES
(1, 'TechCorp'),
(2, 'GadgetSupply');
Insert Data into order_items Table
sql
Copy
Edit
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1, 1000.00),
(2, 2, 2, 2, 500.00),
(3, 3, 3, 3, 100.00);
Insert Data into project_assignments Table
sql
Copy
Edit
INSERT INTO project_assignments (project_assignment_id, employee_id, project_id, assignment_date) VALUES
(1, 2, 1, '2022-07-01'),
(2, 3, 2, '2021-05-10');
*/