set verify off
ACCEPT sysPassword CHAR PROMPT 'Enter new password for SYS: ' HIDE
ACCEPT systemPassword CHAR PROMPT 'Enter new password for SYSTEM: ' HIDE
ACCEPT sysmanPassword CHAR PROMPT 'Enter new password for SYSMAN: ' HIDE
ACCEPT dbsnmpPassword CHAR PROMPT 'Enter new password for DBSNMP: ' HIDE
host F:\ProfessialApp\oracle\product\11.2.0\dbhome_1\bin\orapwd.exe file=F:\ProfessialApp\oracle\product\11.2.0\dbhome_1\database\PWDlibrary.ora force=y
@F:\ProfessialApp\oracle\admin\library\scripts\CloneRmanRestore.sql
@F:\ProfessialApp\oracle\admin\library\scripts\cloneDBCreation.sql
@F:\ProfessialApp\oracle\admin\library\scripts\postScripts.sql
@F:\ProfessialApp\oracle\admin\library\scripts\lockAccount.sql
@F:\ProfessialApp\oracle\admin\library\scripts\postDBCreation.sql
