#!bash

WORK_DIR=$(cd "$(dirname "$0")"; pwd)
SRC_PATH=$1
DST_PATH=$2
if test "x$SRC_PATH" = "x" || test "x$DST_PATH" = "x" ; then
    echo $SRC_PATH
    echo $DST_PATH
    echo usage:
    echo   copy_check.sh SRC_PATH DST_PATH
    exit 1
fi

if test -d "$SRC_PATH" ; then
    mkdir -p "$DST_PATH" >/dev/null 2>/dev/null
    rsync -ru "$SRC_PATH/." "$DST_PATH/" >/dev/null 2>/dev/null
else
    mkdir -p $(dirname "$DST_PATH") >/dev/null 2>/dev/null
    rsync -ru "$SRC_PATH" "$DST_PATH" >/dev/null 2>/dev/null
fi

