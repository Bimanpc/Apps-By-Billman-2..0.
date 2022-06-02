@Echo Stopps the Windows Update Service .............
@echo off
Net stop wuauserv
@echo ************************************************
@Echo Disables the Windows Update Service .............
@echo off
sc config "wuauserv" start=disabled
@echo ************************************************
@echo Finished ....
pause