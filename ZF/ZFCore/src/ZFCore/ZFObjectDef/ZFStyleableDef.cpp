/* ====================================================================== *
 * Copyright (c) 2010-2016 ZFFramework
 * home page: http://ZFFramework.com
 * blog: http://zsaber.com
 * contact: master@zsaber.com (Chinese and English only)
 * Distributed under MIT license:
 *   https://github.com/ZFFramework/ZFFramework/blob/master/license/license.txt
 * ====================================================================== */
#include "ZFStyleableDef.h"
#include "ZFClassUtilDef.h"
#include "ZFListenerDeclareDef.h"
#include "ZFObjectUtilDef.h"
#include "ZFObjectUtilTypeDef.h"
#include "ZFObjectSmartPointerDef.h"

ZF_NAMESPACE_GLOBAL_BEGIN

ZFStyleable *ZFStyleable::defaultStyle(void)
{
    if(this->_ZFP_ZFStyleable_defaultStyleCache == zfnull)
    {
        const ZFMethod *method = this->classData()->methodForName(zfText("DefaultStyleReflect"));
        if(method != zfnull)
        {
            this->_ZFP_ZFStyleable_defaultStyleCache = method->executeClassStatic<ZFStyleable *>();
        }
    }
    return this->_ZFP_ZFStyleable_defaultStyleCache;
}

// ============================================================
zfclass _ZFP_ZFStyleable_PropertyTypeHolder : zfextends ZFObject
{
    ZFOBJECT_DECLARE(_ZFP_ZFStyleable_PropertyTypeHolder, ZFObject)

public:
    ZFCoreArrayPOD<const ZFProperty *> normalProperty;
    ZFCoreArrayPOD<const ZFProperty *> styleableProperty;
    ZFCoreArrayPOD<const ZFProperty *> copyableProperty;
};

// ============================================================
void ZFStyleable::styleableCopyFrom(ZF_IN ZFStyleable *anotherStyleable)
{
    if(anotherStyleable == zfnull)
    {
        return ;
    }
    _ZFP_ZFStyleable_PropertyTypeHolder *holderTmp = this->_ZFP_ZFStyleable_getPropertyTypeHolder();
    const ZFClass *thisCls = this->classData();
    const ZFClass *anotherCls = anotherStyleable->classData();
    ZFObject *anotherStyleableObject = anotherStyleable->toObject();;
    const ZFProperty *property = zfnull;

    for(zfindex i = holderTmp->normalProperty.count() - 1; i != zfindexMax; --i)
    {
        property = holderTmp->normalProperty[i];
        if(!anotherCls->classIsTypeOf(property->ownerClass()))
        {
            continue;
        }
        if(!thisCls->_ZFP_ZFClass_propertyInitStepIsTheSame(property, anotherCls)
            || property->callbackIsValueAccessed(property, anotherStyleableObject))
        {
            this->styleableOnCopyPropertyFrom(anotherStyleable, property, ZFStyleable::PropertyTypeNormal);
        }
    }
    for(zfindex i = holderTmp->styleableProperty.count() - 1; i != zfindexMax; --i)
    {
        property = holderTmp->styleableProperty[i];
        if(!anotherCls->classIsTypeOf(property->ownerClass()))
        {
            continue;
        }
        if(!thisCls->_ZFP_ZFClass_propertyInitStepIsTheSame(property, anotherCls)
            || property->callbackIsValueAccessed(property, anotherStyleableObject))
        {
            this->styleableOnCopyPropertyFrom(anotherStyleable, property, ZFStyleable::PropertyTypeStyleable);
        }
    }
    for(zfindex i = holderTmp->copyableProperty.count() - 1; i != zfindexMax; --i)
    {
        property = holderTmp->copyableProperty[i];
        if(!anotherCls->classIsTypeOf(property->ownerClass()))
        {
            continue;
        }
        if(!thisCls->_ZFP_ZFClass_propertyInitStepIsTheSame(property, anotherCls)
            || property->callbackIsValueAccessed(property, anotherStyleableObject))
        {
            this->styleableOnCopyPropertyFrom(anotherStyleable, property, ZFStyleable::PropertyTypeCopyable);
        }
    }

    this->styleableOnCopyFrom(anotherStyleable);
}
ZFStyleable::PropertyType ZFStyleable::styleableOnCheckPropertyType(ZF_IN const ZFProperty *property)
{
    if(!property->propertyReflectable)
    {
        return ZFStyleable::PropertyTypeNotStyleable;
    }
    if(property->propertyIsRetainProperty()
        && property->setterMethod()->methodPrivilegeType() == ZFMethodPrivilegeTypePrivate
        && property->getterMethod()->methodPrivilegeType() != ZFMethodPrivilegeTypePrivate)
    {
        if(property->propertyClassOfRetainProperty()->classIsTypeOf(ZFStyleable::ClassData()))
        {
            return ZFStyleable::PropertyTypeStyleable;
        }
        else if(property->propertyClassOfRetainProperty()->classIsTypeOf(ZFCopyable::ClassData()))
        {
            return ZFStyleable::PropertyTypeCopyable;
        }
    }
    if(property->setterMethod()->methodPrivilegeType() == ZFMethodPrivilegeTypePrivate
        || property->getterMethod()->methodPrivilegeType() == ZFMethodPrivilegeTypePrivate)
    {
        return ZFStyleable::PropertyTypeNotStyleable;
    }
    return ZFStyleable::PropertyTypeNormal;
}

