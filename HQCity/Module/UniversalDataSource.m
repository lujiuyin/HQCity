//
//  UniversalDataSource.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/18.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "UniversalDataSource.h"

@interface UniversalDataSource()
@property (nonatomic, strong) id view;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSArray *models;

@property (nonatomic, copy) ConfigureBlock configureBlock;

@end

@implementation UniversalDataSource

+ (instancetype)dataSourceForView:(UIView *)view
                           models:(NSArray *)models
                       identifier:(NSString *)identifier
                   configureBlock:(ConfigureBlock)configureBlock {
    return [[UniversalDataSource alloc] initForView:view models:models identifier:identifier configureBlock:configureBlock];
}

- (instancetype)initForView:(UIView *)view
                           models:(NSArray *)models
                       identifier:(NSString *)identifier
                   configureBlock:(ConfigureBlock)configureBlock {
    self = [super init];
    if (self) {
        self.view = view;
        self.models = models;
        self.identifier = identifier;
        self.configureBlock = configureBlock;
        if ([self.view respondsToSelector:@selector(setDataSource:)])
        {
            [self.view performSelector:@selector(setDataSource:) withObject:self];
        }
    }
    return self;
}

- (void)reloadData:(NSArray *)models reloadComplete:(ReloadComplete)reloadComplete {
    self.models = models;
    reloadComplete?reloadComplete(self.view):nil;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell<UniversalCellDelegate> *cell = [tableView dequeueReusableCellWithIdentifier:self.identifier forIndexPath:indexPath];
    id obj = self.models[indexPath.row];
    self.configureBlock(cell, obj);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    UICollectionViewCell<UniversalCellDelegate> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.identifier forIndexPath:indexPath];
    id obj = self.models[indexPath.row];
    self.configureBlock(cell, obj);
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.view = collectionView;
    return self.models.count;
}

@end
