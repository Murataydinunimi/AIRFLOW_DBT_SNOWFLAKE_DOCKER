with raw_reviews as (
    select * from airbnb.raw.raw_reviews
)

select  listing_id,
date as review_date,
reviewer_name,
comments as review_text,
sentiment as review_sentiment
from raw_reviews