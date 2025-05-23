{{
  config(
    materialized='stream',
    parameters={
      'value.format': 'json',
      'key.format': 'JSON',
      'store': 'trial_store'
    }
  )
}}
SELECT 
    viewtime,  
    contactinfo -> zipcode AS zipcode
FROM {{ ref('csas_enriched_pageviews') }} p