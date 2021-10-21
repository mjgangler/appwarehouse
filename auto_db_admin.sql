drop package eba_archive;
drop package eba_archive_fw;
 
drop sequence eba_archive_seq;
 
drop table eba_archive_users          cascade constraints;
drop table eba_archive_errors         cascade constraints;
drop table eba_archive_access_levels  cascade constraints;
drop table eba_archive_notifications  cascade constraints;
 
drop table eba_archive_error_lookup;
 
drop table eba_archive_preferences;

select 'drop table '||table_name||' cascade constraints;'
from dba_tables
where owner = 'APPDW'
and table_name like 'EBA_%';

DROPTABLE'||TABLE_NAME||'CASCADECONSTRAINTS;'"
"drop table EBA_DEMO_CAL_PROJECTS cascade constraints;"
"drop table EBA_DEMO_CHART_POPULATION cascade constraints;"
"drop table EBA_DEMO_CAL_SESSIONS cascade constraints;"
"drop table EBA_DEMO_IG_EMP cascade constraints;"
"drop table EBA_DEMO_CHART_STATS cascade constraints;"
"drop table EBA_DEMO_CHART_ORDERS cascade constraints;"
"drop table EBA_DEMO_CHART_BBALL cascade constraints;"
"drop table EBA_DEMO_CHART_PROJECTS cascade constraints;"
"drop table EBA_DEMO_CHART_GRADES cascade constraints;"
"drop table EBA_DEMO_CHART_EMP cascade constraints;"
"drop table EBA_DEMO_CHART_PRODUCTS cascade constraints;"
"drop table EBA_DEMO_CHART_SAMPLES cascade constraints;"
"drop table EBA_DEMO_CHART_SAMPLE_NAMES cascade constraints;"
"drop table EBA_DEMO_IG_DEPT cascade constraints;"
"drop table EBA_DEMO_CHART_DEPT cascade constraints;"
"drop table EBA_DEMO_IG_PEOPLE cascade constraints;"
"drop table EBA_DEMO_CHART_STOCKS cascade constraints;"
"drop table EBA_DEMO_CHART_SAMPLE_DATA cascade constraints;"
"drop table EBA_DEMO_CHART_TASKS cascade constraints;"
"drop table EBA_DEMO_CAL_MYSESSIONS cascade constraints;"


 drop table EBA_DEMO_CAL_PROJECTS cascade constraints; 
 drop table EBA_DEMO_CHART_POPULATION cascade constraints; 
 drop table EBA_DEMO_CAL_SESSIONS cascade constraints; 
 drop table EBA_DEMO_IG_EMP cascade constraints; 
 drop table EBA_DEMO_CHART_STATS cascade constraints; 
 drop table EBA_DEMO_CHART_ORDERS cascade constraints; 
 drop table EBA_DEMO_CHART_BBALL cascade constraints; 
 drop table EBA_DEMO_CHART_PROJECTS cascade constraints; 
 drop table EBA_DEMO_CHART_GRADES cascade constraints; 
 drop table EBA_DEMO_CHART_EMP cascade constraints; 
 drop table EBA_DEMO_CHART_PRODUCTS cascade constraints; 
 drop table EBA_DEMO_CHART_SAMPLES cascade constraints; 
 drop table EBA_DEMO_CHART_SAMPLE_NAMES cascade constraints; 
 drop table EBA_DEMO_IG_DEPT cascade constraints; 
 drop table EBA_DEMO_CHART_DEPT cascade constraints; 
 drop table EBA_DEMO_IG_PEOPLE cascade constraints; 
 drop table EBA_DEMO_CHART_STOCKS cascade constraints; 
 drop table EBA_DEMO_CHART_SAMPLE_DATA cascade constraints; 
 drop table EBA_DEMO_CHART_TASKS cascade constraints; 
 drop table APPDW.EBA_DEMO_CAL_MYSESSIONS cascade constraints; 
 
 
 drop table APPDW.EBA_DEMO_CAL_PROJECTS cascade constraints; 
 drop table APPDW.EBA_DEMO_CHART_POPULATION cascade constraints; 
 drop table APPDW.EBA_DEMO_CAL_SESSIONS cascade constraints; 
 drop table APPDW.EBA_DEMO_IG_EMP cascade constraints; 
 drop table APPDW.EBA_DEMO_CHART_STATS cascade constraints; 
 drop table APPDW.EBA_DEMO_CHART_ORDERS cascade constraints; 
 drop table APPDW.EBA_DEMO_CHART_BBALL cascade constraints; 
 drop table APPDW.EBA_DEMO_CHART_PROJECTS cascade constraints; 
 drop table APPDW.EBA_DEMO_CHART_GRADES cascade constraints; 
 drop table APPDW.EBA_DEMO_CHART_EMP cascade constraints; 
 drop table APPDW.EBA_DEMO_CHART_PRODUCTS cascade constraints; 
 drop table APPDW.EBA_DEMO_CHART_SAMPLES cascade constraints; 
 drop table APPDW.EBA_DEMO_CHART_SAMPLE_NAMES cascade constraints; 
 drop table APPDW.EBA_DEMO_IG_DEPT cascade constraints; 
 drop table APPDW.EBA_DEMO_CHART_DEPT cascade constraints; 
 drop table APPDW.EBA_DEMO_IG_PEOPLE cascade constraints; 
 drop table APPDW.EBA_DEMO_CHART_STOCKS cascade constraints; 
 drop table APPDW.EBA_DEMO_CHART_SAMPLE_DATA cascade constraints; 
 drop table APPDW.EBA_DEMO_CHART_TASKS cascade constraints; 
 drop table APPDW.EBA_DEMO_CAL_MYSESSIONS cascade constraints; 

drop table ARGO_DB_PDB_INFO cascade constraints;
drop table TEST_TABLE1 cascade constraints;
drop table ARGO_DB_PDB_INFO_SAVE cascade constraints;
drop table ARGO_TBS_GROWTH cascade constraints;
drop table ARGO_DB_LTR_BACKUPS cascade constraints;
drop table ARGO_DB_FULL_BACKUPS cascade constraints;
drop table APEX$ARCHIVE_HEADER cascade constraints;
drop table TEST_TABLE1_ERR$ cascade constraints;
drop table ARGO_ORACLE_DB_INCR_BACKUPS cascade constraints;
drop table ARGO_TBS_INFO cascade constraints;
drop table APEX$ARCHIVE_HISTORY cascade constraints;
drop table APEX$ARCHIVE_PREF cascade constraints;
drop table FOO cascade constraints;
drop table ARGO_MACHINES cascade constraints;
drop table FOO2 cascade constraints;
drop table APEX$ARCHIVE_LOG cascade constraints;
drop table M5_DATABASE cascade constraints;
drop table ARGO_PERFORMANCE_INFO cascade constraints;
drop table ARGO_ORACLE_DATABASES cascade constraints;
drop table APEX$ARCHIVE_CONTENTS cascade constraints;
