//
//  UIView+BTUtils.h
//
//  Version 1.4.2
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

/** Returns horizontally centered x coordinate for given child width in parent frame. */
static inline CGFloat CGHorizontalCenterInParent(CGRect frame, CGFloat childWidth) {
    return frame.size.width / 2 - childWidth / 2;
}

/** Returns vertically centered y coordinate for given child height in parent frame. */
static inline CGFloat CGVerticalCenterInParent(CGRect frame, CGFloat childHeight) {
    return frame.size.height / 2 - childHeight / 2;
}

/** Returns centered frame for given child width and height in parent frame. */
static inline CGRect CGCenterInParent(CGRect parent, CGFloat childWidth, CGFloat childHeight) {
    return CGRectMake(CGHorizontalCenterInParent(parent, childWidth), CGVerticalCenterInParent(parent, childHeight), childWidth, childHeight);
}

@interface UIView (BTUtils)

/**
 Returns masked view with rounded corners.
 @param corners A bitmask value that identifies the corners that you want rounded. You can use this parameter to round only a subset of the corners of the rectangle.
 @param radius A radius value applied to mask.
 */
- (void)maskRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius;

/**
 Returns dashed line/view.
 @param color A color to apply to dashes.
 */
- (void)dashedLineWithColor:(UIColor *)color;

/** Gets frame size. */
- (CGSize)size;

/**
 Sets frame size.
 @param size Frame size.
 */
- (void)setSize:(CGSize)size;

/** Gets frame width. */
- (CGFloat)width;

/**
 Sets frame width.
 @param width Frame width.
 */
- (void)setWidth:(CGFloat)width;

/** Gets frame height. */
- (CGFloat)height;

/**
 Sets frame height.
 @param height Frame height.
 */
- (void)setHeight:(CGFloat)height;

/** Gets frame x origin. */
- (CGFloat)x;

/**
 Sets frame x origin.
 @param originX origin.x.
 */
- (void)setX:(CGFloat)originX;

/**
 Gets frame y origin.
 */
- (CGFloat)y;

/**
 Sets frame y origin.
 @param originY origin.y.
 */
- (void)setY:(CGFloat)originY;

@end
