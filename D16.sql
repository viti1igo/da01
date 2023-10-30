--Q1--
SELECT
ROUND(AVG(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) * 100,2) AS immediate_percentage
FROM Delivery
WHERE(customer_id, order_date) IN (
    SELECT customer_id,
           MIN(order_date) AS first_order
    FROM Delivery
    GROUP BY customer_id
)
--Q2--
WITH cte AS(
SELECT 
  player_id,
  event_date,
  MIN(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS first_log_in,
  (event_date - MIN(event_date) OVER(PARTITION BY player_id ORDER BY event_date)) AS returning_time
FROM Activity)

SELECT ROUND(CAST(SUM(CASE WHEN returning_time = '1' THEN 1 ELSE 0 END)AS decimal)/COUNT(DISTINCT player_id), 2)  AS fraction
FROM cte
--Q3--
SLE id, 
COALESCE(
    CASE 
    WHEN id%2=0 THEN LAG(student) OVER() 
    ELSE LEAD(student) OVER()
    END, student) AS student
FROM seat
--Q4--
WITH cte AS
(SELECT 
  visited_on,
  SUM(amount) AS amount
FROM Customer 
GROUP BY visited_on),

cte2 AS(
SELECT 
  visited_on,
  SUM(amount) OVER(ORDER BY visited_on ROWS 6 PRECEDING) AS seven_day_amount,
  MIN(visited_on) OVER() AS min_date
FROM cte)

SELECT 
  visited_on, 
  seven_day_amount AS amount,
  ROUND(seven_day_amount/7,2) AS average_amount
FROM cte2
WHERE visited_on - min_date >= 6
