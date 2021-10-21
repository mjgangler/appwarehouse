drop table awh_performance_info
/
create table awh_performance_info
(machine_name  varchar2(30) not null,
 db_name       varchar2(10) not null,
 pdb_name      varchar2(32) not null,
sid            number(5),
user_name      varchar2(10),
stime_min      number(15),
scpu_sec       number(15),
spio_k         number(15),
slio_k         number(15),
sredo_mb       number(9),
sqladdress     varchar2(20),
pio_k          number(15),
lio_m          number(9),
rows_ka        number(9),
cpu_min        number(15),
etime_min      number(15),
pio_time_sec   number(15),
lio_time_sec   number(15),
executions     number(15),
stmt_type      varchar2(10),
load           number(15),
upload_time	date not null
)
