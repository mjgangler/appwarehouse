CREATE OR REPLACE FORCE EDITIONABLE VIEW "ADMIN"."ARGO_MACHINE_DB" ("VIRTUALIZATION_HOST", "ENVIRONMENT", "NAME", "CPU_CORE_COUNT", "OPERATING_SYSTEM", "CLASS", "IP_ADDRESS", "DB_NAME", "DB_VERSION", "MACHINE_TZ", "MACHINE_MEMORY", "DB_MEMORY") AS 
  select distinct virtualization_host, environment, a.name, cpu_core_count, 
operating_system, class, ip_address,  b.db_name, b.db_version,
machine_tz, ram__mb_, sga__g_
from argo_machines a, argo_oracle_databases b
where a.name = b.name;
