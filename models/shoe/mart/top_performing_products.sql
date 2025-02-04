{{ 
  config(
    materialized='table'
  ) 
}}

select 
    product_id,
    unique_views,
    total_orders,
    conversion_rate
from {{ ref('int_product_performance') }}
order by conversion_rate desc
limit 10