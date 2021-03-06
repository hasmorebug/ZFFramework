@echo off
setlocal

set WORK_DIR=%~dp0
set SRC_PATH=%~1%
set DST_PATH=%~2%

if not defined SRC_PATH goto :usage
if not defined DST_PATH goto :usage
goto :run
:usage
echo usage:
echo   copy_res.bat SRC_PATH DST_PATH
exit /b 1
:run

mkdir "%DST_PATH%" >nul 2>nul
xcopy /s/e/y/r/h "%SRC_PATH%" "%DST_PATH%" >nul 2>nul
del /f/s/q "%DST_PATH%\*.gitkeep" >nul 2>nul

