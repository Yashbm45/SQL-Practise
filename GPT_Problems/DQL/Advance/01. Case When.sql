use problem_set;
-- ******************** ******************** SIMPLE (Level 1): Basic CASE WHEN Usage ******************** ********************
-- 1. Add a column that shows 'High' if the order amount is above 300, else 'Low'. 
select *, case
			when total_amount > 300 then 'High'
            else 'Low' end as Type
from orders;


-- 2. Label employees as 'Senior' if salary > 60000, else 'Junior'.
select *, 
		case when salary > 60000 then 'Senior'
        else 'Junior' end as Type
from employees;

-- 3. Show 'Electronics', 'Accessories', or 'Other' based on product category ID using CASE.

-- 4. Assign a status label to customers: 'New' if registered after 2022, else 'Existing'.
select *,
		case when Year(registration_date) < 2021 then 'Existing'
        else 'New' end as Type
from customers;

-- 5. Use CASE to display 'Even' or 'Odd' based on order ID.
select *,
	case when (order_id % 2 = 0) then 'Even'
    else 'Odd' end as Eo
from orders;


-- 6. Replace NULL manager IDs with 'No Manager' using CASE.
select * ,
	case when manager_id is null then "No Manager"
    else manager_id end as MN
from employees;


-- 7. Categorize products as 'Expensive', 'Moderate', or 'Cheap' using CASE.
select *,
		case when price > 500 then "Expensive"
			when price > 100 then "Moderate"
            else "Cheap" end as Cat
from products;


-- 8. Show employees' experience level: 'Fresh' (<1 year), 'Experienced' (1–5 years), 'Veteran' (>5 years).
select * ,
	case
		when (Year(now()) - Year(hire_date)) > 5 then "Veteran"
        when (Year(now()) - Year(hire_date)) > 1 then "Experience"
        else "Fresher" end as ExpCat
from employees;


-- 9. Label orders as 'Large', 'Medium', or 'Small' based on total amount ranges.

-- 10. Classify customers as 'Active' or 'Inactive' based on whether they’ve placed an order.
/*
Display 'Weekend' or 'Weekday' based on the day of the order_date.

Format employee status as 'Yes' or 'No' based on whether they report to a manager.

🟡 INTERMEDIATE (Level 2): CASE WHEN with Multiple Conditions and Aggregates
Show order priority: 'High' (>400), 'Medium' (200–400), 'Low' (<200).

Use CASE in ORDER BY to sort products as: Accessories > Electronics > Others.

Count the number of 'High' and 'Low' salary employees using CASE in aggregation.

Calculate bonus: 10% for salary > 60000, 5% otherwise using CASE.

In a query, display gender as 'Male', 'Female', or 'Unspecified' based on a code.

Label employees who are managers (manager_id IS NULL) or staff.

Use CASE to compare each employee’s salary to the department average.

Categorize orders by month: 'Q1', 'Q2', 'Q3', 'Q4'.

Use CASE to pivot product types into columns (Electronics, Accessories, etc.).

Show a flag column: 1 if a customer has ordered >2 times, else 0.

Display discounts: 20% for orders >500, 10% for 200–500, none otherwise.

Use CASE to mask email addresses (e.g., show only domain if not admin).

🔴 ADVANCED (Level 3): Complex Logic, Nested CASE, and DML Integration
Write a nested CASE to label employees based on salary and years of experience.

Create a dynamic commission model: based on role and performance rating.

Use CASE to handle overlapping ranges in product pricing tiers.

Use CASE in a GROUP BY to segment sales by custom time ranges.

Apply CASE logic to rank customers as Platinum, Gold, Silver using total order value.

Implement a CASE to assign inventory reorder levels based on category and stock count.

Use CASE in an UPDATE to set status: 'Priority', 'Normal', or 'Delayed' based on order_date.

Display employee hierarchy level using CASE based on manager depth.

Use CASE in a view to classify order fulfillment status based on multiple criteria.

Implement a conditional format for product names: uppercase if premium, lowercase otherwise.

Write a query using CASE in a join condition for matching optional relationships.

Combine CASE with window functions to flag first purchase per customer.

Let me know if you need solutions, dataset, or table schema to practice with these! */