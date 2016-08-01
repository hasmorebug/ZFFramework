@echo off
setlocal

set WORK_DIR=%~dp0
set ZF_ROOT_PATH=%~1%
set ZF_TOOLS_PATH=%ZF_ROOT_PATH%\tools
set QT_TYPE=Qt_Windows
set RELEASE_PATH=%ZF_ROOT_PATH%\_release\%QT_TYPE%

rem ZF dependency
rem call "%ZF_TOOLS_PATH%\common\run_recursive.bat" "%ZF_ROOT_PATH%" "zfautoscript_release_Qt_Windows_ZFDependencyLib.bat"

call "%ZF_TOOLS_PATH%\common\run_recursive.bat" "%ZF_ROOT_PATH%" "zfautoscript_release_Qt_Windows_ZFCore.bat"
call "%ZF_TOOLS_PATH%\common\run_recursive.bat" "%ZF_ROOT_PATH%" "zfautoscript_release_Qt_Windows_ZFAlgorithm.bat"
call "%ZF_TOOLS_PATH%\common\run_recursive.bat" "%ZF_ROOT_PATH%" "zfautoscript_release_Qt_Windows_ZFUtility.bat"


call "%ZF_TOOLS_PATH%\spec\Qt_Windows_release.bat" ZFUIKit %WORK_DIR%\..

