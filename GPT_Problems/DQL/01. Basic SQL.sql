use problem_set;

select * from customers;




--  ************** ************** ************** ✅ SQL Clause Definitions ************** ************** **************
-- 1. FROM + JOIN  --> Specifies the tables to retrieve data from and how to combine them.
-- → JOIN links rows from two or more tables based on related columns (e.g., foreign keys).

-- 2. WHERE --> Filters rows before grouping, based on specified conditions.
-- → Only rows that meet the condition (e.g., salary > 50000) continue to the next step.

-- 3. GROUP BY --> Groups rows that have the same values in specified columns.
-- → Used with aggregate functions like COUNT, SUM, AVG to summarize data.

-- 4. HAVING --> Filters groups after GROUP BY, based on aggregate conditions.
-- → Example: keep only groups with more than 5 employees.

-- 5. SELECT --> Chooses which columns or calculated values to show in the final result.
-- → Can include raw columns, aliases, or aggregated results.

-- 6. ORDER BY -->Sorts the final result set by one or more columns or expressions.
-- → Default is ascending (ASC), use DESC for descending order.

-- 7. LIMIT --> Restricts the number of rows returned in the final result.
-- → Useful for pagination or top-N queries.

-- 8. OFFSET --> OFFSET skips a specified number of rows before starting to return rows from a query result.
-- -> Often used with LIMIT for pagination.


-- *********** *********** *********** SQL QUERY Flow *********** *********** ***********
SELECT department, COUNT(*) AS emp_count
FROM employees
JOIN departments ON employees.dept_id = departments.id
WHERE employees.salary > 50000
GROUP BY department
HAVING COUNT(*) > 5
ORDER BY emp_count DESC
LIMIT 3 offset 1;

-- *********** *********** *********** SQL Execution  Flow *********** *********** ***********
-- FROM → JOIN → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT


-- *********** *********** *********** 🔍 What Happens Step-by-Step: *********** *********** ***********
-- FROM + JOIN: Combines employees and departments tables.
-- WHERE: 		Filters employees with salary > 50000.
-- GROUP BY: 	Groups remaining rows by department.
-- HAVING: 		Filters out groups with ≤ 5 employees.
-- SELECT: 		Picks department and count of employees.
-- ORDER BY: 	Sorts result by employee count descending.
-- LIMIT: 		Returns top 3 rows.
-- Offset : 	Excludes top 1 record

