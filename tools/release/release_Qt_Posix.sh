#!bash

WORK_DIR=$(cd "$(dirname "$0")"; pwd)
ZF_ROOT_PATH=$WORK_DIR/../..
ZF_TOOLS_PATH=$ZF_ROOT_PATH/tools
QT_TYPE=Qt_Posix
RELEASE_PATH=$ZF_ROOT_PATH/_release/$QT_TYPE

rm -rf "$RELEASE_PATH" >/dev/null 2>/dev/null
find "$ZF_ROOT_PATH/_tmp/$QT_TYPE" -regex ".*/.*\.dll.*" 2>/dev/null | xargs rm >/dev/null 2>/dev/null
find "$ZF_ROOT_PATH/_tmp/$QT_TYPE" -regex ".*/.*\.a.*" 2>/dev/null | xargs rm >/dev/null 2>/dev/null
find "$ZF_ROOT_PATH/_tmp/$QT_TYPE" -regex ".*/.*\.so.*" 2>/dev/null | xargs rm >/dev/null 2>/dev/null
find "$ZF_ROOT_PATH/_tmp/$QT_TYPE" -regex ".*/.*\.dylib.*" 2>/dev/null | xargs rm >/dev/null 2>/dev/null

sh "$ZF_ROOT_PATH/thirdparty_setup.sh"
sh "$ZF_TOOLS_PATH/common/run_recursive.sh" "$ZF_ROOT_PATH" "zfautoscript_release_Qt_Posix*.sh"

