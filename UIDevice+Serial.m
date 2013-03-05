//
//  UIDevice+Serial.m
//  A4E2012
//
//  Created by Dominik Vesely on 6/21/12.
//  Copyright (c) 2012 CTU. All rights reserved.
//

#import "UIDevice+Serial.h"
#include <sys/utsname.h>



@implementation UIDevice (Serial2)

// Utility method (private)
- (NSString*) platformCode {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString* platform =  [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    return platform;
}

// Public method to use
- (NSString*) platformName {
    NSString* platform = [self platformCode];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    
    return platform;
}

// Public method to use
- (PlatformType) platform {
    NSString *platform = [self platformCode];
    if ([platform isEqualToString:@"iPhone1,1"])    return kiPhone1G;
    if ([platform isEqualToString:@"iPhone1,2"])    return kiPhone3G;
    if ([platform isEqualToString:@"iPhone2,1"])    return kiPhone3GS;
    if ([platform isEqualToString:@"iPhone3,1"])    return kiPhone4;
    if ([platform isEqualToString:@"iPhone3,2"])    return kiPhone4Verizon;
    if ([platform isEqualToString:@"iPhone4,1"])    return kiPhone4S;
    if ([platform isEqualToString:@"iPhone5,1"])    return kiPhone5;
    if ([platform isEqualToString:@"iPod1,1"])      return kiPodTouch1G;
    if ([platform isEqualToString:@"iPod2,1"])      return kiPodTouch2G;
    if ([platform isEqualToString:@"iPod3,1"])      return kiPodTouch3G;
    if ([platform isEqualToString:@"iPod4,1"])      return kiPodTouch4G;
    if ([platform isEqualToString:@"iPad1,1"])      return kiPad;
    if ([platform isEqualToString:@"iPad2,1"])      return kiPad2Wifi;
    if ([platform isEqualToString:@"iPad2,2"])      return kiPad2GSM;
    if ([platform isEqualToString:@"iPad2,3"])      return kiPad2CMDA;
    if ([platform isEqualToString:@"i386"])         return kSimulator;
    
    return kUnknownPlatform;
}

@end
