/*
-- Query: with ro as (
select customer_id, count(order_id) as total_orders
from orders 
group by customer_id ) 

select * 
from customers c
join ro r 
on c.customer_id = r.customer_id
-- Date: 2025-04-27 13:38
*/
INSERT INTO `` (`customer_id`,`name`,`email`,`signup_date`,`customer_id`,`total_orders`) VALUES (1,'Customer_ALPHA','customer1@example.com','2022-01-01',1,2);
INSERT INTO `` (`customer_id`,`name`,`email`,`signup_date`,`customer_id`,`total_orders`) VALUES (2,'Customer_BRAVO','customer2@example.com','2022-01-02',2,2);
INSERT INTO `` (`customer_id`,`name`,`email`,`signup_date`,`customer_id`,`total_orders`) VALUES (3,'Customer_CHARLIE','customer3@example.com','2022-01-03',3,2);
INSERT INTO `` (`customer_id`,`name`,`email`,`signup_date`,`customer_id`,`total_orders`) VALUES (4,'Customer_DELTA','customer4@example.com','2022-01-04',4,2);
INSERT INTO `` (`customer_id`,`name`,`email`,`signup_date`,`customer_id`,`total_orders`) VALUES (5,'Customer_ECHO','customer5@example.com','2022-01-05',5,2);
INSERT INTO `` (`customer_id`,`name`,`email`,`signup_date`,`customer_id`,`total_orders`) VALUES (6,'Customer_FOXTROT','customer6@example.com','2022-01-06',6,2);
INSERT INTO `` (`customer_id`,`name`,`email`,`signup_date`,`customer_id`,`total_orders`) VALUES (7,'Customer_GOLF','customer7@example.com','2022-01-07',7,2);
INSERT INTO `` (`customer_id`,`name`,`email`,`signup_date`,`customer_id`,`total_orders`) VALUES (8,'Customer_HOTEL','customer8@example.com','2022-01-08',8,2);
INSERT INTO `` (`customer_id`,`name`,`email`,`signup_date`,`customer_id`,`total_orders`) VALUES (9,'Customer_INDIA','customer9@example.com','2022-01-09',9,2);
INSERT INTO `` (`customer_id`,`name`,`email`,`signup_date`,`customer_id`,`total_orders`) VALUES (10,'Customer_JULIET','customer10@example.com','2022-01-10',10,2);
