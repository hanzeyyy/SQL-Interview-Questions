---Recommendation System---
create table orders_13
(
	order_id int,
	customer_id int,
	product_id int,
);

insert into orders_13 VALUES 
(1, 1, 1), (1, 1, 2), (1, 1, 3), (2, 2, 1), 
(2, 2, 2), (2, 2, 4), (3, 1, 5);

create table products_13
(
	id int,
	name varchar(10)
);
insert into products_13 VALUES 
(1, 'A'), (2, 'B'), (3, 'C'),
(4, 'D'), (5, 'E');

select * from orders_13;
select * from products_13;
--recommendation based on - product pairs most commonly pruchased together
select o1.order_id, o1.product_id as p1, o2.product_id as p2 
from orders_13 o1
inner join orders_13 o2 on o1.order_id = o2.order_id
where o1.product_id = 1 and o1.product_id < o2.product_id;
--since there were duplicates, so we used o1.product_id < o2.product_id


select o1.product_id as p1, o2.product_id as p2,
count(*) as product_freq
from orders_13 o1
inner join orders_13 o2 on o1.order_id = o2.order_id
where o1.product_id < o2.product_id
group by o1.product_id, o2.product_id;
--we got the frequency

select pr1.name as p1, pr2.name as p2,
count(*) as product_freq
from orders_13 o1
inner join orders_13 o2 on o1.order_id = o2.order_id
inner join products_13 pr1 on pr1.id = o1.product_id
inner join products_13 pr2 on pr2.id = o2.product_id
where o1.product_id < o2.product_id
group by pr1.name, pr2.name;

--let's add p1 and p2
select pr1.name + ', ' + pr2.name as p2,
count(*) as product_freq
from orders_13 o1
inner join orders_13 o2 on o1.order_id = o2.order_id
inner join products_13 pr1 on pr1.id = o1.product_id
inner join products_13 pr2 on pr2.id = o2.product_id
where o1.product_id < o2.product_id
group by pr1.name, pr2.name;
