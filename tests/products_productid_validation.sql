


select product_id, count(1) cnt
from {{ ref('dim_products')}}
where product_id <> '89' and display_name <> 'Overdraft Account'
group by product_id