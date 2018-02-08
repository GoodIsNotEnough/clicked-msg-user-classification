-- idl_user_click_data_tmp
-- idl_user_click_union_data_tmp
-- idl_user_click_score_tmp
-- idl_user_click_score_agg

-- task配置
-- idl_user_click_data_tmp
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_user_click_data_tmp",
     "./task_file/click_daily/idl_user_click_data_tmp.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_user_click_data_tmp",
    "idl_user_click_data_tmp",
     0,
     now()); 
-- INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
-- VALUES("idl_user_click_data_tmp",
    -- "odl_user_log",
     -- now());  
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_user_click_data_tmp",
    "idl_limao_user_cidset_tmp",
     now());  
     
-- idl_user_click_union_data_tmp
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_user_click_union_data_tmp",
     "./task_file/click_daily/idl_user_click_union_data_tmp.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_user_click_union_data_tmp",
    "idl_user_click_union_data_tmp",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_user_click_union_data_tmp",
    "idl_user_click_data_tmp",
     now());  
     
-- idl_user_click_score_tmp
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_user_click_score_tmp",
     "./task_file/click_daily/idl_user_click_score_tmp.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_user_click_score_tmp",
    "idl_user_click_score_tmp",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_user_click_score_tmp",
    "idl_user_click_union_data_tmp",
     now());  

-- idl_user_click_score_agg
INSERT INTO config_task_log(task_name,file_path,insertdt,updatedt,connect_type,task_type,outtimes)
VALUES ("idl_user_click_score_agg",
     "./task_file/click_daily/idl_user_click_score_agg.sql",
      now(),
      now(),
     "hive_f",
     "daily",
     "03:00:00");
INSERT INTO config_taregt_log(task_name,target_obj,is_chack,updatedt)
VALUES("idl_user_click_score_agg",
    "idl_user_click_score_agg",
     0,
     now());
INSERT INTO config_rely_log(task_name,parent_obj,updatedt)
VALUES("idl_user_click_score_agg",
    "idl_user_click_score_tmp",
     now()); 
     
-----------------------------------------------------------------------------------     
-- job配置
INSERT INTO plan_job_config (job_name,job_type,PARAMETER,par_end,PARALLEL,begin_time,insertdt,updatedt,job_status,is_debug)
VALUES ("click_daily",
     "daily",
     "2017-08-30",
     "2017-01-01",
      2,
     "00:00:00",
      now(),
      now(),
      0,
      1);
-- idl_user_click_data_tmp
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("click_daily",
    "idl_user_click_data_tmp",
     now());
-- idl_user_click_union_data_tmp
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("click_daily",
    "idl_user_click_union_data_tmp",
     now());
-- idl_user_click_score_tmp
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("click_daily",
    "idl_user_click_score_tmp",
     now());
-- idl_user_click_score_agg
INSERT INTO plan_orltask_log(job_name,task_name,insertdt)
VALUES("click_daily",
    "idl_user_click_score_agg",
     now());