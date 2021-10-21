#/bin/bash
#set -x
export PDB=$1
#Check for Null answers
#
if [ -z "$PDB" ]
then
  echo "Please enter a valid PDB NAME/DBLINK""
  echo "Correct usage OS>./load_tbs_info.sh <ORACLE_PDB>"
  exit
fi

export ORACLE_HOME=/u01/app/oracle/product/12.2.0/dbhome_1EE
export ORACLE_SID=<ORACLE_SID>
export PATH=$ORACLE_HOME/bin:$PATH
export TBS_LOG=/home/oracle/awh_scripts/logs/tbs_pdb_load.log
export SHORT_HOST=`hostname `
export DESC=" TBS Loading in Host -> ${SHORT_HOST} ${PDB} TBS_INFO"
export ADMIN_EMAIL="<EMAIL>"

$ORACLE_HOME/bin/sqlplus ' -s /nolog as sysdba' << EOF
conn awh_apps_dba/<PW>@<AWH_TNS>;
define pdb_name= <AWH_PDB>
alter session set container=&pdb_name;
set serveroutput on;
spool ${TBS_LOG};
@/home/oracle/awh_scripts/awh_tbs_load_pdb.sql ${PDB};
commit;
spool off;
exit
EOF
#
# Sending email
  /bin/mail -s "${SHORT_HOST} ${DESC} ${PDB} `date +%m-%d-%y`" ${ADMIN_EMAIL} < ${TBS_LOG} 
