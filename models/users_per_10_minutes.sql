{{
    config(
        materialized='table'
    )
}}

WITH windowed_data AS (
    SELECT 
        date_trunc('10 minutes', viewtime) as ten_minute_window,
        zipcode,
        COUNT(DISTINCT user_id) as distinct_users_in_10_minutes
    FROM {{ ref('csas_zipcode_pageviews') }}
    GROUP BY 
        date_trunc('10 minutes', viewtime),
        zipcode
)

SELECT 
    ten_minute_window,
    zipcode,
    distinct_users_in_10_minutes,
    SUM(distinct_users_in_10_minutes) OVER (
        PARTITION BY zipcode 
        ORDER BY ten_minute_window 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as cumulative_distinct_users
FROM windowed_data
ORDER BY ten_minute_window, zipcode