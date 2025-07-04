---Market Analysis 2---
create table users_9 
(
	user_id int,
	join_date date,
	favorite_brand varchar(50)
);

insert into users_9 values (1,'2019-01-01','Lenovo'), (2,'2019-02-09','Samsung'),
(3,'2019-01-19','LG'), (4,'2019-05-21','HP');

 create table orders_9 
(
	order_id int,
	order_date date,
	item_id int,
	buyer_id int,
	seller_id int 
);

insert into orders_9 values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),
(3,'2019-08-03',3,2,3), (4,'2019-08-04',1,4,2),
(5,'2019-08-04',1,3,4), (6,'2019-08-05',2,2,4);

 create table items_9
(
	item_id int,
	item_brand varchar(50)
);

insert into items_9 values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

select * from users_9;
select * from orders_9;
select * from items_9;
/*
write a query to find for each seller, whether the brand of the second item (by date) they sold their favourite
they sold their favourite brand.
If a seller sold less than two items, report the answer for that sell as NO
output:
seller_id	2nd_item_fav_brand
1			yes/no
2			yes/no
*/
with rank_orders as
	(select *,
	rank() over(partition by seller_id order by order_date asc) as rk
	from orders_9)
select u.user_id as seller_id, ro.*, i.item_brand, u.favorite_brand,
case when i.item_brand = u.favorite_brand then 'Yes' else 'No' end as item_fav_brand 
from users_9 u
left join rank_orders ro on ro.seller_id =u.user_id and rk = 2
left join items_9 i on i.item_id = ro.item_id;
