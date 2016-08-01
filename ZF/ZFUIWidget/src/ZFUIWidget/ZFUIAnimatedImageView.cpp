/* ====================================================================== *
 * Copyright (c) 2010-2016 ZFFramework
 * home page: http://ZFFramework.com
 * blog: http://zsaber.com
 * contact: master@zsaber.com (Chinese and English only)
 * Distributed under MIT license:
 *   https://github.com/ZFFramework/ZFFramework/blob/master/license/license.txt
 * ====================================================================== */
#include "ZFUIAnimatedImageView.h"

ZF_NAMESPACE_GLOBAL_BEGIN

// ============================================================
ZFSTYLE_DEFAULT_DEFINE(ZFUIAnimatedImageView)

// ============================================================
ZF_GLOBAL_INITIALIZER_INIT_WITH_LEVEL(ZFUIAnimatedImageViewDataHolder, ZFLevelZFFrameworkNormal)
{
    this->animatedImageOnUpdateListener = ZFCallbackForRawFunction(zfself::animatedImageOnUpdate);
}
public:
    ZFListener animatedImageOnUpdateListener;
    static ZFLISTENER_PROTOTYPE_EXPAND(animatedImageOnUpdate)
    {
        ZFUIAnimatedImageView *view = userData->to<ZFObjectHolder *>()->holdedObj;
        view->imageContentSet(view->animatedImage()->aniFrameImageCurrent());
    }
ZF_GLOBAL_INITIALIZER_END(ZFUIAnimatedImageViewDataHolder)

// ============================================================
// ZFUIAnimatedImageView
ZFOBJECT_REGISTER(ZFUIAnimatedImageView)

void ZFUIAnimatedImageView::objectOnInitFinish(void)
{
    zfsuper::objectOnInitFinish();
    this->animatedImage()->observerAdd(ZFUIAnimatedImage::EventAniFrameOnUpdate(),
        ZF_GLOBAL_INITIALIZER_INSTANCE(ZFUIAnimatedImageViewDataHolder)->animatedImageOnUpdateListener,
        this->objectHolder());
}
void ZFUIAnimatedImageView::objectOnDeallocPrepare(void)
{
    this->animatedImage()->observerRemove(ZFUIAnimatedImage::EventAniFrameOnUpdate(),
        ZF_GLOBAL_INITIALIZER_INSTANCE(ZFUIAnimatedImageViewDataHolder)->animatedImageOnUpdateListener);
    zfsuper::objectOnDeallocPrepare();
}

ZF_NAMESPACE_GLOBAL_END

