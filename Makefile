.PHONY: data raw

# Download the dataset and notebook from Zenodo into data/landing
data:
	bash data.sh

# Convert the landing CSV into typed Parquet in data/raw
raw:
	mkdir -p data/raw
	uv run python -c "import duckdb; duckdb.sql(open('scripts/01_csv_to_parquet.sql').read())"
