impdp admin/5q94dwE1r1sq@db202104071520_high \ 
directory=data_pump_dir \
credential=ATPCS_CRED \
parallel=1 \
remap_tablespace=APEX_1600609104228780 \
partition_options=merge \
exclude=cluster,db_files
