DROP TABLE tmp_kgs_mobile_data;
CREATE TABLE tmp_kgs_mobile_data
(
mobile_no string,
isclick string
)
comment "user age"
PARTITIONED BY (ds STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

INSERT INTO tmp_kgs_mobile_data PARTITION (ds)
SELECT
t3.mobile_no,
IF(ISNULL(t4.mobile_no),'0','1') AS isclick,
t3.ds
FROM
    (SELECT 
    t1.mobile_no,
    t1.ds
    FROM tmp_yangjun_sended_tmp t1
    LEFT JOIN tmp_kgs_partitions t2
    ON t1.ds=t2.ds
    WHERE t2.ds IS NOT NULL
    ) t3
LEFT JOIN tmp_yangjun_clicked_tmp t4
ON t3.mobile_no=t4.mobile_no;

select count(1) -- 1095938
from tmp_kgs_mobile_data;

select --76
count(distinct ds)
from tmp_kgs_mobile_data;

select count(1) --9449
from tmp_kgs_mobile_data
WHERE isclick='1';

tmp_kgs_mobile_data01
idl_limao_active_moblie_agg


