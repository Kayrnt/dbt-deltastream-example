{{ 
  config(
    materialized='stream'
  ) 
}}

select 
    order_id,
    product_id,
    customer_id,
    50 + RAND_INTEGER(100) as total_price,
    ts as order_timestamp
from {{ ref('shoe_orders') }}