Top Percentile Fraud 
--------------------

url : https://www.youtube.com/watch?v=XBE09l-UYTE

-- use NTILE() function to find the percentile

SELECT 	policy_num,
		state,
		claim_cost,
		fraud_score
FROM (
	  SELECT 	*,
				NTILE(100) OVER (PARTITION BY state 
							ORDER BY fraud_score DESC) as percentile
	  FROM fraud_score) a
WHERE percentile <= 5
