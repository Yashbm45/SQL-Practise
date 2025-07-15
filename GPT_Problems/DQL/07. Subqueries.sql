-- 🟢 SIMPLE (Level 1): Basic Subqueries

-- 1. Find the maximum order amount from the orders table using a subquery.
select *
from orders
where total_amount = ( 
						select max(total_amount) 
                        from orders);
                        

-- 3. Show the names of employees who earn more than the average salary.
select *
from employees 
where salary > ( 
				select avg(salary) 
                from employees);
                


-- 4. Find the names of departments that have at least one employee.
select department_name 
from departments d
where exists ( select 1
				from employees e
                where d.department_id = e.department_id);
                

-- 5. List customers whose IDs exist in the orders table.
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE c.customer_id = o.customer_id
);


-- Show employee details who belong to the department named 'Engineering'.
select *
from employees
where department_id = ( select department_id 
						from departments
                        where department_name = 'Engineering');


-- Find the price of the most expensive product in each category (use a subquery in SELECT).
SELECT
  p.category,
  p.product_name,
  p.price,
  (SELECT MAX(price)
   FROM products p2
   WHERE p2.category = p.category) AS max_price_in_category
FROM products p;



-- 🟡 INTERMEDIATE (Level 2): Nested & Correlated Subqueries

-- 1. Find customers who placed more than one order.
SELECT c.*
FROM customers c
JOIN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) o ON c.customer_id = o.customer_id;


-- 2. Retrieve products that were never ordered.
select *
from products p
where not exists ( select 1 
					from order_items o
                    where p.product_id = o.product_id);


-- 3. Find employees whose salary is above the average salary of their department.
SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees ee
    WHERE e.department_id = ee.department_id
);

use problem_set;
-- Show customers who ordered every product in a given category.
-- Replace 'X' with the desired category_id or category name
SELECT c.customer_id, c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.category = 'Clothing'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT p.product_id) = (
    SELECT COUNT(DISTINCT p2.product_id)
    FROM products p2
    WHERE p2.category = 'Clothing'
);


-- Retrieve order IDs that contain more than 2 products.
SELECT o.*
FROM orders o
JOIN (
    SELECT order_id
    FROM order_items 
    GROUP BY order_id
    HAVING COUNT(*) > 2
) oi ON o.order_id = oi.order_id;

				

-- Show product names that appear in orders totaling more than $300.
SELECT DISTINCT p.product_name
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN (
    SELECT order_id
    FROM order_items
    GROUP BY order_id
    HAVING SUM(price * quantity) > 300
) high_value_orders ON oi.order_id = high_value_orders.order_id;


-- Display customers who have placed orders for products from more than one category.
SELECT c.*
FROM customers c
JOIN (
    SELECT o.customer_id
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON p.product_id = oi.product_id
    GROUP BY o.customer_id
    HAVING COUNT(DISTINCT p.category) > 1
) cc ON c.customer_id = cc.customer_id;


-- Use a subquery in a FROM clause to calculate the average order amount per customer and list those above $300.
SELECT c.customer_id, c.customer_name, c.city, cc.avg_order_value
FROM customers c
JOIN (
    SELECT customer_id, AVG(total_amount) AS avg_order_value
    FROM orders
    GROUP BY customer_id
    HAVING AVG(total_amount) > 300
) cc ON c.customer_id = cc.customer_id;



-- 🔴 ADVANCED (Level 3): Complex, Correlated, and DDL-Based Subqueries

-- 1. Find customers who placed more orders than the average number of orders per customer.
SELECT c.customer_id, c.customer_name, customer_order_count.total_orders
FROM customers c
JOIN (
    SELECT customer_id, COUNT(*) AS total_orders
    FROM orders
    GROUP BY customer_id
) customer_order_count
    ON c.customer_id = customer_order_count.customer_id
WHERE customer_order_count.total_orders > (
    SELECT AVG(order_count)
    FROM (
        SELECT COUNT(*) AS order_count
        FROM orders
        GROUP BY customer_id
    ) customer_order_stats
);


-- 2. Display the top 3 most ordered products using a subquery with LIMIT.
SELECT p.product_id, p.product_name, pp.total_revenue
FROM products p
JOIN (
    SELECT product_id, SUM(quantity * price) AS total_revenue
    FROM order_items
    GROUP BY product_id
    ORDER BY total_revenue DESC
    LIMIT 3
) pp ON p.product_id = pp.product_id;


-- Retrieve the most recent order for each customer using a correlated subquery.
SELECT c.customer_id, c.customer_name, c.city,
       (
         SELECT MAX(o.order_date)
         FROM orders o
         WHERE o.customer_id = c.customer_id
       ) AS most_recent_order
FROM customers c;

                
-- Find departments where every employee earns above the average salary of the entire company.
SELECT d.department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
      AND e.salary <= (SELECT AVG(salary) FROM employees)
);


-- Show employees who have the same salary as someone in a different department.
SELECT *
FROM employees e1
WHERE EXISTS (
    SELECT 1
    FROM employees e2
    WHERE e1.salary = e2.salary
      AND e1.department_id != e2.department_id
);
-- Another Approach
SELECT DISTINCT e1.*
FROM employees e1
JOIN employees e2 
  ON e1.salary = e2.salary 
 AND e1.department_id != e2.department_id;


-- Create a new table with only high-value customers (total orders > $1000) using a subquery in a CREATE TABLE AS statement.

-- Delete products that have never been ordered using a subquery in DELETE.

-- Update the price of products by 10% if they were ordered more than 5 times (use subquery in UPDATE).

-- Drop a temporary table created using a subquery if it exists (DDL + subquery).

-- Create a view that shows employees and their department names using a subquery.

-- Show customers who have only placed orders in the last 30 days using a correlated subquery.

-- Find the product(s) that were ordered by all customers (use ALL or NOT EXISTS with subqueries).
