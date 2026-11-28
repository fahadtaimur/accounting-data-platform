-- Every journal entry must balance: debits = credits.
-- Returns the entries that don't; the test passes when no rows come back.
select
    journal_entry_id,
    sum(signed_amount) as net_amount
from {{ ref('stg_gl__postings') }}
group by journal_entry_id
having sum(signed_amount) <> 0
