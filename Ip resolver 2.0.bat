:A
@echo off
Title Ip resolver
color 0e
setlocal enableextensions enabledelayedexpansion
echo Enter the website you would like to resolve without http(s)://
echo (If you would like to exit, just type in "exit".)
echo -
set input=
set /p input= Enter your Website here:
if %input%==exit goto exit
echo -
for /f %%a in ('copy /Z "%~f0" nul') do set "CR=%%a"
<nul set /P "=Processing Your request!CR!"
for /f "delims=[] tokens=2" %%a in ('ping %input% -n 1 ^| findstr "["') do (set thisip=%%a)
ping localhost>nul
<nul set /P "=IP address is: %thisip%!CR!"
ping localhost>nul
echo I
echo -
echo -
for /f %%a in ('copy /Z "%~f0" nul') do set "CR=%%a"
for /L %%n in (5 -1 1) do (
  <nul set /P "=This window will close in %%n seconds!CR!"
  ping -n 2 localhost > nul
)
:exit
exit