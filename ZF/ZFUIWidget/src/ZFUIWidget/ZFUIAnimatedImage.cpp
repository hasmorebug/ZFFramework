/* ====================================================================== *
 * Copyright (c) 2010-2016 ZFFramework
 * home page: http://ZFFramework.com
 * blog: http://zsaber.com
 * contact: master@zsaber.com (Chinese and English only)
 * Distributed under MIT license:
 *   https://github.com/ZFFramework/ZFFramework/blob/master/license/license.txt
 * ====================================================================== */
#include "ZFUIAnimatedImage.h"

ZF_NAMESPACE_GLOBAL_BEGIN

// ============================================================
ZFOBJECT_REGISTER(ZFUIAnimatedImageAniFrame)

// ============================================================
ZFSTYLE_DEFAULT_DEFINE(ZFUIAnimatedImage)

// ============================================================
// _ZFP_ZFUIAnimatedImagePrivate
zfclassNotPOD _ZFP_ZFUIAnimatedImagePrivate
{
public:
    ZFUIAnimatedImage *owner;
    zfbool aniRunning;
    zfindex aniFrameIndexLast;
    zfindex aniFrameIndexCurrent;
    zfindex aniRepeatCountCurrent;
    zfidentity aniFrameTaskId;
    ZFListener aniFramesOnChangeListener;
    ZFListener aniFrameDurationOnFinishListener;

public:
    _ZFP_ZFUIAnimatedImagePrivate(void)
    : owner(zfnull)
    , aniRunning(zffalse)
    , aniFrameIndexLast(zfindexMax)
    , aniFrameIndexCurrent(zfindexMax)
    , aniRepeatCountCurrent(0)
    , aniFrameTaskId(zfidentityInvalid)
    , aniFramesOnChangeListener(ZFCallbackForRawFunction(_ZFP_ZFUIAnimatedImagePrivate::aniFramesOnChange))
    , aniFrameDurationOnFinishListener(ZFCallbackForRawFunction(_ZFP_ZFUIAnimatedImagePrivate::aniFrameDurationOnFinish))
    {
    }

public:
    zfindex aniIndexNext(ZF_IN zfindex index)
    {
        return ((index + 1) % this->owner->aniFrames()->count());
    }
    void aniRunNext(void)
    {
        zfblockedRelease(zfRetain(this->owner));

        zfbool loopFinish = zffalse;
        if(this->aniFrameIndexLast != zfindexMax
            && this->aniFrameIndexCurrent == this->owner->aniFrames()->count() - 1)
        {
            loopFinish = zftrue;
        }

        do
        {
            this->aniFrameIndexLast = this->aniFrameIndexCurrent;
            this->aniFrameIndexCurrent = this->aniIndexNext(this->aniFrameIndexCurrent);
            this->owner->aniFrameOnUpdate();
            if(!this->aniRunning)
            {
                return ;
            }
        } while(this->owner->aniFrameDurationCurrent() == 0);

        if(loopFinish)
        {
            if(this->aniRepeatCountCurrent < this->owner->aniRepeatCount())
            {
                ++this->aniRepeatCountCurrent;
                this->owner->aniOnRepeat();
                if(!this->aniRunning)
                {
                    return ;
                }
            }
            else
            {
                this->owner->aniStop();
                return ;
            }
        }

        this->owner->aniOnUpdate();
        if(!this->aniRunning)
        {
            return ;
        }
        this->aniFrameTaskId = ZFThreadExecuteInMainThreadAfterDelay(
            this->owner->aniFrameDurationFixedCurrent(),
            this->aniFrameDurationOnFinishListener,
            this->owner->objectHolder());
    }

public:
    static ZFLISTENER_PROTOTYPE_EXPAND(aniFramesOnChange)
    {
        ZFUIAnimatedImage *owner = userData->to<ZFObjectHolder *>()->holdedObj;
        if(owner->aniRunning())
        {
            zfCoreCriticalMessageTrim(zfTextA("[ZFUIAnimatedImage] you must not modify aniFrame while animating"));
        }
    }
    static ZFLISTENER_PROTOTYPE_EXPAND(aniFrameDurationOnFinish)
    {
        ZFUIAnimatedImage *owner = userData->to<ZFObjectHolder *>()->holdedObj;
        owner->d->aniRunNext();
    }
};

