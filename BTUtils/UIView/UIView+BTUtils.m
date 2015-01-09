//
//  UIView+BTUtils.h
//
//  Version 1.4.3
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

#import "UIView+BTUtils.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (BTUtils)

- (void)maskRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius
{
    if (corners == UIRectCornerAllCorners) {
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
    }
    else {
        CGRect rect = self.bounds;
        CGFloat minx = CGRectGetMinX(rect);
        CGFloat midx = CGRectGetMidX(rect);
        CGFloat maxx = CGRectGetMaxX(rect);
        CGFloat miny = CGRectGetMinY(rect);
        CGFloat midy = CGRectGetMidY(rect);
        CGFloat maxy = CGRectGetMaxY(rect);
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, minx, midy);
        CGPathAddArcToPoint(path, nil, minx, miny, midx, miny, (corners & UIRectCornerTopLeft) ? radius : 0);
        CGPathAddArcToPoint(path, nil, maxx, miny, maxx, midy, (corners & UIRectCornerTopRight) ? radius : 0);
        CGPathAddArcToPoint(path, nil, maxx, maxy, midx, maxy, (corners & UIRectCornerBottomRight) ? radius : 0);
        CGPathAddArcToPoint(path, nil, minx, maxy, minx, midy, (corners & UIRectCornerBottomLeft) ? radius : 0);
        CGPathCloseSubpath(path);
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = path;
        self.layer.mask = maskLayer;
        
        CFRelease(path);
    }
}

- (void)pulseEffectToSize:(CGFloat)size duration:(CGFloat)duration
{
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = duration;
    pulseAnimation.toValue = [NSNumber numberWithFloat:size];
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = FLT_MAX;
    
    [self.layer addAnimation:pulseAnimation forKey:nil];
}

- (void)dashedLineWithColor:(UIColor *)color
{
    self.backgroundColor = [UIColor clearColor];
    
    UIBezierPath *dashPath = [UIBezierPath bezierPath];
    [dashPath moveToPoint:CGPointMake(0.f, self.height/2.f)];
    [dashPath addLineToPoint:CGPointMake(self.width, self.height/2.f)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineWidth = self.height;
    shapeLayer.lineJoin = kCALineJoinMiter;
    shapeLayer.lineDashPattern = @[@1, @1];
    shapeLayer.path = dashPath.CGPath;
    
    if (self.layer.sublayers.count > 0) {
        [self.layer.sublayers[0] removeFromSuperlayer];
    }
    [self.layer addSublayer:shapeLayer];
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
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)x;
{
    return CGRectGetMinX(self.frame);
}

- (void)setX:(CGFloat)originX
{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}

- (CGFloat)y
{
    return CGRectGetMinY(self.frame);
}

- (void)setY:(CGFloat)originY
{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}

@end