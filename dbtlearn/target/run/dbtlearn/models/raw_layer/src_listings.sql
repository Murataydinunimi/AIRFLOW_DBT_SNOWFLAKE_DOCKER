
  create or replace   view AIRBNB.DEV.src_listings
  
   as (
    with raw_listings as (
    select * from airbnb.raw.raw_listings
)

select id as listing_id,
listing_url,
name as listing_name,
room_type,
minimum_nights,
host_id,
price as price_str,
created_at,
updated_at
from raw_listings
  );

