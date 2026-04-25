-- Dimension conformance checks.
-- Every fact foreign key should resolve to a valid dimension row.

SELECT 'missing_date_dimension' AS check_name, COUNT(*) AS failed_records
FROM warehouse.fact_service_requests f
LEFT JOIN warehouse.dim_date d ON f.date_key = d.date_key
WHERE d.date_key IS NULL;

SELECT 'missing_location_dimension' AS check_name, COUNT(*) AS failed_records
FROM warehouse.fact_service_requests f
LEFT JOIN warehouse.dim_location l ON f.location_key = l.location_key
WHERE l.location_key IS NULL;

SELECT 'missing_request_type_dimension' AS check_name, COUNT(*) AS failed_records
FROM warehouse.fact_service_requests f
LEFT JOIN warehouse.dim_request_type rt ON f.request_type_key = rt.request_type_key
WHERE rt.request_type_key IS NULL;

SELECT 'missing_status_dimension' AS check_name, COUNT(*) AS failed_records
FROM warehouse.fact_service_requests f
LEFT JOIN warehouse.dim_status st ON f.status_key = st.status_key
WHERE st.status_key IS NULL;
