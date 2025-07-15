-- ************* ************* ************* SIMPLE (Level 1/*: Basic Views & Temporary Tables ************* ************* *************
-- 1. Create a view that selects all employees with salary above 50,000.
create view allEmp as
	select * 
	from employees
    where salary > 50000;

select * from allEmp;


-- 2. Create a temporary table that stores products with price less than 100.


-- 3. Query a view that joins customers and orders showing names and order amounts.
create view V2 as
	select c.customer_name, o.total_amount
    from customers c
    join orders o
    on c.customer_id = o.customer_id;

select * from v2;
    
    
-- 4. Create a view showing only the customer names and emails.
create view customer_details as 
select customer_name, email
from customers;

select * from customer_details;

-- 5. Create a temporary table to hold orders from the last 30 days.


-- 6. Drop a view named high_salary_employees.
drop view v2;


-- 7. Create a view that shows employee names along with their department names.
create view emp_department_details as
	select e.employee_name, d.*
    from employees e
    join departments d
    on e.department_id = d.department_id;

select * from emp_department_details;

    
-- 8. Insert data into a temporary table and select from it.

-- 9. Update a view that displays employee salary (if updatable).
update allemp view 
set salary = 91000
where employee_id = 16;

select * from allemp;


-- 10. Create a view that displays product names and classifies them as 'Cheap', 'Average', or 'Expensive'.
create view Classification as
select * ,
	case 
		when price > 400 then 'Expensive'
        when price > 100 then 'Average'
        else 'cheap' end as Classification
from products;

select * from classification;

-- 11. Create a temporary table to count orders by product_id.

-- 12. Check whether a view is updatable or not using a test UPDATE.



-- ************* *************  INTERMEDIATE (Level 2): Multi-Table Views, Aggregations, and Filtered Temp Tables ************* *************
-- 1. Create a view that calculates total order value per customer.
create view total as
select *,
	sum(total_amount) over (partition by customer_id) as total_order_per_cst
from orders
order by total_order_per_cst desc;

select * from total;


-- 2. Create a temporary table to hold top 5 products by quantity ordered.

-- 3. Create a view that shows average salary by department.
create view emp_sal_avg as
select d.*,
	avg(e.salary) over ( partition by e.department_id) as avg_sal_dept
from employees e
join departments d
on e.department_id = d.department_id;

select distinct * from emp_sal_avg;


-- 4. Create a view that uses CASE to classify employees based on years of experience.
drop view experience2;
create view experience2 as
select *,
	timestampdiff(year, hire_date, now()) as exp,
    timestampdiff(month, hire_date, now())  as exp_mon
from employees;

select *,
	exp_mon - (exp*12) as actual_mon
from experience2;


-- 5. Create a temporary table that contains customers with more than 2 orders.


-- 6. Create a view that includes a JOIN and GROUP BY on departments and employees.
create view department_stats as
select d.department_name,
		count(*) as emp_count,
        sum(e.salary) as total_sal,
        avg(e.salary) as avg_sal,
        max(e.salary) as max_sal,
        min(e.salary) as min_sal
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name;

select * from department_stats;


-- 7. Create a view that shows total orders and order count per customer.
create view order_details as
select  customer_id,
		sum(total_amount) as total_order,
		count(*) as order_per_cust
from orders 
group by customer_id;

select * from order_details;


-- 8. Use a view to filter and list all products with no associated orders.
create view product_not_ordered as
select *
from products
where product_id not in ( 
						select product_id 
                        from orders);
                        
select * from product_not_ordered;


-- 9. Create a view to show employee ranks using window functions.
create view ranking as
	select *, rank() over (order by salary) as ranks
    from employees;
    
select * from ranking;


-- 10. Create a temporary table that calculates discount based on product price tiers.
create view discount as
select * ,
	case 
		when price > 80 then '10%'
		when price > 50 then '5%'
        else '3%' end as discount_per
from products;

select * from discount;

-- 11. Use a temporary table to store intermediate results for complex joins.

-- 12. Create a view that excludes employees who are managers (manager_id IS NULL).
create view managers as
select *
from employees
where manager_id is null;

select * from managers;


-- ************* ************* ADVANCED (Level 3): Complex Views, Materialization, DDL with Views/Temp Tables ************* *************
-- 1. Create a complex view using multiple JOINs and subqueries for a sales summary dashboard.
create view pivot as
select distinct 
        p.category,
        sum(o.total_amount) over (partition by p.category) as total_sale_cat,
        sum(oi.quantity) over (partition by p.category) as total_quant_cat,
        count(o.order_id) over (partition by p.category) as order_count_cat,
        p.product_id,p.product_name,
		sum(o.total_amount) over (partition by p.product_id) as total_sale_amt,
        sum(oi.quantity) over (partition by p.product_id) as total_quant_sold,
        count(oi.product_id) over (partition by p.product_id) as total_orders
from orders o
join order_items oi
on oi.order_id = o.order_id
join products p
on p.product_id = oi.product_id;

-- 2. Create a view with a recursive CTE to display employee hierarchy.
create view recursive_view as 
	with recursive recursive1 as (
		select employee_id, employee_name, department_id, salary, manager_id, 1 as level
        from employees
        where manager_id is null
        
        union all
        
        select e.employee_id, e.employee_name, e.department_id, e.salary, e.manager_id, r.Level + 1 as level
        from employees e
        inner join recursive1 r on e.manager_id = r.employee_id
	)
    select * from recursive1;
    select * from recursive_view;
    
    
-- 3. Create a view that performs monthly sales aggregation per city and category.
select year(o.order_date), month(o.order_date),
		sum(o.total_amount) over (partition by year(o.order_date),month(o.order_date)) as total_sale_month,
        p.category,o.total_amount,
		sum(o.total_amount) over (partition by p.category) as total_sale_cat,
        sum(oi.quantity) over (partition by p.category) as total_quant_cat,
        count(o.order_id) over (partition by p.category) as order_count_cat,
        c.city,
        sum(o.total_amount) over (partition by c.city) as city_total,
		sum(oi.quantity) over (partition by c.city) as total_quant_city,
        count(o.order_id) over (partition by c.city) as order_count_city
from orders o
join order_items oi
on oi.order_id = o.order_id
join products p
on p.product_id = oi.product_id
join customers c
on o.customer_id = c.customer_id
order by c.city;

select *
from orders o
join customers c
on o.customer_id = c.customer_id
group by c.city;

-- 4. Create a temporary table to calculate and store cumulative monthly sales per customer.
CREATE VIEW cumulative_monthly_sales AS
WITH monthly_sales AS (
    SELECT 
        customer_id,
        date_format(order_date, '%Y-%m') AS month,
        SUM(total_amount) AS monthly_total
    FROM orders
    GROUP BY customer_id, month
)
SELECT 
    customer_id,
    month,
    SUM(monthly_total) OVER (
        PARTITION BY customer_id 
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_total
FROM monthly_sales;
    
    
-- 5. Use a view to simulate a pivot table (e.g., total sales per product per quarter) and total sale of year.
select distinct 
		product_name,
		yearr,
        sum(total_amount) over (partition by  yearr) as Y_sum,
        quarters,
		sum(total_amount) over(partition by product_id, yearr,quarters) as Q_sum
from (select *,
		year(o.order_date) as yearr,
		case 
			when month(o.order_date) >= 10 then 'Q4'
            when month(o.order_date) >= 7 then 'Q3'
            when month(o.order_date) >= 4 then 'Q2'
            else 'Q1' end as Quarters
from orders o
join products p
on o.order_id = p.product_id
order by yearr desc, quarters asc ) as pivot_date
order by product_name;


-- 6. Create a view that includes logic to show employee performance classification.
CREATE VIEW performance AS
SELECT
    employee_id,
    employee_name,
    department_id,
    performance_score,
    
    CASE
        WHEN performance_score >= 85 THEN 'Excellent'
        WHEN performance_score >= 70 THEN 'Good'
        WHEN performance_score >= 50 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS performance_classification

FROM employees;

	
-- 7. Create a temporary table that stores the latest order per customer using ROW_NUMBER().


-- 8. Create a view to compare each employee’s salary to the company-wide average.
CREATE VIEW salary_compare AS
    SELECT 
        e.*, (e.salary - ee.avg_sal) AS salary_diff
    FROM employees e
	CROSS JOIN
        (SELECT 
		AVG(salary) AS avg_sal
        FROM
		employees) AS ee;
        

-- 9. Create a view used to populate a report table with pre-aggregated metrics.
CREATE VIEW report_metrics AS
SELECT
    department_id,
    COUNT(*) AS total_employees,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary
FROM employees
GROUP BY department_id;


-- 10. Write a view using a subquery in the SELECT clause to calculate average product price in category.
CREATE VIEW product_with_avg_category_price AS
SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    (
        SELECT AVG(price)
        FROM products
        WHERE category = p.category
    ) AS avg_category_price

FROM products p;



-- 11. Create a temporary table to support a batch data transformation pipeline.

-- 12. Create a view with filters and joins that can be indexed or materialized in some RDBMS.
CREATE VIEW active_employee_summary AS
SELECT
    e.employee_id,
    e.department_id,
    d.department_name,
    e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

