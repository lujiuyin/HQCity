//
//  UniversalDataSource.h
//  HQCity
//
//  Created by 陆久银 on 2018/7/18.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UniversalCellDelegate.h"

typedef void(^ConfigureBlock)(id<UniversalCellDelegate> cell, id obj);
typedef void(^ReloadComplete)(id view);

@interface UniversalDataSource : NSObject<UITableViewDataSource, UICollectionViewDataSource>

+ (instancetype)dataSourceForView:(UIView *)view
                           models:(NSArray *)models
                       identifier:(NSString *)identifier
                   configureBlock:(ConfigureBlock)configureBlock;


- (void)reloadData:(NSArray *)models
    reloadComplete:(ReloadComplete)reloadComplete;
@end
