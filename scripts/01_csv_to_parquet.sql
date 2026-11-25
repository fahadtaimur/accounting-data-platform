-- Raw layer: landing CSV -> typed Parquet, one row per posting line.
COPY (
    SELECT
        row_number() OVER () AS _source_row,  -- CSV order is the only line identifier
        *,
        'journal_entries_4203.csv' AS _source_file,
        current_timestamp AS _loaded_at
    FROM read_csv(
        'data/landing/journal_entries_4203.csv',
        delim = ';',
        header = true,
        types = {
            'gl_account': 'VARCHAR',
            'amount': 'DECIMAL(18, 2)'
        }
    )
) TO 'data/raw/journal_entries.parquet' (FORMAT parquet, COMPRESSION zstd);
