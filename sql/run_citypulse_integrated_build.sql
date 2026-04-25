-- Full CityPulse Analytics Warehouse build.
-- Run this after the CityPulse ETL project has loaded public.service_requests.

\i sql/integration/import_from_citypulse_etl.sql
\i sql/warehouse/create_dimensions.sql
\i sql/warehouse/create_fact_service_requests.sql
\i sql/warehouse/add_constraints.sql
\i sql/incremental/load_fact_incremental.sql
\i sql/marts/create_reporting_views.sql
\i sql/quality/data_quality_checks.sql
\i sql/quality/grain_validation.sql
\i sql/quality/dimension_integrity_checks.sql
