{{
config(
materialized='table',
schema='curateddatalayer'
)
}}

select
    account_id
    , available_crdr_indicator
    , available_amount
    , booked_crdr_indicator
    , booked_amount
    , currency
    , last_value_timestamp
    , 'vault' as source_system_identifier
FROM {{ref('BalancesCreated')}}