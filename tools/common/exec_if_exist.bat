@echo off
setlocal

set WORK_DIR=%~dp0
set SCRIPT_FILE=%~1%

if not defined SCRIPT_FILE goto :usage
goto :run
:usage
echo usage:
echo   exec_if_exist.bat SCRIPT_FILE
exit /b 1
:run

if not exist "%SCRIPT_FILE%" (
    exit /b 0
)

set ALL_VAR=
shift
:loop
if "x%~1"=="x" goto loop_finish
set ALL_VAR=%ALL_VAR% %1
shift
goto loop
:loop_finish
call "%SCRIPT_FILE%" %ALL_VAR%

