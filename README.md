# Olist E-Commerce SQL Business Analysis

> SQL business analysis of customer behavior, revenue trends,
> product performance, customer segmentation, repeat purchasing,
> and category revenue using the Olist e-commerce dataset.


```
========================================================
                        OVERVIEW
========================================================
```

This project analyzes the Olist e-commerce dataset using
MySQL to answer eight business questions covering customer
behavior, revenue trends, product performance, segmentation,
and repeat purchasing.

The analysis focuses on correct data grain, metric
definition, validation, and clear business interpretation.

Monetary values are presented in **Brazilian Real (BRL)**,
consistent with the Olist dataset's Brazilian marketplace
context. The symbol **R$** is used for monetary results.


```
========================================================
                  BUSINESS QUESTIONS
========================================================
```

1. Who are the top 10 customers by total amount spent?

2. What is the monthly revenue trend across the dataset?

3. What is the month-over-month change in revenue?

4. Which product categories generate the most revenue?

5. Rank top 3 products within each category by revenue.

6. Segment customers into spend tiers
   (Low/Medium/High).

7. How many customers are repeat vs one-time buyers?

8. What % of total revenue comes from the top category?


```
========================================================
                     KEY FINDINGS
========================================================
```

### BUSINESS ANALYSIS 1 — TOP CUSTOMERS

[View SQL](q1_top_customers.sql)

Total recorded payments were aggregated by
`customer_unique_id` and ranked from highest to lowest.

**Highest recorded customer spend: R$13,664.08**


### BUSINESS ANALYSIS 2 — MONTHLY REVENUE TREND

[View SQL](q2_monthly_revenue_trend.sql)

Recorded payments were grouped by purchase month to create
a chronological monthly payment-revenue series.

Very small values at the dataset boundaries should be
interpreted carefully because they may represent partial
observation periods.


### BUSINESS ANALYSIS 3 — MONTH-OVER-MONTH REVENUE CHANGE

[View SQL](q3_month_over_month_revenue_change.sql)

`LAG()` was used to compare each month's payment revenue
with the previous available monthly record.

The first month correctly returns `NULL` because no earlier
monthly value exists.

November 2016 is absent, so December 2016 is compared with
the previous available month rather than a strict previous
calendar month.


### BUSINESS ANALYSIS 4 — PRODUCT CATEGORY REVENUE

[View SQL](q4_product_categories_by_revenue.sql)

Product revenue was aggregated and ranked by category.

**Top category: `health_beauty`**

**Product revenue: R$1,258,681.34**

Other leading categories included `watches_gifts`,
`bed_bath_table`, `sports_leisure`, and
`computers_accessories`.


### BUSINESS ANALYSIS 5 — TOP PRODUCTS PER CATEGORY

[View SQL](q5_top_3_products_per_category.sql)

Products were ranked independently within each category
using `ROW_NUMBER()` with `PARTITION BY`.

Only the top three revenue-generating products within each
category were retained.


### BUSINESS ANALYSIS 6 — CUSTOMER SPEND SEGMENTATION

[View SQL](q6_customer_spend_tiers.sql)

The task did not provide predefined Low, Medium, and High
spend thresholds.

Customer spending was first profiled across smaller
monetary ranges, then consolidated into practical business
tiers:

- **Low:** Below R$100 — 44,390 customers — **46.19%**
- **Medium:** R$100 to below R$500 — 47,216 — **49.13%**
- **High:** R$500 and above — 4,489 — **4.67%**

These are **data-informed, analyst-defined thresholds**,
not mathematically unique cutoffs.

Overall, **95.33%** of customers with matching payment
records spent below R$500.


### BUSINESS ANALYSIS 7 — REPEAT VS ONE-TIME BUYERS

[View SQL](q7_repeat_vs_one_time_customers.sql)

Customers were classified using their total order count.

- **One-Time Buyers:** 93,099 — **96.88%**
- **Repeat Buyers:** 2,997 — **3.12%**

Only **3.12%** of customers placed more than one order
within the observed dataset period.


### BUSINESS ANALYSIS 8 — TOP CATEGORY REVENUE SHARE

[View SQL](q8_top_category_revenue_share.sql)

Category revenue was compared with total product revenue
using a windowed total.

