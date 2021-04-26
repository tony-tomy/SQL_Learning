-- Viewers Turned Streamers

-- url : https://www.youtube.com/watch?v=tNXliLTlrV8&list=WL&index=2

-- Steps
------------

-- First step is to identify the users that had their first session as viewers 
	-- Lets rank by session start time because that will give as correct ordering 
	-- we will return a table with user_id, session_type and rank
-- Filter by the first session and session_type as "viewer" 
-- Now we can count the session by user_id
-- Lastly order by number of sessions then by user_id ASC

SELECT user_id,
	count(*) as n_sessions
FROM twitch_sessions
WHERE user_id IN (
	SELECT user_id,
	FROM (
		SELECT user_id,
			session_type,
			rank() OVER (PARTITION BY user_id ORDER BY session_start) streams_order
		FROM twitch_sessions ) s1
	WHERE streams_order = 1
		AND session_type = 'viewer')
	AND session_type = 'streamer'
GROUP BY 1
ORDER BY n_sessions DESC, user_id ASC
