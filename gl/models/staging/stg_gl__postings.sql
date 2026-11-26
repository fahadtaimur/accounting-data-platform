-- One row per posting line. Lines sharing a journal_entry_id form one journal entry.
with source as (
    select * from {{ source('raw', 'journal_entries') }}
),

renamed as (
    select
        -- identifiers
        _source_row as posting_line_id,
        posting_id as journal_entry_id,
        nullif(ref_id, '0') as reference_id,

        -- dates
        document_date,
        posting_date,
        entered_date as entered_at,

        -- account details
        gl_account as account_number,
        gl_account_name as account_name,

        -- amounts
        amount,
        cd_flag as debit_credit,
        case
            when cd_flag = 'D' then amount
            else -amount
        end as signed_amount,
        tax_rate,

        -- context
        "user" as posted_by,
        text as description,

        -- indicators
        -- entered before 8am or after 5pm
        nwh = 1 as is_non_working_hours,
        high_cash = 1 as is_high_cash,
        top_n = 1 as is_top_n,
        label = 1 as is_anomaly,

        -- multi-value codes
        -- entered_at vs document_date: 1 = 0-9 days, 2 = 10-29, 3 = 30+
        promptly as entry_delay_code,
        -- entered on: 0 = weekday, 1 = Saturday, 2 = Sunday
        weekend as weekend_code,
        -- anomaly scenario number; 0 = not an anomaly
        marking as anomaly_type_code,

        -- lineage
        _source_file,
        _loaded_at
    from source
)

select * from renamed
