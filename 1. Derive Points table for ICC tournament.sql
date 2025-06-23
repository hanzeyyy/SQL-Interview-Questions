-------Complex SQL Query 1------- 
---Derive Points table for ICC tournament---
create table icc_world_cup
(
	team_1 Varchar(20),
	team_2 Varchar(20),
	winner Varchar(20)
);

INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;

/*
points table
team name		matches played		matches won		matches lost
India			  2        					2		      		0
Sri Lanka		2			        		0		      		2
South Africa	1			      		0				      1
England			2				        	1		      		1
New zealand		1			      		1		      		0
Australia		2					        1      			 	1
*/

--using sub_query
select team_name,
count(1) as matches_played,
sum(win) as matches_won,
sum(loss) as matches_lost 
from
	(select team_1 as team_name,
	case when team_1 = winner then 1 else 0 end as win,
	case when team_1 != winner then 1 else 0 end as loss
	from icc_world_cup
	union all
	select team_2 as team_name,
	case when team_2 = winner then 1 else 0 end as win,
	case when team_2 != winner then 1 else 0 end as loss
	from icc_world_cup) A
group by team_name
order by matches_won desc;

--using CTE/with clause
with A as
	(select team_1 as team_name,
	case when team_1 = winner then 1 else 0 end as win,
	case when team_1 != winner then 1 else 0 end as loss
	from icc_world_cup
	union all
	select team_2 as team_name,
	case when team_2 = winner then 1 else 0 end as win,
	case when team_2 != winner then 1 else 0 end as loss
	from icc_world_cup)
select team_name,
count(1) as matches_played,
sum(win) as matches_won,
sum(loss) as matches_lost 
from A
group by team_name
order by matches_won;
