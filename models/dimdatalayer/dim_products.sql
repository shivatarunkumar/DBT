{{
config(
materialized='incremental',
schema='curateddatalayer', 
unique_key="product_id"
)
}}

select distinct
    product_id
    , product_name as display_name
    , product_family
    , product_type
    , default_currency
    , 'vault' as source_system_identifier
FROM {{ref('ProductsCreated')}}
where product_id='89'

