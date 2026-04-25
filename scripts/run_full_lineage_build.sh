#!/usr/bin/env bash
set -euo pipefail

POSTGRES_HOST=${POSTGRES_HOST:-localhost}
POSTGRES_PORT=${POSTGRES_PORT:-5432}
POSTGRES_DB=${POSTGRES_DB:-citypulse}
POSTGRES_USER=${POSTGRES_USER:-citypulse}

echo "Running CityPulse Analytics Warehouse build..."
psql -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f sql/run_citypulse_integrated_build.sql
echo "Warehouse build complete. Review quality-check output for failed_records > 0."
