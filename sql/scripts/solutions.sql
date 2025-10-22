----QUESTION 1----
SELECT COUNT(*)
FROM customers
WHERE EXTRACT(YEAR FROM join_date) = 2023;

----QUESTION 2----
SELECT 
  c.customer_id,
  c.full_name,
  SUM(o.total_amount) AS total_revenue
FROM customers AS c
JOIN orders AS o
ON c.customer_id=o.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_revenue DESC;

----QUESTION 3----
SELECT
  c.customer_id,
  c.full_name,
  SUM(o.total_amount) AS total_revenue,
  RANK() OVER(ORDER BY SUM(o.total_amount) DESC) rank
FROM customers AS c
JOIN orders AS o
ON c.customer_id=o.customer_id
GROUP BY c.customer_id,
  c.full_name
ORDER BY total_revenue DESC
LIMIT 5;

----QUESTION 4----
SELECT
  EXTRACT(YEAR FROM order_date) AS "year",
  TO_CHAR(order_date, 'Month') AS "month",
  SUM(total_amount) AS monthly_revenue 
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2023
GROUP BY EXTRACT(YEAR FROM order_date),
  TO_CHAR(order_date, 'Month'),
  EXTRACT(MONTH FROM order_date)
ORDER BY EXTRACT(MONTH FROM order_date);

----QUESTION 4----
SELECT
  EXTRACT(YEAR FROM order_date) AS "year",
  TO_CHAR(order_date, 'Month') AS "month",
  SUM(total_amount) AS monthly_revenue 
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2023
GROUP BY EXTRACT(YEAR FROM order_date),
  TO_CHAR(order_date, 'Month'),
  EXTRACT(MONTH FROM order_date)
ORDER BY EXTRACT(MONTH FROM order_date);

----QUESTION 5----
WITH A AS(
SELECT
  c.customer_id,
  full_name,
  order_date
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
)
SELECT
  customer_id,
  full_name,
  MAX(order_date) last_order_date
FROM A
WHERE order_date < '2023-12-31'::date - INTERVAL '60 days'
GROUP BY customer_id,
  full_name;

----QUESTION 6----
SELECT
  o.customer_id,
  c.full_name,
  ROUND(AVG(o.total_amount),2)AS aov
FROM orders o
JOIN customers AS c
ON o.customer_id=c.customer_id
GROUP BY o.customer_id,
  c.full_name;

----QUESTION 7----
SELECT
  o.customer_id,
  c.full_name,
  SUM(o.total_amount) AS total_revenue,
  DENSE_RANK() OVER(ORDER BY SUM(o.total_amount) DESC) AS spend_rank
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
GROUP BY o.customer_id,
  c.full_name;

----QUESTION 8----
SELECT
  o.customer_id,
  c.full_name,
  COUNT(o.order_id) AS order_count,
  MAX(o.order_date) AS first_order_date,
  MIN(o.order_date) AS last_order_date
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
JOIN order_items i
ON o.order_id=i.order_id
GROUP BY o.customer_id,
  c.full_name
HAVING COUNT(o.order_id) > 1;

----QUESTION 9----
SELECT 
  l.customer_id,
  full_name,
  SUM(points_earned) AS points_earned
FROM loyalty_points l
LEFT JOIN customers c
ON l.customer_id=c.customer_id
GROUP BY l.customer_id,
  full_name;

----QUESTION 10----
WITH A AS(
SELECT 
  CASE
    WHEN points_earned < 100 THEN 'Bronze'
    WHEN points_earned BETWEEN 100 AND 499 THEN 'Silver'
    WHEN points_earned >= 500 THEN 'Gold'
    ELSE NULL
    END AS tier,
  points_earned 
FROM loyalty_points
)
SELECT
  tier,
  COUNT(tier) tier_count,
  SUM(points_earned) total_points
FROM A
GROUP BY tier;

----QUESTION 11----
SELECT
  o.customer_id,
  full_name,
  SUM(total_amount) AS total_spend,
  SUM(points_earned) AS total_points
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
JOIN loyalty_points l
ON c.customer_id=l.customer_id
GROUP BY o.customer_id,
  full_name
HAVING SUM(total_amount) > 50000 AND
  SUM(points_earned) < 200;

----QUESTION 12----
WITH A AS(
SELECT
  c.customer_id,
  full_name,
  order_date,
  CASE
    WHEN points_earned < 100 THEN 'Bronze'
    WHEN points_earned BETWEEN 100 AND 499 THEN 'Silver'
    WHEN points_earned >= 500 THEN 'Gold'
    ELSE NULL
    END AS tier,
  points_earned 
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
JOIN loyalty_points l
ON c.customer_id=l.customer_id
)
SELECT
  customer_id,
  full_name,
  MAX(order_date) last_order_date,
  SUM(points_earned) total_points
FROM A
WHERE order_date < '2023-12-31'::date - INTERVAL '90 days' AND tier='Bronze'
GROUP BY customer_id,
  full_name;