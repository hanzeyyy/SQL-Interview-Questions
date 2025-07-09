---Amazon Prime Subscription Rate SQL Logic | Amazon Music | Complex SQL 14---
create table users_14
(
	user_id integer,
	name varchar(20),
	join_date date
);

insert into users_14
values (1, 'Jon', CAST('2-14-20' AS date)), 
(2, 'Jane', CAST('2-14-20' AS date)), 
(3, 'Jill', CAST('2-15-20' AS date)), 
(4, 'Josh', CAST('2-15-20' AS date)), 
(5, 'Jean', CAST('2-16-20' AS date)), 
(6, 'Justin', CAST('2-17-20' AS date)),
(7, 'Jeremy', CAST('2-18-20' AS date));

create table events_14
(
	user_id integer,
	type varchar(10),
	access_date date
);

insert into events_14 values
(1, 'Pay', CAST('3-1-20' AS date)), 
(2, 'Music', CAST('3-2-20' AS date)), 
(2, 'P', CAST('3-12-20' AS date)),
(3, 'Music', CAST('3-15-20' AS date)), 
(4, 'Music', CAST('3-15-20' AS date)), 
(1, 'P', CAST('3-16-20' AS date)), 
(3, 'P', CAST('3-22-20' AS date));

select * from users_14;
select * from events_14;
--Prime subscription rate by product action
--Given the following two tables, return the fraction of users, rounded to two decimal places,
--who accessed Amazon music and upgraded to prime membership within the first 30 days of signing up. 
select * from users_14 
where user_id in (select user_id from events_14
				  where type = 'Music');
--we have users who use amazon music

select * from users_14 u
left join events_14 e on u.user_id = e.user_id and e.type = 'P'
where u.user_id in (select user_id from events_14
				  where type = 'Music');
--now, we have all the users who used amazon music and then paid for it

select count(distinct u.user_id) as total_users,
count(distinct case when datediff(day, u.join_date, e.access_date) <= 30 then u.user_id end) as no_of_days
from users_14 u
left join events_14 e on u.user_id = e.user_id and e.type = 'P'
where u.user_id in (select user_id from events_14
				  where type = 'Music');
--we got the desired output

select count(distinct u.user_id) as total_users,
count(distinct case when datediff(day, u.join_date, e.access_date) <= 30 then u.user_id end) as no_of_days,
1.0*count(distinct case when datediff(day, u.join_date, e.access_date) <= 30 then u.user_id end)/count(distinct u.user_id) * 100 as percentage
from users_14 u
left join events_14 e on u.user_id = e.user_id and e.type = 'P'
where u.user_id in (select user_id from events_14
				  where type = 'Music');
