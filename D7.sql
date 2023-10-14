--Q1--
SELECT Name
FROM STUDENTS
WHERE Marks > 75
ORDER BY RIGHT(Name, 3), ID
--Q2--
SELECT user_id,
CONCAT(UPPER(SUBSTRING(name, 1, 1)), LOWER(SUBSTRING(name, 2))) AS name
FROM Users
--Q3--
SELECT manufacturer, '$'||ROUND(SUM(total_sales/1000000), 0) || ' million' AS sales_mil
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY ROUND(SUM(total_sales/1000000), 0) DESC, manufacturer
--Q4--
SELECT EXTRACT(MONTH FROM submit_date) as mth,
product_id,
ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY EXTRACT(MONTH FROM submit_date), product_id
ORDER BY EXTRACT(MONTH FROM submit_date), product_id
--Q5--
SELECT sender_id, COUNT(message_id) AS count_messages
FROM messages
WHERE TO_CHAR(sent_date, 'mm-yyyy') = '08-2022'
GROUP BY sender_id
ORDER BY COUNT(message_id) DESC
LIMIT 2
--Q6--
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15
--Q7--
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date
--Q8--
SELECT COUNT(id) AS hired_emp
FROM employees
WHERE joining_date BETWEEN '2022-01-01' AND '2022-07-31'
--Q9--
SELECT COUNT(id) AS hired_emp
FROM employees
WHERE joining_date BETWEEN '2022-01-01' AND '2022-07-31'
--Q10--
SELECT SUBSTRING(title FROM POSITION(RIGHT(winery, 1) IN winery) + 2 FOR 4) AS year,  title --KHÓ VÃI--
FROM winemag_p2
WHERE country = 'Macedonia'
