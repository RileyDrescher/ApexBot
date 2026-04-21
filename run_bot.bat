@echo off
title ApexBot Bot
:loop
C:\Users\riley\AppData\Local\Python\bin\python.exe C:\Users\riley\Desktop\apexbot\bot\trader.py
echo.
echo Bot stopped. Restarting in 10 seconds...
timeout /t 10 /nobreak >nul
goto loop
