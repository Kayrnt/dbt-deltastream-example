{{
    config(
        materialized='table'
    )
}}

WITH windowed_data AS (
    SELECT 
        date_trunc('minute', viewtime) as minute,
        zipcode,
        COUNT(*) as views_in_minute
    FROM {{ ref('csas_zipcode_pageviews') }}
    GROUP BY 
        date_trunc('minute', viewtime),
        zipcode
)

SELECT 
    minute,
    zipcode,
    views_in_minute,
    SUM(views_in_minute) OVER (
        PARTITION BY zipcode 
        ORDER BY minute 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as cumulative_views
FROM windowed_data
ORDER BY minute, zipcode