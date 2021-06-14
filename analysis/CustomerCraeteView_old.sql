

select 
customer.phone,
customer.isActive,
customer.email,
customer.gender
from {{source('sourcelayer', 'CustomerCreateRaw')}}