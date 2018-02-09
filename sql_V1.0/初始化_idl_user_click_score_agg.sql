drop table idl_user_click_score_agg;
CREATE TABLE idl_user_click_score_agg
(
uid       STRING COMMENT 'uid',
score     FLOAT COMMENT  '得分'
)
comment "score"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

ALTER TABLE idl_user_click_score_agg DROP PARTITION (ds="2017-09-25" );
INSERT INTO idl_user_click_score_agg PARTITION (ds="2017-09-25")
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
        FROM tmp_idl_user_click_union_data_tmp
        WHERE ds="2017-09-25"
        ) t1
    LEFT JOIN config_user_click_weight_parameter t2
    ON t1.keyword=t2.keyword
    WHERE t2.keyword IS NOT NULL
    GROUP BY t1.uid
    ) t3;