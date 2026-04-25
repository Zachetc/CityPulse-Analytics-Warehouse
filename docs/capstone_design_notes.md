# Capstone Design Notes

This project is intentionally scoped around one analytical domain: municipal service requests. The important design work is not the size of the data, but the correctness of the warehouse model.

Key decisions:

1. Use a staging schema to isolate upstream ETL records from warehouse logic.
2. Define the fact table grain before creating marts.
3. Use dimensions for date, location, request type, and status so that reporting queries are consistent.
4. Add explicit constraints and quality checks so table relationships are testable.
5. Keep the orchestration simple enough to explain line by line in an interview.

The project can be extended with dbt, Airflow, late-arriving updates, and dashboard deployment, but the current version focuses on the fundamentals of warehouse modeling.
