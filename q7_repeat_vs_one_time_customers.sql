-- Question 7:
-- How many customers are repeat vs one-time buyers?


-- ============================================================
-- Q7: MAIN QUERY — REPEAT VS ONE-TIME BUYERS
-- ============================================================
-- Count the number of orders placed by each actual customer,
-- then classify customers as One-Time or Repeat Buyers.
--
-- One-Time Buyer = 1 order | Repeat Buyer = more than 1 order
-- Q7 RESULT: Repeat vs One-Time Buyers

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)

SELECT
    CASE
        WHEN order_count > 1 THEN 'Repeat Buyer'
        ELSE 'One-Time Buyer'
    END AS buyer_type,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM customer_orders),
        2
    ) AS percentage_of_customers
FROM customer_orders
GROUP BY buyer_type
ORDER BY customer_count DESC;