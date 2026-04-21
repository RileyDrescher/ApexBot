@echo off
title ApexBot Launcher - Laptop
color 0A

echo.
echo  ==========================================
echo       APEXBOT STARTING UP - LAPTOP
echo  ==========================================
echo.

set PYTHON=C:\Users\riley\AppData\Local\Programs\Python\Python314\python.exe
set ROOT=C:\Users\riley\Desktop\apexbot

echo Starting backend server...
start "ApexBot Backend" cmd /k "%PYTHON% %ROOT%\backend\server.py"

echo Waiting for server...
timeout /t 4 /nobreak >nul

echo Starting Forex bot...
start "ApexBot Bot" cmd /k "%ROOT%\run_bot_laptop.bat"

echo.
echo  Open browser: http://127.0.0.1:5000
echo  Keep both windows open.
echo.
pause
