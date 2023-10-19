
  
    

        create or replace transient table AIRBNB.DEV.bl_hosts_cleansed
         as
        (WITH tl_hosts AS (
    SELECT
        *
    FROM
        AIRBNB.DEV.tl_hosts
)
SELECT
    host_id,
    NVL(
        title_name,
        'Anonymous'
    ) AS title_name,
    is_superhost,
    created_at,
    updated_at
FROM
    tl_hosts
        );
      
  