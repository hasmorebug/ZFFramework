#!bash

WORK_DIR=$(cd "$(dirname "$0")"; pwd)
ZF_ROOT_PATH=$1
ZF_TOOLS_PATH=$ZF_ROOT_PATH/tools
QT_TYPE=Qt_MacOS
RELEASE_PATH=$ZF_ROOT_PATH/_release/$QT_TYPE

# ZF dependency
# sh "$ZF_TOOLS_PATH/common/run_recursive.sh" "$ZF_ROOT_PATH" "zfautoscript_release_Qt_MacOS_ZFDependencyLib.sh"

sh "$ZF_TOOLS_PATH/common/run_recursive.sh" "$ZF_ROOT_PATH" "zfautoscript_release_Qt_MacOS_ZFCore.sh"


sh "$ZF_TOOLS_PATH/spec/Qt_MacOS_release.sh" ZF_impl $WORK_DIR/..

