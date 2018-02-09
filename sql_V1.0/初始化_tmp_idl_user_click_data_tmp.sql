DROP table  tmp_idl_user_click_data_tmp;
CREATE TABLE if not exists tmp_idl_user_click_data_tmp
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

ALTER TABLE tmp_idl_user_click_data_tmp DROP PARTITION (ds="2017-09-25");
INSERT INTO tmp_idl_user_click_data_tmp PARTITION (ds="2017-09-25")
SELECT 
t1.uid,
t1.province,
t1.head,           
t1.tail,          
t2.subroots   
FROM
    (SELECT
    uid,
    mobile_province AS province,
    substring(mobile_mark,1,3) AS head,
    substring(mobile_mark,-1,1) AS tail
    FROM idl_limao_active_moblie_agg
    WHERE ds="2017-09-25"
    ) t1
LEFT JOIN
    (SELECT 
    uid,
    collect_set(subroot_name) subroots
    FROM idl_limao_user_cidset_agg
    WHERE ds="2017-09-25"
    GROUP BY uid
    ) t2
ON t1.uid=t2.uid
WHERE t2.uid IS NOT NULL;