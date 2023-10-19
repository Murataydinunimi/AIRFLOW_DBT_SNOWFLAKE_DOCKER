{{ config(
  materialized = 'table'
) }}


with province_extracted as (select *, 
split(listing_title,'·')[0] as province_str,
REGEXP_SUBSTR(province_str, 'IN\\s+(.+)', 1, 1, 'i') AS province_regexp,
upper(REPLACE(split(province_regexp,' ')[1],'""','')) as province
from {{ ref('bl_listings_cleansed') }}
where province != 'ISTANBUL' and province!='İSTANBUL' and province!=''),

review_score_cleaned as (select listing_id,split(listing_title,'·')[1] as review_score_raw,
REPLACE(review_score_raw,'""','') as review_score_no_quotes,
REPLACE(review_score_no_quotes,'★','')as review_score_no_star,
  CASE
    WHEN TRY_CAST(review_score_no_star AS float) IS NOT NULL THEN TRY_CAST(review_score_no_star AS float)
    ELSE NULL
  END AS review_score
from {{ ref('bl_listings_cleansed') }}
where review_score is not null),

 ctes_joined as (select pe.listing_id, pe.listing_title, pe.room_type, pe.MINIMUM_NIGHTS, pe.price, pe.province,rsc.review_score
 from province_extracted pe
 join review_score_cleaned rsc on rsc.listing_id = pe.listing_id)

select province, avg(review_score) as average_review_score, count(*) as total_stay
from ctes_joined
group by province
having total_stay > 10
order by average_review_score desc




