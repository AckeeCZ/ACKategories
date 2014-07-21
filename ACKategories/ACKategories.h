//
//  ACKategories.h
//  ACKategories
//
//  Created by Dominik Vesely on 01/04/14.
//  Copyright (c) 2014 Dominik Veselý. All rights reserved.
//

//UIKit
#import <UIBarButtonItem+Buttons.h>
#import <UIButton+Buttons.h>
#import <UIColor+Extra.h>
#import <UIControl+Blocks.h>
#import <UIDevice+IdentifierAddition.h>
#import <UIDevice+Serial.h>
#import <UIGestureRecognizer+Blocks.h>
#import <UIImage+Alpha.h>
#import <UIImage+Color.h>
#import <UIImage+Resize.h>
#import <UIImage+RoundedCorner.h>
#import <UIView+Actions.h>
#import <UIWebView+Blocks.h>
#import <UIView+Ext.h>

//Foundations

#import <NSArray+Access.h>
#import <NSArray+Blocks.h>
#import <NSDictionary+Blocks.h>
#import <NSDictionary+Intersection.h>
#import <NSDictionary+Types.h>
#import <NSDictionary+URLParams.h>
#import <NSLock+Blocks.h>
#import <NSMutableDictionary+ConditionalSet.h>
#import <NSObject+Creation.h>
#import <NSObject+Marker.h>
#import "NSObject+PerformBlock.h"
#import <NSOperationQueue+WorkerQueue.h>
#import <NSSet+Blocks.h>
#import <NSSet+Intersection.h>
#import <NSString+MD5Addition.h>
#import <NSString+URLEncode.h>
#import <NSURL+Parameters.h>
#import <Stack.h>
#import <NSData+MD5Addition.h>
#import <NSDateComponents+namedWeekday.h>
#import <NSObject+Creation.h>
#import <NSObject+Marker.h>
#import <NSObject+PerformBlock.h>
#import <NSOperationQueue+WorkerQueue.h>

#define kClearColor [UIColor clearColor]
/*
 blockSelf
 */

#define DEFINE_BLOCK_SELF       __weak __typeof__(self) blockSelf = self

/*
 GCD Singleton
 */

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
\
return _sharedObject;

/*
 Asserts
 */

#define ASSERT_MAIN_THREAD     NSAssert([[NSThread currentThread] isMainThread], @"This method must be called on the main thread.")

/*
 Logging
 */

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#ifdef DEBUG
#define TRC_ENTRY    NSLog(@"ENTRY: %s:%d", __PRETTY_FUNCTION__, __LINE__)
#define TRC_EXIT     NSLog(@"EXIT : %s:%d", __PRETTY_FUNCTION__, __LINE__)
#else
#define TRC_ENTRY
#define TRC_EXIT
#endif

#ifdef DEBUG
#define TRC_POINT(A)    NSLog(@"POINT: %f, %f", A.x, A.y)
#define TRC_SIZE(A)     NSLog(@"SIZE: %f, %f", A.width, A.height)
#define TRC_RECT(A)     NSLog(@"RECT: %f, %f, %f, %f", A.origin.x, A.origin.y, A.size.width, A.size.height)
#else
#define TRC_POINT(A)
#define TRC_SIZE(A)
#define TRC_RECT(A)
#endif

#ifdef DEBUG
#define TRC_STR(A)              NSLog(@"%@", A)
#define TRC_OBJ(A)              NSLog(@"%@", [A description])
#define TRC_LOG(format, ...)    NSLog(format, ## __VA_ARGS__)
#define TRC_ERR(format, ...)    NSLog(@"error: %@, %s:%d " format, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __FUNCTION__, __LINE__, ## __VA_ARGS__)
#else
#define TRC_STR(A)
#define TRC_OBJ(A)
#define TRC_LOG(format, ...)
#define TRC_ERR(format, ...)    NSLog(@"error: %@, %s:%d " format, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __FUNCTION__, __LINE__, ## __VA_ARGS__)
#endif

#ifdef DEBUG
#define TRC_DATA(A)    NSLog(@"DATA %10db: %@", [A length], [[NSString alloc] initWithData:A encoding:NSUTF8StringEncoding])
#else
#define TRC_DATA(A)
#endif


//macros
#define width(a) a.frame.size.width
#define height(a) a.frame.size.height
#define top(a) a.frame.origin.y
#define left(a) a.frame.origin.x
#define FrameReposition(a,x,y) a.frame = CGRectMake(x, y, width(a), height(a))
#define FrameResize(a,w,h) a.frame = CGRectMake(left(a), top(a), w, h)
#define CMLog(format, ...) NSLog(@&amp;quot;%s:%@&amp;quot;, __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__]);
#define MARK	CMLog(@&amp;quot;%s&amp;quot;, __PRETTY_FUNCTION__);
#define START_TIMER NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
#define END_TIMER(msg) 	NSTimeInterval stop = [NSDate timeIntervalSinceReferenceDate]; CMLog([NSString stringWithFormat:@&amp;quot;%@ Time = %f&amp;quot;, msg, stop-start]);

#define APP_NAME [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]
#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
#define OPEN_URL(urlString) [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:urlString]]

// Retrieving preference values
#define PREF_KEY_VALUE(x) [[[NSUserDefaultsController sharedUserDefaultsController] values] valueForKey:(x)]
#define PREF_KEY_BOOL(x) [(PREF_KEY_VALUE(x)) boolValue]
#define PREF_SET_KEY_VALUE(x, y) [[[NSUserDefaultsController sharedUserDefaultsController] values] setValue:(y) forKey:(x)]
#define PREF_OBSERVE_VALUE(x, y) [[NSUserDefaultsController sharedUserDefaultsController] addObserver:y forKeyPath:x options:NSKeyValueObservingOptionOld context:nil];

#define ApplicationDelegate ((MyAppDelegate *)[[UIApplication sharedApplication] delegate])
#define UserDefaults [NSUserDefaults standardUserDefaults]
#define SharedApplication [UIApplication sharedApplication]
#define Bundle [NSBundle mainBundle]
#define MainScreen [UIScreen mainScreen]
#define ShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define NetworkActivityIndicatorVisible(x) [UIApplication sharedApplication].networkActivityIndicatorVisible = x
#define NavBar self.navigationController.navigationBar
#define TabBar self.tabBarController.tabBar
#define NavBarHeight self.navigationController.navigationBar.bounds.size.height
#define TabBarHeight self.tabBarController.tabBar.bounds.size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define TouchHeightDefault 44
#define TouchHeightSmall 32
#define ViewWidth(v) v.frame.size.width
#define ViewHeight(v) v.frame.size.height
#define ViewX(v) v.frame.origin.x
#define ViewY(v) v.frame.origin.y
#define SelfViewWidth self.view.bounds.size.width
#define SelfViewHeight self.view.bounds.size.height
#define RectX(f) f.origin.x
#define RectY(f) f.origin.y
#define RectWidth(f) f.size.width
#define RectHeight(f) f.size.height
#define RectSetWidth(f, w) CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h) CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x) CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y) CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))
#define RectSetSize(f, w, h) CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y) CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define DATE_COMPONENTS NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit
#define TIME_COMPONENTS NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
#define FlushPool(p) [p drain]; p = [[NSAutoreleasePool alloc] init]
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]