{{
config(
materialized='table',
schema='flattendatalayer')
}}

with actOpt as (
SELECT ao.key as ao_key,ao.value as ao_value,account_id as ao_accountId
 FROM {{ source('rawdatalayer', 'src_accounts_created') }},
 unnest(account_options) as ao
 where ao.key="authorised_overdraft" )

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
FROM {{ source('rawdatalayer', 'src_accounts_created') }} ac
Join actOpt aop on ac.account_id = aop.ao_accountId GROUP BY account_id

