//
//  NSString+Base64.h
//  A4E2012
//
//  Created by Dominik Veselý on 5/18/12.
//  Copyright (c) 2012 CTU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

+ (NSString *) base64StringFromData:(NSData *)data length:(int)length;


@end
