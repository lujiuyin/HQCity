//
//  BaseTabBarController.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/17.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"

#import "HomeController.h"
#import "DiscoveryController.h"
#import "AccountController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSArray *tabBarTitles = @[@"首页",@"发现",@"账号"];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:tabBarTitles.count];
    NSArray *tabBarClasses = @[@"HomeController",@"DiscoveryController",@"AccountController"];
    NSArray *tabBarImages = @[@"ic_tabbar_home",@"ic_tabbar_discover",@"ic_tabbar_profile"];

    [tabBarTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class cls = NSClassFromString(tabBarClasses[idx]);
        BaseViewController *vc = [cls new];
        vc.title = obj;        
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:obj image:[[UIImage imageNamed:tabBarImages[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@_select",tabBarImages[idx]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [viewControllers insertObject:nav atIndex:idx];
    }];
    self.tabBar.tintColor = [UIColor blackColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.viewControllers = viewControllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
