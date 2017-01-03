:A
@echo off
Title Website Pinger 2.0
color 0e
echo Enter the website you would like to ping without http(s)://
echo If you would like to exit, just type in "exit".
set input=
set /p input= Enter your Website here:
if %input%==exit goto exit
echo Processing Your request
ping localhost>nul
for /f "delims=[] tokens=2" %%a in ('ping %input% -n 1 ^| findstr "["') do (set thisip=%%a)
echo ----------------------------------------------------------
echo If you do not close this you will ping to %input%
echo ----------------------------------------------------------
ping localhost>nul
echo IP address is: %thisip%
ping %input%  -n 999 -l 1000
:exit
exit