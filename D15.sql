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

--Q5--

--Q6--

--Q7--

--Q8--


WITH cte AS(
SELECT 
  *,
  first_value(transaction_date) OVER(PARTITION BY product_id ORDER BY transaction_date DESC) AS transaction_rank
FROM user_transactions)

SELECT
  transaction_rank,
  user_id,
  COUNT(product_id)
FROM cte
GROUP BY transaction_rank, user_id
