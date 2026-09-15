-- Question 3:
-- What is the month-over-month change in revenue?

-- Q3 Query & Result
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
        ROUND(SUM(op.payment_value), 2) AS monthly_revenue
    FROM orders AS o
    JOIN order_payments AS op
        ON o.order_id = op.order_id
    GROUP BY order_month
)

SELECT
    order_month,
    monthly_revenue,
    LAG(monthly_revenue) OVER (ORDER BY order_month) AS previous_month_revenue,
    ROUND(
        monthly_revenue
        - LAG(monthly_revenue) OVER (ORDER BY order_month),
        2
    ) AS revenue_change
FROM monthly_revenue
ORDER BY order_month;