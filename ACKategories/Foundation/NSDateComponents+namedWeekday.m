//
//  NSDateComponents+namedWeekday.m
//  App4Fest
//
//  Created by Dominik Vesely on 10/24/12.
//  Copyright (c) 2012 Ackee. All rights reserved.
//

#import "NSDateComponents+namedWeekday.h"

@implementation NSDateComponents (namedWeekday)

- (NSString *)namedWeekday {
    NSString* key = [NSString stringWithFormat:@"WEEKDAY_%ld",(long)self.weekday];
    return NSLocalizedString(key,@"");    
}

@end
