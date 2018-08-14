//
//  DIYCollectionViewLayout.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/25.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "DIYCollectionViewLayout.h"
#import "UniversalDataSource.h"

#define ScreenW     [UIScreen mainScreen].bounds.size.width
#define ScreenH     [UIScreen mainScreen].bounds.size.height

@interface DIYCollectionViewLayout()
@property (nonatomic, strong) NSArray *models;
@property (nonatomic, strong) NSMutableArray *layoutArray;

@end

@implementation DIYCollectionViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.layoutArray = [NSMutableArray array];
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<items; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        if (attributes) {
            [self.layoutArray addObject:attributes];
        }
    }
}

- (CGSize)collectionViewContentSize {
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    NSArray *hArray = @[@(0),@(ScreenW/2),@(ScreenW/2),@(ScreenW),@(ScreenW),@(ScreenW),@(ScreenW/4*5),@(ScreenW/2*3)];

    CGFloat height = ((int)items / 8) * ScreenW / 2 * 3 + [hArray[items % 8 ] floatValue];
    return CGSizeMake(ScreenW, height);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layoutArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSArray *xArray = @[@(0),@(ScreenW/2),@(0),@(ScreenW/3*2),@(ScreenW/3*2),@(0),@(0),@(ScreenW/3)];
    NSArray *yArray = @[@(0),@(0),@(ScreenW/2),@(ScreenW/2),@(ScreenW/4*3),@(ScreenW),@(ScreenW/4*5),@(ScreenW)];
    NSArray *wArray = @[@(ScreenW/2),@(ScreenW/2),@(ScreenW/3*2),@(ScreenW/3),@(ScreenW/3),@(ScreenW/3),@(ScreenW/3),@(ScreenW/3*2)];
    NSArray *hArray = @[@(ScreenW/2),@(ScreenW/2),@(ScreenW/2),@(ScreenW/4),@(ScreenW/4),@(ScreenW/4),@(ScreenW/4),@(ScreenW/2)];
    NSInteger index = indexPath.item % 8;
    NSInteger round = indexPath.item / 8;
    CGFloat roundHeight = ScreenW / 2 * 3;
    CGFloat x = [[xArray objectAtIndex:index] floatValue];
    CGFloat y = [[yArray objectAtIndex:index] floatValue]+round *roundHeight;
    CGFloat w = [[wArray objectAtIndex:index] floatValue];
    CGFloat h = [[hArray objectAtIndex:index] floatValue];

    attributes.frame = CGRectMake(x, y, w, h);
    return attributes;
}
@end
