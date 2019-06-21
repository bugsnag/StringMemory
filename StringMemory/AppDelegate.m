//
//  AppDelegate.m
//  StringMemory
//
//  Created by Paul Zabelin on 6/19/19.
//  Copyright © 2019 Paul Zabelin. All rights reserved.
//

#import "AppDelegate.h"
@import Universal;

@interface AppDelegate ()
@end

@implementation AppDelegate

- (void)verifyOnDevice {
    NSString *testString = @"test";
    CFStringRef cfString = (__bridge CFStringRef)testString;
    char *internalString = (char *)SafeStringContents(cfString);
    NSAssert(0 == strcmp(internalString, "test"), @"internal C string representation should be the same sting");
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self verifyOnDevice];
    return YES;
}

@end
