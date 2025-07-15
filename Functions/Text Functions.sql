use problem_set;

-- ***************** ***************** ***************** Basic Text Functions ***************** ***************** *****************

-- ********** ***** Cases in SQL ***** ********** 
select Upper(first_name) from textf;
select Lower(first_name) from textf;



-- ********** ***** Text Extraction in SQL ***** ********** 
select left(first_name, 1) from textf;
select right(first_name,1) from textf;
select substr(first_name, 3,5) from textf;			-- Extract text from 3rd to 5th position.		-- SELECT MID ('database', 5, 3);			-- does not exist in MySQL
select substr(first_name, 1) from textf;			-- If we does not specify ending index it will take last index
select substring(first_name, 1,3) from textf;		-- Same as above




-- ********** ***** Text Manipulation in SQL ***** ********** 
select replace(first_name,'a','SS') from textf;				-- a replaced with SS
select group_concat(first_name) from textf;					-- concat all values from column - column context
select concat(first_name, " ", last_name) from textf;		-- concat two or more texts
select concat_ws('-', first_name, last_name) from textf;  	-- In SQL, CONCAT_WS stands for Concatenate With Separator. Combines strings together using a specified separator between them. -- Key Notes --> NULL values are ignored. CONCAT_WS is supported in MySQL, SQL Server 2017+
select insert(first_name,1,0,'inserted ') from textf;		-- Syntax - ( string, position on insert, length to insert (remove chars this length), new String)	
SELECT REPLACE ('banana', 'a', '@'); 						-- Replace all occurances in string.
SELECT REVERSE('abc'); 	
SELECT CONCAT ('A', SPACE (5), 'B');		 -- Output: A     B



-- ********** ***** Text Cleaning in SQL ***** ********** 
select trim(first_name) from textf;
select ltrim(first_name) from textf;
select rtrim(first_name) from textf;



-- ********** ***** Text Info in SQL ***** ********** 
select length(first_name) from textf;
select position('o' in first_name) from textf;
select instr(first_name, 'sh') from textf;				-- Return position of substring in string
select locate('o',first_name,1) from textf;				-- Same as instr but with position.		SELECT LOCATE ('e', 'cheese', 2);		 	-- Output: 3
select field('Roo',First_name) from textf;				-- position in list otherwise 0
select find_in_set('Roo',First_name) from textf;		-- position in list otherwise 0 -- Same as field
SELECT LPAD('7', 4, '0'); 								-- Put 7 in 4 th position covers before letters with 0
select lpad(first_name,8,'$') from textf;				-- Here make length of each to 8 covers before with $
SELECT STRCMP ('abc', 'abd');			 				-- Output: -1	-- 0 - Equal, 1 - first>second, -1 - first< second	"ASCII Compare"




-- ********** ***** Text Non Important in SQL ***** ********** 
select ascii(first_name) from textf;		-- give ascii value of first character
select char_length("Yash");					-- 4 - datatype if text here
select charset(first_name) from textf;		-- Give name of charset used.
select field('B', 'Y','b','B') from textf;	-- case insensitive
select find_in_set() from textf; -- tobe
SELECT REPEAT ('Hi', 3); 


-- Sample table for practice
/*
create table TextF(
id int,
first_name varchar(150),
last_name varchar(150),
department varchar(150)
);

insert into TextF
values (1, "Yash","Maha","IT"),
		(2, "Roo","Sharma","Comp"),
		(3, "Alpha","Bita","FinTech");
*/