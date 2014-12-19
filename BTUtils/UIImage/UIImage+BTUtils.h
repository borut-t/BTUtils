//
//  UIImage+BTUtils.h
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

#import <UIKit/UIKit.h>

@interface UIImage (BTUtils)

/**
 Returns image with rounded corners and border color.
 
 @param radius A radis to apply to round corners.
 @param fillColor (optional) A color to apply for the background (when image is transparent)
 @param borderColor (optional) A color to apply to border.
 */
- (UIImage *)imageWithRoundedCornersRadius:(CGFloat)radius fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor;

/**
 Returns scaled image for target size.
 @param targetSize Target size to scale image to.
 */
- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

/**
 Returns given image with opacity.
 @param alpha An alpha value set for opacity.
 */
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

/**
 Returns given image with shadow.
 @param size A width of the shadow.
 @param color Shadow color.
 */
- (UIImage *)imageWithShadowSize:(CGFloat)size shadowColor:(UIColor *)color;

@end
