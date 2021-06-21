


select product_id,count(1) cnt
from {{ ref('dim_products')}}
where default_currency <> 'GBP' 
group by product_id