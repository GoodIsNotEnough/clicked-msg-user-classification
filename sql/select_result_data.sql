insert overwrite local directory '/home/kangguosheng/tmp'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE
SELECT
t1.isclick,
t2.score
FROM tmp_kgs_user_click_tmp t1
LEFT JOIN tmp_kgs_user_click_raw_score_tmp t2
ON t1.uid=t2.uid
WHERE t2.uid IS NOT NULL
ORDER BY t2.score;