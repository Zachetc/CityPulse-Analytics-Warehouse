# Fact Table Grain

The grain of `warehouse.fact_service_requests` is:

> one row per service request event.

The natural event identifier is `request_id`. This means:

- `request_count` should always equal 1 per row.
- `request_id` should never appear more than once in the fact table.
- All reporting marts aggregate from the same event-level base table.

This design prevents metric drift because monthly volume, backlog, response time, and priority-rate metrics all start from the same grain.
