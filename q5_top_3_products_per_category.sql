-- Question 5:
-- Rank top 3 products within each category by revenue.

-- ============================================================
-- Q5: MAIN QUERY — TOP 3 PRODUCTS PER CATEGORY BY REVENUE
-- ============================================================
-- Calculate revenue for each product within its category,
-- then rank products from highest to lowest revenue inside
-- each category and return only the top three.
--
-- ROW_NUMBER resets the ranking for each product category.
-- Category names use the same English-name fallback logic as Q4.
-- Q5 RESULT: Top 3 Products per Category by Revenue

WITH product_revenue AS (
    SELECT
        COALESCE(
            pct.product_category_name_english,
            p.product_category_name,
            'Unknown'
        ) AS product_category,
        oi.product_id,
        ROUND(SUM(oi.price), 2) AS product_revenue
    FROM order_items AS oi
    JOIN products AS p
        ON oi.product_id = p.product_id
    LEFT JOIN product_category_name_translation AS pct
        ON p.product_category_name = pct.product_category_name
    GROUP BY
        product_category,
        oi.product_id
),

ranked_products AS (
    SELECT
        product_category,
        product_id,
        product_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY product_category
            ORDER BY product_revenue DESC
        ) AS revenue_rank
    FROM product_revenue
)

SELECT
    product_category,
    product_id,
    product_revenue,
    revenue_rank
FROM ranked_products
WHERE revenue_rank <= 3
ORDER BY
    product_category,
    revenue_rank;