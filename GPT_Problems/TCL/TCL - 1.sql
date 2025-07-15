
-- ******************************* TCL Commands in SQL ******************************* 
-- TCL statements manage changes made by DML (Data Manipulation Language) operations like INSERT, UPDATE, and DELETE. 
-- They help ensure data integrity in multi-step operations.

-- The main TCL commands are:
/*START TRANSACTION / BEGIN
COMMIT
ROLLBACK
SAVEPOINT
RELEASE SAVEPOINT
SET TRANSACTION
*/




-- 1. START TRANSACTION / BEGIN - - - - > Begins a new transaction. -- START TRANSACTION; -- or  BEGIN;
BEGIN;
UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;




-- 2. COMMIT
-- -- -- -- > Saves all changes made in the current transaction.
BEGIN;

INSERT INTO employees VALUES (112,'Alice',3, 50000,'2025-12-12',3);
UPDATE employees SET salary = 55000 WHERE employee_name = 'YASH M';

COMMIT;

select * from employees;





-- 3. ROLLBACK
-- -- -- -- > Undoes all changes made in the current transaction.
BEGIN;

UPDATE employees SET salary = salary + 1000 where employee_id = 112;

-- Oops! Something went wrong
ROLLBACK;





-- 4. SAVEPOINT
-- -- -- -- > Sets a point within a transaction to which you can roll back.

START TRANSACTION;

UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
SAVEPOINT deduct_done;

UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;

-- If something goes wrong
ROLLBACK TO deduct_done;

-- If everything is okay
COMMIT;




-- 5. RELEASE SAVEPOINT
-- -- -- -- > Deletes a savepoint (optional, as committing/rolling back also releases it).
RELEASE SAVEPOINT deduct_done;






-- 6. SET TRANSACTION
-- -- -- -- > Sets the properties for the current transaction (e.g., isolation level).
-- The SET TRANSACTION statement is used to configure properties of a database tran-- saction before it starts. 
-- Most commonly, it is used to set the isolation level, which controls how data visibility is handled between concurrent transactions.

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;







-- TCL Concepts Recap: 
/*
START TRANSACTION / BEGIN	Start a transaction
COMMIT	Save changes
ROLLBACK	Undo changes
SAVEPOINT	Create a rollback point
ROLLBACK TO	Roll back to a specific savepoint
RELEASE SAVEPOINT	Remove a savepoint
SET TRANSACTION	Define isolation level or other settings
*/




