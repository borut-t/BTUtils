//
//  NSData+BTUtils.h
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

#import "UIView+BTUtils.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (BTUtils)

- (void)maskRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius
{
    // To round all corners, we can just set the radius on the layer
    if (corners == UIRectCornerAllCorners) {
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
    }
    else {
        // If we want to choose which corners we want to mask then
        // it is necessary to create a mask layer.
        
        // Create a CAShapeLayer
        CAShapeLayer *mask = [CAShapeLayer layer];
        
        // Set the frame
        mask.frame = self.bounds;
        
        // Set the CGPath from a UIBezierPath
        mask.path = [UIBezierPath bezierPathWithRoundedRect:mask.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)].CGPath;
        
        // Set the fill color
        mask.fillColor = [UIColor whiteColor].CGColor;
        
        self.layer.mask = mask;
    }
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

@end
