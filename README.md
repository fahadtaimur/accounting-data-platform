# accounting-data-platform

A dbt + DuckDB project that models a general ledger. It starts local
(DuckDB + Parquet) and will move to AWS (dbt + Athena) later.

## Objectives

- **Validate the ledger:** check that every journal entry balances, that the trial
   balance ties out, and that posting dates fall in the right fiscal periods
- **Assess data quality:** profile completeness, consistency and referential
   integrity across postings, accounts and documents
- **Model the general ledger:** build tested dbt layers from raw postings to
   reporting-ready marts
- **Support journal entry testing:** surface entries with audit risk indicators and
   compare them against the dataset's labeled anomalies
- **Stay portable:** run the same models on DuckDB locally and Athena on AWS

## Stack

| Layer          | Local now          | AWS later        |
| -------------- | ------------------ | ---------------- |
| Storage        | Parquet files      | S3               |
| Query engine   | DuckDB             | Athena           |
| Transformation | dbt (`dbt-duckdb`) | dbt (`dbt-athena`) |

## Getting started

Requires [uv](https://docs.astral.sh/uv/) and Python 3.12+.

```bash
uv sync
uv run dbt --version
```

## Data

This project uses the **DIB General Ledger Data** dataset: two fiscal years of
synthetic general ledger postings for a fictional company. Every entry follows
double-entry bookkeeping, and the dataset includes labeled problematic entries for
journal entry testing (audit analytics).

All credit for the dataset and the method used to generate it goes to its authors:

> Gronewald, J., Stephan, S., Rombach, A., & Fettke, P. (2026).
> *Generating synthetic journal entries for audit analytics: Method and dataset.*
> Data in Brief. https://www.sciencedirect.com/science/article/pii/S2352340926008048

> Gronewald, J., Stephan, S., Rombach, A., & Fettke, P. (2026).
> *DIB General Ledger Data* [Data set]. Zenodo.
> https://doi.org/10.5281/zenodo.22014653

The authors are with the German Research Center for Artificial Intelligence (DFKI),
Saarbrücken, Germany.

The dataset is licensed under
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). The data isn't stored in
this repo; run `make data` to download the original files from Zenodo into `data/landing/`, then `make raw` to build the Parquet copy in `data/raw/`. Any converted copies (e.g. Parquet) or derived models in this
repo are changes made by this project, not by the original authors.

## Status

Early setup. More to come.

## License

Code in this repo is licensed under the [MIT License](LICENSE). The dataset is not
covered by it and keeps its own CC BY 4.0 license (see [Data](#data)).
