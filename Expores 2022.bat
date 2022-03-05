@ECHO OFF
ECHO.>CON
ECHO EXPIRES, Version 2022 >CON
ECHO List all user ID's that have their password expiration disabled >CON
ECHO.>CON
ECHO Written by bILLYeye PS>CON
ECHO.>CON
ECHO Gathering data, this may take several minutes . . .>CON
ECHO.>CON
ECHO Password never expires for the following user IDs:
ECHO.

FOR /F "skip=4 tokens=*" %%A IN ('NET USER /DOMAIN ^| FIND /V "The command completed successfully"') DO CALL :ParseUsers %%A
GOTO:EOF

:ParseUsers
FOR %%? IN (%*) DO CALL :ChkAcc %%?
GOTO:EOF

:ChkAcc
NET USER %1 /DOMAIN | FIND "Password expires             Never" >NUL
IF NOT ERRORLEVEL 1 ECHO.%1
GOTO:EOF