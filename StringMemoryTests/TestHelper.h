//
//  TestHelper.h
//  StringMemoryTests
//
//  Created by Paul Zabelin on 6/23/19.
//  Copyright © 2019 Paul Zabelin. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN
@interface NSString (RegExMatch)
- (BOOL)matches:(NSString *)pattern;
@end

@interface NSObject (RegExMatch)
- (NSString *)className;
- (NSString *)ptrString;
- (BOOL)ptrMatches:(NSString *)pattern;
@end
NS_ASSUME_NONNULL_END

BOOL ios(NSInteger majorVersion);
