//
//  TestHelper.m
//  StringMemoryTests
//
//  Created by Paul Zabelin on 6/23/19.
//  Copyright © 2019 Paul Zabelin. All rights reserved.
//

#import "TestHelper.h"

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
@end

BOOL ios(NSInteger majorVersion) {
    NSOperatingSystemVersion iosVersion = (NSOperatingSystemVersion){majorVersion, 0, 0};
    return [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:iosVersion];
}
