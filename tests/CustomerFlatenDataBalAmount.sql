-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where this isn't true to make the test fail
select
    customer_name,
    sum(eod_balance) as total_amount
from {{ ref('CustomerCreateFlattendataView' )}}
group by 1
having not(total_amount >= 0)
