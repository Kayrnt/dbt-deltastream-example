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
  COUNT(*) AS pageviews
FROM HOP ({{ ref('csas_zipcode_pageviews') }}, SIZE 1 minute, ADVANCE BY 30 second)
WITH ('timestamp'='viewtime')
GROUP BY window_start, window_end, zipcode