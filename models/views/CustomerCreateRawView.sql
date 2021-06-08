
select 
customer.phone,
balance,
customer.isActive,
company
from {{source('sourcelayer', 'CustomerCreateRaw')}}