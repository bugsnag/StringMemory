//
//  StringMemoryTests.m
//  StringMemoryTests
//
//  Created by Paul Zabelin on 6/19/19.
//  Copyright © 2019 Paul Zabelin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreFoundation/CoreFoundation.h>
#import "CoreFoundationInternals.h"


@interface StringMemoryTests : XCTestCase
@end

@implementation StringMemoryTests


- (void)testExample {
    NSString *testString = @"test";
    CFStringRef cfString = (__bridge CFStringRef)testString;
    CFRuntimeBase theBase = cfString->base;
    char *internalString = (char *)theBase._cfinfoa;
    XCTAssertEqual(0, strcmp(internalString, "test"), @"internal Core Foundation pointer should point to the same C string");
    NSLog(@"internal string value is printable: %s", internalString);
}

@end
