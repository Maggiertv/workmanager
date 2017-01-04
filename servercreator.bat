@echo off
title servercreator
setlocal EnableDelayedExpansion

:start
cls
set /p Eingabe1=Pfade fuer Server- und Kofigurationsdateien werden gesetzt...

SET PFAD= %cd%\server.jar
SET PFAD1= %cd%\eula.txt
SET PFAD2= %cd%\server.properties

cls
echo Pfade: %PFAD% - %PFAD1% - %PFAD2%
echo -- Pfade gesetzt
echo -
echo Suche nach Serverdatei...
set /p Eingabe2=Erstelle und starte ein .batch-file, mit dem der Server gestartet werden kann.

if not exist %PFAD% goto fail:
rem start.bat erstellen, mit der der server gestartet wird und diese ausführen
echo java -Xmx1028M -Xms1028M -jar server.jar nogui >> start.bat
start %cd%\start.bat
rem 10 sekunden warten
cls
echo Serverfenster muss nach erfolgreichem Neustart geschlossen werden.
timeout /t 10
echo -- Datei erstellt und gestartet (Noch 1 Neustart noetig)
echo -
set /p Eingabe3=Suche nach Eula und akzeptiere sie...

if not exist %PFAD1% goto fail:
rem in der eula-Datei, die erstellt wird das false durch true ersetzen
echo #By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula). > %cd%\eula.txt
echo #%DATE% %TIME% >> %cd%\eula.txt
echo eula=true>>%cd%\eula.txt

cls
echo -- Eula akzeptiert
echo -
set /p Eingabe4=Der Server muss noch einmal gestartet werden um weitere Konfigurationen zu laden...

start %cd%\start.bat

cls
echo Server kann wieder geschlossen werden, sobald "Done!" im Serverfenster steht.
echo -- Gestartet (Letzter neustart beendet)
echo -
echo Der naechste Schritt kann dauern. Bitte nur einmal bestätigen...
set /p Eingabe5=Veraendere einige Konfigurationseinstellungen des Servers...

if not exist %PFAD2% goto fail:
rem Eigene IP als Serverip setzen
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set ip=%%b
set ip=%ip:~1%
rem in der config settings verändern
echo generator-settings= > %cd%\server.properties
echo op-permission-level=4 >> %cd%\server.properties
echo allow-nether=true >> %cd%\server.properties
echo resource-pack-hash= >> %cd%\server.properties
echo level-name=world >> %cd%\server.properties
echo allow-flight=false >> %cd%\server.properties
echo announce-player-achievements=true >> %cd%\server.properties
echo server-port=25565 >> %cd%\server.properties
echo max-world-size=29999984 >> %cd%\server.properties
echo level-type=DEFAULT >> %cd%\server.properties
echo level-seed= >> %cd%\server.properties
echo force-gamemode=false >> %cd%\server.properties
echo network-compression-threshold=256 >> %cd%\server.properties
echo max-build-height=256 >> %cd%\server.properties
echo spawn-npcs=true >> %cd%\server.properties
echo white-list=false >> %cd%\server.properties
echo spawn-animals=true >> %cd%\server.properties
echo hardcore=false >> %cd%\server.properties
echo snooper-enabled=true >> %cd%\server.properties
echo online-mode=true >> %cd%\server.properties
echo resource-pack= >> %cd%\server.properties
echo pvp=true >> %cd%\server.properties
echo difficulty=1 >> %cd%\server.properties
echo enable-command-block=true >> %cd%\server.properties
echo gamemode=0 >> %cd%\server.properties
echo player-idle-timeout=0 >> %cd%\server.properties
echo max-players=50 >> %cd%\server.properties
echo generate-structures=true >> %cd%\server.properties
echo view-distance=12 >> %cd%\server.properties
echo motd=Automated Server >> %cd%\server.properties

cls
set /p quest=Benutzt du NO-IP, um deinen Minecraft server zu hosten? [1]-Ja / [2]-Nein: 
IF "%quest%"=="1" (
echo server-ip= >> %cd%\server.properties
) ELSE (
echo server-ip=%ip% >> %cd%\server.properties
)

cls
echo -- Letzte Aenderungen wurden gemacht
echo -
echo Schliesse nun das Fenster und starte den Server mit "start.bat".
echo Er ist nun startbereit.

rem zum Ende springen
goto end:
:end
pause
exit

:fail
echo Hast du den server in server.jar umbenennt?
echo Hast du beide Dateien im gleichen Verzeichnis?
set /p fail=Das Verzeichnis konnte nicht gefunden werden...
goto start:
rem Copyright by Lukas Koch (Nichtmister)
