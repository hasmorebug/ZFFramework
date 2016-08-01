@echo off
setlocal

set WORK_DIR=%~dp0
set TARGET_FILE=%~1%

if not defined TARGET_FILE goto :usage
goto :run
:usage
echo usage:
echo   unity_build.bat TARGET_FILE [SRC_DIRS, ...]
exit /b 1
:run

del /s/q %TARGET_FILE%.tmp >nul 2>nul
md %TARGET_FILE%.tmp >nul 2>nul
rmdir /s/q %TARGET_FILE%.tmp >nul 2>nul

shift /1
:SRC_DIR_LOOP
if "%1" == "" (goto :SRC_DIR_LOOP_END)
>nul 2>nul (
    if exist %1\ (
        dir /a-d/s/b %1\*.c >> %TARGET_FILE%.tmp
        dir /a-d/s/b %1\*.cxx >> %TARGET_FILE%.tmp
        dir /a-d/s/b %1\*.cpp >> %TARGET_FILE%.tmp
        dir /a-d/s/b %1\*.m >> %TARGET_FILE%.tmp
        dir /a-d/s/b %1\*.mm >> %TARGET_FILE%.tmp
    ) else (
        if exist %1 (
            dir /a-d/s/b %1 >> %TARGET_FILE%.tmp
        )
    )
)
shift /1
goto :SRC_DIR_LOOP
:SRC_DIR_LOOP_END

setlocal enabledelayedexpansion
del /s/q %TARGET_FILE%.tmp2 >nul 2>nul
>nul 2>nul (
    rem ensure file exist
    echo /* auto generated file */>%TARGET_FILE%.tmp2
    for /f "delims=" %%a in (%TARGET_FILE%.tmp) do (
        set v=#include "%%a"
        echo !v!>>%TARGET_FILE%.tmp2
    )
)
del /s/q %TARGET_FILE%.tmp >nul 2>nul
move %TARGET_FILE%.tmp2 %TARGET_FILE%.tmp >nul 2>nul

echo n|comp %TARGET_FILE% %TARGET_FILE%.tmp >nul 2>nul
if not "%errorlevel%" == "0" (
    rem changed
    del /s/q %TARGET_FILE% >nul 2>nul
    move %TARGET_FILE%.tmp %TARGET_FILE% >nul 2>nul
) else (
    rem not changed
)
del /s/q %TARGET_FILE%.tmp >nul 2>nul
del /s/q %TARGET_FILE%.tmp2 >nul 2>nul

