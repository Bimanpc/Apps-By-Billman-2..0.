@ECHO OFF
:: Enable command extensions and save initial environment
VERIFY OTHER 2>NUL
SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 1 (
	ECHO Unable to enable command extensions
	GOTO End
)

:: Check parameters
IF /I [%1]==[]   SET SWITCH=/V
IF /I [%1]==[/Q] SET SWITCH=/S
IF /I [%1]==[/S] SET SWITCH=/S
IF /I [%1]==[/V] SET SWITCH=/V
IF [%SWITCH%]==[] GOTO Syntax

:: Use WINMSD.EXE to check the amount of RAM installed
START /W WINMSD.EXE /S
:: Read the amount of RAM installed from WINMSD's report
FOR /F "tokens=2 delims=: " %%A IN ('TYPE %COMPUTERNAME%.TXT ^| FIND "Total:" ^| FIND /V "\"') DO SET RAM=%%A
:: Delete WINMSD's report
DEL %COMPUTERNAME%.TXT
:: Add 1023 to round up, or
:: add 512 for "mathematical" rounding, or
:: add 0 (or "rem out" next line) to round down
SET /A RAM = %RAM:,=% + 1023
SET /A RAM = %RAM:,=% / 1024
:: Use switch to determine display format
IF [%SWITCH%]==[/S] (
	ECHO %RAM%
) ELSE (
	ECHO.
	ECHO Total amount of RAM installed: %RAM% MB
)
GOTO End

:Syntax
ECHO.
ECHO GetRAM.bat, Version 1.10 for Windows NT
ECHO Displays amount RAM installed on PC in MB
ECHO.
ECHO Idea: Billy PSPC
ECHO.
ECHO Usage:  %~n0  [ /Q ^| /S ^| /V ]
ECHO.
ECHO Switches:  /Q ^(quiet^) and /S ^(silent^) display the amount of RAM
ECHO                       installed on the computer as a number only
ECHO            /V ^(verbose^) also tells what it is displaying ^(default^)
ECHO.

:End
ENDLOCAL