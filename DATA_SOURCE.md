# Original Dataset Access and Reproducibility

## Official source

**Brazilian E-Commerce Public Dataset by Olist** — [download the original CSV dataset from Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).

The source is published by Olist, covers anonymized Brazilian e-commerce transactions from 2016–2018, and is listed under **CC BY-NC-SA 4.0 (Attribution–NonCommercial–ShareAlike)**. See Kaggle's original dataset page for the controlling license and download instructions. Signing in to Kaggle may be required.

**Dataset distribution approach:** This repository provides the eight inspectable original SQL analysis scripts and links directly to Olist's authoritative dataset source rather than duplicating or relicensing the nine original CSVs.

## Download and recreate the SQL tables

1. Open [the original Olist dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce), sign in if prompted and download the dataset archive.
2. Extract the CSV files and import the six tables used by the analysis into a **MySQL 8+** database.
3. Name the imported tables as shown below. Preserve the original column names and use numeric/date data types suitable for the SQL analyses.
4. Run the eight `q1_...sql` through `q8_...sql` scripts. The scripts assume the named tables already exist and contain the source data; they are analyses, **not** a database creation/import pipeline.

| Source CSV from Kaggle | Expected table name in SQL |
| --- | --- |
| `olist_customers_dataset.csv` | `customers` |
| `olist_orders_dataset.csv` | `orders` |
| `olist_order_items_dataset.csv` | `order_items` |
| `olist_order_payments_dataset.csv` | `order_payments` |
| `olist_products_dataset.csv` | `products` |
| `product_category_name_translation.csv` | `product_category_name_translation` |

The original Kaggle archive has additional tables that are **not** required for the eight published analyses.

## Metric and interpretation guidance

- For customer-level measures, join on `customer_unique_id` through the customer/order relationships; `customer_id` is an order-linked identifier in the original Olist source.
- Payment revenue uses `SUM(order_payments.payment_value)`; category/product revenue uses `SUM(order_items.price)`. These are different business measures and must not be equated.
- `LAG()` compares against the previous **available record** in the monthly series. Missing calendar months are not filled in automatically.
- The SQL scripts were written for MySQL and use modern analytical functions including `ROW_NUMBER()` and window functions.
- There is no claim that running the scripts on a different dataset version or with different import transformations necessarily reproduces the published numbers without reconciliation.

## Project materials

- [Business questions, interpretations and reconciliations](README.md)
- [Eight SQL query files](.)
- [One-page insights PDF](Olist_Insight_Summary.pdf)

**Attribution:** Original data © / licensed by its respective rights holder, Olist, under the license displayed on Kaggle. This repository's own analytical SQL work is separate from the source dataset licensing.
