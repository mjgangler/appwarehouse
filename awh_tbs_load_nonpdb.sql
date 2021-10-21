# Took script from Tim Hall and modified it for the app warehouse
-- -----------------------------------------------------------------------------------
-- File Name    : http://www.oracle-base.com/dba/monitoring/ts_free_space.sql
-- Author       : Tim Hall
-- Description  : Displays a list of tablespaces and their used/full status.
-- Requirements : Access to the DBA views.
-- Call Syntax  : @ts_free_space.sql
-- Last Modified: 13-OCT-2012 - Created. Based on ts_full.sql
-- -----------------------------------------------------------------------------------
--SET LINESIZE 200
--SET PAGESIZE 140
define dblink=&1

insert into awh_tbs_info a
SELECT 
a.host_name as machine_name ,
a.instance_name as db_name,
'non-pdb' as pdb_name,
tablespace_name,
       size_mb as tbs_allocated,
       size_mb - free_mb "tbs_space_used",
       free_mb as tbs_space_free,
       TRUNC((max_free_mb/max_size_mb) * 100) AS tbs_free_pct,
       TRUNC(((max_size_mb-max_free_mb)/max_size_mb) * 100) AS tbs_used_pct,
       systimestamp as upload_time
FROM   (
        SELECT a.tablespace_name,
               b.size_mb,
               a.free_mb,
               b.max_size_mb,
               a.free_mb + (b.max_size_mb - b.size_mb) AS max_free_mb
        FROM   (SELECT tablespace_name,
                       TRUNC(SUM(bytes)/1024/1024) AS free_mb
                FROM   dba_free_space@&dblink
                GROUP BY tablespace_name) a,
               (SELECT tablespace_name,
                       TRUNC(SUM(bytes)/1024/1024) AS size_mb,
                       TRUNC(SUM(GREATEST(bytes,maxbytes))/1024/1024) AS max_size_mb
                FROM   dba_data_files@&dblink
                GROUP BY tablespace_name) b
        WHERE  a.tablespace_name = b.tablespace_name
       ), 
v$instance@&dblink a
ORDER BY tablespace_name;

