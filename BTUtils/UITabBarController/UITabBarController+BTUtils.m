//
//  UITabBarController+BTUtils.m
//
//  Version 1.4.12
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

#import "UITabBarController+BTUtils.h"

static CGFloat const kAnimationInterval = 0.3;
static CGFloat const kTabBarHeight = 49.f;

@implementation UITabBarController (BTUtils)

BOOL tabBarIsInTransition = NO;

- (BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

- (void)showTabBarAnimated:(BOOL)animated
{
    if (tabBarIsInTransition || !self.tabBar.hidden) {
        return;
    }
    self.tabBar.hidden = NO;
    tabBarIsInTransition = YES;
    
    [UIView animateWithDuration:(animated ? kAnimationInterval : 0) animations:^{
        for (UIView *view in self.view.subviews) {
            if ([view isKindOfClass:[UITabBar class]]) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y-kTabBarHeight, view.frame.size.width, view.frame.size.height)];
            }
            else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height-kTabBarHeight)];
            }
        }
    } completion:^(BOOL finished) {
        tabBarIsInTransition = NO;
    }];
}

- (void)hideTabBarAnimated:(BOOL)animated
{
    if (tabBarIsInTransition || self.tabBar.hidden) {
        return;
    }
    tabBarIsInTransition = YES;
    
    [UIView animateWithDuration:(animated ? kAnimationInterval : 0) animations:^{
        for (UIView *view in self.view.subviews) {
            if ([view isKindOfClass:[UITabBar class]]) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y+kTabBarHeight, view.frame.size.width, view.frame.size.height)];
            }
            else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height+kTabBarHeight)];
            }
        }
    } completion:^(BOOL finished) {
        tabBarIsInTransition = NO;
        self.tabBar.hidden = YES;
    }];
}

@end
