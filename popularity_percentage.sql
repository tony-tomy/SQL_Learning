Popularity Percentage
---------------------

url : - https://www.youtube.com/watch?v=_gy1o9UH2dQ&list=WL&index=26&t=2s

Steps:-
--------

-- Total number of users on the platform : UNION DISTINCT user1 and user2
-- Total number of friends the user has : UNION user1 and user2, user and user1
-- (Total number of friends the user has) / (Total number of users on the platform)

SELECT user,
	(count(*)/max(tuu.all_user)::FLOAT)*100 as popularity_percentage   -- max function is added to complement the count function
FROM (
	SELECT 
		count(*) as all_user
	FROM (
			SELECT DISTINCT user1
			FROM facebook_friends
			UNION
			SELECT DISTINCT user2
			FROM facebook_friends) total_unique_users) tuu
JOIN (
	SELECT
		user1,user2
	FROM facebook_friends
	UNION
	SELECT
		user2 as user1, user1 as user2
	FROM facebook_friends) user_friends) ON 1 = 1  -- to match the total from first sub query with all the rows
GROUP BY user1
ORDER BY user1;
