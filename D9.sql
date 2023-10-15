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

--Q4--
SELECT name
FROM Customer c
WHERE referee_id <> 2 OR referee_id IS NULL
--Q5--
