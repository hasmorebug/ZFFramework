@echo off
setlocal

set WORK_DIR=%~dp0
set ZF_ROOT_PATH=%~1%
set ZF_TOOLS_PATH=%ZF_ROOT_PATH%\tools
set RELEASE_PATH=%ZF_ROOT_PATH%\_release\Android

rem ZF dependency
rem call "%ZF_TOOLS_PATH%\common\run_recursive.bat" "%ZF_ROOT_PATH%" "zfautoscript_release_Android_ZFDependencyLib.bat"



call "%ZF_TOOLS_PATH%\spec\Android_release_lib.bat" ZFCore %WORK_DIR%\..


