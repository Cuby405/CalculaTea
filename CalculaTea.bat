@echo off
title CalculaTea
setlocal enabledelayedexpansion

>nul 2>&1 reg query HKCU\Console || exit /b
reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul

:inicio
cls
echo [92m=======================================
echo               CALCULA-TEA
echo =======================================[97m
echo.
echo [97mType the operation:
echo Symbols: "+  -  *  / ( )"
echo Example: 12+3*4/(2-1)
echo Press enter to calculate.[90m
echo.
echo Type "Q" to quit.
echo.
echo [92m=======================================[97m
echo.

:: Leer la operación
set /p linea=[93mOperation:[97m 

:: Salir si escribió Q
if /i "!linea!"=="Q" goto fin
if "!linea!"=="" goto inicio

:: Quitar "=" al final si existe
if "!linea:~-1!"=="=" set "linea=!linea:~0,-1!"

:: Reemplazar operadores para PowerShell
set "linea=!linea:x=*!"
set "linea=!linea::=/!"

echo.
:: Ejecutar la operación en PowerShell y capturar resultado
powershell -Command ^
"try { $expr='%linea%'; $resultado=[math]::Round((Invoke-Expression $expr),10); Write-Host '[92m=============================='; Write-Host '[93mResultado:[96m ' $resultado; Write-Host '[92m==============================' } catch { Write-Host '[92m=============================='; Write-Host '[91mSyntax error'; Write-Host '[92m==============================' }"

echo.
echo [95mType any key to continue...
pause >nul
goto inicio

:fin
echo.
echo [96mThanks fot use.
echo.
echo [95mType any key to continue...
pause >nul
exit