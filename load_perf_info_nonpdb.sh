#/bin/bash

#set -x
export PDB=$1
#Check for Null answers
#
if [ -z "$PDB" ]
then
  echo "Please enter a valid PDB NAME"
  echo "Correct usage OS>./load_perf_info.sh <db_link_noncdb>"
  exit
fi

export ORACLE_HOME=/u01/app/oracle/product/12.2.0/dbhome_1EE
export ORACLE_SID=<DBSID>
export PATH=$ORACLE_HOME/bin:$PATH
export PERF_LOG=/home/oracle/awh_scripts/logs/perf_noncdb_info.log
export SHORT_HOST=`hostname `
export DESC=" Performance Loading in Host -> ${SHORT_HOST} ${PDB} PERF_NONCDB_INFO"
#export ADMIN_EMAIL="<email>"

$ORACLE_HOME/bin/sqlplus ' -s /nolog as sysdba' << EOF
conn awh_apps_dba/<pwd>@<tnsnames>;
define pdb_name= <pdbname of location of awh data>
alter session set container=&pdb_name;
set serveroutput on;
spool ${PERF_LOG};
@/home/oracle/awh_scripts/awh_performance_nonpdb.sql ${PDB}
commit;
spool off;
exit
EOF
#
# Sending email
  /bin/mail -s "${SHORT_HOST} ${DESC} ${PDB} `date +%m-%d-%y`" ${ADMIN_EMAIL} < ${PERF_LOG} 
