//
//  TestHelper.m
//  StringMemoryTests
//
//  Created by Paul Zabelin on 6/23/19.
//  Copyright © 2019 Paul Zabelin. All rights reserved.
//

#import "TestHelper.h"
@import ObjectiveC.runtime;

@implementation NSString (RegExMatch)
- (BOOL)matches:(NSString *)pattern {
    NSPredicate *matchPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [matchPredicate evaluateWithObject:self];
}
@end

@implementation NSObject (RegExMatch)
- (NSString *)ptrString {
    return [NSString stringWithFormat:@"%p", self];
}

- (BOOL)ptrMatches:(NSString *)pattern {
    return [[self ptrString] matches:pattern];
}

- (NSString *)className {
    return NSStringFromClass(object_getClass(self));
}
@end

BOOL ios(NSInteger majorVersion) {
#if TARGET_OS_IPHONE
    NSOperatingSystemVersion iosVersion = (NSOperatingSystemVersion){majorVersion, 0, 0};
    return [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:iosVersion];
#else
    return NO;
#endif
}

BOOL macos(NSInteger minorVersion) {
#if TARGET_OS_OSX
    NSOperatingSystemVersion osVersion = (NSOperatingSystemVersion){10, minorVersion, 0};
    return [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:osVersion];
#else
    return NO;
#endif
}
