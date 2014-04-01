//
//  UIColor+Extra.m
//  Halla
//
//  Created by Dominik Veselý on 3/10/12.
//  Copyright (c) 2012 CTU. All rights reserved.
//

#import "UIColor+Extra.h"
#import "ACKategories.h"


@implementation UIColor (Extra)

+ (UIColor *) randomColor
{
	CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
	CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
	CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}




+ (UIColor *)colorWithHex:(uint)color
{
    return [UIColor colorWithRed:(((color & 0xFF0000) >> 16)) / 255.0f
                           green:(((color & 0xFF00) >> 8)) / 255.0f
                            blue:((color & 0xFF)) / 255.0f
                           alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString;
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}





+ (UIColor *)darkerColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                               green:MAX(g - 0.2, 0.0)
                                blue:MAX(b - 0.2, 0.0)
                               alpha:a];
    return nil;
}

+ (UIColor *)lighterColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r + 0.2, 1.0)
                               green:MAX(g + 0.2, 1.0)
                                blue:MAX(b + 0.2, 1.0)
                               alpha:a];
    return nil;
}


@end


