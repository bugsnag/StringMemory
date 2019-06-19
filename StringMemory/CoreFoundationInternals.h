//
//  CoreFoundationInternals.h
//  StringMemory
//
//  Created by Paul Zabelin on 6/19/19.
//  Copyright © 2019 Paul Zabelin. All rights reserved.
//

#ifndef CoreFoundationInternals_h
#define CoreFoundationInternals_h

/**
 Copied from https://github.com/apple/swift-corelibs-foundation/blob/e216c6129ea5e08586ee718150db1d97ef73ca0b/CoreFoundation/Base.subproj/CFRuntime.h#L199 
 */
typedef struct __CFRuntimeBase {
    // This matches the isa and retain count storage in Swift
    uintptr_t _cfisa;
    uintptr_t _swift_rc;
    // This is for CF's use, and must match __NSCFType/_CFInfo layout
    _Atomic(uint64_t) _cfinfoa;
} CFRuntimeBase;

/**
 Copied from https://github.com/apple/swift-corelibs-foundation/blob/155f1ce1965effe55289477507a6f9fbdc8fe333/CoreFoundation/String.subproj/CFString.c#L152
 with disabled notInlineMutable union member
 */
struct __CFString {
    CFRuntimeBase base;
    union {    // In many cases the allocated structs are smaller than these
        struct __inline1 {
            CFIndex length;
        } inline1;                                      // Bytes follow the length
        struct __notInlineImmutable1 {
            void *buffer;                               // Note that the buffer is in the same place for all non-inline variants of CFString
            CFIndex length;
            CFAllocatorRef contentsDeallocator;        // Optional; just the dealloc func is used
        } notInlineImmutable1;                          // This is the usual not-inline immutable CFString
        struct __notInlineImmutable2 {
            void *buffer;
            CFAllocatorRef contentsDeallocator;        // Optional; just the dealloc func is used
        } notInlineImmutable2;                          // This is the not-inline immutable CFString when length is stored with the contents (first byte)
        //        struct __notInlineMutable notInlineMutable;
    } variants;
};

#endif /* CoreFoundationInternals_h */
