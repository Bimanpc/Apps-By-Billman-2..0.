@echo off
setlocal enabledelayedexpansion

set "loop_count=100000"
set "start_time=!TIME!"

for /l %%i in (1,1,%loop_count%) do (
    set /a "result=2*2"
)

set "end_time=!TIME!"

echo CPU test completed!
echo Start Time: %start_time%
echo End Time  : %end_time%
pause
