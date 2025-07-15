
-- ********* ********* ********* ********* OPERATORS IN SQL ********* ********* ********* ********* 
--  ********* ********* 1. Arithmetic Operators - 
-- --> Used to perform mathematical calculations.

-- 		+		Addition			salary + bonus
-- 		-		Subtraction			price - discount
-- 		*		Multiplication		quantity * rate
-- 		/		Division			total / count
-- 		%		Modulus(remainder)	salary % 1000




-- ********* ********* ⚖️ 2. Comparison Operators
-- --> Used to compare values.

-- 		=			Equal to					age = 30
-- 		!= or <>	Not equal to				name != 'John'
-- 		>			Greater than				salary > 50000
-- 		<			Less than					price < 100
-- 		>=			Greater than or equal		age >= 18
-- 		<=			Less than or equal			experience <= 5
-- 		BETWEEN		Between two values			age BETWEEN 20 AND 30
-- 		LIKE		Pattern match				name LIKE 'A%'
-- 		IN			Match any in list			city IN ('NY', 'LA')
-- 		IS NULL		Check for NULL				email IS NULL



-- *********  *********  🔗 3. Logical Operators
-- --> Used to combine multiple conditions.

-- 		AND			All conditions true	age > 25 AND salary > 40000
-- 		OR			Any condition true	city = 'NY' OR city = 'LA'
-- 		NOT			Negates a condition	NOT (age < 18)




-- ********* ********* 🧠 4. Special Operators

-- 		EXISTS			Returns true if subquery has rows	WHERE EXISTS (SELECT 1 FROM ...)
-- 		ANY / SOME		Compare to any value in subquery	salary > ANY (SELECT ...)
-- 		ALL				Compare to all values in subquery	salary > ALL (SELECT ...)




-- ******** ******** ******** ******** PROBLEMS ******** ******** ******** ********
-- 🟢 SIMPLE (Level 1): SQL Operators Basics
-- 1. Retrieve all employees with a salary greater than 30000.
SELECT *
FROM EMPLOYEES 
WHERE SALARY > 30000;



-- 2. Get orders where the order total is not equal to 0.
SELECT *
FROM PRODUCTS 
WHERE PRICE <> 0;


-- 3. Find customers where the first name is equal to 'Yash'.
SELECT *
FROM CUSTOMERS
WHERE CUSTOMER_NAME LIKE 'YASH';		-- NOT CASE SENSITIVE


-- 4. Display orders that were not placed in the year 2023.
SELECT *
FROM ORDERS
WHERE YEAR(ORDER_DATE) != 2023;


-- 5. Find employees who earn less than their manager
SELECT *
FROM EMPLOYEES E
join employees M
ON E.manager_id= M.employee_id
WHERE E.SALARY > M.SALARY;
-- 6. Calculate and display price after tax (price * 1.18) for each product.
SELECT * , PRICE * 1.18 AS PRICE_AFT_TXT
FROM PRODUCTS;



-- ********* ********* 🟡 INTERMEDIATE (Level 2): Compound and Range Operators ********* ********* 
-- 1. Find products where the price is BETWEEN 50 AND 200.
SELECT *
FROM PRODUCTS
WHERE PRICE between 50 AND 200;


-- 2. List employees whose names start with 'A' 
SELECT *
FROM employees
WHERE employee_name LIKE 'A%';


-- 3. Get orders that have a NULL value in the order_date column.
SELECT *
FROM orders
WHERE order_date IS null;


-- 4. Retrieve customers who are not from 'DELLAS' OR have spent more than $500.
SELECT * 
FROM CUSTOMERS C
JOIN ORDERS o
ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE C.CITY <> 'DALLAS' AND O.TOTAL_AMOUNT >= 300;



-- 5. Get all products where name contains the word 'phone' using LIKE.
SELECT *
FROM PRODUCTS
WHERE PRODUCT_NAME LIKE '%phone%';


-- 6. Show products whose product_id is NOT IN (2, 3, 5).
SELECT *
FROM PRODUCTS
WHERE PRODUCT_ID NOT IN (2,3,5);

-- 7. Show records from a table where quantity * price > 1000 (use arithmetic operators in WHERE).
SELECT *
FROM PRODUCTS P
JOIN ORDER_ITEMS OI
ON P.PRODUCT_ID = OI.PRODUCT_ID
WHERE (OI.QUANTITY * P.PRICE) > 1000;



-- *********** *********** 🔴 ADVANCED (Level 3): Advanced Logical & Conditional Operators *********** ***********
-- 1. List all employees who do not belong to any department using LEFT JOIN and IS NULL.
SELECT *
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.DEPARTMENT_ID IS NULL;


-- 2. Find all employees whose salary is greater than the average salary using a subquery and >.
SELECT * 
FROM employees
WHERE SALARY > ( 	SELECT AVG(salary)
					FROM EMPLOYEES);


-- 3. Get customers who have placed at least one order using EXISTS.
SELECT *
FROM CUSTOMERS C
WHERE EXISTS (
    SELECT 1
    FROM ORDERS O
    WHERE O.CUSTOMER_ID = C.CUSTOMER_ID
);
       
       

-- Retrieve employees who earn more than any employee in department 10 using > ANY.
SELECT *
FROM employees E
WHERE SALARY > ANY (
    SELECT SALARY
    FROM employees
    WHERE department_id = 2
);


-- List employees who earn more than all employees in department 2 using > ALL.
SELECT *
FROM employees e
WHERE e.salary > ALL (
    SELECT salary
    FROM employees
    WHERE department_id = 2
)
ORDER BY e.department_id;


-- Get products where the price is not between the minimum and maximum price of the category using NOT BETWEEN with subqueries.
SELECT *
FROM products p
WHERE p.price NOT BETWEEN (
    SELECT MIN(price)
    FROM products
    WHERE category = p.category
) AND (
    SELECT MAX(price)
    FROM products
    WHERE category = p.category
);


-- List all orders where the customer has placed more than 2 orders using HAVING with COUNT.
select *
from orders 
where customer_id in (	select customer_id
						from orders o
                        group by customer_id
                        having count(*) > 2);


-- Use NOT EXISTS to find products that have never been ordered.
SELECT *
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.product_id = p.product_id
);

                                
-- Find employees who have the same salary as someone else using a correlated subquery.
SELECT *
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employees ee
    WHERE ee.salary = e.salary
      AND ee.employee_id != e.employee_id
);

-- Another approach
SELECT *
FROM employees e
WHERE salary IN (
    SELECT salary
    FROM employees
    GROUP BY salary
    HAVING COUNT(*) > 1
);