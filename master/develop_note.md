# Intro

this file is written as a note for developers that want to know the mechanism of ZFFramework

# Contents

## Abbreviations

there are many abbreviations in ZFFramework which keep code style and you should follow:

* `_ZFP_` : `ZF Private` contents, should not be used for public
* `_ZFP_I_` : `ZF Private Internal` contents, which won't be logged by global observers and leak tests
* `_ZFI_` : `ZF Include`, dummy macro to wrap headers
* `_ZFT_` : `ZF Type`, used to mark macro defined types
* `zfs` : `ZF String`, core string utils
* `zfm` : `ZF Math`, core math utils


## ZFCastZFObject

we use ZFCastZFObject for dynamic type cast, instead of traditional dynamic_cast

the main reason for that is the performance, ZFFramework use multi-inheritance to simulate interface logic,
which would cause deep inherit tree, which cause dynamic_cast to be very slow

secondly, it reduce the dependency of RTTI, which is not much necessary for ZFFramework


## string type

we use zfstring as low level string container, which is reproduce of std::string

* to reduce dependency for STL, usually it's a pain to export STL containers because of different STL versions
* change to reference count logic to suit ZFFramework

for app level, we use ZFString/ZFStringEditable to hold strings,
whose actual impl depends on platform impl,
and may have better performance when integrated with UI
(considering a UI text view holding a large amount of text)

in short, zfstring is more convenient in cpp wolrd and has better performance for small string operations,
while ZFString suits the situation that interacting with native impls


# ZFCoreArray/ZFCoreMap

we use ZFCoreArray as low level array/list container, and ZFCoreMap for map/unordered_map,
mainly to reduce dependency for STL

however, the performance is not so good comparing to STL containers,
for performance, we would still use STL containers as internal types,
but make sure it won't be visible to public interface


## Styles

ZFFramework supply powerful serialization and style logic,
however, it cost much CPU for property comparing and copying

so, for performance, most of styleable object won't copy it's default style during init,
and most of default style are hard coded, only images are loaded from resource

