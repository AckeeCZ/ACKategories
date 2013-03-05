//
//  UIDevice+Serial.h
//  A4E2012
//
//  Created by Dominik Vesely on 6/21/12.
//  Copyright (c) 2012 CTU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Serial2)

typedef enum {
    kUnknownPlatform = 0,
    kiPhone1G,
    kiPhone3G,
    kiPhone3GS,
    kiPhone4,
    kiPhone4Verizon,
    kiPhone4S,
    kiPhone5,
    kiPodTouch1G,
    kiPodTouch2G,
    kiPodTouch3G,
    kiPodTouch4G,
    kiPad,
    kiPad2Wifi,
    kiPad2GSM,
    kiPad2CMDA,
    kSimulator
} PlatformType;

- (NSString *) platformName;
- (PlatformType) platform;
- (NSString *) platformCode;


@end
