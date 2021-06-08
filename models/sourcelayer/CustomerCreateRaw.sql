select 
cutomer.phone,
balance,
cutomer.isActive,
company

from {{source('Sorucelayer', 'CustomerCreateRaw')}}