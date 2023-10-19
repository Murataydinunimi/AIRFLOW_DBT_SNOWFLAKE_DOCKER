{{
  config(
    materialized = 'incremental',
    on_schema_change='fail'
    )
}}
WITH tl_reviews AS (
  SELECT * FROM {{ ref('tl_reviews') }}
)
SELECT  *
FROM tl_reviews
WHERE review_text is not null
{% if is_incremental() %}
  AND review_date > (select max(review_date) from {{ this }})
{% endif %}