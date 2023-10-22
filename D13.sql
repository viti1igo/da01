--Q1--
WITH chị_tôi_say_vl AS (
SELECT company_id, title, description, COUNT(job_id) AS job_count
FROM job_listings
GROUP BY  company_id, title, description)

SELECT COUNT(company_id) AS duplicate_companies
FROM chị_tôi_say_vl
WHERE job_count > 1
--Q2--
WITH cte AS( 
SELECT category, product, SUM(spend) AS total_spend,
      RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) AS ranking
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date) = 2022
GROUP BY category, product)

SELECT category, product, total_spend 
FROM cte 
WHERE ranking <= 2
--Q3--
WITH cte AS (
SELECT policy_holder_id, COUNT(case_id) AS case_count
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(case_id) > 3)

SELECT COUNT(policy_holder_id) AS member_count
FROM cte
--Q4--
SELECT DISTINCT p.page_id
FROM pages p 
LEFT JOIN page_likes l ON p.page_id = l.page_id
WHERE liked_date IS NULL
ORDER BY page_id
--Q5--
WITH cte_1 AS (
SELECT 
  user_id, 
  EXTRACT(MONTH FROM event_date) AS current_month 
FROM user_actions
WHERE EXTRACT(MONTH FROM event_date) = '07'
AND EXTRACT(YEAR FROM event_date) = '2022'),

cte_2 AS (
SELECT 
  user_id, 
  EXTRACT(MONTH FROM event_date) AS previous_month 
FROM user_actions
WHERE EXTRACT(MONTH FROM event_date) = '06'
AND EXTRACT(YEAR FROM event_date) = '2022')

SELECT current_month AS month, COUNT(DISTINCT c1.user_id)
FROM cte_1 c1
INNER JOIN cte_2 c2 ON c1.user_id = c2.user_id
GROUP BY current_month
--Q6--
SELECT 
  TO_CHAR(trans_date, 'YYYY-MM') AS month,
  country,
  COUNT(id) AS trans_count,
  SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
  SUM(amount) AS trans_total_amount,
  SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY TO_CHAR(trans_date, 'YYYY-MM'), country 
--Q7--
WITH cte AS (
    SELECT product_id, year, quantity, price,
    RANK() OVER(PARTITION BY product_id ORDER BY YEAR) AS year_ranking
    FROM Sales
)
SELECT 
  product_id,
  year AS first_year,
  quantity,
  price
FROM cte
WHERE year_ranking = 1
--Q8--
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (
    SELECT COUNT(*)
    FROM Product
)
--Q9--
SELECT e1.employee_id
FROM Employees e1
LEFT JOIN Employees e2 ON e1.manager_id = e2.employee_id
WHERE e2.employee_id IS NULL 
AND e1.manager_id IS NOT NULL
AND e1.salary < 30000
--Q10: Same as Q1--

--Q11--

--Q12--
