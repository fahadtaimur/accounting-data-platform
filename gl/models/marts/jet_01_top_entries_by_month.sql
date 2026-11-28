-- Top 10 journals per month (equal ranks allowed)
with ranking as (
    select
        journal_entry_id,
        cast(date_trunc('month', posting_date) as date) as posting_month,
        posting_date,
        entered_at,
        posted_by,
        line_count,
        cast(debit_total as decimal(18, 2)) as amount,
        is_anomaly,
        anomaly_type_code,
        rank() OVER (
            PARTITION BY date_trunc('month', posting_date)
            ORDER BY debit_total desc
        ) as amount_rank
    from {{ ref('int_journal_entry_headers') }}
)
    select * from ranking
    where amount_rank <= 10