- **Top Category:** `health_beauty`
- **Category Revenue:** R$1,258,681.34
- **Total Product Revenue:** R$13,591,643.70
- **Revenue Share:** **9.26%**

The highest-revenue category contributes only **9.26%**
of total product revenue.

This indicates that no single product category dominates
total product revenue.


```
========================================================
                   RECOMMENDATIONS
========================================================
```

### 1. ANALYZE SECOND-PURCHASE BEHAVIOR

Examine time to second order, first-purchase category,
customer cohort, and initial order value to better
understand what is associated with repeat purchasing.


### 2. PROFILE HIGH-SPEND CUSTOMERS

Analyze the R$500+ segment by order frequency, average
order value, category preferences, repeat rate, and
contribution to total customer revenue.


### 3. MONITOR CATEGORY PERFORMANCE

Track monthly category revenue, growth, revenue share,
and top-product contribution to identify changes in
product performance over time.


```
========================================================
              METHODOLOGY & VALIDATION
========================================================
```

### Customer Identity

Customer-level analysis uses `customer_unique_id` rather
than `customer_id`.

`customer_id` represents an order-linked customer record,
while `customer_unique_id` represents the persistent
customer identity across multiple orders.


### Revenue Definitions

Payment-based analysis uses:

`SUM(order_payments.payment_value)`

Product and category analysis uses:

`SUM(order_items.price)`

These metrics are intentionally kept separate because they
answer different business questions.

The product-revenue measure is based on item price and does
not include freight.


### Customer Count Reconciliation

**Business Analysis 7**

**93,099 One-Time Buyers + 2,997 Repeat Buyers
= 96,096 unique customers**

**Business Analysis 6**

**44,390 Low + 47,216 Medium + 4,489 High
= 96,095 customers with matching payment records**

The one-customer difference exists because spend
segmentation requires a matching payment record.


### Category Revenue Cross-Check

Business Analyses 4 and 8 independently return:

**`health_beauty` — R$1,258,681.34**

This confirms consistency between the category-ranking
and revenue-share analyses.


### Analytical Limitations

Repeat purchasing is measured only within the available
dataset period. A customer classified as a One-Time Buyer
may have purchased again outside the observation window.

Missing calendar months are not automatically generated,
so `LAG()` compares each month with the previous available
monthly record.

No additional order-status filter was introduced for this
capstone analysis. In production BI reporting, recognized
revenue and order-status inclusion rules should be defined
before publishing governed financial KPIs.


```
========================================================
                   TOOLS & SKILLS
========================================================
```

### Tools

- **MySQL** — querying and analytical calculations
- **DataGrip** — SQL development and validation
- **Git** — version control
- **GitHub** — repository hosting and documentation


### SQL & Analytical Skills

- JOIN and LEFT JOIN
- GROUP BY and aggregation
- CASE WHEN
- COALESCE
- CTEs and subqueries
- DATE_FORMAT()
- LAG()
- ROW_NUMBER()
- PARTITION BY
- SUM() OVER()
- customer segmentation
- metric definition
- data-grain validation
- result reconciliation
- business interpretation


```
========================================================
                        FILES
========================================================
```

### BUSINESS ANALYSIS 1 — TOP CUSTOMERS

[View SQL](q1_top_customers.sql)


### BUSINESS ANALYSIS 2 — MONTHLY REVENUE TREND

[View SQL](q2_monthly_revenue_trend.sql)


### BUSINESS ANALYSIS 3 — MONTH-OVER-MONTH REVENUE CHANGE

[View SQL](q3_month_over_month_revenue_change.sql)


### BUSINESS ANALYSIS 4 — PRODUCT CATEGORY REVENUE

[View SQL](q4_product_categories_by_revenue.sql)


### BUSINESS ANALYSIS 5 — TOP PRODUCTS PER CATEGORY

[View SQL](q5_top_3_products_per_category.sql)


### BUSINESS ANALYSIS 6 — CUSTOMER SPEND SEGMENTATION

[View SQL](q6_customer_spend_tiers.sql)


### BUSINESS ANALYSIS 7 — REPEAT VS ONE-TIME BUYERS

[View SQL](q7_repeat_vs_one_time_customers.sql)


### BUSINESS ANALYSIS 8 — TOP CATEGORY REVENUE SHARE

[View SQL](q8_top_category_revenue_share.sql)