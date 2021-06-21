{{
config(
materialized='table',
schema='flattendatalayer')
}}

SELECT
      DISTINCT
      common_metadata.message_identifier.message_id
    , product_id
    , product_name
    , active_product_version_id
    , operation_type
    , event_timestamp
    , status
    , change_id
    , emh_processing_timestamp
    , product_family
    , product_type
    , default_currency
FROM {{ source('rawdatalayer', 'src_products_created') }}
