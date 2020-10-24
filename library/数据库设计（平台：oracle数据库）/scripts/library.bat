OLD_UMASK=`umask`
umask 0027
mkdir F:\ProfessialApp\oracle\admin\library\adump
mkdir F:\ProfessialApp\oracle\admin\library\dpdump
mkdir F:\ProfessialApp\oracle\admin\library\pfile
mkdir F:\ProfessialApp\oracle\cfgtoollogs\dbca\library
mkdir F:\ProfessialApp\oracle\flash_recovery_area
mkdir F:\ProfessialApp\oracle\flash_recovery_area\library
mkdir F:\ProfessialApp\oracle\oradata\library
mkdir F:\ProfessialApp\oracle\product\11.2.0\dbhome_1\database
umask ${OLD_UMASK}
set ORACLE_SID=library
set PATH=%ORACLE_HOME%\bin;%PATH%
F:\ProfessialApp\oracle\product\11.2.0\dbhome_1\bin\oradim.exe -new -sid LIBRARY -startmode manual -spfile 
F:\ProfessialApp\oracle\product\11.2.0\dbhome_1\bin\oradim.exe -edit -sid LIBRARY -startmode auto -srvcstart system 
F:\ProfessialApp\oracle\product\11.2.0\dbhome_1\bin\sqlplus /nolog @F:\ProfessialApp\oracle\admin\library\scripts\library.sql
