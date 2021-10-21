drop package eba_archive;
drop package eba_archive_fw;
 
drop sequence eba_archive_seq;
 
drop table eba_archive_users          cascade constraints;
drop table eba_archive_errors         cascade constraints;
drop table eba_archive_access_levels  cascade constraints;
drop table eba_archive_notifications  cascade constraints;
 
drop table eba_archive_error_lookup;
 
drop table eba_archive_preferences;
