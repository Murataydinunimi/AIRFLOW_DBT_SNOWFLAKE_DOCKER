
WITH
l AS (
    SELECT
        *
    FROM
        {{ ref('bl_listings_cleansed') }}
),
h AS (
    SELECT * 
    FROM {{ ref('bl_hosts_cleansed') }}
)

SELECT 
    l.listing_id,
    l.listing_title,
    l.room_type,
    l.minimum_nights,
    l.price,
    l.host_id,
    h.title_name,
    h.is_superhost as host_is_superhost,
    l.created_at,
    GREATEST(l.updated_at, h.updated_at) as updated_at
FROM l
LEFT JOIN h ON (h.host_id = l.host_id)