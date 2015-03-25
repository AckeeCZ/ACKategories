//
//  UIImage+Color.h
//  App4Fest
//
//  Created by Dominik Vesely on 10/24/12.
//  Copyright (c) 2012 Ackee. All rights reserved.
//

#import <UIKit/UIKit.h>
#define COLOR_PART_RED(color)    (((color) >> 16) & 0xff)
#define COLOR_PART_GREEN(color)  (((color) >>  8) & 0xff)
#define COLOR_PART_BLUE(color)   ( (color)        & 0xff)

@interface UIImage (Color)

+ (UIImage*)setBackgroundImageByColor:(UIColor *)backgroundColor withFrame:(CGRect )rect;
+ (UIImage*) replaceColor:(UIColor*)color inImage:(UIImage*)image withTolerance:(float)tolerance;
+(UIImage *)changeWhiteColorTransparent: (UIImage *)image;
+(UIImage *)changeColorTo:(NSMutableArray*) array Transparent: (UIImage *)image;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
- (UIImage *)imageByRemovingColor:(uint)color;
- (UIImage *)imageByRemovingColorsWithMinColor:(uint)minColor maxColor:(uint)maxColor;
- (UIImage *)imageByReplacingColor:(uint)color withColor:(uint)newColor;
- (UIImage *)imageByReplacingColorsWithMinColor:(uint)minColor maxColor:(uint)maxColor withColor:(uint)newColor;
- (UIImage *)imageByReplacingColorsWithMinColor:(uint)minColor maxColor:(uint)maxColor withColor:(uint)newColor andAlpha:(float)alpha;
+ (UIImage*) imageWithColor:(UIColor*) color;

+(UIImage *) changeColorForImage:(UIImage *)image toColor:(UIColor*)color;


@end
