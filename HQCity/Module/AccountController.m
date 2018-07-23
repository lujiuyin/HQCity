//
//  AccountController.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/17.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "AccountController.h"
#import "GravityView.h"

@interface AccountController ()



@end

@implementation AccountController

- (void)viewDidLoad {
    [super viewDidLoad];

    GravityView *gravityView = [[GravityView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200)];
    [self.view addSubview:gravityView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
