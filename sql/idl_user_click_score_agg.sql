ALTER TABLE idl_user_click_score_agg DROP PARTITION(ds <= "{p3}" );
ALTER TABLE idl_user_click_score_agg DROP PARTITION(ds = "{p0}" );

INSERT INTO idl_user_click_score_agg PARTITION (ds="{p0}")
SELECT
uid,
score
FROM idl_user_click_score_tmp
WHERE ds = "{p0}"
UNION ALL
SELECT
t0.uid,
t0.score
FROM 
    (SELECT * 
    FROM idl_user_click_score_agg
    WHERE ds = "{p2}"
    ) t0
LEFT JOIN 
    (SELECT * 
    FROM idl_user_click_score_tmp
    WHERE ds = "{p0}"
    ) t1
ON t0.uid=t1.uid
WHERE t1.uid IS NULL;