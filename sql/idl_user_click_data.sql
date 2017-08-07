DROP table  idl_user_click_data;
CREATE TABLE if not exists idl_user_click_data
(
uid               STRING,
province          STRING,
head              STRING,
tail              STRING,
subroots          ARRAY<STRING> COMMENT '物品类别'
) 
comment "email domain and its aggregation"
PARTITIONED BY (ds STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE;

set mapreduce.map.memory.mb=2048;
set mapreduce.map.java.opts=-Xmx1600m;
ALTER TABLE idl_user_click_data DROP PARTITION (ds="2017-08-04" );
INSERT INTO idl_user_click_data PARTITION (ds="2017-08-04")
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
    WHERE ds="2017-07-20"
    ) t1
LEFT JOIN
    (SELECT 
    s1.uid,
    collect_set(s2.subroot_name) subroots
    FROM
        (SELECT *
        FROM idl_limao_user_cid_agg
        WHERE ds="2017-06-26"
        ) s1
    LEFT JOIN
        (SELECT *
        FROM idl_limao_cid_tmp
        WHERE ds="2017-06-26"
        ) s2
    ON s1.cid=s2.cid
    WHERE s2.cid IS NOT NULL
    GROUP BY s1.uid
    ) t2
ON t1.uid=t2.uid
WHERE t2.uid IS NOT NULL;