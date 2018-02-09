-- idl_user_click_data_tmp
DROP TABLE idl_user_click_data_tmp;
CREATE TABLE if not exists idl_user_click_data_tmp
(
uid               STRING,
province          STRING,
head              STRING,
tail              STRING,
subroots          ARRAY<STRING> COMMENT '物品类别'
) 
comment "tel and its subroots"
PARTITIONED BY (ds STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE;

-- idl_user_click_union_data_tmp
DROP TABLE idl_user_click_union_data_tmp;
CREATE TABLE idl_user_click_union_data_tmp
(
uid            STRING,
keyword         STRING,
keyword_value   STRING
)
comment "tels info and subroots"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

-- idl_user_click_score_tmp
DROP TABLE idl_user_click_score_tmp;
CREATE TABLE idl_user_click_score_tmp
(
uid       STRING COMMENT 'uid',
score     FLOAT COMMENT  '得分'
)
comment "tmp_score"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;