-- Add explicit warehouse constraints after dimensions and facts are created.
-- This script makes table relationships visible in PostgreSQL instead of relying only on documentation.

ALTER TABLE warehouse.fact_service_requests DROP CONSTRAINT IF EXISTS fk_fact_date;
ALTER TABLE warehouse.fact_service_requests DROP CONSTRAINT IF EXISTS fk_fact_location;
ALTER TABLE warehouse.fact_service_requests DROP CONSTRAINT IF EXISTS fk_fact_request_type;
ALTER TABLE warehouse.fact_service_requests DROP CONSTRAINT IF EXISTS fk_fact_status;
ALTER TABLE warehouse.fact_service_requests DROP CONSTRAINT IF EXISTS chk_resolution_hours_non_negative;
ALTER TABLE warehouse.fact_service_requests DROP CONSTRAINT IF EXISTS chk_request_count_one;

ALTER TABLE warehouse.fact_service_requests
    ALTER COLUMN request_id SET NOT NULL,
    ALTER COLUMN date_key SET NOT NULL,
    ALTER COLUMN location_key SET NOT NULL,
    ALTER COLUMN request_type_key SET NOT NULL,
    ALTER COLUMN status_key SET NOT NULL,
    ALTER COLUMN request_count SET NOT NULL;

ALTER TABLE warehouse.fact_service_requests
    ADD CONSTRAINT fk_fact_date
    FOREIGN KEY (date_key) REFERENCES warehouse.dim_date(date_key);

ALTER TABLE warehouse.fact_service_requests
    ADD CONSTRAINT fk_fact_location
    FOREIGN KEY (location_key) REFERENCES warehouse.dim_location(location_key);

ALTER TABLE warehouse.fact_service_requests
    ADD CONSTRAINT fk_fact_request_type
    FOREIGN KEY (request_type_key) REFERENCES warehouse.dim_request_type(request_type_key);

ALTER TABLE warehouse.fact_service_requests
    ADD CONSTRAINT fk_fact_status
    FOREIGN KEY (status_key) REFERENCES warehouse.dim_status(status_key);

ALTER TABLE warehouse.fact_service_requests
    ADD CONSTRAINT chk_resolution_hours_non_negative
    CHECK (resolution_hours IS NULL OR resolution_hours >= 0);

ALTER TABLE warehouse.fact_service_requests
    ADD CONSTRAINT chk_request_count_one
    CHECK (request_count = 1);

CREATE INDEX IF NOT EXISTS idx_fact_created_date ON warehouse.fact_service_requests(date_key);
CREATE INDEX IF NOT EXISTS idx_fact_location ON warehouse.fact_service_requests(location_key);
CREATE INDEX IF NOT EXISTS idx_fact_request_type ON warehouse.fact_service_requests(request_type_key);
CREATE INDEX IF NOT EXISTS idx_fact_status ON warehouse.fact_service_requests(status_key);
CREATE INDEX IF NOT EXISTS idx_fact_priority ON warehouse.fact_service_requests(priority_flag);
