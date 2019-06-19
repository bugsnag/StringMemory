//
//  AppDelegate.m
//  StringMemory
//
//  Created by Paul Zabelin on 6/19/19.
//  Copyright © 2019 Paul Zabelin. All rights reserved.
//

#import "AppDelegate.h"

typedef struct __CFRuntimeBase {
    // This matches the isa and retain count storage in Swift
    uintptr_t _cfisa;
    uintptr_t _swift_rc;
    // This is for CF's use, and must match __NSCFType/_CFInfo layout
    _Atomic(uint64_t) _cfinfoa;
} CFRuntimeBase;

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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *testString = @"test";
    CFStringRef cfString = (__bridge CFStringRef)testString;
    CFRuntimeBase theBase = cfString->base;
    NSLog(@"theBase");

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
