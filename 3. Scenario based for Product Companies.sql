---Scenario based Interviews Question for Product companies---
create table entries 
( 
	name varchar(20),
	address varchar(20),
	email varchar(20),
	floor int,
	resources varchar(10)
);

insert into entries values 
('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')

select * from entries;
--write a query to fetch name, total_visits, most_visited_floor and resources_used.
select name, 
string_agg(resources, ',') as resources_used
from entries
group by name;


with distinct_resources as
	(select distinct name, resources
	from entries),
	agg_resources as
	(select name, 
	string_agg(resources, ', ') as used_resources
	from distinct_resources
	group by name),
	total_visits as
	(select name,
	count(1) as total_visits
	from entries
	group by name),
	floor_visit as
	(select name, floor,
	count(1) as visits,
	rank() over(partition by name order by count(1) desc) as rn
	from entries
	group by name, floor)
select f.name, 
f.visits as total_visits,
f.floor as most_visited,
a.used_resources
from floor_visit f
inner join total_visits t on f.name = t.name
inner join agg_resources a on a.name = f.name
where rn = 1;
