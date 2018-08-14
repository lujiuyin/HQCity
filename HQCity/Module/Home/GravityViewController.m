//
//  GravityViewController.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/27.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "GravityViewController.h"
#import "GravityView.h"

@interface GravityViewController ()

@end

@implementation GravityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GravityView *gravityView = [[GravityView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200)];
    [self.view addSubview:gravityView];
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
