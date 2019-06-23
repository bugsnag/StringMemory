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
@import ObjectiveC.runtime;
#import "TestHelper.h"

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

NSString *pointerPattern = @"0x[0-9a-f]{9}";
NSString *taggedPointerPattern = @"0x[0-9a-f]{16}";

- (void)testExploreTaggedPointer {
    // Example from: https://www.mikeash.com/pyblog/friday-qa-2015-07-31-tagged-pointer-strings.html
    NSString *constString = @"a";
    NSString *taggedString = [[constString mutableCopy] copy];
    XCTAssertTrue([constString ptrMatches:pointerPattern]);
    if (ios(12)) {
        XCTAssertTrue([taggedString ptrMatches:taggedPointerPattern]);
        XCTAssertNotEqualObjects([taggedString ptrString], @"0xa000000000000611");
    } else {
        XCTAssertEqualObjects([taggedString ptrString], @"0xa000000000000611");
    }

    NSLog(@"%p %p %@", constString, taggedString, object_getClass(taggedString));
    XCTAssertEqualObjects(@"NSTaggedPointerString", NSStringFromClass(object_getClass(taggedString)));
}

@end
