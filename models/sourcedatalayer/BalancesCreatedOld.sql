{{
config(
materialized='table',
schema='flattendatalayer')
}}

with balance_created as(
SELECT
emh_pubsub_id,
data[offset(0)].balance_id as balance_id,
data[offset(0)].balance[offset(0)] as bookedBal,
data[offset(0)].balance[offset(1)] as availBal
FROM {{ source('rawdatalayer', 'src_balances_created') }}
)
select
bookedBal.account_id as account_id,
availBal.credit_debit_indicator as available_crdr_indicator,
availBal.amount.amount as available_amount,
bookedBal.credit_debit_indicator as booked_crdr_indicator,
bookedBal.amount.amount as booked_amount,
bookedBal.amount.currency as currency,
availBal.date_time as last_value_timestamp
from balance_created