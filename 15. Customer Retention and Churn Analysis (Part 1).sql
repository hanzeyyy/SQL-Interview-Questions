---Customer Retention and Churn Analysis (Part 1/2) | SQL Interview Question Product Based Companies---
create table transactions_15
(
	order_id int,
	cust_id int,
	order_date date,
	amount int
);
insert into transactions_15 values 
(1,1,'2020-01-15',150), (2,1,'2020-02-10',150),
(3,2,'2020-01-16',150), (4,2,'2020-02-25',150),
(5,3,'2020-01-10',150), (6,3,'2020-02-20',150),
(7,4,'2020-01-20',150), (8,5,'2020-02-20',150);

select * from  transactions_15;
/*
Customer retention refers to the ability of a company or product to retain its customers over some specified period. 
High customer retention means customers of the product or business tend to return to, continue to buy or 
in some other way not defect to another product or business, or to non-use entirely. 
Company programs to retain customers: Zomato Pro , Cashbacks, Reward Programs etc.
Once these programs in place we need to build metrics to check if programs are working or not. 
That is where we will write SQL to drive customer retention count.  
*/
	select month(this_month.order_date) as month_date,
	count(distinct last_month.cust_id) as retained_cus
	from transactions_15 this_month
	left join transactions_15 last_month on this_month.cust_id = last_month.cust_id 
											and datediff(month, last_month.order_date, this_month.order_date) = 1
	group by month(this_month.order_date);
