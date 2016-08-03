# ======================================================================
# Copyright (c) 2010-2016 ZFFramework
# home page: http://ZFFramework.com
# blog: http://zsaber.com
# contact: master@zsaber.com (Chinese and English only)
# Distributed under MIT license:
#   https://github.com/ZFFramework/ZFFramework/blob/master/license/license.txt
# ======================================================================

# ======================================================================
# app template for ZFFramework
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
ZF_ROOT_PATH = $$_PRO_FILE_PWD_/../../../../../ZFFramework
ZF_TOOLS_PATH = $$ZF_ROOT_PATH/tools

# name of your project
ZF_PROJ_NAME = ZFFramework_test

# build path
ZF_BUILD_PATH = $$_PRO_FILE_PWD_/../../../../_tmp

# src path of your project
# can hold one or more paths, separated by space
ZF_PROJ_SRC_PATH =
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../src

ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZFCore/src
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZFAlgorithm/src
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZFUtility/src
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZFUIKit/src
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZFAddition/src
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZFUIWidget/src
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZFUIWebKit/src

ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZF_impl/src
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZF_loader_impl/src
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZFCore_impl/src
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZFAlgorithm_impl/src
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZFUtility_impl/src
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZFUIKit_impl/src
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZFAddition_impl/src
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZFUIWidget_impl/src
ZF_PROJ_SRC_PATH += $$_PRO_FILE_PWD_/../../../../../ZFFramework/ZF/ZFUIWebKit_impl/src

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
win32 {
    system(call $$shell_path($$_PRO_FILE_PWD_/../../../ZFSetup.bat))
}
unix {
    system(sh $$shell_path($$_PRO_FILE_PWD_/../../../ZFSetup.sh))
}

# Qt modules
# QT += gui widgets
# QT += webkitwidgets
QT += gui widgets
QT += webkitwidgets


# ======================================================================
# Qt project settings, no need to change for most case
# ======================================================================
INCLUDEPATH += $$_PRO_FILE_PWD_/../../../src

QT += core

TARGET = $$ZF_PROJ_NAME
TEMPLATE = app

QMAKE_CXXFLAGS += -Wno-unused-parameter
CONFIG += warn_off

exists($${ZF_PROJ_NAME}.ico) {
    RC_ICONS = $${ZF_PROJ_NAME}.ico
}
exists($${ZF_PROJ_NAME}.icns) {
    ICON = $${ZF_PROJ_NAME}.icns
}


# ======================================================================
# no need to change these
# ======================================================================
win32 {
    _ZF_QT_TYPE=Qt_Windows
    _ZF_SCRIPT_CALL=call
    _ZF_SCRIPT_EXT=bat
}
unix:!macx {
    _ZF_QT_TYPE=Qt_Posix
    _ZF_SCRIPT_CALL=sh
    _ZF_SCRIPT_EXT=sh
}
macx {
    _ZF_QT_TYPE=Qt_MacOS
    _ZF_SCRIPT_CALL=sh
    _ZF_SCRIPT_EXT=sh
}

system($${_ZF_SCRIPT_CALL} $$shell_path($$ZF_ROOT_PATH/thirdparty_setup.$${_ZF_SCRIPT_EXT}))
system($${_ZF_SCRIPT_CALL} $$shell_path($$ZF_TOOLS_PATH/common/exec_if_exist.$${_ZF_SCRIPT_EXT} $$_PRO_FILE_PWD_/../../../../thirdparty/thirdparty_setup.$${_ZF_SCRIPT_EXT}))
system($${_ZF_SCRIPT_CALL} $$shell_path($$ZF_TOOLS_PATH/common/exec_if_exist.$${_ZF_SCRIPT_EXT} $$_PRO_FILE_PWD_/../../../../thirdparty/thirdparty_release_$${_ZF_QT_TYPE}_check.$${_ZF_SCRIPT_EXT}))

CONFIG(debug, debug|release) {
    _ZF_BUILD_TYPE=debug
} else {
    _ZF_BUILD_TYPE=release
}

