# Incremental Load Strategy

The incremental example uses `request_id` as the de-duplication key.

```sql
WHERE NOT EXISTS (
    SELECT 1
    FROM warehouse.fact_service_requests f
    WHERE f.request_id = s.request_id
)
```

This protects the event-level fact table from duplicate inserts when the same upstream ETL records are processed again. It is a simple append-safe strategy suitable for explaining the concept without hiding the logic inside an orchestration framework.

Known limitation: this does not handle late-arriving corrections to previously loaded records. A future version could add an upsert/merge pattern.
