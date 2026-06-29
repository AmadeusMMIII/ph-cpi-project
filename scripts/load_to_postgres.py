import pandas as pd
from sqlalchemy import create_engine, text

# 1. Read the CSV file
df = pd.read_csv("data/Year-on-Year Changes of the Consumer Price Index in Percent by Commodity Group (2018=100) January 2023 - December 2025.csv", skiprows=1)

# Clean column names to be database friendly (lowercase, replace spaces with underscores)
df.columns = df.columns.str.strip().str.lower().str.replace(' ', '_')

engine = create_engine("postgresql://postgres:D4t4@localhost:5432/macro_db")

# Add these lines to create the raw schema if it doesn't exist
with engine.connect() as conn:
    conn.execute(text("CREATE SCHEMA IF NOT EXISTS raw;"))
    conn.commit()

# Now this will run perfectly
df.to_sql("raw_cpi_inflation", engine, schema="raw", if_exists="replace", index=False)
print("Successfully ingested raw CPI data into PostgreSQL!")