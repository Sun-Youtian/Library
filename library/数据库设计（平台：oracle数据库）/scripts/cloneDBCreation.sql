SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool F:\ProfessialApp\oracle\admin\library\scripts\cloneDBCreation.log append
Create controlfile reuse set database "library"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
Datafile 
'F:\ProfessialApp\oracle\oradata\library\SYSTEM01.DBF',
'F:\ProfessialApp\oracle\oradata\library\SYSAUX01.DBF',
'F:\ProfessialApp\oracle\oradata\library\UNDOTBS01.DBF',
'F:\ProfessialApp\oracle\oradata\library\USERS01.DBF'
LOGFILE GROUP 1 ('F:\ProfessialApp\oracle\oradata\library\redo01.log') SIZE 51200K,
GROUP 2 ('F:\ProfessialApp\oracle\oradata\library\redo02.log') SIZE 51200K,
GROUP 3 ('F:\ProfessialApp\oracle\oradata\library\redo03.log') SIZE 51200K RESETLOGS;
exec dbms_backup_restore.zerodbid(0);
shutdown immediate;
startup nomount pfile="F:\ProfessialApp\oracle\admin\library\scripts\initlibraryTemp.ora";
Create controlfile reuse set database "library"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 100
Datafile 
'F:\ProfessialApp\oracle\oradata\library\SYSTEM01.DBF',
'F:\ProfessialApp\oracle\oradata\library\SYSAUX01.DBF',
'F:\ProfessialApp\oracle\oradata\library\UNDOTBS01.DBF',
'F:\ProfessialApp\oracle\oradata\library\USERS01.DBF'
LOGFILE GROUP 1 ('F:\ProfessialApp\oracle\oradata\library\redo01.log') SIZE 51200K,
GROUP 2 ('F:\ProfessialApp\oracle\oradata\library\redo02.log') SIZE 51200K,
GROUP 3 ('F:\ProfessialApp\oracle\oradata\library\redo03.log') SIZE 51200K RESETLOGS;
alter system enable restricted session;
alter database "library" open resetlogs;
exec dbms_service.delete_service('seeddata');
exec dbms_service.delete_service('seeddataXDB');
alter database rename global_name to "library";
ALTER TABLESPACE TEMP ADD TEMPFILE 'F:\ProfessialApp\oracle\oradata\library\TEMP01.DBF' SIZE 20480K REUSE AUTOEXTEND ON NEXT 640K MAXSIZE UNLIMITED;
select tablespace_name from dba_tablespaces where tablespace_name='USERS';
alter system disable restricted session;
connect "SYS"/"&&sysPassword" as SYSDBA
@F:\ProfessialApp\oracle\product\11.2.0\dbhome_1\demo\schema\mkplug.sql &&sysPassword change_on_install change_on_install change_on_install change_on_install change_on_install change_on_install F:\ProfessialApp\oracle\product\11.2.0\dbhome_1\assistants\dbca\templates\example.dmp F:\ProfessialApp\oracle\product\11.2.0\dbhome_1\assistants\dbca\templates\example01.dfb F:\ProfessialApp\oracle\oradata\library\example01.dbf F:\ProfessialApp\oracle\admin\library\scripts\ "'SYS/&&sysPassword as SYSDBA'";
connect "SYS"/"&&sysPassword" as SYSDBA
shutdown immediate;
connect "SYS"/"&&sysPassword" as SYSDBA
startup restrict pfile="F:\ProfessialApp\oracle\admin\library\scripts\initlibraryTemp.ora";
select sid, program, serial#, username from v$session;
alter database character set INTERNAL_CONVERT ZHS16GBK;
alter database national character set INTERNAL_CONVERT AL16UTF16;
alter user sys account unlock identified by "&&sysPassword";
alter user system account unlock identified by "&&systemPassword";
alter system disable restricted session;
