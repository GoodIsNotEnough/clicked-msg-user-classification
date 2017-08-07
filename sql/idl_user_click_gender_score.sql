DROP TABLE idl_user_click_gender_score;

CREATE TABLE idl_user_click_gender_score
(uid STRING,
gender STRING,
score FLOAT COMMENT  '得分'
)
comment "user info including:emails,occupation,registration,token_t"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

set mapreduce.map.memory.mb=2048;
set mapreduce.map.java.opts=-Xmx1600m;
ALTER TABLE idl_user_click_gender_score DROP PARTITION (ds="2017-08-04" );
INSERT INTO idl_user_click_gender_score PARTITION (ds="2017-08-04")
SELECT
t1.uid,
t2.gender,
t1.score
FROM
    (SELECT *
    FROM idl_user_click_raw_score_tmp
    WHERE ds="2017-08-04"
    ) t1
LEFT JOIN adl_message_source_data_agg t2
ON t1.uid=t2.mobile_no
WHERE t2.mobile_no IS NOT NULL;

select count(1) --227776387 231504503-227776387=3728116
from idl_user_click_gender_score;