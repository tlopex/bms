@echo off
setlocal
set "SOURCE=C:\ProgramData\MySQL\MySQL Server 8.1\Data"
set "DEST=D:\MySQL_Backup"

echo [%date% %time%] Starting backup...
xcopy "%SOURCE%\DESKTOP-DB6DDD1-bin.*" "%DEST%" /D /I /Y
echo [%date% %time%] Backup completed.
