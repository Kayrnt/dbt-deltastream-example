{{
  config(
    materialized='materialized_view'
  )
}}
SELECT
    userid, 
    COUNT(*) AS view_count 
FROM {{ ref('csas_enriched_pv') }}  
GROUP BY userid