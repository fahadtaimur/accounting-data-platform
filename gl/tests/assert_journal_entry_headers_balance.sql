-- Each journal entry should be balanced
select
    journal_entry_id,
    debit_total,
    credit_total
from {{ ref('int_journal_entry_headers') }}
where debit_total <> credit_total
