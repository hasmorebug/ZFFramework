@echo off
setlocal

set WORK_DIR=%~dp0
set ZF_ROOT_PATH=%~1%
set ZF_TOOLS_PATH=%ZF_ROOT_PATH%\tools

call "%ZF_TOOLS_PATH%\common\cleanup_proj.bat" "%WORK_DIR%\..\proj" "ZFCore"
call "%ZF_TOOLS_PATH%\common\cleanup_proj.bat" "%WORK_DIR%\..\proj" "ZFCore_jni"
