# Data Lineage

CityPulse Analytics Warehouse is downstream of CityPulse ETL.

```text
CityPulse ETL
  -> public.service_requests
  -> staging.service_requests
  -> warehouse.dim_date / dim_location / dim_request_type / dim_status
  -> warehouse.fact_service_requests
  -> marts.request_volume_monthly / response_time_distribution / priority_request_trends / open_request_backlog
```

The warehouse does not perform scraping or raw cleaning. Its responsibility is analytical modeling: staging, dimensions, fact construction, constraints, quality checks, and reporting marts.
