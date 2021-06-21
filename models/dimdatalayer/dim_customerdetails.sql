{{
config(
materialized='table',
schema='curateddatalayer'
)
}}

select
  'cc647baca88ed0045f4e3bdabe733a4b' as sk
  , 'TRUE' as is_active
  , customer_id
  , customer_type as type
  , 'name of customer' as customer_name
  , status
  ,'some number' as customer_age
  , 'vault' as source_system_identifier
FROM {{ref('CustomersCreated')}}