-- Given a table of purchase day by day. Calculate the month over month percentage change in revenue. 
-- Output should include date in (YYYY-MM) format and percentage rounded to 2 decimals.

-- The input table columns are 
-- id : int, created_at : object, value : int, purchase_id : int
-- Percentage change formula = (this month revenue - last month revenue)/ last month revenue * 100

-- Source : https://www.youtube.com/watch?v=QenwDm5oWdU

-- Answer

SELECT  to_char(created_at::date, 'YYYY-MM') as year_month,
        round((sum(value) - lag(sum(value),1) over (w) /
        lag(sum(value),1) over (w) * 100, 2) as revenue_diff
FROM sf_transactions
GROUP BY year_month
WINDOW w as (ORDER BY to_char(created_at::date, 'YYYY-MM'))
ORDER BY year_month ASC

