//
//  BTUtils.h
//
//  Version 1.4.13
//
//  Created by Borut Tomazin on 8/30/2013.
//  Copyright 2015 Borut Tomazin
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/borut-t/BTUtils
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import <UIKit/UIKit.h>
//#import "NSString+BTUtils.h"
//#import "NSData+BTUtils.h"
//#import "UIImage+BTUtils.h"
//#import "UIView+BTUtils.h"
//#import "NSArray+BTUtils.h"
//#import "UIColor+BTUtils.h"
//#import "UINavigationController+BTUtils.h"
//#import "UITabBarController+BTUtils.h"

/** UIColor on-liner for native colorWithRed method without alpha. */
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
/** UIColor on-liner for native colorWithRed method with alpha. */
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
/** Checks if system version is greater than or equal to specific string version. */
#define SYSTEM_VERSION_GREATER_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
/** Converts radians to degrees. */
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
/** Converts degrees to radians. */
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
/** Checks if given key exists in given dict. */
#define IS_NOT_NULL(dictionary, key) ([dictionary objectForKey:key] && ![[dictionary objectForKey:key] isKindOfClass:[NSNull class]])
/** Checks if given array is array. */
#define IS_ARRAY(array) ([array isKindOfClass:[NSArray class]])
/** Checks if given dictionary is dictionary. */
#define IS_DICTIONARY(dict) (![dict isKindOfClass:[NSNull class]] || ![dict isKindOfClass:[NSDictionary class]])
/** Checks if given string is nil or zero length. */
#define IS_EMPTY(string) (string == nil || [string isKindOfClass:[NSNull class]] || [(NSString *)string length] == 0 || [(NSString *)string isEqualToString:@"null"])

/** Drop-in replacement for standard NSLog. */
#ifdef DEBUG
    #define BSLog(format, ...) NSLog((@"%s[%d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
    #define BSLog(...)
#endif

/** iPhone sizes. */
typedef NS_ENUM(NSUInteger, PhoneScreenSize) {
    PhoneScreenSizeUndefined=0,
    PhoneScreenSize3point5Inch,
    PhoneScreenSize4Inch,
    PhoneScreenSize4point7Inch,
    PhoneScreenSize5point5Inch
};

@interface BTUtils : NSObject

#pragma mark - Device
/** Returns the current version of the operating system. */
+ (NSString *)OSVersion;

/** Returns app version string using key 'CFBundleShortVersionString'. */
+ (NSString *)appVersion;

/** Returns app build string using key 'CFBundleVersion'. */
+ (NSString *)appBuild;

/** Returns app name string using key 'CFBundleDisplayName'. */
+ (NSString *)appName;

/** Returns device model. */
+ (NSString *)deviceModel;

/** Returns device screen size. */
+ (CGSize)screenSize;

/** Returns interface orienation. */
+ (UIInterfaceOrientation)orientation;

/** Returns YES when UIUserInterfaceIdiom is Pad. */
+ (BOOL)isPad;

/** Returns YES when UIUserInterfaceIdiom is Phone. */
+ (BOOL)isPhone;

/** Returns iPhone screen size. */
+ (PhoneScreenSize)phoneScreenSize;

/** 
 Returns YES if device is phone and 4inch (a.k.a. iPhone 5/5s/5c).
 @deprecated Use phoneScreenSize method to detect screen size instead.
 */
+ (BOOL)isPhone4Inch __attribute__((deprecated));

/** Returns YES if device screen has retina resolution. */
+ (BOOL)isRetina;

/** Returns YES if right-to-left system language is set. */
+ (BOOL)isRTL;

/** Returns the string representation of a specified CFUUID object. */
+ (NSString *)CFUUID;



#pragma mark - Other
/** Call this private instance method from the class you want to trace stack. */
+ (NSArray *)traceCallStack;

/** Call this private instance method from the class you want to trace class. */
+ (NSString *)traceCallClassWithDetails:(BOOL)withDetails;

/** Returns class property names. */
+ (NSArray *)propertyNamesForObject:(id)object;



#pragma mark - Network
/**
 Toggles network activity indicator.
 @param show A toggle boolean value defining network loader visibility.
 */
+ (void)showNetworkLoader:(BOOL)show;

/**
 Returns resource path for selected file name.
 @param name A file name represented on filesystem.
 */
+ (NSString *)resourcePath:(NSString *)name;

/**
 Returns App Store link for selected appId.
 @param appId And appId to generate App Store link with.
 */
+ (NSString *)appStoreLinkForAppId:(NSString *)appId;

/**
 Url encodes string.
 @param string An input string to be url encoded.
 */
+ (NSString *)urlEncodedString:(NSString *)string;



#pragma mark - Image
/**
 Returns uncached image from filesystem.
 @param name An image name to be loaded from the filesystem.
 @deprecated This method is not maintained anymore.
 */
+ (UIImage *)imageNamed:(NSString *)name __attribute__((deprecated));

/**
 Generates new UIImage with given color and size.
 @param color UIColor of the target image.
 @param size CGSize of the target image.
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

/**
 Captures screen for selected view.
 @param view View that is going to be captured.
 @return View screenshot.
 */
+ (UIImage *)captureView:(UIView *)view;

/**
 Captures frame inside selected view.
 @param frame Frame that is going to be captured.
 @param view View hosting frame.
 @return View frame screenshot.
 */
+ (UIImage *)captureFrame:(CGRect)frame inView:(UIView *)view;

@end
