
WITH tl_reviews AS (
  SELECT * FROM AIRBNB.DEV.tl_reviews
)
SELECT  *
FROM tl_reviews
WHERE review_text is not null

  AND review_date > (select max(review_date) from AIRBNB.DEV.bl_ft_reviews)
