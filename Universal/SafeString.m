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

const void * _Nonnull SafeStringContents(CFStringRef _Nonnull str) {
    CFRuntimeBase theBase = str->base;
    const void *internalString = (char *)theBase._cfinfoa;
    return internalString;
}

BOOL isTaggedPointer(const void * _Nullable ptr) {
    return _objc_isTaggedPointer(ptr);
}
