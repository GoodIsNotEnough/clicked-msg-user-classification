ALTER TABLE idl_user_click_data_tmp DROP PARTITION (ds="{p0}");
INSERT INTO idl_user_click_data_tmp PARTITION (ds="{p0}")
SELECT 
t1.uid,
t1.province,
t1.head,           
t1.tail,          
t2.subroots   
FROM
    (SELECT
    user_id AS uid,
    mobile_province AS province,
    substring(moblie_mark,1,3) AS head,
    substring(moblie_mark,-1,1) AS tail
    FROM odl_user_log
    WHERE ds="{p0}"
    ) t1
LEFT JOIN
    (SELECT
    uid,
    collect_set(subroot_name) subroots
    FROM idl_limao_user_cidset_tmp
    WHERE ds="{p0}"
    GROUP BY uid
    ) t2
ON t1.uid=t2.uid
WHERE t2.uid IS NOT NULL;