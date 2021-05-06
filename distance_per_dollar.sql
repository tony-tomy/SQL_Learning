Distance Per Dollar
-------------------

--  date | distance/cost - avg(distance/cost for month)


SELECT b.request_date,
		round(abs(b.dist_to_cost-b.avg_dist_to_cost)::DECIMAL, 2) as mean_deviation 
FROM
	(SELECT a.request_date,
			a.dist_to_cost,
			AVG(dist_to_cost) OVER (PARTITION BY a.request_month) AS avg_dist_to_cost
	FROM
		(SELECT *, 
				to_char(request_date::date, 'YYYY-MM') AS request_month,
				(distance_to_travel/monetary_cost) AS dist_to_cost
		FROM uber_request_logs) a 
	ORDER BY request_date ) b 
GROUP BY b.request_date
		 b.dist_to_cost
		 b.avg_dist_to_cost
ORDER BY b.request_date
