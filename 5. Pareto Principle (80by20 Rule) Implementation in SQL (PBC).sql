---Pareto Principle (80/20 Rule) Implementation (PBC)---
/*
The pareto principle states that for many outcomes,	roughly 80% of consequences come from 20% of causes.
1. 80% of the productivity comes from 20% of the employees
2. 80% of the sales comes from 20% of the product
3. 80% of the decisions in a meeting are made in 20% of the time
*/

select * from orders;
--write a query to find 80% of the sales that comes from 20% of the product/services.
with product_wise_sales as	
	(select product_id,
	sum(sales) as product_sales
	from orders
	group by product_id),
	cal_sales as
	(select product_id,
	sum(product_sales) over (order by product_sales desc rows between unbounded preceding and 0 preceding) as running_sum,
	0.8*sum(product_sales) over () as total_sales
	from product_wise_sales)
select * from cal_sales
where running_sum <= total_sales;
