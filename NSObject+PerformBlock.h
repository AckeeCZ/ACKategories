
//
//  NSObject+PerformBlock.h
//  App4Fest
//
//  Created by Dominik Vesely on 11/7/12.
//  Copyright (c) 2012 Ackee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformBlock)

- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay;
- (void)fireBlockAfterDelay:(void (^)(void))block ;
@end
