//
//  WaterfallViewController.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/27.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "WaterfallViewController.h"
#import "DIYCollectionViewLayout.h"
#import "UniversalDataSource.h"
#import "ColorCell.h"

#define ScreenW     [UIScreen mainScreen].bounds.size.width
#define ScreenH     [UIScreen mainScreen].bounds.size.height

@interface WaterfallViewController ()<UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UniversalDataSource *dataSource;

@property (nonatomic, strong) NSMutableArray *sizeData;
@end

@implementation WaterfallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DIYCollectionViewLayout *layout = [[DIYCollectionViewLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ColorCell" bundle:nil] forCellWithReuseIdentifier:@"ColorCell"];
    self.collectionView.delegate = self;
    
    self.dataSource = [UniversalDataSource dataSourceForView:self.collectionView models:nil identifier:@"ColorCell" configureBlock:^(ColorCell<UniversalCellDelegate> *cell, id obj) {
        [cell configure:obj];
    }];
    self.collectionView.dataSource = self.dataSource;
    [self.view addSubview:self.collectionView];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW -100, ScreenH - 44 - 100, 100, 100)];
    [btn setBackgroundColor:[UIColor blueColor]];
    btn.layer.cornerRadius = 50;
    btn.layer.masksToBounds = YES;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(addCell) forControlEvents:UIControlEventTouchUpInside];
    [self addCell];  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addCell {
    NSInteger count = self.sizeData.count;
    for (int i=count; i<count+1000; i++) {
        [self.sizeData addObject:[NSNumber numberWithInt:i]];
    }
    
    [self.dataSource reloadData:self.sizeData reloadComplete:^(UICollectionView *view) {
        [view reloadData];
    }];
}

- (NSMutableArray *)sizeData {
    if (!_sizeData) {
        _sizeData = [NSMutableArray array];
    }
    return _sizeData;
}

@end
