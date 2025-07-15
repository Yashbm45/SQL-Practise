-- 🟢 SIMPLE (Level 1): Basic CTE Usage
-- 1. Use a CTE to select all employees with salary greater than 50,000.
with sal as (
	select * from employees
	where salary > 50000
)
select * from sal;


-- 2. Write a CTE to find products with a price above the average price.
WITH avg_price AS (
    SELECT AVG(price) AS avg_price
    FROM products
)
SELECT p.*
FROM products p
CROSS JOIN avg_price
WHERE p.price > avg_price.avg_price;


-- 3. Create a CTE to show customers who registered in 2022.
with registration_2022 as (
	select * 
	from customers
	where year(registration_date) = 2022
)
select * from registration_2022;


-- 4. Use a CTE to count the number of employees per department.
with emp_count as (
	select d.department_name, count(e.employee_id) as emp_count
	from employees e
	join departments d
	on e.department_id = d.department_id
	group by d.department_name
)
select * from emp_count;

	-- Including departments with zero employees (if needed):
	-- You'd use a LEFT JOIN instead of an INNER JOIN:
    
WITH emp_count AS (
    SELECT 
        d.department_name, 
        COUNT(e.employee_id) AS emp_count
    FROM departments d
    LEFT JOIN employees e ON e.department_id = d.department_id
    GROUP BY d.department_name
)
SELECT * FROM emp_count;

-- 5. Create a CTE that selects all orders with total_amount > 300.
with order_above as (
select *
from orders
where total_amount > 300
)
select * from order_above;


-- 6. Use a CTE to find the top 5 most expensive products.
with products_top5 as (
	select *
    from products
    order by price desc
    limit 5
) 
select * from products_top5;


-- 7. Write a CTE to join orders and customers, showing order_id and customer_name.
with cust_order as (
	select o.order_id, c.customer_name
	from customers c
	join orders o
	on o.customer_id = c.customer_id
)
select * from cust_order;


-- 8. Use a CTE to filter employees hired before 2021.
with hire_cte as (
select * 
from employees
where year(hire_date) < 2021 
)
select * from hire_cte;


-- 9. Create a CTE that calculates the total sales per product.
with total_pro as (
	select p.product_name, o.total_amount
	from orders o
	join order_items oi on o.order_id = oi.order_id
	join products p  on oi.product_id = p.product_id
)
select product_name,
		sum(total_amount) as total
from total_pro
group by product_name;


-- 10. Write a CTE to retrieve products not ordered (use NOT IN).
with pro_order as (
	select * 
	from products
	where product_id not in (
							select distinct product_id 
                            from order_items)
) 
select * from pro_order;


-- 11. Use a CTE to rank products by price using ROW_NUMBER().
with rankk as (
select *,
	row_number() over (order by price desc) as rankk
from products
)
select * from rankk;

-- 12. Write a query with a CTE to calculate average salary and return employees earning above it.
with avg_sal as (
	select avg(salary) avg_sal
	from employees
)
select * 
from employees
cross join avg_sal
where salary > avg_sal;



-- 🟡 INTERMEDIATE (Level 2): Multi-CTEs, Aggregations, and Joins
-- 1. Use two CTEs: one to get total sales per product, another to filter products with sales > 1000.
WITH total_sales AS (
    SELECT 
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.product_name
),
high_sales AS (
    SELECT *
    FROM total_sales
    WHERE total_sales > 1000
)
SELECT *
FROM high_sales;

    
-- 2. Create a CTE to find the latest order per customer.
WITH latest AS (
    SELECT 
        customer_id,
        MAX(order_date) AS latest_order_date
    FROM orders
    GROUP BY customer_id
)
SELECT o.*
FROM orders o
JOIN latest l 
    ON o.customer_id = l.customer_id 
   AND o.order_date = l.latest_order_date;
   
   
-- 3. Write a CTE that joins employees and departments to show department names.
with depart as (
	SELECT 
		e.employee_id,
		e.employee_name,
		d.department_id,
		d.department_name
	FROM employees e
	JOIN departments d 
    ON e.department_id = d.department_id
)
select * 
from depart
ORDER BY department_name, employee_name;


