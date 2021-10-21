-- ********************************************************************
-- * Filename           : awh_load_tbs_growth.sql
-- * Author             : Mike Gangler
-- * Last Update        : 11-Feb-21
-- * Description        : load pdb tbs growth items
-- * Usage              : @awh_load_tbs_growth.sql <DBLINK>
-- ********************************************************************
--define dblink=&1
set linesize 200 
set pagesize 100 
set colsep "," 
set echo off feedback off timing off

column tablespace_name format a100
column avg_growth_per_day_mb format 9999.99 heading "AVG GROWTH|PER DAY MB"
column projected_growth_3mo_mb format 9999.99 heading "PROJECTED|GROWTH|FOR 3 MONTHS|MB"
column projected_growth_6mo_mb format 9999.99 heading "PROJECTED|GROWTH|FOR 6 MONTHS|MB"
column projected_growth_1yr_mb format 9999.99 heading "PROJECTED|GROWTH|FOR ONE YEAR|MB"
column msg format a15 heading "ACTION|TO BE TAKEN"
insert into awh_tbs_growth_proj
--create table awh_tbs_growth_proj as
with t1 as (
select  ss.run_time,
        ts.name,
        round(su.tablespace_size*dt.block_size/1024/1024,2) alloc_size_mb,
        round(su.tablespace_usedsize*dt.block_size/1024/1024,2) used_size_mb
 from
      dba_hist_tbspc_space_usage su,
      (select trunc(BEGIN_INTERVAL_TIME) run_time,
      max(snap_id) snap_id 
 from dba_hist_snapshot
 group by trunc(BEGIN_INTERVAL_TIME) ) ss,
      v$tablespace ts,
      dba_tablespaces dt
 where su.snap_id = ss.snap_id
   and su.tablespace_id = ts.ts#
   and ts.name NOT LIKE '%TEMP%'
   and ts.name NOT LIKE '%UNDO%'
   and ts.name = dt.tablespace_name order by 2,1),
t2 as (
 select e.run_time,
        e.name, 
        e.used_size_mb,
        e.used_size_mb - b.used_size_mb growth
   from t1 e, 
        t1 b
  where e.name = b.name 
    and e.run_time = b.run_time +1),
t3 as (
 select --fre.tablespace_name, 
        --fre.alloc,
        --fre.used,
        tsz.name,
        tsz.alloc_size_mb,
        tsz.used_size_mb,
        ave.avg_growth_per_day_mb,
        ave.avg_growth_per_day_mb*90 projected_growth_3mo_mb 
  from
        (select name,
                max(alloc_size_mb) alloc_size_mb, 
                max(used_size_mb) used_size_mb 
           from t1 group by name) tsz,
        (select name,
                round(avg(growth),2) avg_growth_per_day_mb from t2 group by name) ave 
          where tsz.name = ave.name)
select  a.host_name,
        a.instance_name as db_name,
        'Non-PDB' as pdb_name,
        t4.tablespace_name,
        t4.alloc alloc_sz_mb,
        t4.used used_sz_mb,
        --t3.alloc_size_mb
        --t3.used_size_mb
        t3.avg_growth_per_day_mb,
        t3.projected_growth_3mo_mb,
        t4.free free_sz_mb,
        case when t4.free < nvl(projected_growth_3mo_mb,0) then 'ADD SPACE' end MSG, 
        projected_growth_3mo_mb*2 projected_growth_6mo_mb , 
        projected_growth_3mo_mb*4 projected_growth_1yr_mb
 from t3,
      v$instance a,
      (select a.tablespace_name,
       round(a.bytes/1024/1024,2) alloc,
       round(b.bytes/1024/1024,2) used,
       round(c.bytes/1024/1024,2) free
from   sys.sm$ts_avail a,
       sys.sm$ts_used b,
       sys.sm$ts_free c
where 
       a.tablespace_name = b.tablespace_name(+)
       and a.tablespace_name = c.tablespace_name(+)) t4
where  t4.tablespace_name = t3.name(+)
order by 1;
/
