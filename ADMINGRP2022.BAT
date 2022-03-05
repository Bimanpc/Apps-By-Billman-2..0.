@echo off 
cls
:: ADMINGRP2022.BAT
::
:: Author - Vasilis PS
:: Date - 11-29-2022
:: Version - 2022

:: This batch is intended to run on Windows NT.
::----------------------- batch code -----------------------

:variables
:: set all initial variables here
set user=domain desktop support
set group=Administrators
set password=
set domain=
set admin=administrator
set match=no   


:getdate
  FOR /F "TOKENS=1,2*" %%A IN ('DATE/T') DO SET TODAY=%%B
  SET TODAY=%TODAY:/=-%
  echo This run completed on %TODAY% >.\log.txt
  ::ren .\log.txt .\%TODAY%-log.txt

:getmachines
  FOR /F "skip=3 tokens=*" %%A IN ('NET VIEW /DOMAIN:%domain%') DO CALL :check %%A
  goto exit

:check
  set currentmachine=%1
  for /F %%i in (.\exclude.txt) do if %currentmachine%==%%i set match=yes
  if %match%==no call :process
  if %match%==yes call :bypass
  goto :EOF
  goto :EOF
  goto :exit 

:bypass 
  @echo Current system: %currentmachine% is on the exclude list, BYPASSING....... >>.\log.txt
  echo -===================================->>.\log.txt
  set match=no
  goto :EOF

:process
  @echo Current system: %currentmachine% is valid......Processing....... >>.\log.txt
  if exist .\temp.txt del /F /Q .\temp.txt
  echo domain: %currentmachine%>> .\temp.txt
  echo localgroup: %group%>> .\temp.txt
  echo %User%>> .\temp.txt

  echo %currentmachine%
  net use \\%currentmachine%\IPC$ /D 
  net use \\%currentmachine%\IPC$ /USER:%domain%\%admin% %password% >>.\log.txt

  Usrtogrp.exe .\temp.txt >>.\log.txt
  echo -===================================->>.\log.txt
  set match=no
  goto :EOF

:Exit