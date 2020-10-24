SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool F:\ProfessialApp\oracle\admin\library\scripts\postDBCreation.log append
select 'utl_recomp_begin: ' || to_char(sysdate, 'HH:MI:SS') from dual;
execute utl_recomp.recomp_serial();
select 'utl_recomp_end: ' || to_char(sysdate, 'HH:MI:SS') from dual;
execute dbms_swrf_internal.cleanup_database(cleanup_local => FALSE);
commit;
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
create spfile='F:\ProfessialApp\oracle\product\11.2.0\dbhome_1\database\spfilelibrary.ora' FROM pfile='F:\ProfessialApp\oracle\admin\library\scripts\init.ora';
shutdown immediate;
connect "SYS"/"&&sysPassword" as SYSDBA
startup ;
host F:\ProfessialApp\oracle\product\11.2.0\dbhome_1\bin\emca.bat -config dbcontrol db -silent -DB_UNIQUE_NAME library -PORT 1621 -EM_HOME F:\ProfessialApp\oracle\product\11.2.0\dbhome_1 -LISTENER LISTENER_ORCLTEST -SERVICE_NAME library -SID library -ORACLE_HOME F:\ProfessialApp\oracle\product\11.2.0\dbhome_1 -HOST DESKTOP-SKTLULO -LISTENER_OH F:\ProfessialApp\oracle\product\11.2.0\dbhome_1 -LOG_FILE F:\ProfessialApp\oracle\admin\library\scripts\emConfig.log;
spool off
