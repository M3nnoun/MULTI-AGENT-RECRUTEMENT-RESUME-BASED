@echo off
REM Sets up the MULTI-AGENT-CANDIDATE-SELECTION project: creates the Python
REM virtual environment (env-macs) and installs all dependencies.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup.ps1"
pause
