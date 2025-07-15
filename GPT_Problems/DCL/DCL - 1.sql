✅ DCL Command Examples in MySQL (All Types)
🔹 1. GRANT Privileges to a User
✅ Grant All Privileges on a Database
sql
Copy
Edit
GRANT ALL PRIVILEGES ON company_db.* TO 'john'@'localhost';
✅ Grant Specific Privileges on a Table
sql
Copy
Edit
GRANT SELECT, INSERT, UPDATE ON company_db.employees TO 'john'@'localhost';
✅ Grant Privileges with Grant Option
Allows the user to grant the same privileges to others.

sql
Copy
Edit
GRANT SELECT ON company_db.* TO 'jane'@'localhost' WITH GRANT OPTION;
🔹 2. REVOKE Privileges from a User
❌ Revoke Specific Privileges
sql
Copy
Edit
REVOKE SELECT, INSERT ON company_db.employees FROM 'john'@'localhost';
❌ Revoke All Privileges
sql
Copy
Edit
REVOKE ALL PRIVILEGES ON company_db.* FROM 'john'@'localhost';
🔹 3. SHOW GRANTS
Displays the privileges assigned to a user.

sql
Copy
Edit
SHOW GRANTS FOR 'john'@'localhost';
🔹 4. FLUSH PRIVILEGES
Reloads the privileges from the grant tables in the mysql database.

sql
Copy
Edit
FLUSH PRIVILEGES;
🔹 5. Create User (Often paired with DCL)
sql
Copy
Edit
CREATE USER 'john'@'localhost' IDENTIFIED BY 'secure_password';
🔹 6. Drop User
sql
Copy
Edit
DROP USER 'john'@'localhost';
🔐 Common Privileges in MySQL:
Privilege	Description
SELECT	Read data
INSERT	Insert data
UPDATE	Update existing data
DELETE	Remove data
CREATE	Create databases and tables
DROP	Drop databases and tables
GRANT OPTION	Give granted privileges to others
ALTER	Modify table structure
INDEX	Create or drop indexes
EXECUTE	Run stored procedures and functions

Would you like a full script that creates a user and manages their privileges step by step?




