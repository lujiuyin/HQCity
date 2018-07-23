//
//  UIViewController+Container.h
//  HQCity
//
//  Created by 陆久银 on 2018/7/18.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Container)

- (void)attachChildViewController:(UIViewController *)childViewController toView:(UIView *)view callAppearanceMethod:(BOOL)callAppearanceMethod;

- (void)detachChildViewController:(UIViewController *)childViewController callAppearanceMethod:(BOOL)callAppearanceMethod;

- (UIViewController *)frontViewController;

- (UIViewController *)childViewControllerWithClass:(Class)specifiedClass;
@end