-- 4. Use a CTE to find customers who ordered more than 3 times.
with cust as (
	 select customer_id, count(order_id) as order_count
     from orders
     group by customer_id
	)
select c.*
from customers c
join cust cc on c.customer_id = cc.customer_id
where cc.order_count > 3;


-- 5. Create a CTE that groups orders by month and calculates total sales.
with mon as (
	select *, year(order_date) as yearr, month(order_date) as monthh
    from orders 
)
select *,
	sum(total_amount) over (partition by yearr, monthh) as monthly_total
from mon
ORDER BY yearr, monthh, order_date;

-- Step 1: CTE to get monthly totals with group by
WITH monthly_totals AS (
    SELECT 
        YEAR(order_date) AS yearr,
        MONTH(order_date) AS monthh,
        SUM(total_amount) AS monthly_total
    FROM orders
    GROUP BY 
        YEAR(order_date), 
        MONTH(order_date)
)
-- Step 2: Join CTE back to orders to get full order records + monthly total
SELECT 
    o.*, 
    mt.monthly_total
FROM orders o
JOIN monthly_totals mt 
    ON YEAR(o.order_date) = mt.yearr 
   AND MONTH(o.order_date) = mt.monthh
ORDER BY 
    mt.yearr, mt.monthh, o.order_date;



-- 6. Use a CTE to return employees who earn more than their manager
WITH maneger AS (
    SELECT 
        e.employee_id, 
        e.employee_name, 
        e.salary AS employee_salary, 
        e.manager_id, 
        m.employee_name AS manager_name,
        m.salary AS manager_salary
    FROM employees e
    JOIN employees m ON e.manager_id = m.employee_id
    WHERE e.salary > m.salary
)
SELECT * 
FROM maneger;


    
-- 7. Create a CTE to display each customer's total order count and total amount.
with cust as (
select *,
	count(order_id) over (partition by customer_id) as total_orders,
    sum(total_amount) over (partition by customer_id) as total
from orders 
)
select c.*, cc.total_orders, cc.total
from customers c
join cust cc on c.customer_id = cc.customer_id;



-- 8. Use a CTE with RANK() to list the top 3 highest-spending customers.
WITH customer_totals AS (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT *,
           RANK() OVER (ORDER BY total_spent DESC) AS spend_ranking
    FROM customer_totals
)
SELECT *
FROM ranked_customers
WHERE spend_ranking <= 3;



-- 9. Write a CTE to find products ordered by only one customer.
WITH product_customers AS (
    SELECT 
        oi.product_id,
        COUNT(DISTINCT o.customer_id) AS unique_customers
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY oi.product_id
)
SELECT p.*
FROM products p
JOIN product_customers pc ON p.product_id = pc.product_id
WHERE pc.unique_customers = 4;

    

