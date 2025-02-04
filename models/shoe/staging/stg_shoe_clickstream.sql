{{ 
  config(
    materialized='stream',
    parameters={
        'value.format': 'avro',
    }
  )
}}

select 
    product_id,
    user_id,
    view_time,
    page_url,
    ip,
    ts as view_timestamp
from {{ ref('shoe_clickstream') }}