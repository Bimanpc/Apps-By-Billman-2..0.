@echo off
::
::This script adds a single printer to the default user profile.
::NOTE:  Printer names with spaces will NOT be accepted.  
::Usage: run addprinters and follow onscreen directions


cls
echo This script adds the specified local or network printer  
echo to the deafult account for all existing/new users.  
echo *IMPORTATNT* Printer names with space will NOT be accepted.
echo *******************************************************

SET /P target=Enter target computer name (this compupter)  
SET /P printer=Enter Printserver/Printername (do not include \\) 
echo Attempting to add %printer% for all users on %target%


rundll32 printui.dll,PrintUIEntry /ga /c\\%target% /n\\%printer%
echo New printers will NOT appear until spooler is restarted.
SET /P reset=Reset print spooler Y/N?     
if "%reset%"=="y" goto spooly
goto end

:spooly
start /wait sc \\%target% stop spooler
start /wait sc \\%target% start spooler
echo Print Spooler Service restarted.

:end