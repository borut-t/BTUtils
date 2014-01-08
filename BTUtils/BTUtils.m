//
//  BTUtils.m
//
//  Version 1.3
//
//  Created by Borut Tomazin on 8/30/2013.
//  Copyright 2013 Borut Tomazin
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

#import "BTUtils.h"

@implementation BTUtils


#pragma mark - Device
+ (NSString *)OSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)deviceModel
{
    return [[UIDevice currentDevice] model];
}

+ (CGSize)screenSize
{
    return [[UIScreen mainScreen] bounds].size;
}

+ (UIInterfaceOrientation)orientation
{
    return [[UIApplication sharedApplication] statusBarOrientation];
}

+ (BOOL)isPad
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+ (BOOL)isPhone
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

+ (BOOL)isPhone4Inch
{
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        return YES;
    }
    return NO;
}

+ (BOOL)isRetina 
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        return [[UIScreen mainScreen] scale] == 2.0 ? YES : NO;
    }
    return NO;
}

+ (NSString *)CFUUID
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"cfuuid"] == nil) {
        CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
        [userDefaults setObject:(__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject) forKey:@"cfuuid"];
        CFRelease(uuidObject);
    }
    
    return [userDefaults objectForKey:@"cfuuid"];
}



#pragma mark - Network
+ (void)showNetworkLoader:(BOOL)show
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = show;
}

+ (BOOL)isReachable
{
    return !([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable);
}

+ (NSString *)resourcePath:(NSString *)name
{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@",name];
}

+ (NSString *)appStoreLinkForAppId:(NSString *)appId
{
    return [NSString stringWithFormat:@"http://itunes.apple.com/si/app/id%@?mt=8",appId];
}

+ (NSString *)urlEncodedString:(NSString *)string
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge_retained CFStringRef)string,NULL,(CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",kCFStringEncodingUTF8);
}



#pragma mark - Image
+ (UIImage *)imageNamed:(NSString *)name
{
    static const NSString *sufixes[] = {
        @"@2x",
        @"~ipad",
        @"@2x~ipad",
        @"-568h@2x"
    };
    
    NSString *baseName = [name stringByDeletingPathExtension];
    NSString *ext = [name pathExtension];
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    UIImage *ret = nil;
    NSString *fileName = nil;
    
    //iPad
    if ([self isPad]) {
        if ([self isRetina]) {
            fileName = [self resourcePath:[NSString stringWithFormat:@"%@%@.%@", baseName, sufixes[2], ext]];
            if (![fm fileExistsAtPath:fileName]) {
                fileName = [self resourcePath:name];
            }
        }
        else {
            fileName = [self resourcePath:[NSString stringWithFormat:@"%@%@.%@", baseName, sufixes[1], ext]];
            if (![fm fileExistsAtPath:fileName]) {
                fileName = [self resourcePath:name];
            }
        }
    }
    //iPhone
    else {
        //iPhone 5
        if ([self isPhone4Inch]) {
            fileName = [self resourcePath:[NSString stringWithFormat:@"%@%@.%@", baseName, sufixes[3], ext]];
            if (![fm fileExistsAtPath:fileName]) {
                fileName = [self resourcePath:name];
            }
        }
        //iPhone retina
        else if ([self isRetina]) {
            fileName = [self resourcePath:[NSString stringWithFormat:@"%@%@.%@", baseName, sufixes[0], ext]];
            if (![fm fileExistsAtPath:fileName]) {
                fileName = [self resourcePath:name];
            }
        }
        //iPhone non-retina
        else {
            fileName = [self resourcePath:name];
        }
    }
    
    if (![fm fileExistsAtPath:fileName]) {
        BSLog(@"File does not exist for image: %@",name);
        return nil;
    }
    
    ret = [[UIImage alloc] initWithContentsOfFile:fileName];
    
    if (!ret) {
        BSLog(@"Could not load image: %@", name);
        return ret;
    }
    return ret;
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)captureView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)captureFrame:(CGRect)frame inView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(frame.size, view.opaque, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, -frame.origin.x, -frame.origin.y);
    [view.layer renderInContext:ctx];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
