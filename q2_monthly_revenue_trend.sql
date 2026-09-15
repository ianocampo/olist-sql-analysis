-- Question 2:
-- What is the monthly revenue trend across the dataset?

-- ============================================================
-- Q2: MAIN QUERY — MONTHLY REVENUE TREND
-- ============================================================
-- Group orders by purchase month and calculate total payments
-- collected in each month to show how revenue changes over time.
--
-- DATE_FORMAT converts each order timestamp into YYYY-MM
-- so revenue can be compared consistently by month.
-- Q2 RESULT: Monthly Revenue Trend

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    ROUND(SUM(op.payment_value), 2) AS monthly_revenue
FROM orders AS o
JOIN order_payments AS op
    ON o.order_id = op.order_id
GROUP BY order_month
ORDER BY order_month;