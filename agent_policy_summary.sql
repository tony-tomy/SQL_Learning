'''
agent

AgentID	NAME	AGE	GENDER
1	Sherwin	45	M
2	Addy	23	M
3	Fajar	43	M
4	Charolyn	21	F

policy

Agent_Id	Policy_Id	Policy_type	Client_Id	Policy_Start_date	Policy_Status	 Premium Amount 	Policy Term (yr)
1	1	Life	1	1/12/1988	Active	  100,000.00 	5
1	2	Life	1	12/10/1992	Closed	  250,000.00 	11
1	3	Life	1	2/14/1995	Active	  200,000.00 	5
2	4	Life	2	3/15/1998	Closed	  150,000.00 	5
2	5	Life	2	6/9/2001	Active	  75,000.00 	21
2	6	Life	3	1/17/1982	Active	  135,000.00 	5
3	7	Life	4	11/6/1985	Active	  50,000.00 	23
3	8	Life	4	5/22/1992	Closed	  85,000.00 	5
3	9	Life	4	7/16/2011	Active	  500,000.00 	5
3	10	Life	1	9/21/2002	Active	  70,000.00 	5

Expected Output

Agent Name	Agent Age	Gender	number_of_active_Policies	Total_active_policy_premium_amount	Total Agent Commissio
Sherwin	45	Male	2	300000	70000
Addy	23	Male	2	210000	37500
Fajar	43	Male	3	620000	65500
Charolyn	21	Female	0	0	0

total agent commission logic			
	exclude the oldest policy		
	if policy term <= 5 then premium * 10%		
	if policy term >5 and <=20 then premium * 20%		
	if policy term >20 then premium * 30%		
  
Commission is not provided for oldest policy

'''

---Answer

WITH cte_agent as (
	SELECT 	agentid, name, age, gender
	FROM agent),	
	cte_policy as (
	SELECT agent, count(1) as number_of_active_policy, sum(premium) as Total_active_policy_premium_amount
	FROM policy
	WHERE policy_status = 'Active'
	GROUP BY agent),	
	cte_policy_comm as(
	SELECT agent, 
	SUM(CASE WHEN policy_term <= 5 THEN premium * 0.1
		 WHEN policy_term <= 20 THEN premium * 0.2
		 ELSE premium * 0.3 END) as Total_Agent_Commission 
	FROM policy
	WHERE policy_start_date not in (SELECT min(policy_start_date) FROM policy GROUP BY agent)
	GROUP BY agent)	
	SELECT name, age, gender, number_of_active_policy, Total_active_policy_premium_amount, Total_Agent_Commission
	FROM cte_agent
	LEFT JOIN cte_policy ON cte_agent.agentid = cte_policy.agent
	LEFT JOIN cte_policy_comm ON cte_agent.agentid = cte_policy_comm.agent;
