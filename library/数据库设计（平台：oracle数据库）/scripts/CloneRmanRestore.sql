SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool F:\ProfessialApp\oracle\admin\library\scripts\CloneRmanRestore.log append
startup nomount pfile="F:\ProfessialApp\oracle\admin\library\scripts\init.ora";
@F:\ProfessialApp\oracle\admin\library\scripts\rmanRestoreDatafiles.sql;
spool off
