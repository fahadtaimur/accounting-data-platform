select
    *
from {{ ref('stg_gl__postings') }}
where amount <= 0
