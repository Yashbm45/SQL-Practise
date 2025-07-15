-- SIMPLE (Level 1): Basic Window Functions
-- 1. Use ROW_NUMBER() to assign a unique number to each employee.
select *, row_number() over (order by salary desc, employee_id desc) as ranking
from employees;


-- 2. Rank products by price using RANK().
select *, rank() over (order by price desc, product_name asc) as rankk
from products;

select *, rank() over (order by price desc) as rankk
from products;


-- 3. Show employees with their salary and DENSE_RANK() within their department.
select *, dense_rank() over(partition by d.department_id order by e.salary) ranking
from employees e
join departments d
on e.department_id = d.department_id;


-- 4. Use NTILE(4) to divide employees into 4 performance quartiles based on salary.
select *,ntile(4) over (order by salary)
from employees;


-- 5. Show each employee's name and their LAG() salary (previous row's salary).
select *,
lag(salary) over() as lagging
from employees;


-- 6. Display each product’s price along with LEAD() value (next product's price).
select *, 
	lead(price) over ()
from products;


-- 7. Use SUM() OVER() to calculate running total of order amounts.
select *,
		sum(total_amount) over (order by order_id)
from orders;


-- 8. Compute average salary per department using AVG() OVER(PARTITION BY department_id).
select *,
	avg(e.salary) over (partition by e.department_id)
from employees e
join departments d
on e.department_id = d.department_id;


-- 9. Use COUNT() OVER() to find how many employees exist in each department.
select distinct d.department_name,
	count(*) over (partition by d.department_id)
from employees e
join departments d
on e.department_id = d.department_id;


-- 10. Show each order with its cumulative sum by customer using SUM() OVER(PARTITION BY customer_id ORDER BY order_date).
select *, 
	sum(total_amount) over(partition by customer_id order by customer_id)
from orders;


-- 11. Get the first order amount per category using FIRST_VALUE().
select *
from (select distinct (p.category), o.order_id, p.product_name, o.order_date,
first_value(o.total_amount) over (partition by p.category order by order_date asc) as first_order,
row_number() over (partition by p.category order by order_date asc) as rn
from orders o
join order_items oi
on o.order_id = oi.order_id
join products p
on p.product_id = oi.product_id
) as roo
where rn = 1;


-- 12. Show the last salary recorded for each employee using LAST_VALUE().  -- Need to work
select *,
last_value(salary) over (partition by employee_id order by hire_date rows between unbounded preceding and unbounded following) as last_sal
from employees;

-- 13. Use MIN() OVER() and MAX() OVER() to display salary range per department.
select *,
min(salary) over(partition by d.department_name ) as min_sal,
max(salary) over(partition by d.department_name ) as max_sal
from employees e
join departments d
on e.department_id = d.department_id;

-- 14. Display total number of employees with COUNT() OVER() and no GROUP BY.
select *,
count(*) over (partition by department_id)
from employees;

select department_id, count(*) as emp_count
from employees
group by department_id;

select count(*)
from employees;


-- 15. Use RANK() to find top 3 paid employees in the company.
select * 
from (
select *,
	rank() over (order by salary desc) as rn
from employees ) as roo
where rn <= 3;


use problem_set;
-- 🟡 INTERMEDIATE (Level 2): Partitioning, Ordering, and Conditional Logic
-- 1. Rank orders per customer by order amount in descending order.
select 
    o.customer_id,
    o.order_id,
    o.total_amount,
row_number() over (partition by o.customer_id order by o.total_amount desc) as rankk
from order_items oi  
join orders o
on o.order_id = oi.order_id;

-- 2. Find employees whose salary is the highest within their department using RANK().
select *
from (
select d.department_name, e.employee_id, e.employee_name, e.salary,
rank() over (partition by d.department_name order by e.salary desc) as rn
from employees e
join departments d
on e.department_id = d.department_id) as roo
where rn = 1;


-- 3. Use LAG() to find employees whose salary decreased compared to the previous row.
SELECT 
    employee_id, 
    employee_name, 
    department_id, 
    salary, 
    lag_sal
FROM (
    SELECT 
        employee_id, 
        employee_name, 
        department_id, 
        salary,
        LAG(salary) OVER (ORDER BY employee_id) AS lag_sal
    FROM employees
) AS salary_changes
WHERE salary < lag_sal;


-- 4. Show each order and the average amount of the previous 2 orders using a sliding window.
SELECT 
    order_id,
    customer_id,
    total_amount,
    AVG(total_amount) OVER (
        ORDER BY order_id 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS avg_prev
FROM orders;


-- 5. Use ROW_NUMBER() to filter and show the latest order per customer.
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
    FROM orders
) AS roo
WHERE rn = 1;


-- 6. Calculate the difference in salary from the previous employee in the same department using LAG().
SELECT *,
    SUM(total_amount) OVER (
        ORDER BY months
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS months,
        SUM(total_amount) AS total_amount
    FROM orders
    GROUP BY months
) AS r;


-- 8. Show customers and their orders with cumulative total and cumulative count.
SELECT
    *,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total,
    
    COUNT(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_count
FROM orders;


-- 9. Use NTILE(3) to divide products into 3 pricing tiers.
select *,
	ntile(3) over ( order by price desc) as part
from products;


-- 10. Show the second-highest order per customer using window functions with subqueries.
SELECT customer_id, order_id, order_date, total_amount, (price * quantity) AS total_order, rankk
FROM (
    SELECT 
        o.*, 
        oi.price, 
        oi.quantity,
        dense_rank() OVER (PARTITION BY o.customer_id ORDER BY (oi.price * oi.quantity) DESC) AS rankk
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
) AS roo
WHERE rankk = 2;


-- 11. Identify employees who earn more than the average salary in their department using a window AVG().
select e.* , d.depart_avgsal
from employees e
join (
    select 
        department_id,
        avg(salary) over (partition by department_id) as depart_avgsal
    from employees
) as d on e.department_id = d.department_id
where e.salary > d.depart_avgsal;



-- 12. Find the date difference between current and previous order per customer using LAG().
SELECT
    order_id,
    customer_id,
    order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_date,
    DATEDIFF(order_date, LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date)) AS order_difference
FROM orders;

        
-- 13. Compare each employee's salary to the department's maximum using MAX() OVER(PARTITION BY department_id).
SELECT
    employee_id,
    employee_name,
    department_id,
    salary,
    manager_id,
    MAX(salary) OVER (PARTITION BY department_id) AS department_maxsal,
    ROUND(salary - MAX(salary) OVER (PARTITION BY department_id), 0) AS sal_diff_from_max
FROM employees;


-- 14. Display sales trends using LEAD() and LAG() to compare amounts month over month.

-- 15. Use FIRST_VALUE() to tag orders with the first product ordered by a customer.

/*
🔴 ADVANCED (Level 3): Advanced Logic, Nested Queries, and Custom Frames
Show the difference between current and previous 2 salaries using ROWS BETWEEN 2 PRECEDING AND CURRENT ROW.

Use RANK() inside a CTE to find the top 3 products per category.

Calculate percentage change between current and previous order amounts per customer.

Create a trend analysis report with LAG(), LEAD(), and conditional CASE for growth/shrink.

Combine ROW_NUMBER() and PARTITION BY to deduplicate records by keeping latest per group.

Compute moving average of last 3 salaries per employee using sliding windows.

Use window functions to identify "first purchase", "repeat purchase", and "loyal" customers.

Calculate cumulative count and amount of sales grouped by product category and week.

Use NTILE() in a dynamic tiering model based on order value and customer location.

Create a leaderboard per product category using DENSE_RANK() with ties.

Find customers with orders increasing every time using LEAD() and comparison logic.

Track promotion eligibility by calculating tenure in months using date window functions.

Calculate time gaps between events (e.g., logins) using LAG() and DATEDIFF().

Combine multiple window functions in one query for advanced performance dashboards.

Create a revenue trend classification column using CASE + LEAD() for rise/fall/stable tagging.

