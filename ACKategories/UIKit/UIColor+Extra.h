//
//  UIColor+Extra.h
//  Halla
//
//  Created by Dominik Veselý on 3/10/12.
//  Copyright (c) 2012 CTU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extra)

+ (UIColor *) randomColor;
+ (UIColor *) colorWithHex:(uint) hex;
+ (UIColor *)darkerColorForColor:(UIColor *)color;
@end
