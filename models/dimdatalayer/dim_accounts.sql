{{
config(
materialized='table',
schema='curateddatalayer'
)
}}

SELECT
    'cc647baca88ed0045f4e3bdabe733a4b' as sk
  , opening_time as valid_from
  , cast('9999-12-31 23:59:59 UTC' as timestamp) as valid_to
  , 'TRUE' as is_active
  , account_id
  , 'False' as is_internal
  , '99995555' as account_number
  , '119100' as bank_id
  , product_id
  , account_status
  , account_created as account_opened_at
  , authorised_overdraft
  , stakeholder_id
  , 'vault' as source_system_identifier
FROM {{ref('AccountsCreated')}}
where product_id='89'