DESTDIR = $$ZF_BUILD_PATH/$$ZF_PROJ_NAME/$$_ZF_QT_TYPE/$$_ZF_BUILD_TYPE
OBJECTS_DIR = $${DESTDIR}/.obj
MOC_DIR = $${DESTDIR}/.moc
RCC_DIR = $${DESTDIR}/.rcc
UI_DIR = $${DESTDIR}/.ui

win32 {
    _ZF_copy_res = $$shell_path($$ZF_TOOLS_PATH/common/copy_res.bat)
    _ZF_install_lib = $$shell_path($$ZF_TOOLS_PATH/common/install_lib.bat)
} else {
    _ZF_copy_res = sh $$shell_path($$ZF_TOOLS_PATH/common/copy_res.sh)
    _ZF_install_lib = sh $$shell_path($$ZF_TOOLS_PATH/common/install_lib.sh)
}

equals(ZF_BUILD_STATIC_LIB, 1) {
    _ZF_install_lib = echo
}

win32 {
    _ZF_RES_DEPLOY_PATH=$$shell_path($$DESTDIR/res)
    _ZF_LIB_DEPLOY_PATH=$$shell_path($$DESTDIR/.)
}
unix:!macx {
    _ZF_RES_DEPLOY_PATH=$$shell_path($$DESTDIR/res)
    _ZF_LIB_DEPLOY_PATH=$$shell_path($$DESTDIR/.)
}
macx {
    _ZF_RES_DEPLOY_PATH=$$shell_path($$DESTDIR/"$$TARGET".app/Contents/Resources/res)
    _ZF_LIB_DEPLOY_PATH=$$shell_path($$DESTDIR/"$$TARGET".app/Contents/Frameworks)
}

equals(ZF_BUILD_STATIC_LIB, 1) {
    macx {
        _ZF_LINKER_FLAGS = -Wl,-all_load
    } else {
        _ZF_LINKER_FLAGS = -Wl,--whole-archive
    }
} else {
    _ZF_LINKER_FLAGS =
}

# ======================================================================
# lib dependency
# ======================================================================
# ZF dependency
# LIBS += -L$$ZF_ROOT_PATH/_release/$$_ZF_QT_TYPE/all/lib -lZFDependencyLib


INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZFCore/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZFCore/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)

INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZFAlgorithm/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZFAlgorithm/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)

INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZFUtility/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZFUtility/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)

INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZFUIKit/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZFUIKit/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)

INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZFAddition/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZFAddition/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)

INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZFUIWidget/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZFUIWidget/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)

INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZFUIWebKit/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZFUIWebKit/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)


INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZF_impl/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZF_impl/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)

INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZF_loader_impl/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZF_loader_impl/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)

INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZFCore_impl/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZFCore_impl/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)

INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZFAlgorithm_impl/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZFAlgorithm_impl/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)

INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZFUtility_impl/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZFUtility_impl/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)

INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZFUIKit_impl/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZFUIKit_impl/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)

INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZFAddition_impl/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZFAddition_impl/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)

INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZFUIWidget_impl/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZFUIWidget_impl/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)

INCLUDEPATH += $$ZF_ROOT_PATH/ZF/ZFUIWebKit_impl/src
QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$ZF_ROOT_PATH/ZF/ZFUIWebKit_impl/res) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)


# ======================================================================
# no need to change these
# ======================================================================
exists(qt_main.cpp) {
    SOURCES += qt_main.cpp
}

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
        _ZF_UNITY_BUILD_FILE = zfgensrc_$${ZF_PROJ_NAME}_$${_ZF_COMPILE_MODULE_NAME}.cpp
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

for(path, ZF_PROJ_RES_PATH) {
    QMAKE_POST_LINK += $$_ZF_copy_res $$shell_path($$path) $$_ZF_RES_DEPLOY_PATH $$escape_expand(\\n\\t)
}

equals(ZF_BUILD_STATIC_LIB, 0) {
    unix:!macx {
        QMAKE_LFLAGS += -Wl,--rpath=${ORIGIN}
    }
}

macx {
    QMAKE_POST_LINK += macdeployqt $$shell_path($$DESTDIR/"$$TARGET".app) >/dev/null 2>/dev/null $$escape_expand(\\n\\t)
}

