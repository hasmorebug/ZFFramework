# ======================================================================
# Copyright (c) 2010-2016 ZFFramework
# home page: http://ZFFramework.com
# blog: http://zsaber.com
# contact: master@zsaber.com (Chinese and English only)
# Distributed under MIT license:
#   https://github.com/ZFFramework/ZFFramework/blob/master/license/license.txt
# ======================================================================

# ======================================================================
# lib template to build ZFFramework lib
# ======================================================================

# ======================================================================
# ZF settings
# ======================================================================

# whether to build static lib
ZF_BUILD_STATIC_LIB = 0

# whether to use unity builds
# NOTE: you must ensure no Q_OBJECT used while unity builds enabled
ZF_UNITY_BUILD = 0

# ZFFramework's root path
ZF_ROOT_PATH = $$_PRO_FILE_PWD_/../../../../../../ZFFramework
ZF_TOOLS_PATH = $$ZF_ROOT_PATH/tools

# name of your project
ZF_PROJ_NAME = ZFCore_impl

# src path of your project
# can hold one or more paths, separated by space
ZF_PROJ_SRC_PATH =
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../src

# header path to copy to output
ZF_PROJ_HEADER_PATH = $$_PRO_FILE_PWD_/../../../src

# res path of your project
# can hold one or more paths, separated by space
ZF_PROJ_RES_PATH = $$_PRO_FILE_PWD_/../../../res

win32 {
    _ZF_QT_TYPE=Qt_Windows
}
unix:!macx {
    _ZF_QT_TYPE=Qt_Posix
}
macx {
    _ZF_QT_TYPE=Qt_MacOS
}


# ======================================================================
# your custom project settings here
# ======================================================================
# Qt modules
# QT += gui widgets
# QT += webkitwidgets

# ZF dependency
# LIBS += -L$$ZF_ROOT_PATH/_release/$$_ZF_QT_TYPE/all/lib -lZFDependencyLib

LIBS += -L$$ZF_ROOT_PATH/_release/$$_ZF_QT_TYPE/all/lib -lZFCore

LIBS += -L$$ZF_ROOT_PATH/_release/$$_ZF_QT_TYPE/all/lib -lZF_impl



# ======================================================================
# Qt project settings, no need to change for most case
# ======================================================================
INCLUDEPATH += $$_PRO_FILE_PWD_/../../../src
INCLUDEPATH += $$ZF_ROOT_PATH/_release/$$_ZF_QT_TYPE/all/include

QT += core

TARGET = $$ZF_PROJ_NAME
TEMPLATE = lib
equals(ZF_BUILD_STATIC_LIB, 1) {
    CONFIG += staticlib
}

QMAKE_CXXFLAGS += -Wno-unused-parameter
CONFIG += warn_off

win32 {
    DEFINES += ZF_ENV_EXPORT=__declspec(dllexport)
}


# ======================================================================
# no need to change these
# ======================================================================
CONFIG(debug, debug|release) {
    _ZF_BUILD_TYPE=debug
} else {
    _ZF_BUILD_TYPE=release
}

win32 {
    _ZF_copy_lib = $$shell_path($$ZF_TOOLS_PATH/common/copy_lib.bat)
    _ZF_copy_header = $$shell_path($$ZF_TOOLS_PATH/common/copy_header.bat)
    _ZF_copy_res = $$shell_path($$ZF_TOOLS_PATH/common/copy_res.bat)
} else {
    _ZF_copy_lib = sh $$shell_path($$ZF_TOOLS_PATH/common/copy_lib.sh)
    _ZF_copy_header = sh $$shell_path($$ZF_TOOLS_PATH/common/copy_header.sh)
    _ZF_copy_res = sh $$shell_path($$ZF_TOOLS_PATH/common/copy_res.sh)
}

win32 {
    _ZF_LIB_SRC_PATH = $$shell_path($$OUT_PWD/$$_ZF_BUILD_TYPE)
} else {
    _ZF_LIB_SRC_PATH = $$shell_path($$OUT_PWD)
}

# ======================================================================

equals(ZF_UNITY_BUILD, 1) {
    win32 {
        _ZF_unity_build_cmd = call $$shell_path($$ZF_TOOLS_PATH/common/unity_build.bat)
    } else {
        _ZF_unity_build_cmd = sh $$shell_path($$ZF_TOOLS_PATH/common/unity_build.sh)
    }
    for(src_path, ZF_PROJ_SRC_PATH) {
        _ZF_COMPILE_MODULE_NAME = $$src_path
        _ZF_COMPILE_MODULE_NAME = $$replace(_ZF_COMPILE_MODULE_NAME,[\\/\.:],_)
        _ZF_COMPILE_MODULE_NAME = $$replace(_ZF_COMPILE_MODULE_NAME,__+,_)
        _ZF_UNITY_BUILD_FILE = $$_PRO_FILE_PWD_/zfgensrc_$${ZF_PROJ_NAME}_$${_ZF_COMPILE_MODULE_NAME}.cpp
        system($$_ZF_unity_build_cmd $$shell_path($$_ZF_UNITY_BUILD_FILE) $$shell_path($$src_path))
        SOURCES += $$shell_path($$_ZF_UNITY_BUILD_FILE)
    }
} else {
    win32 {
        for(path, ZF_PROJ_SRC_PATH) {
            SOURCES += $$system("dir /s /b $$shell_path($$path\\*.cpp) 2>nul")
            HEADERS += $$system("dir /s /b $$shell_path($$path\\*.h) 2>nul")
            HEADERS += $$system("dir /s /b $$shell_path($$path\\*.hh) 2>nul")
            HEADERS += $$system("dir /s /b $$shell_path($$path\\*.hpp) 2>nul")
        }
    } else {
        for(path, ZF_PROJ_SRC_PATH) {
            SOURCES += $$system("find $$shell_path($$path) -name \*.cpp 2>/dev/null")
            HEADERS += $$system("find $$shell_path($$path) -name \*.h 2>/dev/null")
            HEADERS += $$system("find $$shell_path($$path) -name \*.hh 2>/dev/null")
            HEADERS += $$system("find $$shell_path($$path) -name \*.hpp 2>/dev/null")
        }
    }
}

CONFIG(debug, debug|release) {
    DEFINES += DEBUG
}

QMAKE_POST_LINK += $$_ZF_copy_lib $$ZF_PROJ_NAME $$shell_path($$_ZF_LIB_SRC_PATH) $$shell_path($$ZF_ROOT_PATH/_release/$$_ZF_QT_TYPE/module/$$ZF_PROJ_NAME/lib) $$escape_expand(\\n\\t)
for(path, ZF_PROJ_HEADER_PATH) {
    QMAKE_POST_LINK += $$_ZF_copy_header $$shell_path($$path) $$shell_path($$ZF_ROOT_PATH/_release/$$_ZF_QT_TYPE/module/$$ZF_PROJ_NAME/include) $$escape_expand(\\n\\t)
}
for(path, ZF_PROJ_RES_PATH) {
    QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$path) $$shell_path($$ZF_ROOT_PATH/_release/$$_ZF_QT_TYPE/module/$$ZF_PROJ_NAME/res) $$escape_expand(\\n\\t)
}

