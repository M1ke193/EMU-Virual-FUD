@echo off
chcp 65001 >nul
cls
color 0A
set "PATH_VIEW=C:\Program Files\VirtViewer v11.0-256\bin\remote-viewer.exe"
set "SPICE_PORT=5900"

echo Current path of VirtViewer is %PATH_VIEW%
echo Check it on your machine and set it to variable `PATH_VIEW`, it usually from "C:\Program Files"
echo.
echo Connecting to VM through port %SPICE_PORT% ...

"%PATH_VIEW%" spice://127.0.0.1:%SPICE_PORT%

pause >nul

