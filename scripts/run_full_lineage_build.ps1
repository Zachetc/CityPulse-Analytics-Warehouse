$ErrorActionPreference = "Stop"

$HostName = $env:POSTGRES_HOST
if (-not $HostName) { $HostName = "localhost" }
$Port = $env:POSTGRES_PORT
if (-not $Port) { $Port = "5432" }
$Database = $env:POSTGRES_DB
if (-not $Database) { $Database = "citypulse" }
$User = $env:POSTGRES_USER
if (-not $User) { $User = "citypulse" }

Write-Host "Running CityPulse Analytics Warehouse build..."
psql -h $HostName -p $Port -U $User -d $Database -f sql/run_citypulse_integrated_build.sql
Write-Host "Warehouse build complete. Review quality-check output above for failed_records > 0."
