//
//  NSData+Compressions.m
//  A4E2012
//
//  Created by Dominik Veselý on 5/19/12.
//  Copyright (c) 2012 CTU. All rights reserved.
//

#import "NSData+Compressions.h"
#import <zlib.h>


@implementation NSData (Compressions)

- (NSData* )zlibInflate{
    if ([self length] == 0) return self;    
    unsigned full_length = [self length]; unsigned half_length = [self length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength:full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm; 
    strm.next_in = (Bytef *)[self bytes]; 
    strm.avail_in = [self length];
    strm.total_out = 0; 
    strm.zalloc = Z_NULL; 
    strm.zfree = Z_NULL;
    
    if (inflateInit (&strm) != Z_OK) return nil;
    
    while (!done) {
        if (strm.total_out >= [decompressed length]) [decompressed increaseLengthBy: half_length]; strm.next_out = [decompressed mutableBytes] + strm.total_out; strm.avail_out = [decompressed length] - strm.total_out;
        
        status = inflate (&strm, Z_SYNC_FLUSH); if (status == Z_STREAM_END) done = YES; else if (status != Z_OK) break; } if (inflateEnd (&strm) != Z_OK) return nil;
        
         if (done) {
             [decompressed setLength: strm.total_out];
             return [NSData dataWithData:decompressed];
         } else {
             return nil;   
         }
}
       /* 
        - (NSData* )zlibDeflate { if ([self length] == 0) return self;
            
            z_stream strm;
            
            strm.zalloc = Z_NULL; strm.zfree = Z_NULL; strm.opaque = Z_NULL; strm.total_out = 0; strm.next_in=(Bytef )[self bytes]; strm.avail_in = [self length];
            
            // Compresssion Levels: // Z_NO_COMPRESSION // Z_BEST_SPEED // Z_BEST_COMPRESSION // Z_DEFAULT_COMPRESSION
            
            if (deflateInit(&strm, Z_DEFAULT_COMPRESSION) != Z_OK) return nil;
            
            NSMutableData* compressed = [[[NSMutableData]] dataWithLength:16384]; // 16K chuncks for expansion
            
            do {
                
                if (strm.total_out >= [compressed length]) [compressed increaseLengthBy: 16384];
                
                strm.next_out = [compressed mutableBytes] + strm.total_out; strm.avail_out = [compressed length] - strm.total_out;
                
                deflate(&strm, Z_FINISH);
                
            } while (strm.avail_out == 0);
            
            deflateEnd(&strm);
            
            [compressed setLength: strm.total_out]; return [[[NSData]] dataWithData: compressed]; } 
*/
@end
