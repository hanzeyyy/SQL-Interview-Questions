---SQL Question Asked in a FAANG---
--write a query to provide the date for nth occurance of sunday in future from given date
--sunday -> 1
--monday -> 2
--tuesday -> 3
--wednesday -> 4
--thursday -> 5
--friday -> 6
--saturday -> 7
declare @today_date date;
declare @n int;
set @today_date = '2025-06-25';
set @n = 3;

select dateadd(day, 11 - datepart(weekday, @today_date), @today_date) as upcoming_wednesday;

--we want to see wednesday after 3 weeks
declare @today_date date;
declare @n int;
set @today_date = '2025-06-25';
set @n = 3;

select dateadd(week, @n-1, dateadd(day, 11 - datepart(weekday, @today_date), @today_date)) as upcoming_3rd_wednesday;

declare @today_date date;
declare @n int;
set @today_date = '2025-06-22';
set @n = 3;

select dateadd(week, @n-1, dateadd(day, 8 - datepart(weekday, @today_date), @today_date)) as upcoming_3rd_sunday;
