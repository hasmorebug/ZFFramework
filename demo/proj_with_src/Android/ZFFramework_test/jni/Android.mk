# ======================================================================
# Copyright (c) 2010-2016 ZFFramework
# home page: http://ZFFramework.com
# blog: http://zsaber.com
# contact: master@zsaber.com (Chinese and English only)
# Distributed under MIT license:
#   https://github.com/ZFFramework/ZFFramework/blob/master/license/license.txt
# ======================================================================

LOCAL_PATH := $(call my-dir)

ifeq ($(OS),Windows_NT)
    ZF_ROOT_PATH = ..\..\..\..\..\ZFFramework
    $(info $(shell call ..\..\..\ZFSetup.bat))
    $(info $(shell call $(ZF_ROOT_PATH)\thirdparty_setup.bat))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\common\exec_if_exist.bat ..\..\..\..\thirdparty\thirdparty_setup.bat))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\common\exec_if_exist.bat ..\..\..\..\thirdparty\thirdparty_release_Android_check.bat))

    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat ..\..\..\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_fix.bat assets\res >nul 2>nul))

    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZFCore\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZFAlgorithm\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZFUtility\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZFUIKit\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZFAddition\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZFUIWidget\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZFUIWebKit\res assets\res >nul 2>nul))

    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZF_impl\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZF_loader_impl\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZFCore_impl\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZFAlgorithm_impl\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZFUtility_impl\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZFUIKit_impl\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZFAddition_impl\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZFUIWidget_impl\res assets\res >nul 2>nul))
    $(info $(shell call $(ZF_ROOT_PATH)\tools\spec\Android\res_copy.bat $(ZF_ROOT_PATH)\ZF\ZFUIWebKit_impl\res assets\res >nul 2>nul))
else
    ZF_ROOT_PATH = ../../../../../ZFFramework
    $(info $(shell sh ../../../ZFSetup.sh))
    $(info $(shell sh $(ZF_ROOT_PATH)/thirdparty_setup.sh))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/common/exec_if_exist.sh ../../../../thirdparty/thirdparty_setup.sh))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/common/exec_if_exist.sh ../../../../thirdparty/thirdparty_release_Android_check.sh))

    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh ../../../res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_fix.sh assets/res >/dev/null 2>/dev/null))

    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZFCore/res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZFAlgorithm/res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZFUtility/res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZFUIKit/res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZFAddition/res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZFUIWidget/res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZFUIWebKit/res assets/res >/dev/null 2>/dev/null))

    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZF_impl/res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZF_loader_impl/res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZFCore_impl/res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZFAlgorithm_impl/res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZFUtility_impl/res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZFUIKit_impl/res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZFAddition_impl/res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZFUIWidget_impl/res assets/res >/dev/null 2>/dev/null))
    $(info $(shell sh $(ZF_ROOT_PATH)/tools/spec/Android/res_copy.sh $(ZF_ROOT_PATH)/ZF/ZFUIWebKit_impl/res assets/res >/dev/null 2>/dev/null))
endif

include jni/jni_ZFFramework_test/Android.mk

