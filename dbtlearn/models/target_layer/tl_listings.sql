with raw_listings as (
    select * from airbnb.raw.raw_listings
)

select id as listing_id,
listing_url,
name as listing_title,
room_type,
minimum_nights,
host_id,
price as price_str,
created_at,
updated_at
from raw_listings