// ============================================================
// ZFUIAnimatedImage
ZFOBJECT_REGISTER(ZFUIAnimatedImage)

void ZFUIAnimatedImage::aniStart(void)
{
    if(d->aniRunning || this->aniFrameCount() == 0)
    {
        return ;
    }
    d->aniRunning = zftrue;
    this->aniFrames()->observerAdd(ZFContainer::EventContentOnChange(), d->aniFramesOnChangeListener, this->objectHolder());
    zfRetain(this);

    d->aniRepeatCountCurrent = 0;
    if(!this->aniKeepPreviousState())
    {
        d->aniFrameIndexCurrent = zfindexMax;
    }

    d->aniRunNext();
}
void ZFUIAnimatedImage::aniStop(void)
{
    if(!d->aniRunning)
    {
        return ;
    }
    d->aniRunning = zffalse;
    this->aniFrames()->observerRemove(ZFContainer::EventContentOnChange(), d->aniFramesOnChangeListener);
    d->aniFrameIndexLast = zfindexMax;

    zfidentity aniFrameTaskIdTmp = d->aniFrameTaskId;
    d->aniFrameTaskId = zfidentityInvalid;
    ZFThreadExecuteCancel(aniFrameTaskIdTmp);

    zfRelease(this);
}
zfbool ZFUIAnimatedImage::aniRunning(void)
{
    return d->aniRunning;
}

ZFUIImage *ZFUIAnimatedImage::aniFrameImageCurrent(void)
{
    if(d->aniFrameIndexCurrent < this->aniFrames()->count())
    {
        return this->aniFrameImageAtIndex(d->aniFrameIndexCurrent);
    }
    else
    {
        return zfnull;
    }
}
zftimet ZFUIAnimatedImage::aniFrameDurationCurrent(void)
{
    if(d->aniFrameIndexCurrent < this->aniFrames()->count())
    {
        return this->aniFrameDurationAtIndex(d->aniFrameIndexCurrent);
    }
    else
    {
        return 0;
    }
}
zftimet ZFUIAnimatedImage::aniFrameDurationFixedCurrent(void)
{
    if(d->aniFrameIndexCurrent < this->aniFrames()->count())
    {
        return this->aniFrameDurationFixedAtIndex(d->aniFrameIndexCurrent);
    }
    else
    {
        return 0;
    }
}
ZFUIAnimatedImageAniFrame *ZFUIAnimatedImage::aniFrameCurrent(void)
{
    if(d->aniFrameIndexCurrent < this->aniFrames()->count())
    {
        return this->aniFrameAtIndex(d->aniFrameIndexCurrent);
    }
    else
    {
        return zfnull;
    }
}
zfindex ZFUIAnimatedImage::aniFrameIndexCurrent(void)
{
    if(d->aniFrameIndexCurrent < this->aniFrames()->count())
    {
        return d->aniFrameIndexCurrent;
    }
    else
    {
        return zfindexMax;
    }
}

zfindex ZFUIAnimatedImage::aniRepeatCountCurrent(void)
{
    return d->aniRepeatCountCurrent;
}

ZFObject *ZFUIAnimatedImage::objectOnInit(void)
{
    zfsuper::objectOnInit();
    d = zfpoolNew(_ZFP_ZFUIAnimatedImagePrivate);
    d->owner = this;
    return this;
}
void ZFUIAnimatedImage::objectOnDealloc(void)
{
    zfpoolDelete(d);
    d = zfnull;
    zfsuper::objectOnDealloc();
}

void ZFUIAnimatedImage::objectInfoOnAppend(ZF_IN_OUT zfstring &ret)
{
    zfsuper::objectInfoOnAppend(ret);

    zfstringAppend(ret, zfText(" %zi of %zi"), this->aniFrameIndexCurrent(), this->aniFrameCount());
    if(this->aniFrameCount() > 0)
    {
        for(zfindex i = 0; i < this->aniFrameCount(); ++i)
        {
            if(i == 0)
            {
                ret += zfText(" frames:");
            }
            zfstringAppend(ret, zfText(" %s"), zfsFromInt(this->aniFrameDurationFixedAtIndex(i)).cString());
        }
    }
}

ZF_NAMESPACE_GLOBAL_END

