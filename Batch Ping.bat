@echo off
set /p host=Enter the host or IP address to ping: 
set /p logfile=Enter the log file name: 

echo === Starting ping test for %host% === > %logfile%
ping %host% -t >> %logfile%
