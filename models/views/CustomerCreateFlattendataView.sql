
{{
config( materialized="view",
        schema="flattendatalayer")    
}}
select 
customer_name,
customer_phone,
customer_email,
created_date,
eod_balance,
SUBSTR(customer_phone, 1,3) as country_code_1,
{{ extract_country_code('customer_phone')}} as country_code_2,
{{ concat_list(['customer_phone','customer_name']) }} as newphone,
{{ customer_capping('eod_balance')}} as capping
from {{ ref('CustomerCreateFlattendata')}}