create table tasks_10 
(
	date_value date,
	state varchar(10)
);

insert into tasks_10 values 
('2019-01-01','success'),('2019-01-02','success'),
('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success');

select * from tasks_10;

with all_dates as
	(select *,
	row_number() over (partition by state order by date_value) as row_num,
	dateadd(day, -1*row_number() over(partition by state order by date_value), date_value) as group_date
	from tasks_10)
select min(date_value) as start_date,
max(date_value) as end_date,
state
from all_dates
group by group_date, state
order by start_date asc;
