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
@import Universal;
#import "Universal/SafeString.h"

@interface StringMemoryTests : XCTestCase
@end

@implementation StringMemoryTests


- (void)testExample {
    
    NSString *testString = @"test";
    CFStringRef cfString = (__bridge CFStringRef)testString;
    char *internalString = (char *)SafeStringContents(cfString);
    XCTAssertEqual(0, strcmp(internalString, "test"), @"internal Core Foundation pointer should point to the same C string");
    NSLog(@"internal string value is printable: %s", internalString);
}

- (void)XtestNSTaggedPointerString {
    char* expected = "test";
    int expectedLength = (int)strlen(expected);
    CFStringRef stringPtr = CFStringCreateWithBytes(NULL, (uint8_t*)expected, expectedLength, kCFStringEncodingUTF8, FALSE);
    char *internalString = (char *)SafeStringContents(stringPtr);
    XCTAssertEqual(0, strcmp(internalString, "test"), @"internal Core Foundation pointer should point to the same C string");
}

@end
