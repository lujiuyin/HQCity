//
//  URLCacheViewController.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/27.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "URLCacheViewController.h"
#import "HQRequest.h"

@interface URLCacheViewController ()
@property (nonatomic, strong) HQRequest *request;

@end

@implementation URLCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.request = [[HQRequest alloc] initWithMemoryCapacity:20 * 1024 * 1024 diskCapacity:50 * 1024 * 1024 diskPath:[HQRequest customCachePath]];
    
    [NSURLCache setSharedURLCache:self.request];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"request" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (void)push {
    [HQRequest requestWithSuccess:^(id response) {
        NSLog(@"%@",response);
    } failed:^(NSError *error) {
        
    }];
}

@end
