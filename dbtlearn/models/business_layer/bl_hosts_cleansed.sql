
WITH tl_hosts AS (
    SELECT
        *
    FROM
        {{ ref('tl_hosts') }}
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
