//
//  UIImage+BTUtils.m
//
//  Version 1.3.5
//
//  Created by Borut Tomazin on 8/30/2013.
//  Copyright 2014 Borut Tomazin
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

#import "UIImage+BTUtils.h"

@implementation UIImage (BTUtils)

- (UIImage *)imageWithRoundedCornersRadius:(CGFloat)radius fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor
{
    // begin a new image that will be the new image with the rounded corners
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // add a clip before drawing anything, in the shape of an rounded rect
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    [bezier addClip];
    
    // fill background if color is set
    if (fillColor != nil) {
        [fillColor setFill];
        [bezier fill];
    }
    
    // draw your image
    [self drawInRect:rect];
    
    // draw border if color is set
    if (borderColor != nil) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGPathRef bezierPath = [bezier CGPath];
        CGContextSaveGState(context);
        CGContextSetLineWidth(context, 1.0f);
        CGContextSetStrokeColorWithColor(context, [borderColor CGColor]);
        CGContextAddPath(context, bezierPath);
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
    }
    
    // get the image
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor; // scale to fit height
        }
        else {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else {
            if (widthFactor < heightFactor) {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(targetSize, YES, 0.0);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if (newImage == nil) {
        NSLog(@"could not scale image");
    }
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)imageWithShadowSize:(CGFloat)size shadowColor:(UIColor *)color
{
    size = size * [UIScreen mainScreen].scale;
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef shadowContext = CGBitmapContextCreate(NULL,
                                                       self.size.width + 2.f*size,
                                                       self.size.height + 2.f*size,
                                                       CGImageGetBitsPerComponent(self.CGImage),
                                                       0,
                                                       colourSpace,
                                                       (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colourSpace);
    
    CGContextSetShadowWithColor(shadowContext, CGSizeMake(0, 0), size, color.CGColor);
    CGContextDrawImage(shadowContext, CGRectMake(size, size, self.size.width, self.size.height), self.CGImage);
    
    CGImageRef shadowedCGImage = CGBitmapContextCreateImage(shadowContext);
    CGContextRelease(shadowContext);
    
    UIImage *shadowedImage = [UIImage imageWithCGImage:shadowedCGImage];
    CGImageRelease(shadowedCGImage);
    
    return shadowedImage;
}

@end
