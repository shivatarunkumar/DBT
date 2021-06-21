{{
config(
materialized='incremental',
schema='curateddatalayer'
)
}}

select
  'cc647baca88ed0045f4e3bdabe733a4b' as sk
  , cast('2021-05-27 00:00:20 UTC' as timestamp) as valid_from
  , cast('1975-01-01 23:59:59 UTC' as timestamp) as valid_to
  , 'TRUE' as is_active
  , customer_id
  , customer_type as type
  , status
  , business_name
  , business_start_date
  , company_registration_number
  , date_of_incorporation
  , country_of_incorporation
  , business_address
  , contact_details
  , number_of_employees
  , expected_turnover
  , 'vault' as source_system_identifier
FROM {{ref('CustomersCreated')}}