/* ====================================================================== *
 * Copyright (c) 2010-2016 ZFFramework
 * home page: http://ZFFramework.com
 * blog: http://zsaber.com
 * contact: master@zsaber.com (Chinese and English only)
 * Distributed under MIT license:
 *   https://github.com/ZFFramework/ZFFramework/blob/master/license/license.txt
 * ====================================================================== */
/**
 * @file ZFUIButtonGroupBasic.h
 * @brief abstract button group management
 */

#ifndef _ZFI_ZFUIButtonGroupBasic_h_
#define _ZFI_ZFUIButtonGroupBasic_h_

#include "ZFUIButtonGroup.h"
#include "ZFUILinearLayout.h"
ZF_NAMESPACE_GLOBAL_BEGIN

// ============================================================
// ZFUIButtonGroupBasic
/**
 * @brief basic button group which layout buttons as #ZFUILinearLayout
 */
zfclass ZF_ENV_EXPORT ZFUIButtonGroupBasic : zfextends ZFUILinearLayout, zfimplements ZFUIButtonGroup
{
    ZFOBJECT_DECLARE(ZFUIButtonGroupBasic, ZFUILinearLayout)
    ZFIMPLEMENTS_DECLARE(ZFUIButtonGroup)
    ZFSTYLE_DEFAULT_DECLARE(ZFUIButtonGroupBasic)

public:
    ZFPROPERTY_OVERRIDE_INIT_STEP_DECLARE_ASSIGN(zfbool, buttonCheckable)
    {
        propertyValue = zftrue;
    }

    ZFPROPERTY_OVERRIDE_INIT_STEP_DECLARE_ASSIGN_NO_AUTO_INIT(ZFUIAlignFlags, buttonContentAlign)
    {
        propertyValue = ZFUIAlign::e_LeftInner;
    }

    ZFPROPERTY_OVERRIDE_INIT_STEP_DECLARE_RETAIN(ZFUIImageView *, buttonIconStyleNormal)
    {
        propertyValue.to<ZFUIImageView *>()->imageContentSet(ZFUIImageRes(zfText("ZFUIWidget/ZFUIButtonCheckBox_IconNormal.png")).to<ZFUIImage *>());
    }
    ZFPROPERTY_OVERRIDE_INIT_STEP_DECLARE_RETAIN_NO_AUTO_INIT(ZFUIImageView *, buttonIconStyleHighlighted)
    {
        propertyValue.to<ZFUIImageView *>()->imageContentSet(ZFUIImageRes(zfText("ZFUIWidget/ZFUIButtonCheckBox_IconHighlighted.png")).to<ZFUIImage *>());
    }
    ZFPROPERTY_OVERRIDE_INIT_STEP_DECLARE_RETAIN_NO_AUTO_INIT(ZFUIImageView *, buttonIconStyleChecked)
    {
        propertyValue.to<ZFUIImageView *>()->imageContentSet(ZFUIImageRes(zfText("ZFUIWidget/ZFUIButtonCheckBox_IconChecked.png")).to<ZFUIImage *>());
    }
    ZFPROPERTY_OVERRIDE_INIT_STEP_DECLARE_RETAIN_NO_AUTO_INIT(ZFUIImageView *, buttonIconStyleCheckedHighlighted)
    {
        propertyValue.to<ZFUIImageView *>()->imageContentSet(ZFUIImageRes(zfText("ZFUIWidget/ZFUIButtonCheckBox_IconCheckedHighlighted.png")).to<ZFUIImage *>());
    }

protected:
    zfoverride
    virtual inline void buttonOnAdd(ZF_IN ZFUIButton *button,
                                    ZF_IN zfindex buttonIndex)
    {
        this->childAdd(button, zfnull, buttonIndex);
        zfsuperI(ZFUIButtonGroup)::buttonOnAdd(button, buttonIndex);
    }
    zfoverride
    virtual inline void buttonOnRemove(ZF_IN ZFUIButton *button,
                                       ZF_IN zfindex buttonIndex)
    {
        this->childRemoveAtIndex(buttonIndex);
        zfsuperI(ZFUIButtonGroup)::buttonOnRemove(button, buttonIndex);
    }
};

ZF_NAMESPACE_GLOBAL_END
#endif // #ifndef _ZFI_ZFUIButtonGroupBasic_h_

