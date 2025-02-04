{{ 
  config(
    materialized='materialized_view'
  ) 
}}

SELECT 
    s.window_start,
    s.window_end,
    c.country,
    SUM(s.order_count) as order_count,
    SUM(s.total_order_value) as total_order_value
FROM {{ ref('int_order_stats') }} s
JOIN {{ ref('shoe_customers') }} c ON s.customer_id = c.id
GROUP BY s.window_start, s.window_end, c.country
