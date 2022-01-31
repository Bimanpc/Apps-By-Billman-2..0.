SETLOCAL ENABLEDELAYEDEXPANSION
SET count=1
FOR /F "tokens=*" %%F IN ('WMIC CSPRODUCT GET NAME') DO (
 SET var!count!=%%F
 SET /a count=!count!+1)
 SET v=%var2%
 :;ECHO %var1%
ECHO %var2%
ENDLOCAL

:; Get version number only so drop off HP Pavilion G62
FOR /F "tokens=1-9 delims=K" %%A IN ("%var2%") DO (
    SET V=%%a
    echo %V%
)