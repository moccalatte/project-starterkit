# 04. Data Pipeline

## 4.1 Data Sources
- **Data Warehouse**: Snowflake / BigQuery.
- **Raw Format**: Parquet / CSV.

## 4.2 ETL Stages
1.  **Extraction**: SQL Query to fetch raw logs.
2.  **Cleaning**: Handle missing values (Imputation), remove bots.
3.  **Feature Engineering**:
    - One-hot encoding categorical variables.
    - Normalizing numerical features.
4.  **Splitting**: Time-based split (Train: Jan-May, Test: June).

## 4.3 Tooling
- **Orchestration**: Airflow / Prefect / Dagster.
- **Processing**: Pandas (small data) / Spark (big data).
