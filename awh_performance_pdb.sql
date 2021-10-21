-- This script was taken from Craig and modified for the application
-- ********************************************************************
-- * Copyright Notice   : (c)2000-2004 OraPub, Inc.
-- * Filename		: tp.sql
-- * Author		: Craig A. Shallahamer
-- * Original		: 17-NOV-00
-- * Last Update	: 13-mar-06
-- * Description	: Top Oracle Processes
-- * Usage		: start tp.sql
-- ********************************************************************

--##set feedback off head on echo off

--set verify off feedback off head on echo off
define dblink=&1

col sidx	format       9999	heading 'SID'
col uname	format         a8	heading 'Oracle|User Name' trunc
col timex	format       9999	heading 'STime|(min)'
col scpu	format       9990	heading 'SCPU|(sec)'
col pio		format       999,999,999,9990	heading 'SPIO|(k)'
col lio		format       9990	heading 'SLIO|(m)'
col rs		format       9990	heading 'SRedo|(MB)'
col rss		format       9990	heading 'SRSS|(MB)'
col sa		format        a16	heading 'SQL Address'
col dr		format       999,999,999,990 heading 'PIO|(k)'
col bg		format       9990 	heading 'LIO|(m)'
col rowx	format       9990	heading 'Rows|(k)'
col load	noprint
col pio_time    heading 'Sec/|PIO'               format          9,999,990.00 
col lio_time    heading 'Sec/|LIO'               format          9,999,990.00 
col exe_time    heading 'Sec/|EXE'               format          9,999,990.00
col cpu         heading 'CPU|(min)'        format           9,999,999,990
col etime       heading 'ETime|(min)'        format         9,999,999,990
col stype       heading 'Stmt|Type'             format      a4
col exe         heading 'Exes'                   format     9,999,999,990

insert into  awh_performance_info
select
  a.host_name as machine_name,
  a.instance_name as db_name,
  c.name as pdb_name,
  s.sid			sidx,
  s.username		uname,
  (sysdate-s.logon_time)*24*60 timex,
  (t2.value)/100	scpu,
  sio.physical_reads/1000 			pio,
  (sio.block_gets+sio.consistent_gets)/1000/1000 	lio,
  t1.value/1024/1024	rs,
  s.sql_address		sa,
  q.disk_reads/1000	dr,
  q.buffer_gets/1000/1000	bg,
  q.rows_processed/1000	rowx,
  q.cpu_time/1000000/60           cpu,
  q.elapsed_time/1000000/60       etime,
  (q.elapsed_time/1000000)/(q.disk_reads+0.00000001)      pio_time,
  (q.elapsed_time/1000000)/(q.buffer_gets+0.00000001)     lio_time,
  q.executions                    exe,
  substr(q.sql_text,1,10)                  stype,
  q.disk_reads*10+q.buffer_gets load,
  systimestamp as upload_time
from
  v$session@&dblink s,
  v$sqlarea@&dblink q,
  v$sesstat@&dblink t1,
  v$sesstat@&dblink t2,
  v$sesstat@&dblink t4,
  v$sess_io@&dblink sio,
  --v$transaction r,
  v$pdbs@&dblink c,
  v$instance@&dblink a
where
  s.sql_address = q.address and
  s.sid         = t1.sid and
  s.sid         = t2.sid and
  s.sid         = t4.sid and
  t1.statistic# = 133 and  -- redo size (10g only, 9i is 115)
  t2.statistic# = 12  and  -- CPU used by this session
  t4.statistic# = 318 and  -- OS Maximum resident set size
  s.sid         = sio.sid 
  --t2.value                                   >= nvl('zcpu',0) and
  --sio.physical_reads/1024                    >= nvl('zpio',0) and
  --(sio.block_gets+sio.consistent_gets)/1024/1024  >= nvl('zlio',0) and
  --q.disk_reads/1024                          >= nvl('qpio',0) and
  --q.buffer_gets/1024/1024                    >= nvl('qlio',0)
order by
  load desc
/
