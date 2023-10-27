--Q1--
SELECT 
  EXTRACT(YEAR FROM transaction_date) AS year,
  product_id,
  spend AS curr_year_spend,
  LAG(spend) OVER (PARTITION BY product_id ORDER BY product_id, EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend,
  ROUND(
  (spend-LAG(spend) OVER (PARTITION BY product_id ORDER BY product_id, EXTRACT(YEAR FROM transaction_date)))
  /LAG(spend) OVER (PARTITION BY product_id ORDER BY product_id, EXTRACT(YEAR FROM transaction_date))*100
  , 2) AS yoy_rate
FROM user_transactions;
--Q2--
SELECT DISTINCT
  card_name,
  FIRST_VALUE(issued_amount) OVER(PARTITION BY card_name ORDER BY issue_year, issue_month)
  AS issued_amount
FROM monthly_cards_issued
ORDER BY issued_amount DESC
--Q3--
WITH cte AS(
SELECT 
  user_id,
  spend,
  transaction_date,
  ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS rank
FROM transactions)

SELECT user_id, spend, transaction_date
FROM cte 
WHERE rank = 3
--Q4--
WITH cte AS(
SELECT 
  *,
  first_value(transaction_date) OVER(PARTITION BY user_id ORDER BY transaction_date DESC) AS transaction_rank
FROM user_transactions)

SELECT
  transaction_date,
  user_id,
  COUNT(product_id) AS product_count
FROM cte
WHERE transaction_date = transaction_rank
GROUP BY transaction_date, user_id
--Q5--
SELECT    
  user_id,    
  tweet_date,   
  ROUND(AVG(tweet_count) OVER (
    PARTITION BY user_id     
    ORDER BY tweet_date     
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
  ,2) AS rolling_avg_3d
FROM tweets;
--Q6--
WITH payments AS (
  SELECT 
    merchant_id, 
    EXTRACT(EPOCH FROM transaction_timestamp - LAG(transaction_timestamp) OVER(
        PARTITION BY merchant_id, credit_card_id, amount 
        ORDER BY transaction_timestamp)
    )/60 AS minute_difference 
  FROM transactions) 

SELECT COUNT(merchant_id) AS payment_count
FROM payments 
WHERE minute_difference <= 10;
--Q7--
WITH cte AS
(SELECT 
  category, 
  product, 
  SUM(spend) AS total_spend,
  RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) AS cate_rank
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date) = '2022'
GROUP BY category, product)

SELECT category, product, total_spend
FROM cte
WHERE cate_rank <= 2
ORDER BY category
--Q8--
WITH cte AS 
(SELECT a.artist_name AS artist_name,
  DENSE_RANK() OVER(ORDER BY COUNT(s.song_id) DESC) AS artist_rank
FROM artists a  
JOIN songs s ON a.artist_id = s.artist_id
JOIN global_song_rank r ON s.song_id = r.song_id
WHERE r.rank <= 10
GROUP BY a.artist_name)

SELECT artist_name, artist_rank
FROM cte 
WHERE artist_rank <= 5
