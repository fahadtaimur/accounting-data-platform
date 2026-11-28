-- check that ref staged table has single value for aggregated columns
select
    journal_entry_id
from {{ ref('stg_gl__postings') }}
group by journal_entry_id
having
    count(distinct posting_date) > 1
    or count(distinct document_date) > 1
    or count(distinct entered_at) > 1
    or count(distinct posted_by) > 1
