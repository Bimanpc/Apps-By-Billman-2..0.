@echo off
echo  'Trace route for given hostname'
@echo off
title trace the root to the host
Set /p host_name= enter hostname or ip you want to trace route:
if defined host_name (
powershell -Command tracert -d %Host% >>tracert_result.txt
)