-- Question 5:
-- Rank top 3 products within each category by revenue.

-- Q5 Query & Result
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