-- Question 1:
-- Who are the top 10 customers by total amount spent?
-- customer_unique_id is used to consolidate multiple orders
-- belonging to the same actual customer.

-- Q1 Query & Result

SELECT
    c.customer_unique_id,
    ROUND(SUM(op.payment_value), 2) AS total_spent
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_payments AS op
    ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;