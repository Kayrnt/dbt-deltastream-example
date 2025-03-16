{{
  config(
    materialized='table',
    parameters={
      'store': 'postgres_cluster', 
      'value.format': 'json',
      'postgresql.db.name': 'db',
      'postgresql.schema.name': 'public',
      'postgresql.table.name': 'pageviews'
    }
    
  )
}}
SELECT *
FROM {{ ref('user_view_count') }}
WHERE userid = 'User_2'