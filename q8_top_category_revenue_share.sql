-- Question 8:
-- What % of total revenue comes from the top category?

-- ============================================================
-- Q8: MAIN QUERY — TOP CATEGORY REVENUE SHARE
-- ============================================================
-- Calculate revenue by product category, compare each category
-- with total product revenue, then return the top category
-- and its percentage contribution to the total.
--
-- Product revenue uses order_items.price for consistency
-- with the category analyses in Questions 4 and 5.
-- Q8 RESULT: Top Category Revenue Share

WITH category_revenue AS (
    SELECT
        COALESCE(
            pct.product_category_name_english,
            p.product_category_name,
            'Unknown'
        ) AS product_category,
        SUM(oi.price) AS category_revenue
    FROM order_items AS oi
    JOIN products AS p
        ON oi.product_id = p.product_id
    LEFT JOIN product_category_name_translation AS pct
        ON p.product_category_name = pct.product_category_name
    GROUP BY product_category
),

category_share AS (
    SELECT
        product_category,
        category_revenue,
        SUM(category_revenue) OVER () AS total_product_revenue,
        category_revenue * 100.0
            / SUM(category_revenue) OVER () AS revenue_percentage
    FROM category_revenue
)

SELECT
    product_category,
    ROUND(category_revenue, 2) AS category_revenue,
    ROUND(total_product_revenue, 2) AS total_product_revenue,
    ROUND(revenue_percentage, 2) AS percentage_of_total_revenue
FROM category_share
ORDER BY category_revenue DESC
LIMIT 1;