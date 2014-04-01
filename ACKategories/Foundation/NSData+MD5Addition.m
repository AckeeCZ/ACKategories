//
//  NSData+MD5Addition.m
//  ACKategories
//
//  Created by Dominik Vesely on 01/04/14.
//  Copyright (c) 2014 Dominik Veselý. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "NSData+MD5Addition.h"

@implementation NSData (MD5Addition)
- (NSString *)md5Hash {
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(self.bytes, (uint) self.length, md5Buffer);
    
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}
@end
