//
//  SafeString.m
//  Universal
//
//  Created by Paul Zabelin on 6/21/19.
//  Copyright © 2019 Paul Zabelin. All rights reserved.
//

#import "SafeString.h"
#import "CoreFoundationInternals.h"
#import "objc-internal.h"

BOOL isTaggedString(const void * _Nonnull str) {
    return isTaggedPointer(str) && _objc_getTaggedPointerTag(str) == OBJC_TAG_NSString;
}

size_t getTaggedStringLength(const void * _Nonnull str) {
    uintptr_t value = _objc_getTaggedPointerValue(str);
    return value & _OBJC_TAG_SLOT_MASK;
}


const void * _Nullable SafeStringContents(CFStringRef _Nonnull str) {
    if (isTaggedString(str)) {
        uintptr_t value = _objc_getTaggedPointerValue(str);
        return (void *)value;
    }
    CFRuntimeBase theBase = str->base;
    const void *internalString = (char *)theBase._cfinfoa;
    return internalString;
}

BOOL taggedPointersEnabled() {
    extern uintptr_t objc_debug_taggedpointer_mask;
    extern uintptr_t objc_debug_taggedpointer_obfuscator;
    return _objc_taggedPointersEnabled();
}

uintptr_t objc_debug_taggedpointer_obfuscator = 0;

void initializeTagPointers() {
    if (objc_debug_taggedpointer_obfuscator) {
        return;
    }
    const UInt8 bytes = 0x61;
    uintptr_t obfuscatedPtr = (uintptr_t)CFStringCreateWithBytes(NULL,
                                                                 &bytes,
                                                                 1,
                                                                 kCFStringEncodingUTF8,
                                                                 FALSE);
    uintptr_t unobfuscatedPtr = (uintptr_t)_objc_makeTaggedPointer(OBJC_TAG_NSString, bytes);
    objc_debug_taggedpointer_obfuscator = obfuscatedPtr ^ unobfuscatedPtr;
}

BOOL isTaggedPointer(const void * _Nullable ptr) {
    return _objc_isTaggedPointer(ptr);
}
