drop table idl_user_click_raw_score_tmp;
--231504503
CREATE TABLE idl_user_click_raw_score_tmp
(uid   STRING COMMENT 'uid',
score     FLOAT COMMENT  '得分'
)
comment "每个类别的截距"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

set mapreduce.map.memory.mb=2048;
set mapreduce.map.java.opts=-Xmx1600m;
ALTER TABLE idl_user_click_raw_score_tmp DROP PARTITION (ds="2017-08-04" );
INSERT INTO idl_user_click_raw_score_tmp PARTITION (ds="2017-08-04")
SELECT
t3.uid,
EXP(t3.linear_score)/(1+EXP(t3.linear_score)) AS score
FROM 
    (SELECT 
    t1.uid,
    sum(t1.keyword_value*t2.weight) AS linear_score
    FROM
        (SELECT
        uid,
        keyword,
        CAST(IF(ISNULL(keyword_value),0,keyword_value) AS FLOAT) AS keyword_value
        FROM idl_user_click_union_data
        WHERE ds="2017-08-04"
        ) t1
    LEFT JOIN 
        (SELECT s*
        FROM config_user_click_weight_parameter
        )t2
    ON t1.keyword=t2.keyword
    WHERE t2.keyword IS NOT NULL
    GROUP BY t1.uid
    ) t3;

-- 注:实际中keyword_value不会为NULL
SELECT count(uid)
FROM idl_user_click_raw_score_tmp;