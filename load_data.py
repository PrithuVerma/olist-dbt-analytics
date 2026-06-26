import duckdb
import os

# Connect to your DuckDB database file
con = duckdb.connect("/Users/neeraj/Desktop/Code/dbt_f/olist_dbt_project/olist_analytics/olist.duckdb")

# Path to your CSV folder
csv_path = "/Users/neeraj/Desktop/Code/dbt_f/olist_dbt_project/olist_analytics/dataset"

# Create raw schema
con.execute("CREATE SCHEMA IF NOT EXISTS raw")

# Load all 9 CSVs into raw schema
tables = {
    "raw_orders":             "olist_orders_dataset.csv",
    "raw_order_items":        "olist_order_items_dataset.csv",
    "raw_customers":          "olist_customers_dataset.csv",
    "raw_sellers":            "olist_sellers_dataset.csv",
    "raw_products":           "olist_products_dataset.csv",
    "raw_payments":           "olist_order_payments_dataset.csv",
    "raw_reviews":            "olist_order_reviews_dataset.csv",
    "raw_geolocation":        "olist_geolocation_dataset.csv",
    "raw_category_translation": "product_category_name_translation.csv",
}

for table_name, filename in tables.items():
    filepath = os.path.join(csv_path, filename)
    print(f"Loading {filename} → raw.{table_name}...")
    con.execute(f"""
        CREATE OR REPLACE TABLE raw.{table_name} AS
        SELECT * FROM read_csv_auto('{filepath}')
    """)
    count = con.execute(f"SELECT COUNT(*) FROM raw.{table_name}").fetchone()[0]
    print(f"  ✓ {count:,} rows loaded")

print("\nAll tables loaded successfully!")
con.close()