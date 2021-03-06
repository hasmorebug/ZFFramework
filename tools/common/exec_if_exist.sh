#!bash

WORK_DIR=$(cd "$(dirname "$0")"; pwd)
SCRIPT_FILE=$1

if test "x$SCRIPT_FILE" = "x" ; then
    echo usage:
    echo   exec_if_exist.sh SCRIPT_FILE
    exit 1
fi

if test ! -e "$SCRIPT_FILE"; then
    exit 0
fi

sh "$SCRIPT_FILE" "${@:2}"

