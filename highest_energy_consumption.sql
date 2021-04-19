-- Highest Energy Consumption

-- Steps 
-------------
-- Create a single list of energy values from all the individual tables and use UNION ALL as the JOINS won't yield correct answers due too different no.of columns.
-- Sum the comsuptions by date 
-- Find the maximum consumption from the sums
-- Use the maximum conumption and Join it with Sum consumpton to find the date(s) with higest consumption (It will help in addressing the edge case of having multiple dates with maximum comsuption. 


WITH total_energy as (
	SELECT *
	FROM fb_eu_energy
	UNION ALL
	SELECT * 
	FROM fb_asia_energy
	UNION ALL
	SELECT *
	FROM fb_na_energy),
energy_by_date as (
	SELECT date,
		SUM(consumption) as total_energy
	FROM total_energy
	GROUP BY date
	ORDER BY date ASC),
max_energy as (
	SELECT MAX(total_energy) as max_energy
	FROM energy_by_date)
SELECT date, total_energy
FROM max_energy me
JOIN energy_by_date ebd
ON ebd.total_energy = me.max_energy
