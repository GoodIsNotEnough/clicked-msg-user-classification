drop table tmp_kgs_partitions;

CREATE TABLE tmp_kgs_partitions
(ds  STRING COMMENT 'partition'
)
comment "每个类别的截距"
STORED AS TEXTFILE;

load data local inpath '/data1/shell/data_tool/tmp/tmp_kgs_partitions.csv' 
overwrite into table tmp_kgs_partitions;


select * from tmp_kgs_partitions;