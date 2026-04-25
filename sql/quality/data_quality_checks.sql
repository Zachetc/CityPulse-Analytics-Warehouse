-- CityPulse warehouse quality checks.
-- These checks are intentionally written as readable SQL so they can be explained in a capstone presentation.

-- 1. Staging should not contain duplicate request IDs.
SELECT
    'duplicate_request_ids_in_staging' AS check_name,
    COUNT(*) AS failed_records
FROM (
    SELECT request_id
    FROM staging.service_requests
    GROUP BY request_id
    HAVING COUNT(*) > 1
) dupes;

-- 2. Required event timestamp should exist.
SELECT
    'missing_created_at_in_staging' AS check_name,
    COUNT(*) AS failed_records
FROM staging.service_requests
WHERE created_at IS NULL;

-- 3. Required fact foreign keys should not be null.
SELECT
    'null_fact_foreign_keys' AS check_name,
    COUNT(*) AS failed_records
FROM warehouse.fact_service_requests
WHERE date_key IS NULL
   OR location_key IS NULL
   OR request_type_key IS NULL
   OR status_key IS NULL;

-- 4. Resolution hours should not be negative.
SELECT
    'negative_resolution_hours' AS check_name,
    COUNT(*) AS failed_records
FROM warehouse.fact_service_requests
WHERE resolution_hours < 0;

-- 5. Closed records should normally have a closed_at timestamp.
SELECT
    'closed_requests_missing_closed_at' AS check_name,
    COUNT(*) AS failed_records
FROM warehouse.fact_service_requests
WHERE is_closed = TRUE
  AND closed_at IS NULL;

-- 6. Mart tables should contain rows after build.
SELECT
    'empty_request_volume_mart' AS check_name,
    CASE WHEN COUNT(*) = 0 THEN 1 ELSE 0 END AS failed_records
FROM marts.request_volume_monthly;
