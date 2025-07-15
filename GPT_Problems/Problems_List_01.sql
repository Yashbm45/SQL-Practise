-- Problem List
use gptpp;

-- **************🧩 1. Intermediate Level (Basics, Joins, Aggregations) ****************
-- ************Get a list of all customers who signed up in 2022. */
select *
from customers
where Year(signup_date) = 2022;


-- *********Count the total number of orders made by each customer.
select customer_id, count(order_id) as total_orders, sum(quantity) as total_Quan
from orders o
group by customer_id;

-- ******** List all orders where quantity is greater than 2.
select *
from orders 
where quantity >= 2;

-- ******** Get the total revenue (sum of total_amount) from the orders table.
select sum(total_amount) as total_revenue
from orders;

-- Find the most expensive product.
select * 
from products
order by price desc
limit 1;

-- *************** List products with price greater than 100.
select *
from products
where price > 100;

-- *************** Find how many orders each product has received.
select product_id, count(order_id) as total_Orders
from orders 
group by product_id;

-- ***************Get the names and emails of customers who placed at least one order.
with ro as (
select customer_id, count(order_id) as total_orders
from orders 
group by customer_id ) 

select * 
from customers c
join ro r 
on c.customer_id = r.customer_id;
-- ***************Show orders made between '2023-01-01' and '2023-01-10'.
select *
from orders 
where order_date between '2023-01-01' and '2023-01-10';

-- ***************Count how many customers signed up per month.
select month(signup_date) as Month, count(*) as count_Per_Month
from customers
group by Month(signup_date);

-- ***************Get total revenue per product category.
select p.category, sum(o.total_amount) as total_revenu
from orders o
join products p
on o.product_id = p.product_id
group by p.category;

-- ***************Find the top 3 products by total sales.
select product_id, sum(total_amount)  as total
from orders
group by product_id
order by total desc
limit 3;

-- ***************Show the product name and total quantity sold.
select p.product_name, sum(o.quantity) as total_Sold
from orders o
join products p 
on o.product_id = p.product_id
group by p.product_name;

-- ***************Find the average order value (total_amount) per customer.
select customer_id, round(avg(total_amount),2)as AVG_Per_cust
from orders o
group by customer_id;

-- ***************List customers who have never placed an order.
select *
from customers c
where customer_id not in (
select customer_id 
from orders);

-- ***************List the first 5 orders placed (by order date).
select *
from orders
order by order_date asc, total_amount desc
limit 5;

-- ***************Find customers who have made more than 3 orders.
select count(order_id) as orders_made, customer_id
from orders 
group by customer_id
having orders_made > 3;


-- ****************** Count orders per day.
select day(order_date) as day, count(order_id) as order_count
from orders
group by day(order_date);

-- ****************** Show the latest order per customer.
select *
from (
select *, 
row_number() over (partition by customer_id order by order_date) as row_Num
from orders ) as subb
where row_Num = 1;

-- ****************** Find duplicate customer emails (if any).
select * 
from (
select *, count(customer_id) over (partition by email) as Email_count
from customers ) as sub
where Email_count >= 1;



-- **********************🚀 2. Advanced Level (Window Functions, CTEs, Subqueries) ******************************

-- ********************** Rank products by total revenue using RANK() window function.
with ro as ( select distinct(product_id), 
sum(total_amount) over (partition by product_id) as total
from orders
order by total desc )

select *, rank() over (order by r.total desc) as rankkk
from products p
join ro r
on p.product_id = r.product_id;

-- ********************** Get the cumulative revenue by day using SUM(...) OVER (ORDER BY order_date).
select *, 
SUM(total_amount) OVER (ORDER BY order_date) as cumulative_revenue
from orders;

-- ********************** Find each customer's first order date.
select *
from (
select *,
dense_rank() over ( partition by customer_id order by order_date ) as  rankk
from orders ) as subb
where rankk = 1;

-- ********************** List customers who ordered the same product more than once.
select *, count(o.order_id)
from orders o
join orders oo 
on o.order_id = oo.order_id
group by o.order_id
having o.order_id = oo.order_id and count(o.order_id) >= 2;

-- ********************** For each customer, calculate average order value using window functions.
select distinct(customer_id), 
avg(total_amount) over (partition by customer_id) as avg_per_cust
from orders;

-- ********************** Get the most recent 3 orders per customer.
select *
from ( select *,
row_number() over (partition by customer_id order by order_date) as rowNum
from orders ) as sub
where rowNum <= 3
order by customer_id;


-- ********************* List products that haven’t been ordered in the last 30 days.
-- approach 1
SELECT *
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE oi.product_id = p.product_id
      AND o.order_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
);

-- appproach 2
SELECT p.*
FROM products p
LEFT JOIN (
    SELECT DISTINCT oi.product_id
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
) recent_orders ON p.product_id = recent_orders.product_id
WHERE recent_orders.product_id IS NULL;


-- ********************* Use a CTE to get all orders where total_amount is above customer’s average.
 with ro2 as (
select *,
avg(total_amount) over () as cust_avg
from orders
)
select *
from ro2
where total_amount > cust_avg;

-- ********************* Find customers who only ordered from the "Books" category.
select c.customer_id, c.name, c.email 
from products p
join orders o
on o.product_id = p.product_id
join customers c
on c.customer_id = o.customer_id
where p.category = "Books";


-- ********************* List order frequency per customer (days between orders).

-- Get top 3 customers by total spend.
select distinct(o.customer_id),c.name, sum(o.total_amount) over ( partition by customer_id) as Total_spend
from customers c
join orders o 
on c.customer_id = o.customer_id
order by total_spend desc
limit 3;

