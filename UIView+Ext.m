//
//  UIView+Ext.m
//  Halla
//
//  Created by Dominik Veselý on 3/15/12.
//  Copyright (c) 2012 CTU. All rights reserved.
//

#import "UIView+Ext.h"


@implementation UIView (Ext)

- (UIImage*) renderToImage
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); 
    return image;
}

@end
