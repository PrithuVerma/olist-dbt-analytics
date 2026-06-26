# Olist E-Commerce Analytics Pipeline

An end-to-end analytics pipeline built on the Brazilian Olist E-Commerce dataset using dbt and DuckDB.

## Project Overview

This project transforms raw e-commerce data into clean, tested, and documented analytical models that answer real business questions about orders, revenue, delivery performance, and seller metrics.

## Tech Stack

- **dbt Core** — data transformation, testing, and documentation
- **DuckDB** — local analytical database
- **Python** — data loading script
- **PowerBI** — dashboard (coming soon)

## Dataset

[Olist Brazilian E-Commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — 100k+ orders across 9 related tables covering customers, sellers, products, payments, and reviews.

## Architecture
Raw CSVs → DuckDB (raw schema) → dbt Staging Models → dbt Mart Models

**Staging layer** — 8 views that clean and rename raw source tables. One model per source table, no joins.

**Marts layer** — 6 tables containing joined, enriched, analysis-ready data.

## Models

### Staging
| Model | Description |
|---|---|
| stg_orders | Cleaned orders with cast timestamps |
| stg_order_items | Line items with price and freight |
| stg_customers | Customer info and location |
| stg_sellers | Seller info and location |
| stg_products | Product details and dimensions |
| stg_payments | Payment type and value |
| stg_reviews | Review scores and comments |
| stg_category_translation | Portuguese to English category mapping |

### Marts
| Model | Description |
|---|---|
| dim_customers | Customer dimension table |
| dim_sellers | Seller dimension table |
| dim_products | Product dimension with English category names |
| fct_orders | Core fact table with delivery and payment metrics |
| fct_order_items | Order line items joined with product and seller info |
| olist_monthly_summary | Monthly aggregated business metrics |

## Business Questions Answered

1. What is the monthly revenue and order volume trend?
2. Which product categories generate the most revenue?
3. What is the average delivery time and how does it vary by state?
4. Which sellers have the highest review scores?
5. What payment methods do customers prefer?

## Data Quality

35 dbt tests covering:
- Uniqueness and not-null constraints on all primary keys
- Accepted values validation on order status and review scores
- Referential integrity across staging and mart layers

## Lineage DAG

<img width="2800" height="1234" alt="dbt-dag" src="https://github.com/user-attachments/assets/25bd5f16-e60d-48a3-9d1c-9f02ab8efefb" />

## How to Run

```bash
# Clone the repo
git clone https://github.com/PrithuVerma/olist-dbt-analytics.git
cd olist-dbt-analytics

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install dbt-core dbt-duckdb

# Download Olist dataset from Kaggle and place CSVs in dataset/ folder

# Load raw data into DuckDB
python load_data.py

# Run dbt
dbt run
dbt test

# View documentation
dbt docs generate
dbt docs serve
```
