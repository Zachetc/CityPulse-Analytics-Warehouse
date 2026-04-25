-- Fact table grain validation.
-- Expected grain: one row per service request event.
-- request_id should be unique in warehouse.fact_service_requests.

SELECT
    'fact_grain_duplicate_request_id' AS check_name,
    COUNT(*) AS failed_records
FROM (
    SELECT request_id
    FROM warehouse.fact_service_requests
    GROUP BY request_id
    HAVING COUNT(*) > 1
) duplicates;

-- The number of fact rows should not exceed the number of distinct staging request IDs.
SELECT
    'fact_rows_exceed_distinct_staging_requests' AS check_name,
    CASE
        WHEN (SELECT COUNT(*) FROM warehouse.fact_service_requests) >
             (SELECT COUNT(DISTINCT request_id) FROM staging.service_requests)
        THEN 1 ELSE 0
    END AS failed_records;
