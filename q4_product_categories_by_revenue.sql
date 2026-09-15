-- Question 4:
-- Which product categories generate the most revenue?

-- Q4 Query & Result
SELECT
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name,
        'Unknown'
    ) AS product_category,
    ROUND(SUM(oi.price), 2) AS category_revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation AS pct
    ON p.product_category_name = pct.product_category_name
GROUP BY product_category
ORDER BY category_revenue DESC;