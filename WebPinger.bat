::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFLWm4tUt38VjqG6yJEYhQT0oQA0td94bfZzQzrueHE7mRINKhDjseIb0Z2X/ou72vS6YTT0dmVpjnU2kC/CZsT/oRE+M9AU1A2AU
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
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