//
//  AnimationViewController.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/27.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "AnimationViewController.h"
#import "UniversalDataSource.h"

@interface AnimationViewController ()<UITableViewDelegate>

@property (nonatomic, strong) UniversalDataSource *dataSource;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [tableView registerNib:[UINib nibWithNibName:@"ItemTableViewCell" bundle:nil] forCellReuseIdentifier:@"ItemTableViewCell"];
    
    
    self.dataSource = [UniversalDataSource dataSourceForView:tableView models:nil identifier:@"ItemTableViewCell" configureBlock:^(id<UniversalCellDelegate> cell, id obj) {
        [cell configure:obj];
    }];
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    
    self.dataArray = @[
                       @{@"UIViewAnimationViewController":@"UIView动画"},
                       @{@"SpringAnimationController":@"Spring动画"},
                       @{@"CoreAnimation":@"瀑布流"},
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
