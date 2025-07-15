



-- ********** ********** Formating Numbers ********** ********** 
select abs(-25);			-- Give absolute value means real value without any sign
select round(12.25, 1);		-- Round value to specified decimal. *** General approach means **0.4 - down **0.5 above - up ***
select ceil(12.25);			-- Round up
select floor(12.99);		-- Round Down



-- ********** ********** Aggregation ********** ********** 
select sum(total_amount) from orders;
select avg(total_amount) from orders;
select min(total_amount) from orders;
select max(total_amount) from orders;
select count(*) from orders;
				-- Imp Aggregations
                


-- ********** ********** Row Context ********** ********** 
select greatest(12,15,17,19);					-- *** max - column context *** greatest - row context
select least(12,15,17,19);						-- *** min - column context *** lowest - row context
select least(price, stock) from products;		-- Compare values from two columns and give lowest values. -- Row Context
select greatest(price, stock) from products;	-- Compare values from two columns and give highest values. -- Row Context



-- ********** ********** Basic Math ********** ********** 
select mod(15,4);								-- Give remainder
select pow(3,2);								-- Give Power of number
select sign(-25);								-- Give Sign of number		-- Output "-1"
select sqrt(25);								-- give squre root of number
select rand();									-- Give random value between 0 to 1
		
