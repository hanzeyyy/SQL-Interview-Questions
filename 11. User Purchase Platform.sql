create table spending_11 
(
	user_id int,
	spend_date date,
	platform varchar(10),
	amount int
);

insert into spending_11 values
(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);

select * from spending_11;
/* User purchase platform.
-- The table logs the spendings history of users that make purchases from an online shopping website which 
has a desktop  and a mobile application.
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only 
and both mobile and desktop together for each date.
*/
with all_spent as
	(select spend_date, user_id,
	max(platform) as platform,
	sum(amount) as amount
	from spending_11
	group by spend_date, user_id
	having count(distinct platform) = 1
	union all
	select spend_date, user_id,
	'Both' as platform,
	sum(amount) as amount
	from spending_11
	group by spend_date, user_id
	having count(distinct platform) = 2
	union all
	select distinct spend_date, null as user_id,
	'Both' as platform,
	0 as amount
	from spending_11
	group by spend_date, user_id
	)
select spend_date, platform, 
sum(amount) as total_amount,
count(distinct user_id) as total_users
from all_spent
group by spend_date, platform
order by spend_date, platform desc
;
