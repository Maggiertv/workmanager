@echo off
title work-manager
setlocal EnableDelayedExpansion

rem compare-op  can be one of
::                EQU : Equal
::                NEQ : Not equal

::                LSS : Less than <
::                LEQ : Less than or Equal <=

::                GTR : Greater than >
::                GEQ : Greater than or equal >=

:start
cls
set decimals=1

set /A one=1, decimalsP1=decimals+1
for /L %%i in (1,1,%decimals%) do set "one=!one!0"

set /a continue = 0
echo If you don't want to use a specific starting time the program will
echo take the current system-time for the starting time.
set /p continue=Do you want to use your specific starttime? [1(yes)/0(no)]
if %continue%==1 (
goto gettimeer2)
if %continue%==0 (
goto gettimeer)
if /i %continue% GTR 1 (
goto start)
if /i %continue% LSS 0 (
goto start)

:gettimeer2
set /a time = 0
set /p time=Insert the starting time (07:30 - Hours:Minutes):
if /i %time% LSS 0 (
goto :gettimeer2)
goto numOK2
echo The Time must have a doublepoint or is not correct
goto gettimeer2

:numOK2

:gettimeer
set /a timevalue = 0
set /p timevalue=Insert until when you have to work (16:00):
if /i %timevalue% LSS 0 (
goto :gettimeer)
if /i %timevalue% LSS %time% (
echo I don't think that you work longer than 24h.
goto gettimeer )
goto numOK


:numOK


rem The format of %TIME% is HH:MM:SS,CS for example 23:59:59,99
set STARTTIME=%TIME%

set ENDTIME=%timevalue%

rem output as time
echo STARTTIME: %STARTTIME%
echo ENDTIME: %ENDTIME%

rem convert STARTTIME and ENDTIME to centiseconds
set /A STARTTIME=(1%STARTTIME:~0,2%-100)*360000 + (1%STARTTIME:~3,2%-100)*6000 + (1%STARTTIME:~6,2%-100)*100 + (1%STARTTIME:~9,2%-100)
set /A ENDTIME=(1%ENDTIME:~0,2%-100)*360000 + (1%ENDTIME:~3,2%-100)*6000 + (1%ENDTIME:~6,2%-100)*100 + (1%ENDTIME:~9,2%-100)

rem calculating the duratyion is easy
set /A DURATION=%ENDTIME%-%STARTTIME%

rem we might have measured the time inbetween days
if %ENDTIME% LSS %STARTTIME% set set /A DURATION=%STARTTIME%-%ENDTIME%

rem now break the centiseconds down to hors, minutes, seconds and the remaining centiseconds
set /A DURATIONH=%DURATION% / 360000
set /A DURATIONM=(%DURATION% - %DURATIONH%*360000) / 6000
set /A DURATIONS=(%DURATION% - %DURATIONH%*360000 - %DURATIONM%*6000) / 100
set /A DURATIONHS=(%DURATION% - %DURATIONH%*360000 - %DURATIONM%*6000 - %DURATIONS%*100)
set /A work=(%DURATIONH%*360000 + %DURATIONM%*6000 + %DURATIONS%*100)

rem some formatting
if %DURATIONH% LSS 10 set DURATIONH=0%DURATIONH%
if %DURATIONM% LSS 10 set DURATIONM=0%DURATIONM%
if %DURATIONS% LSS 10 set DURATIONS=0%DURATIONS%
if %DURATIONHS% LSS 10 set DURATIONHS=0%DURATIONHS%

rem outputing
::echo STARTTIME: %STARTTIME% centiseconds
::echo ENDTIME: %ENDTIME% centiseconds
::echo DURATION: %DURATION% in centiseconds
echo %DURATIONH%:%DURATIONM%:%DURATIONS%,%DURATIONHS%

:gettimeer3

echo -
set /a pause = 0
set /p pause=Insert how long you have to eat lunch (00:45 - Hours:Minutes):
if /i %pause% LSS 0 (
goto :gettimeer3)
goto num3OK
echo The Value must have a point and %decimals% decimals
goto gettimeer3

:num3OK

set STARTTIME3=00:00:00,00

set ENDTIME3=%pause%:00,00

rem convert STARTTIME and ENDTIME to centiseconds
set /A STARTTIME3=(1%STARTTIME3:~0,2%-100)*360000 + (1%STARTTIME3:~3,2%-100)*6000 + (1%STARTTIME3:~6,2%-100)*100 + (1%STARTTIME3:~9,2%-100)
set /A ENDTIME3=(1%ENDTIME3:~0,2%-100)*360000 + (1%ENDTIME3:~3,2%-100)*6000 + (1%ENDTIME3:~6,2%-100)*100 + (1%ENDTIME3:~9,2%-100)

