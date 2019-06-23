//
//  StringMemoryTests.m
//  StringMemoryTests
//
//  Created by Paul Zabelin on 6/19/19.
//  Copyright © 2019 Paul Zabelin. All rights reserved.
//

@import XCTest;
@import Universal;
#import "TestHelper.h"

@interface StringMemoryTests : XCTestCase
@end

@implementation StringMemoryTests

- (void)setUp {
    initializeTagPointers();
}

- (void)test__NSCFConstantString {
    
    NSString *testString = @"test";
    CFStringRef cfString = (__bridge CFStringRef)testString;
    char *internalString = (char *)SafeStringContents(cfString);
    XCTAssertEqual(0, strcmp(internalString, "test"), @"internal Core Foundation pointer should point to the same C string");
    NSLog(@"internal string value is printable: %s", internalString);
    XCTAssertEqualObjects(@"__NSCFConstantString", [testString className]);
}

-(CFStringRef)createStringWithBytes:(char *)expected {
    int expectedLength = (int)strlen(expected);
    return CFStringCreateWithBytes(NULL, (uint8_t*)expected, expectedLength, kCFStringEncodingUTF8, FALSE);
}

- (void)XtestNSTaggedPointerString {
    CFStringRef stringPtr = [self createStringWithBytes:"test"];
    char *internalString = (char *)SafeStringContents(stringPtr);
    XCTAssertEqual(0, strcmp(internalString, "test"), @"internal Core Foundation pointer should point to the same C string");
}

- (void)testStringLength {
    CFStringRef stringPtr = [self createStringWithBytes:"test"];
    XCTAssertEqual(4, getTaggedStringLength(stringPtr));
}

NSString *pointerPattern = @"0x[0-9a-f]{9}";
NSString *taggedPointerPattern = @"0x[0-9a-f]{16}";

- (void)testExploreTaggedPointer {
    // Example from: https://www.mikeash.com/pyblog/friday-qa-2015-07-31-tagged-pointer-strings.html
    NSString *constString = @"a";
    NSString *taggedString = [[constString mutableCopy] copy];
    NSLog(@"%p %p %@", constString, taggedString, [taggedString className]);

    XCTAssertTrue([constString ptrMatches:pointerPattern]);
    if (ios(12) || macos(14)) {
        XCTAssertTrue([taggedString ptrMatches:taggedPointerPattern]);
        XCTAssertNotEqualObjects([taggedString ptrString], @"0xa000000000000611");
        XCTAssertNotEqualObjects([taggedString ptrString], @"0x6115");
    } else {
        #if TARGET_OS_OSX
                XCTAssertEqualObjects([taggedString ptrString], @"0x6115");
        #else
                XCTAssertEqualObjects([taggedString ptrString], @"0xa000000000000611");
        #endif
    }
    XCTAssertTrue(taggedPointersEnabled());
    XCTAssertTrue(isTaggedPointer((__bridge const void * _Nullable)(taggedString)));

    XCTAssertEqualObjects(@"NSTaggedPointerString", [taggedString className]);
}

@end
