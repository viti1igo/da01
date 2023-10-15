--Q1--

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
