//
//  SafeString.m
//  Universal
//
//  Created by Paul Zabelin on 6/21/19.
//  Copyright © 2019 Paul Zabelin. All rights reserved.
//

#import "SafeString.h"
#import "CoreFoundationInternals.h"

const void * SafeStringContents(CFStringRef str) {
    CFRuntimeBase theBase = str->base;
    const void *internalString = (char *)theBase._cfinfoa;
    return internalString;
}
