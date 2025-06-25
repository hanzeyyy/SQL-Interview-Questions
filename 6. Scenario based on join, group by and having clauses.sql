---Scenario based on join, group by and having clauses---
select * from person;
select * from friend;
--write a query to find person_id, name, number of friends, sum of marks of a person
--who have friends with total score greater than 100.
with score_details as
	(select f.personid, sum(p.Score) as friend_score,
	count(f.friendid) as no_of_friends
	from friend f
	inner join person p on f.FriendID = p.PersonID
	group by f.PersonID
	having sum(p.score) > 100)
select s.*, p.name
from score_details s 
inner join person p on s.PersonID = p.PersonID;
