#/bin/bash

#set -x
export PDB=$1
#Check for Null answers
#
if [ -z "$PDB" ]
then
  echo "Please enter a valid PDB NAME/DBLINK"
  echo "Correct usage OS>./load_tbs_info.sh <ORACLE_PDB>"
  exit
fi

export ORACLE_HOME=/u01/app/oracle/product/12.2.0/dbhome_1EE
export ORACLE_SID=<ORACLE_SID>
export PATH=$ORACLE_HOME/bin:$PATH
export TBS_LOG=/home/oracle/awh_scripts/logs/awh_tbs_nonpdb.log
export SHORT_HOST=`hostname `
export DESC=" TBS Loading in Host -> ${SHORT_HOST} ${PDB} TBS_NONPDB_INFO"
export ADMIN_EMAIL="<email>"

$ORACLE_HOME/bin/sqlplus ' -s /nolog as sysdba' << EOF
conn awh_apps_dba/<PW>@<awhtns>;
define pdb_name= <awh_pdb>
alter session set container=&pdb_name;
set serveroutput on;
spool ${TBS_LOG};
@/home/oracle/awh_scripts/awh_tbs_load_nonpdb.sql ${PDB};
commit;
spool off;
exit
EOF
#
# Sending email
  /bin/mail -s "${SHORT_HOST} ${DESC} ${PDB} `date +%m-%d-%y`" ${ADMIN_EMAIL} < ${TBS_LOG} 
