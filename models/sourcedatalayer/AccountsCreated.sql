{{
config(
materialized='table',
schema='flattendatalayer')
}}

 

with actOpt as (
SELECT ao.key as ao_key,ao.value as ao_value,account_id as ao_accountId
 FROM {{ source('rawdatalayer', 'src_accounts_created') }},
 unnest(account_options) as ao
 where ao.key="authorised_overdraft" ),

customer_info as (
  select distinct customer_id 
  from {{ source('flattendatalayer','CustomersCreated')}}),

product_info as (
  select distinct product_id
  from {{ source ('flattendatalayer','ProductsCreated')}}),

account_info as (
SELECT
      account_id
      , ARRAY_AGG(product_name IGNORE NULLS ORDER BY account_updated DESC)[OFFSET(0)] AS product_name
      , ARRAY_AGG(account_status IGNORE NULLS ORDER BY account_updated DESC)[OFFSET(0)] AS account_status
      , ARRAY_AGG(nick_name IGNORE NULLS ORDER BY account_updated DESC)[OFFSET(0)] AS nick_name
      , ARRAY_CONCAT_AGG(stakeholder_id)[Offset(0)] as stakeholder_id
      , ARRAY_CONCAT_AGG(permitted_denominations)[Offset (0)] AS permitted_denominations
      , MAX(account_created) AS account_created
      , ARRAY_AGG(product_id IGNORE NULLS ORDER BY account_updated DESC)[OFFSET(0)] AS product_id
      , ARRAY_AGG(product_version_id IGNORE NULLS ORDER BY account_updated DESC)[OFFSET(0)] AS  product_version_id
      , ARRAY_AGG(statement_frequency IGNORE NULLS ORDER BY account_updated DESC)[OFFSET(0)] AS statement_frequency
      , ARRAY_AGG(tside IGNORE NULLS ORDER BY account_updated DESC)[OFFSET(0)] AS tside
      , MAX(opening_time) AS opening_time
      , MAX(account_updated) AS account_updated
      , ARRAY_AGG(aop.ao_value IGNORE NULLS ORDER BY account_updated DESC)[OFFSET(0)] as authorised_overdraft
FROM {{ source('rawdatalayer', 'src_accounts_created') }} account_info
Join actOpt aop on account_info.account_id = aop.ao_accountId 
GROUP BY account_id)

SELECT  
account_id
,product_name
,account_status
,nick_name
,stakeholder_id
,permitted_denominations
,account_created
,account_info.product_id
,product_version_id
,statement_frequency
,tside
,opening_time
,account_updated
,authorised_overdraft
from account_info 
inner join customer_info on customer_info.customer_id = account_info.stakeholder_id
inner join product_info on product_info.product_id = account_info.product_id
