{{ 
  config(
    materialized='materialized_view'
  ) 
}}
select 
    clicks.product_id,
    count(distinct clicks.user_id) as unique_views,
    count(distinct orders.order_id) as total_orders,
    round(count(distinct orders.order_id) * 100.0 / nullif(count(distinct clicks.user_id), 0), 2) as conversion_rate
from {{ ref('stg_shoe_clickstream') }} clicks
left join {{ ref('stg_shoe_orders') }} orders on clicks.product_id = orders.product_id
group by clicks.product_id