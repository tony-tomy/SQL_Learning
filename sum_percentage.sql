-- Order table and its columns

SELECT order_day, order_id, product_id, quantity, price
	FROM public."order";

'''
SQL Code to find the percentage of amount spent on each order
'''
SELECT product_id, price * quantity as total,
CONCAT(ROUND(100 *(price * quantity)/SUM(price * quantity) OVER( PARTITION BY product_id)::FLOAT), '%') as percentage 
FROM public.order
ORDER BY product_id;

-- Convert percentage to Double and round to 2 precisions 

SELECT product_id, price * quantity as total,
CONCAT(ROUND((100 *(price * quantity)/SUM(price * quantity) OVER( PARTITION BY product_id)::NUMERIC),2), '%') as percentage 
FROM public.order
ORDER BY product_id;
