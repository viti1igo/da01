--QUESTION 1--
SELECT DISTINCT CITY
FROM STATION
WHERE ID % 2 = 0;

--QUESTION 2--
SELECT COUNT(CITY)-COUNT(DISTINCT CITY)
FROM STATION

--QUESTION 3--

--QUESTION 4--
SELECT ROUND(SUM(CAST(item_count AS DECIMAL)*order_occurrences)/SUM(order_occurrences), 1) AS mean
FROM items_per_order;

--QUESTION 5--
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(DISTINCT skill) = 3

--QUESTION 6--
SELECT user_id, MAX(DATE(post_date)) - MIN(DATE(post_date)) AS days_between
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021
GROUP BY user_id
HAVING COUNT(post_id) >= 2

--QUESTION 7--
SELECT card_name, MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY MAX(issued_amount) - MIN(issued_amount) DESC

--QUESTION 8--
SELECT manufacturer, COUNT(drug) AS drug_count, SUM(cogs-total_sales) AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY SUM(cogs-total_sales)  DESC

--QUESTION 9--
SELECT *
FROM Cinema
WHERE id%2 = 1 AND description <> "boring"
ORDER BY rating DESC 

--QUESTION 10--
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id
  
--QUESTION 11--
SELECT user_id, COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id
  
--QUESTION 12--
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5
