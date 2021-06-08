{{
    config(
        materialized='incremental',
        unique_key='guid',
        schema='flattendatalayer'
    )
}}

with customer_flatten_data as (
SELECT 
customer.name as customer_name,
customer.gender as customer_gender,
customer.phone as customer_phone,
customer.email as customer_email,
balance as eod_balance,
guid as guid,
current_date() as created_date,
current_timestamp() as created_time
FROM {{ source( 'sourcelayer','CustomerCreateRaw')}} )


select * from customer_flatten_data