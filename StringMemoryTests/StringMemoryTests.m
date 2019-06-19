//
//  StringMemoryTests.m
//  StringMemoryTests
//
//  Created by Paul Zabelin on 6/19/19.
//  Copyright © 2019 Paul Zabelin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreFoundation/CoreFoundation.h>


@interface StringMemoryTests : XCTestCase

@end

@implementation StringMemoryTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    NSString *testString = @"test";
    CFStringRef cfString = (__bridge CFStringRef)testString;
    CFRuntimeBase theBase = cfString->base;
    NSLog(@"theBase");
//    XCTAssertTrue(theBase != 0);
    
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
