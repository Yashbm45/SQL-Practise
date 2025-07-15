
-- ********************* ********************* Date and Time Functions in MySQL ********************* *********************

-- ********** ********** ********** 1. current time and date ********** ********** **********
select curdate(); 				 -- Give todays date according to system in format YYYY-MM-DD.
select curtime(); 				 -- Give todays time according to system in format HR-Min-Sec.
select current_date(); 			 -- Give todays date according to system in format YYYY-MM-DD.
select current_time(); 			 -- Give todays time according to system in format HR-Min-Sec.
select current_timestamp(); 	 -- Give current timestamp according to system in format YYYY-MM-DD HR-Min-Sec.
select Now(); 					 -- Give current date and time.
-- NOT IN MYSQL SELECT SYSDATE ();				-- Similar to NOW (), but reflects the exact moment of function call, not query start time. Example: '2025-06-12 15:23:47'
-- Returns the current date and time.		Example: '2025-06-12 15:23:45'
SELECT CURRENT_TIMESTAMP (); 
SELECT LOCALTIME (); 
SELECT LOCALTIMESTAMP (); 


select last_day(now());
select localtime();				-- Give current local date and time
select localtimestamp();		-- Give current local date and time
select makedate(2025,160);		-- Give date by provided year and day of year
select maketime(12,12,12);		-- Give time by hour minute and second
select microsecond(now());
select monthname(now());

select period_add(now(),2);
select period_diff(now(), '2023-12-10');

select quarter(now());

select str_to_date('20251230');


select subdate(now(), interval 3 month);


-- ********** ********** ********** 2. Date calculations ********** ********** **********
select datediff('2023-01-22','2023-01-20'); -- 2 -- give difference between dates in days
 
-- ********** I.DATE CALCULATIONS IN INTERVAL
select DATE_ADD('2025-02-27', INTERVAL 5 DAY); 			-- Syntax - DATE_ADD(date, INTERVAL n unit) -- -- Adds interval to date
select ADDDATE('2025-05-22', INTERVAL 7 DAY);  			-- Synonyms for DATE_ADD 	ADDDATE('2025-05-22', INTERVAL 7 DAY)
SELECT ADDTIME('2025-06-11 10:30:00', '01:15:00');				-- Output: 2025-06-11 11:45:00
select DATE_SUB('2025-05-22', INTERVAL 1 MONTH); 		-- Syntax - DATE_SUB(date, INTERVAL n unit) -- -- Subtracts interval from date
select SUBDATE('2025-05-22', INTERVAL 7 DAY);			-- Synonyms for DATE_sub 	SUBDATE('2025-05-22', INTERVAL 7 DAY)
select PERIOD_ADD (202406, 2); 	-- returns 202408		-- select PERIOD_ADD (period, months) 	-- Adds months to a period (YYYYMM format).
select PERIOD_DIFF (202506, 202401); -- -- returns 5 	-- PERIOD_DIFF (period1, period2):Difference in months between two periods.


-- ********** II. Date Differences
SELECT DATEDIFF('2025-05-22', '2000-05-01'); -- → 21 			--  DATEDIFF(date1, date2) --	Returns difference in days	
SELECT TIMESTAMPDIFF(YEAR, '2000-01-01', '2025-01-01'); -- → 25 -- TIMESTAMPDIFF(unit, date1, date2)	Difference in specified units (SECOND, MINUTE, HOUR, DAY, MONTH, YEAR)
select SUBTIME('03:00:00', '01:30:00'); 						-- SUBTIME (time1, time2):  Subtracts one time from another.returns '01:30:00'




-- ********** ********** ********** 3. Extracting Parts of Dates ********** ********** **********
SELECT YEAR('2025-05-22'); 		-- → 2025 	-- YEAR(date)	Returns year	
select quarter(now());			-- → 2		-- QUATER(date)	Returns quater number
SELECT MONTH('2022-05-22'); 	-- → 05 	-- MONTH(date)	Returns month (1–12)	
SELECT DAY('2025-05-22');		-- → 22 	-- Returns day of month	
SELECT WEEK('2023-05-25');		-- → 21 	-- Returns week number of the year	
select HOUR('21:34:05');
select MINUTE('2023-05-25 21:34:05');
select SECOND('2023-05-25 21:34:05');	
-- Advance*****
select extract(year from '2023-05-25 21:34:05');  	-- EXTRACT(unit FROM date)	General extractor	EXTRACT(DAY FROM '2025-05-22')
select extract(week from '2023-05-25 21:34:05');	-- week of the year
select weekofyear(now());							-- week of year
select date(now());									-- Extract date from date and time expression

-- ********** ********** ********** 4. Formatting Dates ********** ********** **********
select DATE_FORMAT(NOW(), '%d-%m-%Y %h:%m:%s'); -- → 22-05-2025-- DATE_FORMAT(date, format_string)	Custom format	 -- "%Y" means full year 2023 "%y" means short year 23


-- ********** ********** ********** 5. Other Useful Functions ********** ********** **********
select last_day(now()); -- LAST_DAY(date)			-- Returns last day of the month
select str_to_date('22220314', '%Y-%M-%D');			-- STR_TO_DATE(str, format)	Parses a string into a date
select makedate(2023,144);  						-- MAKEDATE(year, dayofyear) 	Makes a date from year and day of year
select MAKETIME(09, 54, 55);						-- Returns a time value


-- ********** ********** ********** 6. Text Based extraction ********** ********** ********** 
select dayname(now());
select dayofweek(now());			-- Default sunday first day
select dayofmonth(now());			-- Give day of month
select dayofyear(now());			-- Give day of year

select week(now());					-- Give week of the year
select weekday(now());				-- Give day of week
select weekofyear(now());			-- Give week of the year

select monthname(now());			-- return month name
select from_days(455555);			-- return date from number




-- ********** ********** ********** IMP Concepts ********** ********** **********
-- ********** Week of the month ********** 
SELECT 
    now(),
    FLOOR((DAY(now()) - 1) / 7) + 1 AS week_of_month;

-- ********** Week according to Monday start ********** 
SELECT 
    order_date,
    WEEK(order_date, 3) - WEEK(DATE_SUB(order_date, INTERVAL DAY(order_date) - 1 DAY), 3) + 1 AS week_of_month
FROM orders;



select current_user(); 	-- Give current username

