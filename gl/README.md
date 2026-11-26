# gl

dbt project that models the general ledger. Runs on DuckDB locally; Athena later.

## Run

From the repo root, build the raw data first:

```bash
make data   # download the source files into data/landing
make raw    # build data/raw/journal_entries.parquet
```

Then, from this folder:

```bash
uv run dbt debug   # check the connection
uv run dbt build   # build models and run tests
```

Models build into `data/warehouse.duckdb`. Connection settings are in `profiles.yml`.

## Layers

| Folder | Materialization | Purpose |
| --- | --- | --- |
| `models/staging` | view | Cleaned 1:1 copies of the raw sources |
| `models/intermediate` | view | Reshaping between staging and marts |
| `models/marts` | table | Final tables for reporting and analysis |
