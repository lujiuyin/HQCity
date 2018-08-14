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
@property (nonatomic, strong) NSArray *dataArray;

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


    self.dataArray = @[
                       @{@"GravityViewController":@"重力碰撞"},
                       @{@"URLCacheViewController":@"URLCache"},
                       @{@"WaterfallViewController":@"瀑布流"},
                       @{@"AnimationViewController":@"动画"},
                       ];
    
    [self.dataSource reloadData:self.dataArray reloadComplete:^(UITableView *view) {
        [view reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.dataArray[indexPath.row];
    Class cls = NSClassFromString([dic allKeys].firstObject);
    [self.navigationController pushViewController:[cls new] animated:YES];
    
}

@end