-- ********************* Create a report showing total sales, average sales, and number of orders by category. ********************* 
select p.category,
sum(total_amount) total_sales, 
avg(total_amount) average_sales, 
count(order_id) num_orders_category
from orders o
join products p
on o.product_id = p.product_id
group by p.category;

-- *********************  Show daily revenue and compare it with the previous day (use LAG()).  ********************* 
WITH aggre AS (
    SELECT
        order_date,
        SUM(total_amount) AS daily_total
    FROM orders
    GROUP BY order_date
),
diffs AS (
    SELECT
        order_date,
        daily_total,
        LAG(daily_total) OVER (ORDER BY order_date) AS prev_day_total
    FROM aggre
)
SELECT
    order_date,
    daily_total,
    prev_day_total,
    (daily_total - prev_day_total) AS revenue_diff
FROM diffs;

-- approach 2
SELECT
    order_date,
    daily_total,
    LAG(daily_total) OVER (ORDER BY order_date) AS prev_day_total,
    daily_total - LAG(daily_total) OVER (ORDER BY order_date) AS revenue_diff
FROM (
    SELECT order_date, SUM(total_amount) AS daily_total
    FROM orders
    GROUP BY order_date
) AS daily;

-- Show orders where quantity is higher than the average order quantity.
-- approach 1
with ro3 as (
select *,
avg(quantity) over () as quant_avg
from order_items
)
select *
from ro3
where quantity > quant_avg;

-- approach 2
select *
from order_items
where quantity > (select avg(quantity) from order_items);
-- Approach 1 - Slow -- The AVG(...) OVER () is computed per row, although the result is the same across all rows. MySQL has to materialize the full result set with the extra quant_avg column before filtering.
-- Approach 2 - fast -- MySQL executes the subquery once, computes the average, and compares quantity to it. Simple, efficient plan — minimal memory overhead.

--  ************************* Find the product with the highest average order quantity. *************************
select avg_quant,
rank() over ( order by avg_quant) as rankkk
from (
select *,
avg(quantity) over(partition by product_id) as avg_quant
from orders 
order by avg_quant desc ) as roo;

-- ************************* Calculate running total of quantity sold per product. *************************
select distinct(product_id) as pp,
 sum(quantity) over( partition by Product_id order by product_id rows unbounded preceding) as running_total
from orders;


-- ************************* Use CASE to classify orders as 'High', 'Medium', 'Low' value. *************************
select distinct(customer_id),
sum(total_amount) over ( partition by customer_id) as totall,
case when total_amount > 100 then 'High'
		when  total_amount > 50 then 'Medium'
        else 'Low' end as Category
from orders;

-- ************************* Find product category with most unique customers. *************************
select min(cust_count)
from (
select  product_id, count(customer_id) as cust_count
from orders
group by product_id ) as roo;

-- Create a rolling 7-day revenue total.
select *,
sum(total_amount) over( order by customer_id rows between 7 preceding and current row ) as rolling_total
from orders;

-- ************************* Identify customers whose spending has decreased month-over-month. *************************


-- ************** ************* 3. Professional Level (Business Logic, Optimization, Analytical Queries) *************  ************* 
-- ************************* Build a customer lifetime value (LTV) model (total spend per customer). *************************
select customer_id,
sum(total_amount) as total_spend
from orders
group by customer_id;

-- ************************* Segment customers based on total spend: High, Medium, Low. *************************
select *,
case when total_spend > 1000 then 'High'
		when total_spend > 100 then 'Medium'
        else 'Low' end as category
from (
select *,
sum(total_amount) over (partition by customer_id) as total_spend
from orders ) as roo;


-- ************************* Identify customers whose average order value is increasing over time. *************************
select *,
		avg(total_amount) over ( partition by customer_id order by order_date rows between 2 preceding and current row ) as avg_t
	from orders;


-- ************************* Determine the most popular product per category. *************************
select distinct(p.category) as cat,
sum(o.total_amount) over ( partition by p.category ) as total_cate
from orders o
join products p
on o.product_id = p.product_id;


-- ************************* Find time gap (in days) between customer’s first and last order. *************************
select customer_id,
		min(order_date) as min_order,
		max(order_date) as max_order,
        max(order_date) - min(order_date) as diff
from orders
group by customer_id;

-- ************************* Create a cohort analysis: group customers by signup month and track order activity. *************************

-- ************************* Use nested subqueries to find the customer with the highest average order value. *************************
select *
from customers
where customer_id = ( select customer_id
from orders
group by customer_id
order by avg(total_amount) desc
limit 1
)
;
-- ************************* List customers with orders in 3 or more different categories. *************************
select customer_id, count(product_id) as cnt_prdt
from orders
group by customer_id
having count(product_id) > 3;

-- Calculate average revenue per product per week.


-- Create a view to track daily active customers.


-- ************************* Find the product with the most volatile daily sales (using standard deviation). *************************
select product_id, round(stddev_samp(total_amount),2) as stdd
from orders
group by product_id
order by stdd desc
limit 1;

-- Identify abandoned customers (no orders in last 90 days).

-- Detect seasonal sales trends across months.

-- Predict future revenue using linear regression in SQL (if engine supports it).

-- Use CTEs and JOINs to find products frequently bought together.

-- Create a dynamic customer ranking per month.

-- Track category-level sales share changes over months.

-- Identify customers with high purchase frequency but low spend.

-- Write a query to optimize index suggestion (most frequent filter columns).

-- ***************Build a performance report showing revenue, quantity, and order count by day, category, and customer segment.
