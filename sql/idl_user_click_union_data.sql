DROP TABLE idl_user_click_union_data;

CREATE TABLE idl_user_click_union_data
(uid STRING,
keyword STRING,
keyword_value STRING
)
comment "user info including:emails,occupation,registration,token_t"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

set mapreduce.map.memory.mb=2048;
set mapreduce.map.java.opts=-Xmx1600m;
ALTER TABLE idl_user_click_union_data DROP PARTITION(ds="2017-08-04");
INSERT INTO idl_user_click_union_data PARTITION (ds="2017-08-04")
SELECT
uid,
keyword,
keyword_value
FROM
    (SELECT 
    uid, 
    str_to_map(concat_ws("\073",province_str,head_str,tail_str),"\073","\072") AS keyword_map
    FROM 
        (SELECT
        uid, 
        concat_ws('\072', concat_ws('_','province',CAST(IF(ISNULL(province),'NULL',province) AS STRING)),'1') AS province_str,
        concat_ws('\072', concat_ws('_','head',CAST(IF(ISNULL(head),'NULL',head) AS STRING)),'1') AS head_str,
        concat_ws('\072', concat_ws('_','tail',CAST(IF(ISNULL(tail),'NULL',tail) AS STRING)),'1') AS tail_str
        FROM idl_user_click_data
        WHERE ds="2017-08-04"
        ) t1
   ) t2
LATERAL VIEW OUTER explode(keyword_map) mytable AS keyword,keyword_value
UNION ALL
SELECT
uid,
subroot AS keyword,
'1' AS keyword_value
FROM idl_user_click_data
LATERAL VIEW OUTER explode(subroots) mytable3 as subroot
WHERE ds="2017-08-04";





