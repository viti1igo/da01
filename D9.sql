--Q1--
SELECT
SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
SUM(CASE WHEN device_type = 'tablet' OR device_type = 'phone' THEN 1 ELSE 0 END) AS tablet_views
FROM viewership
--Q2--
SELECT *
CASE WHEN x+y>z AND x+z>y AND y+z>x THEN 'Yes'
ELSE 'No'
END AS triangle
FROM Triangle
--Q3--
SELECT DISTINCT ROUND(
(SUM(CASE
    WHEN call_category = 'n/a' OR call_category IS NULL 
    THEN 1 
    ELSE 0 
    END)
    ) / COUNT(*) * 100, 1) AS call_percentage
SELECT 

FROM callers
--Q4--
SELECT name
FROM Customer c
WHERE referee_id <> 2 OR referee_id IS NULL
--Q5--
SELECT survived,
SUM(CASE WHEN pclass = 1 THEN 1 ELSE 0 END) AS first_class,
SUM(CASE WHEN pclass = 2 THEN 1 ELSE 0 END) AS second_class,
SUM(CASE WHEN pclass = 3 THEN 1 ELSE 0 END) AS third_class
FROM titanic
GROUP BY survived
