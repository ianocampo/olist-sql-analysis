-- Question 2:
-- What is the monthly revenue trend?

-- Q2 Query & Result
SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    ROUND(SUM(op.payment_value), 2) AS monthly_revenue
FROM orders AS o
JOIN order_payments AS op
    ON o.order_id = op.order_id
GROUP BY order_month
ORDER BY order_month;