SELECT COUNT(*) AS total_passengers
FROM airline;
SELECT
satisfaction,
COUNT(*) AS passenger_count
FROM airline
GROUP BY satisfaction;
SELECT
    satisfaction,
    COUNT(*) AS passenger_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM airline), 2) AS percentage
FROM airline
GROUP BY satisfaction;
SELECT
    "Class",
    satisfaction,
    COUNT(*) AS passenger_count
FROM airline
GROUP BY "Class", satisfaction
ORDER BY "Class", satisfaction;
SELECT
    "Class",
    satisfaction,
    COUNT(*) AS passenger_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM airline a2 WHERE a2."Class" = airline."Class"),
        2
    ) AS percentage
FROM airline
GROUP BY "Class", satisfaction
ORDER BY "Class", satisfaction;
SELECT
    "Type of Travel",
    satisfaction,
    COUNT(*) AS passenger_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM airline a2
         WHERE a2."Type of Travel" = airline."Type of Travel"),
        2
    ) AS percentage
FROM airline
GROUP BY "Type of Travel", satisfaction
ORDER BY "Type of Travel", satisfaction;
SELECT
    CASE
        WHEN Age < 18 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 30 THEN '18-30'
        WHEN Age BETWEEN 31 AND 45 THEN '31-45'
        WHEN Age BETWEEN 46 AND 65 THEN '46-65'
        ELSE '66+'
    END AS age_group,
    satisfaction,
    COUNT(*) AS passenger_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (
            PARTITION BY
            CASE
                WHEN Age < 18 THEN 'Under 18'
                WHEN Age BETWEEN 18 AND 30 THEN '18-30'
                WHEN Age BETWEEN 31 AND 45 THEN '46-65'
                WHEN Age BETWEEN 46 AND 65 THEN '46-65'
                ELSE '66+'
            END
        ),
        2
    ) AS percentage
FROM airline
GROUP BY age_group, satisfaction
ORDER BY
    CASE age_group
        WHEN 'Under 18' THEN 1
        WHEN '18-30' THEN 2
        WHEN '31-45' THEN 3
        WHEN '46-65' THEN 4
        WHEN '66+' THEN 5
    END,
    satisfaction;
SELECT
    CASE
        WHEN "Flight Distance" < 1000 THEN 'Short'
        WHEN "Flight Distance" < 2000 THEN 'Medium'
        WHEN "Flight Distance" < 3000 THEN 'Long'
        ELSE 'Very Long'
    END AS distance_group,
    COUNT(*) AS passenger_count,
    ROUND(
        SUM(CASE WHEN satisfaction = 'Neutral or Dissatisfied' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS dissatisfaction_percentage
FROM airline
GROUP BY distance_group
ORDER BY
    CASE distance_group
        WHEN 'Short' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Long' THEN 3
        WHEN 'Very Long' THEN 4
    END;
SELECT
    satisfaction,
    ROUND(AVG("Departure Delay in Minutes"), 2) AS avg_departure_delay,
    ROUND(AVG("Arrival Delay in Minutes"), 2) AS avg_arrival_delay
FROM airline
GROUP BY satisfaction;
	
