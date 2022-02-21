:A
@echo off
Title Website Pinger 2022
color 0e
echo Enter the super website you would like to ping
set input=
set /p input= Enter your Website here:
if %input%==goto A if NOT B
echo Processing Your request
ping localhost>nul
echo -------------------------------------------------------------------------------------
echo If you do not clost this in 120 seconds you will go to **ENTER THE WEBSITE HERE**
echo -------------------------------------------------------------------------------------
ping localhost>nul
echo This is the IP=
ping %input%
set input=
set /p input= If you want to open this adress please enter the IP here:
start iexplore.exe %input%
set input2=
set /p input2=
if %input% exit goto exit
ping localhost -n 120 >nul
start iexplore.exe **ENTER THE WEBSITE HERE**
exit
:exit
exit