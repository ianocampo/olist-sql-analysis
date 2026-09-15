-- Question 4:
-- Which product categories generate the most revenue?

-- ============================================================
-- Q4: MAIN QUERY — PRODUCT CATEGORY REVENUE
-- ============================================================
-- Calculate total product revenue for each category, then rank
-- categories from highest to lowest revenue.
--
-- Category names are translated to English when available.
-- If no translation exists, use the original category name;
-- if no category name exists, label it as Unknown.
-- Q4 RESULT: Product Categories by Revenue

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