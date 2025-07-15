
use problem_set;

-- 1. Find all employees whose first name starts with 'A'.
SELECT * FROM employees WHERE first_name LIKE 'A%';

-- 2. Retrieve customers whose last name ends with 'd'.
select *
from customers
where customer_name like '%d';

-- 2. List products whose name contains 'phone'.
select *
from products
where product_name like '%phone%';


-- 3. Show all users whose username contains exactly 5 characters.
select *
from employees
where employee_name like '_____';


-- 4. Find employees whose email contains '@company.com'.
select *
from customers
where email like '%@example.com';


-- 5. Get all departments whose name starts with 'Sales'.
select *
from departments
where department_name like '%Sales%';



-- 🟡 INTERMEDIATE (Level 2): Pattern Matching with _, NOT LIKE, combined LIKE

-- 1. Find usernames where the second character is 'a'.
SELECT * 
FROM users 
WHERE username LIKE '_a%';

-- 2. Retrieve products where the name does not start with 'S'.
select *
from products
where product_name not like 'S%';


-- 3. Get all customer names where the name contains two consecutive 'l's, like "Allan".
select *
from customers
where customer_name like '%ll%';


-- 4. Show users whose email contains '.edu' but not '.org'.
select *
from users
where email like '%.edu' and email not like '%.org';


-- 5. Find all items whose description has an underscore _ literal (escaped).



-- 🔴 ADVANCED (Level 3): Pattern Matching Using REGEXP (MySQL / PostgreSQL)
-- 1. Find customers whose name starts with a vowel.
select * 
from customers
where customer_name like '%[aeiou]';

SELECT * FROM customers WHERE customer_name REGEXP '^[aeiouAEIOU]';


-- 2. List all products whose name contains only letters (no digits).
SELECT *
FROM products
WHERE product_name NOT REGEXP '[0-9]';


-- Find users whose username ends with a digit.
SELECT *
FROM users
WHERE username REGEXP '[0-9]$';


-- Retrieve employees whose names contain at least two vowels in a row.

-- Get orders where the order code contains a dash - followed by 3 digits.

-- Show records where the comments column includes words like 'error', 'failed', or 'timeout' using REGEXP.

-- Find book titles that contain a word that starts with "re" and is at least 5 characters long.

