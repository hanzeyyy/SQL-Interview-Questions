---Customer Retention and Churn Analysis (Part 2/2) | SQL Interview Question Product Based Companies---
select month(last_month.order_date) as month_date,
count(distinct last_month.cust_id) as churned_cus
from transactions_15 last_month
left join transactions_15 this_month on this_month.cust_id = last_month.cust_id 
										and datediff(month, last_month.order_date, this_month.order_date) = 1
where this_month.cust_id is null
group by month(last_month.order_date);
