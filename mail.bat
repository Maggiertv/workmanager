@echo off

:start

echo -:- Mailserver gestartet:

set /p SUBJECT=Subjekt angeben:
echo - 
set /p BODY=Nachricht angeben:
echo - 
set FROM=test@testmail.com
set /p FROM=Absender angeben:
echo -
set /p TO=Empfaenger angeben:
echo -
set SMTP=smtp.1und1.de
set /p SMTP=SMTP-Server angeben:
echo -

set /p Attribut=Wollen Sie einen Anhang versenden: [1=Ja][2=Nein]
echo -
if %Attribut%==1 (
set ATT=%Pictures%/maxresfault.jpg
echo Falls Sie eine Datei versenden wollen,
set /p ATT=geben Sie bitte den Dateipfad an:
)

echo -:- Parameter wurden geladen
echo -
echo Bitte kurz warten, bis die Mail verschickt wurde...
echo -


if %Attribut%==1 (
powershell -ExecutionPolicy Unrestricted -c "Send-MailMessage -To '%TO%' -Subject '%SUBJECT%' -Body '%BODY%' -SmtpServer '%SMTP%' -From '%FROM%' -Attachments '%ATT%'"
) else (
powershell -ExecutionPolicy Unrestricted -c "Send-MailMessage -To '%TO%' -Subject '%SUBJECT%' -Body '%BODY%' -SmtpServer '%SMTP%' -From '%FROM%'"
)

echo -
echo -:- Mail wurde erfolgreich versendet

set /p CONTINUE=Wollen Sie eine weitere Mail versenden? [1=Ja][2=Nein]
if %CONTINUE%==2 goto end:
if %CONTINUE%==1 cls & goto start:
:end
pause