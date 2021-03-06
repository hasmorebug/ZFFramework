#!bash

WORK_DIR=$(cd "$(dirname "$0")"; pwd)
ZF_ROOT_PATH=$1
ZF_TOOLS_PATH=$ZF_ROOT_PATH/tools
RELEASE_PATH=$ZF_ROOT_PATH/_release/iOS

# ZF dependency
# sh "$ZF_TOOLS_PATH/common/run_recursive.sh" "$ZF_ROOT_PATH" "zfautoscript_release_iOS_ZFDependencyLib.sh"

sh "$ZF_TOOLS_PATH/common/run_recursive.sh" "$ZF_ROOT_PATH" "zfautoscript_release_iOS_ZFCore.sh"
sh "$ZF_TOOLS_PATH/common/run_recursive.sh" "$ZF_ROOT_PATH" "zfautoscript_release_iOS_ZFAlgorithm.sh"
sh "$ZF_TOOLS_PATH/common/run_recursive.sh" "$ZF_ROOT_PATH" "zfautoscript_release_iOS_ZFUtility.sh"
sh "$ZF_TOOLS_PATH/common/run_recursive.sh" "$ZF_ROOT_PATH" "zfautoscript_release_iOS_ZFUIKit.sh"


sh "$ZF_TOOLS_PATH/spec/iOS_release.sh" ZFUIWebKit $WORK_DIR/..

