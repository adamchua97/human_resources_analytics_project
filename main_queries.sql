-- CREATE A JOIN TABLE
SELECT 
	*
FROM
	absenteeism_at_work a
LEFT JOIN compensation c
	ON a.ID = c.ID
LEFT JOIN reasons r
	ON a.Reason_for_absence = r.Number
ORDER BY
	a.ID;


--- FIND THE HEALTHIEST FOR THE BONUS
-- (NON-SMOKERS & NON-DRINKERS & BMI<25 & absenteeism < average absenteeism)


SELECT
	*
FROM
	absenteeism_at_work
WHERE
	Social_drinker = 0
	AND Social_smoker = 0
	AND Body_mass_index < 25
	AND Absenteeism_time_in_hours < (
		SELECT
			AVG(Absenteeism_time_in_hours)
		FROM
			absenteeism_at_work)
ORDER BY
	ID;



-- COMPENSATION RATE INCREASE FOR NON-SMOKERS
-- PROGRAM BUDGET IS $983,221
-- 686 NON-SMOKERS * 2080 TOTAL WORK HOURS IN A YEAR = 1,426,880
-- 983,221 / 1,426,880 = 0.69 CENTS RATE INCREASE PER HOUR
-- 2080 TOTAL WORK HOURS IN A YEAR * 0.69 INCREASE PER HOUR = $1435.20 RATE INCREASE PER YEAR


SELECT
	COUNT(*) AS 'non-smokers'
FROM
	absenteeism_at_work
WHERE
	Social_smoker = 0;



-- OPTIMIZE QUERY

SELECT 
	a.ID,
	r.Reason,
	a.Body_mass_index,
	CASE
		WHEN a.Body_mass_index < 18.5 THEN 'Underweight'
		WHEN a.Body_mass_index BETWEEN 18.5 AND 25 THEN 'Healthy Weight'
		WHEN a.Body_mass_index BETWEEN 25 AND 30 THEN 'Overweight'
		WHEN a.Body_mass_index > 30 THEN 'Obese'
		ELSE 'Unknown'
	END AS BMI_Categeory,
	CASE
		WHEN a.Month_of_absence IN (12,1,2) THEN 'Winter'
		WHEN a.Month_of_absence IN (3,4,5) THEN 'Spring'
		WHEN a.Month_of_absence IN (6,7,8) THEN 'Summer'
		WHEN a.Month_of_absence IN (9,10,11) THEN 'Fall'
		ELSE 'Unknown'
	END AS Season_Names,
	a.Seasons,
	a.Month_of_absence,
	a.Day_of_the_week,
	CASE
		WHEN a.Day_of_the_week = 1 THEN 'Sun'
		WHEN a.Day_of_the_week = 2 THEN 'Mon'
		WHEN a.Day_of_the_week = 3 THEN 'Tue'
		WHEN a.Day_of_the_week = 4 THEN 'Wed'
		WHEN a.Day_of_the_week = 5 THEN 'Thu'
		WHEN a.Day_of_the_week = 6 THEN 'Fri'
		WHEN a.Day_of_the_week = 7 THEN 'Sat'
		ELSE 'Unknown'
	END AS Day_of_Week,
	a.Transportation_expense,
	CASE
		WHEN a.Education = 1 THEN 'HS Diploma'
		WHEN a.Education = 2 THEN 'Bachelors'
		WHEN a.Education = 3 THEN 'Masters'
		WHEN a.Education = 4 THEN 'PhD'
		ELSE 'Unknown'
	END AS Education_Level,
	a.Son AS 'Children',
	a.Social_drinker,
	a.Social_smoker,
	a.Pet,
	a.Disciplinary_failure,
	a.Age,
	a.Work_load_Average_day,
	a.Absenteeism_time_in_hours
FROM
	absenteeism_at_work a
LEFT JOIN compensation c
	ON a.ID = c.ID
LEFT JOIN reasons r
	ON a.Reason_for_absence = r.Number
ORDER BY
	a.ID;