void ZFStyleable::styleableOnCopyPropertyFrom(ZF_IN ZFStyleable *anotherStyleable,
                                              ZF_IN const ZFProperty *property,
                                              ZF_IN ZFStyleable::PropertyType propertyType)
{
    switch(propertyType)
    {
        case ZFStyleable::PropertyTypeNormal:
        {
            property->callbackCopy(property, this->toObject(), anotherStyleable->toObject());
        }
            break;
        case ZFStyleable::PropertyTypeStyleable:
        {
            ZFStyleable *selfPropertyValue = ZFCastZFObject(ZFStyleable *, property->callbackRetainGet(property, this->toObject()));
            ZFStyleable *anotherPropertyValue = ZFCastZFObject(ZFStyleable *, property->callbackRetainGet(property, anotherStyleable->toObject()));
            if(selfPropertyValue != zfnull && anotherPropertyValue != zfnull)
            {
                selfPropertyValue->styleableCopyFrom(anotherPropertyValue);
            }
        }
            break;
        case ZFStyleable::PropertyTypeCopyable:
        {
            ZFCopyable *selfPropertyValue = ZFCastZFObject(ZFCopyable *, property->callbackRetainGet(property, this->toObject()));
            ZFObject *anotherPropertyValue = property->callbackRetainGet(property, anotherStyleable->toObject());
            if(selfPropertyValue != zfnull && anotherPropertyValue != zfnull)
            {
                selfPropertyValue->copyFrom(anotherPropertyValue);
            }
        }
            break;
        case ZFStyleable::PropertyTypeNotStyleable:
        default:
            zfCoreCriticalShouldNotGoHere();
            return ;
    }
}

_ZFP_ZFStyleable_PropertyTypeHolder *ZFStyleable::_ZFP_ZFStyleable_getPropertyTypeHolder(void)
{
    ZFCoreMutexLocker();
    if(_ZFP_ZFStyleable_propertyTypeHolder == zfnull)
    {
        _ZFP_ZFStyleable_propertyTypeHolder = this->classData()->classTagGet<_ZFP_ZFStyleable_PropertyTypeHolder *>(
            _ZFP_ZFStyleable_PropertyTypeHolder::ClassData()->className());
        if(_ZFP_ZFStyleable_propertyTypeHolder == zfnull)
        {
            zflockfree_zfblockedAllocWithoutLeakTest(_ZFP_ZFStyleable_PropertyTypeHolder, holderTmp);

            const ZFCoreArrayPOD<const ZFProperty *> allProperty = ZFClassUtil::allProperty(this->classData());
            const ZFProperty *propertyTmp = zfnull;
            for(zfindex i = 0; i < allProperty.count(); ++i)
            {
                propertyTmp = allProperty[i];
                switch(this->styleableOnCheckPropertyType(propertyTmp))
                {
                    case ZFStyleable::PropertyTypeNotStyleable:
                        break;
                    case ZFStyleable::PropertyTypeNormal:
                        holderTmp->normalProperty.add(propertyTmp);
                        break;
                    case ZFStyleable::PropertyTypeStyleable:
                        holderTmp->styleableProperty.add(propertyTmp);
                        break;
                    case ZFStyleable::PropertyTypeCopyable:
                        holderTmp->copyableProperty.add(propertyTmp);
                        break;
                }
            }

            _ZFP_ZFStyleable_propertyTypeHolder = holderTmp;
            this->classData()->classTagSet(
                _ZFP_ZFStyleable_PropertyTypeHolder::ClassData()->className(),
                holderTmp);
        }
    }
    return _ZFP_ZFStyleable_propertyTypeHolder;
}

// ============================================================
ZFOBJECT_REGISTER(ZFStyleableObject)

// ============================================================
ZF_STATIC_INITIALIZER_INIT_WITH_LEVEL(ZFStyleableDefaultStyleDataHolder, ZFLevelZFFrameworkEssential)
{
}
ZFCoreMap instanceDataMap; // _ZFP_ZFStyleableDefaultPointerHolder *
ZF_STATIC_INITIALIZER_END(ZFStyleableDefaultStyleDataHolder)

_ZFP_ZFStyleableDefaultPointerHolder *_ZFP_ZFStyleableDefaultRefAccess(ZF_IN const zfchar *name)
{
    ZFCoreMutexLocker();
    ZFCoreMap &m = ZF_STATIC_INITIALIZER_INSTANCE(ZFStyleableDefaultStyleDataHolder)->instanceDataMap;
    ZFCorePointerBase *v = m.get(name);
    if(v == zfnull)
    {
        m.set(name, ZFCorePointerForObject<_ZFP_ZFStyleableDefaultPointerHolder *>(zfnew(_ZFP_ZFStyleableDefaultPointerHolder)));
        v = m.get(name);
    }
    return v->pointerValueT<_ZFP_ZFStyleableDefaultPointerHolder *>();
}

ZF_NAMESPACE_GLOBAL_END

