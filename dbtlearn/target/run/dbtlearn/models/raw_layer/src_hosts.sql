
  create or replace   view AIRBNB.DEV.src_hosts
  
   as (
    WITH raw_hosts AS (
    SELECT
        *
    FROM airbnb.raw.raw_hosts
)
SELECT
    id AS host_id,
    NAME AS host_name,
    is_superhost,
    created_at,
    updated_at
FROM
    raw_hosts
  );

