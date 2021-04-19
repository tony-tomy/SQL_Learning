-- Favourite Nationality

-- url : https://www.youtube.com/watch?v=IKw0lkmBHNI&list=WL

-- Steps 
-------------

-- filter reviews by guests ( from_type = 'guest')
-- find the max(review_score) by from_user
-- join the above query to the airbnb_reviews and grab the host_id that received the max(review_score)
-- join above table to the airbnb_host and grab the nationality
-- output the user_id and nationality of the host 

SELECT 
	distinct guest_id,
	nationality as fav_nationality
FROM (
	SELECT 
		from_user as guest_id,
		max(review_score) as max_score_given
	FROM airbnb_reviews
	WHERE from_type = 'guest'
	GROUP BY guest_id ) ms
INNER JOIN (
	SELECT *
	FROM airbnb_reviews
	WHERE from_type = 'guest'
	) ar
	ON ms.guest_id = ar.guest_id AND ms.max_score_given = ar.review_score
INNER JOIN airbnb_host ah 
	ON ah.host_id = ar.to_user
ORDER BY guest_id
