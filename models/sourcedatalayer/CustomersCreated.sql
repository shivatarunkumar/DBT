{{
config(
materialized='incremental',
schema='flattendatalayer')
}}

select
      message_id
      , org_id
      , customer_id
      , customer_type
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
      , created_by
      , last_modified_by
      , created_timestamp
      , last_modified_timestamp
      , emh_processing_timestamp
FROM {{ source('rawdatalayer', 'src_customers_created') }}