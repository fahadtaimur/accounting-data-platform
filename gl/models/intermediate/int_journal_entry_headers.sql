select
    journal_entry_id,
    min(document_date) as document_date,
    min(posting_date) as posting_date,
    min(entered_at) as entered_at,
    min(posted_by) as posted_by,
    count(*) as line_count,
    sum(case when debit_credit = 'D' then amount else 0 end) as debit_total,
    sum(case when debit_credit = 'C' then amount else 0 end) as credit_total,
    bool_or(is_anomaly) as is_anomaly,
    max(anomaly_type_code) as anomaly_type_code
from {{ ref('stg_gl__postings') }}
group by journal_entry_id
