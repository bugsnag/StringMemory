//
//  SafeString.h
//  Universal
//
//  Created by Paul Zabelin on 6/21/19.
//  Copyright © 2019 Paul Zabelin. All rights reserved.
//

@import CoreFoundation;

const void * _Nullable SafeStringContents(CFStringRef _Nonnull str);
size_t getTaggedStringLength(const void * _Nonnull str);
BOOL isTaggedPointer(const void * _Nullable ptr);
BOOL taggedPointersEnabled(void);
void initializeTagPointers(void);
