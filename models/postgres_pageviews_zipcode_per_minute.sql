{{
  config(
    materialized='table',
    parameters={
      'store': 'postgres_cluster', 
      'postgresql.db.name': 'db',
      'postgresql.schema.name': 'deltastream_example',
      'postgresql.table.name': 'postgres_pageviews_zipcode_per_minute'
    }
    
  )
}}
SELECT 
window_start, 
window_end,
zipcode, 
pageviews
FROM {{ ref('deltastream_pageviews_zipcode_per_minute') }}