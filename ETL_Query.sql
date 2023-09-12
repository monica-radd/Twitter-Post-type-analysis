--POST_TYPE FIELD CREATION
create table test_schema."Post_Type_Analysis"
as
select 
post_date,
entity_id,
followers,
case when is_picture='True' then 'Picture'
     when is_video='True' then 'Video'
	 when is_picture='False' and is_video='False' then 'Text' end as Post_type,
video_duration_secs,
impressions,
likes,
shares,
replies,
engagement_rate
from test_schema."TEMP_Post_Type_Analysis";