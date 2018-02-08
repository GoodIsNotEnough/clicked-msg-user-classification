DROP TABLE tmp_idl_user_click_union_data_tmp;
CREATE TABLE tmp_idl_user_click_union_data_tmp
(
uid            STRING,
keyword         STRING,
keyword_value   STRING
)
comment "tels info and subroots"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

ALTER TABLE tmp_idl_user_click_union_data_tmp DROP PARTITION(ds="2017-09-25");
INSERT INTO tmp_idl_user_click_union_data_tmp PARTITION (ds="2017-09-25")
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
        FROM tmp_idl_user_click_data_tmp
        WHERE ds="2017-09-25"
        ) t1
   ) t2
LATERAL VIEW OUTER explode(keyword_map) mytable1 AS keyword,keyword_value
UNION ALL
SELECT
uid,
subroot AS keyword,
'1' AS keyword_value
FROM tmp_idl_user_click_data_tmp
LATERAL VIEW OUTER explode(subroots) mytable2 as subroot
WHERE ds="2017-09-25";





