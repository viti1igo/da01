--Q1--
SELECT n.CONTINENT, FLOOR(AVG(c.POPULATION))
FROM CITY c
INNER JOIN COUNTRY n ON c.COUNTRYCODE = n.CODE
GROUP BY n.continent
--Q2--
SELECT
  ROUND(CAST(SUM(CASE WHEN t.signup_action = 'Confirmed' THEN 1 ELSE 0 END) AS DECIMAL)/COUNT(DISTINCT e.email_id),2) AS activation_rate
FROM emails e
LEFT JOIN texts t ON e.email_id = t.email_id
--Q3--
WITH cte AS (SELECT age_bucket, 
  (CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END) AS s,
  (CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END) AS o
FROM activities ac
JOIN age_breakdown ab ON ac.user_id = ab.user_id)

SELECT age_bucket, 
ROUND(SUM(s)/SUM(s+o)*100, 2) AS send_perc, 
ROUND(SUM(o)/SUM(s+o)*100, 2) AS open_perc
FROM cte
GROUP BY age_bucket
--Q4--
SELECT c.customer_id
FROM customer_contracts c 
JOIN products p ON c.product_id = p.product_id
WHERE p.product_category IN ('Analytics','Containers','Compute')
AND p.product_name LIKE 'Azure%'
GROUP BY c.customer_id
HAVING COUNT(product_category) = 3
--Q5--
SELECT e1.employee_id, e1.name, COUNT(e2.reports_to) AS reports_count, ROUND(AVG(e2.age)) AS average_age
FROM Employees e1
LEFT JOIN Employees e2 ON e1.employee_id = e2.reports_to 
GROUP BY e1.employee_id, e1.name
HAVING COUNT(e2.reports_to) > 0
ORDER BY employee_id
--Q6--
SELECT p.product_name, SUM(o.unit) AS unit
FROM products p
JOIN Orders o ON p.product_id = o.product_id
WHERE (order_date BETWEEN '2020-02-01' AND '2020-02-29')
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100
--Q7--
SELECT DISTINCT p.page_id
FROM pages p 
LEFT JOIN page_likes l ON p.page_id = l.page_id
WHERE liked_date IS NULL
ORDER BY page_id
