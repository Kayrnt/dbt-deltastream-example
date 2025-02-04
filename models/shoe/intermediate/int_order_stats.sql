{{
  config(
    materialized='ephemeral'
  )
}}

SELECT 
    window_start,
    window_end,
    o.customer_id,
    COUNT(order_id) as order_count,
    SUM(total_price) as total_order_value
FROM TUMBLE({{ ref('stg_shoe_orders') }} o, INTERVAL 1 HOUR)
GROUP BY window_start, window_end, customer_id
