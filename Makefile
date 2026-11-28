.PHONY: data raw dbt-run dbt-build dbt-test dbt-docs

# Download the dataset and notebook from Zenodo into data/landing
data:
	bash data.sh

# Convert the landing CSV into typed Parquet in data/raw
raw:
	mkdir -p data/raw
	uv run python -c "import duckdb; duckdb.sql(open('scripts/01_csv_to_parquet.sql').read())"

# Build dbt models only (no tests)
dbt-run:
	cd gl && uv run dbt run

# Build dbt models and run tests in dependency order
dbt-build:
	cd gl && uv run dbt build

# Run dbt tests only (models must already be built)
dbt-test:
	cd gl && uv run dbt test

# Generate dbt docs and serve them at http://localhost:8080 (open in VS Code: Simple Browser: Show)
dbt-docs:
	cd gl && uv run dbt docs generate && uv run dbt docs serve --port 8080 --no-browser
