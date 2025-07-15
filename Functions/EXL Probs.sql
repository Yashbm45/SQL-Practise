/*EXL Interview Experience
📍 Role: Data Analyst (hashtag#dataanalyst hashtag#powerbi)
💰 CTC Offered: ₹12–15 LPA
📅 Experience Range: 4-5 Years */


-- 1. Write a query to retrieve the top 3 revenue-generating products within each category.
WITH product_revenue AS (
    SELECT 
        p.product_id,
        p.product_name,
        p.category,
        SUM(oi.quantity * oi.price) AS total_revenue
    FROM 
        order_items oi
    INNER JOIN 
        products p ON oi.product_id = p.product_id
    GROUP BY 
        p.product_id, p.product_name, p.category
),
ranked_products AS (
    SELECT 
        pr.*,
        ROW_NUMBER() OVER (PARTITION BY pr.category ORDER BY pr.total_revenue DESC) AS rn
    FROM 
        product_revenue pr
)
SELECT 
    category,
    product_id,
    product_name,
    total_revenue,
    rn as Rankk
FROM 
    ranked_products
WHERE 
    rn <= 3
ORDER BY 
    category, rn;



-- 2. Identify products whose total revenue exceeds the overall average revenue across all products.
WITH product_revenue AS (
    SELECT 
        p.product_id,
        p.product_name,
        p.category,
        SUM(oi.quantity * oi.price) AS total_revenue
    FROM 
        order_items oi
    INNER JOIN 
        products p ON oi.product_id = p.product_id
    GROUP BY 
        p.product_id, p.product_name, p.category
),
average_revenue AS (
    SELECT AVG(total_revenue) AS avg_revenue
    FROM product_revenue
)
SELECT 
    pr.*,ar.*
FROM 
    product_revenue pr,
    average_revenue ar
WHERE 
    pr.total_revenue > ar.avg_revenue;

                        
                        

-- 3. Use LAG() and CASE to find customers with a month-over-month increase in spending.
WITH monthly_spending AS (
    SELECT 
        c.customer_id,
        date_format(o.order_date, '%Y%m') AS order_month,
        SUM(oi.quantity * oi.price) AS monthly_total
    FROM 
        customers c
    JOIN 
        orders o ON c.customer_id = o.customer_id
    JOIN 
        order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        c.customer_id, date_format(o.order_date,'%Y%m')
),
spending_with_lag AS (
    SELECT 
        customer_id,
        order_month,
        monthly_total,
        LAG(monthly_total) OVER (PARTITION BY customer_id ORDER BY order_month) AS previous_month_total
    FROM 
        monthly_spending
)
SELECT 
    customer_id,
    order_month,
    monthly_total,
    previous_month_total,
    CASE 
        WHEN monthly_total > previous_month_total THEN 'Increased'
        ELSE 'Not Increased'
    END AS spending_trend
FROM 
    spending_with_lag
WHERE 
    previous_month_total IS NOT NULL
ORDER BY 
    customer_id, order_month;


-- 4. Write a query to mark the first and last transaction for every user.
select *,
	min(order_date) over ( partition by customer_id) as first_transaction,
    max(order_date) over ( partition by customer_id) as last_transaction
from orders;

-- sol 2
WITH ranked_transactions AS (
    SELECT 
        customer_id,
        order_id,
        order_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date ASC) AS rn_first,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn_last
    FROM 
        orders
)
SELECT 
    customer_id,
	order_id,
    order_date,
    CASE 
        WHEN rn_first = 1 THEN 'First'
        WHEN rn_last = 1 THEN 'Last'
        ELSE NULL
    END AS transaction_marker
FROM 
    ranked_transactions
WHERE 
    rn_first = 1 OR rn_last = 1
ORDER BY 
    customer_id, order_date;

-- sol 3
SELECT 
    *,
    CASE 
        WHEN order_date = MIN(order_date) OVER (PARTITION BY customer_id) THEN 'First'
        WHEN order_date = MAX(order_date) OVER (PARTITION BY customer_id) THEN 'Last'
        ELSE NULL
    END AS transaction_marker
FROM 
    orders;


-- 5. Find employees who share the same manager and also earn the same salary.
with manager as (
	select e.employee_id,e.manager_id,e.salary
    from employees e
    join employees ee on e.manager_id = ee.manager_id
    where ee.manager_id = e.manager_id and ee.salary = e.salary
)
select * from manager;

/*
🐍 Python Interview Questions
 1. Reverse a list without using built-in methods like reverse() or slicing.
 2. Convert the string "abc123xyz" to "ABC123XYZ" using a loop only (no .upper()).
 3. From a dictionary, print all keys associated with even-numbered values.
 4. Define a function to check if two strings are anagrams of each other.
 5. Build a frequency dictionary to count the occurrence of each character in a string.

⸻

📊 Excel Interview Questions
 1. Explain the difference between COUNT, COUNTA, and COUNTBLANK with practical examples.
 2. How do you use INDEX + MATCH to look up a value to the left of the reference column?
 3. Demonstrate how IFERROR is used in complex nested formulas.
 4. Create a formula to highlight duplicate values excluding their first instance.
 5. Use SUMIFS to **calculate total sales where Region = “West” and Month = “Jan”`.

⸻

📈 Power BI Interview Questions
 1. What’s the key difference between a calculated column and a measure in Power BI?
 2. How do you manage many-to-many relationships in your data model?
 3. Write a DAX measure to compute the cumulative sales (running total) per customer.
 4. Describe how to apply dynamic filters using slicers effectively.
 5. How can you design a KPI visual to compare current vs. previous month’s sales?

For more such questions - download*/