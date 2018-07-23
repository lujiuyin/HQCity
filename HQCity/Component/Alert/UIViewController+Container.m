//
//  UIViewController+Container.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/18.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "UIViewController+Container.h"

@implementation UIViewController (Container)

- (void)attachChildViewController:(UIViewController *)childViewController toView:(UIView *)view callAppearanceMethod:(BOOL)callAppearanceMethod
{
    [self addChildViewController:childViewController];
    childViewController.view.frame = view.bounds;
    childViewController.view.translatesAutoresizingMaskIntoConstraints = YES;
    childViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    callAppearanceMethod ? [childViewController beginAppearanceTransition:YES animated:NO] : nil;
    [view addSubview:childViewController.view];
    callAppearanceMethod ? [childViewController endAppearanceTransition] : nil;
    [childViewController didMoveToParentViewController:self];
}


- (void)detachChildViewController:(UIViewController *)childViewController callAppearanceMethod:(BOOL)callAppearanceMethod
{
    callAppearanceMethod ? [childViewController beginAppearanceTransition:NO animated:NO] : nil;
    [childViewController.view removeFromSuperview];
    callAppearanceMethod ? [childViewController endAppearanceTransition] : nil;
    
    [childViewController willMoveToParentViewController:nil];
    [childViewController removeFromParentViewController];
}

- (UIViewController *)frontViewController
{
    if ([self isKindOfClass:[UINavigationController class]])
    {
        return [((UINavigationController *)self).topViewController frontViewController];
    }
    else if ([self isKindOfClass:[UITabBarController class]])
    {
        return [((UITabBarController *)self).selectedViewController frontViewController];
    }
    else if (self.navigationController && self != self.navigationController.visibleViewController)
    {
        return [self.navigationController.visibleViewController frontViewController];
    }
    else if (self.presentedViewController)
    {
        return [self.presentedViewController frontViewController];
    }
    else
    {
        return self;
    }
}

- (UIViewController *)childViewControllerWithClass:(Class)specifiedClass {
    for (UIViewController *childViewController in self.childViewControllers) {
        if ([childViewController isKindOfClass:specifiedClass]) {
            return childViewController;
        }else if ([childViewController childViewControllerWithClass:specifiedClass]){
            return [childViewController childViewControllerWithClass:specifiedClass];
        }
    }
    return nil;
}
@end
