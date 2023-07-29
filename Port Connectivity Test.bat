@echo off
set /p host=Enter the host or IP address to test: 
set /p port=Enter the port number to test: 

echo Testing connectivity to %host% on port %port%...

(echo ^<?xml version="1.0" encoding="UTF-8"?^>) > temp.xml
(echo ^<Configuration^>) >> temp.xml
(echo ^<Service^>ping^</Service^>) >> temp.xml
(echo ^<Host^>%host%^</Host^>) >> temp.xml
(echo ^<Port^>%port%^</Port^>) >> temp.xml
(echo ^</Configuration^>) >> temp.xml

echo. & type temp.xml | curl --data-binary @- http://www.ptsv2.com/t/<YOUR_UNIQUE_IDENTIFIER>
del temp.xml