rem calculating the duration is easy
set /A DURATION3=%ENDTIME3%-%STARTTIME3%

rem we might have measured the time inbetween days
if %ENDTIME3% LSS %STARTTIME3% set set /A DURATION3=%STARTTIME3%-%ENDTIME3%

set /A DURATION3H=%DURATION3% / 360000
set /A DURATION3M=(%DURATION3% - %DURATION3H%*360000) / 6000
set /A DURATION3S=(%DURATION3% - %DURATION3H%*360000 - %DURATION3M%*6000) / 100
set /A DURATION3HS=(%DURATION3% - %DURATION3H%*360000 - %DURATION3M%*6000 - %DURATION3S%*100)
set /A pause=(%DURATION3M%*6000 + %DURATION3H%*360000)

rem some formatting
if %DURATION3M% LSS 10 set DURATION3M=0%DURATION3M%
if %DURATION3S% LSS 10 set DURATION3S=0%DURATION3S%
if %DURATION3HS% LSS 10 set DURATION3HS=0%DURATION3HS%

echo Duration: %DURATION3H%:%DURATION3M%:%DURATION3S%,%DURATION3HS%


:gettimeer1

echo -
set /a piece = 0
set /p piece=Insert how long you are working for 1 piece (05:30 - Minutes:Seconds):
if /i %piece% LSS 0 (
goto :gettimeer1)
goto num1OK
echo The Value must have a point and %decimals% decimals
goto gettimeer1

:num1OK

set STARTTIME1=00:00:00,00

set ENDTIME1=00:%piece%,00

rem convert STARTTIME and ENDTIME to centiseconds
set /A STARTTIME1=(1%STARTTIME1:~0,2%-100)*360000 + (1%STARTTIME1:~3,2%-100)*6000 + (1%STARTTIME1:~6,2%-100)*100 + (1%STARTTIME1:~9,2%-100)
set /A ENDTIME1=(1%ENDTIME1:~0,2%-100)*360000 + (1%ENDTIME1:~3,2%-100)*6000 + (1%ENDTIME1:~6,2%-100)*100 + (1%ENDTIME1:~9,2%-100)

rem calculating the duratyion is easy
set /A DURATION1=%ENDTIME1%-%STARTTIME1%

rem we might have measured the time inbetween days
if %ENDTIME1% LSS %STARTTIME1% set set /A DURATION1=%STARTTIME1%-%ENDTIME1%

set /A DURATION1H=%DURATION1% / 360000
set /A DURATION1M=(%DURATION1% - %DURATION1H%*360000) / 6000
set /A DURATION1S=(%DURATION1% - %DURATION1H%*360000 - %DURATION1M%*6000) / 100
set /A DURATION1HS=(%DURATION1% - %DURATION1H%*360000 - %DURATION1M%*6000 - %DURATION1S%*100)
set /A piece=(%DURATION1M%*6000 + %DURATION1S%*100)

rem some formatting
if %DURATION1M% LSS 10 set DURATION1M=0%DURATION1M%
if %DURATION1S% LSS 10 set DURATION1S=0%DURATION1S%
if %DURATION1HS% LSS 10 set DURATION1HS=0%DURATION1HS%

echo Duration: %DURATION1H%:%DURATION1M%:%DURATION1S%,%DURATION1HS%

set "fpA=%work:.=%"
set "fpB=%piece:.=%"
set "fpC=%pause:.=%"
set "fpD=%work1:.=%"

set /A add=fpA+fpB, sub=fpA-fpB, mul=fpA*fpB/one, div=fpD*one/fpB, sub1=fbA-fpC

set /a work1 = %work%-%pause% rem !sub1:~0,-%decimals%!.!sub1:~-%decimals%!

echo %work%ms (complete time) - %pause%ms (pause) = %work1% (work-time)

set /a output = %work1%/%piece%
echo -
::echo %work% + %piece% = !add:~0,-%decimals%!.!add:~-%decimals%!
::echo %work% - %piece% = !sub:~0,-%decimals%!.!sub:~-%decimals%!
::echo %work% * %piece% = !mul:~0,-%decimals%!.!mul:~-%decimals%!
echo %work1%ms (work-time) / %piece%ms (time per piece) = %output%
echo -

echo -
echo You can make %output% pieces!
echo -
echo ------------------------------------------------------------------------
set /p noice=Press enter for a new instance!
goto start: