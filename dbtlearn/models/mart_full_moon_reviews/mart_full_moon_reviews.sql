{{ config(
  materialized = 'table',
) }}

WITH fact_reviews AS (
    SELECT * FROM {{ ref('bl_ft_reviews') }}
),
full_moon_dates AS (
    SELECT * FROM {{ ref('full_moon_dates') }}
)

SELECT
  fcr.*,
  CASE
    WHEN fmd.full_moon_date IS NULL THEN 'not full moon'
    ELSE 'full moon'
  END AS is_full_moon
FROM
  fact_reviews
  fcr
  LEFT JOIN full_moon_dates
  fmd
  ON (TO_DATE(fcr.review_date) = DATEADD(DAY, 1, fmd.full_moon_date))