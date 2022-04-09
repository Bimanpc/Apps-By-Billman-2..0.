@ECHO OFF
IF NOT "%~1"=="" GOTO Syntax

:: Check for WinPE first, as WMI might not be available in WinPE
REG.EXE Query HKLM\SYSTEM\ControlSet001\Control\MiniNT >NUL 2>&1
IF NOT ERRORLEVEL 1 (
	ECHO Windows PE Version
	EXIT /B 3
)

:: Check for "regular" boot state
WMIC.EXE Path Win32_ComputerSystem Get BootupState | FIND.EXE "Normal boot" >NUL
IF NOT ERRORLEVEL 1 (
	ECHO Normal
	EXIT /B 0
)

WMIC.EXE Path Win32_ComputerSystem Get BootupState | FIND.EXE "Fail-safe boot" >NUL
IF NOT ERRORLEVEL 1 (
	ECHO Safe mode
	EXIT /B 1
)

WMIC.EXE Path Win32_ComputerSystem Get BootupState | FIND.EXE "Fail-safe with network boot" >NUL
IF NOT ERRORLEVEL 1 (
	ECHO Safe mode with net
	EXIT /B 2
)

ECHO Unknown
EXIT /B -1


:Syntax
ECHO.
ECHO BootState.bat,  Version 1.04
ECHO Show Windows' boot state
ECHO.
ECHO Usage:    BootState.bat
ECHO.
ECHO Notes:    Boot state is returned as string and as "errorlevel" ^(return code^):
ECHO               "Normal"                    ^(errorlevel = 0^)
ECHO               "Safe mode"                 ^(errorlevel = 1^)
ECHO               "Safe mode with network"    ^(errorlevel = 2^)
ECHO               "Windows PE"                ^(errorlevel = 3^)
ECHO           In case of ^(command line^) errors, the errorlevel will be -1.
ECHO.
EXIT /B -1