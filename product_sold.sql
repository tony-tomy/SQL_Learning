SELECT order_day, order_id, product_id, quantity, price
	FROM public."order";
  
-- The prodcuts that sold on both days (2) with total sold count. 

SELECT product_id, price * quantity as total,
CONCAT(ROUND((100 *(price * quantity)/SUM(price * quantity) OVER( PARTITION BY product_id)::NUMERIC),2), '%') as percentage 
FROM public.order
ORDER BY product_id;
