/**
 * @page DocTag_Tutorial_Serializable Serializable
 *
 * to make an object serializable is easy:
 * @code
 *   // extends from any ZFObject type, and implements from ZFSerializable
 *   zfclass MyObject : zfextends ZFObject, zfimplements ZFSerializable
 *   {
 *       ZFOBJECT_DECLARE(MyObject, ZFObject)
 *       ZFIMPLEMENTS_DECLARE(ZFSerializable)
 *
 *       // normal property value would be serialized automatically
 *       ZFPROPERTY_ASSIGN(zfindex, myProperty)
 *
 *       // object type property can be serialized automatically
 *       // if it's type of ZFSerializable
 *       ZFPROPERTY_RETAIN(SomeSerializable *, mySerializableProperty)
 *   };
 * @endcode
 * once declared, the object can be serialized by:
 * @code
 *   zfblockedAlloc(MyObject, obj);
 *   // serialize to an data holder,
 *   // which can be converted to raw data and write to file,
 *   // you may also convert it to xml or json or other data formats
 *   ZFSerializableData data = ZFObjectToSerializableData(obj);
 *
 *   // serialize object from existing data
 *   ZFObject *serializedObject = ZFObjectFromSerializableData(data);
 *   // the newly created object should be released manually
 *   zfRelease(serializedObject);
 * @endcode
 *
 * @section DocTag_Tutorial_Serializable_Advanced Advanced
 * if any of contents of your object can't be serialized automatically,
 * you may override some methods to supply your own serialize logic:
 * @code
 *   zfclass MyObject : zfextends ZFObject, zfimplements ZFSerializable
 *   {
 *       ZFOBJECT_DECLARE(MyObject, ZFObject)
 *       ZFIMPLEMENTS_DECLARE(ZFSerializable)
 *
 *   protected:
 *       virtual zfbool serializableOnSerializeCategoryFromData(ZF_IN const ZFSerializableData &ownerData,
 *                                                              ZF_OUT_OPT zfstring *outErrorHintToAppend = zfnull,
 *                                                              ZF_OUT_OPT const ZFSerializableData **outErrorPos = zfnull)
 *       {
 *           if(!zfsuperI(ZFSerializable)::serializableOnSerializeCategoryFromData(ownerData, outErrorHintToAppend, outErrorPos))
 *           {
 *               return zffalse;
 *           }
 *           // serialize your type from ownerData
 *           return zftrue;
 *       }
 *       virtual zfbool serializableOnSerializeCategoryToData(ZF_IN_OUT ZFSerializableData &ownerData,
 *                                                            ZF_IN ZFSerializable *referencedOwnerOrNull,
 *                                                            ZF_OUT_OPT zfstring *outErrorHintToAppend = zfnull)
 *       {
 *           if(!zfsuperI(ZFSerializable)::serializableOnSerializeCategoryToData(ownerData, outErrorHintToAppend, outErrorPos))
 *           {
 *               return zffalse;
 *           }
 *           // serialize your type to ownerData
 *           return zftrue;
 *       }
 *   private:
 *       YourNotSerializableType data;
 *   };
 * @endcode
 * for detailed usage, please refer to #ZFSerializable
 */
