#!bash

WORK_DIR=$(cd "$(dirname "$0")"; pwd)
ZF_ROOT_PATH=$1
ZF_TOOLS_PATH=$ZF_ROOT_PATH/tools
RELEASE_PATH=$ZF_ROOT_PATH/_release/Android

# ZF dependency
# sh "$ZF_TOOLS_PATH/common/run_recursive.sh" "$ZF_ROOT_PATH" "zfautoscript_release_Android_ZFDependencyLib.sh"



sh "$ZF_TOOLS_PATH/spec/Android_release_lib.sh" ZFCore $WORK_DIR/..


