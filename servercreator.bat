@echo off
title servercreator
setlocal EnableDelayedExpansion

:start

SET PFAD= %cd%\server.jar

if exist %PFAD% (
sed "s/false/true/g" <eula.txt>eula.txt
echo java -Xmx4095M -Xms4095M -jar craftbukkit.jar nogui>>%cd%\start server.bat 
goto end:
)

goto start:
:end
pause