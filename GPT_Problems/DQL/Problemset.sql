use problem_set;

-- ****************** ****************** SIMPLE (Level 1) – 10 Questions ****************** ****************** 
-- 1. Select all columns from a table named employees.
select * from employees;

-- 2. Get the first name and last name of all employees.
select employee_name, 
		SUBSTRING_INDEX(employee_name, ' ', 1) AS first_name,
        SUBSTRING_INDEX(employee_name, ' ', -1) AS last_name
from employees;

-- 3. Retrieve distinct department names from the departments table.
select distinct department_name
from departments;

-- 4. Find employees with salary greater than 50000.
select *
from employees
where salary > 50000;

-- 5. Retrieve records from orders placed after 2023-01-01.
select * 
from orders
where order_date > '2023-01-01';

/*
List products whose price is between 100 and 300.

Get all customers from customers table whose name starts with 'A'.

Count the number of employees in the employees table.

Sort employees by hire_date in ascending order.

Find employees who do not have a manager (NULL manager_id).

🟡 INTERMEDIATE (Level 2) – 10 Questions
Get the average salary of employees in each department.

Find the total sales (quantity * price) for each product in the order_items table.

Retrieve the top 5 highest paid employees.

Find the number of employees in each job title.

List employees who joined in the last 6 months.

Get the maximum salary in each department but only show departments where the max salary is over 100000.

Join employees and departments to get employee names along with their department names.

Show customers who have placed more than 3 orders.

Retrieve all employees who work in departments located in 'New York'.

Find products that have not been ordered at all.

🔴 ADVANCED (Level 3) – 10 Questions
Get the second highest salary from the employees table.

Retrieve the top-selling product (by total quantity).

List employees who earn more than the average salary of their department.

Find all employees who report to the same manager as 'John Doe'.

Find the department with the highest average salary.

Show customers who have never placed an order (use LEFT JOIN).

Use a subquery to list all employees who have a salary higher than the average salary of all employees.

Write a query that lists all employees and their manager's name.

Rank employees by salary within each department using RANK() or a window function (if supported).

Show the monthly total sales for the current year grouped by month.

*/