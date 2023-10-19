WITH tl_listings AS (
    SELECT * FROM AIRBNB.DEV.tl_listings
)
SELECT 
  listing_id,
  listing_title,
  room_type,
  CASE
    WHEN minimum_nights = 0 THEN 1
    ELSE minimum_nights
  END AS minimum_nights,
  host_id,
  REPLACE(REPLACE(price_str,'$'),',',''):: NUMBER(10,2) as price,
  created_at,
  updated_at
FROM
  tl_listings