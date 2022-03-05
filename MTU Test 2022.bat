@ECHO OFF
:: Windows NT 4 and later
IF NOT "%OS%"=="Windows_NT" GOTO Syntax
:: Windows 7 and later
VER | FINDSTR /R /E " 6\.[1-9]\.[0-9][0-9]*\]" >NUL || VER | FINDSTR /R /E " 7\.[0-9]\.[0-9][0-9]*\]" >NUL || GOTO Syntax
:: No command line arguments required
IF NOT "%~1"=="" GOTO Syntax

SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F %%A IN ('NETSH interface ipv4 show subinterfaces ^| FINDSTR /R /B /C:"  *[1-9]" ^| FIND /C " "') DO SET Adapters=%%A
IF %Adapters%0 EQU 0 (
	ECHO No enabled network adapters were detected.
	EXIT /B 1
)
IF %Adapters%0 NEQ 10 (
	ECHO This script can only be used with a single network adapter enabled.
	ECHO A test showed %Adapters% enabled network adapters.
	ECHO Disable all but one network adapter and try again.
	EXIT /B %Adapters%
)
SET RC=0
FOR /F "skip=3 tokens=1,4*" %%A IN ('NETSH interface ipv4 show subinterfaces') DO (
	IF %%A LSS 2000 IF %%A GTR 1000 (
		SET CurrentMTU=%%A
		SET Adapter=%%C
		ECHO Testing network adapter "!Adapter!" . . .
		SET /A PingSize = !CurrentMTU! - 28
		PING one.com -f -l !PingSize! 2>NUL | FIND "TTL=" >NUL
		IF ERRORLEVEL 1 (
			ECHO The current MTU value for this adapter ^(!CurrentMTU!^) is too high^^!
			SET RC=1
		) ELSE (
			SET /A PingSize = !PingSize! + 10
			PING one.com -f -l !PingSize! 2>NUL | FIND "TTL=" >NUL
			IF ERRORLEVEL 1 (
				ECHO Current MTU value ^(!CurrentMTU!^) is the optimal value for this adapter.
			) ELSE (
				ECHO The optimal MTU value for this adapter is higher than the current value ^(!CurrentMTU!^).
				SET RC=1
			)
		)
	)
)
ENDLOCAL & EXIT /B %RC%


:Syntax
ECHO.
ECHO MTUTest.bat,  Version 2022
ECHO Test if current MTU value is  optimal value
ECHO.
ECHO Usage:  MTUTEST
ECHO.
ECHO Return value ("errorlevel") will be 0 if MTU value is optimal,
ECHO or 1 otherwise (if not optimal or if an error occurred).
ECHO.

IF "%OS%"=="Windows_NT" EXIT /B 1