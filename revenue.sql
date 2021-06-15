Find the restaurents with least 2% revenue
-------------------------------------------

url : https://www.youtube.com/watch?v=T1UhSuKqy3A

Steps:-
-------

--- Filter data to use only May 2020 using customer_placed_order_date_time column
--- Calculate revenue by sum(order_total) and group by restaurant_id
--- Find percentiles by spliting total_order into even buckets using NTILE(50) to give 2% buckets
--- Isolate the first NTILE using an outer query

WITH btm_rev as (
	SELECT restaurant_id,
		SUM(order_total) as total_order,
		ntile(50) OVER (
						ORDER BY SUM(order_total))
	FROM doordash_delivery
	WHERE customer_placed_order_date_time BETWEEN '2020-05-01' and '2020-05-31'
	GROUP BY restaurant_id)
SELECT restaurant_id, total_order
FROM btm_rev
WHERE ntile = 1
ORDER BY 2 DESC 
