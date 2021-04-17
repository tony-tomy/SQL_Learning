-- New and Existing users

with new_user as (
	SELECT 	date_part('month' ,new_user_start_date) as month,
			count(distinct user_id) as new_user
	FROM
		(SELECT user_id,
			min(time_id) as new_user_start_date
			FROM fact_events
			GROUP BY user_id) sq
	GROUP BY month),
all_user as (
	SELECT 	date_part('month' ,new_user_start_date) as month,
			count(distinct user_id) as all_user_user
	FROM 	fact_events
	GROUP BY month)
SELECT 
	au.month,
	new_user/all_user::decimal as share_new_users,
	1- new_user/all_user::decimal as share_exising_users
FROM all_user au
JOIN new_user nu ON nu.month = au.month
