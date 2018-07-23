//
//  HomeController.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/17.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "HomeController.h"
#import "DetailViewController.h"
#import "EmitterView.h"
#import "UniversalDataSource.h"
#import "HQAlertManager.h"

#import "Masonry.h"

@interface HomeController ()<UITableViewDelegate>

@property (nonatomic, strong) UniversalDataSource *dataSource;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [tableView registerNib:[UINib nibWithNibName:@"ItemTableViewCell" bundle:nil] forCellReuseIdentifier:@"ItemTableViewCell"];
    

    self.dataSource = [UniversalDataSource dataSourceForView:tableView models:nil identifier:@"ItemTableViewCell" configureBlock:^(id<UniversalCellDelegate> cell, id obj) {
        [cell configure:obj];
    }];
    tableView.delegate = self;
    [self.view addSubview:tableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)push {
    [self.dataSource reloadData:@[@"1",@"2",@"3",@"4"] reloadComplete:^(UITableView *view) {
        [view reloadData];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[DetailViewController new] animated:YES];
}

@end
