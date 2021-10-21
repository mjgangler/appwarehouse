impdp admin/5q94dwE1r1sq@db202104071520_high \ 
directory=data_pump_dir \
credential=ATPCS_CRED \
DUMPFILE=https://objectstorage.us-ashburn-1.oraclecloud.com/p/ou6QoUdZZQvVJaTpM6C-oJIU07-C7rRTT4wwf5mfAa4fbGl7zZrIc6ziO_kDwj6f/n/idcnpoqs6gpf/b/imports/o/apex_admin.dmp \
parallel=1 \
remap_tablespace=APEX_1600609104228780 \
partition_options=merge \
exclude=cluster,db_files