-- 10. Create a CTE that shows products and total quantity ordered across all orders.
WITH product AS (
    SELECT 
        p.product_id,
        p.product_name,
        SUM(oi.quantity) AS total_quantity,
        SUM(oi.quantity * oi.price) AS total_sale
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT * 
FROM product
ORDER BY total_sale DESC;


-- 11. Use a CTE to classify orders by size: 'Small', 'Medium', 'Large'.
with classification as (
	select *,
		case
			when total_amount > 400 then 'Large'
            when total_amount > 100 then 'Medium'
            else 'Small' end as Order_type
	from orders
)
select * from classification;



-- 12. Write a CTE that joins with a subquery to compare employee salary with department average.
WITH depart AS (
    SELECT 
        e.*, 
        ds.avg_sal
    FROM employees e
    JOIN (
        SELECT 
            department_id, 
            AVG(salary) AS avg_sal
        FROM employees
        GROUP BY department_id
    ) AS ds
    ON e.department_id = ds.department_id
    WHERE e.salary > ds.avg_sal
)
SELECT * 
FROM depart;



-- 🔴 ADVANCED (Level 3): Recursive and Complex CTEs
-- 1. Write a recursive CTE to generate numbers from 1 to 10.
with recursive recursive1 as (
	-- CTE Query / anchor query
    select 1 as num
    -- set operator to combine result
	union all
    -- recursive query
    select num + 1
    from recursive1
    where num < 10
)
select * from recursive1;



-- 2. Use a recursive CTE to find the factorial of numbers 1 to 5.
with recursive factorial as (
	select 1 as num, 1 as fact
    union all
    select num+1, fact * (num +1) as fact
    from factorial
    where num < 5
)
select * from factorial;


-- 3. Create a recursive CTE to traverse an employee hierarchy (manager to subordinates).
WITH RECURSIVE hierarchy AS (
    SELECT 
        employee_id, 
        employee_name, 
        department_id, 
        manager_id, 
        1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT 
        e.employee_id, 
        e.employee_name, 
        e.department_id, 
        e.manager_id, 
        h.level + 1
    FROM employees e
    INNER JOIN hierarchy h
        ON e.manager_id = h.employee_id
)
SELECT * FROM hierarchy;

select * from products;
-- 4. Write a recursive CTE to flatten a parent-child product category structure.



-- 5. Use a CTE with UNION ALL to build a sequence of order dates.
with recursive order_date as (
	select min(order_date) as datee
    from orders
    union all
    select date_add(od.datee,interval 1 day) as datee
    from order_date od
    where datee  < (SELECT MAX(order_date) FROM orders)
) 
select * from order_date;


SELECT * FROM date_sequence;

-- 6. Create a CTE that calculates cumulative monthly sales by customer.
WITH monthly_sales AS (
    SELECT
        customer_id,
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(total_amount) AS monthly_total
    FROM orders
    GROUP BY customer_id, DATE_FORMAT(order_date, '%Y-%m')
),
cumulative_sales AS (
    SELECT *,
        SUM(monthly_total) OVER (
            ORDER BY month
        ) AS cumulative_total
    FROM monthly_sales
)
SELECT * FROM cumulative_sales;

-- 7. Use a CTE to identify the second highest salary per department.
WITH sal AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rn
    FROM employees
)
SELECT 
    s.employee_name, 
    s.department_id, 
    d.department_name, 
    s.salary
FROM sal s
JOIN departments d ON d.department_id = s.department_id
WHERE s.rn = 2;


-- 8. Write a recursive CTE to count total subordinates for each manager.

-- 9. Create a CTE used in an UPDATE to adjust prices based on product performance.
with roo as (
	select distinct p.*,sum(oi.quantity) over ( partition by p.product_id) as total_quan_sale
    from order_items oi
    join products p on oi.product_id = p.product_id
), 
	performance as (
		select product_id,
				case 
					when total_quan_sale > 3 then price * 1.12
                    when total_quan_sale between 1 and 3 then price
                    else price * 0.95 end as new_price
		from roo
        )
        update products p
        join performance pp on p.product_id = pp.product_id
        set p.price = pp.new_price 
		where 1 = 1;
        select * from products;
        
-- 10. Use a multi-CTE structure to calculate year-over-year growth in sales.
WITH sales AS (
    SELECT 
        YEAR(order_date) AS yearr,
        total_amount
    FROM orders
),
yearly_sales AS (
    SELECT 
        yearr,
        SUM(total_amount) AS year_total
    FROM sales
    GROUP BY yearr
),
growth AS (
    SELECT
        yearr,
        year_total,
        LAG(year_total) OVER (ORDER BY yearr) AS prev_year_total,
        ROUND(
            (year_total - LAG(year_total) OVER (ORDER BY yearr)) / LAG(year_total) OVER (ORDER BY yearr) * 100,
            2
        ) AS yoy_growth_percent
    FROM yearly_sales
)
SELECT * FROM growth;


-- 11. Create a recursive CTE to compute Fibonacci numbers up to 1000.
WITH RECURSIVE fibo AS (
    SELECT 0 AS prev, 1 AS curr  -- starting two Fibonacci numbers

    UNION ALL

    SELECT curr, prev + curr
    FROM fibo
    WHERE curr <= 1000
)
SELECT curr AS fibonacci_number
FROM fibo;


-- 12. Use a CTE inside a MERGE/INSERT to load transformed data into a reporting table.

