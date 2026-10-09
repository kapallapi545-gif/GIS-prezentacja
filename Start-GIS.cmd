@echo off
REM ===================================================================
REM  Prezentacja CLI: System Informacji Geograficznej (SIG / GIS)
REM  Uruchamia prezentacje w PowerShell z kodowaniem UTF-8 dla polskich znakow.
REM ===================================================================
setlocal
chcp 65001 >nul
title Prezentacja CLI - System Informacji Geograficznej (SIG / GIS)
set "PS1=%~dp0src\Prezentacja-GIS.ps1"

where pwsh >nul 2>&1 && (
    pwsh -NoProfile -ExecutionPolicy Bypass -File "%PS1%" %*
    goto :koniec
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%PS1%" %*
set KOD=%ERRORLEVEL%

:koniec
echo.
if not "%KOD%"=="0" echo [Blad] Prezentacja zakonczyla sie bledem (kod %KOD%). Sprobuj: Start-GIS.cmd -Ascii
pause
endlocal
