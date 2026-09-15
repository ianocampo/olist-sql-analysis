-- Question 6:
-- Segment customers into spend tiers (Low/Medium/High).


-- ============================================================
-- Q6A: QUERY 1 — MAIN CUSTOMER SPEND SEGMENTATION
-- ============================================================
-- Calculate total spend per customer and assign each customer
-- to a Low, Medium, or High spend tier.
--
-- Tier thresholds were selected after reviewing the customer
-- spend distribution shown in Query 2 below.
--
-- Low = below 100 | Medium = 100 to below 500 | High = 500 and above.
-- Q6A RESULT: Customer Spend Segmentation

WITH customer_spend AS (
    SELECT
        c.customer_unique_id,
        ROUND(SUM(op.payment_value), 2) AS total_spent
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_payments AS op
        ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id
)

SELECT
    customer_unique_id,
    total_spent,
    CASE
        WHEN total_spent < 100 THEN 'Low'
        WHEN total_spent < 500 THEN 'Medium'
        ELSE 'High'
    END AS spend_tier
FROM customer_spend
ORDER BY total_spent DESC;


-- ============================================================
-- Q6B: QUERY 2 — SUPPORTING SPEND DISTRIBUTION
-- ============================================================
-- Profile customer spending across smaller monetary ranges
-- to support the selection of the final tier thresholds.
--
-- Narrower ranges are used where spending is more concentrated,
-- while wider ranges are used at higher spending levels.
-- Q6B RESULT: Spend Distribution

WITH customer_spend AS (
    SELECT
        c.customer_unique_id,
        ROUND(SUM(op.payment_value), 2) AS total_spent
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_payments AS op
        ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id
)

SELECT
    CASE
        WHEN total_spent < 50 THEN 'Under 50'
        WHEN total_spent < 100 THEN '50 to 99.99'
        WHEN total_spent < 200 THEN '100 to 199.99'
        WHEN total_spent < 500 THEN '200 to 499.99'
        WHEN total_spent < 1000 THEN '500 to 999.99'
        ELSE '1000 and above'
    END AS spend_range,
    COUNT(*) AS customer_count
FROM customer_spend
GROUP BY spend_range
ORDER BY MIN(total_spent);


-- ============================================================
-- Q6C: QUERY 3 — SUPPORTING SEGMENT SUMMARY
-- ============================================================
-- Summarize the final segmentation by showing customer count,
-- share of customers, and actual spend range for each tier.
-- Q6C RESULT: Spend Tier Summary

WITH customer_spend AS (
    SELECT
        c.customer_unique_id,
        ROUND(SUM(op.payment_value), 2) AS total_spent
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_payments AS op
        ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id
),

segmented_customers AS (
    SELECT
        customer_unique_id,
        total_spent,
        CASE
            WHEN total_spent < 100 THEN 'Low'
            WHEN total_spent < 500 THEN 'Medium'
            ELSE 'High'
        END AS spend_tier
    FROM customer_spend
)

SELECT
    spend_tier,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM segmented_customers),
        2
    ) AS percentage_of_customers,
    MIN(total_spent) AS minimum_spend,
    MAX(total_spent) AS maximum_spend
FROM segmented_customers
GROUP BY spend_tier
ORDER BY minimum_spend;