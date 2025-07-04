---Recursive CTE---
with cte_numbers as
	(select 1 as num --anchor query (runs only once)

	union all 
	
	select num+1 --recursive query
	from cte_numbers
	where num < 6 --filter to stop the recursion
	)
select num
from cte_numbers;

/*
anchor: 1
num=1 , 2
num=2 , 3
num=3 , 4
num=4 , 5
num=5 , 6
*/
create table sales_12 
(
	product_id int,
	period_start date,
	period_end date,
	average_daily_sales int
);

insert into sales_12 values (1,'2019-01-25','2019-02-28',100),
(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);

select * from sales_12;
--write a query to print product_id and total_amount for each year (report_year)
with recursive_cte as
	(select min(period_start) as dates,
	max(period_end) as max_date
	from sales_12 --anchor

	union all
	
	select dateadd(day, 1, dates) as dates,
	max_date
	from recursive_cte -- recursive cte
	where dates < max_date -- condition
	)
select product_id,
year(dates) as report_year,
sum(average_daily_sales) as total_amount
from recursive_cte
inner join sales_12 on dates between period_start and period_end
group by product_id, year(dates)
order by product_id, year(dates)
option (maxrecursion 1000);
