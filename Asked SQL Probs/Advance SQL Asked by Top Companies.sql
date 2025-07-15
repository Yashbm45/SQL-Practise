-- Amazon and Microsoft asked these SQL questions in their interview.( Experience 2+ years)	CTC- 30 LPA


-- 1/ Find the second highest salary without using LIMIT, OFFSET, or TOP.
select max(salary)
from employees
where salary< (
				select max(salary)	
                from employees
			);


WITH monthly_transactions AS (
    SELECT 
        customer_id,
        DATE_FORMAT(order_date, '%Y-%m') AS ym
    FROM orders
    GROUP BY customer_id, ym
),
customer_details AS (
    SELECT 
        customer_id
    FROM monthly_transactions
    GROUP BY customer_id
    HAVING COUNT(DISTINCT ym) = 12
)
SELECT c.*
FROM customers c
JOIN customer_details cd
  ON c.customer_id = cd.customer_id;



-- 3/ Calculate the 7-day moving average of sales for each product.
-- Step 1: Daily total sales per product
WITH daily_sales AS (
    SELECT 
        p.product_id,
        o.order_date,
        SUM(o.total_amount) AS daily_sales
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON p.product_id = oi.product_id
    GROUP BY p.product_id, o.order_date
)

-- Step 2: 7-day moving average per product
SELECT 
    product_id,
    order_date,
    daily_sales,
    AVG(daily_sales) OVER (
        PARTITION BY product_id 
        ORDER BY order_date 
        RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW
    ) AS moving_avg_7d
FROM daily_sales
ORDER BY product_id, order_date;



-- 4/ Find users who logged in for at least three consecutive days.
select *
from users;

-- 5/ Use window functions to rank orders by order value per customer and return the top 3.
-- 6/ Retrieve employees who earn more than their managers.
select e.*
from employees e
join employees m on e.manager_id = m.employee_id
where e.salary > m.salary;


-- 7/ Find duplicate rows in a large table and delete only the extras.
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY employee_name, department_id, hire_date -- define your "duplicate" columns here
                              ORDER BY employee_id) AS rn
    FROM employees
)
DELETE FROM employees
WHERE employee_id IN (
    SELECT employee_id
    FROM CTE
    WHERE rn > 1
);
/*
8/ Optimize a slow-performing query with multiple joins and aggregations.
9/ Get the first order for each customer, handling tie-breakers properly.
10/ Find products never purchased by any customer.
11/ Retrieve users who made purchases in 2 consecutive months but not the 3rd.
12/ Find the department with the highest total salary payout.
13/ Identify employees with the same salary in the same department.
14/ Calculate median salary without using built-in functions.
15/ Write a query to pivot rows into monthly sales columns.
16/ Identify top N customers with the highest total purchases (with tie handling).
17/ Get the running total of revenue per day using window functions.
18/ Find users whose most frequently purchased category in the last year is ‘Electronics’.
19/ Retrieve the first and last event for each user from an events table.
20/ Rank products by yearly sales, resetting rank every new year.
*/