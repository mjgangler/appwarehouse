drop table awh_tbs_info
/
create table awh_tbs_info
(machine_name  varchar2(30) not null,
 db_name       varchar2(10) not null,
 pdb_name      varchar2(32) not null,
tbspace_name varchar2(100)  not null,
tbs_allocated  number(15),
tbs_space_used  number(15),
tbs_space_free  number(15),
tbs_free_pct    number(3),
tbs_used_pct    number(3),
upload_time	date not null
)
