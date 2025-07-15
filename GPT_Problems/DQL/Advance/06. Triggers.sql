🟢 SIMPLE (Level 1): Basic Trigger Concepts
Create a trigger that logs every insert into the employees table.

Write a trigger to automatically update a last_modified column on update in the products table.

Write a trigger to set the created_at timestamp on insert into the orders table.

Create a trigger that prevents inserting a product with price less than 0.

Write a trigger that converts all customer names to uppercase before insert.

Create a trigger to maintain an audit table for deletions from the customers table.

Write a trigger that ensures no two employees have the same email before insert.

Create a trigger that sets a default status of 'pending' for new orders if not provided.

Create a trigger that copies data into a backup table after a delete from products.

Write a trigger to automatically assign a default department ID for new employees.

Create a trigger that logs any update to the salary field in the employees table.

Write a trigger that prevents deleting rows from the departments table.

Create a trigger that calculates tax and inserts it into the tax_amount column before insert.

Write a trigger that appends “_archived” to a product name upon deletion.

Create a trigger that rounds prices to 2 decimal places before inserting into products.

🟡 INTERMEDIATE (Level 2): Triggers with Conditions and Logic
Write a trigger that prevents increasing salary by more than 20% in one update.

Create a trigger that archives a customer record into another table before deletion.

Write a trigger that increases product stock in inventory when a return is inserted into returns.

Create a trigger that updates the total_orders in customers table after each order insert.

Write a trigger that prevents updates to the admin account in the users table.

Create a trigger to ensure order total is correctly calculated from line items on insert.

Write a trigger that checks if an employee is assigned to an existing department.

Create a trigger that automatically inserts a welcome note into messages when a new user is added.

Write a trigger that prevents deletion of orders that are already shipped.

Create a trigger that records who modified an employee record using SESSION_USER.

Write a trigger to prevent inserting duplicate email addresses across multiple user roles.

Create a trigger that logs the difference between old and new salary during update.

Write a trigger to update the total number of employees in a department after insert/delete.

Create a trigger to enforce a soft delete by setting an is_deleted flag instead of hard delete.

Write a trigger that blocks insert into products if inventory count exceeds a limit.

🔴 ADVANCED (Level 3): Multi-table, INSTEAD OF, and Complex Logic
Create an INSTEAD OF INSERT trigger on a view to route data into multiple underlying tables.

Write a trigger that logs the full change history (before and after) of updates in employees.

Create a trigger that prevents a manager from being deleted if they have active subordinates.

Write a trigger that updates employee salary and recalculates department average salary.

Create a trigger that updates customer loyalty status based on total orders after each new order.

Write a trigger that copies both deleted and updated rows to a history table during update.

Create a trigger that prevents inserting orders for inactive customers.

Write a trigger that ensures account balances in a transfer remain consistent in two tables.

Create a trigger that runs only during business hours (e.g., between 9 AM and 5 PM).

Write a trigger that rolls back the transaction if the total inventory falls below safety level.

Create a trigger that updates multiple tables when a product is deleted (e.g., inventory and logs).

Write a trigger that enforces cross-table consistency between projects and tasks.

Create a trigger that synchronizes address updates between billing and shipping tables.

Write a trigger to validate complex business rules before inserting into a finance table.

Create an audit trigger that tracks who, when, and what was changed for each update.

