insert overwrite local directory '/home/kangguosheng/tmp'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE
select *
from tmp_kgs_user_click_keyword
WHERE isclick='1'
order by rand()
limit 8000;

insert overwrite local directory '/home/kangguosheng/tmp'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '\073'
MAP KEYS TERMINATED BY '\072'
STORED AS TEXTFILE
select *
from tmp_kgs_user_click_keyword
WHERE isclick='0'
order by rand()
limit 70000;