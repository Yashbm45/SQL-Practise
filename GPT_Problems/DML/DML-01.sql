-- DML Commands
-- YOU CANNOT EXECUTE UPDATE OR ANY DML WITHOUT WHERE IN SAFEGUARD MODE IN MYSQL
use dml;

-- -- ************************************************INSERT STATEMENTS ******************************************************
-- 1. SINGLE INSERT ***************
insert into colleges ( id, name, address, typesof)
values ( 102, "DYPCOE","Pune","Med");

select * from colleges;

-- 2. Multiple value Insert ***************
insert into base1 (id, name, phone, collegeID)
values ( 4, "Yash","12346",102),
( 5, "Yasha","12347",102),
( 6, "Yashaa","12348",102);

select * from base1;

-- 3. Query Insert Insert ***************
insert into colleges
select * from col2;
	-- OR
insert into colleges
select id, name, address, typeof 
from col2 
where id = 105;

select * from colleges;


-- ************************************************UPDATE STATEMENTS ******************************************************
-- 1. SINGLE COLUMN UPDATE
update COL2 
SET NAME = "UPDATED"
WHERE ID = 104;

-- 2. MULTICOLUMN UPDATE
update COL2 
SET NAME = "UPDATED", TYPEOF = "UPDATED"
WHERE ID = 105;


-- 3. UPDATE WITH EXPRESSION
update COL2
SET ID = ID + 1
WHERE ID = 106;

-- 4. UPDATE WITH SUBQUERY
update COLLEGES
SET TYPESOF = (
SELECT TYPEOF 
FROM COL2
WHERE COLLEGES.ID = COL2.ID
)
WHERE ID = 105;

-- 5. UPDATE WITH JOIN
update COLLEGES C
JOIN COL2 C2 ON C.ID = C2.ID
SET C.NAME = C2.NAME
WHERE 1 = 1;


-- 6. CONDITIONAL UPDATE
UPDATE COL2
SET TYPEOF = CASE 
		WHEN TYPEOF = "UPDATED" THEN "CONDITIONAL"
        ELSE TYPEOF END
WHERE ID > 1;


-- 7. UPDATE WITH LIMIT
UPDATE COL2
SET ADDRESS = 'LIMIT'
order by ID
LIMIT 1;


-- 8. UPDATE ALL ROWS -- Not reccommended
-- Skip where condition -- OR -- give univeral true condition like 2 = 2, 2 < 1 
UPDATE TABLE_NAME
SET COL = "VALUE";

SELECT *  FROM COL2;



-- ************************************************DELETE STATEMENTS ******************************************************
-- 1. SIMPLE DELETE ROW
delete FROM COL2
WHERE ID = 107;

-- 2. MULTIPLE DELETE ROW
DELETE FROM COL2
WHERE ID < 102;

-- 3. DELETE WITH JOIN CLAUSE
DELETE C2 
FROM COL2 C2
JOIN COLLEGES C ON C2.ID = C.ID
WHERE C.ID = 105; 

-- 4. DELETE WITH SUBQUERY
DELETE C2
FROM COL2 C2
WHERE ID IN ( SELECT ID FROM COLLEGES WHERE ID > 111);

-- 5. DELETE WITH LIMIT 
DELETE FROM COL2
order by ID desc
LIMIT 1;


-- 6. DELETE WITH CTE
WITH TO_DEL AS (
SELECT ID FROM COLLEGES WHERE ID > 112
)
DELETE 
FROM COL2
WHERE ID in ( SELECT ID FROM TO_DEL);


-- 7. DELETE ALL ROWS - OR USE UNIVERSAL TRUE IN WHERE  -- -- NOT RECOMMENDED -- --
DELETE FROM COL2;

SELECT * FROM COL2;









-- **************************************************** TABLES FOR DML COMMANDS PRACTISE *************************************************** 
create table col2 (
id int primary key,
name varchar(50) not null,
address varchar(150),
typeof varchar (150)
);

insert into col2
values ( 105, "SB Patil","Ravet","Chem"),
( 106, "NIT","Mumbai","Petrolium");

select * from col2;