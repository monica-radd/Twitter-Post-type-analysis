##   POST_TYPE FIELD CREATION
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

##   CHECKING FOR ANAMOLIES... 
select * from test_schema."Post_Type_Analysis"
where video_duration_secs is not null;

##   TO FIND WHTHER EACH ROW REPRESENT A UNIQUE POST
select post_date,entity_id,count(*) from test_schema."Post_Type_Analysis"
group by post_date,entity_id;

select post_date,entity_id,engagement_rate,count(*) from test_schema."Post_Type_Analysis"
group by post_date,entity_id,engagement_rate
having count(*) > 1;
##  	"2020-08-08 23:12:00"	"4A3372EBDC9C484AA8503A96CD14B858"	2;
##		"2020-08-05 09:49:00"	"4A3372EBDC9C484AA8503A96CD14B858"	0.00000208	2

select post_date,entity_id,count(*) from test_schema."Post_Type_Analysis"
group by post_date,entity_id
having count(*) > 1;

select * from test_schema."Post_Type_Analysis"
where entity_id = '4A3372EBDC9C484AA8503A96CD14B858' and post_date = '2020-08-08 23:12:00'

select * from test_schema."Post_Type_Analysis"
where entity_id = '4A3372EBDC9C484AA8503A96CD14B858' and post_date = '2020-08-05 09:49:00'
##		THIS SHOWS TWEETS SOMETIMES POSTS MORE THAN ONCE AT THE SAME TIME

SELECT * FROM test_schema."Post_Type_Analysis" WHERE engagement_rate is null

##		ANALYSIS

select post_type,avg(engagement_rate)as engagement_rate,avg(impressions)as impressions,count(*) 
from test_schema."Post_Type_Analysis"
group by post_type
order by engagement_rate desc;

##		CTR BY POST TYPE
Select post_type, avg(ctr) as ctr
from
(
Select
	post_type,
(likes+shares+replies) as engagements,
impressions ,
	(likes+shares+replies)/impressions as ctr
	from 
test_schema."Post_Type_Analysis"
)a
group by post_type;
##		OVERALL CTR
Select  avg(ctr) as ctr
from
(
Select
	post_type,
(likes+shares+replies) as engagements,
impressions ,
	(likes+shares+replies)/impressions as ctr
	from 
test_schema."Post_Type_Analysis"
)a
; --OVERALL CTR = 0.003478270745358512725736

##  	OVERALL AVG ENGAGEMENT RATE
Select  avg(engagement_rate) from 
test_schema."Post_Type_Analysis" 
##		 overall avg engagement_rate = 0.00099193809259626181


##		OVERALL AVG IMPRESSIONS
select avg(impressions) from 
test_schema."Post_Type_Analysis" 
##		overall avg Impressions = 196373.589084816553




