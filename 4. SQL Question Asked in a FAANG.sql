---SQL Question Asked in a FAANG---
--write a query to provide the date for nth occurance of sunday in future from given date
declare @today_date date;
declare @n int;
set @today_date = '2025-06-24';
set @n = 3;

select dateadd(week, @n-1, dateadd(day, 8 - datepart(weekday, @today_date), @today_date)) as next_3rd_sunday;
